Return-Path: <linux-pci+bounces-17324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8217C9D92F1
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 08:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAB08B23496
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 07:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC361CD21C;
	Tue, 26 Nov 2024 07:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MNNu2BGX"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013069.outbound.protection.outlook.com [40.107.159.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47CF1B2192;
	Tue, 26 Nov 2024 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732607914; cv=fail; b=NBwnYncerrNOKS2PHB+lbxK9eWfRCtS938cknUyvwSYm5s3bYnEaTqf95XUHPk5QySnLFQdwwpYnSVTTCfsnvz7x4dmJYnSH2Dmps+d1+06JxCHCarEvQVxNpvP+4L1XVrEr8p65syp/CaQ+H9y9zPybNXKBDzrrhyYr26bKBtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732607914; c=relaxed/simple;
	bh=Xj4iXkotqS4k21eagw1ilt69fbfuKnuvO5o1ZkzGW1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EYNGkfSfvmEIO6i0NbYPggYC1yghwzXHsAF7cOuxnJ+DXAlApusvPlm71i3uODhRZ0Svya4iRKUtNHKr9I/RMLrNwU/DG4orOA3s+XtiICMxBm/wIvbDdqBiTNYrqjZvBBbfe7SYRtl5FMqK5IGiHQvgx94pNmBlacMxmeKLqXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MNNu2BGX; arc=fail smtp.client-ip=40.107.159.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALyB6yLJ9VWwjsV57T8G2Apiagbxt4f3omTshYhZf17QDjfYDAMH5XfbfWUAsGLSfvVjFTZKWkIMLDg5WW0IThaTlBuzEAdtkoMloIvq8NI5Bky+zo9LmSxSCxjNq9ysVCNcsI+vJaEDMKFvVPUXyU5BhSQ/5dvydZgk1gX49Ki6Jz+n5awOtk7X4czjXR5D5QZo3qJF5NxRWsFFFvpXrXwf0d1+5WXK8/7cp/S5wQgLk5dyWQQuQ1zcq6wj6XX7k2L9H6YB6PJza1It+1sD+ZWDW2oVHzkkL03bvyAyC+LyLVVLYZYShapeHScn9JN38D5LK8jAj6JHkDeSUxiVpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1I9xxrN2Rh/xWirdR8GNL/HnNXIkRjyXKY9PxRLBtd8=;
 b=v0868kTI/vJiKE0dGIVY8uwZY6SsM+FytRw/mhcrTWuil9h7zESmcvh8PcwEo8nqp5xg+HA4dmThT0ygO+4MNsmdyO7WQ8df0bE0DPbz8WSRvzETyFB2ecL4Tub1dXPvh3viWhWG/HsNmjq3UJmi1U4tVcQX63O9fGvT7Z8wBw9cMHw6+jhpzfI69XXfBwpbU621n7lcBGBon8uw7+WfwSXTUkknqMA+k5fMz2aWfXZSlYIRuYTs7wc7iM2nMm9YwxG6wnwQo1DnLkDr3v1YD/GJhFVBoMHpV9sLhE6X/lUZDr66O5YKtV4EGHaiSdR4Ao4hMThg4T7wen+DHUCYdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1I9xxrN2Rh/xWirdR8GNL/HnNXIkRjyXKY9PxRLBtd8=;
 b=MNNu2BGXO+ibiCekeDeFenSI3z3ewqblhyxGxV0X2gZWAwlGi+1pwQ/kJEHRj2fYm2CUqOchr4SDiWna77eUMc9GPVctPoEFQ4yvCVR6ezFzvau3ATXBNvVlpeZtWmq/TyCfG2DD8qjxkN0jJdqxOEfnXCPf/iJurew9QaXu1BqXbbLKNw3eKAVFfTbS0IBdE9VS/w8BAo+dSOEgzP/mu7rPIGKBsDbSaYhiVQImIBNprSSCB0VGjyxTf1hL3Ar1I8GAoqJ0vNzWO+hwXQSSs78XmvvszJFeCx0yo0bZy2vIyrkbtktA1Dz4DDKoNz/ka3QYmkP+kHLK2x0KxfBWaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8489.eurprd04.prod.outlook.com (2603:10a6:102:1dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 07:58:29 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 07:58:29 +0000
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
Subject: [PATCH v7 07/10] PCI: imx6: Remove imx7d_pcie_init_phy() function
Date: Tue, 26 Nov 2024 15:56:59 +0800
Message-Id: <20241126075702.4099164-8-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
References: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PAXPR04MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 9660762d-6c8d-4228-a002-08dd0df01d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?47QHSo0ZUPdeqDAPyWBhFsfCDWHpBVPI3IFtrQqs7M+to/PuWUZ2UJNB1YwF?=
 =?us-ascii?Q?bD3NmKLd+CxLwqJXoqccBlMcjYkfrGUigcLpO4T160mOnzX/eyFPprSMD2hM?=
 =?us-ascii?Q?X+temB6smI4sbdu19QCbO88BzCzIKjtYaRckOLQd+f919F736zf4sJRnIGSq?=
 =?us-ascii?Q?Sbp8pCZhbdsVe7awPsD+/KZTUrNd3kUyMtlxJocaR03/Zi+xDlw5yFva8Uzc?=
 =?us-ascii?Q?nkiaJ9KFBE6aK9uHmZGq7GjD/D21iMrejY6b4e22QM3Z7GUiRwdwMshIqlKT?=
 =?us-ascii?Q?yQWGzzCaZCZ+xauus7NrhE8QmEclTGQC7qd+80y9vGRW136pW/u+gG0pMaX5?=
 =?us-ascii?Q?VPnWLN0kGV8R1m1mGSr4GgYNhdpHkqu/cbOznQMhXlSw2bydZXb654BxsYG6?=
 =?us-ascii?Q?Kk+OqSHgdNHIjHPu463XgpoXpYYe63D/BkNhGaK1dFrH2af/smG0+RP3ZSmo?=
 =?us-ascii?Q?43aLil0Z3hlsEhbv1OweKbm5/X2OhI6tUpTvbX85qV5FV+KlN1hBR840QjDn?=
 =?us-ascii?Q?SipfX9ABLkbi6fh2/8t/FqUoJ/HNIfk3m0IY7VkbQkyL3d8RW7Ae1n5DoxSt?=
 =?us-ascii?Q?IfQTKRaQtX2eDMI2NYjyQtoxBUPB8Bw8+m1s1wQn9v0UToKo//9+xazM577V?=
 =?us-ascii?Q?iE8W5Hg52zRkBGrWtglFVSBWSLFNHXlWm4g9vF0r42Q/W3zKjZLWb9I+kex5?=
 =?us-ascii?Q?7x3lyBhFWA2ev5dFxk/7D9CjLbeRImZlJZQAHKzeyJHvOVJUy/h+tD7P/+Eh?=
 =?us-ascii?Q?E5d+U2OHcqBaXju54Z2JltrqVTUbm3Hqx9pT8RO2pyIY/biRv6DGTQAJHyxR?=
 =?us-ascii?Q?ZiH4cMIZIq7SSD6jt17E+Kips6APzvor3837uPkXJnnn8zZHunt1XokCk/AS?=
 =?us-ascii?Q?vPGclPIH0ybUvtiIC4wjuZx7IdhAdSfbPTT+mu2U4X94vwlMCLTaDpJDKmu4?=
 =?us-ascii?Q?467N032Ti2iaTTvDYbmf4I2cbA8lGFkxie2Hf69OsIX3lE2lhfyz/iF3DjZi?=
 =?us-ascii?Q?pmJltAcYvO/b7K67UkDwPrPNMQR4HYxZbgsrpi3Qa1LpAe2eV6hDqzgamQ6e?=
 =?us-ascii?Q?gWH/qY01dHMECWuI2vvnzKwW4ISPSUTo9reRVxI31hUHa02BQ/tkMC8i2/GM?=
 =?us-ascii?Q?6QlbSnBnFA+MSNieaJfMZ9W7btFXvbhR9P2R7JFXEQFVGraAPv12BmPd+RTM?=
 =?us-ascii?Q?qiY3DWnDrxU3NA2AODhcpIzvg4F0GRjHq/hSrz/c16IYFF9Md2CM4Xei5ILe?=
 =?us-ascii?Q?1DjH0Yr5RM1cA3/b5byKTgmPN/8wD8WtJJIyctLuqtFf6yWfNDG2wv5NAJbV?=
 =?us-ascii?Q?QVi3798I30lDcEqnvxCYxW6JO91epWjBRLQ1y/l2I0ZyQqLPl+RsGdvihDXk?=
 =?us-ascii?Q?8lZGVLWLiiEoMgnmwnGQWJcomo8DCGfYhOklh8Rut0tsTzv7gcuqTaGSQmfY?=
 =?us-ascii?Q?+89r0kENIjw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8fz6R+wYm8rzfBtp/ImH0MlvcF5PpQn7hN7hOm5FzxYPBv0k4W8T6IrwLqzN?=
 =?us-ascii?Q?dVldvMdyok1U1o3VXEfmPexdD5e0zzdmlzgHkfua/CxJX0xfAhVd1reTFSVZ?=
 =?us-ascii?Q?a7psx0XKIae66l5USqjbtVlN3/OHzsOgBZE2PfW7IO4XKbGLzZ9cLWTRRCnt?=
 =?us-ascii?Q?Ya3syNumRnW9DsCzqnTSw/lcZ1MmGakJWbbXYKUdhMICKm1UAqhVEOYP09UN?=
 =?us-ascii?Q?bRQ3XNXcuOEGHXZv7nyrERDEW62whvla+CM5hdAwokIldF30JiQKjAn4jmh0?=
 =?us-ascii?Q?MlQ+wYUBUEsGIpjqD61+Mk6uDtghHq4RPVXuZ4z7Aq0CTDjzvphc7wAqK5GS?=
 =?us-ascii?Q?yi4DHeEMcHEe9rze3udXifWVmOpygw2e7MxhawFfefnW50Yw27nNYTrh8JRR?=
 =?us-ascii?Q?WjJkrfpm8D0OAcG+T75l+oIShBzXoPgzeGnQXt4cbFsdaTlD0YvORAND/aa0?=
 =?us-ascii?Q?rQbHiCLo79qRytUhPnxfCen4V4I0Az9YPNXxks2m21dnidQsQqYQPxSwFECX?=
 =?us-ascii?Q?teq6gXmIWRpuzWsX+F9vS6aAYIPjbYC4oz4rgJw+Oef5Er7tG2fQHJOso9wi?=
 =?us-ascii?Q?/Z4lZPoe7D7A+vURVRssTYks6Jlg8IDD3xSyejeCClalWB0VWUz94y7iHAWJ?=
 =?us-ascii?Q?xckAZRvBvyzVaRUQrOZGnvmbzhAMPN44VfhBPKS96q5Er4oRxSTQBZqxagg3?=
 =?us-ascii?Q?a0DqFlZdSkaFoCTIW9jxmGAUYhIJlRyA7vdJPPNZsI3ctFdLyuVHp/wYd26H?=
 =?us-ascii?Q?ycOsBcDvTktNKWenh0cL29JYQZj8PxuB2CM9mmDTfuSiPz5bMy4iwTBWG+po?=
 =?us-ascii?Q?Hpsku9jUmNFMoYNhqq0vFeckLC4H9ug6GwXirpGBarqJ5eW54e/+LgFFy9SN?=
 =?us-ascii?Q?o4DXpUGGHuK/3jTqaBgih5jkb/jkJbAxyb8vywaEFFixNXuAQ1MQsHpMQfaI?=
 =?us-ascii?Q?8Nn4RzF/lPoKSd4t2k9EI9rRD3LSW+M8vXeWSI7pHsWfHmFtYKrrSpRjB2IW?=
 =?us-ascii?Q?s2JiF3Q/bxmGg/KqWdGc3UUAWybzi6Zg1iheTlZv99DPIFgRA3SDTJ1SJcfp?=
 =?us-ascii?Q?Bqx2HTBqAa7xeRNWoheCZRH0e/26Qkaz1ISOHTkxY8nm6NyQsrr9NoEuK88r?=
 =?us-ascii?Q?p/5IbhAhKpZetWlHhZmaIHx0F//7VoOjqlVsCy8jBF8Kcz4mKI5R4GvmkT5q?=
 =?us-ascii?Q?fwo+WZMteqr2FhyeU6lTOEIP3WdJjq+5G/NcnZxcD1c99R2MdkXyblb0cvxf?=
 =?us-ascii?Q?S5Ru0vLETVKiC4Otrb6a+aJQH00Wz9YRSHN/yhaEQ8/mV5hckjtFCirT3lY8?=
 =?us-ascii?Q?Z8UqY6t2mZg7LkJkrwnUHTIaXfnqYr3Itczm0dqlhLzT8YZNzN0LkjWz+03r?=
 =?us-ascii?Q?ORWArG+0NT1ySyTE0jWovXn8uL3oKoTrvUapEAgrR42C7094rXgTvuPMiWDl?=
 =?us-ascii?Q?lQU6j82eVc3m+8c0IwpHuPrrTn5a4yzQ9YKsHACqJxqXQuD/3fenEPwLOlhp?=
 =?us-ascii?Q?576P0OMN4fLS6ZjoUg5z3SY7OCKI1gupbsspigR2r9ybRcI9BsqKBqETsHon?=
 =?us-ascii?Q?8TazyKBiolye4r9RFI89pbimAog9iHBI/ll131c3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9660762d-6c8d-4228-a002-08dd0df01d2b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 07:58:29.3235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UErIZcrJHrGP7PwfuDJp4FGeqvIVYWG1OcnyNYLG1nOnwQhFx/xJyMs5aKGppMneKa6SL+JJgAEBN++cMCHdRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8489

This function essentially duplicates imx7d_pcie_enable_ref_clk(). So remove
it.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index ab2c97a8c327..743a71789d17 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -394,13 +394,6 @@ static int imx8mq_pcie_init_phy(struct imx_pcie *imx_pcie)
 	return 0;
 }
 
-static int imx7d_pcie_init_phy(struct imx_pcie *imx_pcie)
-{
-	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
-
-	return 0;
-}
-
 static int imx_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
 	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
@@ -1554,7 +1547,6 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
-		.init_phy = imx7d_pcie_init_phy,
 		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
 		.core_reset = imx7d_pcie_core_reset,
 	},
-- 
2.37.1


