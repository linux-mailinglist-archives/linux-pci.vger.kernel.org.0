Return-Path: <linux-pci+bounces-20072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B24A2A1564D
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 19:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4C73A65E3
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 18:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1600C1A0BD7;
	Fri, 17 Jan 2025 18:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cSpVihRW"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9451119F48D;
	Fri, 17 Jan 2025 18:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737137266; cv=fail; b=D/dzjtmc7PQI8DbFkwbvyeSNWY9KgX6CbgHAYmQPhVTZVbzdACGSSwvLxORtvDHoIBT0qIyQCE566N3KMvKaR32C5j3Pa55R+LEE/fGTgULYEvpVRsBmi++DCHVQyRiAPOFjMJvG0s00Dfi+ZMlcWx8+dkp9k3QB2kx6HbBZlhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737137266; c=relaxed/simple;
	bh=hXS+ntXt7Spzab7TxJEpoPnyN/XHWU/3y0vsgpgRxDw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mD2L61E4wP8dQNVMygXyvjyF6ZJWPOtQHt4khz5HZ1CJ8HVo6vRONcXBlUr5LUKzASeh/qqDJ6IrPnp9R6zbqnw/hP/Y5r83v6R6Y60wr5Uzk847NkigkwL9wWiiBs/B8OM8PkMs99XFnFbRGlkLsTLkyfHEpyKWWrJWI04Gw84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cSpVihRW; arc=fail smtp.client-ip=40.107.20.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lo0FJCxeuJ3mEUarMs3fuu6cNpnciCKV6jWZpi0eJdMT+NgCG5b1RQ+sN8CWIhLJgSrpjEk9aR+e76lAsdIF16dvk2F1Q+XHZGFpKG1sZv+tdw52R6u0IZAt3CKWOITEVd8yz7qdXrmQJK5Chvm7IXhnM96O/Ww/6pcAl/tBSL8u5iyx/zbm2xDZdDtxoGjSCgWFgJNTRl4qz2M7xn3AQH0Llf31i6zmyaKr88T6TCshm8ECvcjfvLt6OtKQbKSEPpfeuOwLtw8XdGjgPx+gZc63/6xLP40jhscxvSgUfGDIKvAT41dlXr0NkMIx40YpOVDWewhIqBlI7w/B4C7h0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5uuUi5FxyP0cIW3gv2BbeIZaymzaWemodUja5q9jh4=;
 b=bJsXwBbg19JK2Z7wBWZL+3gDAb3eftckiE5XIhDJph09r6ATjs/8lAaMGmbZmR0RmcSesfTItX5PwOv22tF3yQhICEywh9atfpDUEcZsxvr/Lk/acERUi/05B5FKPK9NLZVvUrryOKDm3Xu5v0ti1UX99ryTuAprubpjJNGdQVdWPKNldP3oZ3gONtqudx2ONAqrWthBL7QWIdxin1sgTDbeWqlIUX+oDw8aefYDfZ5tOHB/06OFeVCZAmZZNT20+qJgMJZSo8ttbd0ZjiLnii7uYhRVQvEOWICoIMJ0GtJIq6X428fLSVpSFJIYQX9uq+Dp4+0rvqYd1aWfe03kJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5uuUi5FxyP0cIW3gv2BbeIZaymzaWemodUja5q9jh4=;
 b=cSpVihRWmlQtA29YJD1WhQN2LmzCwE9lTYTClJa2WpUMtL0m+ZBfrqD7jdjvscGC77D2JPqxeMlU3B3u6mUsGGNerU3E4lfx+OoNO9Bm5OcTue8TqpkRPb1JTljaOV/xLOcL0VF7w25iAVss74o86KebgxpHL2XofZCqvGg/9VvIuqohPXdLAS9H5ItfhfrQHTgSaVkio1Y+V3rvLGOTHN5Xl+ylGQACeoNWvl9qRFbjFGZWVzRDWRKP9bh9Ndgdymmz+Ai9nqRkHPliLQQrLz/tPVDttG1EmV12VG1azibccT0l6XZxUPh3tEJci/uHKwbGg2BMw1GXfubFErv4+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB10052.eurprd04.prod.outlook.com (2603:10a6:800:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 18:07:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 18:07:40 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR IMX6),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR IMX6),
	imx@lists.linux.dev (open list:PCI DRIVER FOR IMX6),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] PCI: imx6: Add CONFIG_PCIE_DW_HOST check for suspend/resume
Date: Fri, 17 Jan 2025 13:07:22 -0500
Message-Id: <20250117180722.2354290-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB10052:EE_
X-MS-Office365-Filtering-Correlation-Id: 32659819-abdd-44dc-624a-08dd3721d512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qmcRimATW83hzOHDBuPwuig0OVjPfgX8L+8M9of8gf/Zw3ZSMNumZ+YvPQew?=
 =?us-ascii?Q?e499549SE2SaHdDliFtTgfTCmu0XCl4q2qNi1UOtBjTYoGcttAL7cfSMlcLu?=
 =?us-ascii?Q?90/So4oYuicuhyLQoIZ338eN7639JbJxq9lXBGGz23LSYAglFGPYPAKspFN6?=
 =?us-ascii?Q?FRHpOmQChqbRndWub6Bu1OEeNbNzeIgCkn1mH/sK5CiriBGnCHuHSwmfJV1B?=
 =?us-ascii?Q?bIZyWrm++Qrgd7DY+dRiMuKLypweK+L7MTjQL4Y+RQlOL0bDBBcWmBckGgMp?=
 =?us-ascii?Q?RtO7MIyWmkUZRIsIqO+dpknUGOMr0N3FlooW6P4jD+G+KOizwdlgWKhYqm2W?=
 =?us-ascii?Q?ShD13FjqG5C2X5FmYNCSTFMZ0n6Lpu7nXx5N4bMbvbvE5y26xJ5ZPTWx+yaa?=
 =?us-ascii?Q?xamX54EgwXNPAqbCvTA+Mwl80tzGjFDdFuL8INSGNc6qhjiyP6B2u58R684P?=
 =?us-ascii?Q?OEP3lfgePPFP2EAEAmjKq2GLKwvDvzVbcvM2fam7f7wH6n/5urg5uxpzdfb/?=
 =?us-ascii?Q?crR9QqNgwswukXvRcMa5zFPOAjLjHm+mHMcwvuc7M4hkdqn9yz2VrbjoX/DC?=
 =?us-ascii?Q?bHQ2cI8bbQolMpqwb34ZbwiuNN5eWctEjr4QT6t80/wPze6hnuUfqpvv4LPp?=
 =?us-ascii?Q?WwjqUYXNI6EgQORcSY4wd3DCvPi95EUijos+i+1jOQ1IkJagK41Z7zs1XzcR?=
 =?us-ascii?Q?ROvyvqc9wd+yYEyjYlW7B8DidLrqkAv642TH1ND1VGM3V6PE2xdLwCtEoUzN?=
 =?us-ascii?Q?eKLQ8L2UP7WG4TN4gjOQ0L/s8YStJ5GhaB5kjPDM4EceggabsQM6woVVrA+a?=
 =?us-ascii?Q?/D9f/shnEbNYdMeyC28n2TjDEPwTP2cuqxLtPNmcTOaREM9EDZLfw4On+Enb?=
 =?us-ascii?Q?1ncAYj6KOxAMeQZrsr8i+xeeN5U+b2ZZMlD+Hd7VjjWGnb1/4zyOVcZsrNLH?=
 =?us-ascii?Q?zZIW2tqRKhF0hTQ/28vR30TzqOjonhh6Ia34yNNrCmGd3jKdDndGzCfdnFIK?=
 =?us-ascii?Q?zTiJyNLSTIJ9WMUBOmtRvfd4eQGbww9wBLdaEYu6zscUM8ZlmhpMaCq1Ycfm?=
 =?us-ascii?Q?H7adu3zdjzpq+5X29kIh3gFA0Skg6ri0eeGnsP2oKevSSqrwGINpRZZ02gb4?=
 =?us-ascii?Q?U2/iwhg7aJ3/JJSE5jSgOzsEUUoC0qqxiJD5W3sUqEGlMo9YSw+D0zmxs2Nx?=
 =?us-ascii?Q?kSapHsi8iujhvE8YCCJBUi0J13y2e6CDVNxZ+MiT2DBPpIGLAm8CQ3OfmMGa?=
 =?us-ascii?Q?w3+KS9myJjxzkb3xf24FbvDFt0SO+q6Ey2T+RZI2hm/XStUhj3IR09uSq3Yw?=
 =?us-ascii?Q?zWqDwFru40K4y9ztAoM9HtGKQYcuAR/bzrGbKENsP4rU2DMqmHS605xF6Bz1?=
 =?us-ascii?Q?ej/7dS+j4JfaltLQzFygMRfCgnxyPQQFStcmECZGbBGQaeK6xt9GFAPc+oFE?=
 =?us-ascii?Q?kKmCxjA/M5U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vV1Ao1eIGavBx4QRSNBraEdJdDhVGTDZovAA/On6z2mNu8DBWzM/jifw4uN+?=
 =?us-ascii?Q?idWTMKQnSCegzlKPeu4wfxITxDT2iM7t3UdoQw7VQ5+RiY++nepn1GyqNkgg?=
 =?us-ascii?Q?AV51DsxRgDcAn3UQGS9/w0TLTjslh4RrF5gZSC4SV7FCUp53Kmrow9dEVdLB?=
 =?us-ascii?Q?xSOS0lxDhSrMYofYVS3kRPSvaCJVNp9JZiPHh3G9+rhClwZyRPKRrmZp5dZR?=
 =?us-ascii?Q?7tF3slA00iOs2w2ETmYfZ5AfF64iBtrohPPOczj5q+y82Z0pMjscGNQOEt97?=
 =?us-ascii?Q?rqtu7MVsIkUZCnAjn0hu/iPve90sMc64jq2WtQQVAwktt1F9nhfWjwSc2idP?=
 =?us-ascii?Q?5FYXq5Ud8fB2g4iUBkg5iJhVbL/JSdAK0KYm7K/huVv+DzxhBmFbInZMYsTw?=
 =?us-ascii?Q?BtCWz30p66pKjDqIs5IyMg8OTHs2pojdlwUj0KcFw4NUO4swyPcMx/1TyHIS?=
 =?us-ascii?Q?z1gS3334raquI7TtepbuzrTgUC5Ycs70Y9RScpHP1HEoCK2O3u+QEgV00mxy?=
 =?us-ascii?Q?CuYB0WiOIvbQjnsa6l0Z9K1aCqsEBiJKvc248Ah7ucPNDueUn7Fw0Rcgj9Jz?=
 =?us-ascii?Q?C3bK/ubk1TtTyQA5lSj8O0iRAW3HCGTRnD3O5N7Tvz4fdUYwJ5t2N/lOaN2D?=
 =?us-ascii?Q?rXeuI5zvD5zTJ3fiUKAziB25f5oJZNU+hZaP6llRAyR+BWgVUH8WgYnUYuoz?=
 =?us-ascii?Q?ExQLufQ751SianetVqICw04iMiDl5OiEHh7neC+TRaalO7YzTjLTDban9Okg?=
 =?us-ascii?Q?NEEaiGq0NWJU7JbbDhxQVNz6epdomubO8Xw+vNhOg3Gh0emWOq4OrsrnfsLe?=
 =?us-ascii?Q?Gf7Hc4VChf4lXN/VilLXvaJ17YsBcEZIjeguver3UjFhHVfcIUOgFfTiAeLG?=
 =?us-ascii?Q?qGLEMN1XNkL36rtMwhnPZpi0yc3G0TmNSKcvyuSP+dlOwePi2Yj2hJklRFBO?=
 =?us-ascii?Q?XRGTp4JVO8Rjw5bfv487pUe8KfkYb5DivhONKbuIXFM1p66GSKouB8ba6Ff9?=
 =?us-ascii?Q?hICdbQKuCw3SJ7SlDLY2L1qAqHEg79goHL7w3/RDSYwNi+gwjMfOCSTwGL4s?=
 =?us-ascii?Q?Kw4HfKmquDVQnGZUIhDYL76xtkt6iqI/Ym1IIzPbJeaaCFY0odZrmgTVi+GM?=
 =?us-ascii?Q?V3Qb1ZiESSjOVOKAlxp2AxrSpDEmpKcsHqEqBnQz1Ty6rMu5sn2gNUvcCxth?=
 =?us-ascii?Q?4tDszTTJicbT0H9Y3z4KUOGVeiUaiqA9q90/B+Da2nY2kJD7UnYQwm4aTrCW?=
 =?us-ascii?Q?j6sFmfBK864VJIXxG+Q5ts3i0oGg4Cgf2Gh4O6A4NSN7xEl3/CR2GjO2yQlM?=
 =?us-ascii?Q?9LhhsHA0Es7z+byP7I10ysoAMZi9IQ+3hrCpPGjYofkjaAssvBv7NLEmTJ2R?=
 =?us-ascii?Q?WYFxTvvQYtg3kZ7hloGNzpvbNB6ikvLs5dbbk9SfGY5Jv1VRs8uxC5rtrEw/?=
 =?us-ascii?Q?LIDOaQPRg44WuMt4EC5n8jv+4uxV1+iLS0cbr28kg/w6khNHjeRoAIHM136U?=
 =?us-ascii?Q?RWzYzBZDgrceWXpBGGUq8PBhLYXwJ/NS1ceUdsxlEkNDQp08jefR1nfHJwAn?=
 =?us-ascii?Q?auMWddvW37l/J4ZnqBQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32659819-abdd-44dc-624a-08dd3721d512
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 18:07:40.6045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1s+AfBhiAt+1AW0yPuWEAxSQXOdtg2Gq4iSUEAkWOixF04kG57ziDuQu4fmGaRTYKfas3wkDbqIF+SAMJvgA0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10052

Add CONFIG_PCIE_DW_HOST check for suspend/resume to avoid build issue
when CONFIG_PCIE_DW_HOST is not defined but CONFIG_PCIE_DW_EP defined.

Only host support suspend/resume at i.MX chips.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501171751.YzEFidaE-lkp@intel.com/
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 129604025252d..e9fdf35d24821 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1390,7 +1390,8 @@ static int imx_pcie_suspend_noirq(struct device *dev)
 {
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
 
-	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
+	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND) ||
+	    !IS_ENABLED(CONFIG_PCIE_DW_HOST))
 		return 0;
 
 	imx_pcie_msi_save_restore(imx_pcie, true);
@@ -1414,7 +1415,8 @@ static int imx_pcie_resume_noirq(struct device *dev)
 	int ret;
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
 
-	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
+	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND) ||
+	    !IS_ENABLED(CONFIG_PCIE_DW_HOST))
 		return 0;
 
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_BROKEN_SUSPEND)) {
-- 
2.34.1


