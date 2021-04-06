Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B9A354F45
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 10:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244761AbhDFI7T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 04:59:19 -0400
Received: from mail-db8eur05on2060.outbound.protection.outlook.com ([40.107.20.60]:53530
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244714AbhDFI7Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 04:59:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bACBmcrYzSEHeGBxajskPNuuBkeJ0vlMqDgMwGA0EdI6EcUL9hoaYrfpDluyMZ+78mP3oh1aYaE7Y1Lt9+Xw4Ye2Cj/uDJJO/OMLB9byleRl1ux469YOGW3juc4kqwVGDqde4bCX/EFih573+ypX2DOfaIsTzYm9EzVteoWJcWlV6YP3AA8to6a3DhwbWJnyykCfoj3TFfKS5PZIioNE5phY88C8i1KaAd9qjEA9oR78sBceMqR3IYhMyZp4Hs1jmqMWD3pHAk6+VaQ9cpdLFxsd4JvpIM72uXM/QKzL7KnezrlY8IRxrr1kZYXz0q3GYqT/jy0GAlqfC52WUJoxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPgzEZqo7rmWmzgziVNUQf2GW0RUou58ahNTTbYZ77E=;
 b=Cx7JQl02MNis2hWIs9JTawc/x8kiJ3ETbQ8ZRz8OZ0XvTIAPYZlUgRIX5GLrvSI8Ivq8xakgqfVfAUjN+0DXhtBAslFgUfJfBPOLZgrIVGmNxL54iMDp9rTi/V+OLvja72HChTp2qj+WNsxZlHxHuUnPJrLZ6+MqNq5MbFNkTK2ZUUH+f17iD+BYcf6cp+zUZZA5kCufwQO2GbqX3fs55NEn5b7JyXEXo7kmqAS2NgCWb76Gj1y1OOcmcyeRtXUgChjkAtOETv6WEZjEZyFuM6gLpSdnSlFSF9sRFlSYatgqa7kwyw1Z/5ntDclJoXwljsA5zECgt1VD5eLbooyG3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPgzEZqo7rmWmzgziVNUQf2GW0RUou58ahNTTbYZ77E=;
 b=av9cAEwJFz5qYoYm7fuwR4IXpLd86gvlnT/0jxnX5ycaCV5An0rcGgLf/dMl9+WqwuZ3vTdrFG4MKf9zTQy5oT4htyo1agO0hGgEOdNnmu5t4a4+Op/3C1mNFWvxhSHMNasUblRK7qgkI3kD/FQ6N1v6waC4bQgdcoltNINcPfI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0401MB2652.eurprd04.prod.outlook.com (2603:10a6:3:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 08:59:05 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc%3]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 08:59:05 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv4 6/6] PCI: layerscape: Add power management support
Date:   Tue,  6 Apr 2021 17:04:49 +0800
Message-Id: <20210406090449.36352-7-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210406090449.36352-1-Zhiqiang.Hou@nxp.com>
References: <20210406090449.36352-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: HK2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:202:2e::13) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by HK2PR06CA0001.apcprd06.prod.outlook.com (2603:1096:202:2e::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Tue, 6 Apr 2021 08:58:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d04a20ab-b143-419a-6096-08d8f8da3635
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2652:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2652915968998BB1D2F9C30684769@HE1PR0401MB2652.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U0u4V7r9Q5J9S1Pct/dYJqSQ2n3SG1vQZ06jEe99HyzlRn6vKWTyeBCOFhDNPZCIRtDZ1RullwT7wSJVuCPS8WuAm1vfcQHO/ET8rcCbHfSx3o3WpK2b9dIDFQJfmGPEj6TK5Z0wOS5u3x+YLjU9YpIDwHlUA3BZtAcn3qGNZCNmarx2ab20DDrvRS7mb7q+2pYn6Xkdy1CDOsAJIlIcKml6LxYBO6ILTCuRloF4zUpxlIEvQvoR5AIDMrZH3G7NugR0zPqhQAoi3Z8s91PFwf+kJo5496QwzZXV3Cz8fuc3MuF4zXTpwH3NAYUPN3v4MBHOnZWgEI6h+K6vJbri0iwAz4p/w5S5VRTmeKB5oBzSlFL1hde+x1iQ9lhVdTgoEb0LCuUeFSJmnHyCmWzte+P0bM1QMUQA7+N+m6ejN1Vy57CYiiX2IceBlIkPoyw/fbsZn+L2qTzuXyoxKLpKhnVbByYZcp60F8i1DeMKJGHdlP64Nl6JITmKbSWUpQT7nppfuZbqgd41IZYCkU4QZxty7zGVA6feuM+0AGTcWVy1EYxYu1rXOoRQzv08+/QgJeFu5PT30Tr5JCb9iC+pvZLzGtJMWvnx/TOIWGv7MCECZxNeq+lRja28dXKATru8MTYSXaevCVJsriMFAyuakyklQbvEIc32lBU56f9jaSrzjU005XEHrBPQPUmi2ovw44ftgW8S5exEsHfI0PQn2zkHQlWVK8nYu7u1iV+c0Ioiv8mPGx5l2FhEpxv5Yu/Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(26005)(69590400012)(5660300002)(2906002)(1076003)(6506007)(30864003)(66946007)(66556008)(66476007)(478600001)(83380400001)(38100700001)(52116002)(4326008)(956004)(16526019)(186003)(2616005)(86362001)(6486002)(316002)(6666004)(8676002)(6512007)(921005)(8936002)(36756003)(38350700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?d/og9xYCZv8C2QXHv9QePZdXy+6kPboDUuYJ9xwA54VyOoMBq/6gbHeLdg03?=
 =?us-ascii?Q?exwXHx4XaB0E0O3Uhfnw4Ud8y8T+4PA2cXo1FS2SOiqZ5f2uN6UIzoImFjn3?=
 =?us-ascii?Q?4hzuFyhsVyO0V0fiXsSSCMirNxCTTaXpOcHCdmeA/7Fs5nPnZs7kOjM61D1F?=
 =?us-ascii?Q?s3FVHvr/S3a6Ck1uoth6MyVuVadR27u+G+5AYkfM5xEgDVxmCjE90OO8ji08?=
 =?us-ascii?Q?0mQJdRGaklWJIm6ZovuIA1zhSSW37Z9Vq14DXmWtNCuUR9ycddxYr3haOk+L?=
 =?us-ascii?Q?fMHkhftzKfrfMBbbptNqADO/eiQ6yVYsW6kYf5zHRl0evmD7CGIe7gdYBHt/?=
 =?us-ascii?Q?R9gvswVGHwmAsNMoN6//UR+S4OmipqkslhLZ5kVshJheJPmOkZfV4JKTYw+9?=
 =?us-ascii?Q?++l1hXAh/M9E5bp5DzSaImLNv7wtx59G5iMqNhWXG5nWXE6K1JaUJ3m5O/qv?=
 =?us-ascii?Q?neUOffnkGzqK0VzCgpfRTtdxhAvQk5qlKJcF+cfuJ8akU8appLYfJEv8kYrx?=
 =?us-ascii?Q?ouVjfk7f731/xnisimhoiOKK7h5NwDBYv5E7yCWWmxH5FSqB+J9FSluygfIK?=
 =?us-ascii?Q?IhnpVczbGHnryzGWXrn+Hzm0qTdUOfw3+NS7hZNHybrY7j/O/JE0wUW9+JO+?=
 =?us-ascii?Q?ZD7sYyuC4URv7cFdN7TOVu8TJL2Syd6M8OdMPFtgjBUEOtgbDdbO14ahOwUm?=
 =?us-ascii?Q?WcT6rz6OlxALP9k1AJ4RfauQq6PEn1JihkmXDX12GqN+70d9ggfnbBpoB051?=
 =?us-ascii?Q?0r5T7JPXYWeBscA0G6EjHGDDzCUSYhqXFdP7EXzdTv9ZQZmrwTwZc99zQMPa?=
 =?us-ascii?Q?LSFpZAVA9r8xFVjoUV287A6YOTYcNqYnVx5STOn2v1Q+/s5IQKSBlQIKAWwX?=
 =?us-ascii?Q?NqoiXt+bgx50/Ftju507pSjurlQQ23TYpSZ5gvOrJMOV3Hlg5cs1OMhl+D59?=
 =?us-ascii?Q?/0CA10Bmydq0NUBIY70g2jJxge9lgpq9CrtmcfiWJTh9ZaaOnGhr/w6fs3Ng?=
 =?us-ascii?Q?v/CSFUpNYt5CXgAxjPRSZj+SSDY/51hBNf9iPTtDmATD7qIn6oITxOlmHodZ?=
 =?us-ascii?Q?eWNjjDuJdd2VTPR3+evfifw+frB9PyvMB7MgfwDHcpCuBNI5jXgGNGqoELu9?=
 =?us-ascii?Q?adTtYij5VvUW+vrAK4SAMBqMp4IUlGv3X6lX4Knc3Yu1TenCgV+lJvQanPqh?=
 =?us-ascii?Q?VzMP9HFTjpoZXFYF+f2entu4EfjvA+/dqBms9YuD2IML2bZpjI+9ZvpHufpy?=
 =?us-ascii?Q?WGqHJqpzTQvV/F9vjZmAIFJher4r9dscHDHcaMd8a+Oi9rIBaZV987MyEPP/?=
 =?us-ascii?Q?HFjjuD8glCcYbPlPOak9tyiB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04a20ab-b143-419a-6096-08d8f8da3635
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 08:58:57.4029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5iJyg7hprKAGdal+gU981+YQRDokOjtoPwqJ6N8NVkJOit4HF1/WnUBN6bPyQN7mt/wtv9VZLqB+84HVXPuzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2652
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add PME_Turn_Off/PME_TO_Ack handshake sequence, and finally
put the PCIe controller into D3 state after the L2/L3 ready
state transition process completion.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V4:
 - Rebased against the latest code base

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
+	dw_pcie_setup_rc(pp);
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

