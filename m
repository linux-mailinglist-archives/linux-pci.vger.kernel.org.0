Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8132162E20A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 17:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbiKQQfs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 11:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240706AbiKQQfL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 11:35:11 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D697B21E17;
        Thu, 17 Nov 2022 08:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1668702825;
        bh=685HAFrCQ1H/XhJLiR5NAOp9W9THBYFHsQy1Qc41aVo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=OyDvoHxHU1L95Wa0KYOonqnvFfKZivlRzj1X8/opR4cRCXR7U/1PflHFkG5OFHWkr
         FglAHvOZanlbUtxAJZO1nlWdDVL+DVCJN9OvlyHqO6euqzCqxEvEwNr8DiXbadiayd
         bMAgt4ucMDNBteOoZ3g7b++IiiMdqAa8aG5ywKnm3B1SjKystmiYLOMmoF68tiEn4K
         C3W87tKYViz16d6oxhKZC7OFTHQLth/HPnjjJ3+5/tYJBIqKRO/PS6VpXqLpjJwQRx
         4YYJGhAkkXJH92Ojy5puFhJypGffqac+qtlG9rKaUCYYHFL6dBDnoLUV56/kk/akpq
         j/hywstOfH2yw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from frank-G5 ([80.245.75.65]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72oH-1os9zy3DOp-008ZPP; Thu, 17
 Nov 2022 17:33:45 +0100
From:   Frank Wunderlich <frank-w@public-files.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH v5 11/11] arm64: dts: mt7986: add BPI-R3 nand/nor overlays
Date:   Thu, 17 Nov 2022 17:33:40 +0100
Message-Id: <20221117163340.21069-1-frank-w@public-files.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0zZwEQSc2GM6vXeRI+bIlFokQn6BiimSebefS/q5FvkdTAUriwf
 EZUjeBe8VS0cpVmGPqbd7om/VGkKaOWVsRrAJSGrnj1FDk6vmzKPrv0xmj2m5gt/edGraoT
 Vgu0D1yDgAp20KGj2l0bp8pDIMk0tjM/6LLtxxl27rhPFN5/AqjbH+BT0MuyeuD0v+Pip58
 a9Mm8BcTnAzuHu5oKBo3g==
UI-OutboundReport: notjunk:1;M01:P0:3IeX2Ck7v2c=;ogtxe/hQAW/5OgpgaE149rA6Ojd
 yE4FnS9/79cwkcr38IDTkRvVzQNBd67qQ2svqNS8HsKRYqahDnwWzuLGm+EYsK/mDXbWyHQJP
 39Su45nSSX2oPr1U88osomWn53OuukBeDR/x8p+hTTD57jMxehypkYbZP2e8CumRoedlGaMDZ
 BGDIk28EXLRi2megpflU9obww7Az+/DAgdAja4F7Ys09fjF8eKJsATrnfwM6vxX/kz1mKMANr
 p6DeQvZuSqI4vJrqEuFT+4/CzSVjfgkeWfFJKZbPE8PcMl0T9I8Ml/sBJCegR7lZI+gtgSfLY
 EyiGg7cnF7qJwt/4O0ksBvqhw61BUOcgRCcp1b1s3pXYi/feY+GOb6AWE0JpCW8jhl/sjItJ2
 VthgWcSQ8RZmf0LtsleiJscjzEULGa7uK0sJ8V8R+WkZyR5HKPKe+EG4bh9b/pPPEjt1N/mFy
 TEp03WR1Y8Rp9318QkflSdaoa2xrsFx5YzAPtAKQnZ7puLMD+VjTy4IhqZvW3bnmE8sxGEiqB
 uFZcBlDGW42hS3nXOPQffhp1/Odj8EZp+casHkhU326tz2VEo5Y5oj9m6nTmMCgDaYJQvq7w1
 oJ7s5F5gbvJxwbH7B8fVtMRfk5oFFJImxCLKxZ4yacmqUvcKYGxI3d+cEeTE1y+itwsPw+Gg+
 A6Q2Kb7YX429xjC9mkt1TOgwvBZFvSmkJ/CQiC2hlIwP0/SgQ5TuMIKOYTz3+K6W6OAnhkmu3
 LoedwBpEBL0CSITG0+De7YKf7nL9fykn+HVkvrNU2Vuar9Pt+Whxi+Yjm6C8IuyXVJv5AZINd
 kiOeByn/cTiF1EtI1mKh+CiM6Ylh2TYa5PRzT+6mmkgeHeV8TtmTOxYcvfKTKxNhC7EaT4uj8
 GpyIUjbkPCZFi+QF5oCJd01dH1901zSHMYOzu0WOX0XdLONsCucyLiyXyrQc5Qy04X+TsMp9e
 1VsjKQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add devicetree overlays for using nand and nor on BPI-R3.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
maybe rename to dtso?

"kbuild: Allow DTB overlays to built from .dtso named source files"
https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?h=
=3Ddt/next&id=3D363547d2191cbc32ca954ba75d72908712398ff2

more comments about the dt overlay-support:

https://patchwork.kernel.org/comment/25092116/
https://patchwork.kernel.org/comment/25085681/
=2D--
v4:
- drop compile-comment from overlays
- add author-information to dt-overlays
=2D--
 arch/arm64/boot/dts/mediatek/Makefile         |  2 +
 .../mediatek/mt7986a-bananapi-bpi-r3-nand.dts | 55 +++++++++++++++
 .../mediatek/mt7986a-bananapi-bpi-r3-nor.dts  | 69 +++++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-n=
and.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-n=
or.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/m=
ediatek/Makefile
index e8902f2cc58f..d42208c4090d 100644
=2D-- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -8,6 +8,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6797-x20-dev.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7622-rfb1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7622-bananapi-bpi-r64.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-emmc.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-nand.dtbo
+dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-nor.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sd.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-rfb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986b-rfb.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dts=
 b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dts
new file mode 100644
index 000000000000..15ee8c568f3c
=2D-- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dts
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Authors: Daniel Golle <daniel@makrotopia.org>
+ *          Frank Wunderlich <frank-w@public-files.de>
+ */
+
+/dts-v1/;
+/plugin/;
+
+/ {
+	compatible =3D "bananapi,bpi-r3", "mediatek,mt7986a";
+
+	fragment@0 {
+		target-path =3D "/soc/spi@1100a000";
+		__overlay__ {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			spi_nand: spi_nand@0 {
+				compatible =3D "spi-nand";
+				reg =3D <0>;
+				spi-max-frequency =3D <10000000>;
+				spi-tx-buswidth =3D <4>;
+				spi-rx-buswidth =3D <4>;
+
+				partitions {
+					compatible =3D "fixed-partitions";
+					#address-cells =3D <1>;
+					#size-cells =3D <1>;
+
+					partition@0 {
+						label =3D "bl2";
+						reg =3D <0x0 0x80000>;
+						read-only;
+					};
+
+					partition@80000 {
+						label =3D "reserved";
+						reg =3D <0x80000 0x300000>;
+					};
+
+					partition@380000 {
+						label =3D "fip";
+						reg =3D <0x380000 0x200000>;
+						read-only;
+					};
+
+					partition@580000 {
+						label =3D "ubi";
+						reg =3D <0x580000 0x7a80000>;
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dts =
b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dts
new file mode 100644
index 000000000000..f18643a9089c
=2D-- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dts
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Authors: Daniel Golle <daniel@makrotopia.org>
+ *          Frank Wunderlich <frank-w@public-files.de>
+ */
+
+/dts-v1/;
+/plugin/;
+
+/ {
+	compatible =3D "bananapi,bpi-r3", "mediatek,mt7986a";
+
+	fragment@0 {
+		target-path =3D "/soc/spi@1100a000";
+		__overlay__ {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			flash@0 {
+				compatible =3D "jedec,spi-nor";
+				reg =3D <0>;
+				spi-max-frequency =3D <10000000>;
+
+				partitions {
+					compatible =3D "fixed-partitions";
+					#address-cells =3D <1>;
+					#size-cells =3D <1>;
+
+					partition@0 {
+						label =3D "bl2";
+						reg =3D <0x0 0x20000>;
+						read-only;
+					};
+
+					partition@20000 {
+						label =3D "reserved";
+						reg =3D <0x20000 0x20000>;
+					};
+
+					partition@40000 {
+						label =3D "u-boot-env";
+						reg =3D <0x40000 0x40000>;
+					};
+
+					partition@80000 {
+						label =3D "reserved2";
+						reg =3D <0x80000 0x80000>;
+					};
+
+					partition@100000 {
+						label =3D "fip";
+						reg =3D <0x100000 0x80000>;
+						read-only;
+					};
+
+					partition@180000 {
+						label =3D "recovery";
+						reg =3D <0x180000 0xa80000>;
+					};
+
+					partition@c00000 {
+						label =3D "fit";
+						reg =3D <0xc00000 0x1400000>;
+						compatible =3D "denx,fit";
+					};
+				};
+			};
+		};
+	};
+};
=2D-
2.34.1

