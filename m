Return-Path: <linux-pci+bounces-772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D973F80DDC9
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 23:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68AD1B2147F
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 22:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8105D5466B;
	Mon, 11 Dec 2023 22:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ob84I823"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2083.outbound.protection.outlook.com [40.107.241.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0CBEB;
	Mon, 11 Dec 2023 14:00:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfaqCIjae+pL20hgRTnQ7RdzEK9v405UH9SRSME5Y4drV2xkdjCYMZlKX600+OlEy0anz+3OcGXf4QHEaYNmZbM2P6GFtQKMqhpBwM40+sbhL7MHXnBmKWDyGexL8BGLFxKoW2Xh9w2dZO5av/iPRnlwUZeGC0D4OnCTiSOV3yfwc89kE+nZ+3So0HVicjwbX2yh/p4F8N0DkGzR9BpU/2YM96p+sBm1iHWzPyI+mic8CJUBX5K0sb+kk7dwI3eFCygnG/DyDGrsWi+4fzBynTYPbdTufUd6LDXGR3KBiBD7V1FYcN2rQ2HqIWlFmJqRC2ospwUFOXtRV2ADQcCh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+O8KDC48w0NQMLHJPGOgAGokjP/XnC90cLpCcTuKZI=;
 b=DA7t+XmT2uKan9+1wj5Mqq5PNfg68M5iyxVD5QfnqNFOgDTLWE1mjYh0CKqXp/i3/tn5QXrWprHxKtSgI0N5YXjAylnBt4q4jnpanXA/cs74TCYYhUpZbLg2aJhDIs3l9D+Lkp/QO5t2Eg7In+WUKZVlzO6some7B57gwJR8hxQuiPGzA0fJ0ekY/8y18R+7U4VTkmty2u0CRzQATBCIUoL3LBAiQsKzH4q0MG5WKOVUGrHJXQ5ueIJlPk27YY+LjwqBoSyZE1oTEB9SkL7rjVFXqgnQ1xbax3Xivig1g/Yxlroo6DtPusj6WvgOMheeoQC3O1w6Aj9EZ+ZkI/pHaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+O8KDC48w0NQMLHJPGOgAGokjP/XnC90cLpCcTuKZI=;
 b=Ob84I8230pAw0LJZrknd/MazSP6D9kZgazNKEyxWGp7enDanwXMP+psZIbfBgnCUHHMYE0qrArq35+O7D6rxxua+13c1OY0nYdd0Riwnm6vdk2qLB40cv/62dSJFoQPY6jIDwTqV/Mm3w8vd5MiIeTmLFIY0GXfD/KtfHv3XwZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AM9PR04MB7569.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 22:00:14 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5%6]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 22:00:14 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	helgaas@kernel.org,
	hongxing.zhu@nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v3 10/13] PCI: imx6: Clean up get addr_space code
Date: Mon, 11 Dec 2023 16:58:39 -0500
Message-Id: <20231211215842.134823-11-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211215842.134823-1-Frank.Li@nxp.com>
References: <20231211215842.134823-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::14) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|AM9PR04MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 1568c97e-dd86-4ad1-be57-08dbfa948da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HYTwZ+TQNKVGmR5mzYiEEHdPCXweyrlmmC04d7xJK+Yt0mJ9xj1+4ORiAHgr86KdE0+Au6KT6IvJfA6IKDZzDkih4NIlYM8Kxi74rQE/44pKFjFUIer40izJpEZVbnPh/ec7j9/d4MVM6LdNWHbEP0eDYbxS/QFn2dWlPCiI87pagnGgnGOdt5NuYu3Id6y9caWGMoRpVvf/JJjqHbYm5/8h9+Q3fm6A8uXAZfBRlfBYWWAUDkfkIUCzINOpYT0H9UzEvYykBG48q+ZAEO4KqLTVnJYQ++86JGrvWijgHG+nX3yLeS7kodL3f0h7b1ewMpMETksvF9CaO+JVqEhlwWPktNEjd64cohxXQlmTWX8cIjJCUUKverq/lLKacGjoAWpYNj1bzZIhCCeDw9vKcwvRxBLpJ6FCSmqNai8Q79U2xYAc1EZ8j6N4V1yYcgw9TID8vwXgzc1WxpEHTBhduMfpGAilLUCo2Nk34atN0fRD4ygcg3Sj2za8jT/XBsQqHHyHeG0ChmKxLpdMlEzG79UurWFL1TprGTicaMoJiZliD0nGzopZQn+dR8S32xSuqQI++W96AlccwBVy78WVFzBR421IjFjNneDOPI0yf/bLqlM+Xdh2EU4opAVGmGMm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1076003)(26005)(2616005)(6666004)(6506007)(6512007)(52116002)(83380400001)(5660300002)(7416002)(41300700001)(2906002)(478600001)(6486002)(8676002)(8936002)(4326008)(66946007)(66556008)(316002)(34206002)(37006003)(66476007)(86362001)(38100700002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jm2cUxnir1W/HaRcKKXDYx89XQDEHt3QSdI+Ih9JL0VUnNuiOkqNBX+AhJdP?=
 =?us-ascii?Q?QE/NyPBzb2P4l/JzczZV9PdjWPXsTUDJr24/mLYnzoTIfEZCnkszS+VLbhLU?=
 =?us-ascii?Q?NGZBb2CccxhjyqL7o05d2TFWBYJs6iyr/le6LhQwnTEi3T+Kn/TpZecE1h5z?=
 =?us-ascii?Q?U0J/6ZSW5w19rTCezg4a0x7bOgk5hfOByBfboNbVy71BxdDp1fYM0iEStTnp?=
 =?us-ascii?Q?fQHI7bJ7kb291W9I6rObIsotWoWYQE1W8nxibs5rbwYMH/ms+Vk9G3Vpe0u1?=
 =?us-ascii?Q?0hpggCwvP7IOMfTGamWlN9QJftCdHCAoFavPD++qxBxK1eaN+LizC5rqx+m0?=
 =?us-ascii?Q?L+V3pZfBnyu7ZNfYEa87ZUquL80bQ+ncoxz55W5AKAg+SAjTh+U793na1gx8?=
 =?us-ascii?Q?HjjYtWsZX6u4CngmBP8h0Sd9L2z2rJyLnG5ERIJm02E3GE1i+kQOeq2oJSsk?=
 =?us-ascii?Q?hq/QGOCzq1TFCHHVXJxRw/pJKz7Cp0Q+s+sqx3xJUIDx6JvMizeWk3pL1Q8t?=
 =?us-ascii?Q?R7ESDNihLCL/i2sfvX8slKCEoqpneAy87pyaqvWWYZ2SKlUdANl6PhdtLMGP?=
 =?us-ascii?Q?OU4DDJu4CJudCgfFfrsJUuuHw0Wu+YEHWVW7YwQRy0jWOILaBrOdztnCMKvH?=
 =?us-ascii?Q?MgPUC9gGdoYWUH9vcMbcFGZs82NrRoiU0qydpi4mCorZPRZTCeHnqHocu0qw?=
 =?us-ascii?Q?HnlD8mnlEMNxbNUF+L3TeHqe31m4nytkaTbpdA0bCCXI2tfKByHKGtz6oNDe?=
 =?us-ascii?Q?SU+mAB3C/DPGj1qp0xBC1QYWxaPIPVuBq5JZK/lxQihNDDoct8yn+rEyR2Ee?=
 =?us-ascii?Q?h2/Q8rKFPu22i/20qCehQChtDGylMJXrSUj3AKfi4j5D4NXhoqJ3yumRMUKi?=
 =?us-ascii?Q?hJjdh8BoLz7EmgO13XS6Ct/EgGpUIdLckShat/lBK2p3yqN4gDCM1fGrA2F2?=
 =?us-ascii?Q?WnQN/OmX5NtSUcqcsU+7utALSG3nUQ7I+SqZcaZ5M2VfQiYalhI5Pe5BIj4h?=
 =?us-ascii?Q?gAi+M++RQ2z6N9Jxk1muGRCBPKKXgmOk1GhHyFoxDV26lCejCphVNDJ/rrYs?=
 =?us-ascii?Q?uNRljlAUIKc1xlaIJaDTdCxstetTrw5E7Kx42TqWlB/zhW9AsFMWF1v6cmdT?=
 =?us-ascii?Q?C7/4mOAI9vjfrLHYes+mPAEMVw9FdCPc4LbAAB0lKmVSpCDX/IwShKwkUesW?=
 =?us-ascii?Q?vNYF505VgRy4pvY21pO/da5Pbxg6inLiqEDtCP+B9XqXhYneuEVOWD1gtyRu?=
 =?us-ascii?Q?7rGvQvPDhNOtCBXpOuDnMf3T2QfROdGUSdL04Vd/w4vgN5KJYb1QO7AghfJd?=
 =?us-ascii?Q?Ort2gx0WKD/JfQOnlLfTMvXF5qCs4kIz3CGK+nuQ3hSIK+ZoQLf5sycMwTNy?=
 =?us-ascii?Q?qClyCWpLckGJMPQBG0qW2LHhQF6RMw6O5i6Gqh6XMICKtSvgaybe0pCv28TT?=
 =?us-ascii?Q?dNOYa3YifWPDgLCKOdo5DD6nYPcqD/M/Bd0UbR7hEX/BWOJkXt28vK3Xq4V2?=
 =?us-ascii?Q?OJ83bvSL7G04GNx9OGGpT9RF6Y0ul9oGTSCEp0ThzTN7demHHnFgzShAGdZl?=
 =?us-ascii?Q?nIaDA3shAqyMywOzxD9kVMdYpCttheYKhK3zRnXj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1568c97e-dd86-4ad1-be57-08dbfa948da7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 22:00:14.5335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwpIhNzJa4sG/ZNzpI9pEJstewcQiJH6ybOcWyKs7SC6mXFqWJnyYFs4LR/HXK/6r+prann2UJoRGY6A3ty5+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7569

The common dw_pcie_ep_init() already do the same thing. Needn't platform
driver do it again.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v3
    - new patches

 drivers/pci/controller/dwc/pci-imx6.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 99022efe27334..eb4e954e3a167 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1116,7 +1116,6 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 	int ret;
 	unsigned int pcie_dbi2_offset;
 	struct dw_pcie_ep *ep;
-	struct resource *res;
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct dw_pcie_rp *pp = &pci->pp;
 	struct device *dev = pci->dev;
@@ -1135,14 +1134,8 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
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


