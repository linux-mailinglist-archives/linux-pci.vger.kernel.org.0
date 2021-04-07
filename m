Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107CA3561B5
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 05:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348233AbhDGDEY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 23:04:24 -0400
Received: from mail-db8eur05on2062.outbound.protection.outlook.com ([40.107.20.62]:58081
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348239AbhDGDEU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 23:04:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3MUAseOhsuzQeDiWeurAkUuM7fHY/0zZCK0yJqtsikQ/kJYagXvU6GRgpViTBsZPGHXoSWbFN7JEMMIpd+QahRAV/kbeQSI8VBK6nVZgYZhlX+ufLhWqagGO1VlMRX6k497yHi6Zx+YWm6LfiOOwREv8FzW/Y6VTke3lbcLSTk5IIHQ01qHBaA2YZTn4/MN0DCz4OCn9J3ziBLfyj0dIkrXI5j7oWxKemdEmsPkc5jZ1k1jjsS9YhCHFB1/RakM3SjOpRjMUP5kzho0CO/uVJXCi+TxjxixKq+CV7plg7irmn4aGi7CGUvDXyPaA/QI70OP3xsLFBDU2gAaKYV7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Nen2MkSeP9u0nEVDkFJAkaomeZeBN/3fvmSwcPp5JE=;
 b=N9e7BZk2DoDoW8kXAUelGrvMS9ZDfjkeN2mSC029pijjpqd6XFD3eOk/gm7h5geGuocgr02vwj4vCB8PZLkDcUnx8P5CwqJBCKwdZhWw1Ws8V5RzTDXDAsgqjWShtO5ze8Q79nd31qS+3xD86ZcI6BNq343zUL6EvmfacPrHlw0VHfFVzn5QWQs5Ck0+Ni8Ei4gniZCfwD45p2CmlHXo5qjnXkIigtdxJODk6Bw/V3f0vQg/SbM0wfjebn0mQ+ZuFtDi+5+FBpygaGXNohBnEtTzdYL3DUW06BsSvXACYslvQqkW7AAKQLoCV+fqE1ke2P0137OyNWNwowiWpycjGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Nen2MkSeP9u0nEVDkFJAkaomeZeBN/3fvmSwcPp5JE=;
 b=YcIvgmL7AgVKNE10wvZlpLgIeksBcAplX3v0GcuFrf/NwaLzrus7v8U+HY6naDfoOdVLAqDo5LCZET6hZAIm/WZ1mpWEDPSU+SH+v2vUNb1f8qDRE1L5dp/JEoe7PFjBLmMKEX32i9jRMrY6ITrsqtW1cYN7twKNt5WHoV84Jhk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR04MB3276.eurprd04.prod.outlook.com (2603:10a6:7:22::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Wed, 7 Apr
 2021 03:04:08 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc%3]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 03:04:08 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv5 6/6] PCI: layerscape: Add power management support
Date:   Wed,  7 Apr 2021 11:09:48 +0800
Message-Id: <20210407030948.3845-7-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210407030948.3845-1-Zhiqiang.Hou@nxp.com>
References: <20210407030948.3845-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::26) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 03:04:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b83a7a9e-2c61-4c43-5577-08d8f971cf96
X-MS-TrafficTypeDiagnostic: HE1PR04MB3276:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR04MB327687FD2FBE11C4B50D00A484759@HE1PR04MB3276.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3y+34pqQ0vMnVi3XGrfsMhNqDkuOP0lg/3DPk1zCWbyaFl3Hmd239+AdfWlz7QuXb3pVikdnKdyV5VlWdreSki+2RoTWajXdz1MOAa/+VowBpRpA52sU4+eg7t7+iA732C7SpAdXWxMOB1MSE3glW8/7S1Losbw9pl0oeHS7yYy5wzDRcsGVQ17pxi5n4MgBvxBtXp8fhogSNp6JwsW4BBoTu93UXvlf91Cq/6reFnnel8awdHsvoHaBYzDpJjHQZjsKbFweqXqaaN5t4jmW5LJncKdLreBe+6YZF/Vr1e+M5TuPnwJsWeiUuW274ChEQF/iaXN60+ypuwm8gqL8NOrDp2GXA2pkmEH/3Rt2ZkP0P9h7nr82iyINnLSD6Jo7te6mQgIEtlVrpGxyZ4r6z7/3DtbwLXO4CwMwGKoB0lXFTLXqygFtgWj6Icx09gEWY/2X5ywwBzil9Bsrdme6fTaeJ1A8ihvaCHSY0qYkugqhzt/OifPMjt3ABNz7HNv1Bugfh0J1Cw1Qxr/JxCa68yYg5Gtr89AglCQ7FVDw6E5ht4QLIZnGvTLUQ4ciP1X0OfoBNWxSTxvBzOv14WEqYKtxVPGwrSaXUr9++FU6MBh89cmVyB3sBqK22FYMsFweQs+mDxdq4znCusqC2lsG9c7A5RRluwel+/bxzl7/8ZbAGlPwBqvkuQ/tYsdxv4ZuUt4lmLoNgp39bBUkfZ02p/FT6IXEW987ZguTTf5ejJ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(4326008)(6506007)(36756003)(38350700001)(26005)(2906002)(6666004)(6486002)(1076003)(66476007)(16526019)(186003)(66556008)(956004)(86362001)(66946007)(38100700001)(69590400012)(316002)(6512007)(83380400001)(478600001)(8936002)(2616005)(8676002)(30864003)(5660300002)(52116002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ArSDDARmna/dVDqmRvFnRpIV+ZVdxHom1XAAwCJ/CZwBrSIPDnIsDdf9LpXX?=
 =?us-ascii?Q?BOWDs3KFGpoxMucKEumdW0Qg8bZGUsodBVvkT4WqcQgk8R/sXbG3wCXxHYHt?=
 =?us-ascii?Q?vSl8RyJmTw8f6G5a1b56kLg+4cgT48TeOXXr075q9i+UDhoVVbJQ7Cuvpl6v?=
 =?us-ascii?Q?kx1wlMh4odys7aScq+y0GhUuVpDsbRDT+swgjEjSDiAeD7OoJ3/riKE9s8X3?=
 =?us-ascii?Q?E4Lj32EvoC/IjorH9ZaaeucHXhvH+yk/d9jha243gG8g/AAQZ/VYbM24W6Ed?=
 =?us-ascii?Q?Hik2mIp6LTr4Sl4/+zb/O8UBtuut7QWsjfq0uCVld/gcMYnm1FzK7Qi4eXWQ?=
 =?us-ascii?Q?8qK0LUzBFhTXXSP3x6WB9WkKkJZXrIunvVPwL7IO7Y+TzYzBabBJsDm/txVI?=
 =?us-ascii?Q?rkB8+9xRxz1BdKeJCRvy426pIGUCx/pXiHrCnM8d3M4gDUt4oJjYf+S91V3o?=
 =?us-ascii?Q?MS4y6q1f0+m5A1zTRI7Rcn8SEVd+2zcjrZDHYlDzyRVLSvEUlvmlzYYsXu+N?=
 =?us-ascii?Q?ylqLJxEWMtO9u/9aMD4hewcNG2TpB90aWQwjdsI7iBta6tUXwXMUbhhCS03b?=
 =?us-ascii?Q?VfTjMNnuWtEW0Ucx4IF5n5utLZ6Bnf4MZQKkbk4JehaHMCgkQ95gPwJVkauy?=
 =?us-ascii?Q?e87F1lZckJi+dqt8l5b9vjH5nyJ5WthoHJGpzQE4qsJpgnpRWJlgpshbWay7?=
 =?us-ascii?Q?OtYBza3IXuRYGp5liUABuYsxO9ybpjrkC+UxU3uxrsR7c8zweLb6+JhHGQBJ?=
 =?us-ascii?Q?0BsLvSUPRgh2vNQ60JiAKJg1Q9xeyWp/kO9tNJpyRhUY/qG4xtF02N9Iq4kb?=
 =?us-ascii?Q?FTgemcoptwIr24hIo7W7yzjNrSTyGLVdv5HlJejhle1hkJ4U6Ha8DHV4vGlY?=
 =?us-ascii?Q?DFlLN8btNk6R2tdNUfWM+3JVzsDCNYpNOXzK68vQE6B013UewDdHq1FPEg/J?=
 =?us-ascii?Q?nlnAz6TA7nCwxLw1dgctbBqeyY9ceYpzeI8pcMr93des5JRL2EDpMV0eWBVx?=
 =?us-ascii?Q?cMwSMLxvSLVvYsS0nJRXGXUtgV2ubZmGW7OEG/QT+kAS/z18knZv16pbqA0n?=
 =?us-ascii?Q?n4cHlidKCw8uiiXdGatSOzLS2i3RLnyCilmpVoD/bL6RN48xf3B1HMi81YYJ?=
 =?us-ascii?Q?xK8rHofNrUAW9c9T5WKW5D5bWCA3OmgA04IAX2DNk47PbkfJpFA/RTQYJi5Y?=
 =?us-ascii?Q?ZvJA1LgYWvzW8YIVL1K+yzOR9hx/18v3zN+U+PWfi+T/4RGw2gzOSTjouipk?=
 =?us-ascii?Q?ise4p+ecs2jSd4pPJnyHX1lso/8q1yrrsWcy0PpJ0UkHN0+ohtKGc+J5tQn7?=
 =?us-ascii?Q?lzq7KHxJFkzoi4E06uyr3xhb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83a7a9e-2c61-4c43-5577-08d8f971cf96
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 03:04:08.7758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DJTvmhbCDuDPk323rTfciJjYHnAAfVWnB/5suSLpD8Br0XNMM1tUPkL8Z3U8USSTO7WpCDXPwVMERM8vlJMQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3276
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add PME_Turn_Off/PME_TO_Ack handshake sequence, and finally
put the PCIe controller into D3 state after the L2/L3 ready
state transition process completion.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V5:
 - Fix a typo of the parameter given to function dw_pcie_setup_rc()

 drivers/pci/controller/dwc/pci-layerscape.c  | 382 ++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h |   1 +
 2 files changed, 381 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index 71911ca4c589..868e18b12e4a 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -3,13 +3,16 @@
  * PCIe host controller driver for Freescale Layerscape SoCs
  *
  * Copyright (C) 2014 Freescale Semiconductor.
+ * Copyright 2020 NXP
  *
  * Author: Minghuan Lian <Minghuan.Lian@freescale.com>
  */
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/iopoll.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/of_irq.h>
@@ -27,17 +30,60 @@
 #define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
 #define PCIE_ABSERR_SETTING	0x9401 /* Forward error of non-posted request */
 
+/* PF Message Command Register */
+#define LS_PCIE_PF_MCR		0x2c
+#define PF_MCR_PTOMR		BIT(0)
+#define PF_MCR_EXL2S		BIT(1)
+
+/* LS1021A PEXn PM Write Control Register */
+#define SCFG_PEXPMWRCR(idx)	(0x5c + (idx) * 0x64)
+#define PMXMTTURNOFF		BIT(31)
+#define SCFG_PEXSFTRSTCR	0x190
+#define PEXSR(idx)		BIT(idx)
+
+/* LS1043A PEX PME control register */
+#define SCFG_PEXPMECR		0x144
+#define PEXPME(idx)		BIT(31 - (idx) * 4)
+
+/* LS1043A PEX LUT debug register */
+#define LS_PCIE_LDBG	0x7fc
+#define LDBG_SR		BIT(30)
+#define LDBG_WE		BIT(31)
+
 #define PCIE_IATU_NUM		6
 
+#define LS_PCIE_IS_L2(v)	\
+	(((v) & PORT_LOGIC_LTSSM_STATE_MASK) == PORT_LOGIC_LTSSM_STATE_L2)
+
+struct ls_pcie;
+
+struct ls_pcie_host_pm_ops {
+	int (*pm_init)(struct ls_pcie *pcie);
+	void (*send_turn_off_message)(struct ls_pcie *pcie);
+	void (*exit_from_l2)(struct ls_pcie *pcie);
+};
+
 struct ls_pcie_drvdata {
+	const u32 pf_off;
+	const u32 lut_off;
 	const struct dw_pcie_host_ops *ops;
+	const struct ls_pcie_host_pm_ops *pm_ops;
 };
 
 struct ls_pcie {
 	struct dw_pcie *pci;
 	const struct ls_pcie_drvdata *drvdata;
+	void __iomem *pf_base;
+	void __iomem *lut_base;
+	bool big_endian;
+	bool ep_presence;
+	bool pm_support;
+	struct regmap *scfg;
+	int index;
 };
 
+#define ls_pcie_lut_readl_addr(addr)	ls_pcie_lut_readl(pcie, addr)
+#define ls_pcie_pf_readl_addr(addr)	ls_pcie_pf_readl(pcie, addr)
 #define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
 
 static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
@@ -78,6 +124,210 @@ static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
 	iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
 }
 
+static u32 ls_pcie_lut_readl(struct ls_pcie *pcie, u32 off)
+{
+	if (pcie->big_endian)
+		return ioread32be(pcie->lut_base + off);
+
+	return ioread32(pcie->lut_base + off);
+}
+
+static void ls_pcie_lut_writel(struct ls_pcie *pcie, u32 off, u32 val)
+{
+	if (pcie->big_endian)
+		return iowrite32be(val, pcie->lut_base + off);
+
+	return iowrite32(val, pcie->lut_base + off);
+
+}
+
+static u32 ls_pcie_pf_readl(struct ls_pcie *pcie, u32 off)
+{
+	if (pcie->big_endian)
+		return ioread32be(pcie->pf_base + off);
+
+	return ioread32(pcie->pf_base + off);
+}
+
+static void ls_pcie_pf_writel(struct ls_pcie *pcie, u32 off, u32 val)
+{
+	if (pcie->big_endian)
+		return iowrite32be(val, pcie->pf_base + off);
+
+	return iowrite32(val, pcie->pf_base + off);
+
+}
+
+static void ls_pcie_send_turnoff_msg(struct ls_pcie *pcie)
+{
+	u32 val;
+	int ret;
+
+	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
+	val |= PF_MCR_PTOMR;
+	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
+
+	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
+				 val, !(val & PF_MCR_PTOMR), 100, 10000);
+	if (ret)
+		dev_info(pcie->pci->dev, "poll turn off message timeout\n");
+}
+
+static void ls1021a_pcie_send_turnoff_msg(struct ls_pcie *pcie)
+{
+	u32 val;
+
+	if (!pcie->scfg) {
+		dev_dbg(pcie->pci->dev, "SYSCFG is NULL\n");
+		return;
+	}
+
+	/* Send Turn_off message */
+	regmap_read(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), &val);
+	val |= PMXMTTURNOFF;
+	regmap_write(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), val);
+
+	mdelay(10);
+
+	/* Clear Turn_off message */
+	regmap_read(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), &val);
+	val &= ~PMXMTTURNOFF;
+	regmap_write(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), val);
+}
+
+static void ls1043a_pcie_send_turnoff_msg(struct ls_pcie *pcie)
+{
+	u32 val;
+
+	if (!pcie->scfg) {
+		dev_dbg(pcie->pci->dev, "SYSCFG is NULL\n");
+		return;
+	}
+
+	/* Send Turn_off message */
+	regmap_read(pcie->scfg, SCFG_PEXPMECR, &val);
+	val |= PEXPME(pcie->index);
+	regmap_write(pcie->scfg, SCFG_PEXPMECR, val);
+
+	mdelay(10);
+
+	/* Clear Turn_off message */
+	regmap_read(pcie->scfg, SCFG_PEXPMECR, &val);
+	val &= ~PEXPME(pcie->index);
+	regmap_write(pcie->scfg, SCFG_PEXPMECR, val);
+}
+
+static void ls_pcie_exit_from_l2(struct ls_pcie *pcie)
+{
+	u32 val;
+	int ret;
+
+	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
+	val |= PF_MCR_EXL2S;
+	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
+
+	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
+				 val, !(val & PF_MCR_EXL2S), 100, 10000);
+	if (ret)
+		dev_info(pcie->pci->dev, "poll exit L2 state timeout\n");
+}
+
+static void ls_pcie_retrain_link(struct ls_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u32 val;
+
+	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL);
+	val |= PCI_EXP_LNKCTL_RL;
+	dw_pcie_writew_dbi(pci, offset + PCI_EXP_LNKCTL, val);
+}
+
+static void ls1021a_pcie_exit_from_l2(struct ls_pcie *pcie)
+{
+	u32 val;
+
+	regmap_read(pcie->scfg, SCFG_PEXSFTRSTCR, &val);
+	val |= PEXSR(pcie->index);
+	regmap_write(pcie->scfg, SCFG_PEXSFTRSTCR, val);
+
+	regmap_read(pcie->scfg, SCFG_PEXSFTRSTCR, &val);
+	val &= ~PEXSR(pcie->index);
+	regmap_write(pcie->scfg, SCFG_PEXSFTRSTCR, val);
+
+	mdelay(1);
+
+	ls_pcie_retrain_link(pcie);
+}
+static void ls1043a_pcie_exit_from_l2(struct ls_pcie *pcie)
+{
+	u32 val;
+
+	val = ls_pcie_lut_readl(pcie, LS_PCIE_LDBG);
+	val |= LDBG_WE;
+	ls_pcie_lut_writel(pcie, LS_PCIE_LDBG, val);
+
+	val = ls_pcie_lut_readl(pcie, LS_PCIE_LDBG);
+	val |= LDBG_SR;
+	ls_pcie_lut_writel(pcie, LS_PCIE_LDBG, val);
+
+	val = ls_pcie_lut_readl(pcie, LS_PCIE_LDBG);
+	val &= ~LDBG_SR;
+	ls_pcie_lut_writel(pcie, LS_PCIE_LDBG, val);
+
+	val = ls_pcie_lut_readl(pcie, LS_PCIE_LDBG);
+	val &= ~LDBG_WE;
+	ls_pcie_lut_writel(pcie, LS_PCIE_LDBG, val);
+
+	mdelay(1);
+
+	ls_pcie_retrain_link(pcie);
+}
+
+static int ls1021a_pcie_pm_init(struct ls_pcie *pcie)
+{
+	struct device *dev = pcie->pci->dev;
+	u32 index[2];
+	int ret;
+
+	pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node,
+						     "fsl,pcie-scfg");
+	if (IS_ERR(pcie->scfg)) {
+		ret = PTR_ERR(pcie->scfg);
+		dev_err(dev, "No syscfg phandle specified\n");
+		pcie->scfg = NULL;
+		return ret;
+	}
+
+	ret = of_property_read_u32_array(dev->of_node, "fsl,pcie-scfg",
+					 index, 2);
+	if (ret) {
+		pcie->scfg = NULL;
+		return ret;
+	}
+
+	pcie->index = index[1];
+
+	return 0;
+}
+
+static int ls_pcie_pm_init(struct ls_pcie *pcie)
+{
+	return 0;
+}
+
+static void ls_pcie_set_dstate(struct ls_pcie *pcie, u32 dstate)
+{
+	struct dw_pcie *pci = pcie->pci;
+	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_PM);
+	u32 val;
+
+	val = dw_pcie_readw_dbi(pci, offset + PCI_PM_CTRL);
+	val &= ~PCI_PM_CTRL_STATE_MASK;
+	val |= dstate;
+	dw_pcie_writew_dbi(pci, offset + PCI_PM_CTRL, val);
+}
+
 static int ls_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -91,22 +341,63 @@ static int ls_pcie_host_init(struct pcie_port *pp)
 
 	ls_pcie_drop_msg_tlp(pcie);
 
+	if (dw_pcie_link_up(pci)) {
+		dev_dbg(pci->dev, "Endpoint is present\n");
+		pcie->ep_presence = true;
+	}
+
+	if (pcie->drvdata->pm_ops && pcie->drvdata->pm_ops->pm_init &&
+	    !pcie->drvdata->pm_ops->pm_init(pcie))
+		pcie->pm_support = true;
+
 	return 0;
 }
 
+static struct ls_pcie_host_pm_ops ls1021a_pcie_host_pm_ops = {
+	.pm_init = &ls1021a_pcie_pm_init,
+	.send_turn_off_message = &ls1021a_pcie_send_turnoff_msg,
+	.exit_from_l2 = &ls1021a_pcie_exit_from_l2,
+};
+
+static struct ls_pcie_host_pm_ops ls1043a_pcie_host_pm_ops = {
+	.pm_init = &ls1021a_pcie_pm_init,
+	.send_turn_off_message = &ls1043a_pcie_send_turnoff_msg,
+	.exit_from_l2 = &ls1043a_pcie_exit_from_l2,
+};
+
+static struct ls_pcie_host_pm_ops ls_pcie_host_pm_ops = {
+	.pm_init = &ls_pcie_pm_init,
+	.send_turn_off_message = &ls_pcie_send_turnoff_msg,
+	.exit_from_l2 = &ls_pcie_exit_from_l2,
+};
+
 static const struct dw_pcie_host_ops ls_pcie_host_ops = {
 	.host_init = ls_pcie_host_init,
 };
 
+static const struct ls_pcie_drvdata ls1021a_drvdata = {
+	.ops = &ls_pcie_host_ops,
+	.pm_ops = &ls1021a_pcie_host_pm_ops,
+};
+
+static const struct ls_pcie_drvdata ls1043a_drvdata = {
+	.ops = &ls_pcie_host_ops,
+	.lut_off = 0x10000,
+	.pm_ops = &ls1043a_pcie_host_pm_ops,
+};
+
 static const struct ls_pcie_drvdata layerscape_drvdata = {
 	.ops = &ls_pcie_host_ops,
+	.lut_off = 0x80000,
+	.pf_off = 0xc0000,
+	.pm_ops = &ls_pcie_host_pm_ops,
 };
 
 static const struct of_device_id ls_pcie_of_match[] = {
 	{ .compatible = "fsl,ls1012a-pcie", .data = &layerscape_drvdata },
-	{ .compatible = "fsl,ls1021a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021a_drvdata },
 	{ .compatible = "fsl,ls1028a-pcie", .data = &layerscape_drvdata },
-	{ .compatible = "fsl,ls1043a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043a_drvdata },
 	{ .compatible = "fsl,ls1046a-pcie", .data = &layerscape_drvdata },
 	{ .compatible = "fsl,ls2080a-pcie", .data = &layerscape_drvdata },
 	{ .compatible = "fsl,ls2085a-pcie", .data = &layerscape_drvdata },
@@ -142,6 +433,14 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
 
+	pcie->big_endian = of_property_read_bool(dev->of_node, "big-endian");
+
+	if (pcie->drvdata->lut_off)
+		pcie->lut_base = pci->dbi_base + pcie->drvdata->lut_off;
+
+	if (pcie->drvdata->pf_off)
+		pcie->pf_base = pci->dbi_base + pcie->drvdata->pf_off;
+
 	if (!ls_pcie_is_bridge(pcie))
 		return -ENODEV;
 
@@ -150,12 +449,91 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	return dw_pcie_host_init(&pci->pp);
 }
 
+static bool ls_pcie_pm_check(struct ls_pcie *pcie)
+{
+	if (!pcie->ep_presence) {
+		dev_dbg(pcie->pci->dev, "Endpoint isn't present\n");
+		return false;
+	}
+
+	if (!pcie->pm_support)
+		return false;
+
+	return true;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int ls_pcie_suspend_noirq(struct device *dev)
+{
+	struct ls_pcie *pcie = dev_get_drvdata(dev);
+	struct dw_pcie *pci = pcie->pci;
+	u32 val;
+	int ret;
+
+	if (!ls_pcie_pm_check(pcie))
+		return 0;
+
+	pcie->drvdata->pm_ops->send_turn_off_message(pcie);
+
+	/* 10ms timeout to check L2 ready */
+	ret = readl_poll_timeout(pci->dbi_base + PCIE_PORT_DEBUG0,
+				 val, LS_PCIE_IS_L2(val), 100, 10000);
+	if (ret) {
+		dev_err(dev, "PCIe link enter L2 timeout! ltssm = 0x%x\n", val);
+		return ret;
+	}
+
+	ls_pcie_set_dstate(pcie, 0x3);
+
+	return 0;
+}
+
+static int ls_pcie_resume_noirq(struct device *dev)
+{
+	struct ls_pcie *pcie = dev_get_drvdata(dev);
+	struct dw_pcie *pci = pcie->pci;
+	int ret;
+
+	if (!ls_pcie_pm_check(pcie))
+		return 0;
+
+	ls_pcie_set_dstate(pcie, 0x0);
+
+	pcie->drvdata->pm_ops->exit_from_l2(pcie);
+
+	dw_pcie_setup_rc(&pci->pp);
+
+	/* delay 10 ms to access EP */
+	mdelay(10);
+
+	ret = ls_pcie_host_init(&pci->pp);
+	if (ret) {
+		dev_err(dev, "ls_pcie_host_init failed! ret = 0x%x\n", ret);
+		return ret;
+	}
+
+	ret = dw_pcie_wait_for_link(pci);
+	if (ret) {
+		dev_err(dev, "wait link up timeout! ret = 0x%x\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops ls_pcie_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(ls_pcie_suspend_noirq,
+				      ls_pcie_resume_noirq)
+};
+
 static struct platform_driver ls_pcie_driver = {
 	.probe = ls_pcie_probe,
 	.driver = {
 		.name = "layerscape-pcie",
 		.of_match_table = ls_pcie_of_match,
 		.suppress_bind_attrs = true,
+		.pm = &ls_pcie_pm_ops,
 	},
 };
 builtin_platform_driver(ls_pcie_driver);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 7247c8b01f04..067b48a07100 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -54,6 +54,7 @@
 #define PCIE_PORT_DEBUG0		0x728
 #define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
 #define PORT_LOGIC_LTSSM_STATE_L0	0x11
+#define PORT_LOGIC_LTSSM_STATE_L2	0x15
 #define PCIE_PORT_DEBUG1		0x72C
 #define PCIE_PORT_DEBUG1_LINK_UP		BIT(4)
 #define PCIE_PORT_DEBUG1_LINK_IN_TRAINING	BIT(29)
-- 
2.17.1

