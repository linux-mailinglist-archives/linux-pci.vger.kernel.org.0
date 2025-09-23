Return-Path: <linux-pci+bounces-36744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6545BB94D2A
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 09:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 159727B12C9
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 07:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DDE3164C5;
	Tue, 23 Sep 2025 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i9hc03/5"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011049.outbound.protection.outlook.com [52.101.65.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C66316191;
	Tue, 23 Sep 2025 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613217; cv=fail; b=NL51LS/wog3ZXBsdegwlTnYGYE87y37NLjyOyReZ3EvHc8snU5Cyhae2gmijXHhSE6Y4dDN8B3K2Y2KggI/O+Zow3rnYGKtnlEAKlsqSnheqTy13hx398zkEDT2PXOi6jF+1DU5k1Av3oQrAoP1kEw6QWqTDCsFouGiABxAnNmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613217; c=relaxed/simple;
	bh=DRelEcYBSkVNI0CgHc9M1uCxmeLhjhnsZx4OgU8cF4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WGDpycCGKVjEcOa4WspZ8SgaUxSs2N0RXZ5tq9wXOYmLidQ+NM649Yj7oH7A7VAt/qwsFMehE1kP8XJBMNAX8KpOaMwR3MTrNSxVK1WlqS+H9u7YlQ52OsvmLWGIwg2ezfuvPApxk5Ge8DSlBanxhgs7DWWVrdKxLKugDse27no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i9hc03/5; arc=fail smtp.client-ip=52.101.65.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hi731FeAqRMHRomqkBK68LELK106fCLsiAW0DAGVczXzqbLponZAKzhuYArvFtFoatTIux73zcDf+2rnrlIbDj9Fb2YqkusZdW0A2dWaCf6otmMYdXrxgFz5Mn3ETd0kKxacpCq4F8Ylt2Zca7QW8qS4wVwudYUANlGeDwPAXMaJGd5GGl3t2ZzZuo7NA7bzGfc/hKKFzMjHAHzAprbVu3D8X51Kk9IpZCyb0osRqvXv2qP4aE7D1r8W1SI4K55GWO3lYMYDNhIuV3m88Z7QSXMnOtQXi1yfaaaWPTqu2Ewf7ZIWQGTrwGefPaT2X9QOnDsyww2pUawBNTKrNtcD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcduZLoo/npSKNNeCAfoMdR5ukMyCAWcF1ZInVV/um4=;
 b=LUSx3Da+lF0d7MgS1MmEsPPCYGQn3tFn9TQpsBRrBRcsCrgwFXkdlPHuGBkrmYoH4Nll6H4uJ1YsZ7pGjlXNxh7dHNvpONfGWvH/Yevon+N2Epj2fG9J2WnpIuMXLOwE+J+CPpcKoV9Prr55kIKQW3g9W4sNNdo8Ez+ljOQ8OskB1GxXo9z9l0wMJyiSDeuwuJk+6rVdV+mWfYKIjVyGTFcB7HWzTFlHMYgPZ0Dnly2Hzf5Fe5CfN4DQZMf0mnaBNj59sD3eIRDEs39biBifl1nYb25qF0vmhzs/QM1doEm6FsvBKNxgayFX/cWTS49Y5/6gvz5XeomqzMM40hSWWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcduZLoo/npSKNNeCAfoMdR5ukMyCAWcF1ZInVV/um4=;
 b=i9hc03/5zRvCdT+R5xoUYqAn1GtYkYPE/4F5ZbTA7y+l90+SG4QwIyT9VRHDFFsakribvTVKlY9xm5LgKJ/hQa9Tx8hdt9eru/kkol3TjiQssmr27ob04cKZZJUJ52/JXuRZIDIVfxLzTkjY9ZaRGe+L6Vyqo1+kz4Ina3WYs+eaL+oIvYehIA2nEjvTJgEBsgh3kn3mdxP8DduFY4Cg0FkkAXvS74HzpfhiE5Dj0RhXBPi2LSeDfoo0Li6R/wKUyygbp1htKu4mocsY8RqL4ZN7NDBBcqjJ/JnOzeyrilCIPzeCndvUwBGskIhi7movFgUr8ZEut7IG2L6cP92rpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV2PR04MB11446.eurprd04.prod.outlook.com (2603:10a6:150:2b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 07:40:13 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 07:40:13 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	jingoohan1@gmail.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
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
Subject: [PATCH v5 1/2] PCI: dwc: Invoke post_init in dw_pcie_resume_noirq()
Date: Tue, 23 Sep 2025 15:39:12 +0800
Message-Id: <20250923073913.2722668-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250923073913.2722668-1-hongxing.zhu@nxp.com>
References: <20250923073913.2722668-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|GV2PR04MB11446:EE_
X-MS-Office365-Filtering-Correlation-Id: d7114ecd-3fb7-4562-bc04-08ddfa746e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/ndMIlEh/me+x7TAB0EqxNg3M1uhwz+OSQeAPnV2+M1jQ7UbwI+9WcQM2sxl?=
 =?us-ascii?Q?TFA6PXT7vKqO1l25e/YCYX6JDVGjEKObI5S6d2ZggPDqwv0UQdfUrImfzUKa?=
 =?us-ascii?Q?AaL4VOlel5Q2NqGcsdJJ91qr7zMO8yrymsdam/waNmz4iFQwrNtZ1VNmFglq?=
 =?us-ascii?Q?nJTDGWNs7+Wzwv1Pm6rOQHXJ1kgCLjUMKoEOIDSpFluBA9sBFg4p1ndwFhng?=
 =?us-ascii?Q?DifgLvPS6PC+MvtHohhyM1CtAAc9umXHLKDvIrnbZfPJzN7USTX2al6NTFWq?=
 =?us-ascii?Q?Ufd9sfgIXdylVNUR442Llpppory4M58A2NpkBtxuJKXZ0SUM3le6iQzp/d2o?=
 =?us-ascii?Q?kyo+ryf7zB2WrRzTEJpefE84EsSUyThIgEO9WsFmzvkbT9dEBMtMI9Wmy7pi?=
 =?us-ascii?Q?O4RaZmr6SWhVqN8Q/ZfA9+HOQ5dAVcBUOCx8nmnLVQxibPpNRZ62Z87CPii7?=
 =?us-ascii?Q?VYQsqHFvnVFGqL7N+guKuAnPr/fejSFsA+yYw4iGauFpzqygpcjwk6mAUqIB?=
 =?us-ascii?Q?PXy0CFi5PlYvVTHOJSKZOARNzlY8VlNsUs0fEqXM5VCPCxbYtyclsYoL3HqR?=
 =?us-ascii?Q?1XV4FxG0Zd4sbe1VZWH6x2UbZrLEX1wS5lSMHOmcQ9ZTMrUdbJ4nhtaQr1x3?=
 =?us-ascii?Q?whIZRQkZNQrz/PB9XWXGaOKMEaYX/QA0NcMnvDCl1DhlpdEmmjP4lPsOMkZ/?=
 =?us-ascii?Q?NlBok8yIRRyrKXQLR6Fz1dT8Xg6zuIRHd/YAbpurq7q6YorcwWiakCktKKIl?=
 =?us-ascii?Q?+Y3tmW+CR9Z40Wammn+rQzp0X2rkQsx3RK6rpI3cSOpNFPAiKTnPCFXmgbjs?=
 =?us-ascii?Q?03JANGBquiN/yp4FhGBxieT7zWUHMUk7k8byDv0Z6wWJz5rb/zPQEwXPoEqQ?=
 =?us-ascii?Q?w+qfCzVh4dndg6MfXdHbTj7G2Da1dX+Cb4poejAFw9XmRjmwY1H2SikNh+aq?=
 =?us-ascii?Q?Q2rF7GHlz137w7zlhhbVaxZ+AML8DvSdFBUSOipxmv3j2I1Y3VmViCjeuUh3?=
 =?us-ascii?Q?TMOGRpzSUpozHw2+C1VhkaMjJ1CfSzH4Wi/tX7I+Lul5flGn+BbT2kMlPGP8?=
 =?us-ascii?Q?bmnYrK8/NrR6BG+WE53La2akpjfvlNjmHvT0/PWcEDN4xJMIyzho6SI37Z8d?=
 =?us-ascii?Q?/eTHtZCaYyqeDQAoy+lgiNNe+ZgA//RxCU5Z93XwpwusKmgn/+32tnvReL2H?=
 =?us-ascii?Q?3ilivG19xIC4SX1jJIlhY+iseWryMQM3+qrCJjwYRataqHPd7Z9WjyTEoBQL?=
 =?us-ascii?Q?khQDtmmSU0jcBkkh8v0d+A1/iSiwAOUigNNDmQuH6JvCDxYFYk7PQJRzQpNg?=
 =?us-ascii?Q?w4oqRpt8ny3c1PGkQg04VFzktcdysUuyJX8RiKy4l2Dc/YPYb0KQ9+PBNgTX?=
 =?us-ascii?Q?8QB2pkMIxR4gEpqz5VJuSV4S+WW9xuOHBRBF9kK2TZtxAQVSFob5tgLyHIU/?=
 =?us-ascii?Q?haxOGQe+chxQsbJXQBoD2sv/Tudt06L6jXvUScat5VQj/qOHIac2DY9gdCFn?=
 =?us-ascii?Q?1p5EUjF7BeQZ9IQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D32ML4Fpdqeb9Cw0Dh2zI2sonIAI8zMeG056O06krQxnTyGDOxhLArjgu6yY?=
 =?us-ascii?Q?K7SmqL9sFNx9faaCqnID6WPW8VBM47OaK1LNgbBQ6SkfvRYbVoyiYiTGcGsA?=
 =?us-ascii?Q?NBxr8gJRNBWG3qrTeSF7utq4vy8H0MW5ReFr/Vos7GWghWJRSs+arKP0GbFD?=
 =?us-ascii?Q?6463nF329YtP88HixMpYCX2wC6itImAqnZxUWTr/OPQyCfUlqUE51DDrnKLN?=
 =?us-ascii?Q?5uTG4Vs70mrDqTqD2iJ+if5HPAcPirjLJu6ceklVXNzqNIkG2UaUbxQxVA/K?=
 =?us-ascii?Q?rGtZA+W+Ool87k4NxXPh+3DTioTCcdwGD2Uh2RnviXwag4pheosJtaAcxL7t?=
 =?us-ascii?Q?jdkvajnr7bwvovNRDIW/pDxflwsaD8bMm8UQmBDsgLTqakrrd2kfPyLDr9Ik?=
 =?us-ascii?Q?UTEuYupIFtUIqjhDjmza7DJxjC4NkTw9OXo3vwirKi6dKAlqQrBfzx2p5Nzn?=
 =?us-ascii?Q?5FMxPOybE2Dipb4u6Gva23Oza37s+8SFK8YKuXSskmN6TmPWluSqz7ymHC4u?=
 =?us-ascii?Q?29TrU0DFP1XNMPG8+wEfAoDUmVGLIhjVQdQSY2aUmNJSZcT7R0o/aDzBkmRI?=
 =?us-ascii?Q?EUw01DHlFYfN8MbPOtQw1eu34/WNFaDirQmIR+BqbyVPi/Fm8Ys0d/Au1/Is?=
 =?us-ascii?Q?UR56tQaBwLHmzPCcXB3kiZvjpvUMt0EWLEGDWqcDCdp2Va1tu4nazK4Dz87Z?=
 =?us-ascii?Q?JdBPfzzdbQdTj2kkbz5TdSGqqhm3RPASwZxm+L0PCBcZzZlZ1Sp8USaZIjBG?=
 =?us-ascii?Q?i5yC4AMzi1ZcAuOA75YrwpmSta8qm2WNjx9gIfFDdwx5PnESHc5LWmVMIbew?=
 =?us-ascii?Q?TeZ/Vm1M7PvK8k0qTd9aoDHs21dz+KuoO2ak5LT9Qe29Lt3HXQIhStqjWswM?=
 =?us-ascii?Q?aayuVEUvSuUmzk8pwMrvfII7YiXDOttyv2alr4X94jkFYOvRGo4MoN4fKcCa?=
 =?us-ascii?Q?WvqFKisVh7beHwhgT/hwJaYEMxGtFYAZHG+WisQVnx8fAI5XJQmEVoMjVvwL?=
 =?us-ascii?Q?wZgqi7dqRRubVlXgKXzb/YD5ITwAdMpgWGzowA3uZxYav0KWbH1NkSdEhULm?=
 =?us-ascii?Q?5LcKINnPRcqmhcl0Z9pMX6kaxMGyoblvasTBsSbRVWXmNkRSW7mdZwCVh7VN?=
 =?us-ascii?Q?Ze9zLIgwrO59w9v5dDqRDgDUCDSpYvp+/dY7YAwh1KHUAvs7nh7woMaKvy4W?=
 =?us-ascii?Q?S8mQgcgSMZKzFuetkmNpTrLs+Pa0Lgw84YyS5gxXSsA9N9Fc+h1EiKfDWOd/?=
 =?us-ascii?Q?A3DzDrt9nPqDlxwgrFEy7sg3vtXPHlLtZ2C+5LVZJW3/h6FzKJTGsniyOjDA?=
 =?us-ascii?Q?tG4z+IFmAQSMFHjMWqxYdtrnNcwHqSwXSzUmjg32djU2i6u2vMO6HBdwCr5j?=
 =?us-ascii?Q?LIVjRR3baeeFG2H5ZnfgssC4ZPKPF8a+JkPHyh6qd6Kwwc5FtVEAQmLYcZJl?=
 =?us-ascii?Q?0Vuucaqs9SWKgXiQdNehEOvDtnwiWPeiHIT0nzQ4YvWHMINrFRCxAKLa3GQp?=
 =?us-ascii?Q?E1QAl5ylUGbd87FXdF+zmqJpiXgOrwbXLqEndmVR+4w4XCoFyyDsxhYrmNT1?=
 =?us-ascii?Q?Y8VrP5MMbYGn7mxKPjy/BOwTcgf+JAfUuYkA0nBo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7114ecd-3fb7-4562-bc04-08ddfa746e2c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:40:13.1844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqKnOQ2JLVjBeQ+0ZnMOy0nnU4UueqVJw5bxJAir5aiTwOXNN3Mmhf/oopUSVEIpEP//5D/QW3aY7/y6OsPcag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11446

If the ops has post_init callback, invoke it in dw_pcie_resume_noirq().

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 952f8594b501..f24f4cd5c278 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1079,6 +1079,9 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
 	if (ret)
 		return ret;
 
+	if (pci->pp.ops->post_init)
+		pci->pp.ops->post_init(&pci->pp);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
-- 
2.37.1


