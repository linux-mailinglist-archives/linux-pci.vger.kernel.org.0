Return-Path: <linux-pci+bounces-12182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D06295E683
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 03:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F0C8B20CDF
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 01:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F2D4C96;
	Mon, 26 Aug 2024 01:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dUxXquBs"
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2084.outbound.protection.outlook.com [40.107.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D391944E;
	Mon, 26 Aug 2024 01:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724637454; cv=fail; b=eJ42eB2pNuBnKMCB0NySy4lu1kRxAr6p+bS2own1p4L/P+x5YbxPQH/v5ev7KjGCnuJdJAGvkQa7hvV4HI7o35cEuxC1u1YG56+zw9sNfKB/RAYmYI8U+wL7HZ5zhc6PW8bE2Q2PRqdnvgECtQvyh5BEVwU2TggTm1jNddU8+kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724637454; c=relaxed/simple;
	bh=AOZNVejSidUXAuWi1XQxzxXtVL6W4noDCU88cgIjyQU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mlUUSWimVe5eDdDNVYkd8X9QaGIn4uQMzoVNkkOusnkGIcbRGoetzAlYl7AG6I6snBo/mQrBZ84SUaHO4WY4qeGRqRWHNAC8Uw3M5KrDJgHTQ+zM7gCp2zzdy1iChrV3K5IhevZhDLVscR125FbeHn40rC0BUmwBvAEKu8fbJY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dUxXquBs; arc=fail smtp.client-ip=40.107.255.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkLI1QS9/vJ+YALMXFkOpkGOjaNkrsGqfLRcRBRSkqIWnpnUmGfNTP0jWdX2UrxoWoD+rQ5HY8H5zUeqGCBi07F7kW1SeRNnCxGNvduiqP/eMNk1wMEwbzqrc6BksfAF6Mjlpe0oBSHujZgLOXz3eUvED5/jBggrJjCKUnV2DWOCh73bWTTabBmsX7WMHDkp0tkzue01ncOPkorNsALJllJvr40YIjMoT222H7XLr0jdACfycmIFJEEBzPToCWpSgcg/YwT7K+6mGdDnlacbn3udedT2+M10/FYn4xg5g5ktbZGxAFXzNY8eJF/BgYglgIptfxZT/der5s8DzoHWSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xxi5IS3jRgMgRIC7zMIAqT9ADcIVRaVx8qzJJXy6HQ=;
 b=OAxwOrunwWh0kIoQoqLFEJR/ox9nt+kuFUV4mdz4mxOOzwjWh3E2ZzZjROK+cJlCsL7ADJQgylkBoHtZMQicNMiuQvRVv1UoO64ZQXQwEFF+162My5gOIeo95RHKuAsx3eK3Vhpei9Lavy3VcwJmLT4eQasrDk1h0OIyLb5LL23SdG6+qJVWhtJSqRAsqEZNA7X+f8q8OIpKOPhRBUDelEpodVVtUfyV7Mbb4sSPvdJY/DzoT4wuRR3Nee0OsuIzHR0Sz9iReypvfyXFviD+2R2s33sFwuRlsxPwVswJ8x088KXtz4/dOkjuRsXUVE04JT1vQJthX+KQOH0dJ6wymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xxi5IS3jRgMgRIC7zMIAqT9ADcIVRaVx8qzJJXy6HQ=;
 b=dUxXquBsV2GjLzCKziqiKcj0tD47+3OGh7IVkGqYRzNB8yH912RVqETJwOc84ktZJaHuvXPyl3oYY/6lhutbnHT3kOT1Ng7q8Owoi3/IshvE3omlGPKbQ1iVt3jDjMtFA5VjhJ4EUIU1TwGs7gsK4mClS+lSm5XqYmVHJBEAU3klZKLND3BvfN+0S/ILU5sr1ze4x5Ux1qB7fccDOVyKkyrV3wxO0WjQQa8O42QoAqEkM7xZ1mzOQXN6Hq+WkV7RcvSyOcGCRwLnoja3tmtNTOmiJs+Di38KeBU+DqjZPnZcF9TJIxgPa0ID3P6F22iWdgxmKACpO13B7bRE04o+Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by JH0PR06MB6320.apcprd06.prod.outlook.com (2603:1096:990:13::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 01:57:26 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%6]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 01:57:26 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-kernel@vger.kernel.org
Cc: Pratyush Anand <pratyush.anand@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>
Subject: [PATCH v2] PCI: spear13xx: change to use devm_clk_get_enabled() helper
Date: Sun, 25 Aug 2024 20:12:27 -0600
Message-Id: <20240826021227.2206146-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|JH0PR06MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c1757e1-5ef0-4385-2aa1-08dcc5726f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BdKUQ8YjoD7WCZAVmGoS/mKk9OBvuxJzjfF+kVPFmD5LE6M6Wx+OOg22XO5j?=
 =?us-ascii?Q?QZ+3nvs7doDOIcBok88b54DHcgucLgIC++bKswrVkF1gZf6e2SQ7P3W8vcrg?=
 =?us-ascii?Q?XzhWis50M+B0fbWOkf8AkBnESRYlTaFBOs+l8Adef5JdEpGpZEgbx3wJpEgK?=
 =?us-ascii?Q?+V+RsZFMl4JrNs8tvdgfkNEFOHe4xXa6HbNveQQGDGcJCq7rpkwqMIIGopxG?=
 =?us-ascii?Q?R1VBzfwnjYtzQuyU/wZ7Bz+tUDPafGVgonAoKpWhGXH6B7a7SSm8MxK9HCzE?=
 =?us-ascii?Q?z3hv9as9Aru1IDVyLiYiEI8yqpFEVdN/3ueVOTRBDS7dsP1WWi+RgT9zY6is?=
 =?us-ascii?Q?YWfxhTs7uekaJ9tasEYseCOWW4pC5yI7HlTx0E6wGu4t5e9/ejrQqtDtMg6J?=
 =?us-ascii?Q?STGuGWG5RvIcIDCoYKT4rld/AjUXYxIKeBX7IZVwQObTXlFfIsM30jD4jbD6?=
 =?us-ascii?Q?67T7pvqLJFXkTYg9BkFz+iMPwxJh2Ljbys3tOBTybvwPQXh16HbQIfhDzyrn?=
 =?us-ascii?Q?nmJ/O30QKBB9nb0MHEHS0WF/ZOtcl0PeXDJy6A5ze+e4XGqME5rwY+95fhF+?=
 =?us-ascii?Q?NxKS+nfUPSm0BfQyi8B2gtGgXqO6bQK7cxvsNsWFgJTxjsrDvlzYBEcOFLEZ?=
 =?us-ascii?Q?qwOP+OXBsUspLhYJ2zFX0PNejPhXfQb5qAROC7zSeLbjfBY1PgUeRMA67MHj?=
 =?us-ascii?Q?SlVqGhKVHStsVEGKFHt27uor78tnuAl3uLS8Rj6rMgua3IGSMClJs6ZlCXKz?=
 =?us-ascii?Q?AKo1iTakpXIGRDgOOq/uSSu908+Te0K1/OmiNDeUnQ+gMFBQTIhSCb6e+iko?=
 =?us-ascii?Q?Sv1+n1fyeNGaSBNuQ1qcSZd+UR5MZWYlyEtGWO0wsSWQPjKvETUURzX0FjM3?=
 =?us-ascii?Q?hmhpWqSALL0dn/havw/0j05o5PfSM7dTqtqqQJKVRWfhtbU2ePtjJXygmnls?=
 =?us-ascii?Q?HtAgdo9J8+0HK8o/oj92WBiCxBA57skxBX0+QfnxGfFFahEKb6l4N72UZxNW?=
 =?us-ascii?Q?lQ6Jyq0ee/lt3mXnoiEnpStA9CKFpcHucEVAVaqKhOGd8pdahbLIy3GIjZHv?=
 =?us-ascii?Q?fCF7aPttwBeYT1LYqx3+yI8XqXbNvOgJpDJPRcz8zMvC9+iDcAMR2MwAGmXR?=
 =?us-ascii?Q?1gDvHTlRytcB0GR3jfQRUJjL71kFI4gBOcRU6FwnNrpl5NXfg8JigOoMdGvD?=
 =?us-ascii?Q?ZUCFqZWf9ucFTHqcKCr4KNJ50DPc0zotfTTZLqgRoKjP7ATFXxMmHb0n6jFA?=
 =?us-ascii?Q?Abt87CXAjl3JRg2pHG8VXcbfsW5ntB0vMC22lcp6V1UwC2wZkUOyYmXVzeT8?=
 =?us-ascii?Q?8HI4dDONXak7cc2UKDn8COsNLBq58gnBAT0CkoXASotmUri45xqfstGLxLMX?=
 =?us-ascii?Q?xeSuW30DQBjEbJVOGA27wFQWsODsin9pqN/78WPqUFmeifB9oQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cv63zFIeUuJ5CGsvJvWxhPppMbxrZp9iuFc1MZZAGBLOtsnBanl8otDPncQe?=
 =?us-ascii?Q?UAWkIhIPIUC08ZQGXE2lz2Rh4/UF3pMw0Ze4BS2G1wHTTVEafizV2484rVRo?=
 =?us-ascii?Q?NWMARNSHw90aprOTkbQDAmytRjDNM+S5maDF6r7INuSSn6wCEe4/fO5QLqyj?=
 =?us-ascii?Q?qgzrZtzGXkVMcLOx2Hr+tQ9BkAJrIGixKHYnYABUls4MgnHJiKGVddP4wMZn?=
 =?us-ascii?Q?H4kovXLsnkoz4HP3UyqsfXoPkPZ6x3bKN1rjjs1FpLn7+abVKPQC6dCqZzVC?=
 =?us-ascii?Q?B/Yby4G32syYn7yE3nycqbc34thqYueTTNPAugZrExEaAvmA95RHu5LxXzgs?=
 =?us-ascii?Q?Js8BEk3NgEZXlveoLI87ybTvAKtVCL1Mal3vCHXvXYC3gdMVSaNkKqc/pnzz?=
 =?us-ascii?Q?lv8xEIBZpN2Ie+Ogi5xNdPIKSJIySMZXqLrPgmmy970Wz65UqJOFbsGQ56oP?=
 =?us-ascii?Q?eZlL2r6VurfMjXBA8HctAGrMMosRCaYEuT70IgfeCTjAOlsgsHaz3yRFIAzu?=
 =?us-ascii?Q?sEzSlXp6wmFs1F7aUX9I3RdbIPgo2XcFjKTpwaT7dXcCUCwQlnwBNBvfPygT?=
 =?us-ascii?Q?U3UkBNtQLz6Ppp9Te14qsJ2e6FFubqrM8KEyclv56fXNka+DhXcCPPmp+SXK?=
 =?us-ascii?Q?EWXKAk4GhSUFGuMzTGBfRpat4a3x69n4cGunBkzf3E+dvJM92mQK5PlqVX2k?=
 =?us-ascii?Q?OUsxiST6W6hjaGuHLIrd+Q+G722fFTCr+Z/vBIFGeIMFmjqlWyXciRd36Kd1?=
 =?us-ascii?Q?zVukYc15nmU/nDgsPeQharDvsgyONVc6dkyGEZwUJ4wElPxfUwTmmanZTA/q?=
 =?us-ascii?Q?4BtgnQMOoTwUxAVPs/R8VsS8xgGMTqa2+WbDTQRuzQtFdfXToE9Mn1MxybsL?=
 =?us-ascii?Q?k/tAdVwX8Qqi0J7H8JtxMapWwJFAWcV1MlIBYjkcRiXKOpXY9RggI7H9Ie9g?=
 =?us-ascii?Q?BY1OQ7rT1V/lrl4pK+0+7FuKCDIGrT47RLQiMcpprt/B/e0kWJuecF5z0hnd?=
 =?us-ascii?Q?/mnUnIiNxCBWSBDrwz/T9nF87TKWsb2nEBDT/gV9ezQvPpDF9deKzVBcyLjg?=
 =?us-ascii?Q?s+PC66rKpfwove/IRvm6SQEThgYvemfHOY7pPcM5wxhVOtV7GMOdW66fuK0A?=
 =?us-ascii?Q?nMoLZoZjznZ2BfUfa0ep3wKVovQ2hcSxreybH1R4T0FFnnSbe8Mk+2oKOhap?=
 =?us-ascii?Q?rv+jtOo1uetDXeY3zA9dRDMpj3R4i6gNo5joHymtYU0WP6lpEFiQOh6THgHK?=
 =?us-ascii?Q?MPRp4tUdhdYDVyUBNfIwWjR1LitOiV7DTNbtndawF9bgoA5wLcYBodTmMUok?=
 =?us-ascii?Q?mvEyO+n2eXVzaNB+0knXbl+3hOuN319kCiIgmgjObgsqKztKzJTHfFylVC7M?=
 =?us-ascii?Q?X5YjDAIms4I61zLRJXe8UaQ3KUKbxvWY+zpvmu5VirQ20Ur2llCLoVe2RbyV?=
 =?us-ascii?Q?B6nRYH75zXnXLAAgqwwbm74BgqAH+ife2LM84Eri9cF1dDIV3t8hvAWd2PTM?=
 =?us-ascii?Q?0rYZBu5mFJ65WR3xuge1eGzy4Hy7KjlVtY2a2owjKXT3MI3oTIuIiYMU6JfG?=
 =?us-ascii?Q?+Q6iTz3/Y0lkNCozZxfNmG3A1vvUmz1w3t+ylk6+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1757e1-5ef0-4385-2aa1-08dcc5726f53
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 01:57:26.6038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDIgZ8A3ejyl/HrXpiDw8fSDUEYoTPct94CbCdJnLH9GdfIUV/xWVPkIJ3Lt5q6SlPgGyULccVLsLB59VW0O9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6320

Use devm_clk_get_enabled() instead of devm_clk_get() to make the code
cleaner and avoid calling clk_disable_unprepare()

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 drivers/pci/controller/dwc/pcie-spear13xx.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index 201dced209f0..37d9ccffc2e6 100644
--- a/drivers/pci/controller/dwc/pcie-spear13xx.c
+++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
@@ -221,32 +221,18 @@ static int spear13xx_pcie_probe(struct platform_device *pdev)
 
 	phy_init(spear13xx_pcie->phy);
 
-	spear13xx_pcie->clk = devm_clk_get(dev, NULL);
+	spear13xx_pcie->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(spear13xx_pcie->clk)) {
 		dev_err(dev, "couldn't get clk for pcie\n");
 		return PTR_ERR(spear13xx_pcie->clk);
 	}
-	ret = clk_prepare_enable(spear13xx_pcie->clk);
-	if (ret) {
-		dev_err(dev, "couldn't enable clk for pcie\n");
-		return ret;
-	}
 
 	if (of_property_read_bool(np, "st,pcie-is-gen1"))
 		pci->link_gen = 1;
 
 	platform_set_drvdata(pdev, spear13xx_pcie);
 
-	ret = spear13xx_add_pcie_port(spear13xx_pcie, pdev);
-	if (ret < 0)
-		goto fail_clk;
-
-	return 0;
-
-fail_clk:
-	clk_disable_unprepare(spear13xx_pcie->clk);
-
-	return ret;
+	return spear13xx_add_pcie_port(spear13xx_pcie, pdev);
 }
 
 static const struct of_device_id spear13xx_pcie_of_match[] = {
-- 
2.25.1


