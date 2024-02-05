Return-Path: <linux-pci+bounces-3104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0811E84A0F6
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 18:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ECA11C21C51
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 17:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA704E1BC;
	Mon,  5 Feb 2024 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="b2FL3aEn"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE364BA88;
	Mon,  5 Feb 2024 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154493; cv=fail; b=N/4MyPApIZdPEplgB0dUwW7utETgUaMXEwd0n5WwW+Chjde6iQ8gWuZaFGj4r+AphY6ZnJ4Eykwx0Iu/lNKvojh8xNFsdsKKF9ULBYdYPcznLwhmkVl0qJDE0PH2NUWOr40m36/8k2ZE9ANBsPwgOG/zRekAk+fycFENoZl3IDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154493; c=relaxed/simple;
	bh=FQFQKVPf+4vzacDoJKiD1r94cyhtL2YqHTbIydVR7hY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rwlr3SRrTKquU9QKJ25b3TIiqhZ9IZfqGoM/1+6EJpy3TWQVxmIr+vOQM4NupfvuhWRETLwYkAq54oz/lzE3mvNmYl9Yd1C9/xP9/JC2Z9+mgMLAD26Z77opiqX/K6eHaq/kDvmt7nKT8wKAO7xQ0AZfmgmFdmDkJq/JoWekgFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=b2FL3aEn; arc=fail smtp.client-ip=40.107.20.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvEOAqyMsgOSFkyJZV9ItSoHdq1W2sBjrfoIYYVgSQe4gfRg3M0vE29V+oSAKcfhE4UOLAEFWedNqvbYwJ5P2v9ikisG59S0VWh0g61JgPz1gmiWJsKs/8X3astz+WA7sHAxbdWMQcIaKFtqq+MFlInzd/ZNBhjSjmpcQgNB8oP/11xvc73bN0yvNbSrwGl7CGBPs2XW4zi/9ln8h867H+F40nISmHoXD6e7OU8kxCsRgZni6yqjaVTnZCCzRvgvRexr31LUaiuAQb8bh+qTZD10pVbeqCBkqN4uZ5yNJAYiW5GM3c9fJTzcNSM7Sgr9pOWRHzSloZbU4Zpj8Irk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zvNS6Bl5iiwQHAvN/4D8lUZqWGmSxa4uSuNgy4S7aA=;
 b=RThhNhkaNT4eRdMeo3ZpL/xEGbz2CGKwZ6dI/1u+6z4JESO/6PHyt9m3ObtSul8YdI1SMimHJy9rsxp+ceArWNXqeXsN+MoZyUTB3z92trffvZcVViNIMcIIyeUTNnrId7LIJY5UsYjMpubZ7nph1oYYOnE9h/nf0UoQEMSdBiYZLG+vNoY0+4Tz6U/+b/WgYTcNqgGAevnpeSv4IxzmL1PzzOz79/c9yrqFUOlq9BE9aEBkRxETWeiA99oH4xC+qK6Lnt9zaBEkKI1qZiaqPIE1emTVZjhNg+wXBxwKO6458ukTYwHTu0HAda20J4us/5qtnDQkmD6t5GLecTjfuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zvNS6Bl5iiwQHAvN/4D8lUZqWGmSxa4uSuNgy4S7aA=;
 b=b2FL3aEn/FK3j2ktZR0Dg+qFeW+ow1OG3pUA2HCF71fu1NMUA8S7W1JmDyfimIeunjk/q2JE8hkwmKBWLVyfQwhXSpBKmj0+3pvbPgWkviwW3evksPZCOkJBIttvS2ulNtDHJMoZN+T4eO6oskvTrK7J5uKUKjw75qYH6mXorsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7080.eurprd04.prod.outlook.com (2603:10a6:20b:11b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 17:34:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 17:34:49 +0000
From: Frank Li <Frank.Li@nxp.com>
To: lpieralisi@kernel.org
Cc: Frank.li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	helgaas@kernel.org,
	hongxing.zhu@nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v10 11/14] PCI: imx6: Clean up get addr_space code
Date: Mon,  5 Feb 2024 12:33:32 -0500
Message-Id: <20240205173335.1120469-12-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205173335.1120469-1-Frank.Li@nxp.com>
References: <20240205173335.1120469-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:a03:60::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: a8508d75-76e0-4d18-fd92-08dc2670c0d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RoK3IcfFJQ0tb7d1DFenC6nQ0U7OT8HclBsPFRojsRCf6TPDRfQI2Lbio3NCWYwIBSSrO/MhgJXGBQDq8PUbspno7W2ceIH7s59Ha+YUyZQT5jjKNIdBcjYzroX3lZLd3g5iFbR01mIlYKFkgEf8gwNKrrIQxdOEmPmPDhLFCZF6yE5+Mgv+WMwcIrckvtWWKW4EbF3cYU+X8MMMFcPNz2Q3RAryVSpNvuwHIc4MyUYEicEJjSWXcgqQLu2OI7357EPWg2SDmK9hyxg7vZktFAjBY5Qv3RpgxrM6fYwuDtIr9fkQsHPfxHGyCeSZbLpjRxWeVY3J7OGmbvYC+gaKQJMjDvHtg0xEMSLXgyWUNmR1pqO54GFi5RVR5Cb3RMM/oSelvyzzA+2aJbGsyMMHy3Y20OXFA43PvysA6itzwCFSdnBfP0zIO34zFm+jMKszi9TepUs8quoqN389cFOKT/cyUxj297eKpfIaupMLCR0RK1V59E6hM3nfbf/Rgdrbkl2fqGc9ARjX8K/ndoUT9QeZyRO781u6jo/FACxY7bVc5zHFtZI7nTHKTQosHDmoI46IIHlfH6eCOVUBYPJ/SfWdUcjjw5bj2ZUDNSADYR1hoC2xFreWZ9nn80nBElxz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(8676002)(38100700002)(41300700001)(1076003)(2616005)(66946007)(478600001)(6666004)(6512007)(52116002)(6506007)(66476007)(2906002)(6486002)(4326008)(8936002)(6916009)(316002)(26005)(66556008)(7416002)(86362001)(5660300002)(83380400001)(38350700005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vwTRG6AlC7PyFudBofRP3UPT4OiMXVVDwzdm1DKfirCQ2HYK22YktE50KNRv?=
 =?us-ascii?Q?Iry5wyzMQSdjJoWZIxcuCF4eh5EgisKg1nvQWG2goKvuRyu+y0SyUkxOvO97?=
 =?us-ascii?Q?2Qs1k1c825NspUHvXpK1tqFjxcRAlHGhzPEDyz1S57VawZ+3J/b3kMbFvbjG?=
 =?us-ascii?Q?WPk/xM2VTtbH/XtYFhEiY/Uq524OO9OEahS7TP9dXdVoQqm26lUTjwpvm/t0?=
 =?us-ascii?Q?kalq+CXdDnen74FuaXX/Wdsp4LhybBgtraIrFFieTYZMuSJwdCRETF956Nmm?=
 =?us-ascii?Q?Rf9nU9FYPxhtGidiVvLRaE+fMuyjc0w701qXIUdrigGYubmFIo6slkcigihP?=
 =?us-ascii?Q?CNM5v6zLfx3wbTPWrKKCl1k48yPry0J2g8C8kyfFrRn0bcyvISlE4Tlhu27M?=
 =?us-ascii?Q?kXWE3Q7VkU6UnHxsfVBcYY1CTYu3u+scKbFWA/V0EQSRKKsHxI9XamZgdigG?=
 =?us-ascii?Q?79GfWB/haiHz8PCALAZqtFt7dEvggFyJR6+/7iqlw2Fh5bQA+sMCXyk0EEW1?=
 =?us-ascii?Q?gqbxmnnd/BoPSDGLIGD51y2x6gMoaS3Bu0BYYVNbr2W/d4mat+bbWjTIuTur?=
 =?us-ascii?Q?usQIzyzzf6gEaofoCRh/R0WdZv/ZTZ6Z2n/cSlr8zjJr+k1L+Xsjt0Ea80ms?=
 =?us-ascii?Q?E6Itz6Yzo4ri5CiWLrmlythKbB1rY8lUzHug091gwHVq5jzyQ6k/+3zK1o1V?=
 =?us-ascii?Q?nFXkBiirEwf1w4EtV1HNsP7q+MTe7IFBHcRIpY2rwYkwIUvCRhzMrlTnEikN?=
 =?us-ascii?Q?mHAIiCYws0gvUF6smS9T7vTzpWVTArja6wpuTsFQMR30vnK8ENT2c2zGBUyh?=
 =?us-ascii?Q?Nw1hW9TYw5v6g2omU6M9HJabZD3B8WvjKj15TRsWlxlaJLqVEuFj9gCmIDSm?=
 =?us-ascii?Q?SLqNo2RzPjH/82YJveDAfgNHFgK6EufLjRars+vd8FcD/hyvVZpp8Smha6as?=
 =?us-ascii?Q?DhlAwW08TCqa22+BClLjRDzj48iZVE2Eufqk3OSvGGif8EzXOAkOGyr+2mdg?=
 =?us-ascii?Q?0nArzbigtVHe70FZprlaCkVfVgrV3pUk7K8EFpQ76x22E2z8bcK1LrxYA/nC?=
 =?us-ascii?Q?eKeBvHTS1PBHpZj9TA6OYs2WwbD+12caLruJd83kLeaUSDKnH6hUWWTJ5VDm?=
 =?us-ascii?Q?UchtysU7fnD6y5btYBpGUeQ9dqStuHG8XkIv7lPDrMilA+J5x5ZXpZ0iy3v4?=
 =?us-ascii?Q?lbSqT6NJ0TGmSuX4r9XZ1mn2yLfdJk0msK1qspB1kxSskpt5gtz/y10oBdmt?=
 =?us-ascii?Q?jpP96fHOJtVnGa3uMrsBtl9Jw4R21KdQgqnQxdIKC27mHj7o5R5oM3RYB6ED?=
 =?us-ascii?Q?156CwllUzdVbspcfVSEqyQpAJ8HdCUMvHulRcz1gReBGNi82OlkHsCGrosPV?=
 =?us-ascii?Q?fdm6RyZ4R2B5OaooodDlbZKmUmU0cj7VbnDv6/MuA06o3IVTT45ILS2fLqmG?=
 =?us-ascii?Q?T6tMuEOzZwpPKNKhoE5C0JIM7oq0JDzXqW4Ug0H8qsXlSZ8zf3UD1Usb5WSI?=
 =?us-ascii?Q?di+FLuqK/775xOqjMHIjUIqdWy4PGl2uMEVpjlADZERK63xPxGdSbgDdfj5N?=
 =?us-ascii?Q?fF1HHwqY/bcaGa+Wf0R64V266rSKq/hMhQbK7FGd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8508d75-76e0-4d18-fd92-08dc2670c0d6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 17:34:49.4823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0OQuysQUW4RpbUYuGQ7F0RuKPufXQDYu8+0XpMrG1TptCF4rHMtjycwu7Jhjo26TBE525qhRV2C0q8A4eckdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7080

Since the dw_pcie_ep_init() function is already fetching the 'addr_space'
region, no need to do the same in this driver.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v7 to v8
    - update commit message
    - Add Manivannan Sadhasivam's review tag
    Change from v4 to v7
    - none
    Change from v1 to v3
    - new patches

 drivers/pci/controller/dwc/pci-imx6.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 183bb3b31cf16..9cc6802e93641 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1067,7 +1067,6 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 	int ret;
 	unsigned int pcie_dbi2_offset;
 	struct dw_pcie_ep *ep;
-	struct resource *res;
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct dw_pcie_rp *pp = &pci->pp;
 	struct device *dev = pci->dev;
@@ -1086,14 +1085,8 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 		pcie_dbi2_offset = SZ_4K;
 		break;
 	}
-	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
-	if (!res)
-		return -EINVAL;
 
-	ep->phys_base = res->start;
-	ep->addr_size = resource_size(res);
-	ep->page_size = SZ_64K;
+	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
 
 	ret = dw_pcie_ep_init(ep);
 	if (ret) {
-- 
2.34.1


