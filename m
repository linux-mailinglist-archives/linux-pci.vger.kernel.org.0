Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07C8604D9F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 18:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiJSQkW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 12:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiJSQj6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 12:39:58 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F1F937BD;
        Wed, 19 Oct 2022 09:39:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5R2CWkUbONfEC82y5KBksiLFZVv9Gin4ZHEXpnk8xVXHjB0S4mbMxTqATSoBNiFQa7QdfGdrXgJ3hJWwl2uxwTB+zrT3+kQZYitzPMFK80+7rXKNhWphqFbjFvJWx3Q+n8Jf/qmue78Sn/DRLxhZaUjR2vtHTOshWDdEhQKJTj1EiOZfeeWn61l+IUDArH0wj6K23pebivCytWUoErzSaxD+4FVtFg+m8bG86ziQ09kTtnsXT1jSV8/OrU+JhaqQxQSwl9wITPJApdDAi3wlYNYfmkmQtp5r6o+6EHobtTk5XZlBKUmFyXgd6EdqI6qJOkz65JWYiA9pm91XSROHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AF6juBIUfEb+5nX+4ySQMH0fMffTYAz1usWWEhHb174=;
 b=Nft1RDJ+UisH3JQKtXuc/FpA1Wcxybf5ZOzWGxxLnChNfYdR61YydBxJ0ywlfuiz+03ie9hL82zpp+mLYDu8cU2v7/wR2I68xFYN1xpJm/Itfe0X7RQFrOF08l0TuV9Hsd+W71vv1x8AnCY5HyDezTMbTOAOaXbcQCQnomlMbu72+XRUmmokzCTB58gFTIoTaN8rFipu64GAoMa+XeR8EdSd3ToIMAPt7sns7I8nOKx1FlGIgRIPyNp9dCTn/Wi4UBcfwXardp9eOJ7IsupL6NwgqL5X05Nx/2uQuF8XJEoI8GOwBGJvAkZhIBjiO9Jy7CpyYk/HjCEr0r2fZiTFjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AF6juBIUfEb+5nX+4ySQMH0fMffTYAz1usWWEhHb174=;
 b=MUScSGFY0HQcbo2RSTWpd+CtJiVr2clgHfxk1LMyxABoaooigctlZJQSqpd/fMnMr77gnNiYBVVO1HGyGWrc2mWnCYJbwz6XowQDlIkjFqm1mwCdRtoio8c8LiAM1bQZ9q+0NWKQJazr+wRYBd01KYwpWEYcQZCQNLgrJLpKlzk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DBAPR04MB7318.eurprd04.prod.outlook.com (2603:10a6:10:1ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Wed, 19 Oct
 2022 16:39:38 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::6110:8304:5648:88f5]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::6110:8304:5648:88f5%10]) with mapi id 15.20.5723.034; Wed, 19 Oct
 2022 16:39:38 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     helgaas@kernel.org
Cc:     Frank.Li@nxp.com, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, imx@lists.linux.dev, jdmason@kudzu.us,
        kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
        ntb@lists.linux.dev
Subject: [RESENT PATCH v13 6/6] PCI: endpoint: pci-epf-vntb: fix sparse build warning
Date:   Wed, 19 Oct 2022 12:38:55 -0400
Message-Id: <20221019163855.1267295-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019163855.1267295-1-Frank.Li@nxp.com>
References: <20221019163855.1267295-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::27) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DBAPR04MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: ea78c336-4a2e-47b9-105e-08dab1f08396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nHvwUC9ANFqclWnICAlOaz13nRvRwsrO3zGL+ieWAN2hyjB4DTSwRBS6VvNwNmD6MLXSrH3aV8oj9pdZCrmPBFSYrZtP8zDb0kJ58vJhp9nN6WYH4KnxrteOGzbP1uA+7fcfHqpaHrQ1CLiAACtfqVxpE4mz31nTsg9t2Mnvzcagxpi64oRxa0YtwdACPoUgmy3E4D10gVgTUFt1ljNojYbuwKfRYAcilZrg6wAdlyUHDXTwQRCO5gEvnluNtKVaRt79/QSyuukcEAQzEcyn83yOSeZtLT2LI72bHBgacWw2qej3WrYjPfMgwVn9MTQJTQvFhGg+L0abb3SpEmeAHOVTWE3Wf7sS8OzMTQ8yztmV1JG7L0p37tel0L3c/EBYMhI+1F8UrQccZhxvivjNfGghB0IC9Q+mWNq9FbaTbHJO5bswmww6oA41m1klsyYNzkSuISo6k7HkxrAVel8w8aj0soZ/Stkcq+0IpRUChZ8vP0vPBxepBLe3kttWN+vxpzL9POSR7WyGZdwZlnY974dNzOpWOISgO0ZTeegNEMF6vfnBHg4Wq5OtsfV8ceoYUJuo/jq7PEFAUR3oSM11o1czV0T5ekyEdqkOnu4iFWdChUlx2YeOOb2tSruaDJERyD7DLK76mwbWBKiXixAz+3g85pusiTX0XEj2U0b7qRPb3729oDbFzXoJOYUokL8Dd6ZelJiMadwzg8RN6lUSKIhaEAmeJD/noPusLaVaHZz/zOtDrv4WexnuJncv7nMW0Mr1DwLTIPB14cCVT1Unyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199015)(41300700001)(5660300002)(8936002)(2906002)(26005)(316002)(66946007)(7416002)(6916009)(4326008)(8676002)(38100700002)(66556008)(66476007)(83380400001)(38350700002)(6666004)(52116002)(86362001)(6486002)(6506007)(478600001)(6512007)(186003)(1076003)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ut79OYt8KocfJOJkuP61HyKzkvqSAPXWOYtmFCq4++cs7pa+/0sNAw1ZRFDW?=
 =?us-ascii?Q?toAyZ29RXI7Na255bdTmTxpyEHt2pV1MqXtVZ5J9N5bKUQ7GLlIVgoEBVrV2?=
 =?us-ascii?Q?xLLVfu3UyVSq1G4d5sc6gV8E4gxtBVOWEb8a/P/gGolNShj3tre75EUCmGPr?=
 =?us-ascii?Q?PK+HNfluRiUySa6VB2MS9Byh7H8BvLr4P46VF2hzgx0VAIyn5tevK21GjJaj?=
 =?us-ascii?Q?FtKr8IMpRYtNYYkj7S8m5bKhSh7zSCYpihIFNjqhj6iGYMwwAIgJijb6h4IY?=
 =?us-ascii?Q?EnnqfOEdbmGaA7pf4AE3TXQiwonywC0PgizveQKDfRAADdhWY3r8CDf/rQZy?=
 =?us-ascii?Q?nliVAPxJ2tYh7XnYFuCvXhV/wJPf+Z5+VGJaI9X1V5YQONJgzOybWZ02IVum?=
 =?us-ascii?Q?8fA6NWOeYgT85bXHDmtQHc5bFdfYMf6ukGCa1VUw/jTUK4zng8A5GpfA65sW?=
 =?us-ascii?Q?ubstj8EdxNBnqoQsEyaUeC/RysjY0pfQSaC3+HiZUD6GCQVl05HrGO3FoSbf?=
 =?us-ascii?Q?utY6eGZL4A8hYOwcIXHw1o+f+uc9Gfp7tDQM5x1wEmQGsDhKaxlbhPP9X2oA?=
 =?us-ascii?Q?gOh+Jc2a9ApYATfF4fLJy672Eb5W6+UCuN+IfjbibkstCBbr7uIJCWqsp1+E?=
 =?us-ascii?Q?Z4ZI00+knWjXbFdyu3txzgnnx/2FGjwsyjfucpY28Jju4nmyZziGv9fLIFAp?=
 =?us-ascii?Q?1rodLDtR4G7AEkdDD7PlE399oG37cxZA9U6M1jEarAY0VoMRwiRwrDHl7TzP?=
 =?us-ascii?Q?bOFP5hZpj7vraYzQeUCXAPJ1xCRucbv1CZtMvSiK6W7P8F+pjBINnYIDTEF9?=
 =?us-ascii?Q?sfcqaMEwkP89pCcQF0YMfoTOz7nFBy73Egf7a26hyfkINGzEs/9rUPgZtgsA?=
 =?us-ascii?Q?tCHGcMuHkv9MvaxknJ9cNlyUl3+uGSZbevuqCSLeZrZwdIfz9fUQpgEab+JJ?=
 =?us-ascii?Q?F8BHKk37zpGb0nhE9Tct0Ls1+9z/OTP7I4Xk78jt75FAA9UxzIoBivD3JLtm?=
 =?us-ascii?Q?IRkwF0krtMNUxf/ntMwXz/vBTADQaDW5BpomNoMlNjCBj2c/f4ZnVD8Y4Y91?=
 =?us-ascii?Q?8QeiApCmuAaP380tRh8rpapRsZ2tXt90N1u7Sn7Qs3Hv8BaMfFOkNBpCbINQ?=
 =?us-ascii?Q?7yVdDJbD8nhQ9bOYguWOTLmRC/bf+kGx3ocHZ2bpgtZovmYkiIerbAQ19I4Q?=
 =?us-ascii?Q?Rzg/Gpmv7I+LkBtbUBtgxDBnGqAAhZtK5iLMUOZ1l+uq1S5sJgdy9oHsHqwf?=
 =?us-ascii?Q?Y6fC9gOBNql7TdWuYfXQpyIP6IU8X1caCaPfmNFeAGnDcR0vmQQczS5+m/bZ?=
 =?us-ascii?Q?+jxxOQW7PVgrJX3PJd50eVY/FAHHVRkgz9i1r5TSLYZcBTss83jBxyKZCzyV?=
 =?us-ascii?Q?fChsebnRimYYqCHeE98Qu29IQHkl8/n7NppwbpQxEcO8etYatP/c2MTit8KZ?=
 =?us-ascii?Q?B+K9qZmexVhv7ZIr6gE6RUY+qL9IsFuMniq6ddRvxmpbkdXfAoBXjFtMETuA?=
 =?us-ascii?Q?V+HM4xUO0LIQPiW+LpNbbpLGv4dD85pWPcsdJOyrKBphg9xCVxqx2fmF5DEG?=
 =?us-ascii?Q?GBiVpKJCK5KwUCRHFIJCzdteKznQsJ4IoCPVHFNz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea78c336-4a2e-47b9-105e-08dab1f08396
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 16:39:38.6138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7i9x2lYkG79TYZpgJnojePYeniz7g4tNQs3YxuTHC9wOu381KVQTDW+n5aNT6Q0GYgOtibFWG3Cv5v/xGpK1yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7318
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Li <frank.li@nxp.com>

Using  epf_db[i] instead of readl() because epf_db is located in local
memory and allocated by dma_alloc_coherent().

Sparse build warning when there are not __iomem at readl().
Added __iomem force type convert in vntb_epf_peer_spad_read\write()
and vntb_epf_spad_read\write(). This require strong order at read and
write.

Signed-off-by: Frank Li <frank.li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 27 +++++++++----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 54616281da9e..9f1ec6788e51 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -136,7 +136,7 @@ struct epf_ntb {
 
 	struct epf_ntb_ctrl *reg;
 
-	void __iomem *epf_db;
+	u32 *epf_db;
 
 	phys_addr_t vpci_mw_phy[MAX_MW];
 	void __iomem *vpci_mw_addr[MAX_MW];
@@ -257,12 +257,9 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
 	for (i = 1; i < ntb->db_count; i++) {
-		if (readl(ntb->epf_db + i * sizeof(u32))) {
-			if (readl(ntb->epf_db + i * sizeof(u32)))
-				ntb->db |= 1 << (i - 1);
-
+		if (ntb->epf_db[i]) {
 			ntb_db_event(&ntb->ntb, i);
-			writel(0, ntb->epf_db + i * sizeof(u32));
+			ntb->epf_db[i] = 0;
 		}
 	}
 
@@ -529,13 +526,15 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 {
 	const struct pci_epc_features *epc_features;
-	u32 align;
 	struct device *dev = &ntb->epf->dev;
-	int ret;
 	struct pci_epf_bar *epf_bar;
-	void __iomem *mw_addr;
 	enum pci_barno barno;
-	size_t size = sizeof(u32) * ntb->db_count;
+	void *mw_addr;
+	size_t size;
+	u32 align;
+	int ret;
+
+	size = sizeof(u32) * ntb->db_count;
 
 	epc_features = pci_epc_get_features(ntb->epf->epc,
 					    ntb->epf->func_no,
@@ -1123,7 +1122,7 @@ static u32 vntb_epf_spad_read(struct ntb_dev *ndev, int idx)
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	int off = ntb->reg->spad_offset, ct = ntb->reg->spad_count * sizeof(u32);
 	u32 val;
-	void __iomem *base = ntb->reg;
+	void __iomem *base = (void __iomem *)ntb->reg;
 
 	val = readl(base + off + ct + idx * sizeof(u32));
 	return val;
@@ -1134,7 +1133,7 @@ static int vntb_epf_spad_write(struct ntb_dev *ndev, int idx, u32 val)
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct epf_ntb_ctrl *ctrl = ntb->reg;
 	int off = ctrl->spad_offset, ct = ctrl->spad_count * sizeof(u32);
-	void __iomem *base = ntb->reg;
+	void __iomem *base = (void __iomem *)ntb->reg;
 
 	writel(val, base + off + ct + idx * sizeof(u32));
 	return 0;
@@ -1145,7 +1144,7 @@ static u32 vntb_epf_peer_spad_read(struct ntb_dev *ndev, int pidx, int idx)
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct epf_ntb_ctrl *ctrl = ntb->reg;
 	int off = ctrl->spad_offset;
-	void __iomem *base = ntb->reg;
+	void __iomem *base = (void __iomem *)ntb->reg;
 	u32 val;
 
 	val = readl(base + off + idx * sizeof(u32));
@@ -1157,7 +1156,7 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct epf_ntb_ctrl *ctrl = ntb->reg;
 	int off = ctrl->spad_offset;
-	void __iomem *base = ntb->reg;
+	void __iomem *base = (void __iomem *)ntb->reg;
 
 	writel(val, base + off + idx * sizeof(u32));
 	return 0;
-- 
2.34.1

