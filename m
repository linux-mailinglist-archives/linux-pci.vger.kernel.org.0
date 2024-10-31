Return-Path: <linux-pci+bounces-15678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD0F9B75DF
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 08:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91BCF1C23837
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 07:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFA01547E3;
	Thu, 31 Oct 2024 07:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="de9UF1f9"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2069.outbound.protection.outlook.com [40.107.241.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B556717B50F;
	Thu, 31 Oct 2024 07:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730361449; cv=fail; b=o9uYrM98fMlvs1vGrjgz08TqbLtChYKxTOLsqgweBZohKwEHs/awiDsbV86jKG/EE7MphJjuVcb2LYSxgLaCYxK7b/gSiUIAXtfJGybaETxyPjdA6cNyhankyQ1xZzKyZ9Ho2HqoEePAiMnwdnh8OjEr9+tK8sq1brARDIr+0Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730361449; c=relaxed/simple;
	bh=DEdS9qEOvhNDr49j+j3KKYQoOAFdeAB5ICcC3TsyrE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DuL9qAu2fyoOs9IxAVBMH+q5gC04ofmxhpqgLCHQ8lI2KVWQNCjoAKeApahgOoY454tkylbH031juD0uycsVYlaCI/10/l1SwkJ/62DAn9NzN73CEk+cj2Hp1Wrg4oCHEGy0xyqRBwmP88MitA5nohLF5ynG2spVttNdXo972ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=de9UF1f9; arc=fail smtp.client-ip=40.107.241.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUO1A+sTIzFVcyjY52OvUypIqcLFk6ZlXWe3seYIyODQSs2Yxgp6EGYVV3kMnKyk+XaMwKGlR4kJKoAQ9nJGQElXaDTFmxYXqym96m6lJriz78J69ewBLAJKmjPPMOARhpSpImLdpEgSSswsKF16TbbQJoBMx4RP9EP7SRTaiG9XBKw9tTS+o69l7YTkCqVotKmT0ytUHHc0xF0hJqDeZykm5pAulHPQScpUYVbb0m+lNK1+GeRO4+rPpbZk7iJ+mlqTN+MJ3Jm9TSm/Sxm5Ksq1K9gPgsuAYiG7UJEpPfGeSElIRtqKyUYkfmSEk6NzU4wI0urMSz3CzNhWS5Iu3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cJuVE5Oe+ZUPDPWv61QsRWeGGpZuNOJWUAEqPFt9ig=;
 b=R+XIO3BhpFfy/J2h4m71q1xHHiOJUkDUZHVQVtKYWpLMoyYGTGzexhUISrIRM66WJlW4oqCH67dK94VVGSaDY0kfPJhOoUM7yNUCuDWIHM50QEJQfWwEMAfQLpX/vyLtuiH6yoKpJqyFVoFGv759pSRIrWzfCioZ86yV9KUqF+AIJaMEdVQ2ryjyNn3oyjCbeoucAccrTC2bSyPd3c4AUkimCpWtdRFs2NogOCcTvW6XbG94DQIYHpRl0NVYnGJBOG/aTK4JYp7lIIRwZUNZ3dEHY1xqb0Pezl3vO9pndJYua28MMzK60iDaU/vtkO+t4T2lHpsIQLBCBrd13EA5ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cJuVE5Oe+ZUPDPWv61QsRWeGGpZuNOJWUAEqPFt9ig=;
 b=de9UF1f91dsrJJ8zbR4Hm2NBIWyeiyNsGZIiNN55bgRHeVo0cNkAxz6A46F4wa4QrrUEvpES4sV63jksI1GsI9PTKLYwqpDgdTpO/AydloOJHOS6A7EBb+iHQlGOFhg9KkSmv3xQDxbQe0+BBE5ojFRr6hC+xBy4rtzRiROblPF+7M52iYfJhuGJZqeLrJSi03nmXF/5646vmtb38sv608Kacjmc7LlFcWLqCx01yFCuhW0318nIgTDg/T7jPfgTOzjhlc8+2GPQk68a09OQVumalH1HQRZMSEkM5eNTBoF3gDOAacK5SborwfrR6EvyPUDLgZF+X9TSIOlh/0gdkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB8139.eurprd04.prod.outlook.com (2603:10a6:10:248::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 07:57:23 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 07:57:23 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: l.stach@pengutronix.de,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	frank.li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 05/10] PCI: imx6: Make core reset assertion deassertion symmetric
Date: Thu, 31 Oct 2024 16:06:50 +0800
Message-Id: <20241031080655.3879139-6-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241031080655.3879139-1-hongxing.zhu@nxp.com>
References: <20241031080655.3879139-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|DB9PR04MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: 386763df-00ac-40e6-76e0-08dcf981a748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wpNjrIKRQdRVRuVpOTFDeR1Sm4YYI6jijwd9W0D7rIGsnfgsAiLDOYUbJjHu?=
 =?us-ascii?Q?UisOuzTej2x1IFth1hP1jtSkc89e/uT1vBeEdA98YCJIvNSYbdtlbcDI7xTj?=
 =?us-ascii?Q?nA/5iTC0KmYYsZyw8P1NcqK4fNjgy/3Kq64geUr69F9zrcxuBPWfm9OPSuKd?=
 =?us-ascii?Q?ISicEVrpH95gBgnt9uEeaKAYGG7cHjOVT7OxZFzuXDezntVh/7/PVvTKUlb6?=
 =?us-ascii?Q?WhL/jzPQCykNVbBHez3xGhG772jyhnPzA44kdjnj3Z64pBX1ZtgcfYbsGztu?=
 =?us-ascii?Q?Joeb0dfYw3Yb9/AfCTZEZQPHkbGh4XoXfsEdfBy5UAPJ9aqoAjl8ulE8kZMn?=
 =?us-ascii?Q?BWWZqFYrrLM/CzkI8AsgfpWeyKH7gHaX7qoZILGgXylI5r3gELp4UV4ebHpl?=
 =?us-ascii?Q?6/Dvnb0/UvUkXsL/HTqtqNS18zOOsFELKjiA2yy6vA9TYZvA3+0FxSlsMX+p?=
 =?us-ascii?Q?Em7QGjU+Qd5yJ8UJd/2XwRZzILjJYjiiAjAa/RS5fqIkZ7xgIW+CVQzBK0r7?=
 =?us-ascii?Q?ocvsSxV3FwlqCaQ6qneyRG4iMoR9+8VOouflNvb2ALBkkkXQ1HLxN/jqduNZ?=
 =?us-ascii?Q?02e8dKx4EY0lM4U1rKZqw34hItNOsUMBLyCMp2lOzhy4RWEFDUbjRdILONLl?=
 =?us-ascii?Q?TrS3tkK3M+DdnFCCDND09JGpzrwDeTyCCfOoKWvhUIPyLM3Ge8AyTl3ewTW2?=
 =?us-ascii?Q?V8Bqh3IpIISm6Qlm31MvKa/j9mTVJvqyI6nCwkFzotOIzdJdhRQc3gBn8km/?=
 =?us-ascii?Q?aoi5gtHV3IUzWFX/qG9/wDNPRMCSfL2N3u3GRTZ4MPAzer3pUWg6hwbMGzdu?=
 =?us-ascii?Q?hKCp1Fx5a5BHxtuolyLbKmR+BgJVgm3gp1SwCMdZIy6ryxfCaWPcqbVGohhI?=
 =?us-ascii?Q?+dlJwPGn5Hw0U1F2jozAd4pmD5yC0JO7Q3SDCb4okoO/NhoDxUKq8lltNMfE?=
 =?us-ascii?Q?ujXUN+SXHDTJuqIsUEWk+CPqs2Pf2xMPhpdCpB4gwUqmlKftMYU7IdJu0X/u?=
 =?us-ascii?Q?hg3rU5/8kuZP5U7ut2U70FH9HEtjaQr/6emrCF7qIudRdzYmrMd+bpBkOf7k?=
 =?us-ascii?Q?EPQnQ8bb0zNGWuZp9VlrlqrBde4RrnicBZXOnUIJmSQnLKfoRY20YNugizrZ?=
 =?us-ascii?Q?j7JCFy2MK/q04h1vB08G4aqP5Vo4vhg4c1R56Ir2ehTjlua7jFJEIHO6gqNM?=
 =?us-ascii?Q?Li4UaZA3YPf4njUzn8R6Jmg2zOju65MerTMDOV7YTbBeXZBGYKtydu8DgjSV?=
 =?us-ascii?Q?psOMgeWoSDt6vQ/ms2s+ivev1iBHJr8F2oCpwKYyuWlala+Qg/ZHXeya/wcB?=
 =?us-ascii?Q?V4Vh3V+k9y1SQqK0+1jVCwvI/Q2PD/ckUSEJV9uAnZ88GlyJNTtBuq+k2faX?=
 =?us-ascii?Q?oEPfT5ex3lkiOcahRwVWC6UdefID?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P9C629F2pPWTO91wfggqjM56IcqPlppp6VCByDQA5Hk8usI7mmVMfwDBPb6M?=
 =?us-ascii?Q?/2OTN1qAFDBaFwn8WMZ7P8q75glDykROOvNMSHke83d3eIz//h7Uac1DwR44?=
 =?us-ascii?Q?v26Im7UxysPMPsN1gQ3wKM1rrK2T5YOBDBAIAsphdyEpcRAl96MqrRzQ9ITT?=
 =?us-ascii?Q?9xjWhD3Yhn3S4vAo9cSMYR2YXkUIxSolnl1Hy2fZKmVLQyu9ya4VM3eaWN1Z?=
 =?us-ascii?Q?JUPwDtsPCHSoKE14ByEhyqKpeoYTsRXLNh9PFftGydNgyHXvaAjK1Ok63Voj?=
 =?us-ascii?Q?vMApoDKGG5k+VRvPFZBXWX3j6q7k+N41ebEzcoRXGvPQAebgHZwHxOx2s+GT?=
 =?us-ascii?Q?h7l4ohISyvUJaSNhHDgTKpLuABmYUotkfm9AZYXt7xXW/aENT3cuxzkN4FGN?=
 =?us-ascii?Q?elcUK0PXpcxsZpDU9UbmiJzU6HCu+YQWEx5BqKzAccSpHGcg2FDI8nGS5pK6?=
 =?us-ascii?Q?VlMNbrc5hBZNzHuU8ITRfrsryN/x0hxLLwhpYm/aN65KZK8af2Rlkdn4Wh3y?=
 =?us-ascii?Q?yBb5F88nyVt9WBvJb3jM+e0W3A24uu8nUSowil3FVpBuCAha5sWvbWJB/2Bw?=
 =?us-ascii?Q?xvUmsSqCN0wwhVatgLWCr2/zpIUH6keu0Ch1TcPSNY+C3x/HxVeLFIlq42/P?=
 =?us-ascii?Q?fFwZWHdTC8JaYSBs1svuI2W87HYZYcpg59OLw8ni5sRLCeh50t3lKoLVryLE?=
 =?us-ascii?Q?RoQiAw7J2BSp1ctuon2Gy+lbaAvbdzWC87yC1rp3lkWBVz2mIcTTJx+79452?=
 =?us-ascii?Q?juEZriJUqNY/Q+bHGwqFYjhn34T6eIMuGr1zDG2MoG/IdMfxCbS62bUidZ/L?=
 =?us-ascii?Q?5RHiEqPP9t3t+OJOeQpbkyyTkAGpgCRFwOFiAEFOcn6CM38WcMRLW7jRefXN?=
 =?us-ascii?Q?7PH8aWyeyebPodvO76etx5gGQzAUATw6xHl6uZmSbAmSwTRHVyIfnoCWlMyS?=
 =?us-ascii?Q?muHiSEssgzmIdYNx3dmy6OZzad3wxOOfET5zB+dw7x+SjlMx9hpJng2SSXYR?=
 =?us-ascii?Q?pNxC8lOJI7ezDS9+GFmGVIsFf5I8gXLb0yuledLlImZjVwqP1tXQ+k3qwgFE?=
 =?us-ascii?Q?BV3pMC3ICly1AZgbshh7qCmhoYJqqxzzLeLivkG9en/mQnm5BT9HzAY5lK8R?=
 =?us-ascii?Q?DJ3naME2fB/DoYczfP6q+kQ8R22A4e/J+13XqUNjY00MyiCGQIWcfkUYLsRN?=
 =?us-ascii?Q?cMalFI8B7ibOzH02FA4qQjAMfVFL9punlPvvzkqJhftc8/xvAY7o12indDVC?=
 =?us-ascii?Q?cTKKFNJA2BPJzc21PjlH6eKyJ+v4UwrFZgLLGpfc+M/EI/UCQeeAL9LofAmh?=
 =?us-ascii?Q?JNVTwoWUb3TC5ngOyeeCUKi8mvoozdPQqlo8gxPZJNS5du3kb8UPoVNVA4vn?=
 =?us-ascii?Q?uQ7VRiSivAqO0lLr8foeIvX2T9vFM6EISyE8lRWqhk1PXkRcPUPO9F67wn89?=
 =?us-ascii?Q?Fcqz/Gle8TWS4P2liJKkhL06u0BlcL2O/H20F8CJCI8+Wknt+kEKX9SMkUkH?=
 =?us-ascii?Q?T8naNH+Au1M9bXojiygLV6feBFCeJa7YTNt1TBqr5nZVxmPyMJ9u5DOHbuGL?=
 =?us-ascii?Q?kb2nTq/ZKbeDRUz6mVcojGTOFdSfMv3Tbz4SrtBA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386763df-00ac-40e6-76e0-08dcf981a748
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 07:57:23.5763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYVtaSf6C6h8vEjdk7juLdS//FcFxpOki8A3wQMI27kSKgBjCXTFZ+VEVhGQbCpbuMtcSJSzoQqpu75vzjvOEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8139

Add apps_reset deassertion in the imx_pcie_deassert_core_reset(). Let it be
symmetric with imx_pcie_assert_core_reset().

In the commit first introduced apps_reset, apps_reset is asserted in
imx6_pcie_assert_core_reset(), but it is de-asserted in another place, in
stead of the according symmetric function imx6_pcie_deassert_core_reset().

Use this patch to fix it, and make core reset assertion deasertion
symmetric.

Fixes: 9b3fe6796d7c ("PCI: imx6: Add code to support i.MX7D")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 7479d3253f20..92f2d2536ffc 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -771,6 +771,7 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 {
 	reset_control_deassert(imx_pcie->pciephy_reset);
+	reset_control_deassert(imx_pcie->apps_reset);
 
 	if (imx_pcie->drvdata->core_reset)
 		imx_pcie->drvdata->core_reset(imx_pcie, false);
-- 
2.37.1


