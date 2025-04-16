Return-Path: <linux-pci+bounces-25984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C955BA8B30F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 10:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16CE4433BC
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 08:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5A022FE0C;
	Wed, 16 Apr 2025 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NLNXhEqr"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8391D2309A1;
	Wed, 16 Apr 2025 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791295; cv=fail; b=YRz0qUX7mmGhZRK37L5AWschPxNmjmL7BBXsiGP2Pqv2h0KiQW7i4qffGYTe+aoEyTokZbaNbbNC4xXq0TodM+cEWYVIoaXbgmeLcts/5crNMPDv1KQpNV3J9pkm+fuur5IG5/swrwy4iPWmsg88u6v2qmjGiVKLMok1xdtE204=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791295; c=relaxed/simple;
	bh=tP1y8jmRInkN0Uqi18FgtepIcoQcsm+fwe2mjuJxex0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OgL0i4VTDw++hI8sy920BdAyoagww51EbmueP+/6z2GtgMSIihdGSqr7gtv9r0bVjqSJu2eqx4jQoieOwvwEC+BOCSXLXA4pGj9QmCksCgOlMo60+gKZj3pe8Wudq9nsBTyhj08hIJkaNZA64W+O+Xb6saFFNgSq156eNwnHHEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NLNXhEqr; arc=fail smtp.client-ip=40.107.21.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCy4+fDIEcvWDJT41o27Js33zc16OeOEMBV0a8NbFDg01dBy/lYqvLLF5NeE4b7LgWJILoPWUWcMlJIVqOD7Wko3BpgCIA/XHw8856dP6Myd/Xf4SDNdJRdkXwGiHi3tflbDIOtIHjPXNrB25Cohiff7xGxyCig/pJbZy314ZcghzZfDf85CIRBKUPysGr3p354Yr2fGy6B3ykvm8arCET5lCjJukt9PGqjBYbRFFMHQvRMd+gpv+EwfppzBAkvqu7BPxj/GtZgu71EAuvsZiIw5lJo/WHOAOg8zxOB9rUGWrt/aXDqbHRaEePXNcVLK01BXByz1hcMKWBnjiFeS9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iPa7OY+q2H5o3W66scZBiAuu7Of4yBZLJcG45hihVM=;
 b=u4Uxdsp8k1idteu2AEa71rq9E9pnmsv5TFh43nvZ/YCC1Eae44nek3jwlMPJWTHKiZtHeJH4Ax33BjztIOTnGs5OMgoXGgVridmPRQ/KAmpzVyQSjY5UrSQPVKL7wy1/6MtXCQ61XYB4dylEk4SWV26gH7VG+AaDfRQ66268d/ol2iIQsA/TERnGwdp6FPj9Dv+rEmgGc6n0dImiLIMaWkvggaAofFlrA34FG+e4izgYtUQuxTEHqdZkPLFwkGGhgLZTWV7/5HR1rU5lXTDaRUDUTlRcdVOcnt+eTzqeOf1xag1g738n6bl5PEtqveCNGCZxqZjhOUHFCDfrV8snKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iPa7OY+q2H5o3W66scZBiAuu7Of4yBZLJcG45hihVM=;
 b=NLNXhEqrinOzjSLhRWUeGB7FonhHZi5Zl6SuKyqquAKtkXHV1DnZcrOD0Hfac5/djjGl8M7o/f2yfOtn/aIvcz/abRNzQi6617LyvRhGtFESgSAPujYUNg5NFkuBnBtmH8+POJ58xzFmxBKl7XEe314xM0GywHO7nnSGmXOaE0nsDIAu2zptHmK4Cg68Dh7s/q8MzYYaK/XKd9eNPfy72eueB5WkAsDdwJMz+GLhOcnlZMIbzlj4Os5+pfF0NS2ZJaE8n5Zou2oJS9b247PEh5E0Ld6p6Y10xPm2fjF7mqbcwmClglDzB+HPpMmEJlvIqiQB1KEfBIyR1zaI4Eo3tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB7103.eurprd04.prod.outlook.com (2603:10a6:800:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 16 Apr
 2025 08:14:50 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 08:14:50 +0000
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
Subject: [PATCH RESEND v6 2/7] PCI: imx6: Skip one dw_pcie_wait_for_link() in workaround link training
Date: Wed, 16 Apr 2025 16:13:09 +0800
Message-Id: <20250416081314.3929794-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250416081314.3929794-1-hongxing.zhu@nxp.com>
References: <20250416081314.3929794-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|VI1PR04MB7103:EE_
X-MS-Office365-Filtering-Correlation-Id: 0006012e-7014-43ff-20dc-08dd7cbec23e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IGqNjUV3vFKY1JPYHi4DI1w9+k7Ep8zTp20FUxaJi9h9j1gLWyg+shp6qAhj?=
 =?us-ascii?Q?c7K9jGpDrI8x/tR7kt9cJutJroxpRs8pf/R4Xw7N1Ypdn3uaoCo0qK5Q9Dxk?=
 =?us-ascii?Q?1t8wbsVCnEt0yEUJBc1OT5yl0nFHNPkQvMF1oM/FebbHrqqZhcvyAUT1Xssm?=
 =?us-ascii?Q?Tloq3ikbmFdXIOX7fKA7tA8lFX8xkPkCqaBMgkUIwsaWRqeAfPHQezetrNcz?=
 =?us-ascii?Q?8g7IRvbZ+g/JW4xKlSUKtVfIGI/1i9A+OHd0qXyl1Dqmv3w2i9CwInnyw6Qe?=
 =?us-ascii?Q?KJaAYTdqsMIEzJ5r/f/8KUaakjVhxnfN2LntI8QnTI7TA9cAWHn7veq9VhPW?=
 =?us-ascii?Q?XVxGjW3ZTHHU2hKUaunbwR0pwiGrviBq3mT+lskw8eSf7T6817MRaopH+2MM?=
 =?us-ascii?Q?WSmG/fuDMOJe+BvS4K1sF1+NwCKnFigIfb/zKzoVYuQDLVLwb6c3EQjaXD1L?=
 =?us-ascii?Q?maBHGpCRXsesUKqFQPqvTXeyxwdtxrcAglD0AJKKMREx03hxqS6mT5PVmu07?=
 =?us-ascii?Q?4guDCewlstLkRjGqUDw1aM4+g3aqW3DhSoDe9GTwlU7KtO3fYmImWqKbtl8S?=
 =?us-ascii?Q?kxZILdqZQdR2FL1YkzUReBypnfXRJ1j7tBtyf7nS/G+tQPL9oZQv/ctaGHuX?=
 =?us-ascii?Q?otizSVkCuaz/5V7tn4oygcpjca9NaGPLas+piGK4NnjljBkR8ueN/JOz+ido?=
 =?us-ascii?Q?aqikqXDJvOqPl9ptCh7aZ2t68AqYZu5gtWUcTTdZwWdeOSjDxROWwsd/oQgF?=
 =?us-ascii?Q?JtJU5SYa74llKN3YrA8iuUqBt03bGHqHb5WARGiRSTlpRnzRhB/KMjhkl70y?=
 =?us-ascii?Q?lcqDMMJ3vyaYvRhrZPvX1QdB2jRVYRD2DQ4gwqjPYySLH4VNPAdygKSCOsHq?=
 =?us-ascii?Q?Ihi4/1Ix7wyPVI+sry3ZkCooNGsOZoeGPwWYFoToPrrjfuCERAfSHfFzL2Mf?=
 =?us-ascii?Q?C8lc4xDUPruM9wywiLHgiA5aIiFiWpRprhEuUgk2s5vUlDlDNtKVOKhzRQXW?=
 =?us-ascii?Q?Ks0rDgdZOD42z+vXRoG/WUufPHpqs2RIsZhT9aP/p06SJedE+E1YljBF3RT4?=
 =?us-ascii?Q?zcKujhAILAlu1yZ0uBIsKEyghP2Clg9fFdij1vvnZyNUPiEcf8ZquW71v0yY?=
 =?us-ascii?Q?wdQhuijuO9Ra8WEYAW5/SC+uRwOCGNVYZbQFXaDy/ohh68gmUCYdWFq4e3gs?=
 =?us-ascii?Q?m1IaripimAZ5ZRrSKOM4QII/kBf/PYHDjKR9J2QdN8wnobh65DNvw7hL8CuO?=
 =?us-ascii?Q?6IQ+yfDPEAwS8U3QWxBwjTFWHBZubVIW8ovPfzow5yK0o+1ULhAJ4y7tj/pV?=
 =?us-ascii?Q?1ZHstUYCDzkirCeVP0MHKji4HftOF/u+IOeffTPnV6hV+L7L+qsycR3vKAQh?=
 =?us-ascii?Q?LB/VLzS8H1Fb+teh+ZGMzR6UuVLRtZ8ptRDsHaUReTGPalcO0AtHesedKbJN?=
 =?us-ascii?Q?5SWXqvSX6z7VFh6BKF3uzC+cEmaem/RDO6ltulMyaXMuZH/cgnODRmMB61Lf?=
 =?us-ascii?Q?qqABCcNZRDvDi7U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CcRuGgdhZUK0/g7M39x4hbjjBBrb1i+SLfb2Zo1GFXxxpvOtqFQJ2jCJ+Bec?=
 =?us-ascii?Q?Cm5dQcvMRn4JXpIbwCo64rgmVmJnXLTYURQWIBFl+Ft62BGUOLyky9i8aqTa?=
 =?us-ascii?Q?4O6lsxoboSOz4+WTWr7r+YVr8VYIdwp1Xh0z1fiXX41k0d3YegtTo2Shelnu?=
 =?us-ascii?Q?ZVzl2xlLf1rBg9PlWs18flHHKcnvZOCVLcr3dAsKYZ9rcEajzdBR9u3vwwsA?=
 =?us-ascii?Q?IMJSh1wqk5lKtcH/TcQOvfYPYIgO6jGJC0ofqXfHGnSUbPD0kAQAi0GbKCDA?=
 =?us-ascii?Q?3NBRZN+TYS1BMDdb5cgtePHdvauYIV8FqMeyk7o/fKW1fBfzEx0XZLGIBgbb?=
 =?us-ascii?Q?Ou4gQFeRV0uknajnaKJ/lLaPtuIa2r/TUfbhN1weYnCGP47Ryj0EJzY1egqM?=
 =?us-ascii?Q?7NGv+EKYAfGlGZV5WiaDMg5gl9vwHjNIJmPsnUSDQfOaWp7m6ZjntAd24Mvs?=
 =?us-ascii?Q?qz4U3qOsCSLTukZ2ZKA2S3mw0IEc9IiNCZ+lkr3aQwG5uRHB+4v9jy4TZf4k?=
 =?us-ascii?Q?z5bQFgkgwEnT0jHLa87pvCxR3JFwTPp5/eF3M3Lj29JLvfIt/q41BMFFcPt6?=
 =?us-ascii?Q?H16l7zbda+MnFnNPJKeWNLZyL2/fZujxePEQWEUED3uq2NyWj1uxtX12kFvw?=
 =?us-ascii?Q?yUEmBtjksuZn0kkgvbkLfdBumz0FAAZB6z5KSor9FbEx4iuFLMLRiBZAr/wl?=
 =?us-ascii?Q?79BzzyEkkH3HVwiTnKzkqTfOBmheTXKsS2veYNrWPUYDVJ/1lD55A2T1+GvI?=
 =?us-ascii?Q?lMltx/+sVbXMiFgcHF0IUTg31kPuwUd90DdXHk3VRrXkyFnEGQtHLe78hZm7?=
 =?us-ascii?Q?/BnY4bwuMmOwx1Fr741KghZNUgOyhpOBYy9V/wD8X5sdNwseNcXLpkhH/2Pt?=
 =?us-ascii?Q?7nE+Xm9KsTUWmRptRFMMiI29KexcH7u6Al7Fms9vazEBvXubKyYSGyPgZiV9?=
 =?us-ascii?Q?ztErbPv/dy+eM0GWl/FAmm902otQ7CRogBNzPEZKQW2JyyeM1+Xi0Djmbwka?=
 =?us-ascii?Q?KLktPeNgKe82QIvaoAGGJU0vIsTh1JhnziNav5U1NsoOVwFx4TlbHiuPuW5C?=
 =?us-ascii?Q?nV1aS009jWJGO0FBmFhHs+nP0eFm+UZ2d58p88oF3BUazmlBUstME9RwqKk3?=
 =?us-ascii?Q?SxV/AgavlxullguIj1iL/kvmkPWlUZDIifY/FwhMVTKRcXZj5RjbpfHPa/+E?=
 =?us-ascii?Q?1z2CgwoU/T4Q123YF7OU8UHznclaFAVKr7B828Wc/p6O1ZFQx4+1YooJsCNs?=
 =?us-ascii?Q?gIFkRJzigGfTJZ5WqzWvLl4vqojBWAt6Wr/5Fs541FxTsb25rikk+ZUaD2p5?=
 =?us-ascii?Q?dX684IonuI7TWwosYQhCQFMVmeddeO8Acu2X8iRNZszMVF7a7j6ZgxjjdYwY?=
 =?us-ascii?Q?/rjK31u//VYQLpZA14ULqCmpjrI6uyUkLMaa7rSKt3w5dq4e/YcX5CAW8Y9l?=
 =?us-ascii?Q?OIdLtFwQgLItnKRss9VqkyRiz4InCcfnIeIQNx+6jPDqLJORkMmm2WmDsbuh?=
 =?us-ascii?Q?9qr1qbFwSFqL0a80o7CNMQeSLC4MBOSVL8zWbSIe/HKQBjexd7c/qC2oFOan?=
 =?us-ascii?Q?ZDdjJT0j6UIhPxxYukWbf56e+DbcmdnJRbcKjr1H?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0006012e-7014-43ff-20dc-08dd7cbec23e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 08:14:50.2880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wh6Z88juOqtJC285nZZultf5PgpXd8Y9d+9GtLW82YqorZB9bsOUNbb3N5F6KgVYPia4DspT9Sv1CYFBXrpww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7103

Remove one redundant dw_pcie_wait_for_link() in link training workaround
because common framework already do that.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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


