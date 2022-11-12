Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4413062686C
	for <lists+linux-pci@lfdr.de>; Sat, 12 Nov 2022 10:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiKLJUP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Nov 2022 04:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbiKLJUM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Nov 2022 04:20:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA155DEC8;
        Sat, 12 Nov 2022 01:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1668244777;
        bh=tuqut74UZqWZODN1QpAhPVRlE49i8ImsqmOIOqF0/qo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Lt3QdQ3tyYgD9SudXw0ZjqHbx9PKGycyoiiLILga9dNvnWpy6W9wV7+eJs5q3D1IH
         eirSZCw50+2O1NCqyMNJuFybHxznr56S1eAKQMqJcGSpsJ5TrF/ZHSa5e+09XeVs2g
         JC20Loz1sQayusdOdTgtoFj29+BRLVoakEjrkVhQOa4/2fkXW5D7qQCFosESPUiUnJ
         50oOyFzPaQIxW/LOMdHp3evxWWilqkT7pfeZd36dWZS2/PuzCs09pFlDboazIFhrT1
         narnI4/mqQe8KN65NoHZ/btyZMamA0wzpOTAfiwHhPDMYjGlW4zYxPR4swGZYOYeB1
         yUuIFFuGxyykA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from frank-G5 ([157.180.227.41]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKm0-1odnKE3Y7u-00OrcK; Sat, 12
 Nov 2022 10:19:36 +0100
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
Subject: [PATCH v4 11/11] arm64: dts: mt7986: add BPI-R3 nand/nor overlays
Date:   Sat, 12 Nov 2022 10:19:23 +0100
Message-Id: <20221112091923.9562-2-frank-w@public-files.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221112091923.9562-1-frank-w@public-files.de>
References: <20221112091923.9562-1-frank-w@public-files.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kKjaW9aI7wAg0CdKWw9t+9h2N0yWI8C1ic20qYJbFdx1SXsJukP
 uPR44ZUAe6EWerEtW0dXW5xmg1XUkpe6B1L5fA2n02283EId0pWWnwzL23CEwzx4ps2gFt0
 P0J7XfxpftQfZVSUxyCieVNqNLgs8raCEFVFYV6YR41GDvWOuvQR7FQWC+CIONmjUZ7ONXK
 KsLi4v3N1mpziL3jyXgng==
UI-OutboundReport: notjunk:1;M01:P0:ard/iJETmyI=;KPC3jaRpk4xcD3byMkdfvKRcTIv
 xWie5/oLRUaj8Zjk7ca2wpGRmzITD+Q6pBjXB99CTvr+enrJ50vZyLltQ9tK2ViNBYQDgCsYY
 6vlhtB3ZYemsLwazxPp8HxkT3EMbUO40BKZqGjvIkdLMkpZevM6KT9vIyPIw5wo2Aw9I2TgpJ
 aL7DBl/t9UQxqRYcm8vdhX3g5OPiEKZBYW270MjM5YLzfe9pSJFgNhvCj3zwPWC9r8N4QP0sc
 IMY3HKsx5+AAz9ZGo70INMz6glEQEJjKHrBd/zPz6xAEGdlaY3LvELPz15B916ELH3+GL3Y5C
 db0RdLWG9ALfAVjsjD+RTvPqjqjB7LGZOym6xetErXbuks2758is0UYmWBpgg5b2MyvLGby9p
 HDoPrPHAksy1j5XnGaKxKTFw99HXP2SK87Am3HzFUSlYUtwJhVDuruHDAG0nmMqGa03MMPPwj
 B5Uz5k6f+/Xklbgj9pWSjbpvWeSNs7z6ly37bdm2SQnjnY6CnT0fcpRoqKD5U8BWuesF1OHHr
 5rq0KjUC23Js8qTxRo1vjrgowNto1QDh5jAH6b7qGatYUGqcvpUTCTIuVUVZOffv29DORqQj3
 iqd6FQl9Jhi/KFc/dV/Jhe0eiuudpj//a0nHeEe3c42hSzqdFd8cVSN4iP26raGjGm1m4zRDj
 NmWCZ2iEvKbaZwUwwGQgaDYjb1Qj166ogyhECwwRzacP+EWel4BkiBcCHidKYTyfYRh9l9nvH
 1jTPJmBaVJSHYg3P9xYV4EpdY5uHtMO9NMzL2QmQu7IpEbzIIHehxJREdVsxJcmJ0P3U1/6AD
 dmP82ZZsnV7BZ5Uro0LGSNDc4JsSIlmwG465Suo2Z+jijq+KUm4gQ3JWuDHVZbHbRAeQQnyqQ
 Oq3Uw3SkfnQqEC2HFApmltc7K3pveVYdo6tf3LkUlfQmGVtNRGu3v04DMfChbmqV2/vL0v3Me
 bgXFl0P6TlFQwPqvqeZIwm9zGx0=
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

