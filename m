Return-Path: <linux-pci+bounces-34259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5E3B2BA80
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 09:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E133F3B5693
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 07:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595B03115A5;
	Tue, 19 Aug 2025 07:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VJV3eJCv"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010040.outbound.protection.outlook.com [52.101.84.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613581DA3D;
	Tue, 19 Aug 2025 07:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755587842; cv=fail; b=FmfeSDCEGWVnXe7Ow2+UPt7K5HXc0qcfRl9bc+GTJ51Fl6ez5Tdksz06BMkCfb4zRZlb7shZyLr27ZEYMU6/oDGBktcbUaY+i8430dsBvKwXdwKFeiTEQtgYCXzggDQfqa6npM/P6Kmy+JHPlIkMKTDfYXNbA6r+541trD3vDgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755587842; c=relaxed/simple;
	bh=Cmctnoyu1ucU1T++zibhfaXn1SVz2ujgn7X1XyA4MZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZdsOixniuaEALSH0QcQpuO5OQ+aQPamRmWdL28OEy0bn1Mw2lfX3+EI6yT77pJr9TRlXVPIaNsNGQwIQW5+nUqPHIFH/4F7ZDzTLJZgGtrROCLPBop9MytD66qXdHV7yeFYDmZgZTf1sds6BsWNWk9wmvkIgof5R8go1pLfps3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VJV3eJCv; arc=fail smtp.client-ip=52.101.84.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUoW5CZ2NDPnIsV58pVUsCwra/I8tmavkYghUDuj9oFEdnY1yGcrC7ojVn3IxDpQZZtu8a1r2tAyV9pQbavlDfXYtc+orW3QWxTv1vnFWtKlZ6WpLPBsCMNAuT+7S8NaecqjtCFfsnSWaNd4l+CS7manXMgmjRdGlqhBdAWpuFL76jyPSYOQ0Zm8POWIYdqk/VkD9+GWaG6lOvF0mzsdqFl96UFomU7qj6OZd8VYCKiSyFA55Dts5qoK7hauOVWkcn3pIQCGhxJtsAfapGzC6GBBX/0ib8Pz7A+gxMwRxyZ+cjBJrRUIPlf3dWHl5B+fgmU50icKpleycfh8PIPggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLgVtPkbgrz2T9FOHhc4NCDYqgmk6y2CpZY7wFZxp1c=;
 b=U1n0u79Wa47xSL2ip8nY2NzFWwdZM+uHxcOQmjK+knDK7YC8uyY+X23TrE9p4RMK/8SB+Fbde6FHYk1OC+Sv5Jf9s4h7kC/QBsf0U0hBTtBqD+i3YlccqqLEHeVDx/N0NlHeQHjHJBOaAgnD+MI6hw+m++rhTr+7tDVkOBSyfMHLHqkiZt0EF/yIvAmyFKTbk/p05LEhxDJaNM3tr9rPnIPLrL24AsMsKffVeqmyHGYYgPmO+6L5WGGSKm52nuI2aXrv/E4/T88JnCxgMZtMi9NbpLdOtgORwQl9J9EXAauqekZK3Dy6o8hJOdTKpyu53cVvF4exe4AIsazYbKJ/6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLgVtPkbgrz2T9FOHhc4NCDYqgmk6y2CpZY7wFZxp1c=;
 b=VJV3eJCvuJxXJ/GyiEb1ZYPu6bjPL3wqvc7ptZRQRHme4VydfreQOxIjftepRgTErPLPBbOrCTP9JmKoZFgVi3fY/W4gI+uSwAI3zBNEi1OAbEsbjRvmupunUP4KDCFAhOyGDOr0YVbEw8+ooNMe86Pm49jtRMbDvkuyZ7PbV3jC2itSsv+5Ob9PxMwvJTkpEJydtHHuC6tRQJ88MzQ09Gi8jdyF/WOUh8wWUy87GV0EXs8Bsnp9PiP34RknlE+Wu/sFtJtvII9sCpVa+dZBpqzy7vKcuqCoTIfdg67Fq92btWLWciFapEaS5K8lwVBC+5kzXX4l7AoAAfVg6On0Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PA1PR04MB10844.eurprd04.prod.outlook.com (2603:10a6:102:493::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Tue, 19 Aug
 2025 07:17:17 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 07:17:16 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v4 2/2] PCI: imx6: Enable the vaux regulator when fetch it
Date: Tue, 19 Aug 2025 15:16:30 +0800
Message-Id: <20250819071630.1813134-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250819071630.1813134-1-hongxing.zhu@nxp.com>
References: <20250819071630.1813134-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|PA1PR04MB10844:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e612c1-5271-4678-f08d-08dddef06d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|19092799006|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LnNtjdO1Pt4GedjtiiAQ4FpOXpBnMeJ23/X/kwReRL0zn33g+Pyu6isl0e71?=
 =?us-ascii?Q?Djlax2g8uFS/ixeqztpR8c72oyk4wQ/+4jekqbgaNtkQHSUM1U3NRWxRfLCx?=
 =?us-ascii?Q?JJeikAwrwVKg8FxRPB06Oo6wApMzuiZKtU6MdDNgqG3OsoeNM9/2ybXVTVlH?=
 =?us-ascii?Q?r+aktAwvxL/VU4uQ5S8PJHNRslhlFfp2t0O69we2z32rnZjzWGsGkk05WY/b?=
 =?us-ascii?Q?AGyx8d05EtPjk238Jm5+mKbK4nhUpbS3H7zcBDtCsTnpwrKX3AoDNFb0brqn?=
 =?us-ascii?Q?jpooeRvVzd5o8+1ypL5va/uDTmMJAvQqCBFes93BLsLKdZZsLWSvwksx04Ft?=
 =?us-ascii?Q?B9sJoOmVvd8Npn4eJBc8mYpSzRf9jGOBtrvGmSpP0d0mIQFYMEjvPS4i45hD?=
 =?us-ascii?Q?MmHS0EgzDS4iqumNBQv+zocEmqoy95RMJQW89gsoHlxESd8ir1GtxXPA7AfD?=
 =?us-ascii?Q?9g2dzWFomDVZGxisV/QE3hXceCyLd6Fk+X8L4SBv9j1BMIfmNxhsTPcEDxfN?=
 =?us-ascii?Q?+b/zEaz/H+uv9NF2fwvaPhRAxjnoxtG1hwW/j6XUgiJ3HJLKvnEp0owtlOCj?=
 =?us-ascii?Q?Cu8Md1C8S1f3GKkY19OW2d2vuJNC4OmR8PbwS0SqhMffvfQr5aHu6N80hsZw?=
 =?us-ascii?Q?fhpvsbgMYDntv/AZp4DYSzTuCkJsfUhuRHPlLiQTM9xhDD1X+nd134IbdkYZ?=
 =?us-ascii?Q?wIlTMxUv/JpNRSaDqJByEbEEQd4Jhx3vBDQA/PQHxFWQR12qbbuIzg0sWyO8?=
 =?us-ascii?Q?NVyA8uGTOndjhRKMRrou1qYX3y1fSWWBRuEOh27cutWh3jbXsOlEMM+95/0V?=
 =?us-ascii?Q?yUfIIS0ZfXFTFfwOSfvcGJaL90rckpEpm5plwLPSQ8HQtRh7bpD7GzTl9g+9?=
 =?us-ascii?Q?4pCSJBxvDwIrRcojb36QkXJmvNskB7TT+rPSrI6p7/x1WyTOjtBjNjS5N972?=
 =?us-ascii?Q?Q3SqsfBrRu6SVCNZvKe3LyVM3VOVeqoye2GSpm6fzrrgUSJ+WjBZm2WYX7DC?=
 =?us-ascii?Q?9U4viHt/gVn956hfip8zW6+0Qn0Icfr97AY5xuiECFQsEfyJNjToSqkmVAJP?=
 =?us-ascii?Q?FNpI7qZW6Xi3rsTTVh6hMZja9Ovdfy3vlNlz77gAi4qn/tlIdJhLJKLsKIJ9?=
 =?us-ascii?Q?NIOGHt4DQXF+mwKOoED6Rg7HcrnDs8LZtXREgERhWaR14Dc9e6j7O6i9KFZ7?=
 =?us-ascii?Q?IlTuMmYcurrpdLeQfTvLP8vgYTKVw9NkDjd59czzn1DshiQcdoJ6ZOHV+BYV?=
 =?us-ascii?Q?4r++iKiNDKseQJ2WhOf/6PoCS7H9f0m2qW6OtItAGGMYPQxPlyRlS7Sj2c1L?=
 =?us-ascii?Q?fOBQcu5PIDtiTufn2LMleW5wzyn4nDUOnX3g66UbTDis/pQqewRaX0yRzUlv?=
 =?us-ascii?Q?xaphlFLbI5Bnw5VsNf1ht2vv0lqCNKwz6mMABXzrC0mnmTF9YlZm2gdp6B/Z?=
 =?us-ascii?Q?othr0Sp4mx9F64yQFOkUGMv6Yv7MOwu0RdgWFgcDkVWuQO64mA37TInTp2mT?=
 =?us-ascii?Q?00rFc7KwSN8SrP8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(19092799006)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gEbLbtws7rPCqwfHpZdqlL0OEhErAurlWizDWhlftwXhpqffJCnt84VKsR05?=
 =?us-ascii?Q?vv2nB5InPGR+DFrk2iPTFqVBxQkMd7fyOP5e0UtiE3Onr0tVoKxXG075qmJa?=
 =?us-ascii?Q?WvG0HQhHAcU/5J0nUlOX3ZJ5b7e0RIlpldAB3RQtCmbc58t9x0Qk3X0w57bV?=
 =?us-ascii?Q?KTjO4qYGjitSpS2OesAT3GxhvKy2828jQpVzqa7wOYgF8eMgQJOOB18ajX9V?=
 =?us-ascii?Q?1bokR/GgkQnTRklKdDdl7A2mqrWpd1S1CUyUpDsfXWMl/jXuNyL/rhqRGhGD?=
 =?us-ascii?Q?cB6wgfzkCYZgeour/na77iFxeoW7ku5hCo0/6FlcyWcFcoWSqoZ6ERwt0XeZ?=
 =?us-ascii?Q?8tK3mVuMnnyP57hiNk1hVCmsG6PrPTyLqJC288svuWulLB/C02sHNvNn9+xU?=
 =?us-ascii?Q?n02pbg9ko2EfeDsqxbsoWHe6ZHRMVA4iefubomBb/+L8u+Ra3l15WwUTNBtc?=
 =?us-ascii?Q?h/7aUwT+gQMiHbCr/fWWeI4PzO08npj6R0nnp0jngNMFeXAWDWuVCSir3PUe?=
 =?us-ascii?Q?JP45P2ao7JEk87Ss6R4fj4xtgGqjprVcUd0D6go0VLI+JgOixif5Gk+O+FLh?=
 =?us-ascii?Q?wkA4rtTxmzvXy2qM/l806unc/VIX1RFGpRi9HvskiqeV8Eh73Dqfa/++QHVh?=
 =?us-ascii?Q?q8LjAsC+c33A96tISm0GGS9xnKBr5GtPQY1eh8zdbb+t/IIPgTfmD0rwk26K?=
 =?us-ascii?Q?b2dC77ZT7cPEctSGt+RpfN4RBYJZnkUDA7aCiXDL8VuitoTFyx57eYhURsoC?=
 =?us-ascii?Q?Bd72jZOvJ10Gpfe90k/CqXc3+TlB24nXw920SDfqscyRcxFQNfJZWQRdvsTh?=
 =?us-ascii?Q?N1/WdHnUbzG3+P3Nbi3DDMWEcQm70Z5PMa2LxJs8YG6h80IeqYJS6b1TqOBU?=
 =?us-ascii?Q?Vt5OJyY8B2JLitso5mMnujxFxlVV2mANArE9LGVCGZnjlIseywLJpAalbN5e?=
 =?us-ascii?Q?iEvbviaFpLew8Sg/+xBu2h98iDZGk5Dog7WEpFOwciUu2jS/pt45SS4bA5kz?=
 =?us-ascii?Q?0+5E+PDTsRo5lJnppw0sMM16xGxjSDolL/U619BI+PnA3IXMmHtZGdebOGJf?=
 =?us-ascii?Q?G469RvtZ8y2rMaiciiHE5r0g4dq2eyRyhbBrr0u6aBoPqTLqLDgz5eCmQJWh?=
 =?us-ascii?Q?IR2YZl/fzG55slyF09/4EueafVtayyxky+AFN97Pq8kwxROvTvA++/ftXfvJ?=
 =?us-ascii?Q?MZ+mNYIWfpByr+Xo4wLM1rMxOcBaAqizTG99u95LuzX/rKUrcFqc5sJLKpJn?=
 =?us-ascii?Q?sgn0ufRREVWmvJYeQNrNvebpcPqXYxuOk2zLet6/R7yD2hn5lJi1U72ovPRF?=
 =?us-ascii?Q?BtAqYcYPUpvtmI7HkQVk+95UmnAlFmA7e8f+hmDh4JHOJYma6G7PY8Jy1bVA?=
 =?us-ascii?Q?pr/y/yNAUk4FTFe53opI0QGadbJijESKCNihf221omjkwhV5I64kpENDCVcA?=
 =?us-ascii?Q?giVBz4X1VdSCfqaj5FhDdGQj90O288gwGXB0g7N4YV9Ss4WK2SFmTrEybn5C?=
 =?us-ascii?Q?LeKE+MV2UrRPSLUYfW1jPnCyMSUbcsQTeegcjy6l4znAnpSKs/Q+uoSEV0Ow?=
 =?us-ascii?Q?iCZPvcNf+3m6Gmyeys3zWptSDwj93wnpfeklo6aw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e612c1-5271-4678-f08d-08dddef06d1c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 07:17:16.2941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpV69XLTaQr77r4ESEcDvIzaFTN7L3Dg5vPRWoEFzRJlaZij0HYzAL37sGMDdGo/2ac1N1J0SgYfbAaKvnBiFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10844

Enable the vaux regulator at probe time and keep it enabled for the
entire PCIe controller lifecycle. This ensures support for outbound
wake-up mechanism such as WAKE# signaling.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5a38cfaf989b1..1c1dce2d87e44 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -159,6 +159,7 @@ struct imx_pcie {
 	u32			tx_deemph_gen2_6db;
 	u32			tx_swing_full;
 	u32			tx_swing_low;
+	struct regulator	*vaux;
 	struct regulator	*vpcie;
 	struct regulator	*vph;
 	void __iomem		*phy_base;
@@ -1739,6 +1740,20 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	pci->max_link_speed = 1;
 	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
 
+	/*
+	 * Refer to PCIe CEM r6.0, sec 2.3 WAKE# Signal, WAKE# signal is only
+	 * asserted by the Add-in Card when all its functions are in D3Cold
+	 * state and at least one of its functions is enabled for wakeup
+	 * generation. The 3.3V auxiliary power (+3.3Vaux) must be present and
+	 * used for wakeup process. Since the main power supply would be gated
+	 * off to let Add-in Card to be in D3Cold, get the vaux and keep it
+	 * enabled to power up WAKE# circuit for the entire PCIe controller
+	 * lifecycle when WAKE# is supported.
+	 */
+	ret = devm_regulator_get_enable_optional(&pdev->dev, "vaux");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to enable vaux");
+
 	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
 	if (IS_ERR(imx_pcie->vpcie)) {
 		if (PTR_ERR(imx_pcie->vpcie) != -ENODEV)
-- 
2.37.1


