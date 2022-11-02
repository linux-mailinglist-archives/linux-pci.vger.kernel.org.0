Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E56161649D
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 15:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiKBOL1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 10:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiKBOLJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 10:11:09 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730AF24F33;
        Wed,  2 Nov 2022 07:11:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnfXzoKi7ggI1RIGizrkRM8/YbRTiNc2zC2KP9COiKgTctNCWIY3W0hNauc0WZntlpKdQ9LzdRjoCaalWFR9Q79a0DXsQs/8/+OyqNFMNmsIxyDpH6N9ECMWfpCUiPT6fI/pmeHZuSO3pRVVIybJnmxRaUSSzIpRGB7PPiKjV5czOu3efnDjuhUAsgPlhFzz04a7LiNz5A4Fysqn6iPpTFC5v0GAQd2Cop4FE9pC9cBQrXvzpUxrqKVzEigJN2cbmPe7cV8kx4GZDPpHyXS70HlsW9zMrRq5uyOBC+afvzvqpIfxA4AJmfKhUtUJhjVICR3S0TMooYcrdC81zX2a2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFzFyx1vsGg3jLH40Ok722Zs8rNi57PQqnyZ7ZkJjRA=;
 b=Fu1RN2UhETiWAFq+EUy8EUvdHQvLpOaOvlrXLJ0L3yTevtKBDzovRjkTks1frLzokSc0v/Ip1318knb7Oeleq9D7HcmK33B29lDhtUuKGQRkst79TrIffdvCRLOOFcjq/tjIlYwKKvo+iJqDMT4k4WOBIbzD9rl5Gio3QseIhrZtZUz03FWScNILNf0F5g6OaQ60som3TWecOiPJM0CcV9o+lK8t3gLkvP1fxMMo4aDA8dI2sCJ2CM2neib748TtV6ERyrpyuXWrB70Tb32Eq4sXQzU+/nxxtqYF8kQ0ba7ry61rUfLo4LnEs6CkGDhoFk0TCgwrcZ0gMxAf3NFwXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFzFyx1vsGg3jLH40Ok722Zs8rNi57PQqnyZ7ZkJjRA=;
 b=OPA+d1XdjwmewlYd7lCoptGWsD8gmfEq6+f0iCh9KZs+YvdvTEf59amrgb90MRqLfRba4wAV7L4BjiNNnnDJWl9sE1Ibbl0NCHln2mGJJh2P/YPXp3GLOAUxAqrj/XyqIs9xrtCC4rL90G5zMfNf/7Qjtary/hfCgWIlhSXLXcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DB9PR04MB8234.eurprd04.prod.outlook.com (2603:10a6:10:25d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 14:11:01 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%11]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 14:11:01 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     mani@kernel.org
Cc:     Frank.Li@nxp.com, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, helgaas@kernel.org, imx@lists.linux.dev,
        jdmason@kudzu.us, kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        ntb@lists.linux.dev
Subject: [PATCH v16 7/7] PCI: endpoint: pci-epf-vntb: fix sparse build warning at ntb->reg
Date:   Wed,  2 Nov 2022 10:10:14 -0400
Message-Id: <20221102141014.1025893-8-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c91f7991-ffbb-4382-e2e8-08dabcdc1205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cB7TGGGQUWZaXdxzPbzuksxAaVL30q1RKQbqInOCgV8ZcnpCL+fbAMFDsGUouikjFDiaboxqPoQzOcar7Jwib2ZUA/8rphxbo4toojkP8NfTQRLthTsSelO/yE8wq9Qd3iSn6aZLQlyr26W9QtNSSQ67BRMEwxOaRVSEI/CE4zMxG7yKPS7wpQNDs+9eHvVMKrgbVRvjylJOqVgU2rUY5r0RozqtKoG1l/f5LszrQL2Gqx8Wu6LY4XcrS0M9FbYu0VXHUE5DhoCokdFc/cRfKTzIesrZodsLfbb+TjEF6TIG516FSwWsJqriri6PHT8/hr22snRRQ4FDHTdopjhLbLBDvJQc48YT/fmy+/g8xxirQt/xd52hwdfO7zvOCQSGgE3OyqKMIFvnwfAzQ+iXgcZScy9CHd6KOYYaAsmNWzy8MD8H69hMq8YR/bwgLlSiRVa5YY1mkm81ZNyz4Am6IxN4P1oazbuyms0U7OXNd4zZaUIc9mwIuTIal50heN04e50NtuHP+t21sSAvBqvOa14WupJHM7T3COMLFSd+q86EqJvBeTcwP8U1foGqIuRSRj0Dc+pgQYqtnduAF1BSIRowUissrJFZACbVUCRNXDJyLfFZwewgCyg4uu1rynGzbnv+uVJI/FZ3n4oOKIRnoM9Tp1bF/HhF2upQSgAt5Temvrw/TdZi+C3pIT6sPuP6EMMpxOlj884LdfQjlHlEom4W7G7MNNm35PPBwRp7BbYXmIC3ggrsKoJplag1egHFeB+E6nW0fzLjeVLZpo24Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199015)(36756003)(6916009)(6486002)(5660300002)(7416002)(83380400001)(478600001)(2906002)(41300700001)(66556008)(316002)(8676002)(66476007)(4326008)(66946007)(8936002)(26005)(6512007)(186003)(38100700002)(2616005)(1076003)(38350700002)(86362001)(6666004)(52116002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c+ghEMmt98/jipg6CzkX0byXVGkx4WgT3WmigTtY8eu1Afty/nTVa+y8CqUI?=
 =?us-ascii?Q?yQgj8KS6MvGy95Lq43qljFku2maTApZIGttBXy5VBzu7T65/A/oDQmbuaEpM?=
 =?us-ascii?Q?wMLDNsK9aypUFoAkDZ7OwIfYZm+1ZPBobwCz6/G92EK95JRHY343Mdkm+R/m?=
 =?us-ascii?Q?CXK5gGovurmMEfoV/Om/G51UVG2PHlszOpBWRCf0gXblo8l+uqiDoHYszDy5?=
 =?us-ascii?Q?yLyh0AGocPMLGS+WMVa394DFJTgIw6+cugcBkMLcnl6v+kEAeWQbbyCjKC1L?=
 =?us-ascii?Q?04wdbdMLSVaN4Ef2BhOG3m7qQ8z/MNtD797BAKWOB+LjIGT5xLTW6S/Qq+fe?=
 =?us-ascii?Q?1S96ertGMFn2Dw/Ugbt/mO3+J9y76A9Q4sP6EKnJU12I3fl0VOn2VA52CfRm?=
 =?us-ascii?Q?pPZiqhzVsUpvtuA//TOi7bcvhGBlzaYS7TGMrxVzyZNjPtBr/sEqu8dpySxs?=
 =?us-ascii?Q?JU3WrTwB8BHV/I+CWv4LjgkWi5bbs8ywFqexNaf0Mx4wP2wotWXXUhunj9lR?=
 =?us-ascii?Q?yvId0Ouoa9ou+Pb/n/OLhzKHRuq5F8R1sSrD4OlO0oQbMgwE3wJ+JsZY+00I?=
 =?us-ascii?Q?20ARo3YIOuLw+A61C/sxXzZu1a2Vr29xmPeF31f8aK/ZZL/i66tPbFM5znW1?=
 =?us-ascii?Q?a2iK3fi8Ds4CuRLoFgX7lN4wxmkjoA/V4Olok/GwOxxgs3mrv72yjYbNW2K0?=
 =?us-ascii?Q?7zuPkGwTcSFCf8sCGdNGsYbQZdJOep8m997CidiP4ZUBEgSXRTTUdf+xWMPF?=
 =?us-ascii?Q?2GARaX56nysLPHtUUlsu8grGez+N4PIMyLeNl23P0H5cVve5TeLAthwer3Ig?=
 =?us-ascii?Q?zTtY7PuZaidBqys1jVupvv0NOLyHy48IYLUUQJ9sJcA/7B35m3DUOAZvVYge?=
 =?us-ascii?Q?W3VkrWjutSZrD1svg/8BPP3ZLbgPfOH5MDSEjMgJTbyV14brwDICq8dqNq9k?=
 =?us-ascii?Q?/77cJjFV3JWcIzoCl03f6WFcwsFufI49vDH8IM5U40nYVS2HKE95iJY+AEyW?=
 =?us-ascii?Q?wGT2U6jhuz4J1SQukT61vK95w3PAAE4YvJrHPeJE09MJFaI8Hz8NKSH+xFQk?=
 =?us-ascii?Q?Fx8TJy09uthlO7tumvL5r1+CHmQS8Fd/YZpHl74bVB3yF9ah3+js8QVFguX3?=
 =?us-ascii?Q?LSoinoQclk9cip3FvNMBMlIBpCsTbhYdn5oIfO1CudKw9E5g+Xj9GfEJAvt0?=
 =?us-ascii?Q?7p8rxYLMakzoVJMg6LbkGWG7aF80J8omW9Arbk2IsVeHKtuhSHhICaMMvVUV?=
 =?us-ascii?Q?towrZMGCKqAAnwc5mzAMgMdoJp/q/Eiepsc96OmYQ0PFyTa0vMLN1wkP/X1h?=
 =?us-ascii?Q?WgykKtVi2VrM57wfY+5Dri71WKb6bSTNBp98JUm9H3E8xtLiZ3bKNh0mZ2xd?=
 =?us-ascii?Q?GIHwr8z/HpvkMSQBiYlZI7P4ja87shoHC+xIb4ouuoVD5z9y9sZ5npT8RijK?=
 =?us-ascii?Q?iJVFI41qiiFkY4IKA7234E1LtV7Nv/S8J7FEoxKQPRUHQKo5yvGS6vHVvr19?=
 =?us-ascii?Q?1XP9laSVRZanzsOakimcij6SBw2TrVBjPYiyNbqB1z4/d82Xii6UPC04p2yA?=
 =?us-ascii?Q?tP23ugPQi3+c/bSgTAHSFZ4CKrI6mBs3IzTi8XtF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91f7991-ffbb-4382-e2e8-08dabcdc1205
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 14:11:00.9267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BICY0AbF7Az3z0HD/RJJkLUVE5mv9/QmjZOQpu7AMSRuMLpwd4nIBrdy5JyCPCWplgJN5xZj5PW3PmBFhqqa+w==
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

  pci-epf-vntb.c:1128:33: sparse:     expected void [noderef] __iomem *base
  pci-epf-vntb.c:1128:33: sparse:     got struct epf_ntb_ctrl *reg

Add __iomem type convert in vntb_epf_peer_spad_read() and
vntb_epf_peer_spad_write().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Frank Li <frank.li@nxp.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index f896846ed970..04698e7995a5 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1121,7 +1121,7 @@ static u32 vntb_epf_spad_read(struct ntb_dev *ndev, int idx)
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	int off = ntb->reg->spad_offset, ct = ntb->reg->spad_count * sizeof(u32);
 	u32 val;
-	void __iomem *base = ntb->reg;
+	void __iomem *base = (void __iomem *)ntb->reg;
 
 	val = readl(base + off + ct + idx * sizeof(u32));
 	return val;
@@ -1132,7 +1132,7 @@ static int vntb_epf_spad_write(struct ntb_dev *ndev, int idx, u32 val)
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct epf_ntb_ctrl *ctrl = ntb->reg;
 	int off = ctrl->spad_offset, ct = ctrl->spad_count * sizeof(u32);
-	void __iomem *base = ntb->reg;
+	void __iomem *base = (void __iomem *)ntb->reg;
 
 	writel(val, base + off + ct + idx * sizeof(u32));
 	return 0;
@@ -1143,7 +1143,7 @@ static u32 vntb_epf_peer_spad_read(struct ntb_dev *ndev, int pidx, int idx)
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct epf_ntb_ctrl *ctrl = ntb->reg;
 	int off = ctrl->spad_offset;
-	void __iomem *base = ntb->reg;
+	void __iomem *base = (void __iomem *)ntb->reg;
 	u32 val;
 
 	val = readl(base + off + idx * sizeof(u32));
@@ -1155,7 +1155,7 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct epf_ntb_ctrl *ctrl = ntb->reg;
 	int off = ctrl->spad_offset;
-	void __iomem *base = ntb->reg;
+	void __iomem *base = (void __iomem *)ntb->reg;
 
 	writel(val, base + off + idx * sizeof(u32));
 	return 0;
-- 
2.34.1

