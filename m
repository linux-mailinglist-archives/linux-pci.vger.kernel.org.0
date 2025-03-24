Return-Path: <linux-pci+bounces-24479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D00A6D44D
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 07:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3313A8FB8
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 06:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21FB36D;
	Mon, 24 Mar 2025 06:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a3CiFbmt"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CFA19004B;
	Mon, 24 Mar 2025 06:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797904; cv=fail; b=Wnerk6LnNYxnF7/oRb5gVIPQsPTxNa0Zsi6eARDNwcWJUuIw7mCTEhv3UUrc4cS1GOqsG9/6t/mvdg18WbCtl9mbtar/dlhnPQ1A0J3sbnbPN796WnlLERExYJbUo1S7u5AH9ArHyipIwyx4AKqqdF7Dy1nPwzcFFkH5iVxxYYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797904; c=relaxed/simple;
	bh=vpeLZs4ofURN9Sx1yw3GNSEA4qmRP9nG5pFnaTwyrZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BIzO8I2EkEIdrpXxrGbhurQ68e56JVb7eDa7ODrsg+g9ibWHo1K39LbTJZpuKj9WvmSDX1oArP/zKgVMDJZBhCQpr4MS15Mvtqj0kQvHZDboMJKsiMuZ4daFfrt8TabHH864VRkQyod0/yTF3jDOfe8b0MA+jSqeTRalp6Y2/bQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a3CiFbmt; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXyBTvY/l+XwNn/DqQliBsV1TyTCSh8I/L56gB4ZV3dDjBlGwdkitc+uSaQyVPWjSiKCYKWmKFkmCFI8ND6OtTXCiQW1knawr295HlodCS+aHftRe9DDiiDaccCkWdE/ucXvewBppdNvUBCQDctYvxn6bzVFvlQngskSZpZOwVyVW8A7HZ0Ec90frCwdM/38fy+j0SKMljI2gtqffiWs5TLAT9ZLRjuK9neh+90ic88OXrJR9d9SOGjPn0k9RIgEgfvcMh4nn/37NGwswzuWgtEzkWDjgRbap4CtqLXUBG36G9GpiY+U6JTO8WCFf6wewcEuZE1XjW2Xb9HDWbwzZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7u/8aeTnOHrKyPorXG6aIfsLmL3nz+vi3LNguUR7wtM=;
 b=reJrs41DKaLdkzeCTLXudwAiMcR3gaWiGVPktaZo4D6+PM1vjZfijMi7GGd0gqPUhi5+W6eDrAmB8w297/0caR3zcGnzvVdoIInN7prUQqabRuOfvrLBdW1EUe67MWaV7ZarZlmeRBfJP2DLuvm5oPEowOtZ5x21bDA55PVHvWJWFbLsdVdKbO7mAufj9BHFggTnoUif+xZoSMo0gLZWtv2pYIxtRuBeai6CC+6L2DUYPvbjNB1ANdhFBoWhBsf/HW7StCUErWXuOS+Ce6YaAbC2w/u4UaQbe4r4Vr7gFckuSKzqlDlovAawUMz4KA4LGMKGWTy0YOp1zb+N41KSHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7u/8aeTnOHrKyPorXG6aIfsLmL3nz+vi3LNguUR7wtM=;
 b=a3CiFbmtjivZOeT5zXNdMxP94LcsEpEuz6pcnQ734TCgPTdUqg8cWMCWWe+SbviCfdqYu/vyJAhEKP52T1YmSR1GUoUfpKLlMvpiDESD5tX21XYxiiUE8eEXAPgrJNwKUI2p9KP/jMiuN4YWZRtCpk/gDUI3CLxTss/4FusQDyXK2QjLuqV9s46ptQZFQ3FOLeRiyS5zwWjehypP2uX1Qv46Mjo3zdage2abn950x6ngNdpnCVH5k1YiBhOaeikucGu54q8vxBrW8CXte5jL458Feq9dwKf21QATs6zAQ21ywCZ224a82ZD/VOfRQnEjqyCGKIRbuF0oe2w2vmXtmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DBAPR04MB7366.eurprd04.prod.outlook.com (2603:10a6:10:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 06:31:40 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 06:31:40 +0000
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
Subject: [PATCH v1 1/5] PCI: imx6: Start link directly when workaround is not required
Date: Mon, 24 Mar 2025 14:26:43 +0800
Message-Id: <20250324062647.1891896-2-hongxing.zhu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: eb8dccc4-fc1e-4761-1c81-08dd6a9d8917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|1800799024|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C1E6jQ2OPKrgWx4Uu/8Jg2j2auOOolasLOs5rFDLjI381oCuLZcENycLGt4P?=
 =?us-ascii?Q?Z6In4G9mbM85j95SRJvrvpB9xrXuwpADrJAnsvpDgHHu8mpfbz+bSzp2pBju?=
 =?us-ascii?Q?LmKx+7vGDm07wBHAJhSqSxYxo5PF4ZJqBJfyQqQSe4BAWk1yxiNTT5hP3ym+?=
 =?us-ascii?Q?6ZAJG6evSJef19zPdeuPEsuFTFxCki839/ynxu6KCjxLjLFu715GAKVAbDhH?=
 =?us-ascii?Q?UiJ43rxy2liuuDDhfhDZJraR5K4+KWJ9kt2zp0/R7R6+DK/zLbjBBFvN/iLx?=
 =?us-ascii?Q?RruwRaPYn0euPGKL3vTTsgx1zfJ5M4MCyp8ME8SW+HyQJ9+MkdOMMD2mx92C?=
 =?us-ascii?Q?XCSPHJm/rj4+n2t/vWFAS5aGdJLfA4dAQCjipe0Qvp84UPOw0FzHhF3dEA23?=
 =?us-ascii?Q?TA8s11aAZ3M7tDArKLslHoyVPIBzeMWdg9jUThMQgcoLKatLPot1OvS2eoFy?=
 =?us-ascii?Q?c7e4AivTi6g1Rpp/go6j60CiBRuvHBVr75UN6SebPyzp56rAEFBk9p0Ifrkz?=
 =?us-ascii?Q?+EDRQ+9FjeDqdkstdgom5ORQ5LDWl2fJ4jAHvEnbnj073VeVzM5s/uCO8jpI?=
 =?us-ascii?Q?UAh/+UCreswJnYzpgsI77tId96CTpbaMJpNDkmTBBnwSe2yCnIbgJLnr/a8x?=
 =?us-ascii?Q?0CF+xF+g2Sgz5m2HPAyP2jJzJywlt89MlxI69qu7SVq+15BBy7CeVqiXX4je?=
 =?us-ascii?Q?bdENdqHJBhyWIeX1KXSuT28309xvd6UbHzEMlGw7pNulcRvnw65eOHatgmzN?=
 =?us-ascii?Q?f8NTN4jRUG/DaIqvv/UDXY0ahANee6Shed9Y19PdJMF2CVox4xk4NSLKtaDu?=
 =?us-ascii?Q?O5DdO3f1xAjbHqUNSdp0ISBQ25N1ktRWSmV1fzctOzM5CrUd2fu8bMFsTm4A?=
 =?us-ascii?Q?mUd8fVaDhqGBGDPS+IAKcP8SwYwYTePGyDr4+bqybsNzpi5bywPSpgKPZ8uj?=
 =?us-ascii?Q?JBW23in2pbAX7j6s6biD8aD71Tx342cKMerXxNPiyh6/jArDx5ShkBYZllRl?=
 =?us-ascii?Q?4BhL3afns1/zgYUtVO7h9qhj9zE17BZt8HhkBQ27dvz0qYJ1UO6KFvZAC3ap?=
 =?us-ascii?Q?xOimS0mmqYFKJwDjm8sVp/dyTQpAvejRM7rmsBZr/bAf87RXH42t84X0UXnb?=
 =?us-ascii?Q?OVWrrtKcCnHLXq1Bg8QV8fhxrohpXhyfgREGihWt5lKCoFdQTJxzW8SJZLSU?=
 =?us-ascii?Q?KwmHeO9KU7GsDPt4YPzByJeA+wQRU/w2cDgXEsllz2K1izI0GR4T7+766rN+?=
 =?us-ascii?Q?kgtCkr9jJri4XKwQQK9W0IUwHbVvSoKNA0Bn7QQnyOhoMh3xMRRvgbi0Hi8K?=
 =?us-ascii?Q?BAMn6k/djH0FXQWSkEBXkIKBbU9Uc8XTRA1flkR8BVMSmszNDembalM3Zal6?=
 =?us-ascii?Q?pNykY5f5WFrwvjsANEPt4an/17/Yr06Dp2C4DhZrrZ2MdxvxPud7ltPN0YAr?=
 =?us-ascii?Q?Fcdjc28I7rz5S08RB2r9rA2yit67WPQ5gxGrhSizinNwJYzGIqftHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(1800799024)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B0cAzdMV2QQPn6zgzqiRQFYnXClWObnO7EUeUeyUqeizn12PFEpjilkxUFIa?=
 =?us-ascii?Q?OrXeszgTPDMO4nZrbjT62uzCORWQgNTE0RmRhXmNY2JfFtYpiuZxfMQyZyDh?=
 =?us-ascii?Q?aP6pI65kr/4+41V0E6YP4VDQsnNm/0t6ewYpGYcLSizg7ysT0rST0cfJxZCg?=
 =?us-ascii?Q?o5Szin4YpZFtwWV8ZZLxbxBzjEa1eJjLTYwlvvvTj1JCIgph9CsefK/wkqkU?=
 =?us-ascii?Q?ayk4QSxj7oJhpD5mmNgYg/EeQgyfBhsL/kcymdNfxe/+iPVaxGxAM+oz4kuq?=
 =?us-ascii?Q?5mnzfcDjzpBb6d1loMwmdfQUEiSnz/OVzClf1yS3diKZfzh2aZDRuOpkR63Q?=
 =?us-ascii?Q?vuIgEQmEqoXK/D6gDKcW7xVvhyt8zc6vRSWM7+nxGbnrbDhYHBTfofFW/hRf?=
 =?us-ascii?Q?e60/l8gg4RIGrNQdCRLV+pSJ8+Jvr6lKaRuJrUwzXC9F9I0tuTx3z82FOV99?=
 =?us-ascii?Q?OSk24JP/lQ4OJsKprYCs8Ic3bPFGl7uMhzt9Bj94UcQYJ7pH3Ke/bPxezHOR?=
 =?us-ascii?Q?YeE9GjRxQBtvK5KYvy8mCG6ZO7tNkHgz9zm51K8NiCzvEtO6fcqmmwTplsMe?=
 =?us-ascii?Q?hXluMFKS2YfmTi8o4Otfodc+FK1zSonhQTQWn2SUP5uUNLFW7n/Wo2INlw8k?=
 =?us-ascii?Q?VpP3T8wCOF6sm28iFK9t/1MuVCtIlO4RQPERvumuoX4NiyILvtTdlCc8nTiJ?=
 =?us-ascii?Q?ZoBd3423fdsw6N7sYxkLQvAk/2ou/NEyL2rN6CtYs5S3FkOgiA9ldfy0B5tl?=
 =?us-ascii?Q?5jsWtMF1UPo14gCLNevk/lMNFlITtt3G1/xYjHCE6EL58E7Cz5vhzGhTnAsd?=
 =?us-ascii?Q?cT67rAL4DpzU6MXP4bltzELeUKvfjrz6D61yT+UFMsohMBqXhUU41QHKNlli?=
 =?us-ascii?Q?ie1DepclzJMHuC8lPX9hV5aluQQVt+SKjpvhe94wmTWR3r22nPeiIioNybhL?=
 =?us-ascii?Q?ydNHcrp5nc1ss8X3CARrEupVhPRxWfy4CQKk0qsQ2D0+Ldiib9GbH28N8bDV?=
 =?us-ascii?Q?x6knTUpjk2DMPywXpVzAiXzwRhIyRBFKU4OWOwFVp+Dfv920JDW7vcxAczPA?=
 =?us-ascii?Q?cBEg16Bnl9weAXCuC29GZ+dRcSIj5ihhDfw3w+BaRDKPUF7GMUJkusM3jALA?=
 =?us-ascii?Q?Oh6DqdHIK4aQq09ZyITtdxX2o2QSTyVtz6qJ3Np0piRHnpsvJGVSRSLkbykQ?=
 =?us-ascii?Q?kubqeRpiuRKBxoETxnDpJ2ZTFSMYukOc1pUaOJXNq+vEztwLiFOAsxVVutNW?=
 =?us-ascii?Q?wdUt52bIiojYNFD/h+GJBwMCGs/3DDauTyDzdkYr82+0HEfcIbhKWeSTLId4?=
 =?us-ascii?Q?gk3+e8rkhoqXng2sUqapC6wAEFHiQyxDPxzPUhmGnubWfsGISXHUfC8KmZb+?=
 =?us-ascii?Q?5kkMsbb88wDRO48/onQqxuiKvmeUWdZmiaWjRxjKk7Vx+NuK5xuilrdboWiN?=
 =?us-ascii?Q?rk3f8gHtBXZ8fPBJ2MoVljaV4wKCiUEvV+hf3Yu9Frej10/ckS215PK8C8J9?=
 =?us-ascii?Q?lCBEAT5FNQzy82fSbaKhBv0XLrja3hDgsammXGYg17JBvPtQDe6ggLE7WoGM?=
 =?us-ascii?Q?khIIuI5aZb0GRXhPesT1pr/VSOpqCbxMO8Co463u?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8dccc4-fc1e-4761-1c81-08dd6a9d8917
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 06:31:40.0937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OnV3baPRo7URDZfzj/YJBUF/oZvhy66/wgY0+gPWd3V3qat0tocnybOmjLJ/GuPqHvzbXNuSMaIpo6ivXQfEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7366

The current link setup procedure is more like one workaround to detect
the device behind PCIe switches on some i.MX6 platforms.

To describe more accurately, change the flag name from
IMX_PCIE_FLAG_IMX_SPEED_CHANGE to IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND.

Then, start PCIe link directly when this flag is not set on i.MX7 or
later paltforms to simple and speed up link training.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 34 +++++++++++----------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c1f7904e3600..aa5c3f235995 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -91,7 +91,7 @@ enum imx_pcie_variants {
 };
 
 #define IMX_PCIE_FLAG_IMX_PHY			BIT(0)
-#define IMX_PCIE_FLAG_IMX_SPEED_CHANGE		BIT(1)
+#define IMX_PCIE_FLAG_SPEED_CHANGE_WORDAROUND	BIT(1)
 #define IMX_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
 #define IMX_PCIE_FLAG_HAS_PHYDRV		BIT(3)
 #define IMX_PCIE_FLAG_HAS_APP_RESET		BIT(4)
@@ -860,6 +860,12 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 	u32 tmp;
 	int ret;
 
+	if (!(imx_pcie->drvdata->flags &
+	    IMX_PCIE_FLAG_SPEED_CHANGE_WORDAROUND)) {
+		imx_pcie_ltssm_enable(dev);
+		return 0;
+	}
+
 	/*
 	 * Force Gen1 operation when starting the link.  In case the link is
 	 * started in Gen2 mode, there is a possibility the devices on the
@@ -896,22 +902,10 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
 		dw_pcie_dbi_ro_wr_dis(pci);
 
-		if (imx_pcie->drvdata->flags &
-		    IMX_PCIE_FLAG_IMX_SPEED_CHANGE) {
-
-			/*
-			 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
-			 * from i.MX6 family when no link speed transition
-			 * occurs and we go Gen1 -> yep, Gen1. The difference
-			 * is that, in such case, it will not be cleared by HW
-			 * which will cause the following code to report false
-			 * failure.
-			 */
-			ret = imx_pcie_wait_for_speed_change(imx_pcie);
-			if (ret) {
-				dev_err(dev, "Failed to bring link up!\n");
-				goto err_reset_phy;
-			}
+		ret = imx_pcie_wait_for_speed_change(imx_pcie);
+		if (ret) {
+			dev_err(dev, "Failed to bring link up!\n");
+			goto err_reset_phy;
 		}
 
 		/* Make sure link training is finished as well! */
@@ -1665,7 +1659,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
 		.variant = IMX6Q,
 		.flags = IMX_PCIE_FLAG_IMX_PHY |
-			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
+			 IMX_PCIE_FLAG_SPEED_CHANGE_WORDAROUND |
 			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
@@ -1681,7 +1675,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6SX] = {
 		.variant = IMX6SX,
 		.flags = IMX_PCIE_FLAG_IMX_PHY |
-			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
+			 IMX_PCIE_FLAG_SPEED_CHANGE_WORDAROUND |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.ltssm_off = IOMUXC_GPR12,
@@ -1696,7 +1690,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6QP] = {
 		.variant = IMX6QP,
 		.flags = IMX_PCIE_FLAG_IMX_PHY |
-			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
+			 IMX_PCIE_FLAG_SPEED_CHANGE_WORDAROUND |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
-- 
2.37.1


