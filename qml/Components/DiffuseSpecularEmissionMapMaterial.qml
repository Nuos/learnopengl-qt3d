/****************************************************************************
**
** Copyright (C) 2014 Klaralvdalens Datakonsult AB (KDAB).
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt3D module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl-3.0.html.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 2.0 or (at your option) the GNU General
** Public license version 3 or any later version approved by the KDE Free
** Qt Foundation. The licenses are as published by the Free Software
** Foundation and appearing in the file LICENSE.GPL2 and LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-2.0.html and
** https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

import Qt3D.Core 2.0
import Qt3D.Render 2.0

import "."

Material {
	id: root

	property color ambient:  Qt.rgba( 0.05, 0.05, 0.05, 1.0 )
	property real shininess: 150.0
	property real textureScale: 1.0

	parameters: [
		Parameter { name: "ka"; value: Qt.vector3d(root.ambient.r, root.ambient.g, root.ambient.b) },
		Parameter {
			name: "diffuseTexture"
			value: Texture2D {
				id: diffuseTexture
				minificationFilter: Texture.LinearMipMapLinear
				magnificationFilter: Texture.Linear
				wrapMode {
					x: WrapMode.Repeat
					y: WrapMode.Repeat
				}
				generateMipMaps: true
				maximumAnisotropy: 16.0
				TextureImage {
					id: diffuseTextureImage
					source: Resources.texture(diffuseName)
				}
			}
		},
		Parameter { name: "specularTexture";
			value: Texture2D {
				id: specularTexture
				minificationFilter: Texture.LinearMipMapLinear
				magnificationFilter: Texture.Linear
				wrapMode {
					x: WrapMode.Repeat
					y: WrapMode.Repeat
				}
				generateMipMaps: true
				maximumAnisotropy: 16.0
				TextureImage {
					id: specularTextureImage
					source: Resources.texture(specularName)
				}
			}
		},
		Parameter { name: "emissionTexture";
			value: Texture2D {
				id: emissionTexture
				minificationFilter: Texture.LinearMipMapLinear
				magnificationFilter: Texture.Linear
				wrapMode {
					x: WrapMode.Repeat
					y: WrapMode.Repeat
				}
				generateMipMaps: true
				maximumAnisotropy: 16.0
				TextureImage {
					id: emissionTextureImage
					source: Resources.texture(emissionName)
				}
			}
		},
		Parameter { name: "shininess"; value: root.shininess },
		Parameter { name: "texCoordScale"; value: textureScale }
	]

	effect: Effect {

		FilterKey {
			id: forward
			name: "renderingStyle"
			value: "forward"
		}

		techniques: // OpenGL ES 2
			Technique {
				renderPasses: RenderPass {
					shaderProgram: ShaderProgram0 {
						vertName: "diffusemap"
						fragName: "diffusespecularemmisionmap"
					}
				}
			}
	}

	property string diffuseName
	property string specularName
	property string emissionName
}
