Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BC1616498
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 15:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiKBOLI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 10:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiKBOLD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 10:11:03 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EDE27DFA;
        Wed,  2 Nov 2022 07:10:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StUSbjJfpHmTNbpp7P2bjgBPeglR/kXXficaD1HoM4rTy5p+ERCZiPM7xQ5mnVjY/LEgQ7xMg8pnUzr9iEwt9ij4oQDRSQf69jdOFH4LWaLQ8xK5RV6BQZZxkA2+lDQy/UVTvCGjzXDvIU152ZcKEXHN2L29eVePrattIN8N6OGAznN6LnliMBeFp8tImr8xpdhrB8PJO1i+SXQOpx0vec1bSVEgkt6BdZbZFhk+pHX345jygFbkHctjflwjT7aOn29y/M4nUwM1H42Q5jNpesR1NiimNVl25xf3u/Wel0bnjfv0d5ejo5KudlTVw28e+XZw/nrvwnGhS9x+ZnG5SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5pmgfmO9df3Hk/t5Nvw6lWOCyuSGK6o3sQhZJwpX0E=;
 b=dToSvlodOcC/4GjnHSMgCnaWR3jSuLiqOVXzHKmEUj1qZhcgbiE/vdxZkzADYPHz7JCNOiTPTMcwNpEBxpwnQpduBeU3yCCjjJjVZLOsVY3ctulqGL4s7s+6/bmvk6a5+C9kWmSIc9XPTyj+BLp/J6cMR9/B78eanRg6F57IY/CiK6vu+H7Ul1XdmHAek0eesCIilUCA6azgHkNONDYKEK3Hg2T0ddCcw/jHWdhcc+217NrDxobiTLFa4IZao+UiowZ39jcW5Pbux5m15RcizTaZ4pQG4gZEk4MOPjxkIlfg7iDLaOKaX0wQAyPnaPN+A03FKFpowSHWBO5nYJvcqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5pmgfmO9df3Hk/t5Nvw6lWOCyuSGK6o3sQhZJwpX0E=;
 b=Y+FWnPV5kYDRFSGrjC6uAXvzAVJw5R2ECV9TCKErbSd6/XMeafRZJjhqP5M6WUVTHTqwnQgqHrbY+Wt6IeXs60BbFfH9q9Z69OPKpdx2fKvyYtqG9EYOGiMac7b3DndQHOLBMYeehS+/qc9UiICWVMKldk5t/pg3YiON+z8tTBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DB9PR04MB8234.eurprd04.prod.outlook.com (2603:10a6:10:25d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 14:10:52 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%11]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 14:10:52 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     mani@kernel.org
Cc:     Frank.Li@nxp.com, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, helgaas@kernel.org, imx@lists.linux.dev,
        jdmason@kudzu.us, kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        ntb@lists.linux.dev
Subject: [PATCH v16 5/7] PCI: endpoint: pci-epf-vntb: replace hardcode 4 with sizeof(u32)
Date:   Wed,  2 Nov 2022 10:10:12 -0400
Message-Id: <20221102141014.1025893-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102141014.1025893-1-Frank.Li@nxp.com>
References: <20221102141014.1025893-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0210.namprd05.prod.outlook.com
 (2603:10b6:a03:330::35) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DB9PR04MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c8e2f2-291f-48d2-bee3-08dabcdc0d18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4HjfLuwJuW9ulGYDlGbzMaUDC1ev2Jt13rewJAbDwZ5ANoO/Gypu6xWhSjTO+V+eLLPGKDRwonU55eVZcpcYmkiNKIxbmKEhswHl1JqyhB/OGxCgHY6NpuN+XHc/T4GmVjPO1duf/iBKVktiwcTtSlIYGHL4lU9+Sbfuup6eg5Q7dTFWjGodB7lVj4Gr1slZ/xzeJavij7pmaPTgQbES6dvxR71LO3WYAks2uhzKxE04gKY+JLU6UPviiQ8an230cpZWY+f/zgIQKRHdq1MK2/mHef8gPvR1ZHC78qEM1UzvBMM76xKxCgXkSTat9m/cNk22PeYm+V0/iZj3zW0sw11+lcZj+v/KyM05bsoF0tfK/4+/yR5MWKie26uaRIkqoGZNKrKdoDvlyRQq/NU/uhx07Hpbmy4PpNBHRIc/idltfvLDR2odD3rjK7N65bk4qke4kNJxK0Z1oYGT5CAOpeYqYKYvUS+DVn9cKdu1pKfnWwp2f9T3iCt+f1G2o8x7Gc7gmoMsugum0YHx7Jrbx30QBVHxAinLvkn3H3aJH97Gg/Y17dmzKoclxCbct3/teripfEdlCf/1/Ctp7cY+v+jwPsq5YvHzzeEhWjHLPuLZMDPHnoB4zyBYajMFNarH666+x8uyll0f+NGDjFg4QTZFQPjOpaZDJACZnnQLi490TziIeKYMvXErP4yE+pVY9oNc74ONd5lVuvQ9NhvtA5B0qkaE4CqxXGKfLEA7n7xGWt3tvhvjmpWmyEClrRhyRV8Lq+LSZXKIEhWXBEjc+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199015)(36756003)(6916009)(6486002)(5660300002)(7416002)(83380400001)(478600001)(2906002)(41300700001)(66556008)(316002)(8676002)(66476007)(4326008)(66946007)(8936002)(26005)(6512007)(186003)(38100700002)(2616005)(1076003)(38350700002)(86362001)(6666004)(52116002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UHsmVfwkqaZ/P9gxuCXp85TnbeG9o0Ufs9yIbfsfLIQyL6n+OkkKH76jaybq?=
 =?us-ascii?Q?kdkFTTNHquLB4AIq1IlP4JHRDk7w7t5kl8Yxj+QmaD1yccEqPECNjHeKkKFm?=
 =?us-ascii?Q?9g3ReCgty3NBN9TBwt30ll/bKqURJBKnTi5uptezwXHjTYNfSrmRVf9YWoPW?=
 =?us-ascii?Q?qu4LPWfjPuitFTLml82HVSrGdTnw7rzxdOW7ISdFpMQk/8LlnE4Vm5D29vW2?=
 =?us-ascii?Q?TW8aXZzEKfxm7cNbw0h3xAM8Q/udFEJS5WcOz2HWo2gMwQMnHI49t2fAL5yW?=
 =?us-ascii?Q?MhqB5jBu6rUFU2D/Yo21hwQWdMf84gF1hysFfwfflgnfJW8u7y10cFuVtsN3?=
 =?us-ascii?Q?uECDHcz6y0RIQzUeyrgzCkumSrUN5br9KBE9hfgd8gmJOXhs/PxBKmfC9r4e?=
 =?us-ascii?Q?qcqp2BAuHSxJZFjvnXqEaGSStyBdfw2oewLFsXpBIroqVC7o/D0HFfhmABhR?=
 =?us-ascii?Q?N3jOetwKh20SRMfBFybvqztNYC4roHa17Hc4f/dC51gb/Qnj0Iwh1lxKaTvI?=
 =?us-ascii?Q?EM9ivxGoWtFJ7CFddrHEJeNZJQAH6p2ubNVH1HLeSYapE8xjnZc3yeAeKcnt?=
 =?us-ascii?Q?r6jv+OnJ78dguoeh76k/ss9LOkCH68NfwaHwrk3aV6EmAzKHvOeBK+RuCSln?=
 =?us-ascii?Q?4jn8qJy6fXSbX9R9N0adHdyUprXpwLsSybnEXofqrElVmHtFI0yZxTSCCmaB?=
 =?us-ascii?Q?J/M3wgZcrSXyEw6VDv2ZpMwd04gQMQX1heN2n3KUyrVsObkp7e7E2y/btuMo?=
 =?us-ascii?Q?+fpubeGpprmGidlkMpD/++mlTJbsw3ABCIGchFv6nNfmcUbu3a88SxSLbWcf?=
 =?us-ascii?Q?uENKTamkHy3ZK8cmnFy6omb4/HLxCNvzX8cGA7343sDBMGZAOoAyMnFUvHvc?=
 =?us-ascii?Q?uqdsdG2CjBrYFGmUJ5ueLZrKtvzG9bkLBn1x6xY3GkkVJA6geDy6c8+ef0I9?=
 =?us-ascii?Q?08UtQFES/RkvjhyV9EvF3quR++T/p9xH8qZ2jnHAku2E1YhX7A4WrzwZ3zVv?=
 =?us-ascii?Q?O4gnnhkIsYsLlgY7qTS7D/ka7D1ziWUS5JQhBcXGKix4FVttZzI59tnZbJB6?=
 =?us-ascii?Q?tknlvUIkjliFOc1QERq8VFALzwuXnJR05ssesHXfWJHVRBuyxCEkorOXoMXT?=
 =?us-ascii?Q?Px+iNZcseH4VP9c5SKJvJh3En9E3dlK0uu/e8cCO4SQ/OPszI3lM7DwDXYSp?=
 =?us-ascii?Q?Abf8xSJJMYUb0y2K3Uq3vvBGJ2DkBaraDs/Bib7RZ6/pqzNdm6FraMqN3bgT?=
 =?us-ascii?Q?QsBRMJVFwfvUV9jrirci3d47Zs2uzSpCIkte1+DpcHjoucAoUMYLLl+RZDPb?=
 =?us-ascii?Q?jTMuFMnPFqRE6y4gx112nsDUu19XF2/qYFD9Ma3UYOYO+zFkzLKSFxma2vVJ?=
 =?us-ascii?Q?1MgrDqN0x79IaCkKutyA6/VU5VLqbgAopfXWWa3LA68FCskWQKzGeCRAhw4c?=
 =?us-ascii?Q?kBJF5tqDexnGU8p1NmBFWoYd+owmrpNOPPOQUn8GXfWl91qyiUpwjCENWKdT?=
 =?us-ascii?Q?pupcHwNpiek1G2CunRgfVrM083XWNCj72dftJdsezdENWcC4fz4t6hKKZjej?=
 =?us-ascii?Q?AUS9WGPl4WLGBZwQcWulcsdxQbzoz8YpVtl4HSVB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c8e2f2-291f-48d2-bee3-08dabcdc0d18
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 14:10:52.6773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jiy7EfZZovnTs6/dJHMJBUsiy+oAlGAOttel/RJim96wMzCmUqFcnAGZRjXciukVu5mFoNAoAeM5oDG/3h7UYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8234
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

ntb spad entry item size is sizeof(u32).

Signed-off-by: Frank Li <frank.li@nxp.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index ee66101cb5c4..54616281da9e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -257,12 +257,12 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
 	for (i = 1; i < ntb->db_count; i++) {
-		if (readl(ntb->epf_db + i * 4)) {
-			if (readl(ntb->epf_db + i * 4))
+		if (readl(ntb->epf_db + i * sizeof(u32))) {
+			if (readl(ntb->epf_db + i * sizeof(u32)))
 				ntb->db |= 1 << (i - 1);
 
 			ntb_db_event(&ntb->ntb, i);
-			writel(0, ntb->epf_db + i * 4);
+			writel(0, ntb->epf_db + i * sizeof(u32));
 		}
 	}
 
@@ -433,7 +433,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	spad_count = ntb->spad_count;
 
 	ctrl_size = sizeof(struct epf_ntb_ctrl);
-	spad_size = 2 * spad_count * 4;
+	spad_size = 2 * spad_count * sizeof(u32);
 
 	if (!align) {
 		ctrl_size = roundup_pow_of_two(ctrl_size);
@@ -463,7 +463,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	ctrl->num_mws = ntb->num_mws;
 	ntb->spad_size = spad_size;
 
-	ctrl->db_entry_size = 4;
+	ctrl->db_entry_size = sizeof(u32);
 
 	for (i = 0; i < ntb->db_count; i++) {
 		ntb->reg->db_data[i] = 1 + i;
@@ -535,7 +535,7 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 	struct pci_epf_bar *epf_bar;
 	void __iomem *mw_addr;
 	enum pci_barno barno;
-	size_t size = 4 * ntb->db_count;
+	size_t size = sizeof(u32) * ntb->db_count;
 
 	epc_features = pci_epc_get_features(ntb->epf->epc,
 					    ntb->epf->func_no,
@@ -1121,11 +1121,11 @@ static int vntb_epf_link_enable(struct ntb_dev *ntb,
 static u32 vntb_epf_spad_read(struct ntb_dev *ndev, int idx)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
-	int off = ntb->reg->spad_offset, ct = ntb->reg->spad_count * 4;
+	int off = ntb->reg->spad_offset, ct = ntb->reg->spad_count * sizeof(u32);
 	u32 val;
 	void __iomem *base = ntb->reg;
 
-	val = readl(base + off + ct + idx * 4);
+	val = readl(base + off + ct + idx * sizeof(u32));
 	return val;
 }
 
@@ -1133,10 +1133,10 @@ static int vntb_epf_spad_write(struct ntb_dev *ndev, int idx, u32 val)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct epf_ntb_ctrl *ctrl = ntb->reg;
-	int off = ctrl->spad_offset, ct = ctrl->spad_count * 4;
+	int off = ctrl->spad_offset, ct = ctrl->spad_count * sizeof(u32);
 	void __iomem *base = ntb->reg;
 
-	writel(val, base + off + ct + idx * 4);
+	writel(val, base + off + ct + idx * sizeof(u32));
 	return 0;
 }
 
@@ -1148,7 +1148,7 @@ static u32 vntb_epf_peer_spad_read(struct ntb_dev *ndev, int pidx, int idx)
 	void __iomem *base = ntb->reg;
 	u32 val;
 
-	val = readl(base + off + idx * 4);
+	val = readl(base + off + idx * sizeof(u32));
 	return val;
 }
 
@@ -1159,7 +1159,7 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
 	int off = ctrl->spad_offset;
 	void __iomem *base = ntb->reg;
 
-	writel(val, base + off + idx * 4);
+	writel(val, base + off + idx * sizeof(u32));
 	return 0;
 }
 
-- 
2.34.1

