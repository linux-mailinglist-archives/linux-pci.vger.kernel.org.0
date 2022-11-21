Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D49632107
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 12:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbiKULp0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 06:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiKULpA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 06:45:00 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3831F1144C
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 03:44:58 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221121114456epoutp01cc9c9ada732cb52c3c9c2679c25af5ff~plvCJIgyK1750417504epoutp01k
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 11:44:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221121114456epoutp01cc9c9ada732cb52c3c9c2679c25af5ff~plvCJIgyK1750417504epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669031096;
        bh=c990sCiq0zvDTMsHHjHhBwmXzm4vFtz79VQIqBmSj/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dH5ZoP66BVB3g+mDA7K4ZSY/Uk8iBIWG+nORMhNnBdJpE624IK0RRElw6AXc70rHj
         TV3k0Vbk3lNUL2gk9R8mUhwnhZ1FTPkSn3oErbzACKjtLua5Qz30kMcQYl+O9Qr414
         tNXI/rJJUyPaAfR3lmKJqkM+MmvX/U54/uDiJcA0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221121114455epcas5p410ea9bda0ccdb9d2880c72a12b3be5be~plvBE-Lq62259222592epcas5p4J;
        Mon, 21 Nov 2022 11:44:55 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NG5Cp3Mstz4x9Px; Mon, 21 Nov
        2022 11:44:54 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.B5.56352.6B46B736; Mon, 21 Nov 2022 20:44:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221121104736epcas5p36c12ff0b575af77f8cf99811b055b339~pk8_lU1Mf0704807048epcas5p3e;
        Mon, 21 Nov 2022 10:47:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221121104736epsmtrp1b2f727aa3da94d37a6356fccce8793d9~pk8_kSZGY2467324673epsmtrp15;
        Mon, 21 Nov 2022 10:47:36 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-ae-637b64b601ef
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.5B.14392.8475B736; Mon, 21 Nov 2022 19:47:36 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221121104733epsmtip182b28227ecb6fde21abbe8f31c65ba50~pk87JK7Zc0888708887epsmtip1_;
        Mon, 21 Nov 2022 10:47:33 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com, vkoul@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, mani@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com, rcsekar@samsung.com,
        sriranjani.p@samsung.com, bharat.uppal@samsung.com,
        s.prashar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, p.rajanbabu@samsung.com,
        niyas.ahmed@samsung.com, chanho61.park@samsung.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH 4/6] phy: tesla-pcie: Add PCIe PHY driver support for FSD
Date:   Mon, 21 Nov 2022 16:22:08 +0530
Message-Id: <20221121105210.68596-5-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221121105210.68596-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTfUxTVxTAc/va10LG9iigFwaMvGVxshVaKOzCRE0g8xlZZCPuD8csXXlQ
        Rnnt+gFMMTL5yCQISNQRhEKATamAWBAZyoSWAZKMdZY4GWwDBpEPMwgKOitshVe2/34553fu
        ued+CDDhPdxPkM7oaS0jV5G4O7fTuvtNUWfKCYW44A8f1LvUx0WTxk4crVcM8JGl/QYf3Z+3
        8VHjaSWy33kL1faP8FB+wzUc2WZLcFQ6N4WhvBIHD9m7q3H0o3EQR+WmNS4qeFHARb3LJoBm
        zk/z0A/XE1H9jSd8VGXr4qHCnn4+MnbVAHTWehKNP2rloe8mhrD9fpTjeQWg6swGymw6g1MT
        92/j1Mzo1xzqTk0zn2pvPEWVdpgANfjgJod6bA5McD+asUdJy1NobRDNKNQp6UxaDHkoURYr
        i4gUS0SSKPQOGcTIM+kYMi4+QfReuso5OBmUJVcZnKEEuU5Hhu7do1Ub9HSQUq3Tx5C0JkWl
        kWpCdPJMnYFJC2FofbRELA6LcIrJGcrV579gmr+O50yNb/DyQFV6MXATQEIKn845sGLgLhAS
        twB81mzFNxNCYgXAMy0iNrEGoMVajG1XTDddAWyiB8CRxVpXeSEHVrTZwaaFE8Hwy1W2wptY
        weDTi9GbEkbUATj1oGlL8iIOwkl79RZziTfggm2Ju8keRDTs/P4Sh233Grza1ru1kBvxLmxt
        GMfZ+LIAdndnshwHL/503uV7wYXBDj7LfnC+rMjFabCpvdI1ggqutTe6/H2wd7Ta2Vfg3Nxu
        eK07lA0HwAvDrVsKRrwMzzpmXLoH7DJu8+vwyfptLsu+0Dhg57FMwbGWKZw9lFIAr1eUgXIQ
        WPV/izoATMCX1ugy02hdhCacobP/uzWFOtMMth538KEuMD25HGIBHAGwACjASG+PU0knFEKP
        FPkXx2mtWqY1qGidBUQ4z+8c5uejUDt/B6OXSaRRYmlkZKQ0KjxSQu70aKgMVgiJNLmezqBp
        Da3druMI3PzyOPyirMKkm/wSMQk0wgnZcPR4YYe6yxJa8Wluw0Hm2EuOBP/w4MU4fZFwJrvP
        ZJ/sb1aModj5HIfdFypX5u593vOrW+6riqOp5PvJLc3Zj6xe+rHT+49dzg14liQk/7EFaP6s
        LK7P6vH5+VIlTNWbk4x9UPiJcUn428Nz3jtE+b+XfBZfQx65W/cx9TczXNL9UT23szijfeNb
        FLtQ1iDbVRTG9LWmzh6pPTyXPxqWIPCXvWIuzXn7rihx7wDz+Mqov6dn+gXrVzujxxqrpMlB
        qvD8wKmTq/uGyvM36pVxfTvEjb7xWfSt5ofzL76xtB0Yml2MSFof8bTBpVT9h1c/uExydUq5
        JBjT6uT/Apb9QaJlBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJTtcjvDrZ4PxjPYsD7w+yWDyYt43N
        4u+kY+wWhzZvZbe49vICu8WSpgyLy/u1LeYfOcdq0bx4PZvFhac9bBZ9Lx4yWzT0/Ga1uLxr
        DpvF2XnH2SwmrPrGYtHyp4XF4sCHVYwWT6Y8YrU4ujHYYtHWL+wWsy7sYLVo3XuE3WLejrmM
        Fr2Hay1uv1nHarHzzglmBymP378mMXos2FTqsWlVJ5vHnWt72DyeXJnO5LF/7hp2j81L6j36
        tqxi9Dh+YzuTx+dNcgFcUVw2Kak5mWWpRfp2CVwZX39dZy54V1Xx8PY/1gbGWZldjJwcEgIm
        Eo9WrmDsYuTiEBLYzSjxc9ZUJoiEpMTni+ugbGGJlf+es0MUNTNJTPl3hw0kwSagJdH4tYsZ
        JCEi0MMiMXvrHbAqZoEljBKb7+4BqxIW8JR4cHkOI4jNIqAq8erCexYQm1fASmLbvtlQK+Ql
        Vm84wAxicwpYS6xbfBusVwioZt2NP+wTGPkWMDKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvX
        S87P3cQIji8tzR2M21d90DvEyMTBeIhRgoNZSYRX5FhlshBvSmJlVWpRfnxRaU5q8SFGaQ4W
        JXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MOrcz6y5cMT0/7/937j7Zw4mL/zMteiG6x/6/
        h1h++KuHzE1LT8stPWrQz+99w9ouy9zytoLCSrHDlh0q52IXKZnNmyfabffz+joPhclaExQW
        bM4y/HYloOaXQZbzrt8Vvs+5pj/JVjnjeFh25eMn85ObOZoDsqfpyBVx/eawWrRkdbnI57oP
        miGJGspbXjCaR9xj+uguNX/j3Wu9bwX/tG6odF3/ieHrkxt3k28e/DLzU67+jv0ez0QaU6OX
        XL9v8OTOYoaQFwvvbv1zMmz+xDu8pQ6rtrDZ6H839yvkMwmW9y0WmN9WsaO+T6b6ZMkX9fob
        Trt4S2MCDquWv/IQX/Zs6/kZ89vcZZVNMlcKKbEUZyQaajEXFScCAG8VljAeAwAA
X-CMS-MailID: 20221121104736epcas5p36c12ff0b575af77f8cf99811b055b339
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221121104736epcas5p36c12ff0b575af77f8cf99811b055b339
References: <20221121105210.68596-1-shradha.t@samsung.com>
        <CGME20221121104736epcas5p36c12ff0b575af77f8cf99811b055b339@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch adds PHY driver support for PCIe controller
found in Tesla FSD SoC.

Signed-off-by: Niyas Ahmed S T <niyas.ahmed@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
---
 drivers/phy/samsung/Kconfig          |  10 +
 drivers/phy/samsung/Makefile         |   1 +
 drivers/phy/samsung/phy-tesla-pcie.c | 397 +++++++++++++++++++++++++++
 3 files changed, 408 insertions(+)
 create mode 100644 drivers/phy/samsung/phy-tesla-pcie.c

diff --git a/drivers/phy/samsung/Kconfig b/drivers/phy/samsung/Kconfig
index 3ccaabf2850a..8c108b974c09 100644
--- a/drivers/phy/samsung/Kconfig
+++ b/drivers/phy/samsung/Kconfig
@@ -38,6 +38,16 @@ config PHY_SAMSUNG_UFS
 	  Samsung Exynos SoCs. This driver provides the interface for UFS host
 	  controller to do PHY related programming.
 
+config PHY_TESLA_FSD_PCIE
+	bool "TESLA FSD PCIe PHY driver"
+	depends on OF && (ARCH_TESLA_FSD || COMPILE_TEST)
+	select GENERIC_PHY
+	help
+	  Enable PCIe PHY support for TESLA FSD SoC series.
+	  This driver provides PHY interface for TESLA FSD PCIe controller.
+	  It will do basic initialisation of the PHY and make it available
+	  for use.
+
 config PHY_SAMSUNG_USB2
 	tristate "S5P/Exynos SoC series USB 2.0 PHY driver"
 	depends on HAS_IOMEM
diff --git a/drivers/phy/samsung/Makefile b/drivers/phy/samsung/Makefile
index afb34a153e34..f1fc0db84eab 100644
--- a/drivers/phy/samsung/Makefile
+++ b/drivers/phy/samsung/Makefile
@@ -15,3 +15,4 @@ phy-exynos-usb2-$(CONFIG_PHY_EXYNOS5250_USB2)	+= phy-exynos5250-usb2.o
 phy-exynos-usb2-$(CONFIG_PHY_S5PV210_USB2)	+= phy-s5pv210-usb2.o
 obj-$(CONFIG_PHY_EXYNOS5_USBDRD)	+= phy-exynos5-usbdrd.o
 obj-$(CONFIG_PHY_EXYNOS5250_SATA)	+= phy-exynos5250-sata.o
+obj-$(CONFIG_PHY_TESLA_FSD_PCIE)		+= phy-tesla-pcie.o
diff --git a/drivers/phy/samsung/phy-tesla-pcie.c b/drivers/phy/samsung/phy-tesla-pcie.c
new file mode 100644
index 000000000000..448579f53840
--- /dev/null
+++ b/drivers/phy/samsung/phy-tesla-pcie.c
@@ -0,0 +1,397 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TESLA FSD SoC series PCIe PHY driver
+ *
+ * Phy provider for PCIe controller on TESLA FSD SoC series
+ *
+ * Copyright (C) 2018-2021 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/init.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/phy/phy.h>
+#include <linux/regmap.h>
+
+#define FSD_LANE_OFFSET			0x400
+#define BRF_NONE			0
+#define BRF_L4				1
+#define BRF_L2				2
+
+/* TESLA FSD: PCIe PHY registers */
+#define PCIE_PHY_AGG_BIF_RESET		0x0200
+#define PCIE_PHY_AGG_BIF_CLOCK		0x0208
+
+#define FSD_PCIE_PHY_TRSV_REG01_LN_N	0x5EC
+#define FSD_PCIE_PHY_TRSV_REG02_LN_N	0x548
+#define FSD_PCIE_PHY_TRSV_REG03_LN_N	0x4E4
+#define FSD_PCIE_PHY_TRSV_REG04_LN_N	0x4EC
+#define FSD_PCIE_PHY_TRSV_REG05_LN_N	0x4F0
+#define FSD_PCIE_PHY_TRSV_REG06_LN_N	0x4F8
+#define FSD_PCIE_PHY_TRSV_REG07_LN_N	0x4FC
+#define FSD_PCIE_PHY_TRSV_REG08_LN_N	0x50C
+#define FSD_PCIE_PHY_TRSV_REG09_LN_N	0x520
+#define FSD_PCIE_PHY_TRSV_REG10_LN_N	0x5AC
+#define FSD_PCIE_PHY_TRSV_REG11_LN_N	0x60C
+#define FSD_PCIE_PHY_TRSV_REG12_LN_N	0x618
+#define FSD_PCIE_PHY_TRSV_REG13_LN_N	0x61C
+#define FSD_PCIE_PHY_TRSV_REG14_LN_N	0x678
+#define FSD_PCIE_PHY_TRSV_REG15_LN_N	0x67C
+#define FSD_PCIE_PHY_TRSV_REG16_LN_N	0x404
+#define FSD_PCIE_PHY_TRSV_REG17_LN_N	0x408
+#define FSD_PCIE_PHY_TRSV_REG18_LN_N	0x414
+#define FSD_PCIE_PHY_TRSV_REG19_LN_N	0x418
+#define FSD_PCIE_PHY_TRSV_REG20_LN_N	0x41C
+#define FSD_PCIE_PHY_TRSV_REG21_LN_N	0x424
+#define FSD_PCIE_PHY_TRSV_REG22_LN_N	0x428
+#define FSD_PCIE_PHY_TRSV_REG23_LN_N	0x430
+#define FSD_PCIE_PHY_TRSV_REG24_LN_N	0x448
+#define FSD_PCIE_PHY_TRSV_REG25_LN_N	0x44C
+#define FSD_PCIE_PHY_TRSV_REG26_LN_N	0x450
+#define FSD_PCIE_PHY_TRSV_REG27_LN_N	0x454
+#define FSD_PCIE_PHY_TRSV_REG28_LN_N	0x458
+#define FSD_PCIE_PHY_TRSV_REG29_LN_N	0x7F0
+#define FSD_PCIE_PHY_TRSV_REG30_LN_N	0x7F4
+
+/* TESLA FSD PCIe PCS registers */
+#define PCIE_PCS_BRF_0			0x0004
+#define PCIE_PCS_BRF_1			0x0804
+#define PCIE_PCS_CLK			0x0180
+
+/* TESLA FSD SYS REG registers */
+#define PCIE_PHY_0_CON			0x042C
+#define PCIE_PHY_1_CON			0x0500
+
+#define PHY_0_CON_MASK			0x3FF
+#define PHY_0_REF_SEL_MASK		0x3
+#define PHY_0_REF_SEL			(0x2 << 0)
+#define PHY_0_SSC_EN_MASK		0x8
+#define PHY_0_SSC_EN			BIT(3)
+#define PHY_0_AUX_EN_MASK		0x10
+#define PHY_0_AUX_EN			BIT(4)
+#define PHY_0_CMN_RSTN_MASK		0x100
+#define PHY_0_CMN_RSTN			BIT(8)
+#define PHY_0_INIT_RSTN_MASK		0x200
+#define PHY_0_INIT_RSTN			BIT(9)
+
+#define PHY_1_CON_MASK			0x1FF
+#define PHY_1_AUX_EN_MASK		0x1
+#define PHY_1_AUX_EN			BIT(0)
+#define PHY_1_CMN_RSTN_MASK		0x2
+#define PHY_1_CMN_RSTN			BIT(1)
+#define PHY_1_INIT_RSTN_MASK		0x8
+#define PHY_1_INIT_RSTN			BIT(3)
+#define PHY_1_REF_SEL_MASK		0x30
+#define PHY_1_REF_SEL			(0x2 << 4)
+#define PHY_1_SSC_EN_MASK		0x80
+#define PHY_1_SSC_EN			BIT(7)
+
+struct fsd_pcie_phy_n_pdata {
+	u32 phy_con;
+	u32 phy_con_mask;
+	u32 phy_ref_sel_mask;
+	u32 phy_ref_sel;
+	u32 phy_ssc_en_mask;
+	u32 phy_ssc_en;
+	u32 phy_aux_en_mask;
+	u32 phy_aux_en;
+	u32 phy_cmn_rstn_mask;
+	u32 phy_cmn_rstn;
+	u32 phy_init_rstn_mask;
+	u32 phy_init_rstn;
+	u32 phy_trsv_reg19_val;
+	u32 phy_trsv_reg29_val;
+	u32 num_lanes;
+	u32 lane_offset;
+};
+
+struct fsd_pcie_phy_data {
+	const struct phy_ops	*ops;
+	struct fsd_pcie_phy_n_pdata *phy0_pdata;
+	struct fsd_pcie_phy_n_pdata *phy1_pdata;
+};
+
+struct fsd_pcie_phy {
+	void __iomem *phy_base;
+	void __iomem *pcs_base;
+
+	struct regmap *sysreg;
+	const struct fsd_pcie_phy_data *drv_data;
+	struct fsd_pcie_phy_n_pdata *pdata;
+
+	u32 lane_sel;
+	u32 bifurcation_mode;
+	int phy_id;
+};
+
+struct fsd_pcie_phy_n_pdata fsd_phy0_con = {
+	.num_lanes		= 0x4,
+	.lane_offset		= FSD_LANE_OFFSET,
+	.phy_con		= PCIE_PHY_0_CON,
+	.phy_con_mask		= PHY_0_CON_MASK,
+	.phy_ref_sel_mask	= PHY_0_REF_SEL_MASK,
+	.phy_ref_sel		= PHY_0_REF_SEL,
+	.phy_ssc_en_mask	= PHY_0_SSC_EN_MASK,
+	.phy_ssc_en		= PHY_0_SSC_EN,
+	.phy_aux_en_mask	= PHY_0_AUX_EN_MASK,
+	.phy_aux_en		= PHY_0_AUX_EN,
+	.phy_cmn_rstn_mask	= PHY_0_CMN_RSTN_MASK,
+	.phy_cmn_rstn		= PHY_0_CMN_RSTN,
+	.phy_init_rstn_mask	= PHY_0_INIT_RSTN_MASK,
+	.phy_init_rstn		= PHY_0_INIT_RSTN,
+	.phy_trsv_reg19_val	= 0x0,
+	.phy_trsv_reg29_val	= 0x7,
+};
+
+struct fsd_pcie_phy_n_pdata fsd_phy1_con = {
+	.num_lanes		= 0x4,
+	.lane_offset		= FSD_LANE_OFFSET,
+	.phy_con		= PCIE_PHY_1_CON,
+	.phy_con_mask		= PHY_1_CON_MASK,
+	.phy_ref_sel_mask	= PHY_1_REF_SEL_MASK,
+	.phy_ref_sel		= PHY_1_REF_SEL,
+	.phy_ssc_en_mask	= PHY_1_SSC_EN_MASK,
+	.phy_ssc_en		= PHY_1_SSC_EN,
+	.phy_aux_en_mask	= PHY_1_AUX_EN_MASK,
+	.phy_aux_en		= PHY_1_AUX_EN,
+	.phy_cmn_rstn_mask	= PHY_1_CMN_RSTN_MASK,
+	.phy_cmn_rstn		= PHY_1_CMN_RSTN,
+	.phy_init_rstn_mask	= PHY_1_INIT_RSTN_MASK,
+	.phy_init_rstn		= PHY_1_INIT_RSTN,
+	.phy_trsv_reg19_val	= 0x3,
+	.phy_trsv_reg29_val	= 0x80,
+};
+
+static void fsd_pcie_phy_writel(struct fsd_pcie_phy *phy_ctrl,
+							u32 val, u32 offset)
+{
+	u32 i;
+	void __iomem *phy_base = phy_ctrl->phy_base;
+	struct fsd_pcie_phy_n_pdata *pdata = phy_ctrl->pdata;
+
+	for (i = 0; i < pdata->num_lanes; i++)
+		writel(val, phy_base + (offset + i * pdata->lane_offset));
+}
+
+static int fsd_pcie_phy_init(struct phy *phy)
+{
+	struct fsd_pcie_phy *phy_ctrl = phy_get_drvdata(phy);
+	void __iomem *phy_base = phy_ctrl->phy_base;
+	struct fsd_pcie_phy_n_pdata *pdata = phy_ctrl->pdata;
+
+	if (phy_ctrl->bifurcation_mode == BRF_NONE) {
+		writel(0x00, phy_ctrl->pcs_base + PCIE_PCS_BRF_0);
+		writel(0x00, phy_ctrl->pcs_base + PCIE_PCS_BRF_1);
+		writel(0x00, phy_base + PCIE_PHY_AGG_BIF_RESET);
+		writel(0x00, phy_base + PCIE_PHY_AGG_BIF_CLOCK);
+	} else if (phy_ctrl->bifurcation_mode == BRF_L4) {
+		writel(0xF, phy_ctrl->pcs_base + PCIE_PCS_BRF_0);
+		writel(0xF, phy_ctrl->pcs_base + PCIE_PCS_BRF_1);
+		writel(0x55, phy_base + PCIE_PHY_AGG_BIF_RESET);
+		writel(0x00, phy_base + PCIE_PHY_AGG_BIF_CLOCK);
+	} else if (phy_ctrl->bifurcation_mode == BRF_L2) {
+		writel(0xC, phy_ctrl->pcs_base + PCIE_PCS_BRF_0);
+		writel(0xC, phy_ctrl->pcs_base + PCIE_PCS_BRF_1);
+		writel(0x50, phy_base + PCIE_PHY_AGG_BIF_RESET);
+		writel(0xA0, phy_base + PCIE_PHY_AGG_BIF_CLOCK);
+	}
+
+	fsd_pcie_phy_writel(phy_ctrl, 0x20, FSD_PCIE_PHY_TRSV_REG01_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0x01, FSD_PCIE_PHY_TRSV_REG02_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0xF, FSD_PCIE_PHY_TRSV_REG03_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0x13, FSD_PCIE_PHY_TRSV_REG04_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0xFB, FSD_PCIE_PHY_TRSV_REG05_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0x10, FSD_PCIE_PHY_TRSV_REG06_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0x4, FSD_PCIE_PHY_TRSV_REG07_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0x11, FSD_PCIE_PHY_TRSV_REG08_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0x11, FSD_PCIE_PHY_TRSV_REG09_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0x78, FSD_PCIE_PHY_TRSV_REG10_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0x8, FSD_PCIE_PHY_TRSV_REG11_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0xFF, FSD_PCIE_PHY_TRSV_REG12_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0x3D, FSD_PCIE_PHY_TRSV_REG13_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0x33, FSD_PCIE_PHY_TRSV_REG14_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0x33, FSD_PCIE_PHY_TRSV_REG15_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0x3F, FSD_PCIE_PHY_TRSV_REG16_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0x1C, FSD_PCIE_PHY_TRSV_REG17_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0x2B, FSD_PCIE_PHY_TRSV_REG18_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, pdata->phy_trsv_reg19_val,
+			FSD_PCIE_PHY_TRSV_REG19_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0x9, FSD_PCIE_PHY_TRSV_REG20_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0x10, FSD_PCIE_PHY_TRSV_REG21_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0x0, FSD_PCIE_PHY_TRSV_REG22_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0x93, FSD_PCIE_PHY_TRSV_REG23_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0x1, FSD_PCIE_PHY_TRSV_REG24_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0x0, FSD_PCIE_PHY_TRSV_REG25_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0x0, FSD_PCIE_PHY_TRSV_REG26_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0x0, FSD_PCIE_PHY_TRSV_REG27_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0x0, FSD_PCIE_PHY_TRSV_REG28_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, pdata->phy_trsv_reg29_val,
+			FSD_PCIE_PHY_TRSV_REG29_LN_N);
+	fsd_pcie_phy_writel(phy_ctrl, 0x0, FSD_PCIE_PHY_TRSV_REG30_LN_N);
+
+	regmap_update_bits(phy_ctrl->sysreg, pdata->phy_con,
+			pdata->phy_cmn_rstn_mask, pdata->phy_cmn_rstn);
+
+	return 0;
+}
+
+static int fsd_pcie_phy_reset(struct phy *phy)
+{
+	struct fsd_pcie_phy *phy_ctrl = phy_get_drvdata(phy);
+	struct fsd_pcie_phy_n_pdata *pdata = phy_ctrl->pdata;
+
+	writel(0x1, phy_ctrl->pcs_base + PCIE_PCS_CLK);
+
+	regmap_update_bits(phy_ctrl->sysreg, pdata->phy_con, pdata->phy_con_mask,
+			   0x0);
+	regmap_update_bits(phy_ctrl->sysreg, pdata->phy_con, pdata->phy_aux_en_mask,
+			   pdata->phy_aux_en);
+	regmap_update_bits(phy_ctrl->sysreg, pdata->phy_con, pdata->phy_ref_sel_mask,
+			   pdata->phy_ref_sel);
+
+	/* Perform Init Reset Release */
+	regmap_update_bits(phy_ctrl->sysreg, pdata->phy_con,
+			pdata->phy_init_rstn_mask, pdata->phy_init_rstn);
+	return 0;
+}
+
+static const struct phy_ops fsd_phy_ops = {
+	.init		= fsd_pcie_phy_init,
+	.reset		= fsd_pcie_phy_reset,
+	.owner		= THIS_MODULE,
+};
+
+static const struct fsd_pcie_phy_data fsd_pcie_phy = {
+	.ops		= &fsd_phy_ops,
+	.phy0_pdata	= &fsd_phy0_con,
+	.phy1_pdata	= &fsd_phy1_con,
+};
+
+static const struct of_device_id fsd_pcie_phy_match[] = {
+	{
+		.compatible = "tesla,fsd-pcie-phy",
+		.data = &fsd_pcie_phy,
+	},
+	{},
+};
+
+static int fsd_pcie_phy_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct device *dev = &pdev->dev;
+	struct fsd_pcie_phy *fsd_phy;
+	struct phy *generic_phy;
+	struct phy_provider *phy_provider;
+	struct resource *res;
+	const struct fsd_pcie_phy_data *drv_data;
+	struct regmap *sysreg;
+	struct fsd_pcie_phy_n_pdata *pdata;
+
+	drv_data = of_device_get_match_data(dev);
+	if (!drv_data)
+		return -ENODEV;
+
+	fsd_phy = devm_kzalloc(dev, sizeof(*fsd_phy), GFP_KERNEL);
+	if (!fsd_phy)
+		return -ENOMEM;
+
+	fsd_phy->phy_id = of_alias_get_id(dev->of_node, "pciephy");
+	if (fsd_phy->phy_id == 0)
+		fsd_phy->pdata = drv_data->phy0_pdata;
+	else
+		fsd_phy->pdata = drv_data->phy1_pdata;
+	pdata = fsd_phy->pdata;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	fsd_phy->phy_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(fsd_phy->phy_base)) {
+		dev_err(dev, "Failed to get phy_base resource\n");
+		ret = PTR_ERR(fsd_phy->phy_base);
+		goto fail_get_resource;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	fsd_phy->pcs_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(fsd_phy->pcs_base)) {
+		dev_err(dev, "Failed to get pcs_base resource\n");
+		ret = PTR_ERR(fsd_phy->pcs_base);
+		goto fail_get_resource;
+	}
+
+	/* sysreg regmap handle */
+	fsd_phy->sysreg = syscon_regmap_lookup_by_phandle(dev->of_node,
+			"tesla,pcie-sysreg");
+	if (IS_ERR(fsd_phy->sysreg)) {
+		dev_err(dev, "pcie sysreg regmap lookup failed.\n");
+		ret = PTR_ERR(fsd_phy->sysreg);
+		goto fail_get_resource;
+	}
+
+	/* Bifurcation/Aggregation configuration */
+	if (of_property_read_u32(dev->of_node, "phy-mode",
+				&fsd_phy->bifurcation_mode)) {
+		dev_err(dev, "Failed selecting the phy-mode\n");
+		ret = -EINVAL;
+		goto fail_get_resource;
+	}
+	dev_info(dev, "property phy-mode from u32 : %x\n", fsd_phy->bifurcation_mode);
+
+	sysreg = fsd_phy->sysreg;
+	fsd_phy->drv_data = drv_data;
+
+	generic_phy = devm_phy_create(dev, dev->of_node, drv_data->ops);
+	if (IS_ERR(generic_phy)) {
+		dev_err(dev, "Failed to create PHY\n");
+		ret = PTR_ERR(generic_phy);
+		goto fail_get_resource;
+	}
+
+	phy_set_drvdata(generic_phy, fsd_phy);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider)) {
+		dev_err(dev, "Failed to register phy provider\n");
+		ret = PTR_ERR_OR_ZERO(phy_provider);
+		goto fail_phy_provider;
+	}
+
+	writel(0x1, fsd_phy->pcs_base + PCIE_PCS_CLK);
+
+	regmap_update_bits(sysreg, pdata->phy_con, pdata->phy_con_mask,
+			   0x0);
+	regmap_update_bits(sysreg, pdata->phy_con, pdata->phy_aux_en_mask,
+			   pdata->phy_aux_en);
+	regmap_update_bits(sysreg, pdata->phy_con, pdata->phy_ref_sel_mask,
+			   pdata->phy_ref_sel);
+
+	/* Perform Init Reset Release */
+	regmap_update_bits(sysreg, pdata->phy_con, pdata->phy_init_rstn_mask,
+			   pdata->phy_init_rstn);
+
+	dev_info(dev, "PCIe PHY%d Probe Successful\n", fsd_phy->phy_id);
+
+	return 0;
+fail_phy_provider:
+	devm_phy_destroy(dev, generic_phy);
+fail_get_resource:
+	return ret;
+}
+
+static struct platform_driver fsd_pcie_phy_driver = {
+	.probe	= fsd_pcie_phy_probe,
+	.driver = {
+		.of_match_table	= fsd_pcie_phy_match,
+		.name		= "fsd_pcie_phy",
+	}
+};
+
+builtin_platform_driver(fsd_pcie_phy_driver);
-- 
2.17.1

