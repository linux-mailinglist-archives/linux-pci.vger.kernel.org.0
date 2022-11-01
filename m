Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CC1614FDA
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 17:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiKAQ6E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 12:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiKAQ56 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 12:57:58 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70059.outbound.protection.outlook.com [40.107.7.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4F01D0C3;
        Tue,  1 Nov 2022 09:57:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kteey2HVuyXtS77yx7eTeUB7XbggQKHRgoY8BMh3dwXwL6Zf7r9QBK5o9xI4YJPo8/mkIb8OrMZ/TevclzCsAqrSZF86WcRmc+vPcVG9X1c8Y30bNReobyoYR7C3XtQosntiUcLyJo2lM4uHiulg5boWntUtwiNPgLJTMpO9nNfHPkhV8yAjWnCIJBnXJCL5tnjBgNthGFo1ZK6lEmhHub8LtdADT4Md0J+vFsKvNZi0o/rQwOgjo1E9XrIAbIojGfADUwP39OzTQFPMhC9f0Wq9DrIAnFrr1EC238gOCOVL5SOO/fACu2K71bWWjhGMcSBkUuzdy/Aade+7XpRMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5pmgfmO9df3Hk/t5Nvw6lWOCyuSGK6o3sQhZJwpX0E=;
 b=PDe2AfMG/J1753TC/tRStYV7IOlDNV8ZKwHFvBiGscM9WbWyFGammjMqrXQSRP5R4eMP9Unay5nIZTVOSvvtGWzr8B9y6IiPnsLfaS2hGcbhqyg+iVuDlP0iIDF4Eg6qlMGg5Z90SBkRo25RQ6bohdSwoDuIEl+m7iHEHoGSacZCw+9qbxo//Ll81rNrEBj2rkyV+b71PYzizs/fwBvR/ZSaCEfHnPpENDDh58umKGwCw72aAt818sd5SjDFhUSvhuRIBS6N39srvdcR+ZOPd5YcCgdXm2371GzTGW7SHurvagFrU15AvNu+XpqNzxepKXNis5atDp1QaTYqZl35mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5pmgfmO9df3Hk/t5Nvw6lWOCyuSGK6o3sQhZJwpX0E=;
 b=oEU7uyDXVLZPZUNACQMDgdYlmaFRlbNwdLVBvzzzWltlGDJHwk6SnDHxY5vY19btXqg7sWWehQ7OSNdY0uaOElyte7WsVSfOUdagxiT/OpeV1oGSY/SW/ryYMeGofxRKPa3wzYoraU6IvTDO8FkLGrmR0Z/KUfroY20mPUa0Tio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DU2PR04MB8631.eurprd04.prod.outlook.com (2603:10a6:10:2de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 16:57:49 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%11]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 16:57:49 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     mani@kernel.org
Cc:     Frank.Li@nxp.com, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, helgaas@kernel.org, imx@lists.linux.dev,
        jdmason@kudzu.us, kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        ntb@lists.linux.dev
Subject: [PATCH v15 5/7] PCI: endpoint: pci-epf-vntb: replace hardcode 4 with sizeof(u32)
Date:   Tue,  1 Nov 2022 12:57:07 -0400
Message-Id: <20221101165709.983416-6-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 58bd74fa-2fa8-4fe6-d452-08dabc2a34eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8A5CBYGhu+PSPIBlpQjubQYfH/wGSFQ0/QMYbRf8dJJL6ngxhUrFXFQTeCLMqma4t96Tpnyd+M8dUr4xgfVS4zn/X8+hhTSoc/BGIEjTVqKXjNd8D8+P1eSrT8pusiCh3f7nKjvn7VWEPfhSWBbbsnNrkaQ0urDz64zyJ1euO7afqGaaIHlfxfRbGIQjJZYs/PgC+iUo4YE8oYFC+Xav+pLfkHvf/CunsD1sdxEVgdXhczI+ipAcmdxU0B6bULudVpdLNlsLvBVlvio4+y2dDMOFQnC5+V5hzl7myx6IG2ndwoYguMpSZxxgliW2tDTCgLNV9M9nUPHldnFg5M6a7UqfaCcUuGlkWebICrv+m8DsbDlLvbpp306bSbUjWd/xsLQXXPXfmlpSdqmydTqpJ8UavfavL7txESEiT9UfMdLAClGbigAQtsQaGpFk7qfnUAoyemKksXmz9hjzfzWfCNgl5aG1w3DNtqh3PkyEWPtaE1MP6UKtxGs6xBFIr/A8glgf7Zg6QWj3z59Gzs8gSOY7gTtog+C5iNEsX9DIb6/C2msZ4y4Tw9BQaGAaXrIXJtq8CfwERhpocRY5Jm/eVxQ0L+ZKGmVxjBaWLshMZyQZX/uPWS8D56+kQn01RDal20R1OTF5uEaF2XBugmI4dNKd1XkOy6N+TgvEnKxtR14I1uzQOf6gTa0XB5/XkZcbgbYkZUYb8agfgTHtyT1yiazQRRCjuqjpoyEK/2rVksvF35e/usGMSey2IZ9LzSou7CannOXpEE8S+yo+D4MIBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199015)(83380400001)(36756003)(86362001)(38350700002)(38100700002)(6916009)(316002)(6666004)(2616005)(1076003)(7416002)(5660300002)(186003)(6486002)(2906002)(6512007)(26005)(41300700001)(6506007)(8676002)(4326008)(66476007)(66556008)(66946007)(52116002)(8936002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A8AMe/C1CL3KIH5cRB4QyFWsvFcXmcPuHTe8OBIjAOnm74wy9X1cVuzBYkn8?=
 =?us-ascii?Q?a6qwiHB1a1ZFbOOIz/SiwyIKKxfsd+e/TTAjHN8ggOKZmoHtLizO0/SPTA1b?=
 =?us-ascii?Q?rZvfqKb3brxpPffWWSY0JRWiwPQvTKsZzYllGZCfA1vWZpMMS5h89swGEC9y?=
 =?us-ascii?Q?T2voBkRgDOsxwTu1LqvcUmGYritYD3xE1+gRknRY5kfFB/QA2DyGb8mqSRaI?=
 =?us-ascii?Q?TjE3FUVUQGBxPWU34Ui8HUm0v5GkRx+df4CCGXQNhoyZRthyqhNKrIZFqWpm?=
 =?us-ascii?Q?AYkgP+MnTEZGQxd4nxxY1GueR8Gvkdp/dbtLfUf64iP6RfrvQYOUIc3HOofw?=
 =?us-ascii?Q?pG4Yn6rN7+SE5rs4DrZoawphTriz0Q6NTpzYvq9ykjc5IPBf0scXMLXU5AJo?=
 =?us-ascii?Q?hB36Xiw/ZMsuDdbMZRqfg5Zo5yKXK/gwMvzPIXseMKfcjId+q5lpNghlduy4?=
 =?us-ascii?Q?xI3yj7iKXRclj1W0s1F4/ljUbYgQCdL+3OxZmufN2rUURVGrPhegGQZv3hmt?=
 =?us-ascii?Q?QiPuJTBgNsmzTt1viPKTS3mA/25vWKUCIKGfe7NspDBsrxNwRkEkdBjSPbsU?=
 =?us-ascii?Q?QipV3W4liFuKGduFsqJ4M3dCe6NAatYLuHFSarPFVk+kPeBmYJztI7gInmt8?=
 =?us-ascii?Q?3rers2xE9gG/ksQkY2FloXsVhJ9dMv6+Tp/Z/7XkLersqEYDD1lQDRW2Y+px?=
 =?us-ascii?Q?rRhtHvTOwj5Ff3FqrOzF768+LM7yR3aXLECbp7nnXWJ4wezkbzHz2AqEi1yA?=
 =?us-ascii?Q?7gN6JOy3T0r8bol5JYrN6T56zhw1LElRRp6+gKWUW6bkAp5X9vti11nDiSuf?=
 =?us-ascii?Q?G7avY9b5AUt0LP/3EAOw5OGcmQg4zAV9uPx7PGakZn+OgqtKUsG42rbch6tc?=
 =?us-ascii?Q?UF6DYpyVtzDDpg+Qc7IorafsWUEs99uPXorCWAxN882MH/CatvBteqGilXkT?=
 =?us-ascii?Q?tljbEoHpVDy+b+j+6X7BZCcxUSRQSda3uZbqOU9NvK5OnKkDNY4gCBqn2iQR?=
 =?us-ascii?Q?IVcljlhpBz+IPGys/Pr3Rgi+H9avhh7cg7S6Gd+zdSAIVbaOFvSm1wuWLpOb?=
 =?us-ascii?Q?HFObcKEBaAVx1fvUD+1Ctln3Mhzb+KGeBvDzMYzTnXtRB96h62FBmKUvrbs5?=
 =?us-ascii?Q?eM/LSOFUdZWO00pqgZBBQ9Ed+FiiFf6miu29y9egGZFicXpnit4HpuMYlHqR?=
 =?us-ascii?Q?aryDGCFrWTyRbdyRIREnuoeu7iKpok19xA09pQtj1VIWEewqLUbrjAWxaMLz?=
 =?us-ascii?Q?cuZg8T7LkrofrlNPz8h6G88hNXoKIeSh85H+cmDv+UP4DkWWepqsspi8witm?=
 =?us-ascii?Q?/AuNjYHK+nt88a+X8lyUOFtp102xcwlYWr4GJiVh9yCQ+vYHXIvGjVOmrUPs?=
 =?us-ascii?Q?zbcDOYRDCf9kxCBqxjZpLZ+OIKm3cG3zGZtEorciWDaZIWiisUESXB6EOSkc?=
 =?us-ascii?Q?9vV6COQgpUpiNgUQfCg8K6Vizgv2xoR6GgJIgNkjobgDc1RfKVUbgNQusQBD?=
 =?us-ascii?Q?w37IeGLbz+0v4MhguT2a/YICkp3rpeMUIKMZD7UrlI+Bh50S3K6jc/b+PG1M?=
 =?us-ascii?Q?u49Xw2KUdJKyGeN9iQ+mNQfSj8YxeeISgYDjdmyr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bd74fa-2fa8-4fe6-d452-08dabc2a34eb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 16:57:49.0583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbiqIDp24HZAZjLH6CHzTzRmHEM2U8KOJ9pJznWKdl879Ag1bPnMtq06uABvAIGobydJ8oGXfJWf001aNIkYvw==
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

