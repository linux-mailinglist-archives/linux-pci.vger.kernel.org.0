Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DC55F7DBB
	for <lists+linux-pci@lfdr.de>; Fri,  7 Oct 2022 21:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJGTOj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Oct 2022 15:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJGTOY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Oct 2022 15:14:24 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B759D25AA;
        Fri,  7 Oct 2022 12:14:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKnSZaibiKs+Sc+l7HHR8JoPVBQZewxAglavCsjjx/Wdj7BF2txcmHs430YXIBbv8Wc9EONT+EQ54Ie113Ln3jVFey6b0sla2atlxUKr0cBeTOhEisLHD48GBKJ6hGtM/YFdbkdWlQIzbpGiy2ipjElO6soInb3FemivUMFy6R5/mF057ty5sKRxdXxaDKasQ0NbMBi/MCGWumVSAXE5LXKCFwSwknNDqZccBXTdOxw0rOXj2gxNHjAHG3xBo83Mj0ae11XtFNoc03U6l3uGLkBXRJjdmeh1dcVHf3/h73yffFFbWGHw+Umr2k4a+d3C6p+xRLQZ5paAbdxl2cP2QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7rFAgLLE8DgxLzFxypT6h/aMZ7/AGzWG+1ThOcYzlQ=;
 b=XRRc/KfwNrTk8sFrmbjgJIGjvy+0OoqbFAzI1CB/+OqZAc1TZh9DUzB4CCJIdXVDj3rkRZnYQksDcHfYvIbfwMTWDyvna8J0jfVL0hpjImilc/lsoGoQBKqBnw58JFGeWtExlKy9Kis/fYxwNHDwHRdF1zstYlHUy1wZkQsqgAicVidcs3kRtxv2xIN9BdZxKXtzYOGTstkisNKoHADwuDM/RS1IGhJebuYzvIyMLB32IaLUgoCHTeUHwiCpx7M+9Tc41zx94ZovaOCUGnplha8Rh+KB/KZIPG77vMKGujYnzHKGzrgNRZpiBmm5cAhq0KZHf1GJpzAxthnRD1R+TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7rFAgLLE8DgxLzFxypT6h/aMZ7/AGzWG+1ThOcYzlQ=;
 b=Vn6C7rDZXkg2m5FRczZubzjFWWAngrFYNI/UHGrDVmphb6re0R0OD1UuxbFc020V3UcE1Mgd82O+HPTrQoIdkyHqmQba4l+8W95oN31vsD4xPetfQNrGXR3Q1AHF5cumtY3yszA7UJHGAl62rf/LYD5Fh7QLQwNgrFvKQfxOkLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by PAXPR04MB8192.eurprd04.prod.outlook.com (2603:10a6:102:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 19:14:19 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::54da:4ebc:2916:de90]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::54da:4ebc:2916:de90%5]) with mapi id 15.20.5676.038; Fri, 7 Oct 2022
 19:14:19 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     imx@lists.linux.dev, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ntb@lists.linux.dev (open list:NTB DRIVER CORE),
        linux-pci@vger.kernel.org (open list:PCI ENDPOINT SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v13 5/6] PCI: endpoint: pci-epf-vntb: replace hardcode 4 with sizeof(u32)
Date:   Fri,  7 Oct 2022 15:13:25 -0400
Message-Id: <20221007191326.193079-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221007191326.193079-1-Frank.Li@nxp.com>
References: <20221007191326.193079-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::20) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|PAXPR04MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: b4cf8da2-8182-4c39-53e8-08daa8982297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: itL7l3OmIev9DPydUhe/pM3rELPAKqoGMyMUCvy5rCc7vxlhLShzyeYxwJP6vyLnBUf7Al1c9lDLH7GE6Uww1w4B8uuxqOeTExGfw0YiSfaJU6uAPNAUG3zJMTPRAZzaKegwFxHk8oLKNxnK2XFyfxXCiAELNF+Cq87ReTazGzH/zjpRX4AlTdyce/2KnPZIdhTXDNX63Y36NEny1a2zWFXkPvCTbue9uVAVxfFpvrl2qFHEEYilNM2apYgXT8UzfYrL6hFdLGzDFuom0Th0T04USNbYKCqmTnty8fvpbzjCnbIDrpCBkcGl1ReVGgxDJHkel8sy4vN9G7Y0w4yFEk/Ei2tZl+BQd71Zl6TJNjs1SFN0wFKAg9uqAIWJ7h0oGTQ4rdoxY3qYrkBp592/7reXicSUybYglJh0tFgv/lNb+fzrWMIEDlKtMByTT3iypUWzjSsi8PtZ2guS5OTJglpcyvhYKJZTTeiI1lriMdgaZ/s1wqHdNcKE8ZJIWZ51//7WlD/qX1DwhYrvc9ATc79GSARnSUw58E7T/qR2Uhm5TW9sOV1sc2iLqgVqwKd9qkWF6zbx+Xya1WEQvm7ORJHvPOXODDVtfwwJKVIMaHV3rDNH9qFK46CkgnucE/knyjlArnHsOa+DiF85GZe5+WE75MA39vjrIVViEZSRCnFkucaQCJ+f30I7TZOuOZWemfLhnZXh2u3Whz+FvWkUKAtlhKmN619bige7NQHoFTJSW8LyxLwO2V523c3vdcgtPP0q3NePnvIyBDi4z084pvehU7IMtMCfX6WpLwcGnJc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(66946007)(36756003)(6666004)(7416002)(38350700002)(8676002)(38100700002)(2906002)(1076003)(41300700001)(66476007)(186003)(66556008)(83380400001)(6512007)(8936002)(2616005)(52116002)(26005)(86362001)(5660300002)(921005)(6506007)(6486002)(110136005)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j/j+vHF2uNkyVj0As2jW0I8jIB2CXPvaX45IgRdeFFNwyQ4KVAM7ubWw6AQD?=
 =?us-ascii?Q?hB20lGH6tg2Rddh9kmfadGQaUIR8d7B5cg9sTxFmLUoL6ZW18mAxbmpiopkA?=
 =?us-ascii?Q?Ut+hsmvDxP1JPpHJbMh9JX/aO9NI0ztQcq5bOh7DwmGvh4RDqXOcuJGJiTrs?=
 =?us-ascii?Q?0L+aYC/l9EwzkasXj2M1+ug1x9Mh9Z9r35Hi1jn8t0TQk3OVIaXMcIcK5/wf?=
 =?us-ascii?Q?cIiW+mRIUitelIUDaxkTynNpgD4U7SfTtjtWrSAtLw9yLQbnV6sreO2IvCSB?=
 =?us-ascii?Q?eobgAtbYUYUI5+tzqmvpR4vAE+zEgpS+Ft3idpR1tzicxxTyTA/9P5HfFTDf?=
 =?us-ascii?Q?dlQH1ch0EQlwlTByYzH8l36N0bTwVRXVdvly7tlTz38Figi6AAFEgRSZhNYE?=
 =?us-ascii?Q?A0Oav67uW/Sbtn4+ty0RHjSD6Aw0rbW8SseJxuupJfJJMR3hxYU5rzQ1/lvp?=
 =?us-ascii?Q?B5fNQF48APpSyeCKvmQRJoXqe4ChMy/fMfdOfjJI35rScvBWDRrJU2+WXIeJ?=
 =?us-ascii?Q?m+5MhfvspKJDNKMB5lF8Gk4N/d+OEnyVjnPvHznOi/+lUrLgNuE33fuTFJkK?=
 =?us-ascii?Q?ZAriGPpATglJl763nRSkrdOp53owc/T3gHcUtPRk+3rlzVQuWnVvy6Ko/kyT?=
 =?us-ascii?Q?VG21E4cOINO044Kv3fNmP66SG1rWVVs/5iMlgN05NJU3F7PtpqDRqaNO8raH?=
 =?us-ascii?Q?n6TK90MPwRa7YKdDpdxME4Uk4P59zffuaJAdFCw7sk2BQki2ZQusMKw/JegX?=
 =?us-ascii?Q?TNFJE+Dio6HSWnzDKCxmiqoiTLEALaCrJ9HcXsrtvnGZuGSUbD/trHKolxDp?=
 =?us-ascii?Q?THq6ElTBu29spF+IciWU4ifUXB7BVlPfUPjYSihES8zSZ1V95cik65D3neQz?=
 =?us-ascii?Q?Tt5R/rO9acDJccz7rQMA8DSwm+8IRHK8b09RuZUbLBmJc175X+YtChCQxm6Y?=
 =?us-ascii?Q?QcnX8uzNrxqTDe9GA4skMvy8nA20LTqoxlCUWdhnJsLBpPdpjRAKnCcqhKq5?=
 =?us-ascii?Q?8bLMu2lxc8ksyz+rlBfeobCx8sp2wDiXhz1sITLWzYBWnWxnUon01zU4IfSd?=
 =?us-ascii?Q?ghkyb2YMBDOsjCCIvykt6G/5ZeCbSCwLzFSMkeXq7g0J5Bm7vvGx7W/EOvk2?=
 =?us-ascii?Q?yG8r+/SSZs53I65H3DFAlbznDgUbZ3tINBJTOvExrNC8n5m9fs8j/6yw2Zou?=
 =?us-ascii?Q?zp2Qk89AHHEdrXQaJ2a58QOcsAsaUTSF+/BxMG7tHv4cc7QH90YB2P29v5Yj?=
 =?us-ascii?Q?IebaueJKLcN3YIuxCuyjASA+jbX4xQmjeIq/Pj18mO0toclFIPcqJ0JDSUrC?=
 =?us-ascii?Q?VfP7RyEwQTW4gFNm5shVbH1mDkUkiwIjZJ5LrYFkPY6IIK2GpgimxEnfW+sb?=
 =?us-ascii?Q?iFwRBfPhouH4f2frj+FFpO6fYaEQSb6Wmrx1gyb5CQdpJxvQ3gEPICacdx82?=
 =?us-ascii?Q?9xas31FcJk1iX1WoXkbwlvMmKTpC7QT9U/+udBx/MUx9tz9fOQnvqwLR4nCP?=
 =?us-ascii?Q?mai3FPfWYyjlgXXIKvuwV5Kp/xkapZdZeBgFmH2fuI+2NZFWpkuHA6p5NIT4?=
 =?us-ascii?Q?I7YgP8tIlkDBM7ezXtc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4cf8da2-8182-4c39-53e8-08daa8982297
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 19:14:19.6746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJxvtEE+QAW9zWYc0mNpac8maiau/NZb9p9IgjYIUD8u2kz6A4xwYwJIzIxBO8LKCmwPynGtRiYGaPo+0SvncQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8192
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

