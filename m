Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B639664CED3
	for <lists+linux-pci@lfdr.de>; Wed, 14 Dec 2022 18:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbiLNRXV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Dec 2022 12:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237720AbiLNRXT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Dec 2022 12:23:19 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8F7E0A9;
        Wed, 14 Dec 2022 09:23:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJsXq1A1cW4AprUn+5gt7otc88bDITxH1GnRFsF+jcRo1MYFL1a8RjuJZ3/ma83gyPU9xHuR9GC1Ps3cCaIhrQzbx/Vb0bO6jA1iydsbPh7qdVQI4czQQ38Bu6jFQm1luuRO1+4LIKNCW+R9W3wHrvH3TYZn41YNxQhAdJy2WAdew1mSangpwnINQ9DvJoTeU+Yxd9mW7CHgzHEuqAFBZCJPXS4Y7CHdnqBGT+wEM3qubJWW48yfu7hn3DL0tG5LGDD+/gCUZa2eyrT3MYSxHRzqIvP5n8IDID1+CUsgWxnLAxqlvs0jO4fGNRa0d2AlUSh4ihMlP0FXcUhvyQYojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOAOvNEzX0Rr7ekgZsw1MuLt3OMB6AOpLdSQv3uahOs=;
 b=dDcqjHK4kprxU7AsrdUyViNdV31FUym/hSvrlkVHIn6YmHeRplHUmSa8TvUSpdqeAMznzlaeKzKCTJnwSKtUeQjTRwR2ZRT8stouSLfpQUp/J5LovAtUiEFcuYxfnzaE7RcrYssmbI0izMefe303xIIGqltVc4OJ4l2P1u4VHdzgrv0QJ1rQuVifQvNnXGR/rxhUR5XWqsDB3FfbSUDN+qD4Sn+L2Ro9Y/7yJDNJAcGnG6lfthHX99/abT67lAaleBAWhcv+F3O63AEV9hDYeg4NWZhfeJ9LSKseMbV7b9VMmvVOT0H1dJeLwyBvig2fl7LZyHBiE//6+WwrpkZSiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOAOvNEzX0Rr7ekgZsw1MuLt3OMB6AOpLdSQv3uahOs=;
 b=C5qCIwsR2jUTs0yYhOPrgkVXbve6TQpBZ+do47KPn7m/BbTQSUvwFeliWfOL5lWi68AS2GJWT8dqoPNmv1LL3w/J7cvv8bVcvrPCDPf0B8b3zgFlhW0FbPqlT1k8H4zU85ScgO5mo68L45ju234K5mKIYSPSzjenCKbWhFRNXLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AS1PR04MB9311.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 17:23:14 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663%12]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 17:23:13 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     lpieralisi@kernel.org
Cc:     Frank.Li@nxp.com, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, helgaas@kernel.org, imx@lists.linux.dev,
        jdmason@kudzu.us, kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, mani@kernel.org, ntb@lists.linux.dev
Subject: [PATCH 1/1] PCI: endpoint: pci-epf-vntb: fix typo span in comments
Date:   Wed, 14 Dec 2022 12:22:54 -0500
Message-Id: <20221214172254.668282-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|AS1PR04MB9311:EE_
X-MS-Office365-Filtering-Correlation-Id: b98638e2-1b70-45a0-6ba6-08daddf7e075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EDUED3odKWgW9J2FdJNc5beUnUS7KRlFZcw62CJ6LYIdwxLHJk+TXW+jPKZnKO0+kmR3SCOT6t8QYoAhuB4JztVW+a0oWVEmyGo8WB16Uj5717SGrpZ1OPl+5r4oli2jlAQXaxwVjVtGfAQ21akr62uHpydcpCUVF1pkMg7pgveRkm0DlmIBeUUmtrU/GtAbCNxnmenlAPYb+u4OGvBWpU/IRxueJIJg4QHIX/Y6saTMnVr7O7KO2jsEK/pU9HM+wgTX3BEx2ByJWMw4GT6u4fR4GltvORC3aG4De//qfnTQMhYS1yhlgc9CHR5esPVmcdyvgGFAE5VJjhgZoIjoPlbdAa+SprMSLGmCKtYNz9tq9n8m1LzH4WZxJZN7A0CdPoSv3+tm2xasVPtk8HmLifHXI5Z/bSQhh+JjnmlwYcMa5Fk2wYRryRVKlHZK4H9FEyzSKtC98yW7NaQ6Ub3/1tPJdh9smDyaBBgKD5PuBA0Masp40K2aHBZv/lBbanBevGI+jCqFj6OtA4R86shy2zevnJjvnG8hbDZlWQp1aDVzhu3r0eS3xnWlTfMvRhry6WEDPCrtpXgPgZpI6ManwyCfrj3T9WL43ZL9rA/lsmM54guO9l3rGXBMC7w6wvMnj5m4q9ZuE3uLM+2fIj3qY8d965E0WqGLx+hsVxaiOXxVe62rSVcXbW+wYPQFPOhxJOwYR7Hj8YvIWU9lNQaStw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199015)(8676002)(8936002)(4326008)(7416002)(66476007)(66946007)(5660300002)(66556008)(2906002)(316002)(41300700001)(6506007)(6916009)(6512007)(26005)(478600001)(186003)(36756003)(52116002)(6666004)(83380400001)(6486002)(86362001)(2616005)(1076003)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EIiL5xb8YlGI8tY1g9Dj1MjHkQDQLVK6zVpUG9+lM+L6Z/8vB4B8LNRmJ78z?=
 =?us-ascii?Q?uTE+Bgzy/5kkE8FBlh99a09y1ZaPSqcVdgjXjyy9bJoyKdiKGab/UKTD0a2o?=
 =?us-ascii?Q?UIhjDveSXVu89fetF2xTen6eHD/0opASr+kA2cHRY/lknX6gtRNOUk2fg2/K?=
 =?us-ascii?Q?WV+54KfF8Uh6lH89uLrdCSYa8Sq4S9HJKx02BzZz250BkXdwNOLrApk/EQeN?=
 =?us-ascii?Q?cVUWWABg+0127yaqE9H9/6DpxGqDIDt/rz3agBJGUGofiQVtJfLelP3mTKg8?=
 =?us-ascii?Q?zGWIRbsnKXpRdHeHfmJHMgYSYlbww+Tngr7L7r7THWRFoRUOtAYuccfPkKi4?=
 =?us-ascii?Q?XmpeAX1JE0F8DFaYV8S2rVwsojAILKpFc9c1H+Bz0Jj2Aso8H1JWUd/QJX25?=
 =?us-ascii?Q?dfmosLZDsaCwWhS8TtcCCT2zeH/n4+PXGAK6ySoRDH+M5JgL+nb8kom5i0ho?=
 =?us-ascii?Q?52mX8pgAoaXYBEmjbvs9YwFjQA5kYvVbx1AnPiNF4n3ZLrTnEFA9PQwn2Nuj?=
 =?us-ascii?Q?fAxrP1PTuosPynUd1XOV6xl3Vl8BCLZleFcVkW4dORFTv4HX5afIXr47K8dX?=
 =?us-ascii?Q?mTEkUpl+Cmdls9kAf79KzVgE6gEPEthhKGy3zGbJiGMs6TrdaKK4WZx/2upz?=
 =?us-ascii?Q?LWTPsBsLopmmEk6DhjE8oUq257g5+xP7PVydQux/BIl8Zy+D5HVb7e1vREqs?=
 =?us-ascii?Q?jRQ53xCSurVWcz6rTB9XrfsOlESIv5AHcK5QWfa30oAUgSlcOgeVcmWO7SVy?=
 =?us-ascii?Q?qFqEKlBts+qi2NhmbF3HdjC03P4vI4j+741pMNmQIHu0/xfjZ04L3PiSFd6A?=
 =?us-ascii?Q?FtVVdfoVhDdbqiZCOEKtXgEt8C+n7O8ZYVAajAZCGiCS0abw6e18mj/3EzUf?=
 =?us-ascii?Q?Yzz4+60nge2RvtkxxClyznJ5kpocouQ/ru243t8XImEpvBV867HrLInKzmIo?=
 =?us-ascii?Q?rEyiVk6OVNM5yoBIiAOPNaKhiNliWQ+ybGYntpsmB3a3IsjmcL9OUPmFS1dF?=
 =?us-ascii?Q?S5lWY9XMQ27JfgO/2YS1eGS9hDOiQO7Q42FbSadox68guM+2mljcCw2c4Uk7?=
 =?us-ascii?Q?4t5slqqTFBiurCM34KSui6CgphqaH8LfqGZEBdZFfFUTL9tQ3TH2XWCtbsG4?=
 =?us-ascii?Q?j/lxQyem7dpwHAtKnW4DWmrJi+kAdb5mrhIHMZQ8x93vpxyBbmnLPCiWMmgt?=
 =?us-ascii?Q?1lil8ul8XODCPRZu4GbpQqXE0b6AdXHSwZmxcxQL8iKEOYN91xP65+O1H8nR?=
 =?us-ascii?Q?wZBz5xZgkqc4F5F3P4+bRba6J6BxKaF+fxr3Y1eUAIcAP6G5HhZa1H20vbU9?=
 =?us-ascii?Q?1Wwe71CPpAW+Sa0a03hD4mLsHeQXuuG5KMFAh4N4Mm4nbU51ZqVYcXjgArhK?=
 =?us-ascii?Q?LeRcgBPmIZQlH1YOH8t+ZYlII8czWtxjEIYhgwaXfMawzzR6bpBFHLAdg0vT?=
 =?us-ascii?Q?Csr4x/WKCGGvP4pPJJaPI6bnJLNYWGd+Zr1wKv0TRttXOL4TB9Z9/U4Ea1Ks?=
 =?us-ascii?Q?DAWnmizXHLLbO9ZPP7N/KpQUnVlZ89LMVEV26qYUHJSn0PwhpdTQloQ6LILn?=
 =?us-ascii?Q?XdKIO5e9qZuWSy4IDta6YDq+tr74EH+erhTE3O4r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b98638e2-1b70-45a0-6ba6-08daddf7e075
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 17:23:13.6609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjyed2Oa6Q1LmVz2P2VJPq2+zlBSTTNWI2yU913BTjVltHheudm1dtF2PASy7LAMReLy453FqzNVqIaUtJDpGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9311
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace span with spad.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 58a23ef4b572..935748244078 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -84,15 +84,15 @@ enum epf_ntb_bar {
  * |                                                  |
  * |                                                  |
  * |                                                  |
- * +-----------------------+--------------------------+ Base+span_offset
+ * +-----------------------+--------------------------+ Base+spad_offset
  * |                       |                          |
- * |    Peer Span Space    |    Span Space            |
+ * |    Peer Spad Space    |    Spad Space            |
  * |                       |                          |
  * |                       |                          |
- * +-----------------------+--------------------------+ Base+span_offset
- * |                       |                          |     +span_count * 4
+ * +-----------------------+--------------------------+ Base+spad_offset
+ * |                       |                          |     +spad_count * 4
  * |                       |                          |
- * |     Span Space        |   Peer Span Space        |
+ * |     Spad Space        |   Peer Spad Space        |
  * |                       |                          |
  * +-----------------------+--------------------------+
  *       Virtual PCI             PCIe Endpoint
-- 
2.34.1

