Return-Path: <linux-pci+bounces-24480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA503A6D44F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 07:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E703A903F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 06:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F88B1957E4;
	Mon, 24 Mar 2025 06:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I0Sn7A1o"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F70319415E;
	Mon, 24 Mar 2025 06:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797909; cv=fail; b=g5T6obxKWbbwlXTLQ7/LHSUS87CAuQcddysi//j9BodUscTOswtK/8hdnZxB0aGh881d953J2o2/KRyKPxxvjBdou9Gbl4+T2fimAsbp1Z72K6TzKJWQRPh1Y05b+niua4IKlFCeVHNdaAquL7afOKSVERChZirKAnS8u06gFgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797909; c=relaxed/simple;
	bh=Tq9ihE5J4+2GeLqYEZU9HSg0fRjK/tJW1b5riywU0dk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BeWHZLJpHFCgAUJQqt6NELPlM0BX+g7YX8aRwlc9wIP+wjuuqIb/lh/F6bmNVOXxv6QWKSgkk+cdYpzTdkfWxywys/p1zobMiByqg4g/vyWUKe2W3EMYEO7ZS5LPmRBhLX8SvJ3RBUiOCH73P90hamLTEsSDLq4w8DNS58sdw+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I0Sn7A1o; arc=fail smtp.client-ip=40.107.22.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bes1nNoURardqeXvD5sTO9qlyTHf9EU4MFy5R2HpJi15M1Oo78CV0YTq7bk4XlSn77gd7F3iLPqqooi9T5VgRakWgI9cHCj0VJoVJnw0z1B9k0JZA9GJodyTT4bde1TRAaAXH/QNlsLgiL5zJ/WYqAOZZZG/UFSw8+DrYMr32jsILAJqN1WfDfppPrXve6LqyOI5KURiWnv4FbaD3ys8C5Bc6X3+Moxt0MpchBmTPMab4WW97hNqjul6+dWuwCvtRcyVCM2Yuof1Z/+i54Bl2Jao4Lbo+FNkWHn5EtALyKiJzns/4ihbqw2eaP3WWG3huQfi+bNK8JVMHu0SqDm4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5YU9D0UFrVDk9buDYGrr5WAFjBFZ3/gURYp8rk2TvY=;
 b=d+rhN6dGp8PXsGZn0HaB5d3EF6cT3Ulyp6XJTFOQjP0ykaKnxk9xYCpJALHTiZZVnRWjy8lZgdTME0r28CILLNsMBZ0u+IfxwWEac4CbLY9b3CGjzxI737wKFcpfu+SshHvGrvqr7hE0sWPyCZ2/7JCXuS0PTOYaaQlGJf+0QkKha5gcnFQE6RPJdOsUecDkb101QWyIT2k4deWYstpRs0JNrZVy3pIy7U8AG/bMPLofOdl540gwt9pIPt7aUjgSWSfYL8LTG8hws8qxOFebzkpT0WwAo3VPzTXFvl/BbeEibS0AfDREummxz8XWdJOXl9E0v3aaBdO06K9ReSWpnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5YU9D0UFrVDk9buDYGrr5WAFjBFZ3/gURYp8rk2TvY=;
 b=I0Sn7A1oKQhHExIROBakLtJ2OpZnkRSTUBPryCzR+1wuA4Z8UDGaNlOyfXWMpVDNo9mBiZsWjrhHaMTpJ3FdOjTYE3/NllmiOhy1mlUGNsYwpqt9FMfI1ssQd1nw2CS8f2lBIKR4sX44iYO/ST9k1wEa+mKTzjMBDrWmGWx6HxnC7b0Y72/rvl4IteCPd+hDRT3YeobMegLLaMtfPtR1ARSAGOmgjng56MNRyBDCjuBJ7lbEybVtMgWvvQhDrSM+2Dl4Mmbl22wNKwoltIZ75RVr7nJ8vTfZn0BoWIVq8xafYMuK/sToc2h+DurPf10ePlWKpwbxmNZSQdS8QALF/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DBAPR04MB7366.eurprd04.prod.outlook.com (2603:10a6:10:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 06:31:45 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 06:31:45 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 2/5] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
Date: Mon, 24 Mar 2025 14:26:44 +0800
Message-Id: <20250324062647.1891896-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250324062647.1891896-1-hongxing.zhu@nxp.com>
References: <20250324062647.1891896-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|DBAPR04MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f2439b-17b2-472f-d383-08dd6a9d8c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|1800799024|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C/4P/KIHzJYbIJrC3cEOG8rHs+ERFODHqIh5EPgYBjOfgGEe0VTimppTHlb8?=
 =?us-ascii?Q?o1csQLzGxKIeGlAChkQNDiBw30wSJgyv4d6oqyTVZhd1tTOFTi5/9LgCjxw6?=
 =?us-ascii?Q?u5t98IJKuzf101mgjZ65412bNVWwqkFGtyPOUGeVCjjBmo55z+kgOUQVphfQ?=
 =?us-ascii?Q?0/YfBqJJfFbOrv2UWp70UivEoiWjOBvDqYx1PGPEm9vqJ4InbjyH0VuOrPKD?=
 =?us-ascii?Q?fyZuQbO0zsggJdt+xhLQ4HOWwPNXXdCKCUhvD5ZfD0gBjeJEZMNqS9mpyGe2?=
 =?us-ascii?Q?qu02xPmDkYmwtiwKda7LUitTSG63P/XQNQB6L9QA0DJnigLv0nU57cvaP01w?=
 =?us-ascii?Q?BLi+OfYRthyqpxjcueqvvuQIpwGXGELVEtKZZZXzz9vNeG2GkBT23tPLwaa+?=
 =?us-ascii?Q?KFe2ev9cAoTVt6PIND3kExms+R4DBNnhYTiePmXhEVmPOEbPcNvh4St/mV6g?=
 =?us-ascii?Q?Fgm/XeR2I+8Q2P3X7lfuzMsXCibin/YY35XXvEUHqtz8TIuLqeiD0+MxdRU7?=
 =?us-ascii?Q?paVTwc4KDfQmGTjlvEc6Ny1DNHwGHAQSMywq+TAB42T3jJuPaLG9yfe9v5ws?=
 =?us-ascii?Q?i7mdFNiIOXR1Z47TGl/RXxpXXEYoF9+bLjl4Nt+Vb6qlT4Sgesxckw9ad6BN?=
 =?us-ascii?Q?QrvXqiRjcFrp5McAVeoV9Hbl6WLtvrqdH/WbkNIpSVJXdMsnysxwqIp23jdc?=
 =?us-ascii?Q?KSlT7PzjXVeA8u+qdibSeeaeoYYiq+0Nm9+GPIYyUvZaDusixoaPUpLaDF91?=
 =?us-ascii?Q?fJRzY+CAqPZaH8k9+HpLtDFIIpBO0gM0UOiXOY+A4QAdcyqO/kEStbdXq2C9?=
 =?us-ascii?Q?SoCUY2HQl+U0Lqsx8KW+9dtKEdGhwnPep0JfS1Sti1rmuf6wjtSExLm/RBJj?=
 =?us-ascii?Q?VcP1ojzK9JLEttntfxQxTBw+35QswyrbMNXocZnzKr/G+HRoPhVDJbfUaeTQ?=
 =?us-ascii?Q?LAXufcSqcDv8uUg4FT5ADRhjRU5AXJKmK3/11YwYQBX9GTm+VeXiqqpoKhnQ?=
 =?us-ascii?Q?0gwumUuywKoDc3zpZ2zMidvohqsisAaa+EgnI9qm2S2R6Al3VZznZ+idw8sE?=
 =?us-ascii?Q?Rx+fo2QtwhNfOv/4Dg5LI/Yl8f0K5EjBMrsrjNhcy2dx13O9S0JwI/CiF3Ux?=
 =?us-ascii?Q?u4bdUmjBz/nff9/vGIC3he4X0UoCS9mHIfxGq4BC6pxjA6JBJnK3KStLdemB?=
 =?us-ascii?Q?UoSgTpJmlnq8AdLzYxjjdAF+/srCJMmbTJwOWLYrXxm5FQ539dAHsut+NxfJ?=
 =?us-ascii?Q?9v43r6cnktaZt0/gzvnA58dhfXk/EOEd9kGkW0Eiwee1ZBVNvTf/bOQxJMpW?=
 =?us-ascii?Q?ONABnT0ofvkl4i49VEEWQ65XoShGxqM9nYYZjxfN+GjIAI1BM5Y2KmcEMxbS?=
 =?us-ascii?Q?PC20nKfr/0pi4uuYe4Vp2Qah2zm0QbSr2DgF/idX+uryvnh+kVRWAaYqqml2?=
 =?us-ascii?Q?0s/KLkuVPTEUvxgbRG94FDZQwLiN+dvoITztPRSUq41zqp4BBADT5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(1800799024)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e5iDNEa8fMiK9iNOZ1LFgJzRbw14N3ylWOSrHxikUjnxrZHEBqRcocEdii+H?=
 =?us-ascii?Q?wm8aF79IAXEQr7ZEAJzLongSjstCRQ0ID1h0HmTDeM8f+oKvVydNVKLwoy/t?=
 =?us-ascii?Q?Gezd67Yrgn4rcDnuv5TaDPbqv3+ilNmsgZyokMjKGi9cuUfFTL01bVnxpFeL?=
 =?us-ascii?Q?iPD6lhmTEyV75q8+vph1D8b2ARA2zSVS2IkYTh3+P1y3Lh7B+0uy+JDVk8ST?=
 =?us-ascii?Q?Ljv80NcHET2lI8nGe6zn3hfSifxIxIMSRfnrJZNvRHghHKyHA0CRpBh77/Qf?=
 =?us-ascii?Q?HBLtBmNY/608XyhdHUIls234Hz46Y4eb93jr4xW7AaHyRzkYWjXhMJ64++KB?=
 =?us-ascii?Q?Njnax/13vvMiFr2cl/QEVkvbsAgqkJYlfZVS7uUPT3A8KK5zSbw1Kds0WWnw?=
 =?us-ascii?Q?cdyQmKTeO/XYhVVyOyg0xDF90kcN7+9M4/KU3eiP+OTE4jUHYzvfJGjRVRMV?=
 =?us-ascii?Q?uOnaf1tQ/ZM1PvT2vKb/GqSDDfQoYhZ8ntl0bCMfKlWu1RWQNdnrn/JKKJBL?=
 =?us-ascii?Q?OIInb9Z5TC8q4tQthc3l3MlUW7nl9XDf3sSqxmUUmnC9ULgfL1+msOn++AwA?=
 =?us-ascii?Q?U4d7xzd10JEgHI7IXN4Ovkln95VQzsKAGdMlicmDZVUohOVIxu071HUxBMdK?=
 =?us-ascii?Q?0ojBZhlOV0Co53CYmYLaXb058TTnJopNSSSK/Vc8YfnFD5TeHNV8pJ1xgfWR?=
 =?us-ascii?Q?mzdLqda6CKgYBhtVy9Ha5rcMlEU8kHPSEkc5iSUOamO994hwO/CyOsejMQLn?=
 =?us-ascii?Q?WFJWOD3YlWATtzpOEnzZZAFN1D45mX0h0sFknU2+yqUrmuH9gt6HhbKhKBrf?=
 =?us-ascii?Q?anQuaMWfEuRXBA+YnCGeBj0QnwPA23Lh3LbY3PVIF1FiyXZvzkCI4JhukPwp?=
 =?us-ascii?Q?e62MrMmma65ZXbjEqV/JuloHBT8mnZIUB/2up96uFAB4TS9IMpKihMzJ8+Gb?=
 =?us-ascii?Q?4sEaDH8Rsq4jBFEKvIG/gX2/5nOL8COCQtQhfBwZWRnl0f0lVUi3G9jcH63i?=
 =?us-ascii?Q?dGKXI15rL4V8x09OctBa7tzr7anuafu5zPeTIiVD+0LpvsORTo4arN5kLkrd?=
 =?us-ascii?Q?BbcKo26ag5I0kLFCt7ZFu4PuT7xcDnlpdSaZD7PNt6IjWH97hdMd4f9hswfv?=
 =?us-ascii?Q?aK8WW67cvN836NFIY2Zjzqtl9/xjVNsW+YON7H3iGoYUbI6BpFg84IbffTyv?=
 =?us-ascii?Q?iAX7q1sBLbowxxMWtylEisa9NjLQbbVBtX6KybsTUNi1tKT5cwKrJAqskw90?=
 =?us-ascii?Q?bJQ30HRHNdC78dmCA+m4V6KR2ymHZMMKIjA/lGNHbgnmQb1Oy8Gh49QBrR2q?=
 =?us-ascii?Q?JnQ6nhaPzSnRlpgYsMlZZv9jAWE2pvR643T5Wb2PQ/joFsmCazuNrcsLjZRA?=
 =?us-ascii?Q?O0Zqxo3OLHWLFO8vxtjY9pWL2qwO4S7z/0s9XdlnieCWQBnh/caG0baAnu+z?=
 =?us-ascii?Q?J7z3n6xslIwiLVDOk5N0LeR5W669h2w/phW2J4r0j9SKH+ztO50TVrKmeNC9?=
 =?us-ascii?Q?OyTJojqD+kbxs/YEpqw3WArxdylKOOt95YNAvX/gEnUhse/k7mnbcuQJghax?=
 =?us-ascii?Q?OCXlOGUlDORLh8ywkXe3OzBB0ieaNN3U8xx0h5To?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f2439b-17b2-472f-d383-08dd6a9d8c0f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 06:31:45.0587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ps9XlsFhhP8maNezdfMzpFOcwLzv/N4ziaRu4rue/ob5Fh6z2n6Tji30g+hxWmpmoGOySGfp9ZD6g4bCLIjMyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7366

Beside the power-on reset, add the cold reset toggle for i.MX95 PCIe.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 31 +++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index aa5c3f235995..0f42ab63f5ad 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -71,6 +71,9 @@
 #define IMX95_SID_MASK				GENMASK(5, 0)
 #define IMX95_MAX_LUT				32
 
+#define IMX95_PCIE_RST_CTRL			0x3010
+#define IMX95_PCIE_COLD_RST			BIT(0)
+
 #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
 
 enum imx_pcie_variants {
@@ -773,6 +776,32 @@ static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 	return 0;
 }
 
+static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+{
+	if (assert) {
+		/*
+		 * From i.MX95 PCIe PHY perspective, the COLD reset toggle
+		 * should be complete after power-up by the following sequence.
+		 *                 > 10us(at power-up)
+		 *                 > 10ns(warm reset)
+		 *               |<------------>|
+		 *                ______________
+		 * phy_reset ____/              \________________
+		 *                                   ____________
+		 * ref_clk_en_______________________/
+		 * Toggle COLD reset aligned with this sequence for i.MX95 PCIe.
+		 */
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				   IMX95_PCIE_COLD_RST, IMX95_PCIE_COLD_RST);
+		udelay(15);
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				   IMX95_PCIE_COLD_RST, 0);
+		udelay(10);
+	}
+
+	return 0;
+}
+
 static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 {
 	reset_control_assert(imx_pcie->pciephy_reset);
@@ -1762,6 +1791,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
 		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+		.core_reset = imx95_pcie_core_reset,
 		.init_phy = imx95_pcie_init_phy,
 	},
 	[IMX8MQ_EP] = {
@@ -1815,6 +1845,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
 		.init_phy = imx95_pcie_init_phy,
+		.core_reset = imx95_pcie_core_reset,
 		.epc_features = &imx95_pcie_epc_features,
 		.mode = DW_PCIE_EP_TYPE,
 	},
-- 
2.37.1


