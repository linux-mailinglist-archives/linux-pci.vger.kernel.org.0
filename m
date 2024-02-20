Return-Path: <linux-pci+bounces-3784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE28C85C131
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 17:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4596AB2262B
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E9C76C6F;
	Tue, 20 Feb 2024 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="avu2VkZU"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2068.outbound.protection.outlook.com [40.107.249.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909267AE7C;
	Tue, 20 Feb 2024 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446052; cv=fail; b=iDPRMrpeEs0zvNfLAGD1o/upxknPOSmZRNC8TeQFtQV5WaQr6tYLJvhhhJ1sa7MQMBajSpfM3jHx9wn6qyhqSlolA/SabgusSDvVle+MLCaqePmjwEX18j3qF+Hk+UuwuiqliEUVpPD2zS3KvV1slhGoE1ZL55aRpM17n7bipAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446052; c=relaxed/simple;
	bh=zBrnjyM3VQW0uVxKxfZ28qssPZISTIow7Y8BfuCA7cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cZbgMM4HOpzFgSuug2vo3OZc695PH89SnkG5VWafWipCrqTHOqI+ogflLd9dCgNUNZmN2hOcDWE22S1v9dh0YOM9ATzYFMZ+U9+C9LcrfYhl5orD6kGJ30M8W4pU/GXVrqDdzM1gFY4wBgLsCpcgTrliptWucGbbsYTSwj8WU40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=avu2VkZU; arc=fail smtp.client-ip=40.107.249.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVhzyQBJo05aiSahThm/U2HWm6c+oy49Um8MnuyiM+kiA3Uvyrfci50WXuD482rE4aI4iCn5gZyXJWsfviija5kP/ypWc/UeKHl2Jsr9MxqMOMGqXggTHJEr6YjPSlyiD+K8mZ/x/alAyv5jVFKc1JXQNwRkX/dszcYPRRhf4BDYzfDVbCyOJob2W0L6I0mlEIsRpUW+AAQQ5wvUw3NQg8PsgC6zbatZ+l2pW4W+9CNVpXEr82a5Pn6ovIB1y2WbPqiDhb5BtcOEpXk7Qwlisa/ud7kpVJ0pCiBEfZy7ZhY0KyCOkpR8vqLHfrBpvoLLaoLqdh+QY0+ZjFaiS+yDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81mSYg5kAevXFgLjg+kio0OZY+mGG496YILz7kVVH+I=;
 b=ZKF9PhfjYxogyqcHv31/0igBkC9WaiMTqHE+5iEwv8aMxp16Xri2bmTOnHWPv6Sr8VHI7cJmhoLlZKszZN+iPgS+GEk8lir8kIhj5a9thOXEvgo4btPWkxLc3BHCbXxZaXlU2k83Kw6aa5sVs2Cu4tG7QSS95YvKCVxaKxo8DxHdBe9zMWDSfSlOacrr5eyaNd5kyGw/KabuxvCsr/LBYka2XrWFNvgX3ZoY2W+H7y7yz3AJyF17uLmofzWbBw3MmehUAUOhkhBUftXHbcuCPEC/DBQWOBeUdwMaftiHgPrFSXnIhLsOwV/oh3eP65ZrHXB0eSzRytAP2CF8Z/DF0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81mSYg5kAevXFgLjg+kio0OZY+mGG496YILz7kVVH+I=;
 b=avu2VkZUQwfXtQlQgGk8zYGHq9ZU87OWBnyhg2TNf9gYC/tyOozvifLU9eMcTEHHqLKPyzITsYRjGuD6Se7+RoajJIKzzubpnP8/vBO8FuW8Rx0miPonDFhEl3hFsQGQi8igaWAibJThU/vpNfAs6P3JvnG92HykgajeXkpXEKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7295.eurprd04.prod.outlook.com (2603:10a6:800:1ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 16:20:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 16:20:47 +0000
From: Frank Li <Frank.Li@nxp.com>
To: lpieralisi@kernel.org
Cc: Frank.li@nxp.com,
	bhelgaas@google.com,
	cassel@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	helgaas@kernel.org,
	hongxing.zhu@nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v11 12/14] PCI: imx6: Add epc_features in imx6_pcie_drvdata
Date: Tue, 20 Feb 2024 11:19:22 -0500
Message-Id: <20240220161924.3871774-13-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220161924.3871774-1-Frank.Li@nxp.com>
References: <20240220161924.3871774-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: dbdff3f7-e48a-4a07-7525-08dc322fe510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KZQUCdv/T+OBKIW/1D49BiTB1Wl2NwEIgAoSboEDyGy3zHIfRjwogYAA3r4yFn37OjGnPHmuiBEOL5C5dqkYGDEVtz4Wo+j7s+XEmsyPuen34mnYQZVfcydCKlA6oY0eSVHBdaxP2XPu5+4omRmXZr3B4MdhFdWypPbtrChovtxHlX0KFPKENpbC/6GExpTQyLKhsfanpXU0MwlX222hlCK0ZJ6not7QNoFZ3KlUTcGmPw5Jm6ejsrUKsCQAyrlxinETWJ/57rOa914R0o/bwkOzjTnRAQW35FEYek6jzCsQv55g4SFDiYRQXgW8aKbqktRghf2BaG5P7S3gSRo0SSS1XKKzBRCqjHyUtJGrGEWTsu9PFJuBwQ1YvHkPlrjtGEPiAZgxmX1GmnIeQQK6O+03cWf5G6917QdTZIIMj0z3I2re55ghJ+73aMj7DZupyj0qLLndXgehF/5hM78IrMDWytcuDfsmWBYdLB9Z03tCPH/igHsnq2CezR/lZTzRG+heO1hsA3c9Bywv1X58gT0PyAqYb8PaD1kTtlj259gqaUZ6/O2MtFhl5wrqSqIbYr2RVB1rwaxcqOkZPFZAZnfkmAkANpP3L8+VNOVt/lrbWWla5a+r07JOMVDZzpnw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yBp75FEf6vkHZCOkjsI0LWziylMygFjz+fSnjumYIFzdSz0MKlCmGrl79VTq?=
 =?us-ascii?Q?/23fxkzOvhAkTx9rA4ms3BJlNuPNLg4D+ib0c9E1y49fEJYzfEE/LzPY3OI6?=
 =?us-ascii?Q?nXynLuyWzdqSWa+6UXl9LhzExgqNn6HWc4wbaen6UnPMyjGPkhmu1l3egcDu?=
 =?us-ascii?Q?26fAnTU+QRC6oQHEeUlAvTfr3KDrGZtJByQRQYdtGUEI9g2wg2xltSr/F9Lt?=
 =?us-ascii?Q?IViQylGi1mDWywIjb+w9dvb+YwMIYRbGLN/YAw/hq7X75RUeyIrd6HJD6CTy?=
 =?us-ascii?Q?w2HbNY5jhfAIMYlDVkj0ejxcxLhOpM1W1nCzGTAHXu97SsBK+IhTrZF0cAbC?=
 =?us-ascii?Q?wrZqm245BpfTdKMKOW95djEV+w0rRRQ53QoQkm0m+3b2Vi23YghdMMZX1Yy+?=
 =?us-ascii?Q?IvThrKRcNtjsZXqydsmlE3kt25Ro+OFdpvoowDZQKKHFOfnesEBHjKKE2FOB?=
 =?us-ascii?Q?LsvNcH/T4sdo8h7gWuAdvOTzc2eFa9VOo4ERGCHcSlWVsRfnpz7eMmT1D+ZR?=
 =?us-ascii?Q?enAa5uE1YmTXpgbtql56JxWkaifaeO/keEXJBRluef8eyXW5IlG3X6cvm3/2?=
 =?us-ascii?Q?bxMcBm2m2fkSmhCVNyX/LuEDYrlcA5Z4TOh0LYFCL4bKDF1j3gp6e0SChLez?=
 =?us-ascii?Q?Rh1tKWRTROGgJmm8EBnHCa6OIdvtx9WSYgH7ec1XalA20cgNtCVFZDlH2TsU?=
 =?us-ascii?Q?dqHVMruPBB69EbFRS05INLj0DIGZIcn2ELHxQUCnyh5TW01jNe5a6NuhrJ8L?=
 =?us-ascii?Q?IW39rPVnxPwch1oKbdMtdsS1slqH/afNYkT9cTexMk+odpLNlVj9qhP5jM1X?=
 =?us-ascii?Q?vuCceO+dmmyJejzFl6MHWsIFO1tYMTYulkKPkoDUKzONH/q6R93MoE/F1hEk?=
 =?us-ascii?Q?JbrsNf2wBdhtALEhQc88+p4qfG4dFTDT4nFD8MGC2xc81o4QP/wLI3PZ/tqv?=
 =?us-ascii?Q?I7sfe2Y67AUT01GgEwqf/YaZGBNEHUhOPnodODfe8ZA6Ror7PKlc0LThuAyj?=
 =?us-ascii?Q?drTP8Aw6cw39sqiJsgG7FyXu+MmvUMbGlwaVZljMXuju0P+e9RMpOkVzOuho?=
 =?us-ascii?Q?LDhM9AlRuGpEyjXtY06PVZxNuTjd9TFDnOBgLXh6VxOGPKq9odbcbHWNw3qS?=
 =?us-ascii?Q?QIncPEAgMoirLiMgsSBRkAt+BgIOKkK9HChjK68/qX0LpA+DN0ax4YYr3NgN?=
 =?us-ascii?Q?tg/g+Do0B6k/TJWr07Vkwh1eOAeKIIAGRFkkyezwBIuqoEwvbuprjNzZydX4?=
 =?us-ascii?Q?FY2vKhYK8FOLtNlCcY0hNoZihqP17xutaqtnGcENQd8ybCBibsqM5JIH71Ns?=
 =?us-ascii?Q?YPiS8FRofJbXSsLfWlFZFR/MtHdAXSPe4CnneK6+yXQWyxfor2JKJCZR4kpN?=
 =?us-ascii?Q?l81oU6MleW9kqr9fL0k/1olsPWqQSMGaW0ZdI7FL9DDwDH6Ea3iFnC/x8T1e?=
 =?us-ascii?Q?rRCaZwH4VdrIT3W0hRydzp4CQAgrWbKwxQwHpgEzCcfYQ/2ijVZn7/ON0J8a?=
 =?us-ascii?Q?I/FA+/8Zy7KEqFsPX9guz7JWx5DjxPQXtpr5/yJI9Y7wHtS6s5y31eXxc5BL?=
 =?us-ascii?Q?fnv/yzOlD5Pv1rkEp8FARPuk5DPqpdzcD7WM+02e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbdff3f7-e48a-4a07-7525-08dc322fe510
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 16:20:46.9999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2bXoHXpub57pCgSKzPX+XvI+hQqsP8NTGsWJDU9xtoizPFFp8+uC8U87ELwr9OrPx3ZuLzJKnd7HezHyYx+OEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7295

The i.MX EP exhibits variations in epc_features among different EP
configurations. This introduces the addition of epc_features in
imx6_pcie_drvdata to accommodate these differences. It's important to note
that there are no functional changes in this commit; instead, it lays the
groundwork for supporting i.MX95 EP functions.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v7 to v8
    - Added  Manivannan Sadhasivam's review tag
    Change from v6 to v7
    - none
    Change from v5 to v6
    - add missed maxitems.
    - add comments about reuse linux,pci-domain as controller id.
    linux,pci-domain have not defined at PCI endpoint side.
    
    Change from v1 to v3
    - new patch at v3

 drivers/pci/controller/dwc/pci-imx6.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 3009c3ffa1415..b714edac6d566 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -105,6 +105,7 @@ struct imx6_pcie_drvdata {
 	const u32 ltssm_mask;
 	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
 	const u32 mode_mask[IMX6_PCIE_MAX_INSTANCES];
+	const struct pci_epc_features *epc_features;
 	int (*init_phy)(struct imx6_pcie *pcie);
 };
 
@@ -1053,7 +1054,10 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 static const struct pci_epc_features*
 imx6_pcie_ep_get_features(struct dw_pcie_ep *ep)
 {
-	return &imx8m_pcie_epc_features;
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+
+	return imx6_pcie->drvdata->epc_features;
 }
 
 static const struct dw_pcie_ep_ops pcie_ep_ops = {
@@ -1533,6 +1537,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.epc_features = &imx8m_pcie_epc_features,
 		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM_EP] = {
@@ -1544,6 +1549,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.epc_features = &imx8m_pcie_epc_features,
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
@@ -1554,6 +1560,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.epc_features = &imx8m_pcie_epc_features,
 	},
 };
 
-- 
2.34.1


