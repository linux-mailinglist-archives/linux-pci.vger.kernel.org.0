Return-Path: <linux-pci+bounces-14547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 980F999EC51
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 15:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52EAF2891FE
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 13:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4640D1B2199;
	Tue, 15 Oct 2024 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hfKs2Wf7"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394963DAC0A;
	Tue, 15 Oct 2024 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998075; cv=fail; b=clbBXfqgRN6WxscLezr8h2LnBfJFBFCbu+FfyeEc6RACFYrAq8i3d3CgegGTZkvkFVSypuCpNrkA9DK396ASiw/qhT/IjFmkO+cIOvx74Pt8d2IVNS1aL8T62UTTiTPRr4mhx3/xYr6eE46EowpkW6PaqazbDcbSLP7NRdFuB38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998075; c=relaxed/simple;
	bh=MmDmIDm0jAWTDLlpIRqmWWIpOR6bw0N4k2dbVuAxM9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ow6V7mrMmh64ZXpUCtMcGLFopxf2xxd2ZWMNnZlslSijTWHVvuTKteszYs4GhDiwkeZX+7ostkZEqcFjO8d0YWcvh7UdXmmzQlP+qUqDPl78LCFHkOYTBTTTYL41117Ei0k6unCbiWdaud5fi56RjdlOjoiVQjK5JyeSDFzGOYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hfKs2Wf7; arc=fail smtp.client-ip=40.107.22.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jb87eQ8A964vB4J4lUgGiALFBjrZ7J/3zJ+VRUDRzgRTcsdXp1Q/OJPkPGZgWfaiLzbEmp7PR3nC67nuLvuRwq045xqnUE5vyRuBaoks+/v+eUfIjat2ophC1Rvy6cYthZULdIADuIKfqb4vpye1MIO0AEB47iWinL+X0nYYQ29GnoG9hCVJxHz/d/li/i5RPzFWw3BjchEMggTXlTkg3EYc4vNdhJkmWysijNhigbwGmq3EMCcWxiHAE6bVu4r6sm1hEzehxOLAcO4Yws9MUY5L79U54/GQvFVWCC3IPRAjJgTZ2mcRFOxSWHe4if6DTeJRnkfTns4pVSxiIlb/QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2cAAlZDdH6Vpfu7V08Yut44j65BcaePFXdV+RQWjuU=;
 b=TvwtKKH87c97NsMFwFMFQCzGwDZPf+X3+a3ZU0qE+6MteM1l+TQxCOSak1PyUvp47y25zHYf20jl/AV5uKapMXToRcHgv98bzAStkPQOGco41q7Z7WHOp/RrkzN01sPDmPRk3FKdFqv/UxOmji2Cm3ZfzMWgf6HQQML64wGSi0ehvN3JT3bCy56W1AGWL01NpnDk7g1vMyYy6nxO+a778ja7jHl3jSKlU5lqvjnGLaAgEeb2TDksJ9eGUoT0Z30GEHo0W56/x2wsyMeJIAei+7hmqatxDYF77yrdA+v4cgKliuQM0wvSps3Owfq2OTIsr2cc8qIyuvWazlSSj64lQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2cAAlZDdH6Vpfu7V08Yut44j65BcaePFXdV+RQWjuU=;
 b=hfKs2Wf7arllxEtiNXL4gl9MEyy+NUAUszywcKgVKO1VuYGbxEI/fJEBozKvG9KiEc25RpqcjX7ZNaNGwl6LUjP/EqgnUrS/d4HrdTCIJBhHVoTAX0HlSfdtdQr1OccrQyZ0M6xhB66trjg4B4h+vZ4AvwdepxMGBBWHvqRKJ6s3Sl5GrS8ei5JEHB0N+gV2ggIHAw2wPIniSqRo4GI7Pv+QQ/o5JP5jlcijfSjbl+W5JyDgSN56zThAluJUNauEev1lPd/AA0OvMbEBQrVi1tQ4MxuJxUINsb00fkZmSmSqvXURDSXTMCobila7cf8CWGxjCssuMWaoO+n2G6bvhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS5PR04MB9876.eurprd04.prod.outlook.com (2603:10a6:20b:678::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Tue, 15 Oct
 2024 13:14:30 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Tue, 15 Oct 2024
 13:14:29 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu,
	linux@armlinux.org.uk,
	bhelgaas@google.com,
	horms@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 net-next 10/13] net: enetc: extract enetc_int_vector_init/destroy() from enetc_alloc_msix()
Date: Tue, 15 Oct 2024 20:58:38 +0800
Message-Id: <20241015125841.1075560-11-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015125841.1075560-1-wei.fang@nxp.com>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS5PR04MB9876:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f68f8d6-546b-44c1-9bcd-08dced1b4d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xtPtQZV6S17801VrYcTfD/WzhAvgG87rehlrlJ279Tkk6ggteHVWvgrRLaKD?=
 =?us-ascii?Q?+8j7r2YYDoQK87AnRksRx+LHtXUgxb6ehxNdEqmQEg/B3R+7CeJJmaFa13ae?=
 =?us-ascii?Q?24HwGTxJq8NfdDEgx0Mi15/Q98xRwkuauxPrfOM6/YF3SC2LDxzpljeiue/s?=
 =?us-ascii?Q?gtssot+IbgWSa68ItrqvVxK2gXTgmONaYGkF3rAZM5p51Gdq6UpAUVVNMMeV?=
 =?us-ascii?Q?Daa5ICwjQkSCHFJG3zlB1BJ414ZakaRwTIrqT7cwNjA7up4NNWocWMZx83JR?=
 =?us-ascii?Q?wuzR4xmsHZf+sDxkOP3GEE9wqHCHuHTYmSOMj9+wpJQV0TaueTFxdLfxbLx8?=
 =?us-ascii?Q?/W/jRAAjbXTFgnJrz/JRI9TOpda6D/7NxqhBBT3ONcwHut0Lmj3bILarxjsB?=
 =?us-ascii?Q?D3bmrl5dEkNyndRpOMRi3tzEgZsUtvsFdw8mm9XEce02iKVuJOu2oBuN7aBV?=
 =?us-ascii?Q?9hp3wG1oG/IvgNlekaBxOv1+QudBiEqIky1tIbVBJQHg+DIi8iosl2crkYok?=
 =?us-ascii?Q?+QW3QazjXTymqbcwf1qAxmhSNmYM+zzzjW9Bz+GTxihqPJ0VIuxd3dm8/4t9?=
 =?us-ascii?Q?aFHEHtqlqMwVZ0d7WNL0+c96fvHMo3Wb2wcNnkp/QVMIHdUANQCZsJCu9aYB?=
 =?us-ascii?Q?2AyGp18uGgEsx8aCY7gfcU3+AfMdA+HoCIkX1lTrX+nCDCPEWJgxAjBZKCl9?=
 =?us-ascii?Q?CWL5by+6yhC7d/e7Prp7GKzoMoXPhwu6gm7AdqsIDXBHHfVpnHU80XvAUkdP?=
 =?us-ascii?Q?wgSD7hQSkwQaHD1QuYNYsI/8iOsW9u7ZkyLJKOaocFayxh0KtsDcGDT6rS6D?=
 =?us-ascii?Q?06iO5AG17w/2JvuWIivARXFpHPXM30Wvf3yyf/CC9ROthSF10JCOrVOGK2Ue?=
 =?us-ascii?Q?n7gt56ALVkAY1/ACYQ6a5U15yBi9ZkrkDlYKhYhHZdnIyE4i9vf6z71yMk4s?=
 =?us-ascii?Q?xVqDAm22NACNM+IvgvnYQzgaN28vLvg7ayOw5ZKoZMyagBWze2VyhIUjNjl/?=
 =?us-ascii?Q?dTMkfnyZPHykarWzAgen/UbHFtvuRJIgIl4ZbE8Eyk3TNQJRzj6VHtmV6ToE?=
 =?us-ascii?Q?0/nMaRPkr5LDzVDGieED4OAKtC+C9D+zm19cXw3BG2ywoeGitMIA+YKMsbWY?=
 =?us-ascii?Q?sMI4kJnMgfsfAiUJwFz55mNbZr7wgGZglO2nYjRMTFX/uKtn0NRQ528ukLWd?=
 =?us-ascii?Q?kLX7jCotzBxZOQ8eNUCUoupPTQ3d1qvXQFSAexQnuBy1cPI35WKTV//9zRqb?=
 =?us-ascii?Q?Cb7xjV2pD0L2nxZpmbOH8shvBaIibJEOvMWU/2aXmLozoXV5r3uFKwDVGiHO?=
 =?us-ascii?Q?0RciuaclkcPItR3wchXohJv29BNr/fTnSrQ4Tbh6Zr2IV8YuhWvAaM4PZN4t?=
 =?us-ascii?Q?bgi8jdw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CqmE5d9RdDpLYLmyZBMbz6sGo0+bMgbx5biYN7cS1y4kM/l15UmRsANHvqVE?=
 =?us-ascii?Q?A25kNIlNLl79QJfLjh8SciWCpjt0xm9WsortMyiOKqEyeoF1AJ+bMme8R9m5?=
 =?us-ascii?Q?ZNV/+JSznP5KVMkHMZjVXbf452iMUvS1nJShHWzgCyAyAiO/q7c8+RBTCFAT?=
 =?us-ascii?Q?H3SFPER9PEFz8CnRPVrhzbMPavOYaOYedLky32DkWkIlyvmNAbo7hY51LohG?=
 =?us-ascii?Q?UeA1kB9AMKJqC4ppqeS9uqCgN7saLYE9Dvtw2CutYnCMEPU62mZbAUzXW/WE?=
 =?us-ascii?Q?ro9Okt074qom3sDeZi5Sr81aqnY+zpj2dN7KUD+CUmz7KU/Z+Vi0HT5EvMFs?=
 =?us-ascii?Q?g+1FWqiMxuD+0Ng/f5DWdwcQI8H4QJg2CjKVmrssIymP+n7xJ7o5b8HmxTNw?=
 =?us-ascii?Q?gWJcJeR193ae1IsrE0o/e4+r02+0L57rA0rMfHP9JedjPuK0AqdhsQukufny?=
 =?us-ascii?Q?kS/VIpu3f2VjJc2aqhHhaOt4RJUMsq6FOczUfNNWpNfb5iTSEWBy1BNr808M?=
 =?us-ascii?Q?4pk2+w18+9F6yiGUXJPIVPa+fvbG+2e3kVQoZsNrpsakhQCoDBoqvm/dkyl/?=
 =?us-ascii?Q?ksWyzCsxl05W9APCDrTmMRnbd+fXCQIAeWD2GJX/ErHybdR9br54qovj+xFW?=
 =?us-ascii?Q?aRZjG+Ve0TGKEVem4WLpBMKprXenuUNQIOM/ndA68Cy+Xm1MIoYpWt2LYSqu?=
 =?us-ascii?Q?KEl6vJFb0ng5Ksaa/BN5jYKxbUvEONM1fhzNboHB7TPmRs9S/Csk9MyfEW66?=
 =?us-ascii?Q?TxLJ8e4tOex65uDbY1+6C1I/vqk2wJNQqmRAvx0BLDQNGc5rD5lvD2O+QBOJ?=
 =?us-ascii?Q?Uc1N2QpVRxI/JNX7XobuwsLZ73DQgA0MDpPwxVuU0G3ZH8iwyKKvIoxjT2xU?=
 =?us-ascii?Q?lG+kG+cO1r4K4GydbmZ1/+Wvf5EzviPj+DXyjo6I3IJ/lzhmdnKYix66ic9J?=
 =?us-ascii?Q?TvuU0ErLhWylagVDa6HeTOpxEcZDmvhbnk9r1BowwIgNXF9n/y0RKecVO0Xr?=
 =?us-ascii?Q?KngAaiBB3S9bJczRS5Uw7VfJl7v+55G30aBwfEcoNWUzHHg5qm9nvG4teJl3?=
 =?us-ascii?Q?cwKrBIej546bwTPVUJQrIqW6WMKYq6k61Wb0CfU1xJpgBsHr+i+0SZmB7k1j?=
 =?us-ascii?Q?A0/2bB4w+7965RKB2CjpgCTKxexHoXVua8Zf64fNtasq/qT0XKh4N3SIXBgO?=
 =?us-ascii?Q?Yjmu5YK+xtE2os8KyURi2Pn1KyYkWDotIyyb6WUpCfYCx6+CNW7uvl+PQ3yd?=
 =?us-ascii?Q?yCvIgie3XNRT3AEcSsAWF0r6KmIeO9CEJxAc34jNoPjBVBDzy9Bnm2U+Vsb+?=
 =?us-ascii?Q?mt1Yl2YkUMyV/lL5HLFfRic0CCpsHm9pp+Dt77A/OXlU5Y9V25H52Yvz0pA+?=
 =?us-ascii?Q?p4PwiWx5/WjK+cA56zqUWU3y6D/HV7Tm/r9x9rDH4brTEMBFc6NXMayGvBK3?=
 =?us-ascii?Q?9+z+mzEDS0U+9m12HW50pYSy9Xp7QT6IWcnSaLeVeWudC5tR8A4v3MmgUWdQ?=
 =?us-ascii?Q?ASxzPIY6zfvCxBZ/tVcTvatJRZvJ2eof2gb/vDFfFeCLELCyDZDubnUkmrtC?=
 =?us-ascii?Q?V2mxyXYY5RMV322iTPChdWJRmrmFyOzK8oS8E55C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f68f8d6-546b-44c1-9bcd-08dced1b4d53
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 13:14:29.9436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NkHfBxgK2idUAClWGW06kStVrLQUl6xasMO5rzvpu76ypxSjd4AlNK1tYuT8QOGZYLQZmcIRgAEJjRIR0vXqrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9876

From: Clark Wang <xiaoning.wang@nxp.com>

Extract enetc_int_vector_init() and enetc_int_vector_destroy() from
enetc_alloc_msix() so that the code is more concise and readable.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes:
This patch is separated from v1 patch 9 ("net: enetc: optimize the
allocation of tx_bdr"). Separate enetc_int_vector_init() from the
original patch. In addition, add new help function
enetc_int_vector_destroy().
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 174 +++++++++----------
 1 file changed, 87 insertions(+), 87 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 032d8eadd003..d36af3f8ba31 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2965,6 +2965,87 @@ int enetc_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
 }
 EXPORT_SYMBOL_GPL(enetc_ioctl);
 
+static int enetc_int_vector_init(struct enetc_ndev_priv *priv, int i,
+				 int v_tx_rings)
+{
+	struct enetc_int_vector *v __free(kfree);
+	struct enetc_bdr *bdr;
+	int j, err;
+
+	v = kzalloc(struct_size(v, tx_ring, v_tx_rings), GFP_KERNEL);
+	if (!v)
+		return -ENOMEM;
+
+	bdr = &v->rx_ring;
+	bdr->index = i;
+	bdr->ndev = priv->ndev;
+	bdr->dev = priv->dev;
+	bdr->bd_count = priv->rx_bd_count;
+	bdr->buffer_offset = ENETC_RXB_PAD;
+	priv->rx_ring[i] = bdr;
+
+	err = xdp_rxq_info_reg(&bdr->xdp.rxq, priv->ndev, i, 0);
+	if (err)
+		return err;
+
+	err = xdp_rxq_info_reg_mem_model(&bdr->xdp.rxq,
+					 MEM_TYPE_PAGE_SHARED, NULL);
+	if (err) {
+		xdp_rxq_info_unreg(&bdr->xdp.rxq);
+		return err;
+	}
+
+	/* init defaults for adaptive IC */
+	if (priv->ic_mode & ENETC_IC_RX_ADAPTIVE) {
+		v->rx_ictt = 0x1;
+		v->rx_dim_en = true;
+	}
+
+	INIT_WORK(&v->rx_dim.work, enetc_rx_dim_work);
+	netif_napi_add(priv->ndev, &v->napi, enetc_poll);
+	v->count_tx_rings = v_tx_rings;
+
+	for (j = 0; j < v_tx_rings; j++) {
+		int idx;
+
+		/* default tx ring mapping policy */
+		idx = priv->bdr_int_num * j + i;
+		__set_bit(idx, &v->tx_rings_map);
+		bdr = &v->tx_ring[j];
+		bdr->index = idx;
+		bdr->ndev = priv->ndev;
+		bdr->dev = priv->dev;
+		bdr->bd_count = priv->tx_bd_count;
+		priv->tx_ring[idx] = bdr;
+	}
+
+	priv->int_vector[i] = no_free_ptr(v);
+
+	return 0;
+}
+
+static void enetc_int_vector_destroy(struct enetc_ndev_priv *priv, int i)
+{
+	struct enetc_int_vector *v = priv->int_vector[i];
+	struct enetc_bdr *rx_ring = &v->rx_ring;
+	int j, tx_ring_index;
+
+	xdp_rxq_info_unreg_mem_model(&rx_ring->xdp.rxq);
+	xdp_rxq_info_unreg(&rx_ring->xdp.rxq);
+	netif_napi_del(&v->napi);
+	cancel_work_sync(&v->rx_dim.work);
+
+	priv->rx_ring[i] = NULL;
+
+	for (j = 0; j < v->count_tx_rings; j++) {
+		tx_ring_index = priv->bdr_int_num * j + i;
+		priv->tx_ring[tx_ring_index] = NULL;
+	}
+
+	kfree(v);
+	priv->int_vector[i] = NULL;
+}
+
 int enetc_alloc_msix(struct enetc_ndev_priv *priv)
 {
 	struct pci_dev *pdev = priv->si->pdev;
@@ -2986,64 +3067,9 @@ int enetc_alloc_msix(struct enetc_ndev_priv *priv)
 	/* # of tx rings per int vector */
 	v_tx_rings = priv->num_tx_rings / priv->bdr_int_num;
 
-	for (i = 0; i < priv->bdr_int_num; i++) {
-		struct enetc_int_vector *v;
-		struct enetc_bdr *bdr;
-		int j;
-
-		v = kzalloc(struct_size(v, tx_ring, v_tx_rings), GFP_KERNEL);
-		if (!v) {
-			err = -ENOMEM;
+	for (i = 0; i < priv->bdr_int_num; i++)
+		if (enetc_int_vector_init(priv, i, v_tx_rings))
 			goto fail;
-		}
-
-		priv->int_vector[i] = v;
-
-		bdr = &v->rx_ring;
-		bdr->index = i;
-		bdr->ndev = priv->ndev;
-		bdr->dev = priv->dev;
-		bdr->bd_count = priv->rx_bd_count;
-		bdr->buffer_offset = ENETC_RXB_PAD;
-		priv->rx_ring[i] = bdr;
-
-		err = xdp_rxq_info_reg(&bdr->xdp.rxq, priv->ndev, i, 0);
-		if (err) {
-			kfree(v);
-			goto fail;
-		}
-
-		err = xdp_rxq_info_reg_mem_model(&bdr->xdp.rxq,
-						 MEM_TYPE_PAGE_SHARED, NULL);
-		if (err) {
-			xdp_rxq_info_unreg(&bdr->xdp.rxq);
-			kfree(v);
-			goto fail;
-		}
-
-		/* init defaults for adaptive IC */
-		if (priv->ic_mode & ENETC_IC_RX_ADAPTIVE) {
-			v->rx_ictt = 0x1;
-			v->rx_dim_en = true;
-		}
-		INIT_WORK(&v->rx_dim.work, enetc_rx_dim_work);
-		netif_napi_add(priv->ndev, &v->napi, enetc_poll);
-		v->count_tx_rings = v_tx_rings;
-
-		for (j = 0; j < v_tx_rings; j++) {
-			int idx;
-
-			/* default tx ring mapping policy */
-			idx = priv->bdr_int_num * j + i;
-			__set_bit(idx, &v->tx_rings_map);
-			bdr = &v->tx_ring[j];
-			bdr->index = idx;
-			bdr->ndev = priv->ndev;
-			bdr->dev = priv->dev;
-			bdr->bd_count = priv->tx_bd_count;
-			priv->tx_ring[idx] = bdr;
-		}
-	}
 
 	num_stack_tx_queues = enetc_num_stack_tx_queues(priv);
 
@@ -3062,16 +3088,8 @@ int enetc_alloc_msix(struct enetc_ndev_priv *priv)
 	return 0;
 
 fail:
-	while (i--) {
-		struct enetc_int_vector *v = priv->int_vector[i];
-		struct enetc_bdr *rx_ring = &v->rx_ring;
-
-		xdp_rxq_info_unreg_mem_model(&rx_ring->xdp.rxq);
-		xdp_rxq_info_unreg(&rx_ring->xdp.rxq);
-		netif_napi_del(&v->napi);
-		cancel_work_sync(&v->rx_dim.work);
-		kfree(v);
-	}
+	while (i--)
+		enetc_int_vector_destroy(priv, i);
 
 	pci_free_irq_vectors(pdev);
 
@@ -3083,26 +3101,8 @@ void enetc_free_msix(struct enetc_ndev_priv *priv)
 {
 	int i;
 
-	for (i = 0; i < priv->bdr_int_num; i++) {
-		struct enetc_int_vector *v = priv->int_vector[i];
-		struct enetc_bdr *rx_ring = &v->rx_ring;
-
-		xdp_rxq_info_unreg_mem_model(&rx_ring->xdp.rxq);
-		xdp_rxq_info_unreg(&rx_ring->xdp.rxq);
-		netif_napi_del(&v->napi);
-		cancel_work_sync(&v->rx_dim.work);
-	}
-
-	for (i = 0; i < priv->num_rx_rings; i++)
-		priv->rx_ring[i] = NULL;
-
-	for (i = 0; i < priv->num_tx_rings; i++)
-		priv->tx_ring[i] = NULL;
-
-	for (i = 0; i < priv->bdr_int_num; i++) {
-		kfree(priv->int_vector[i]);
-		priv->int_vector[i] = NULL;
-	}
+	for (i = 0; i < priv->bdr_int_num; i++)
+		enetc_int_vector_destroy(priv, i);
 
 	/* disable all MSIX for this device */
 	pci_free_irq_vectors(priv->si->pdev);
-- 
2.34.1


