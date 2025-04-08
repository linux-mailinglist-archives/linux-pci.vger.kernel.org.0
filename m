Return-Path: <linux-pci+bounces-25466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD1AA7F2EE
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 05:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFAFC18922FF
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 03:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA2C25F793;
	Tue,  8 Apr 2025 03:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UJwUonkP"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012032.outbound.protection.outlook.com [52.101.66.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F46A25EFBC;
	Tue,  8 Apr 2025 03:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744081265; cv=fail; b=Q72kaABZeiBCyY1vR8/i3doxWxJFIanLN/igX5TsXGSIbEZIcRVlU2S7RpGHBgdBgIzWC2MCYMfSZC8DYSTocLt/XDAtcQOrCwCfWu/yc8ZwlZAegatkK7WcxbhMh2tU/6tq74O5iYrkwoSTbjl2RtsY4AfilRvaC+vnaB+b8d8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744081265; c=relaxed/simple;
	bh=1fY7xIXNKgJ8yDxGN6/NP5jOGDJ92lDGzC3lUzto38I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fax/dj0FOmta8pX7p9tsQhD0bzuoNT153xSSJ9O5d4qslcJfpd354PbyDLXJ8JfuaUcw5IJeFuQWVfsPLK+1D1D9TEJo0WGpkEgR9wXuOe3RY2AH8wk/c0Vw4hS6ymeA4XlsxVSx1+exZBl0hiOb/ht7BE3Ttx9NClMyJ1r6K3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UJwUonkP; arc=fail smtp.client-ip=52.101.66.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvt+jq/6rHAGO02C2cPki/O/xL2diFIQ1MFTviPb5Ah+1NNBbAmRYDY7KILSIv8AMXc1XyrxzAZZcxTKWpLkbaMfPPOEh6m4evDZegdNi38UyDzfDm5RPFwuQ32otxDbN2aUwDCRxjw3lhyXZlSz5JPAbnAPAR46Fu/shV/c+bO0xH5UxNukfX/sZgkEdpCjVAZVnJD9IFaa+UJqMCBeHksxhiyCLCVejsQMUHbGWnbRd/ZNgF51DWfGhYgNnhq0G0ZGFZbuq5blMCaZ7G2MnoxM9AaYNlREk/Knv7T3flNRKsBIM0lnOJORpFEWNfZllPhXgTepRev99M0/1Sr9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s00AV898NAq6xc5i+NJmhoGUwbkcJSwE+HGElwC6LFk=;
 b=j1ILpdbIsCaJQR1fnXUcFFEUFCXhIkKd4KcG8qwGB7+f8p+TItQ4ANOaOQgNWk8h4UheNF3gDF7z7F48P8M1D2L4iesDnmNm+N+4p0lojYpcTMf63VypdWXD3ykbXJnwSbCj8szjjus5PrFKkeYuhT37jhInLRgQYR/4nacfQa155jIclQI8PFYIzcjjPqatST2wWbEh/INoSeOgKtDVJOk2vZmP6l4Axz0H/85tK3vFLHX368OG5ed1zoRi74TefNKhphEsTHwgruvT1B4gGEH5d7sCi+OQyGpcfR5xHbFYpDDAeR1j0lqw7M0EwAX1WzImaBRqqR3oZ+0reRt9Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s00AV898NAq6xc5i+NJmhoGUwbkcJSwE+HGElwC6LFk=;
 b=UJwUonkPOqq99JdmNcrQjXjlIjeOGAFDo7eULYZMG3T+tVhA2HNJzFQTU84bo4fk0IFO/KCBwSTLdQm8palTC7WuGebBAUDGx0Y+e6+LZ7/1NQvI0VR7cQKubah6/xS9lHEt2aA6HpRDfdCOZpN7pyRhPCBrsPwUMue+ahYTxfLfs7tXTzOUz585lsf6buEh+8DFVGRFkXjSSHqPSFKYrxts3WHnbdHFTdcktFqNNA29QsxnreItBusTjr4TgjTi0I4L38iRL/BdirEJJD4I9ER0bSitsztN0em0bF/ZVJwO8pQh1A5p8ZhTJMhsayYolTgaIaTmYknvZ5DfZzO3tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA4PR04MB7536.eurprd04.prod.outlook.com (2603:10a6:102:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 03:01:01 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 03:01:01 +0000
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
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 2/7] PCI: imx6: Skip one dw_pcie_wait_for_link() in workaround link training
Date: Tue,  8 Apr 2025 10:59:25 +0800
Message-Id: <20250408025930.1863551-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250408025930.1863551-1-hongxing.zhu@nxp.com>
References: <20250408025930.1863551-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PA4PR04MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a98f24-8c05-443e-80aa-08dd764997ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cXlFVy8BGCK+C7Chlx50LhI1co4vf8SMIfhUcc//Ao4WtrJhNGqTbakjVrxR?=
 =?us-ascii?Q?27cMbFBokW0KoYtZUjuiRbiv6/E1WMgEYRoVDGOv7O25GZoterQkY4tZAvlX?=
 =?us-ascii?Q?HBgFpRCwwp6Lm+u62FnRgH1d/05V7guaWFh9QM4eKsBF717cMDCfFv23JoAL?=
 =?us-ascii?Q?ENuEtf6gQY8KsRbLu8qzqsfLGQmMGYRNe3LWVHCL3CyH4kt7siTi/ke87CPk?=
 =?us-ascii?Q?DGANreXVpBM5QbOSNUUQOR3zZOjUIrXdbk+bCSLlQmttgn22tCwnRiUEH2WP?=
 =?us-ascii?Q?0kE3JHo2DFBiq7NNkzTT49Uhw5YQxvBbPokLdjffnquEp9cHftRviS2Y3zjn?=
 =?us-ascii?Q?L5K3/gO+ROmri5vnlJrED5BNidHHx2cJytZLAKAvn8pibo10dGeQeHAbU3q8?=
 =?us-ascii?Q?e1JIx1JhLvaq3r9IoTKaAojhNdunGnXbmScB/XFD9VH7HxCEW54DhqtuZV6f?=
 =?us-ascii?Q?mT3jgnxAAUcL3F80EuYvX+vuFA3T8Gr5jFvTfnxvgKwRUbmAhPaGBeuAnriv?=
 =?us-ascii?Q?UAE2fFTxGYqvS9XRyZdpWGFcR9xgAvfZvd8yNm5nJp5gn6fT0NygeNtmznNf?=
 =?us-ascii?Q?HjgVF6hS1Xo6Zte5GEr4JAVekookDb1b0mbQZuqAct8yTkdkjzVmlVKtIj7o?=
 =?us-ascii?Q?pkSExy25+t+Ob4OCx1v+iRtno8H/2+7xLb2znmHfnaWOrfI/PcHTjm8LJL/W?=
 =?us-ascii?Q?YJx4jUGX017F80akFZNceipsEiT7UC6/1+4mEN8NtgClvfPNQD1hRvoI0U2v?=
 =?us-ascii?Q?RLkXFu6Asx9vAC6iR4KWrnIV2LCcc/olPNmubECYV3GUKZgiqGVw1L9BSmOH?=
 =?us-ascii?Q?eawPZRtiEBlECnQtRmjOOfLC4f7hr+NkePs3V/EsHhSUE9UbtFnHcjke9rZ1?=
 =?us-ascii?Q?w/TrNzr58xOdLNCZIgICkuxbUZ1D7qsVM9yVnfhNuVr/c6hMpm6u1l3I4fzW?=
 =?us-ascii?Q?DAm3sR2kgkt+/PEUgAOBER9SuVn9kC6cI4f2au3XSvnw5/f8pwkmvIvpBfcV?=
 =?us-ascii?Q?Qbh2wKT1G4WFXlkeGzcM7ITQWGqrbDCWKbX0FPeVtg+wBXjwukz5fd84W4+g?=
 =?us-ascii?Q?vo7qI/fH1oJnLRzvAnQWO92Ij7ck7eYXDhcagVY6qwQ7YSkJhKbk3aebpc52?=
 =?us-ascii?Q?KcHlFiKS9cyQbHqyhP0uiKtOx7O3nP4sL/o2cljzwkUJIbfebQeSvNCa4HHF?=
 =?us-ascii?Q?Vx5Pu3HAHt7HHDNvCX2Z1LDGaacoaOHt/+IYzi9iwgER4PJva84blEYgF77d?=
 =?us-ascii?Q?ZeFLhlmB4sZARy3NWfcQxIrKoM56z198odcbHX3HArbFR0K1vKkqRyAxXOh/?=
 =?us-ascii?Q?T2pvBcTdx53v9NVeGRd074lJvLkt3JTzZvNrO6lb3yS9g/QDh9EKv3yrDCeq?=
 =?us-ascii?Q?5VKi2VcSM0K1JDEB3puN7GpU60z+/JO9aB1qqSI8Xtv0i9nm7FWDznxkPYoZ?=
 =?us-ascii?Q?7WDVXQ9V8GSbOsDI90IiITTKIksDIcdlOlXSoQnNqxVJcQGn9HbivA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yjYVX9FBlmKDpd7w1LL03QP++2Wi6xAD+K5o4D57FWoh9SVbQ07gtPvJ5jTX?=
 =?us-ascii?Q?aNHkv23mnwHjqmTRkoetCIRawP13SjRrqunPwJSKtSZxOycZVLuToYbQw5IX?=
 =?us-ascii?Q?SudIIwznOOaicY8EGM+yBEUjdGtNm85YpgWAyaYCHH09TNflYOsx7VOSlTPw?=
 =?us-ascii?Q?BpxjfoGKcstJEmJeSYCVEp0kBxCiirzzQWAzwLo/ejUN7M38WzTS8AB+Wsqi?=
 =?us-ascii?Q?rgV/pQZgxBcooPlJmu48rMrtJk+jnWabxz2WQ7QN205SaN54NOpGql/ClrnJ?=
 =?us-ascii?Q?3lyBJ0j8pB9um1kuoX7zWP2Yu3LOwoL9Gw3I/7nnVVmVXGOarn+BYzZxI+se?=
 =?us-ascii?Q?RMBg4WaX6GJHaOmDg+ivVzGkVqrJZvuT7pXnHFLlOjSiy66j67GKP3OmMOz+?=
 =?us-ascii?Q?fOYkl9yfkDe5zzPMA4AvXoSv9MAoX7ajlp8EF3uAJL+JcBuoRmhdTuG9QDC4?=
 =?us-ascii?Q?nwn0Lu43aMAkJzeoYEYGaaJhuY3E2ychEypyn7J9xCEYakpG4QRQ2CKuKKXb?=
 =?us-ascii?Q?vydjTSF/pHHUSDirNaai71x7FAqC2WuJqskP2jppd6poc9EQPH/r1pzzUszI?=
 =?us-ascii?Q?3Vi/2lAmu1uuEAiC6hg57I5N0HzS5hot4a7laN467rHzLfmaXiDPEKmXzgpb?=
 =?us-ascii?Q?cvJlhhBGiwTncAGN6eIExwEbaZ3BEdwmqcvvsD7odAA5plMNiD8ffc1NyRzP?=
 =?us-ascii?Q?X6jm0QqJVQhjOB+f6DWqhXdMOSSBgUpOb9y8NnYBT7Ea1/EnP9blB/MCScIG?=
 =?us-ascii?Q?p0gbAqLHUccMDVTMRWJlOfnzfdEqp1gwN3m5YR4ovxPaKdVLhsoQTpWFTbce?=
 =?us-ascii?Q?QbEpYbx9aKorUbNt4Zb7T3Z5uoL20pLWCFA9k+gbOB3lxb0wevtZ+MtaHWz/?=
 =?us-ascii?Q?PnFqdeG3J8DapPaiV1jjSoBk0UnTCgBo6rECSH5WKnYSnKXXuvyuke9BSiDc?=
 =?us-ascii?Q?UYuEY5W4JQSe/zuMG55cdkKHjiHovfOO88x3ueYC1WoUKAajh9VyGBNojPY8?=
 =?us-ascii?Q?8Kv77v6LPRzyraYpuCqrHrVgNH+qKmoTxG0Qw3ghupi705vhU6kyXEzioGfp?=
 =?us-ascii?Q?A1DY3aZnYIBZRgaXd+NqVVNAUk/QqvdPQATZApvM2xc9+qlJBuSypY27p4+e?=
 =?us-ascii?Q?92hotBcbNKY0jUoMQwmLkn5deq5Q6XrEEEW/Ao+349k/OY0bCcO60lYHiSVJ?=
 =?us-ascii?Q?pVjEws2NMGYWUYjhtlrw38f5yD33BJohbT+AoJVBBgIsnzZJ7cBMVSA0lF8E?=
 =?us-ascii?Q?YQwWzT6nlz7TEANRrBpCP+110T4FLRrnicZPbVUYNwxmoWJi1QSQSUlOeEop?=
 =?us-ascii?Q?6sdMGMvlUGO4bNZ5Q6HdgfLfc3oeypkXHKvQdLonMEFqRqxzfP3xDASxTnRA?=
 =?us-ascii?Q?Dv7swYhBG5zXLuiLifgMmwnqSBakw8gS3pppMRwLNH0cADTJ3i0+1NKzudJx?=
 =?us-ascii?Q?xdi46covMaI37M6VoWa7B2Vsz19Qi5IV0wEDeryeLFwWluzaN8hSn7nus5Ro?=
 =?us-ascii?Q?OcHD/b2UjE8F4D/omFJ9j23cVsNaMiG31/IbK8cbPhCi02AqBX36mlCgPdRr?=
 =?us-ascii?Q?nKr5oWUvmklDC5PUDtFopL/e6W2SkzwCSdZgYCnq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a98f24-8c05-443e-80aa-08dd764997ed
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 03:01:01.1703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYGTWFpbW/6MQnPN755H8u5G/Krd/B7zWiAVyPrMtF5K8V0jEjaS77iONHwNeMaaanme1RzYL5r2ivAtY0Xojw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7536

Remove one reduntant dw_pcie_wait_for_link() in link traning workaround
because common framework already do that.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index a4c0714c6468..c5871c3d4194 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -881,11 +881,11 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 	/* Start LTSSM. */
 	imx_pcie_ltssm_enable(dev);
 
-	ret = dw_pcie_wait_for_link(pci);
-	if (ret)
-		goto err_reset_phy;
-
 	if (pci->max_link_speed > 1) {
+		ret = dw_pcie_wait_for_link(pci);
+		if (ret)
+			goto err_reset_phy;
+
 		/* Allow faster modes after the link is up */
 		dw_pcie_dbi_ro_wr_en(pci);
 		tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
@@ -907,17 +907,10 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 			dev_err(dev, "Failed to bring link up!\n");
 			goto err_reset_phy;
 		}
-
-		/* Make sure link training is finished as well! */
-		ret = dw_pcie_wait_for_link(pci);
-		if (ret)
-			goto err_reset_phy;
 	} else {
 		dev_info(dev, "Link: Only Gen1 is enabled\n");
 	}
 
-	tmp = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
-	dev_info(dev, "Link up, Gen%i\n", tmp & PCI_EXP_LNKSTA_CLS);
 	return 0;
 
 err_reset_phy:
-- 
2.37.1


