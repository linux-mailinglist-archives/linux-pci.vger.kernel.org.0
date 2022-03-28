Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4CC4E8C02
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 04:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbiC1CUW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Mar 2022 22:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiC1CUV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Mar 2022 22:20:21 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466FE4EF44
        for <linux-pci@vger.kernel.org>; Sun, 27 Mar 2022 19:18:40 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220328021838epoutp046541b3d8bb8dfb8b12e4c09186b43967~gaepHtfZt0582105821epoutp04h
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2022 02:18:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220328021838epoutp046541b3d8bb8dfb8b12e4c09186b43967~gaepHtfZt0582105821epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648433918;
        bh=xkvRR8ZTpUYMTLdK6AUQbXiNIcJesbUz/VQjRjVQ0Go=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=tMKcu8OfJNHBXMnhjswNPbWf6U08/l4XXfxw3uQSjYBHMmu6Sz20sJp6u4ZNfR07A
         9qXbY2XAwQoUwJmxe38CX7Vcr8VQQFOY/+pMctxJyUjFzii4cd4oLWpZLdpnwtwRIM
         RxyMEmrVkiMxQCK4x3JILm1Y+hZtd0JhfQJG/26M=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220328021837epcas2p4b3e93579bf3250141726ae8abde09782~gaeoSh7c90046100461epcas2p4V;
        Mon, 28 Mar 2022 02:18:37 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.68]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KRbwB3chyz4x9QC; Mon, 28 Mar
        2022 02:18:34 +0000 (GMT)
X-AuditID: b6c32a47-831ff700000063c4-d3-62411af86864
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.2B.25540.8FA11426; Mon, 28 Mar 2022 11:18:32 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 4/5] phy: Add ARTPEC-8 PCIe PHY driver
Reply-To: wangseok.lee@samsung.com
Sender: =?UTF-8?B?7J207JmV7ISd?= <wangseok.lee@samsung.com>
From:   =?UTF-8?B?7J207JmV7ISd?= <wangseok.lee@samsung.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        =?UTF-8?B?7KCE66y46riw?= <moonki.jun@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220328021832epcms2p6b6294b824c64404c437d0fd7f09369a4@epcms2p6>
Date:   Mon, 28 Mar 2022 11:18:32 +0900
X-CMS-MailID: 20220328021832epcms2p6b6294b824c64404c437d0fd7f09369a4
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGJsWRmVeSWpSXmKPExsWy7bCmme4PKcckg9uPlS2WNGVYvDykaTH/
        yDlWi+eHZjFbfGpRtbjwtIfN4uWse2wWDT2/WS2OvPnIbLH/+Eomi8u75rBZnJ13nM1iwqpv
        LBZvfr9gtzi3ONOide8Rdoudd04wOwh6rJm3htHj+roAjwWbSj02repk83hyZTqTx+Yl9R59
        W1Yxehy/sZ3J4/MmuQDOqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTc
        VFslF58AXbfMHKAvlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV5
        6Xp5qSVWhgYGRqZAhQnZGW9enGAvmPqYsaJ/z03mBsb/+xi7GDk5JARMJJ6eaGPuYuTiEBLY
        wShx8foi9i5GDg5eAUGJvzuEQWqEBcwkppx5ywJiCwkoSexYM48ZIm4t8WnKZbA4m4ClxMXW
        h4wgc0QEzjJJ3Ly7nRXEYRa4zSwx//l7FohtvBIz2p9C2dIS25dvhbpCQ+LHsl5mCFtU4ubq
        t+ww9vtj86FqRCRa752FqhGUePBzN1RcSmLBk0OsEHa1xP6/v5kg7AZGif77qSDPSAjoS+y4
        bgwS5hXwlVi/7xzYGBYBVYn1rfehVrlIrP/6EyzOLCAvsf3tHGaQVmYBTYn1u/QhpihLHLkF
        90jDxt/s6GxmAT6JjsN/4eI75j2BOkZNYt7KncwQY2Qktr70n8CoNAsRzrOQrJ2FsHYBI/Mq
        RrHUguLc9NRiowJjeOQm5+duYgQnaC33HYwz3n7QO8TIxMF4iFGCg1lJhFf2rH2SEG9KYmVV
        alF+fFFpTmrxIUZToIcnMkuJJucDc0ReSbyhiaWBiZmZobmRqYG5kjivV8qGRCGB9MSS1OzU
        1ILUIpg+Jg5OqQYm4ZqfJ79/OapzLUr6/Ru3Q7+KfX8eaDJWPLY09bYXw22p70dXaJ7nWj2R
        OVGP0S9Sct9zX9bpOYLxO8+KHFYJZ3zxbfYvnr95M/61eJSc975ner32uDTfJG77vU531fj7
        DvxuVc9uLEv7tm7q8+Ybr/z1L68PLsjqXjn3usxZLcs1vVt1v0x701SSYnFU9HbIoyjNbR56
        RSu6V0+Yxp1XLh6m82WFzd8c6blnjVvv2lfGxp3X/nCoOVUxS3Jb0ceff1vYuSe6WBVV39qx
        6u6Uy9wLarwXTcstCLm6a7G3xUqDPdtyGJW7bU+1G7s8ly2auDtuUrpqy/UQya8fdl47OHnv
        W7fwtj/+Px8IcAatVGIpzkg01GIuKk4EANOMG/hZBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220328021832epcms2p6b6294b824c64404c437d0fd7f09369a4
References: <CGME20220328021832epcms2p6b6294b824c64404c437d0fd7f09369a4@epcms2p6>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support Axis, ARTPEC-8 SoC.
ARTPEC-8 is the SoC platform of Axis Communications.
This is based on arm64 and support GEN4 & 2lane.
This driver provides PHY interface for ARTPEC-8 SoC PCIe controller,
based on Samsung PCIe PHY IP.

Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
---
 drivers/phy/Kconfig                   |   1 +
 drivers/phy/Makefile                  |   1 +
 drivers/phy/artpec/Kconfig            |   9 +
 drivers/phy/artpec/Makefile           |   2 +
 drivers/phy/artpec/phy-artpec8-pcie.c | 879 ++++++++++++++++++++++++++++++++++
 5 files changed, 892 insertions(+)
 create mode 100644 drivers/phy/artpec/Kconfig
 create mode 100644 drivers/phy/artpec/Makefile
 create mode 100644 drivers/phy/artpec/phy-artpec8-pcie.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 82b63e6..9fa4283 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -72,6 +72,7 @@ config PHY_CAN_TRANSCEIVER
 
 source "drivers/phy/allwinner/Kconfig"
 source "drivers/phy/amlogic/Kconfig"
+source "drivers/phy/artpec/Kconfig"
 source "drivers/phy/broadcom/Kconfig"
 source "drivers/phy/cadence/Kconfig"
 source "drivers/phy/freescale/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 01e9eff..d748e29 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_PHY_LPC18XX_USB_OTG)	+= phy-lpc18xx-usb-otg.o
 obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
 obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
 obj-$(CONFIG_USB_LGM_PHY)		+= phy-lgm-usb.o
 obj-y					+= allwinner/	\
 					   amlogic/	\
+					   artpec/		\
 					   broadcom/	\
diff --git a/drivers/phy/artpec/Kconfig b/drivers/phy/artpec/Kconfig
new file mode 100644
index 0000000..23ae7cd
--- /dev/null
+++ b/drivers/phy/artpec/Kconfig
@@ -0,0 +1,9 @@
+config PHY_ARTPEC8_PCIE
+	bool "ARTPEC-8 PCIe PHY driver"
+	depends on OF &&  (ARCH_ARTPEC || COMPILE_TEST)
+	select GENERIC_PHY
+	help
+	  Enable PCIe PHY support for ARTPEC-8 SoC.
+	  This driver provides PHY interface for ARTPEC-8 SoC
+	  PCIe controller.
+	  This is based on Samsung PCIe PHY IP.
diff --git a/drivers/phy/artpec/Makefile b/drivers/phy/artpec/Makefile
new file mode 100644
index 0000000..45d853c
--- /dev/null
+++ b/drivers/phy/artpec/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PHY_ARTPEC8_PCIE)		+= phy-artpec8-pcie.o
diff --git a/drivers/phy/artpec/phy-artpec8-pcie.c b/drivers/phy/artpec/phy-artpec8-pcie.c
new file mode 100644
index 0000000..febbd04
--- /dev/null
+++ b/drivers/phy/artpec/phy-artpec8-pcie.c
@@ -0,0 +1,879 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PHY provider for ARTPEC-8 PCIe controller
+ *
+ * Copyright (C) 2019 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Author: Jaeho Cho <jaeho79.cho@samsung.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/phy/phy.h>
+#include <linux/regmap.h>
+#include <linux/debugfs.h>
+
+/* ARTPEC-8 PCIe PHY registers */
+/* CMN registers */
+#define PCIE_PHY_CMN_REG004		0x10
+#define PCIE_PHY_CMN_REG00B		0x2C
+#define PCIE_PHY_CMN_REG016		0x58
+#define PCIE_PHY_CMN_REG01C		0x70
+#define PCIE_PHY_CMN_REG021		0x84
+#define PCIE_PHY_CMN_REG024		0x90
+#define PCIE_PHY_CMN_REG025		0x94
+#define PCIE_PHY_CMN_REG0E6		0x398
+#define PCIE_PHY_CMN_REG0E7		0x39C
+#define PCIE_PHY_CMN_REG0E8		0x3A0
+#define PCIE_PHY_CMN_REG0E9		0x3A4
+#define PCIE_PHY_CMN_REG0EA		0x3A8
+#define PCIE_PHY_CMN_REG0EB		0x3AC
+#define PCIE_PHY_CMN_REG0EC		0x3B0
+#define PCIE_PHY_CMN_REG0EE		0x3B8
+#define PCIE_PHY_CMN_REG0EF		0x3BC
+#define PCIE_PHY_CMN_REG0F1		0x3C4
+#define PCIE_PHY_CMN_REG0F3		0x3CC
+#define PCIE_PHY_CMN_REG0F4		0x3D0
+
+#define PCIE_PHY_CMN_REG101		0x404
+#define OV_I_CMN_RSTN			BIT(4)
+#define OV_I_INIT_RSTN			BIT(6)
+
+#define PCIE_PHY_CMN_REG131		0x4C4
+#define PCIE_PHY_CMN_REG17B		0x5EC
+#define PCIE_PHY_CMN_REG17D		0x5F4
+#define PCIE_PHY_CMN_REG190		0x640
+#define PCIE_PHY_CMN_REG191		0x644
+#define PCIE_PHY_CMN_REG192		0x648
+#define PCIE_PHY_CMN_REG1C7		0x71C
+#define PCIE_PHY_CMN_REG1DF		0x77C
+#define PCIE_PHY_CMN_REG1E0		0x780
+
+#define PCIE_PHY_CMN_REG0B1		0x2C4
+#define ANA_ROPLL_REF_DIG_CLK_SEL	BIT(2)
+
+/* External clock */
+#define PCIE_PHY_CMN_REG14D		0x534
+#define PCIE_AUX_RX_MODE_EXTEND		BIT(7)
+
+#define PCIE_PHY_CMN_REG0D9		0x364
+#define ANA_AUX_EXT_REF_CLK_SEL		BIT(4)
+
+#define PCIE_PHY_CMN_REG10F		0x43C
+#define AUX_PLL_EN_EXTEND		BIT(4)
+
+#define PCIE_PHY_CMN_REG11E		0x478
+#define AUX2_PLL_EN_EXTEND		BIT(3)
+
+#define PCIE_PHY_CMN_REG0D4		0x350
+#define OV_S_ANA_AUX_EN			BIT(3)
+#define OV_I_ANA_AUX_EN			BIT(2)
+
+/* LANE registers */
+#define PCIE_PHY_TRSV_REG22D		0x8B4
+#define PCIE_PHY_TRSV_REG23E		0x8F8
+#define PCIE_PHY_TRSV_REG2A5		0xA94
+#define PCIE_PHY_TRSV_REG3E3		0xF8C
+#define PCIE_PHY_TRSV_REG3ED		0xFB4
+#define PCIE_PHY_TRSV_REG20B		0x82C
+#define PCIE_PHY_TRSV_REG20C		0x830
+#define PCIE_PHY_TRSV_REG234		0x8D0
+#define PCIE_PHY_TRSV_REG235		0x8D4
+#define PCIE_PHY_TRSV_REG237		0x8DC
+#define PCIE_PHY_TRSV_REG239		0x8E4
+#define PCIE_PHY_TRSV_REG23A		0x8E8
+#define PCIE_PHY_TRSV_REG23B		0x8EC
+#define PCIE_PHY_TRSV_REG24B		0x92C
+#define PCIE_PHY_TRSV_REG25D		0x974
+#define PCIE_PHY_TRSV_REG262		0x988
+#define PCIE_PHY_TRSV_REG271		0x9C4
+#define PCIE_PHY_TRSV_REG272		0x9C8
+#define PCIE_PHY_TRSV_REG27C		0x9F0
+#define PCIE_PHY_TRSV_REG27D		0x9F4
+#define PCIE_PHY_TRSV_REG27E		0x9F8
+#define PCIE_PHY_TRSV_REG284		0xA10
+#define PCIE_PHY_TRSV_REG289		0xA24
+#define PCIE_PHY_TRSV_REG28A		0xA28
+#define PCIE_PHY_TRSV_REG28B		0xA2C
+#define PCIE_PHY_TRSV_REG28C		0xA30
+#define PCIE_PHY_TRSV_REG28E		0xA38
+#define PCIE_PHY_TRSV_REG28F		0xA3C
+#define PCIE_PHY_TRSV_REG290		0xA40
+#define PCIE_PHY_TRSV_REG291		0xA44
+#define PCIE_PHY_TRSV_REG292		0xA48
+#define PCIE_PHY_TRSV_REG294		0xA50
+#define PCIE_PHY_TRSV_REG295		0xA54
+#define PCIE_PHY_TRSV_REG296		0xA58
+#define PCIE_PHY_TRSV_REG297		0xA5C
+#define PCIE_PHY_TRSV_REG298		0xA60
+#define PCIE_PHY_TRSV_REG29B		0xA6C
+#define PCIE_PHY_TRSV_REG29C		0xA70
+#define PCIE_PHY_TRSV_REG29D		0xA74
+#define PCIE_PHY_TRSV_REG29E		0xA78
+#define PCIE_PHY_TRSV_REG2AA		0xAA8
+#define PCIE_PHY_TRSV_REG2AE		0xAB8
+#define PCIE_PHY_TRSV_REG2C2		0xB08
+#define PCIE_PHY_TRSV_REG2C6		0xB18
+#define PCIE_PHY_TRSV_REG2C7		0xB1C
+#define PCIE_PHY_TRSV_REG2CB		0xB2C
+#define PCIE_PHY_TRSV_REG2CC		0xB30
+#define PCIE_PHY_TRSV_REG2CD		0xB34
+#define PCIE_PHY_TRSV_REG2CE		0xB38
+#define PCIE_PHY_TRSV_REG2D0		0xB40
+#define PCIE_PHY_TRSV_REG2CF		0xB3C
+#define PCIE_PHY_TRSV_REG2E0		0xB80
+#define PCIE_PHY_TRSV_REG2E9		0xBA4
+#define PCIE_PHY_TRSV_REG2EA		0xBA8
+#define PCIE_PHY_TRSV_REG2EB		0xBAC
+#define PCIE_PHY_TRSV_REG315		0xC54
+#define PCIE_PHY_TRSV_REG317		0xC5C
+#define PCIE_PHY_TRSV_REG319		0xC64
+#define PCIE_PHY_TRSV_REG364		0xD90
+#define PCIE_PHY_TRSV_REG36C		0xDB0
+#define PCIE_PHY_TRSV_REG36D		0xDB4
+#define PCIE_PHY_TRSV_REG37E		0xDF8
+#define PCIE_PHY_TRSV_REG37F		0xDFC
+#define PCIE_PHY_TRSV_REG38F		0xE3C
+#define PCIE_PHY_TRSV_REG391		0xE44
+#define PCIE_PHY_TRSV_REG39C		0xE70
+#define PCIE_PHY_TRSV_REG3A8		0xEA0
+#define PCIE_PHY_TRSV_REG3E0		0xF80
+#define PCIE_PHY_TRSV_REG3E1		0xF84
+#define PCIE_PHY_TRSV_REG3E7		0xF9C
+#define PCIE_PHY_TRSV_REG3E9		0xFA4
+#define PCIE_PHY_TRSV_REG3EA		0xFA8
+#define PCIE_PHY_TRSV_REG3EE		0xFB8
+#define PCIE_PHY_TRSV_REG3EF		0xFBC
+#define PCIE_PHY_TRSV_REG3F0		0xFC0
+
+#define PCIE_PHY_TRSV_REG2C0		0xB00
+#define LN_EQ_CTRL_RX_DATA_HOLD		BIT(5)
+
+/* RX Preset registers */
+#define PCIE_PHY_CMN_REG17E		0x5F8
+#define PCIE_PHY_CMN_REG180		0x600
+#define PCIE_PHY_CMN_REG181		0x604
+#define PCIE_PHY_CMN_REG182		0x608
+#define PCIE_PHY_CMN_REG183		0x60C
+#define PCIE_PHY_CMN_REG184		0x610
+#define PCIE_PHY_CMN_REG185		0x614
+#define PCIE_PHY_CMN_REG186		0x618
+#define PCIE_PHY_CMN_REG187		0x61C
+
+
+/* ARTPEC-8 PCIe PCS registers */
+#define PCIE_PCS_OUT_VEC_4		0x154
+#define B1_DYNAMIC			BIT(3)
+
+/* ARTPEC-8 SYS REG registers */
+#define FSYS_PCIE_CON			0x424
+#define PCIE_PHY_LCPLL_REFCLK_SEL	0x3
+#define PCIE_PHY_ROPLL_REFCLK_SEL	(0x3UL << 2)
+#define ROPLL_REFCLK_NOT_AVAILABLE	(0x2UL << 2)
+#define PCIE_PHY_LN0_REFCLK_PAD_EN	BIT(10)
+#define PCIE_PHY_LN1_REFCLK_PAD_EN	BIT(11)
+#define PCIE_PHY_PWR_OFF		BIT(7)
+
+/* ARTPEC-8 Sub Controller registers */
+#define SFR_INIT_RSTN			0x1404
+#define SFR_CMN_RSTN			0x1408
+
+#define PCIE_PHY_LN0_REG_START		0x800
+#define PCIE_PHY_LN0_REG_END		0xFCC
+#define OFFSET_PER_LANE			0x800
+
+enum artpec8_pcie_phy_num_lanes {
+	LANE0 = 0,
+	LANE1,
+	LANE_MAX
+};
+
+struct artpec8_pcie_phy_data {
+	const struct phy_ops	*ops;
+};
+
+struct artpec8_pcie_phy {
+	const struct artpec8_pcie_phy_data *drv_data;
+	void __iomem *phy_base;
+	void __iomem *pcs_base;
+	void __iomem *elbi_base;
+	struct clk *soc_pll_clk;
+	struct regmap *sysreg;
+	u32 lcpll_ref_clk;
+	const char *mode;
+	u32 num_lanes;
+};
+
+enum artpec8_pcie_ref_clk {
+	REF_CLK_FROM_XO = 0,
+	REF_CLK_FROM_IO,
+	REF_CLK_RESERVED,
+	REF_CLK_FROM_SOC_PLL,
+	REF_CLK_MAX
+};
+
+struct artpec8_pcie_phy_tune_reg {
+	u32 offset;
+	u32 val;
+};
+
+/* ARTPEC-8 PCIe Gen4 x2 PHY CMN register settings */
+struct artpec8_pcie_phy_tune_reg cmn_regs[] = {
+	{PCIE_PHY_CMN_REG004, 0x65},
+	{PCIE_PHY_CMN_REG00B, 0x18},
+	{PCIE_PHY_CMN_REG016, 0x0E},
+	{PCIE_PHY_CMN_REG01C, 0x4F},
+	{PCIE_PHY_CMN_REG021, 0x01},
+	{PCIE_PHY_CMN_REG024, 0x58},
+	{PCIE_PHY_CMN_REG025, 0x98},
+	{PCIE_PHY_CMN_REG0E6, 0x00},
+	{PCIE_PHY_CMN_REG0E7, 0x00},
+	{PCIE_PHY_CMN_REG0E8, 0x3F},
+	{PCIE_PHY_CMN_REG0E9, 0x3F},
+	{PCIE_PHY_CMN_REG0EA, 0xFF},
+	{PCIE_PHY_CMN_REG0EB, 0xFF},
+	{PCIE_PHY_CMN_REG0EC, 0x42},
+	{PCIE_PHY_CMN_REG0EE, 0x3F},
+	{PCIE_PHY_CMN_REG0EF, 0x7F},
+	{PCIE_PHY_CMN_REG0F1, 0x02},
+	{PCIE_PHY_CMN_REG0F3, 0xFF},
+	{PCIE_PHY_CMN_REG0F4, 0xFF},
+	{PCIE_PHY_CMN_REG131, 0x01},
+	{PCIE_PHY_CMN_REG17B, 0xC0},
+	{PCIE_PHY_CMN_REG17D, 0xAF},
+	{PCIE_PHY_CMN_REG190, 0x27},
+	{PCIE_PHY_CMN_REG191, 0x0F},
+	{PCIE_PHY_CMN_REG192, 0x3F},
+	{PCIE_PHY_CMN_REG1C7, 0x05},
+	{PCIE_PHY_CMN_REG1DF, 0x28},
+	{PCIE_PHY_CMN_REG1E0, 0x28},
+};
+
+/* ARTPEC-8 PCIe Gen4 x2 PHY lane register settings */
+struct artpec8_pcie_phy_tune_reg lane_regs[] = {
+	{PCIE_PHY_TRSV_REG22D, 0x00},
+	{PCIE_PHY_TRSV_REG23E, 0x00},
+	{PCIE_PHY_TRSV_REG2A5, 0x73},
+	{PCIE_PHY_TRSV_REG3E3, 0x7B},
+	{PCIE_PHY_TRSV_REG3ED, 0x4B},
+	{PCIE_PHY_TRSV_REG20B, 0x02},
+	{PCIE_PHY_TRSV_REG20C, 0xEA},
+	{PCIE_PHY_TRSV_REG234, 0x7A},
+	{PCIE_PHY_TRSV_REG235, 0x1C},
+	{PCIE_PHY_TRSV_REG237, 0x10},
+	{PCIE_PHY_TRSV_REG239, 0x68},
+	{PCIE_PHY_TRSV_REG23A, 0xC0},
+	{PCIE_PHY_TRSV_REG23B, 0x0B},
+	{PCIE_PHY_TRSV_REG24B, 0x00},
+	{PCIE_PHY_TRSV_REG25D, 0x07},
+	{PCIE_PHY_TRSV_REG262, 0x07},
+	{PCIE_PHY_TRSV_REG271, 0x23},
+	{PCIE_PHY_TRSV_REG272, 0x5E},
+	{PCIE_PHY_TRSV_REG27C, 0x8C},
+	{PCIE_PHY_TRSV_REG27D, 0x5B},
+	{PCIE_PHY_TRSV_REG27E, 0x2C},
+	{PCIE_PHY_TRSV_REG284, 0x33},
+	{PCIE_PHY_TRSV_REG289, 0xD4},
+	{PCIE_PHY_TRSV_REG28A, 0xCC},
+	{PCIE_PHY_TRSV_REG28B, 0xD9},
+	{PCIE_PHY_TRSV_REG28C, 0xDC},
+	{PCIE_PHY_TRSV_REG28E, 0xC6},
+	{PCIE_PHY_TRSV_REG28F, 0x90},
+	{PCIE_PHY_TRSV_REG290, 0x4D},
+	{PCIE_PHY_TRSV_REG291, 0x19},
+	{PCIE_PHY_TRSV_REG292, 0x1C},
+	{PCIE_PHY_TRSV_REG294, 0x05},
+	{PCIE_PHY_TRSV_REG295, 0x10},
+	{PCIE_PHY_TRSV_REG296, 0x0C},
+	{PCIE_PHY_TRSV_REG297, 0x19},
+	{PCIE_PHY_TRSV_REG298, 0x04},
+	{PCIE_PHY_TRSV_REG29B, 0x03},
+	{PCIE_PHY_TRSV_REG29C, 0x1B},
+	{PCIE_PHY_TRSV_REG29D, 0x1B},
+	{PCIE_PHY_TRSV_REG29E, 0x1F},
+	{PCIE_PHY_TRSV_REG2AA, 0x00},
+	{PCIE_PHY_TRSV_REG2AE, 0x1F},
+	{PCIE_PHY_TRSV_REG2C2, 0x25},
+	{PCIE_PHY_TRSV_REG2C6, 0x10},
+	{PCIE_PHY_TRSV_REG2C7, 0x06},
+	{PCIE_PHY_TRSV_REG2CB, 0x10},
+	{PCIE_PHY_TRSV_REG2CC, 0x06},
+	{PCIE_PHY_TRSV_REG2CD, 0x20},
+	{PCIE_PHY_TRSV_REG2CE, 0x27},
+	{PCIE_PHY_TRSV_REG2D0, 0x10},
+	{PCIE_PHY_TRSV_REG2CF, 0x0A},
+	{PCIE_PHY_TRSV_REG2E0, 0x01},
+	{PCIE_PHY_TRSV_REG2E9, 0x11},
+	{PCIE_PHY_TRSV_REG2EA, 0x05},
+	{PCIE_PHY_TRSV_REG2EB, 0x4C},
+	{PCIE_PHY_TRSV_REG315, 0x18},
+	{PCIE_PHY_TRSV_REG317, 0x86},
+	{PCIE_PHY_TRSV_REG319, 0x8E},
+	{PCIE_PHY_TRSV_REG364, 0x00},
+	{PCIE_PHY_TRSV_REG36C, 0x03},
+	{PCIE_PHY_TRSV_REG36D, 0x04},
+	{PCIE_PHY_TRSV_REG37E, 0x06},
+	{PCIE_PHY_TRSV_REG37F, 0x04},
+	{PCIE_PHY_TRSV_REG38F, 0x40},
+	{PCIE_PHY_TRSV_REG391, 0x8B},
+	{PCIE_PHY_TRSV_REG39C, 0xFF},
+	{PCIE_PHY_TRSV_REG3A8, 0x02},
+	{PCIE_PHY_TRSV_REG3E0, 0x93},
+	{PCIE_PHY_TRSV_REG3E1, 0x79},
+	{PCIE_PHY_TRSV_REG3E7, 0xF5},
+	{PCIE_PHY_TRSV_REG3E9, 0x75},
+	{PCIE_PHY_TRSV_REG3EA, 0x0D},
+	{PCIE_PHY_TRSV_REG3EE, 0xE2},
+	{PCIE_PHY_TRSV_REG3EF, 0x6F},
+	{PCIE_PHY_TRSV_REG3F0, 0x3D}
+};
+#define PCIE_PHY_CMN_REG17E		0x5F8
+#define PCIE_PHY_CMN_REG180		0x600
+#define PCIE_PHY_CMN_REG181		0x604
+#define PCIE_PHY_CMN_REG182		0x608
+#define PCIE_PHY_CMN_REG183		0x60C
+#define PCIE_PHY_CMN_REG184		0x610
+#define PCIE_PHY_CMN_REG185		0x614
+#define PCIE_PHY_CMN_REG186		0x618
+#define PCIE_PHY_CMN_REG187		0x61C
+
+struct artpec8_pcie_phy_tune_reg rx_preset_regs[] = {
+	/* 0 */
+	{PCIE_PHY_CMN_REG17E, 0x00},
+	{PCIE_PHY_CMN_REG180, 0x23},
+	{PCIE_PHY_CMN_REG181, 0x44},
+	{PCIE_PHY_CMN_REG182, 0x61},
+	{PCIE_PHY_CMN_REG183, 0x55},
+	{PCIE_PHY_CMN_REG184, 0x14},
+	{PCIE_PHY_CMN_REG185, 0x23},
+	{PCIE_PHY_CMN_REG186, 0x1A},
+	{PCIE_PHY_CMN_REG187, 0x04},
+	{PCIE_PHY_CMN_REG17E, 0x04},
+	{PCIE_PHY_CMN_REG17E, 0x00},
+	/* 1 */
+	{PCIE_PHY_CMN_REG17E, 0x08},
+	{PCIE_PHY_CMN_REG181, 0x42},
+	{PCIE_PHY_CMN_REG17E, 0x0C},
+	{PCIE_PHY_CMN_REG17E, 0x08},
+	/* 2 */
+	{PCIE_PHY_CMN_REG17E, 0x10},
+	{PCIE_PHY_CMN_REG181, 0x40},
+	{PCIE_PHY_CMN_REG17E, 0x14},
+	{PCIE_PHY_CMN_REG17E, 0x10},
+	/* 3 */
+	{PCIE_PHY_CMN_REG17E, 0x18},
+	{PCIE_PHY_CMN_REG181, 0x45},
+	{PCIE_PHY_CMN_REG17E, 0x1C},
+	{PCIE_PHY_CMN_REG17E, 0x18},
+	/* 4 */
+	{PCIE_PHY_CMN_REG17E, 0x20},
+	{PCIE_PHY_CMN_REG181, 0x46},
+	{PCIE_PHY_CMN_REG17E, 0x24},
+	{PCIE_PHY_CMN_REG17E, 0x20},
+	/* 5 */
+	{PCIE_PHY_CMN_REG17E, 0x28},
+	{PCIE_PHY_CMN_REG181, 0x48},
+	{PCIE_PHY_CMN_REG17E, 0x2C},
+	{PCIE_PHY_CMN_REG17E, 0x28},
+	/* 6 */
+	{PCIE_PHY_CMN_REG17E, 0x30},
+	{PCIE_PHY_CMN_REG181, 0x4A},
+	{PCIE_PHY_CMN_REG17E, 0x34},
+	{PCIE_PHY_CMN_REG17E, 0x30},
+	/* 7 */
+	{PCIE_PHY_CMN_REG17E, 0x38},
+	{PCIE_PHY_CMN_REG181, 0x4C},
+	{PCIE_PHY_CMN_REG17E, 0x3C},
+	{PCIE_PHY_CMN_REG17E, 0x38},
+	/* 8 */
+	{PCIE_PHY_CMN_REG17E, 0x40},
+	{PCIE_PHY_CMN_REG180, 0x20},
+	{PCIE_PHY_CMN_REG181, 0x20},
+	{PCIE_PHY_CMN_REG182, 0x01},
+	{PCIE_PHY_CMN_REG17E, 0x44},
+	{PCIE_PHY_CMN_REG17E, 0x40},
+	/* 9 */
+	{PCIE_PHY_CMN_REG17E, 0x48},
+	{PCIE_PHY_CMN_REG180, 0x20},
+	{PCIE_PHY_CMN_REG181, 0x21},
+	{PCIE_PHY_CMN_REG182, 0x01},
+	{PCIE_PHY_CMN_REG17E, 0x4C},
+	{PCIE_PHY_CMN_REG17E, 0x48},
+	/* 10 */
+	{PCIE_PHY_CMN_REG17E, 0x50},
+	{PCIE_PHY_CMN_REG180, 0x24},
+	{PCIE_PHY_CMN_REG181, 0x80},
+	{PCIE_PHY_CMN_REG182, 0x41},
+	{PCIE_PHY_CMN_REG183, 0xAF},
+	{PCIE_PHY_CMN_REG184, 0x26},
+	{PCIE_PHY_CMN_REG185, 0x34},
+	{PCIE_PHY_CMN_REG186, 0x24},
+	{PCIE_PHY_CMN_REG187, 0x06},
+	{PCIE_PHY_CMN_REG17E, 0x54},
+	{PCIE_PHY_CMN_REG17E, 0x50},
+	/* 11 */
+	{PCIE_PHY_CMN_REG17E, 0x58},
+	{PCIE_PHY_CMN_REG181, 0x81},
+	{PCIE_PHY_CMN_REG17E, 0x5C},
+	{PCIE_PHY_CMN_REG17E, 0x58},
+	/* 12 */
+	{PCIE_PHY_CMN_REG17E, 0x60},
+	{PCIE_PHY_CMN_REG181, 0x82},
+	{PCIE_PHY_CMN_REG17E, 0x64},
+	{PCIE_PHY_CMN_REG17E, 0x60},
+	/* 13 */
+	{PCIE_PHY_CMN_REG17E, 0x68},
+	{PCIE_PHY_CMN_REG181, 0x83},
+	{PCIE_PHY_CMN_REG17E, 0x6C},
+	{PCIE_PHY_CMN_REG17E, 0x68},
+	/* 14 */
+	{PCIE_PHY_CMN_REG17E, 0x70},
+	{PCIE_PHY_CMN_REG181, 0x84},
+	{PCIE_PHY_CMN_REG17E, 0x74},
+	{PCIE_PHY_CMN_REG17E, 0x70},
+	/* 15 */
+	{PCIE_PHY_CMN_REG17E, 0x78},
+	{PCIE_PHY_CMN_REG180, 0x24},
+	{PCIE_PHY_CMN_REG181, 0x85},
+	{PCIE_PHY_CMN_REG182, 0x80},
+	{PCIE_PHY_CMN_REG183, 0x7F},
+	{PCIE_PHY_CMN_REG184, 0x2D},
+	{PCIE_PHY_CMN_REG185, 0x34},
+	{PCIE_PHY_CMN_REG186, 0x24},
+	{PCIE_PHY_CMN_REG187, 0x05},
+	{PCIE_PHY_CMN_REG17E, 0x7C},
+	{PCIE_PHY_CMN_REG17E, 0x78},
+	/* 16 */
+	{PCIE_PHY_CMN_REG17E, 0x80},
+	{PCIE_PHY_CMN_REG181, 0x86},
+	{PCIE_PHY_CMN_REG17E, 0x84},
+	{PCIE_PHY_CMN_REG17E, 0x80},
+	/* 17 */
+	{PCIE_PHY_CMN_REG17E, 0x88},
+	{PCIE_PHY_CMN_REG181, 0x87},
+	{PCIE_PHY_CMN_REG17E, 0x8C},
+	{PCIE_PHY_CMN_REG17E, 0x88},
+	/* 18 */
+	{PCIE_PHY_CMN_REG17E, 0x90},
+	{PCIE_PHY_CMN_REG181, 0x88},
+	{PCIE_PHY_CMN_REG17E, 0x94},
+	{PCIE_PHY_CMN_REG17E, 0x90},
+	/* 19 */
+	{PCIE_PHY_CMN_REG17E, 0x98},
+	{PCIE_PHY_CMN_REG181, 0x89},
+	{PCIE_PHY_CMN_REG17E, 0x9C},
+	{PCIE_PHY_CMN_REG17E, 0x98},
+};
+
+
+static void artpec8_pcie_phy_reg_writel(void __iomem *base, u32 val, u32 reg)
+{
+	writel(val, base + reg);
+};
+
+static u32 artpec8_pcie_phy_reg_readl(void __iomem *base, u32 reg)
+{
+	return readl(base + reg);
+};
+
+static struct dentry *debugfs_dir;
+
+/* FOM registers */
+#define PCIE_PHY_FOM_7_0               0xD3C /* TRSV_REG34F */
+#define PCIE_PHY_FOM_15_8              0xF30 /* Undocumented */
+#define PCIE_PHY_FOM_23_16             0xF34 /* Undocumented */
+#define PCIE_PHY_FOM_31_24             0xF2C /* Undocumented */
+
+static int fom_read(void *data, u64 *value)
+{
+	struct phy *phy = data;
+	struct artpec8_pcie_phy *artpec8_phy = phy_get_drvdata(phy);
+	uint32_t fom;
+
+	fom = artpec8_pcie_phy_reg_readl(artpec8_phy->phy_base,
+			PCIE_PHY_FOM_7_0) & 0xff;
+	fom |= (artpec8_pcie_phy_reg_readl(artpec8_phy->phy_base,
+				PCIE_PHY_FOM_15_8) & 0xff) << 8;
+	fom |= (artpec8_pcie_phy_reg_readl(artpec8_phy->phy_base,
+				PCIE_PHY_FOM_23_16) & 0xff) << 16;
+	fom |= (artpec8_pcie_phy_reg_readl(artpec8_phy->phy_base,
+				PCIE_PHY_FOM_31_24) & 0xff) << 24;
+	*value = fom;
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fom_fops, fom_read, NULL, "%llu\n");
+
+
+static void artpec8_pcie_phy_reg_update(void __iomem *base, u32 mask,
+					u32 update, u32 reg)
+{
+	u32 val;
+
+	val = artpec8_pcie_phy_reg_readl(base, reg);
+	val &= ~(mask);
+	val |= update;
+	artpec8_pcie_phy_reg_writel(base, val, reg);
+};
+
+static void artpec8_pcie_enable_ref_clk_from_xo(struct artpec8_pcie_phy
+						*pciephy)
+{
+	regmap_update_bits(pciephy->sysreg, FSYS_PCIE_CON,
+			   PCIE_PHY_LCPLL_REFCLK_SEL,
+			   REF_CLK_FROM_XO);
+	regmap_update_bits(pciephy->sysreg, FSYS_PCIE_CON,
+			   PCIE_PHY_ROPLL_REFCLK_SEL,
+			   ROPLL_REFCLK_NOT_AVAILABLE);
+};
+
+static void artpec8_pcie_enable_ref_clk_from_io(struct artpec8_pcie_phy
+						*pciephy)
+{
+	artpec8_pcie_phy_reg_update(pciephy->phy_base,
+				    PCIE_AUX_RX_MODE_EXTEND, 0,
+				    PCIE_PHY_CMN_REG14D);
+	artpec8_pcie_phy_reg_update(pciephy->phy_base,
+				    ANA_AUX_EXT_REF_CLK_SEL, 0,
+				    PCIE_PHY_CMN_REG0D9);
+	artpec8_pcie_phy_reg_update(pciephy->phy_base,
+					AUX_PLL_EN_EXTEND, 0,
+				    PCIE_PHY_CMN_REG10F);
+	artpec8_pcie_phy_reg_update(pciephy->phy_base,
+					AUX2_PLL_EN_EXTEND, 0,
+				    PCIE_PHY_CMN_REG11E);
+	artpec8_pcie_phy_reg_update(pciephy->phy_base,
+					OV_S_ANA_AUX_EN, OV_S_ANA_AUX_EN,
+					PCIE_PHY_CMN_REG0D4);
+	artpec8_pcie_phy_reg_update(pciephy->phy_base,
+					OV_I_ANA_AUX_EN, OV_I_ANA_AUX_EN,
+					PCIE_PHY_CMN_REG0D4);
+
+	regmap_update_bits(pciephy->sysreg, FSYS_PCIE_CON,
+			   PCIE_PHY_LCPLL_REFCLK_SEL,
+			   REF_CLK_FROM_IO);
+	regmap_update_bits(pciephy->sysreg, FSYS_PCIE_CON,
+			   PCIE_PHY_ROPLL_REFCLK_SEL,
+			   ROPLL_REFCLK_NOT_AVAILABLE);
+	regmap_update_bits(pciephy->sysreg, FSYS_PCIE_CON,
+			   PCIE_PHY_LN0_REFCLK_PAD_EN,
+			   PCIE_PHY_LN0_REFCLK_PAD_EN);
+	regmap_update_bits(pciephy->sysreg, FSYS_PCIE_CON,
+			   PCIE_PHY_LN1_REFCLK_PAD_EN,
+			   PCIE_PHY_LN1_REFCLK_PAD_EN);
+}
+
+static void artpec8_pcie_enable_ref_clk_from_soc_pll(struct artpec8_pcie_phy
+						    *pciephy)
+{
+	regmap_update_bits(pciephy->sysreg, FSYS_PCIE_CON,
+			   PCIE_PHY_LCPLL_REFCLK_SEL,
+			   REF_CLK_FROM_SOC_PLL);
+	regmap_update_bits(pciephy->sysreg, FSYS_PCIE_CON,
+			   PCIE_PHY_ROPLL_REFCLK_SEL,
+			   ROPLL_REFCLK_NOT_AVAILABLE);
+}
+
+static void artpec8_pcie_lane_control(struct phy *phy, u32 lane0_reg, u32 mask,
+				      u32 val)
+{
+	struct artpec8_pcie_phy *pciephy = phy_get_drvdata(phy);
+	u32 lanex_reg = lane0_reg;
+	int i;
+
+	if (lane0_reg < PCIE_PHY_LN0_REG_START ||
+	    lane0_reg > PCIE_PHY_LN0_REG_END) {
+		dev_err(&phy->dev, "offset [0x%04x] out of range of lane0\n",
+			lane0_reg);
+		return;
+	}
+
+
+	for (i = 0; i < pciephy->num_lanes; i++) {
+		lanex_reg += OFFSET_PER_LANE * i;
+		artpec8_pcie_phy_reg_update(pciephy->phy_base, mask, val,
+					    lanex_reg);
+	}
+}
+
+static void artpec8_pcie_phy_tune(struct artpec8_pcie_phy *pciephy)
+{
+	int i, count;
+
+	/* init cmn registers */
+	count = ARRAY_SIZE(cmn_regs);
+	for (i = 0; i < count; i++) {
+		artpec8_pcie_phy_reg_writel(pciephy->phy_base,
+					    cmn_regs[i].val,
+					    cmn_regs[i].offset);
+	}
+
+	/* init lane registers */
+	count = ARRAY_SIZE(lane_regs);
+	for (i = 0; i < count; i++) {
+		artpec8_pcie_phy_reg_writel(pciephy->phy_base,
+					    lane_regs[i].val,
+					    lane_regs[i].offset);
+		artpec8_pcie_phy_reg_writel(pciephy->phy_base,
+					    lane_regs[i].val,
+					    lane_regs[i].offset +
+					    OFFSET_PER_LANE);
+	}
+
+	/* rx preset registers */
+	count = ARRAY_SIZE(rx_preset_regs);
+	for (i = 0; i < count; i++) {
+		artpec8_pcie_phy_reg_writel(pciephy->phy_base,
+					    rx_preset_regs[i].val,
+					    rx_preset_regs[i].offset);
+	}
+}
+
+static int artpec8_pcie_phy_init(struct phy *phy)
+{
+	struct artpec8_pcie_phy *pciephy = phy_get_drvdata(phy);
+
+	/* reset init_rstn and cmn_rstn */
+	artpec8_pcie_phy_reg_update(pciephy->phy_base, OV_I_CMN_RSTN | OV_I_INIT_RSTN,
+				    0, PCIE_PHY_CMN_REG101);
+
+	/* reference clock selection */
+	switch (pciephy->lcpll_ref_clk) {
+	case REF_CLK_FROM_XO:
+		artpec8_pcie_enable_ref_clk_from_xo(pciephy);
+		break;
+	case REF_CLK_FROM_IO:
+		artpec8_pcie_enable_ref_clk_from_io(pciephy);
+		break;
+	case REF_CLK_FROM_SOC_PLL:
+		artpec8_pcie_enable_ref_clk_from_soc_pll(pciephy);
+		break;
+	default:
+		dev_err(&phy->dev, "invalid reference clock [%d]\n",
+			pciephy->lcpll_ref_clk);
+		break;
+	}
+
+	dev_dbg(&phy->dev, "phy init, lcpll_ref_clk[%d]\n",
+		 pciephy->lcpll_ref_clk);
+
+	/* release i_init_rstn */
+	artpec8_pcie_phy_reg_update(pciephy->phy_base, OV_I_INIT_RSTN,
+				    OV_I_INIT_RSTN, PCIE_PHY_CMN_REG101);
+
+	/* phy initial settings */
+	artpec8_pcie_phy_tune(pciephy);
+
+	/* pll_en should be set to off when PM_STATE is P1.CPM */
+	if (!strncmp(pciephy->mode, "pcie_ep", strlen("pcie_ep"))) {
+		artpec8_pcie_phy_reg_update(pciephy->pcs_base, B1_DYNAMIC,
+					    B1_DYNAMIC, PCIE_PCS_OUT_VEC_4);
+	}
+
+	/* disable lane eq ctrl rx data hold */
+	artpec8_pcie_lane_control(phy, PCIE_PHY_TRSV_REG2C0,
+				  LN_EQ_CTRL_RX_DATA_HOLD, 0);
+
+	return 0;
+}
+
+static int artpec8_pcie_phy_exit(struct phy *phy)
+{
+	dev_dbg(&phy->dev, "phy exit\n");
+
+	return 0;
+}
+
+static int artpec8_pcie_phy_reset(struct phy *phy)
+{
+	struct artpec8_pcie_phy *pciephy = phy_get_drvdata(phy);
+
+	artpec8_pcie_phy_reg_update(pciephy->phy_base, OV_I_CMN_RSTN,
+				    0, PCIE_PHY_CMN_REG101);
+	udelay(10);
+	artpec8_pcie_phy_reg_update(pciephy->phy_base, OV_I_CMN_RSTN,
+				    OV_I_CMN_RSTN, PCIE_PHY_CMN_REG101);
+
+	dev_dbg(&phy->dev, "phy reset\n");
+
+	return 0;
+}
+
+static int artpec8_pcie_phy_power_on(struct phy *phy)
+{
+	struct artpec8_pcie_phy *pciephy = phy_get_drvdata(phy);
+
+	regmap_update_bits(pciephy->sysreg, FSYS_PCIE_CON,
+			   PCIE_PHY_PWR_OFF, 0);
+
+	dev_dbg(&phy->dev, "phy power on\n");
+
+	return 0;
+}
+
+static int artpec8_pcie_phy_power_off(struct phy *phy)
+{
+	struct artpec8_pcie_phy *pciephy = phy_get_drvdata(phy);
+
+	regmap_update_bits(pciephy->sysreg, FSYS_PCIE_CON,
+			   PCIE_PHY_PWR_OFF, PCIE_PHY_PWR_OFF);
+
+	dev_dbg(&phy->dev, "phy power off\n");
+
+	return 0;
+}
+
+static const struct phy_ops artpec8_phy_ops = {
+	.init		= artpec8_pcie_phy_init,
+	.exit		= artpec8_pcie_phy_exit,
+	.reset		= artpec8_pcie_phy_reset,
+	.power_on	= artpec8_pcie_phy_power_on,
+	.power_off	= artpec8_pcie_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static const struct artpec8_pcie_phy_data artpec8_pcie_phy_data = {
+	.ops		= &artpec8_phy_ops,
+};
+
+static const struct of_device_id artpec8_pcie_phy_match[] = {
+	{
+		.compatible = "axis,artpec8-pcie-phy",
+		.data = &artpec8_pcie_phy_data,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, artpec8_pcie_phy_match);
+
+static int artpec8_pcie_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct artpec8_pcie_phy *artpec8_phy;
+	struct phy *generic_phy;
+	struct phy_provider *phy_provider;
+	struct resource *res;
+	const struct artpec8_pcie_phy_data *drv_data;
+
+	drv_data = of_device_get_match_data(dev);
+	if (!drv_data)
+		return -ENODEV;
+
+	artpec8_phy = devm_kzalloc(dev, sizeof(*artpec8_phy), GFP_KERNEL);
+	if (!artpec8_phy)
+		return -ENOMEM;
+
+	/* reference clock */
+	if (of_property_read_u32(dev->of_node, "lcpll-ref-clk",
+				&artpec8_phy->lcpll_ref_clk)) {
+		dev_err(dev, "Failed selecting the lcpll-ref-clk\n");
+		return -EINVAL;
+	}
+	/* PLL SOC reference clock */
+	if (artpec8_phy->lcpll_ref_clk == REF_CLK_FROM_SOC_PLL) {
+		artpec8_phy->soc_pll_clk = devm_clk_get(dev, "ref_clk");
+		if (IS_ERR(artpec8_phy->soc_pll_clk)) {
+			dev_err(dev, "couldn't get reference clock\n");
+			return -EINVAL;
+		}
+		clk_prepare_enable(artpec8_phy->soc_pll_clk);
+	}
+
+	/* link mode */
+	if (of_property_read_string(dev->of_node, "mode", &artpec8_phy->mode)) {
+		dev_err(dev, "failed to get mode\n");
+		return -EINVAL;
+	}
+
+	/* number of lanes */
+	if (of_property_read_u32(dev->of_node, "num-lanes",
+				 &artpec8_phy->num_lanes)) {
+		dev_err(dev, "failed to get num-lanes\n");
+		return -EINVAL;
+	}
+
+	if (artpec8_phy->num_lanes > LANE_MAX) {
+		dev_err(dev, "invalid num_lanes[%u]\n", artpec8_phy->num_lanes);
+		return -EINVAL;
+	}
+
+	/* PHY base register */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
+	artpec8_phy->phy_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(artpec8_phy->phy_base))
+		return PTR_ERR(artpec8_phy->phy_base);
+
+	/* PCS base register */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcs");
+	artpec8_phy->pcs_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(artpec8_phy->pcs_base))
+		return PTR_ERR(artpec8_phy->pcs_base);
+
+	/* sysreg regmap handle, need to change using smc */
+	artpec8_phy->sysreg =
+		syscon_regmap_lookup_by_phandle(dev->of_node,
+			"samsung,fsys-sysreg");
+	if (IS_ERR(artpec8_phy->sysreg)) {
+		dev_err(dev, "fsys sysreg regmap lookup failed.\n");
+		return PTR_ERR(artpec8_phy->sysreg);
+	}
+
+	artpec8_phy->drv_data = drv_data;
+
+	generic_phy = devm_phy_create(dev, dev->of_node, drv_data->ops);
+	if (IS_ERR(generic_phy)) {
+		dev_err(dev, "failed to create PHY\n");
+		return PTR_ERR(generic_phy);
+	}
+
+	phy_set_drvdata(generic_phy, artpec8_phy);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	if (IS_ERR(phy_provider)) {
+		dev_err(dev, "failed to register PHY provider\n");
+		return PTR_ERR(phy_provider);
+	}
+
+	/* Add FOM in debugfs */
+	debugfs_dir = debugfs_create_dir("pcie-phy", NULL);
+	debugfs_create_file("phy-fom", 0444, debugfs_dir,
+			    generic_phy, &fom_fops);
+
+	dev_info(dev, "registered PCIe PHY\n");
+
+	return 0;
+}
+
+static int __exit artpec8_pcie_remove(struct platform_device *pdev)
+{
+	struct artpec8_pcie_phy *artpec8_phy = platform_get_drvdata(pdev);
+
+	/* Remove debugfs files for FOM values */
+	debugfs_remove_recursive(debugfs_dir);
+
+	if (artpec8_phy->soc_pll_clk)
+		clk_disable_unprepare(artpec8_phy->soc_pll_clk);
+
+	return 0;
+}
+
+static struct platform_driver artpec8_pcie_phy_driver = {
+	.probe	= artpec8_pcie_phy_probe,
+	.remove	= __exit_p(artpec8_pcie_phy_remove),
+	.driver = {
+		.of_match_table	= artpec8_pcie_phy_match,
+		.name		= "artpec8_pcie_phy",
+	}
+};
+
+module_platform_driver(artpec8_pcie_phy_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jaeho Cho <jaeho79.cho@samsung.com>");
-- 
2.9.5
