Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8246614FE0
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 17:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiKAQ6b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 12:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiKAQ6I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 12:58:08 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70059.outbound.protection.outlook.com [40.107.7.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41501D668;
        Tue,  1 Nov 2022 09:58:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yr94jpWqsRYjuqFVWg89f4ED5egXrLhwqubRWGBMfYr/QRGBkhs4QDMabzAHZTeMQTI12zltd9WIz8YhQp6WDIUzO6BRe4xsk2YDZOE08WUVSD5cbDIy8urAv6Cj+muMCxGxHTMOe/q15LfFvAQOkd1lKVX/nFV8j3zwYYpcMsu2pb9vf7OpAJ5XT/d8hGhMDctwpCYYi0SXjbycJLsWTEOjWEetGgEtZLZo9dSetAOkiTLDD6+LrJ790UYixaUU1ImwXWH2mEX8LpxguSrVI3NEdUYd/kLo2OMU4axOFZjLxuetd62MUKUuhMmD5RmFsNK8OuG4EYYZLmh6x4Rkpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFzFyx1vsGg3jLH40Ok722Zs8rNi57PQqnyZ7ZkJjRA=;
 b=jvlT/BIcUqqKZO6EjKAtZl5IKLgi9cvNJd8SdDc+BvdNpEAtWiyraG106TtsD5aOzN41fC81/zaQyMsVzF9qkaAgkxSQ97BnDNTEEBF0brJs1A/BDySjpd9M8aIedDz1Hf8rHGmqXiieqGzFB2PUXgVJA5E3gfRNJA0XJAxn5Y3odlAo2S7QUFE8bFX/MZueEk16WWfPz44hGYCF4IwzLdYBgGhI4bLQ8vPexMuCwRA7HVxl2TvGpB0iq3qVqLfnNvLvcmUdvNiGUcNWrJv+UrIvvYWkGgOLhpNXD90Nf+QfgTMSLL71i/WBh25gz+hHD4cD70NW6NTjOotCXLMqmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFzFyx1vsGg3jLH40Ok722Zs8rNi57PQqnyZ7ZkJjRA=;
 b=Lb7poSpMjR2FzIjGTlxhTEQQIdGFdwTe295JbRXXh65rsd0YGZbpN9QImDxFzLoRwM4CLm3JoLDyqWd5WXHSMvCZBMMTcnjMPv8TS/YTUbtZQpLg+uCoacUX7GJu4cZDGaYjnSwAqzXxhGaZtF7m7OPTTEPVPlY93tp5BcHu68c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DU2PR04MB8631.eurprd04.prod.outlook.com (2603:10a6:10:2de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 16:57:56 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%11]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 16:57:56 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     mani@kernel.org
Cc:     Frank.Li@nxp.com, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, helgaas@kernel.org, imx@lists.linux.dev,
        jdmason@kudzu.us, kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        ntb@lists.linux.dev
Subject: [PATCH v15 7/7] PCI: endpoint: pci-epf-vntb: fix sparse build warning at ntb->reg
Date:   Tue,  1 Nov 2022 12:57:09 -0400
Message-Id: <20221101165709.983416-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101165709.983416-1-Frank.Li@nxp.com>
References: <20221101165709.983416-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::20) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DU2PR04MB8631:EE_
X-MS-Office365-Filtering-Correlation-Id: 5879f941-1ba3-4f14-2623-08dabc2a3983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vyv/lPaEiikBwp8jNWWC0clo8TSaqzuaINmHuP7SiiRmdHks9dMQCyXaBX7Rt7JvKw0c8JrND9dct5gUJDy9glyYOQAo1qbTju1W08QLRbEOaM2GmTuckHE8X6/YQh3x429NVkPIcB4t3tb6oex2/zSzRdXU79Kf6UMcoGWEAdndg7uFn88xuREWo0dmhvl0EqDx/hAYBIg0qdWkZ5Xa+HssE3WRz1vV/OZ6o+9oDX2rjXVKQgQ7IzIT+oKlT13uiO6uXVHF0Kdky3sG1hqq3BnYytn1I4inXAlzRd7Jniz8pB6+rZ8KuBoB/5ejEBvY39byC90MQDGUH10xd3mTeWBKVlEz6dnoEpuB5BKmAVebAGEKrXb9zc4CH8LpNBEy7Um0HWEmeqSZVmQD0x86MfGeulDVEgcPNefAizghQD90sWPvzoK8yAKepBBQ6BDCiHXXECRSfZ9InBQyzhCb3ITVwfu9cKi7VycoZlwXjoZMZr4owgTlZuUJJjahyPgq62IUphi9dCkZcE181GNiZhmFIrLeJugYg2ntSJ/la9rk0/H1u6lWYJiLJHjzKk3kQB1jXgWoKRSIYNITl8TVr/n6sUlyI3A9FLZiIKQa3AGqKGbNT5xHuLpvlbRm9KCHJ5rzuRAkAxzuLpjdGH3uGijsl8y2HFINZWNwbiPzgwek9C7e+k2vzL5uQVX3hBoVU1AXO0Sh4IqWJhXglmq0b78AchOfMZ/lscOQ8G0NRUtWw65Zb+awNPDzYOw9V2omaXqQSh76YaSwvp3W49PC0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199015)(83380400001)(36756003)(86362001)(38350700002)(38100700002)(6916009)(316002)(6666004)(2616005)(1076003)(7416002)(5660300002)(186003)(6486002)(2906002)(6512007)(26005)(41300700001)(6506007)(8676002)(4326008)(66476007)(66556008)(66946007)(52116002)(8936002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Pg+TfWiwtiGv/AHEU0TRL52ayOkxwzpXRvotrTSH9XxxTiNx7IPIiGgzbB0?=
 =?us-ascii?Q?XQsXRwzrdWdPpB+q04emv6gxizdvWhjX7hTFOVYxLVPWP87AIoqIPFchzyzv?=
 =?us-ascii?Q?W/ivlC96lezo24zQdXnOwZ07fJcFFG715bJTnSZ4Gyh6wr0GNP4kP3oS70DZ?=
 =?us-ascii?Q?o37at8cqHbYwNluRGWKSFlddZJxyIrEc0iCcqqdvB79Zth9suskpkUW+L1pG?=
 =?us-ascii?Q?wCS8zW9MrHGRP92Yu/qULTbtHOcayuJr3YEzCCvQA/sFSRH5Ai87wQYFaxzZ?=
 =?us-ascii?Q?Dw6cwYmAqIoaZUtMJsUWwmG040ZcFTNlu499mqjXenEKoNp3fdrc2bVgh9RD?=
 =?us-ascii?Q?poZcEF4TMwYboXL5LRwotORu2qT8yql3aRZhCwjTl/2QEZVqym4qQUpzR8pC?=
 =?us-ascii?Q?dvvhpcE6HppBfMbcCBGmJGHtECOEb5qhA1nsLXdZKKfcanjfwtfnWatson47?=
 =?us-ascii?Q?FW21JU+EW2Xuvk61PJ3Yqso+vjrxKtlOGBYU0LPk/p72aguQ+umThh+SZCkh?=
 =?us-ascii?Q?LKajzY2KXT1i7DFvWyUPJDi5qEWoXNivA3mVuz6hojXa0MxQ+SuCK7WkMuBL?=
 =?us-ascii?Q?EeQ6qR4leQC0aVR+0SaVWecClSM5Yo+jN3CJqWXca9L3PT2BXUPQFootdbSS?=
 =?us-ascii?Q?crqHYntQoeT1SRNQJwC/vZwepf0rUexLUSSB7LGjN3cik06o3Btt9pPElUZH?=
 =?us-ascii?Q?hqRZEGtaeB5sKtsm02XE8/b0XDjuikP55DVrGb8AaOV8zIrC7rIAW5VMne5Y?=
 =?us-ascii?Q?26dKr3jpK7BXBaUgqbmjjOyJjFVTqI5WaNe+5TZe2ZG+VCYDiHkdBbCm1FJj?=
 =?us-ascii?Q?K+qzPjB3aA0AKZR+NyhwgTgJjCIcL16rige4HfrqtJQzE1Dme/8sVijCo5R6?=
 =?us-ascii?Q?uTzJ5OhQdEhO/PFL3Njg1n6eH4ApQPRry64ZtuVRY93ViUPb2hLO4iZbE2x4?=
 =?us-ascii?Q?LPz5o6JtQCIuPJNLUGxIi/fQd0BGa4apddhPYV7WHXsp2+eWUMgi4FY0kQJT?=
 =?us-ascii?Q?BFIttEY/VNwQjSy/l0hhOxOWCwgLbCLO9D3QGch+gvMcf6H6KOX53Xe0Uj2z?=
 =?us-ascii?Q?b5j0CjAqhegSW3sgxoYHShmM5sC13wEFQ5+hFTlKrbuyEOnGBGdhGa5YKNj/?=
 =?us-ascii?Q?U8DIyCBOEkERXC9z6uevd/eSV3Iw4irrXQwzruON55cMabTAwCRHOMtWxHYH?=
 =?us-ascii?Q?hvgm3midpqMvfQw11+0nRTOeQ8Wpv35HqmrUZZSsNWqqAJQyF37p4y4Lv9Ym?=
 =?us-ascii?Q?5HMf+RV5P1ei5hKDZPZU3eGUGNC/xV9ab5VGUr2p3R8IMdge5Ws3gx9MQq/5?=
 =?us-ascii?Q?qzWJzNdxJF7JvU7CJ+SyKckppAxxeWkoGGJygeCRXoWXbx1ka6xWPkHoMClK?=
 =?us-ascii?Q?eF8JZifgeiEws8sTmmtpVume4yq5EbIu2pvpb3xjp3RtF27+CwhsJCm6dGW9?=
 =?us-ascii?Q?AfVwviYScwL5PSgIbc5jtxWURlYXA4mkZC7U/U35rovjahKLQ3Po/4PtzU0l?=
 =?us-ascii?Q?exDMbaxW+wUjrWeyewwpZSnByQkP7iB8TdMCDpYxlco7pF6o17tOnYhpslbG?=
 =?us-ascii?Q?9ALn6I68BKnTNOQrnBVx9+I0L91w0GokpLZ4IwSB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5879f941-1ba3-4f14-2623-08dabc2a3983
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 16:57:56.7453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNPK4q1KdoJbIrmBbhQIG7ffAqsd7Y1UFz9B/bscfVml114DEFepBS/j0c49oi33xW7d7xO97n2gpKq8s1nQ1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8631
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

