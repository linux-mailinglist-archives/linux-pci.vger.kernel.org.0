Return-Path: <linux-pci+bounces-16207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCFE9C0014
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 09:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926F22832D9
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 08:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EA01DC05F;
	Thu,  7 Nov 2024 08:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H/XP61Op"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E971DC05D;
	Thu,  7 Nov 2024 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968514; cv=fail; b=GLwlHVT8Grf0yEls6Pj/1wASay1A3oiN0qTWsAI4SyYy/WmwRyMyxaKGNONrsHUCoNL78oJr71REI8ieE6x/p7ovzySq9g34VM7BJjJhLNPjc2RXWg3hW8cp0NY9sN+aZQnspIREd1xlipxSZyPfV/Pgw2VNEV2GkDrwo/QE30g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968514; c=relaxed/simple;
	bh=H7mjlRPdK40FEvdH4bmaeoT9tTh/ZGiZ3SsyeBt18ss=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iQ0pkCplqdi9Wk1vyM5XFQ5Y2mKsEvW94J7/hsI8MinZF+LVAw1qmEF9GSVlCh+Avq/nKjevuQg9SHVq/XvQcG0JfKAZ8MgM1sJbjd/RmG330mGNCWTTeSRAudCGzQyBvGGJeVZ16VYaoZ/LvobAMGYKGDwHNBmaRzaTfonzAFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H/XP61Op; arc=fail smtp.client-ip=40.107.105.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwEwl9QgCw0u24YEPc7o3wlAISdNIh3PknUaXGx+SnN1N8/3EVnrcX5WHXXj4OWJWPpE26EbHMxJurIzIqJzsqub8uOLW1ZnwrdcHm7HaJCWmJ3SfgeGIHM7lP3bcJbKm68Z3HHFaNtKzo098eLuGkcn8Cypui8icF3dW6GfsPXzcj2bm4Ns7S8Ydo86kM9UvZ70esE/2ReUaePPpd7lAMkQcmWTbbCc5MfOlVPO9PtkHlDFs3fjKTdJqYIPkAd0w+UdBxD1EUYjJGvfMaFcXlVzdFkjzpEwmlTiUjeoZln+nIMRleXyvkl8SEDZftsRZSKw6sbbHLxYuwNIfwtnmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZvH3gt6g6E4MJzd8KA8i9b51Tvnsmsc0XSRVcwILdo=;
 b=Y9g6WaKi9vulvG30ZTesooHo2Y6+yEKnXUf5Bre/R6xwg+/9p9THnojYOHh69eYm8lq+JAzpTElyP8VIAfuIak9wgf/ygx5KQ7c2iPIVezFDG+cooDh9NiRr78L8bM9d1XeqfR1i8vYus6xEMpJq6PLuEO+TmyOOwnQCaaf15MMVw3SBZ8cl0FUy6y/qaJoj79ASAAK6aC2rZ4N4Xj4drwjFhjczcavZ9oJpgkBySPnRCrebQjiMp4WFx15V93DGs2iEUyUBjFqvi0OSpEyBhX8723uyZHvfjjo01/cwbT88sfjVWonxKW2Ihy+/3i154XeSfM14X3C50BMHhCFPcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZvH3gt6g6E4MJzd8KA8i9b51Tvnsmsc0XSRVcwILdo=;
 b=H/XP61OpyR3tr8ot7acjtPV9hu9spj0cmyMArF5kzDTvgt/XjIvWhGtHdc8Ero7FJwFkMQ6F7CHot5Va6OjGskOO+4glmpXaK230YUTin6zf5tQeIRq1dsX0rbbXrchEeHCjRqKdTu5IIqIRcbfPfp7CnlXaZHMvrWY0xLc/V9C5gI4I+fGgp2a0xIU5o9z2JswDTai7ut9aJbtd9XyXhb4T/bPs0dOnBeo0XWCa+C4Akxx/LeeexIRagy/MujLG68/ODIa/OF/DTHtRFleoI99KWw28usvXe85gE1gCf6SfYU7iQKKDrL7vvzZx8NIGABapxPCO3aBrTer5e5T5ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB6847.eurprd04.prod.outlook.com (2603:10a6:803:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 08:35:07 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 08:35:07 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: jingoohan1@gmail.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	frank.li@nxp.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in dw_pcie_suspend_noirq()
Date: Thu,  7 Nov 2024 16:44:55 +0800
Message-Id: <20241107084455.3623576-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|VI1PR04MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c20da41-b965-42a0-e322-08dcff071535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E3PPxVvMdo1yqR/2PrFfmcG6JPcd8muJ7c6VkBso+xy0xEDNZ5EKNzLrv6zF?=
 =?us-ascii?Q?RpiR9rJf5hX21p3qSjaj/4diAjdJeMkJSK75B5nCOCF7JyQXA5VtrJO+4aag?=
 =?us-ascii?Q?iq0Fp+Tm2nZbX4MDcx+GTSkjjyGw7SlPavLmCf5M+lXTfNVJxfg18NF2HBaU?=
 =?us-ascii?Q?ku17iOv10B4Sahj9kpM0qM0TCD3Sa6gXwa2GqONN8WWF2aVb9qHQuuXBR3c1?=
 =?us-ascii?Q?6v0DLf/fCb+iXIHqqECYras7YJNaajYQd61y2ISH1qi9nYKnLX2ai/KIFYZR?=
 =?us-ascii?Q?A6Q4k06TZ7HEJxV4Th1wDz7Tt7X8qsprUktlCqUAyyeMOdwDXVkPieA54tli?=
 =?us-ascii?Q?KCQjZq/ojDlArjHauz5dKR8Oe973aVshmDqoBHtR926siYaaLJh5Tv+XszuD?=
 =?us-ascii?Q?RdP7fx8/bPHuVpJustTSCjmUiPeYeCBsmUdz7cqyZRPv7WsrJseq/TYwbaC5?=
 =?us-ascii?Q?hHNXlbfdwGxRU/ZHAuCZO63Ksic20wOb9E1BZ6OsSpS5TO2GUQdoQmeL/MUT?=
 =?us-ascii?Q?uqSm3fYiPBPvgbSLMy5YEuo3Kxx1FBwgLIYHFqHzJ8t6t+bEjz7N+WLmCbrz?=
 =?us-ascii?Q?vr4J9TH044lxFPcDyRx1h73KESAeJTL/cUGu6YOC5PwuSLmFrDsj6tOio4Jc?=
 =?us-ascii?Q?ZTmBnUZzgReWrO2iwjSK/J/JbT0z44uacPX9TXGTuVRqQz9r8eZxkbQkTLe2?=
 =?us-ascii?Q?fsCkLIAEdPTVIjr33alJezmXy6B5P8qAAUB6wdTGNtJBrfOL1Jf4/7UNGBxa?=
 =?us-ascii?Q?r7LC57PBG5g6//WB5JrpMgo+A165hhKisIADXI3pMY6KB9SQu8YZ1gC6K6+l?=
 =?us-ascii?Q?3nMXSxzzdSFg6zoat3oTX1pePW6iZTES7w9xbBipqDpCdlYiP4i67oNKMkVB?=
 =?us-ascii?Q?qlo/XWQ6xGWgsTFWSpn0WgC1SKBUpkInzpgEOrtfnhnYBR20CDVUT1NCoAbo?=
 =?us-ascii?Q?0weiBI/V/NUGfm4XfT9Lpd0PzHg4oH7qSZTMz1Gk5fldKdMwK4JHAW4CJOfs?=
 =?us-ascii?Q?7ynlwvFbum+tNfin0DDsjda0UnLJnP6BByDs7L/PEYJuxRDQnMRfGdu6Y4/s?=
 =?us-ascii?Q?fsrAIcDlMY0xlPFY8xg81h3quVOOMiFNDsjMeZ8Olwo2EAXMdGceITQnHKM6?=
 =?us-ascii?Q?OGaMI+cNV/DkR6mHDKyEffYCxmEBsvot4KMqnb0/t1YQtiL1va7XPd98ubUy?=
 =?us-ascii?Q?rmSmgfHCbYr86HRiG+tqM7RkQcmSeFzz7i4CKr4dbpSYkvfGBQGL3HrsUhmn?=
 =?us-ascii?Q?42f9OKrXQ8mUpWwd4GzAmq4Rt+l/sbZNoYwcYPKoKMeXw146LEh6XYFJjqbu?=
 =?us-ascii?Q?SxAJMOnOgG29iEP7rgLl0FDbry4dVdsQjkxuhSl7HnEpeuY+v7NIDwSYuHvQ?=
 =?us-ascii?Q?sOg4qgk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p70JZ/sNg87hmkBrNRpt1fcixqAgCQ6iJLhNQCXpHkfU8mQycCNrwuqIX2Hk?=
 =?us-ascii?Q?MZrgUwu3Z1p7SkU2zNntNovY6u14/KFr4KredTaoNijQXsxhqYTL5JFT7iKC?=
 =?us-ascii?Q?wmnWe94f/J2Vt3Dck0oRCJvKp7n6PNnPWTjkmW9H9/UnSGkWdhjdNbGcWceo?=
 =?us-ascii?Q?0hgXKpRHylmvP2KfF25rmxpih2+EAJBcQ91bIhPfMkii2PXBDWuMWLFVNmNt?=
 =?us-ascii?Q?PJdBkJuxcc9I6elT/CNZNSpw323D6li6V/lMqsQpU6SH7BQg80AEARDV7uiI?=
 =?us-ascii?Q?uiw+6d9v/7cKHmAQrdbFvgbSC0S/ddV6+CCmzdy44qs3up7zRrhcvBdha+90?=
 =?us-ascii?Q?4RD4TtAHFQjploCHbzm4PEmLRerAsTZFSD2viwi2GJNTKHQ6yljVwgCUwmdE?=
 =?us-ascii?Q?EDPgDNHB87Joezzfi3Z06p1E0kugp5mp9bDineFTaUawVaBblD1JktfR5YfY?=
 =?us-ascii?Q?8Iz/iG169xE1aaDduh9qEF1ItwdC7LgbsBBW8HHdUX0z1lpH69slKEYRj/IJ?=
 =?us-ascii?Q?tpSaCc+dfOATnPQhHesNC/FqDlQ2ypIswclxeBBPGbIuiZ2FSfAhtDe/W96m?=
 =?us-ascii?Q?nWTXh/MftGbQgAOUvsQl07kDQCSdHCWpe4mdHXQV5noXEXYckDG0GD/I2Hlz?=
 =?us-ascii?Q?75XR4buDIObh3GjxifCDlIVd0PPEekfLJLalt3yt9ItA66tdvTNoZWjwt1sA?=
 =?us-ascii?Q?L9LX8hFHhubnPSElbU8/he3NKvGJQBnEbKKjD8kCLG2NabHwfzV5F08iEJOu?=
 =?us-ascii?Q?+QRyb6BQuUI2/cP1NlOurG/QzXFudX9OmfpR/TyMeKf2v/3+Gm8wNxGo+i5J?=
 =?us-ascii?Q?+iJG7ilbwAobfEo1t98mQV7XXiOXre9NWttSJDbjS5u/cnwhUbbjNUnabBEv?=
 =?us-ascii?Q?IZ5yDmoLXDf4uwL9CS6MWJ6oevD1aiVrS1rBl6NRnOWS7Hul41w/8LLZytBm?=
 =?us-ascii?Q?OrLdUK5VqZfv0vykwC7gW+Sf5aYsI6Gtfzn8Mxp1lJjcK8fL+d/EJL1TYGyo?=
 =?us-ascii?Q?xT1+hqt64iVx2FHCcldJIJt2pEod+3Bg3zo5THtIivDcVx2RzlM3rf2n4cWH?=
 =?us-ascii?Q?iteJn7XlJksTEfjj/c2kpRE/0rcN2Y0oYg3pGmh1u/O+7uh50en4piplY0Sd?=
 =?us-ascii?Q?pC5sWuJY1lAqX56fSZFVoVSP2YiI02RLLNosipnHmgGwOeAScH3nqy3Fwo5M?=
 =?us-ascii?Q?jiWjQ++iKr2bImXv7XJR9Rj5AOlocACbWaJOr91ycV0HqFttAzA7CEQlyyU4?=
 =?us-ascii?Q?P0q2M8h4sCnY8UPbRtcmX4QmP9KCy0w7w//bxXqA7UQJ4HvPuU95SnoPE798?=
 =?us-ascii?Q?LhovvGIITu/AfLcqb86WJstFMe8YFJrlMkM0uq4eJjZMRTQYUJR3/YDOwxU4?=
 =?us-ascii?Q?jBeyfoePELlfxFM8Y+oZ8lCIGrmACKGv4ci28ZS8s3QeDNIbtbYOXP3KFc+O?=
 =?us-ascii?Q?P35TNdoCic24CGQOUwOt5aMO2LdoP86UhNdAsiO7JRQk6arNjBFvXjKoS+5B?=
 =?us-ascii?Q?yz/lqU6nAWlHG5U7cvUjt65uCM/DlQzBRr2lo+x/YcA0l02aaBoC3UluKsnQ?=
 =?us-ascii?Q?inDrIaI+yxpefad2XflPfWPfeSy4jQX5nvXAn4Ee?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c20da41-b965-42a0-e322-08dcff071535
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 08:35:06.8761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sNyoIfVsI20iY/Qhs4O8eheTnXX2NLIrEzEElEbejFlkrSOeQLc+X+enXNaoy+Dd/DGgPzugbgOVN8aSXZshA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6847

Before sending PME_TURN_OFF, don't test the LTSSM stat. Since it's safe
to send PME_TURN_OFF message regardless of whether the link is up or
down. So, there would be no need to test the LTSSM stat before sending
PME_TURN_OFF message.

Remove the L2 poll too, after the PME_TURN_OFF message is sent out.
Because the re-initialization would be done in dw_pcie_resume_noirq().

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 20 ++++---------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f86347452026..64c49adf81d2 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -917,7 +917,6 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 {
 	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	u32 val;
 	int ret = 0;
 
 	/*
@@ -927,23 +926,12 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
 		return 0;
 
-	/* Only send out PME_TURN_OFF when PCIE link is up */
-	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
-		if (pci->pp.ops->pme_turn_off)
-			pci->pp.ops->pme_turn_off(&pci->pp);
-		else
-			ret = dw_pcie_pme_turn_off(pci);
-
+	if (pci->pp.ops->pme_turn_off) {
+		pci->pp.ops->pme_turn_off(&pci->pp);
+	} else {
+		ret = dw_pcie_pme_turn_off(pci);
 		if (ret)
 			return ret;
-
-		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
-					PCIE_PME_TO_L2_TIMEOUT_US/10,
-					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
-		if (ret) {
-			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
-			return ret;
-		}
 	}
 
 	dw_pcie_stop_link(pci);
-- 
2.37.1


