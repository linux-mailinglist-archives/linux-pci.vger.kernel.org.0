Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04686116A5
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 17:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiJ1P7k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 11:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiJ1P7A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 11:59:00 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E7D21CD46;
        Fri, 28 Oct 2022 08:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9VbPvD3wGvJOQYsNXGVklno06CEYFq6aXMUY4Eq9lR9vsrbZ9c/HFOMOWlnAIt/VxgCWjV5zm/j/GsUY7Ty2z6DviQ6AaKBtFbVumPWP0FTZn7aKvDsNcTdvpLD6LiE/W9CBqKq5SG2LEAhUCKFi4JvLGIVvWgq510sy2y4EkykzYxqTecR9yxhSvowjo8X7YH3iQneiarmnp0EEUSUh4ybHT6IGZ3mf7c9aNEh4jwRWuDORrbPsR3h6xVFe3rMdiyLWIltcQhbqJMACtAVfH/jxIDAh7wuyrVp9aL93gJYnnh4eDSwX7xA4KkOSQQZzIaWZntrv64V3rOVij4WSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7rFAgLLE8DgxLzFxypT6h/aMZ7/AGzWG+1ThOcYzlQ=;
 b=WEtztqkD2xgBrjs7tZo+eJmOWUEH0qSrKJD4AqdCHIKIBoYF3M4mEYY8rk9lAzKj80jsbi+O2w2OF3HMVIlalz+c2Xh9Ow5ScEvAMS7wDete9nGV1DdqgrfNQO++OiSBY+EWpQgwrZoBlBwkyEXhx/Ou06KeerPGQVn8QitdZQW/cO6GMPdG8bv8EnoBc+bwRd82z/KOCbe2bhxZLuGKbx9YGIiIZIjH6hs7iKwx+CYM9UJ5mOi20aE+fIgzAX1fBM9iSZch/kFxoUobm2TLuoPgw2N3hx3489ua6QMlYemGQD/OzMWBxt3VoPURCKuu+mc/okKcoNCSTzTWjuqNXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7rFAgLLE8DgxLzFxypT6h/aMZ7/AGzWG+1ThOcYzlQ=;
 b=XIcofmhFu/25nSIp9SO8HuKsUbtTAPAIiwAyfN9k5lI0/ODTcF9P3yh7OpyrtaTegFEIIUYjHHucTU6NIno+C7Fy7ug3hwF9XcIlOMuCTvRR+31kExAa5tRo2sKaJCyh+zxH+YV+aP+Vo1a2g4NO0ZPOR9CcLWCwxP/XW32TciY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AM9PR04MB8323.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 15:57:45 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%10]) with mapi id 15.20.5746.028; Fri, 28 Oct
 2022 15:57:45 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     allenbh@gmail.com, bhelgaas@google.com, dave.jiang@intel.com,
        helgaas@kernel.org, imx@lists.linux.dev, jdmason@kudzu.us,
        kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
        ntb@lists.linux.dev
Subject: [PATCH v14 5/7] PCI: endpoint: pci-epf-vntb: replace hardcode 4 with sizeof(u32)
Date:   Fri, 28 Oct 2022 11:57:01 -0400
Message-Id: <20221028155703.318928-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221028155703.318928-1-Frank.Li@nxp.com>
References: <20221028155703.318928-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::23) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|AM9PR04MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: 075b4988-f553-427a-8ca6-08dab8fd278e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UpoFVPJbbOsb206snh7r+2lNlHZLqd1OoySePfJdY/EMU7Rzvvt7wXnmIrKiDTlEuM45s+nQzgWnX5QU/q9s0RBb0tT5BICP3h8gZdyuoLvpq1evbndtRdEetoFs/SN6YuSlbd3mCzS+bSOawzIBtE099kBK9X4bZyCBwvGs9W9stAC2af/oWn59kCXtKlM//yW55WHH0SGA1KXueweJc61es2JrQeELi921LYT1zEqfZvoJ3uNvtgtfJvkaHCk9X7aLfatzmWnOZDUrsbC9/T6/55QiOdAeLhVxigwcU/1PuAzr0JMnKNv5JKcTVthP48S4VMiCVlzTU72rKdR7rc41lmYz+Xt/t/sQ4wVxrn1Pfc9aL1Yk5sVajHXRr1qcnawyVbxw/Dm/bcq6XGX2LPOMAZf6kWPP0tpKK9l2dFDTK8Fy5OiGPfNZWviXF/cqVF3Fw/YecipDdVc25dpwuIlZOTpS9AJ2bXjkUvn08GcGmSVYEQWPPay+GK3LzHdSUaEBTD1y/AY59gq62/cIp/vTW/hfDFHLaUWDAzYMGjIQ+S/Psnh258u+fUOS4DCG+EiivMU4ew+R5qxDx1NBoHOv3M3XElrwOdytErIFpuZ/8DWjGEELN+EWSm3zPmjMbVSGAikNmnao4WDgHiIJLqRwgsgwevrWsJdLgd/qM/DZkCQTkE9L8Fl0Oediav3xyHhLXQM1JDuJPtAry6t1Jnf9+uOGz0wsyqOEs3Ie1Ohf5FQeeCHttHIbsByFjRkb6WYNCajqRYRw6ld55ekZYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(6666004)(316002)(37006003)(34206002)(8936002)(5660300002)(4326008)(2616005)(186003)(1076003)(7416002)(8676002)(52116002)(36756003)(6506007)(66476007)(66946007)(66556008)(6512007)(26005)(41300700001)(83380400001)(86362001)(38100700002)(2906002)(38350700002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W/bG23VMqS4raFLFF0POdak/KhfEv5VX30ge6L7Ifo0U0+YxeQeVpRafRAZS?=
 =?us-ascii?Q?kjpdxfAcN0CPwOWN5JkW9TVBMW75RYkMMd/Lwoag9aiMlKk9+yKFxlfkarI5?=
 =?us-ascii?Q?G8/lr1sWBTuD5melNk5hJq6qk8MYemZYoUu+mjfpHSGl78rlT4Kp91OtDcRu?=
 =?us-ascii?Q?t+hkm9Vjvw8Z86sB7bORTnLU9pvV4c5JXfE1ultpiEP6+/+I6tM7mXFR6ZzT?=
 =?us-ascii?Q?Nlj5wRfxS+NG6Im922XcEUOgIa4/2ll8Qw5BuUe7GN07HmuhtiNBF+ia8mVQ?=
 =?us-ascii?Q?X+04D9lMV/0iFgG7/JB09qtzs9kokw4l6l0x/D4TQ3BYnUtGZxlaHfhQMmNM?=
 =?us-ascii?Q?vsZuN3y1KvzkrTtMXYdFrpvILtx6iHDr519csY5zUn43P4ye3jpj7i6c9mAD?=
 =?us-ascii?Q?VqIVlJ6sfiUleXvK+e6dE2qUOoAYHJcdGRif33IzMcsqTJsZ8d9wxvQywXEa?=
 =?us-ascii?Q?Mciu5WCKsPyDf/Sx0zwVx4m2FHY3ZhTGbylJBb2ybf0RWo/sAu6Hi0uZLVMf?=
 =?us-ascii?Q?RXGyeXPLtIQArXMDqrNzH4q+0+TNIOC/sGyWydK34SaTA/3PFrxdS8/lwfJF?=
 =?us-ascii?Q?98Uezj6nE2dMJJOVm2gbQ/8FjBOmnlvD9Jv+cGXbw8oKAf9g2NEaCm432C9G?=
 =?us-ascii?Q?4BBWyBzOo1hs3qy3W8hwHRnZhC4CqoFhIqBU9hvjBvmZaalYHJwe5m3t0cQz?=
 =?us-ascii?Q?2ZEWRhRf7EYh0uWDRNcDCT3Us+7vcaqoeYSEmV28FcEwxijeIWggT1QTr9Zr?=
 =?us-ascii?Q?4HWHySu05qrT/UwCxemwCSWIRVknt9vtlJ/Vp5LB0CGVwcm2mf8Lh3vOTXNx?=
 =?us-ascii?Q?vuNPNu8l7GMaKzuTb3oh7eke6orW8LnCsZclSEKQrj1eCAPBwudAFVhFMlmp?=
 =?us-ascii?Q?W0XtVLyZzG2vyiokO2M0WGB8QvwUjhtZqDLuKa/WiZpsfGtp6sPMOqYUPzA/?=
 =?us-ascii?Q?lLyl+rQrXy+US0CPSJjrUOvDDtTN70+CSvwGWmzrJe9YxbbRDiWb4kGpQoeX?=
 =?us-ascii?Q?jqi6TnyyjcjQoW6G+LqD1y0fqVvtBqFsweMcACSuWrLvyJF2gBQmWfLUJ8PN?=
 =?us-ascii?Q?qxcXXq2Opq8aDHvQgB5Tr8niq52hMLXIyjqgl2h7JGj85RLAXYp3KhXGVqSJ?=
 =?us-ascii?Q?oAUGpwaOP7KVa2ineDgw9sLBYFDnSEAikQYB3fQu1lIuKMR7pw+t5SvrbQKU?=
 =?us-ascii?Q?tFMAcuzUvC3tBrBpYY/1f2dDcdftmN6hxYKMSTJB5M3VbzD+3w5dF0K9HCLH?=
 =?us-ascii?Q?6ntzczHcMXaHTruPZ1hmCg0Hraifn4+BHekwEM1kA+IXN323uIIN/upPSzm6?=
 =?us-ascii?Q?YDy1xICRDztN6u+Yux/OpBoZETEZZU8BaxOq4V+TTpx8tnAd+fbe2kkw1yGu?=
 =?us-ascii?Q?jPDqd/b4phHOCOM2o4hX3f39FpBqtQaAON/r8WiMzaM0+Ubxp+q8GpyfuvSh?=
 =?us-ascii?Q?C9Haaon8GVEdpsBd3plhNMu8LsEL1X7qfDp6753rza8sSKL07G49o/Js+ami?=
 =?us-ascii?Q?DJsfQjnTrvqGSn9tZKbKs6t29761zf5ty4V/2BLq5sEw0lz+ny9Yx3rbCnHT?=
 =?us-ascii?Q?NAwCRzacFKQK38NqOF0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075b4988-f553-427a-8ca6-08dab8fd278e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 15:57:45.8424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UuL1JoszslJGU1mmpajbThQuHuulOEFJYwO2qxXxC1x2ajwFN7mZHmpZ2+mnbrDekwNEKFoVDpAzP+jSKv8yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8323
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

