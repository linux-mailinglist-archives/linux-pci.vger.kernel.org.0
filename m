Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6E074983E
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 11:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjGFJWj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 05:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGFJWi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 05:22:38 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20709.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::709])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD15E1BE9;
        Thu,  6 Jul 2023 02:22:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHurPOykK4cuq2UGfuN/i8fdcyFm0e/Xp6Py7lCIHPplG6ZfEOW8pM9a67o+3/nssk13qLPilJ9f0Q+uyazDx6/+bu5MY2+8b18lAYn6c+kRJ4bG4CPwnnUrsVMhpassHt+jbAi8DTkxoeiGPDaTUxePT2P+kt2QLDbUzOBUMNtoqF3wvUYmScRAtX/7otqqNvJdOfXFl2K5535I++R2Gi752gj73xRdZYkxkdUJFS0j2FUozZ/a/v0tzA5sY8f1hlIPjKAmEaBAikkvITABKlZlodL2eP9ttb4uNFLbwj7jfNLNIHi8RgwgEGaTjqj8GHPraKHbsNw4EsajCm0efg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUIr4//1Z0vRI5H54BK4dx7TDfrFJieljwl7yeBA7Ws=;
 b=fJovWI5JwgP4sHuOjZasZ1s5j1GXRc26oRQeQbFe8zbqndzbDTD9LFEjJPpbtfIWiyqFqGUqN2hMr8JHpOFghD0xcJZrHyVy/xRN+zcchD0zVeay/jVeyckyGxSjOtqd8kR3HVVWfEz1L/aD5rA0KILtQlBCUPBEp7DE7JzJ/05Ez5vh+zpAOLRPrYwf8jlExsViOUDJjiFsHQsLaGIYfMokwySx4EUpcYpgysypXvFlb6KLIOCeLwc9GPcldMR6xfUWRmI+VmxFsQS65oK7D6lmHT1a3RaT2wac8eWVt+5txRqjAwWFJp//OPuVmrmHhieM0CKTA+xz0NN+OvnCiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUIr4//1Z0vRI5H54BK4dx7TDfrFJieljwl7yeBA7Ws=;
 b=nI2guFCV7bzzplMcK98sKqc9wNaBwoa8rv/qhC8OXzZbOpwGV0XH6WItMSPH4ssqeMOPUlHaeAD1uK7yObeIgT90phy4b3rf5M/tTPSJFaO9MWx8OC8PWWFcsjF0akLte+VAN2KV/XffX3qQZrVZkYHNlz+Ai69kTc2/AZRReGCKy4R6oKRu5IBVYX2OkRt9GBjXXmJd6V9YNpeN8bcpjdgvSph16bo8Pn0YmlSvqXkuF8vSyhf9SSrGRV0Hebs7uxt3vyBiuk+pO8tbeC4verIkpocxRbinG05Y90mEyT3bPU+e5wqd4lIgFgZtONddr73lYt457af/aY0njN2Amw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6378.apcprd06.prod.outlook.com (2603:1096:400:419::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Thu, 6 Jul
 2023 09:21:05 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 09:21:05 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] PCI: xgene-msi: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 17:20:46 +0800
Message-Id: <20230706092047.18599-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706092047.18599-1-frank.li@vivo.com>
References: <20230706092047.18599-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ba6d09-f2b5-483d-c38c-08db7e0252e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KHYIIh+iva2TON+M05vbQYYwoUs1M0QDJmvIOoypIn0VE7j5p6z0TkU91Mnq/KkH/clpJsTGxPaowWx8uokT/RQd4BiiH5tjp9pO11cuDTv0euRKnObF4s8q0nxvxm2lPrOiuhjybQNPgAh/p9wnD4knxPwCjWFEq8NG6+6J5QIjk1skx+12UnHLOm3cufvmBCH6Pga1zKQCrCKGK+Tl2xpZ9nhKooPk8BpjAvakpvYc4nQsbvokjHYP+kiGwUW0rvOjMo0qtcenS7Co/ld7mIG+uX37OldT4yXBilo4+NGB8zNG4H+kDl6X0tgg7BoLaZUDzw1ndcyGoO4ILGoXOvuaJZ/7u/v03NazzLPue3Fmj5QM3hV1FYs6SzB62HyVjtkGhcmU946/FkV6fOAwxtJvMMghuStw4H7ifDM/F+0/ez0mJ5MBlUcO2VUvklTmLXYq1dUR7oL8hHmFbKabhq19uJbJOMOzO9LbzkgT+/XMcvcpRGiwXDmauUDr0vG7la+SarkARpDoFjEz7TJzSrTMx4X+AUt6Mg8/yvk/ikStua+yKYB7br9gGxxiHfw7/dM7LgzO43+Rw8m1RHW3B37xC9LlEhjo/KRWL01t09gRu11Bj9McMGqjSRNIpTPo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199021)(1076003)(6512007)(66556008)(4326008)(66476007)(8936002)(66946007)(316002)(36756003)(5660300002)(8676002)(478600001)(2906002)(4744005)(38350700002)(110136005)(26005)(86362001)(41300700001)(6666004)(6486002)(83380400001)(6506007)(186003)(38100700002)(52116002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wu8BNovDD0bpbEuNFXNqvrmVMGftccpikvJWvocwdFwGOKjD534Vnf5nZd6C?=
 =?us-ascii?Q?glsMY29ScxwLYBKsg8zxrClqDMrR9wkEEoA/PwHBmXihKVTu5zBTvedQYhSe?=
 =?us-ascii?Q?Y5Xh5oUyTVJ+7rKnrIq0GbPVrv7P4/ye4uJ/61D9tf776bqoZe6/dr++t5ET?=
 =?us-ascii?Q?m3h7Uav2AZ2m7AXvC/h9kRrwvMuOzz7g2Xscq0ngeFAs/f5QOk5mF52IDht+?=
 =?us-ascii?Q?S90ojpXWR8Rv3TkhsupUR30WNqwtTrlieB5V9N1gIcD8FRB414/KO7gMHnvH?=
 =?us-ascii?Q?XYrL7z+XpeMaEROqONWJXvh1bbZgBnagCLFl/GlTSIwuvqsgFur0ucfQNTqv?=
 =?us-ascii?Q?1c8WjNpW+RBvfTY7XBmLHj12gMrRUBP/i5QIVCoZGV6ReJRrrO1Jf+HwRyAu?=
 =?us-ascii?Q?e3LYk2eBGhalDU1f4sqZ0kgYft7g752QJGby6Ig9ZD55HSGRIEzLhiaNAs4q?=
 =?us-ascii?Q?SKPLEhS5MEE8za4EHyRmomA9mBAGsT7S/mbsaSLV8niQroiT05D4JsSGPv+z?=
 =?us-ascii?Q?RynYzf8cZfJsUR8+e/psL1j1VF5tFoK9V3D3yDUN7ufl08qR1jrV37OtAqFq?=
 =?us-ascii?Q?bTqQGwB9L6H5GImqh/y0QBeeFkE2Rd65mW5PW5DfIkuwtNamgrRjFIqccK/q?=
 =?us-ascii?Q?X3rMN78bcbc++g29bOY16xnp3yK+pBan4fGI9wUAF0u8kjJTSHYE8iPTveHz?=
 =?us-ascii?Q?E6gY4nN2rHJ4wqk33HMP73chOD1B2TfxoE4quWVx2hKY3It1UCrQG1cu8yTq?=
 =?us-ascii?Q?2n9YOiaAMoFSAuaALIvqzkc+rXyCRw6Jh7qIOOC4Z4ZMbjGnDle15u7SxZk3?=
 =?us-ascii?Q?1RjQmO0ZDSms7cBU927IZ8jTX7j5oa5P6pjbE321bQ5XMP1SbCMxZY4E4FCt?=
 =?us-ascii?Q?9517pQSiSehryWTgvXDKKBScKi/YVpwuOak+YKg+rBDSmzVKCEcb1rB7DVdo?=
 =?us-ascii?Q?Gm3+XCCuF3uHsOE9fIUFtrAPDh6nJJGAKSadVyDY1rv5p7/NjbY92Co7w3Ni?=
 =?us-ascii?Q?59Fft0RCIKcAAXihjcgnVs+vCKduEYG9p8qmM94ueD9pjT+uBtUGD2oVsoT0?=
 =?us-ascii?Q?Sw+j8oAG4lYGWWneC/jBF9Hrz2iHllgLvdzrYE9RGG14ZoHbdiW7VfgHeLO6?=
 =?us-ascii?Q?ZQius83qIe+iLKqLgwckAsA0C0Q+O4SfaELAspP2gpZVJZCFQIA5CwXAFENP?=
 =?us-ascii?Q?TY6Faau+8Kd5rQ+6YWygMAYq7vQwNZq44EAAWUY+3a+gw4p4M/UDzk2eyGYt?=
 =?us-ascii?Q?7V8XOesDHAO+LMz2zIu3KtWDjBEiuJeSyZJgyh3L/5FxJql4LZdhOLOPnDAM?=
 =?us-ascii?Q?CJwIFaDZW+C9SdjygjcDVvtVu6nv3BNieE8x2i/W1yiPtH8Fi7WcnADm6ujA?=
 =?us-ascii?Q?scXKxTDFUvtTcI7tzeizeK00E7j05fsFY9O6uaoyV8wjeXaK5YU3au0oYua4?=
 =?us-ascii?Q?hU++NWBgiculbCFr3JgfjxEH3KK4YFfikG6Vz6UV6He6y36o3MGXTBG1s2E+?=
 =?us-ascii?Q?UlrWoJ8coNTFk3HjtY4g8+4ZBOPfQyzqbhFk2g+hw1OG+TqDR0gygWFyzTnj?=
 =?us-ascii?Q?/6BM6jXLT80pDvIY1o2tDwIyJRk2RVkEz62P07N5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ba6d09-f2b5-483d-c38c-08db7e0252e4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 09:21:05.1516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9Nl4Y6X2TllQud1S9B/edu6C5y9vIwPwbGvuB33RMeOSM/UENQNGWZHRREp5gTRkFGl+YKfBMgi+2+08inajg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6378
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/pci/controller/pci-xgene-msi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index d7987b281f79..d7e09f264d52 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -443,8 +443,7 @@ static int xgene_msi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, xgene_msi);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	xgene_msi->msi_regs = devm_ioremap_resource(&pdev->dev, res);
+	xgene_msi->msi_regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(xgene_msi->msi_regs)) {
 		rc = PTR_ERR(xgene_msi->msi_regs);
 		goto error;
-- 
2.39.0

