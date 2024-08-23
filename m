Return-Path: <linux-pci+bounces-12056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8A395C2B1
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 03:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65E81F227A8
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 01:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAB914A8F;
	Fri, 23 Aug 2024 01:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZoHNWb8Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2062.outbound.protection.outlook.com [40.107.215.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BA5A94C;
	Fri, 23 Aug 2024 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724375434; cv=fail; b=db4STfup4mmV7DDD9KRXA0578jwdQB/V9WsRaBjT7+QpH4QBAOO1xlFAwce1LwhJ96sQPoUmTwqZDtQJIy9LLaq7vVli4XBRoDEkle6soK5I4t6xHVr7vqpQDCt3csWpe5ShHrR5AkbPaFP956WCOx1RSwgd81RDjAxDL9pEWu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724375434; c=relaxed/simple;
	bh=RgSyywVQU7oVZ+Qw8ygMGvUe1rIQuaIVsFz9ACPAOgw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JP+7WopOg3Q+g0EDDV4+e5f5yTmm+8AM7E8eK4pgP/bRo1mIOAL2SB8Kmhoj6JGYvZBTQX43KLnMQI+ONnmAsBfRHKNIhrlK18d/XYT9OUiROOMLxSk19fKRdxci1eaGqAk7kgv5hKSXR2h5Zw1JwmPq5Zfd4/pJHStza/sjNlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZoHNWb8Y; arc=fail smtp.client-ip=40.107.215.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2pwja+pdBRUN/Iv/ioXpGxPXdc4UkHKVnTCN6WTuZwtksK7d1w+816RPl6zoxocSSA9mlpm8IW1SqgSI5fbmcflHJZ0EvWT/5WS0UYVFfhty/+d4VEG/hSrTTFsJiqK1WGJTSDKEgrLZB1/92zxWmYNXFUN77CNkJv9o1vNWe2/B7vF/eEH1frxKxaD7JwsVF2LrhL6EYKnESgYx4jNhctIPGxjIU4ifk3fwgXoZZRNup9HapiQCV1MLxnx0K5fsFlaW/Njtm++Tpx2NvRgrTKXaDIePEAaZuMSt4glFA3Lmusmcmv7Qs7ON1ePjgT7rFPbAD+H0NhYIDv/sdpM+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqb16xGlZnKrZzkCG3OK6awKgAyzqeF0q7Yp3HJwSNE=;
 b=byGjUfsXooZlqR0Vq5lVd10YzS3UNhmQaPV/pw8y1W78Bu7NF9L7YtDALhkIIo8Es/GwvIF14dXRQSG4Yz9UXrSwxgl3KJTgx+ImfJCwoDhoowAeuNl8lkGFj9lmS954xduA960D7FuQab1ly4FIAkdHoS7Q27Z4nJQCO45HrngZCw6eIHsnSPyu6LlUmAisNl94nhWK9L+ra3x9oEkRLusIEz3s4j8pBDbQCk624Z/0qpIwyLuLslOkdtFkmztQhy01yrxb3VO3lz60y6xYNePIuAChSqEj4jZAxJM5w4yhWP9dy6qdpzV5eN+462qZKvPmOJq/TUxcF3z2DS8V2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqb16xGlZnKrZzkCG3OK6awKgAyzqeF0q7Yp3HJwSNE=;
 b=ZoHNWb8YCH9mz2eAze2iLXcPUskwkvosV1fr5j55SFe57al7cn1516hQjEKuXIBQk47oPH357HXqrZ7bfZGPms8jQ7TF0NY4Ruy8LlFpIGh0e22wWU3Bm9EFmClWEKJ9aAYFj80oleIXaZX0pe1eG5f3LThFBykbl327pcjfNiUqXRRa95R/GnO2xPeLSMF0gkwq1TS5akuXhPoJwEJFANzyf7r1k1MrpDbL+HZORD3/QDEvsPHSFvK0Mwxck/grVLDj/qIU5g2+w3ljlQYZZ+9XOUu6cCt3G2QuMTLUXjysyDJNKmH39qn5XSy5XjK2JxJas1w2Jnu6//2lJF6GUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by SEYPR06MB6523.apcprd06.prod.outlook.com (2603:1096:101:172::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Fri, 23 Aug
 2024 01:10:25 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%6]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 01:10:24 +0000
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
Subject: [PATCH] PCI: dwc: change to use devm_clk_get_enabled() helpers
Date: Thu, 22 Aug 2024 19:25:16 -0600
Message-Id: <20240823012516.1972826-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|SEYPR06MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f6f3fe7-11ec-4161-15af-08dcc3105e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4mpSA9UHAWiHr8fULh9WI6I25obGKu03nmWKi/YPCSnQsIdSeq13+wYwR7PU?=
 =?us-ascii?Q?SlOMjlpUt/mQ2SZsipEEkPjtqIlbytQv1gGHXfVIem+rlRdt9dVOY8GCtySM?=
 =?us-ascii?Q?4bFAOhAjwHW3ViXqkHF6KbUQyaVACuTizErxTDj0N0SXcWIwbKf+3G8CV2OF?=
 =?us-ascii?Q?nf72HhfShMEbZlukB3Qsuf/ANqidjF68Jrmw63QDfOWCf5dkxyQyVD1UgihD?=
 =?us-ascii?Q?kUa/zZ9PlDOgDHQaLVbLCyOpScsjr4epezRmIJQYJhUranl9esVkVZ8SS0ml?=
 =?us-ascii?Q?cp4BBRA5Kr+fCSyidwC5qUK3J3xK1Og+R/xFbctlabkHT/jN/IlK2PNU3dF6?=
 =?us-ascii?Q?B1na3+X8x2cpmyYn2FKZVhuHc/Gh/rnE7joZ7sUt2jDN4ZK5Q2dwHX6A/PuE?=
 =?us-ascii?Q?GWpR20/vEYNv/zuINSjz4s1flHOvshJ5eo5f/E+fNtbUSTYOLZ+H298YU4lx?=
 =?us-ascii?Q?o949MBsgW2Ay5LPGrmS0o0oluD8ntKmGNgQrQEqzZKa9wKI5Ukrj0BQU6B6q?=
 =?us-ascii?Q?Ngm06/pUfduvjwFTzmEcrBLZjGSKHzHcQxauAON2dZ+Rx7frcbF0OPgbnHq9?=
 =?us-ascii?Q?5cLbMu7SdvaSLSjIZZzf18whwW75w67EiiizVvvCClZ/TyolxQ9Pm6ArJSh0?=
 =?us-ascii?Q?dyCFVIZgnvgQp7Qo/2FDmUM4IzftggTxxMNwoyNXzbAtAoH7fQBn4wrBf3XB?=
 =?us-ascii?Q?DcDwDP0aDddMrZZixr+vVW1qNB1X9Bhjs92iHJZO5AzQf1rgVOokAYFZXYpB?=
 =?us-ascii?Q?dN8mbr6HkEVDqv0fHMutzZoG0KzneoUfTSqojFQ0HyikV0sPDLDYxv/sFJv3?=
 =?us-ascii?Q?S81LM+a+hyBXVD0sIfir61R7mvSVB9DPLiXHj1V+taoZKcdpN1nTvcAiWOLy?=
 =?us-ascii?Q?0lwigcCUpa3/LOXlItroAkyANUvLksH7QwBsdt1hj8d7tfdhS/iFsRzo6Zeh?=
 =?us-ascii?Q?MFyrtFREPm3iSkPyYrZPIdouzcG4Y8ACYJ/0vUDRYjnW6nek0aWdlsBBLFtJ?=
 =?us-ascii?Q?LjX0nmlRpLOVLHswOOIzQ71TfSizK49nl6o3E2/T6HMdTmPZ6pd8JihJU+MS?=
 =?us-ascii?Q?iNmahVIAhKSErwYkMPBJ04VngIr/QQPAP24wnj4/60cLdYdEkbq7TJlHGSXY?=
 =?us-ascii?Q?baR/mE8QxPdASqe3i/eZZOuj4LPuUgB1lJh5TexIN2Dfn6/4A4WHEHlwB9bj?=
 =?us-ascii?Q?vxlAFZz/Kvp+pCXoG0gYkw0eujxIANtt2WTvkcloKKaYut/F6kgjpDmalNbV?=
 =?us-ascii?Q?O3/evAlrL1VAlxGcca7/GuEJcQQDglepAJC5XoHG0eCXvv1VOQwTK+jTsBbQ?=
 =?us-ascii?Q?48kI1hS6nVBu727TfGh9ItBF6UzXtGv5iAm6J3/JqVRGOLgVCpTl34lJjEqZ?=
 =?us-ascii?Q?xdgAXnI10C/rVFH1lmCbGS2U5AAgYtUwlFM2yT57wGYyPHmcTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IlZMPoAdCryg+lUQ/KdWVY2KAI5bUySOof7rE9GMcf8JDpVg7K54HA2EDape?=
 =?us-ascii?Q?uVra+3AtN2cqyMKUQod0OalHweF033DUWSWJRSQHJ0CB5szzohpWc3RjocqT?=
 =?us-ascii?Q?GOExBfNJ7iN7/XZCEX66Oj+HnPMMvJodoXuJIOY7gVRGAOpp2Q9FSr731xvm?=
 =?us-ascii?Q?kvIeVGst5d+IVuG7YMTTZh3cikjKxVLZedSew/KIgXJ2es3FotMvf7w/UseQ?=
 =?us-ascii?Q?PLzWllVhDrfbtQmLHDLmZkEKvR0Eah1xwUcvPpBmKMN4O4QAyeK3l5myGEcv?=
 =?us-ascii?Q?fHnAtx0OT0+Wl48y/ADgq8NBIHUYT2wTiI7Ju7vYvlKKfC4hFUA92APbC+pB?=
 =?us-ascii?Q?poRKfS56ItJ/clTuAvUmruOGpZgLHivHJ4ygcTg8M4vxKc49Oya/LHcQEt9a?=
 =?us-ascii?Q?niefmad4L4E3ySCspagWpeuItjVERLTIkLHePuwwMEJtaK43n1p+W/dMF8hJ?=
 =?us-ascii?Q?mW4e5B/Vy9NfEBOBSfg77lyeIROd+UWX7gQKaQ8UmyqQ7jqLm8yZihW+2QHi?=
 =?us-ascii?Q?iN2d7Ir9lormIa+Nwi8WWFH85JuueMJ4T5VIUVGgMfTjIGOR7fF3ae7BTQoc?=
 =?us-ascii?Q?lsaBrzSZbgggpN5/0rj5axrBBGhrbJ03OqRBwl/tf+wRIGYnpj1fE3I01E4Q?=
 =?us-ascii?Q?ak1hBsIFPZ41DFESBCXztw0s0JJCXfKCuWztksaF0x6qB8aXm6qOaEA1nRh3?=
 =?us-ascii?Q?a0XRxGqs50uUWiE3gE5QNkXk7pSpE2vvOxdGOGD9bAaOPPtmOFK/7XG2Le/q?=
 =?us-ascii?Q?Y6o5JysJoA6ddOFRw3h3+vOGotumfqwN7PDwwsZ7Jd5/TPFsqtNN6K3ziB59?=
 =?us-ascii?Q?ZnoG+U6CMqNNAd4YvGBN/MesLLHOs+em4o36LKTbARkz0lxzRTzfEJLpu/rA?=
 =?us-ascii?Q?Cr9+sdyExhLtJ9KmuTTHwO2NczL4+F9hzSisp2QSeulRCqFoILROxP5BZWR7?=
 =?us-ascii?Q?gcdj5GU/CGDMBcf0H0sb5TTaZ5EEJyAdjhzkGB4wpvbTIyCiVIadiUWR83yY?=
 =?us-ascii?Q?YNp3bbHDxFXxUa7QFKzliuc6epkAd+gq5ArZ93Okj6/yk0AuA+xXQXHDDcIh?=
 =?us-ascii?Q?IaLKu+9/P5OSxL7fmnbyx9N1vLWaIdz/aGUMLSCurcAVM4nPUDvnWZnIpE7V?=
 =?us-ascii?Q?06vlUcnpsyIVH8S8FAmx6vjsX54ohhw/4Arm7u5MNj0Y2hbTYUnMzgfKLn6n?=
 =?us-ascii?Q?bpYPny1trqBh/4uKzzP9z0Brw7SlRie1Bv7PVNsWhq9VtxITq0IBX7IRFH7Y?=
 =?us-ascii?Q?n0aGMgTEw3qmpNBhQ0ZEihUA4DxXzEoIQrF6vS18Owc8XwsQkb72e0a5HRaA?=
 =?us-ascii?Q?spaEbF2nGGzkedI4wliYCSav3ipG8I/oWqiah3SSVQOWWpF5p1sj1wWLWr5R?=
 =?us-ascii?Q?AF2jgy1pw3YfRxFjDhH9ke1M4yUcxu2jzIeRlv5Dky2ACLQiIOOVTzcgUVUd?=
 =?us-ascii?Q?Yr100v3Hxm+hsb598DFrswsBmn84jxaT8ki7zZsGQNZfPKcLJveBz4jozDYd?=
 =?us-ascii?Q?C0jENFOFN2LesT5OE6FIz0R7+2kyoX94th1hwWlUAHfYydAemvr0Fgj/vV7g?=
 =?us-ascii?Q?5yh0H6fM5Q62djMpvGz1kyPDe8m8EWrk2TDmr4XT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6f3fe7-11ec-4161-15af-08dcc3105e04
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 01:10:24.6108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20XYBMwzTMXvD0VnlY1Wr5HFJVa58z96HuleQ782QF4oqX5f5VulNXHnxs3mdBvZNzfaY0A546CBdKmGOXvLcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6523

Make the code cleaner and avoid call clk_disable_unprepare()

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


