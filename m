Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F0B604D9D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 18:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiJSQkK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 12:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiJSQjw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 12:39:52 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DA644CFC;
        Wed, 19 Oct 2022 09:39:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsKGKEzJA6Q2eKc6TWNhD6u3hpXl7BZxvMCUvj+uJK6r8sx1zE3ldNPGqwgOGAoQCgQ51FajMlpT06eMPq5FFCxzrQxAWwsURIms4VOWcZXzRXV6k6CmxPmUE9vRwuP2p/XYCKjmnRW1E+iJexj8gOdsQjCJTMrIaG5iiS+wfE6VXHcdExN3S9AdpI9tOvWnOfkaM0+FHtg5wk/PSfIPywxfQCTHd60aF0snAO4vYEZGMPkvzf8qw+8snZ7VvyYLlwRGL65VZ6lCWfeG3eX+RrtPvqp30ZH8GyDZRAOZ1EtAdbbC0k4GCEPrOGN2OPlTQMeFBMYyv7ZdYNlUQRfJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7rFAgLLE8DgxLzFxypT6h/aMZ7/AGzWG+1ThOcYzlQ=;
 b=j/KcR7lgvw7uSZfg17HEQmqJxH5uHPJ1OkkKz7bB+SLHOVGiILiw4stQ+lUFqeVG0oQl6MjVq+fU75fJGcExW6INRZXdQBGtTwJtbj9YydOK/BgxQeFSL7o/DsS/vjJrXCVvlvmACEtS7LE/t6BV5oEZMm4sMR9DLcwL7rg3setaaLHr/YFvpAToKSb2r3zFQp90Enurv50WBJH5VTWe9wARESOTlSNN9v6Eiw0dXS5ghnJO12l9NADx0KTLjFA8rLEWfUJ/9YAXODpD4CCCTqr4u8pWnubfjwWGtwG8D6f1Kiwmt7lmldG9/u4pxOR+2xuiZblQze/CXgPmzgZHwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7rFAgLLE8DgxLzFxypT6h/aMZ7/AGzWG+1ThOcYzlQ=;
 b=FmBU7lwn3WzMp3PMB1+OhuA+SYl5E4GJry+oPizOyK65fHa5mFFgDR0uQJRz9xZMq8ukxpvgA4uHCmPxmfLGjuhxfLkmAxGrF3Q8b2NHEdhNufv1CEd1y1Lc8mRPDpPDe48PR/8vF8VZkWjQ/ghLPEN7fuNHf5SvzPRMCUBhdyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DBAPR04MB7318.eurprd04.prod.outlook.com (2603:10a6:10:1ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Wed, 19 Oct
 2022 16:39:35 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::6110:8304:5648:88f5]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::6110:8304:5648:88f5%10]) with mapi id 15.20.5723.034; Wed, 19 Oct
 2022 16:39:35 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     helgaas@kernel.org
Cc:     Frank.Li@nxp.com, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, imx@lists.linux.dev, jdmason@kudzu.us,
        kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
        ntb@lists.linux.dev
Subject: [RESENT PATCH v13 5/6] PCI: endpoint: pci-epf-vntb: replace hardcode 4 with sizeof(u32)
Date:   Wed, 19 Oct 2022 12:38:54 -0400
Message-Id: <20221019163855.1267295-6-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3593101f-bbfc-4c01-7015-08dab1f08163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k7z5cfWn2SiEGNpRQt6O09fB+x1EdRxwGxGo9bSQOH6srFMhB78Tqc9l9j4Jql52mVmWXs1dfra+lZlKPygjKeAcEnQ7lx4ki4tWq5O+YSDL1N/7+4r0isfXf2zKQa5qpLghkiHNScdNxijO6UQd79AvpvTSaBNIeZB5gKidWL32SrTNsnzmj5ZrnaSaBdBjTbGNNZ3o4+U+d/eBJ7FZXHjiyUApEr2Y1neOwlJ9Id9FkslF2IxGTpodb7gkfjSz6hA6wlcjK70KHGj9maE9/bhC7tQuNJRL0CJEzO/Bvj8M1y347AzZx8ttJ0fKBPA6p8a9Z5tLYG9QHPGcQJ//FLdNO8/Jev9vxLhpRHiRCM90uBLt1qJJBMFMrgdBqmvG206sjTt79J3j7SuidOO8IQZPFnwakfY8rqm/qeARB2XJp9NBGziR6DKsNwa3o+G5HKS/YcF5WINj/sCdIbCqAn6Fktw72T0NPIFnEI2v/GIqqU0KRz/EelvrrU1fi+XSj7F9YVAMSw37wSDwZv8AjhI7ywjPtSYQ2/K4k6KrJvgBh4OL6ySl1dWkYaGyHj3PhDRbkaJ9+dH53VAuVYOzRRN7vwQ0nTjMcX2VUu0NyIkANlbGdpNl5g/6aB8fAdYXfDzrqQ2XlpGT5Su/mEjLa73jCOCNNDzCMT2XXsKjPXHVWLk0ssFNJCZ8v//qj/Sq9Ub4eAWFxioZ9Y7GYcthP7cHO7iSnF3oCD3PKy9fLmtnUMbC8xu99dm/wQMrtC9w/h/knZHCc3ngrbtEKrvzQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199015)(41300700001)(5660300002)(8936002)(2906002)(26005)(316002)(66946007)(7416002)(6916009)(4326008)(8676002)(38100700002)(66556008)(66476007)(83380400001)(38350700002)(6666004)(52116002)(86362001)(6486002)(6506007)(478600001)(6512007)(186003)(1076003)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9o8bQstFY1AouBbWyDjroctxVf8IckShTpqYA83aAAiipK3IGfpn0USk/zU0?=
 =?us-ascii?Q?atYcE6icIbyClTrmGJ+0eVregQnaPktxyTjqJatz7EL7daoqhFece/7WS2Ye?=
 =?us-ascii?Q?iL00nD8O7n72V8BbIOIGLtz4u9FlVHkylv2xQDaGp7LshAabVS4Sa1LhwI4D?=
 =?us-ascii?Q?eMDuQC/rAKUp21zQ1aepk6whibkk36+WqrCXUSrlKmrdVqg5TdhFGkZbA1yV?=
 =?us-ascii?Q?pUZHCpKHecRWmWoX9h4GtlQaMvzxGd4qYdNJOBMBTOx6pnefqioNXJQMghOo?=
 =?us-ascii?Q?AKH9/LyJslCdSkTn3lsPz1uEKg601vCqBMhlyNjlKAsZK/mPQA7A5PuZPRyG?=
 =?us-ascii?Q?95kS4Z8hao84nF8rWHihIPtldle169qEU91Oxcf4BTuOwvrA7cDo9PM0wVgF?=
 =?us-ascii?Q?2c/tecI42SGa7DcrKgWCaYJ1a947c+KyLbPFQT1xhkLvVmJSwXRCqo5McrAN?=
 =?us-ascii?Q?tcFBTiyEfO8gGPFrCsoebN3mOJv1xI0deEAsKzP795wVhnxnxjUADuTNd82L?=
 =?us-ascii?Q?89mYNlDIZwrV4U1kPUuL/Pe6PRaz94DjJsLYKriBIYk87NMIsT23E1Jd4AfB?=
 =?us-ascii?Q?zpuvd7bLpHnf3EApo6vR+t452oMh82P4arAcIR9cy67Y4Q/MXEbojRKpCeMU?=
 =?us-ascii?Q?K5lq1wYwGW4vRmn0zfbAcdyi0LI3Qk2lr2HVIp7m7U43LPPLCLzKvMMsba2u?=
 =?us-ascii?Q?Efg+hClc5rSy2oHoUd4zZBuaF9TEJWodPgKOlxjMAoPzpvXXsEMAGn5M++uZ?=
 =?us-ascii?Q?x9bU57XwfeX6uce9ytTHKFhkJ1+lF6mTLbtSu8/3iV5kot6mNxBlELxRxmwq?=
 =?us-ascii?Q?w/NWt531v1h/yWo8bi30ltIQtHbn9kgkSFNUQJUTU3WDWXSnhQqxyfWHs6cp?=
 =?us-ascii?Q?DiLgUEPLTsm429su3kQZbsjoyO00VPVzE6ZdTuNrbBy/zyhvjmaxC1vzjO4B?=
 =?us-ascii?Q?+/UlnSVNRHpV3im5HPHNJvghihR0uDlY30WBwsS98CVttfOfHHV/yjY0Soas?=
 =?us-ascii?Q?eQ0lDPACT4kmh3ndimJJ1fwpQ5nDAtZifDBIn16xUG8Q/a8Gbg7c4DCc0qrY?=
 =?us-ascii?Q?r7MtNM1iinH4JDAJ9Mr9WPPzM7qu9uqLfoOzbcUlh1MjLKZ80zmSgS07wr1e?=
 =?us-ascii?Q?VRhXbSQ+STfuD2uMN96AnlbSPzRLDmnUwwQT17VUvAd3bf3VYwF51kqoN4Ng?=
 =?us-ascii?Q?H4GcgIYs/YSpJS4H0JLtI3ENxQsCfJspNskPXp6QKF/QpcogRqM/AHEHskS2?=
 =?us-ascii?Q?7mNmedPxPPJCxQ3u7XlekwsaGNVoBC/mbjezF/LdaNTwncOoFx02mc1BxJ52?=
 =?us-ascii?Q?Euv4BQzfiDgD7l1Af0hCvozp9SIgXgNQrhIa5XIjQzIALHgOO0hbqnl5BpWy?=
 =?us-ascii?Q?dR0kq1mfJnVaFP5LaegfOIm2EeMM9+FmuHuetPOhMLg8LAu2akgHOpvaVitN?=
 =?us-ascii?Q?kf/VmWczACWU0Kwk+lkkse8fwnN0apiZEVRT6iWxm4LeVN9X5MRTakbowg/g?=
 =?us-ascii?Q?ymKslUgLvQgJdqqciBynlXMIwKkPEQ5Aun5/e9KqUbngT0mgawTorR8mHiwU?=
 =?us-ascii?Q?c7Q7gQ4V0aBhoY6HS9Gpsazi6mDNv7XNv7Umao6W?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3593101f-bbfc-4c01-7015-08dab1f08163
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 16:39:34.9422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5eTtPnRjx1T3fqmmZYV4iRdq9q4J/ncVpTUxuWwnoKwH8Q3ZLjJlZZDCx6tnuk0EpNzKvR72nJ3uXdRVfkUmg==
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

ntb span entry item size is sizeof(u32).

Signed-off-by: Frank Li <frank.li@nxp.com>
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

