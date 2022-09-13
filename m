Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6A25B7C96
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 23:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiIMVL1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 17:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiIMVKy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 17:10:54 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80044.outbound.protection.outlook.com [40.107.8.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DB776465;
        Tue, 13 Sep 2022 14:10:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEumhe5GJYRuPFa16N1nDulAwDXMPNDulZUZc5ifkyMyLMMpxNQ5pOIbHma/tdnh4P3yOZ5cZs7cnB++836BpJP0GBcZEFhfx5v4TbAuiET6ApAYR+rMOUI3FTe1GFJLhfBrxq6G+fZntNV2VTU3dVp6x8pjHrgTiRh093HZORJpuSykNkVQdLtbFVbklHxGXB4kcgCyH+RRdJjBSUuVN4Zi8Dsqo+1cdFfpyBVt3fng/oBVxk3rsAQn5zvISY4+zRlPg6TF+2VI7U1XezjVlTH9R8o/Pip4loBgrQACuuu/+kelP51QjPjnRxXOeu8G4kchNS1B9jU3SUxIX7Vz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BzD+Xxznd5N3/JEojbN5/7AXJeTYY2ZlfHfdWpVou4=;
 b=FOVTDot3LqhN7ueqJgb4EnwvJXbKy0KFIgp+gjUmDeaxddfPXkKDjgTXT0/tFMDa8DosT0QJTbZEikG8PKz0rqxFH3aoKOu6lUdlSA2rwslpFlm+dofl4ot09sOHrZQO1/Dnfqdd5DhCBPpwyLwYPbDAjWpl0CU9WN0+tDMQ76A7hCDDIhh/Mzrj6pAl2eJh7/+6MZqT9uDYGviW8WyDQZr7rK7oBF0ita2jtIJ0+daBlBEHH4fT7FMOm1l/bTGAYV2qv+xmXIaR//v+h6IgFSKiQVORDOo+CgEmLQV7lAD0b8VQ7tOEmZpS4I9aA+grseIeo0s+qARZE6SBtFXrMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BzD+Xxznd5N3/JEojbN5/7AXJeTYY2ZlfHfdWpVou4=;
 b=rwp89T79sA9Uf2bxuVhO9OqAPU2ewM676dCNd6GZMAbAnywJT0HMCvHkq9ZnDJV4IpB2ED/CTSHyBwHtyJKsxOCumLorqeSzWBBkGpQpjxLO3PfISJJJVbkU0vVc6EPw/1Q28dHB3GC+Tnpu8wrVbZc5h0IemIoOwjibOHSX/Ws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by PAXPR04MB8621.eurprd04.prod.outlook.com (2603:10a6:102:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 21:10:44 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::e5ca:22d0:52e2:15f5]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::e5ca:22d0:52e2:15f5%3]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 21:10:44 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com, imx@lists.linux.dev,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v10 5/6] PCI: endpoint: makeup pci-epf-vntb.c
Date:   Tue, 13 Sep 2022 16:09:56 -0500
Message-Id: <20220913210957.3493826-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220913210957.3493826-1-Frank.Li@nxp.com>
References: <20220913210957.3493826-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::36) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|PAXPR04MB8621:EE_
X-MS-Office365-Filtering-Correlation-Id: a7302561-2090-40a3-cbff-08da95cc6c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OElPTv6gtTvO7WWBUeVSd1IcxGezNWdORHcqbdO8ZLPVn+z4S1a0l55q/GliJk+bcEEMFYKoanOfvixa8TEI2N9K74SNq64h4VAG7U0yNUwWA0qO/6mEL4ND5hR7yyg+qcnfH2+TmLug0xPZIscNaPO3sSDiR4O355z3AR9mHMk26IMJv8K+9OEBG5DT/QMCqCnsC5Rs3Vj5JDEucfMU2Sdit7Ol5nE6qgyh9XIlF6cT32NJE/dEW2YndtzcM8J86+0MorfJ8nB1NhwDrx36WStdZfILCntnutz56CVxPoGPfm6EDGOHen17LykeW/IaMVbmFRKbwuoFVvlpyTAE4a3i19KwRzqV5YZHMCzmZLCDdcS6r0QdzBXIQMuIYebj8NWOSmac9N32HwA/LVhlVQGUf6nVwen4h+XRaathpX8GPUPdKj8ndKiszUelaJCDslkFkBqXDMt78GVJCR1EgheXqg1A5JUu5Q0txNAEeM6qIXUB3uszppEFO7bJIsN2hxkfX/PbdAHYRoKXlWE54YXylvPywQ1UzcEER/IisVUy55eYcw6HpnsN71CN9MtUHgdb/4pRM5CIXYucv8+qHcjpH0OPlwUuuAa0qmoPiqynxpA2B1S5QpNi7aZ7DxCv/+WGP/343izRJ8JacVxGq5gyVAyHpDVGWtCTtso3+YPQFlA0cnrdr2mdD9owvfHicPYCZEaORcM+gQwOJ0pHqWA13nAt1roXTqqf8rEvcGZeCONeTjkW/C0n3q9XGE+XJuuBftK3O5ziVsLzvG5uHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199015)(38100700002)(478600001)(316002)(83380400001)(36756003)(8676002)(66556008)(2906002)(26005)(52116002)(2616005)(6486002)(66476007)(66946007)(6512007)(86362001)(6506007)(4326008)(41300700001)(7416002)(38350700002)(6666004)(8936002)(5660300002)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6AKqkKMBRHUUQ+eRXF4XTeeE6zw2aYaMMmRKBfQRErUzjGuewpDbQYkC/dl3?=
 =?us-ascii?Q?Zo228CbnzMhOHZNQuI++XDp+EH6M0B/pGac/R1Sni2kW9bsdamP8cEtOHryk?=
 =?us-ascii?Q?CTD0MYJJSLPnPAKldwG0wVfZVi6zLvpmNgiHBg1i1RelnlORKtNo+mHvsNOB?=
 =?us-ascii?Q?2iqSabGnG4GER7Z9UuVTWAdn47vPMU3ZJ0UxVarEooZppoQ+hu7jcjkEOJ6J?=
 =?us-ascii?Q?I5qHPYuQTNySUYsgQScFQKQZEYt8wxGukbt7yFa0XKyCOapQDZVTbzqMnEUP?=
 =?us-ascii?Q?4BHe2QZkK7crEEVAxU1ypWRnfwi4w9YpwVSlnLFacdEAiio4DASeNME2NRYz?=
 =?us-ascii?Q?JfOCw0KjxeKXMxnSCDkSbVIsIycYZlYu87FOAzYVdfCb+BIN9lAlghMa0eBB?=
 =?us-ascii?Q?fmvt+vrn+9KKWgdOuLmnmX6SS37p8hS62pH6pIgEt7e7BdX+/dVExpXzPLOf?=
 =?us-ascii?Q?KWspdhZ+M4WMqlEXyIjWRm+NzaQzcK7OwUY3/bb0qVugw/3r2Vfj4IxQMjQL?=
 =?us-ascii?Q?9Yo0POuME55Gs6dOioCzObvbpE5LRK2syzWUFgOuCWUmugJAqPxnQsL8roaO?=
 =?us-ascii?Q?pe64dxn0QTvj9NJRO+fsGaxlUHsRAqU9M9QiBsP7G9J7oYgMvNYLvlRUbNGm?=
 =?us-ascii?Q?njO7/ImoGcrJ2dyeVDi+ZXtSB7LnnJs6Mum8Z15t4QheGC6lLmAYp3nIZFHI?=
 =?us-ascii?Q?HYf7PYM5Dc+9vUnOsVU83u0Rbb2JTu2gO3FD68zbJZ98tnh+X0pN1p0dd9Oq?=
 =?us-ascii?Q?BfPfn9/Gf/hZVtpzQk7ON6slU1UZ1GXti5vVkKj1jVffbAAAvlRhATWytYrA?=
 =?us-ascii?Q?GDfZAAIyhzc+ovbs/EcnrrgVmg7PeeTSDbTtC9MBxviLNoLJE4U/bUuY5jbF?=
 =?us-ascii?Q?6s2PNnLHSPmsKk0KZzW4xiuj/dzMtWocvDegXyZk82uhUUc3avAyYVGI12MK?=
 =?us-ascii?Q?u6ysFhw298RXiKdtc0lSf3wxVkLDH/NkzkN3kVBoUsiefhqNcAgbRiNO0fWn?=
 =?us-ascii?Q?xwhV1TEkPUH/prhivt0OCfY+E0xuAKbqqMWIw9mfMCfzDMWppiWMdzreMDjN?=
 =?us-ascii?Q?eXa4RaOD6HGR4kAW1DRNGOXH9DrCRxXgZcVdskhy+njGHZTCn51r5MxZbCBI?=
 =?us-ascii?Q?LhIYHh0DMiQOmW6p2xX9r3cA4hxsXCebCcdsaq6C7pA16vkXTj/9bZkAaPoe?=
 =?us-ascii?Q?H6KITZJMXlaw8vQ/NaKEoUafbJL0E7DHgK0iAQrD0BqiRBTpC73JM9d0QctF?=
 =?us-ascii?Q?dllYRHNvkoS3BseLLRPcYhT5SMQG6dLfhOGUbIETpqKZ/YLlRTUlFOL3sljs?=
 =?us-ascii?Q?uC0I3SK6oLwA4Gh5EuJB7p53ioIMuS3iMRLu1dyQEsdcN6yVK6/8xROOn3tV?=
 =?us-ascii?Q?Ok7QnWcSe1LW8wtV0B3OW8JtWYYFEPsZS9Mm7TY6E8Dr/4WkYV7xrjyMEF5T?=
 =?us-ascii?Q?BbuG9d6/hxlL/AGCh8Wuiz1+w47NYZfyai4SSWNwYjpPXyvdVd0lTDMR0NQB?=
 =?us-ascii?Q?HnaWs5zbvBPf+Enb2nEQeslaIsFLtr22vo0AmM4tlcU2q494ZU8NXwUd4Omu?=
 =?us-ascii?Q?x+fzRKuNqQ2W+Cvr90U=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7302561-2090-40a3-cbff-08da95cc6c23
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 21:10:44.8061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovsc5u+3Ox8syyZ7ITcsQOWrUYW6A0Ny2cnTgUNzfm/b6zD++PYoLm5T6fciLHyv2xfQJEIUQIb7nRe7BNZ+qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8621
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unused field: epf_db_phy.
Remove __iomem before epf_db.
Remove dupicate check if (readl(ntb->epf_db + i * 4)).
Using readl_relaxed instead of readl.
Using marco ENTRY_SIZE instead of number 4 at all place.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 1466dd1904175..17f030befde52 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -67,6 +67,8 @@ static struct workqueue_struct *kpcintb_workqueue;
 #define MAX_DB_COUNT			32
 #define MAX_MW				4
 
+#define ENTRY_SIZE			4
+
 enum epf_ntb_bar {
 	BAR_CONFIG,
 	BAR_DB,
@@ -136,8 +138,7 @@ struct epf_ntb {
 
 	struct epf_ntb_ctrl *reg;
 
-	phys_addr_t epf_db_phy;
-	void __iomem *epf_db;
+	void *epf_db;
 
 	phys_addr_t vpci_mw_phy[MAX_MW];
 	void __iomem *vpci_mw_addr[MAX_MW];
@@ -254,12 +255,9 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
 	for (i = 1; i < ntb->db_count; i++) {
-		if (readl(ntb->epf_db + i * 4)) {
-			if (readl(ntb->epf_db + i * 4))
-				ntb->db |= 1 << (i - 1);
-
+		if (readl_relaxed(ntb->epf_db + i * ENTRY_SIZE)) {
 			ntb_db_event(&ntb->ntb, i);
-			writel(0, ntb->epf_db + i * 4);
+			writel(0, ntb->epf_db + i * ENTRY_SIZE);
 		}
 	}
 
@@ -424,7 +422,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	spad_count = ntb->spad_count;
 
 	ctrl_size = sizeof(struct epf_ntb_ctrl);
-	spad_size = 2 * spad_count * 4;
+	spad_size = 2 * spad_count * ENTRY_SIZE;
 
 	if (!align) {
 		ctrl_size = roundup_pow_of_two(ctrl_size);
@@ -454,7 +452,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	ctrl->num_mws = ntb->num_mws;
 	ntb->spad_size = spad_size;
 
-	ctrl->db_entry_size = 4;
+	ctrl->db_entry_size = ENTRY_SIZE;
 
 	for (i = 0; i < ntb->db_count; i++) {
 		ntb->reg->db_data[i] = 1 + i;
@@ -516,13 +514,15 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 {
 	const struct pci_epc_features *epc_features;
-	u32 align;
 	struct device *dev = &ntb->epf->dev;
-	int ret;
 	struct pci_epf_bar *epf_bar;
-	void __iomem *mw_addr;
 	enum pci_barno barno;
-	size_t size = 4 * ntb->db_count;
+	void *mw_addr;
+	size_t size;
+	u32 align;
+	int ret;
+
+	size = ENTRY_SIZE * ntb->db_count;
 
 	epc_features = pci_epc_get_features(ntb->epf->epc,
 					    ntb->epf->func_no,
@@ -1084,11 +1084,11 @@ static int vntb_epf_link_enable(struct ntb_dev *ntb,
 static u32 vntb_epf_spad_read(struct ntb_dev *ndev, int idx)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
-	int off = ntb->reg->spad_offset, ct = ntb->reg->spad_count * 4;
+	int off = ntb->reg->spad_offset, ct = ntb->reg->spad_count * ENTRY_SIZE;
 	u32 val;
 	void __iomem *base = ntb->reg;
 
-	val = readl(base + off + ct + idx * 4);
+	val = readl(base + off + ct + idx * ENTRY_SIZE);
 	return val;
 }
 
@@ -1096,10 +1096,10 @@ static int vntb_epf_spad_write(struct ntb_dev *ndev, int idx, u32 val)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct epf_ntb_ctrl *ctrl = ntb->reg;
-	int off = ctrl->spad_offset, ct = ctrl->spad_count * 4;
+	int off = ctrl->spad_offset, ct = ctrl->spad_count * ENTRY_SIZE;
 	void __iomem *base = ntb->reg;
 
-	writel(val, base + off + ct + idx * 4);
+	writel(val, base + off + ct + idx * ENTRY_SIZE);
 	return 0;
 }
 
@@ -1111,7 +1111,7 @@ static u32 vntb_epf_peer_spad_read(struct ntb_dev *ndev, int pidx, int idx)
 	void __iomem *base = ntb->reg;
 	u32 val;
 
-	val = readl(base + off + idx * 4);
+	val = readl(base + off + idx * ENTRY_SIZE);
 	return val;
 }
 
@@ -1122,7 +1122,7 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
 	int off = ctrl->spad_offset;
 	void __iomem *base = ntb->reg;
 
-	writel(val, base + off + idx * 4);
+	writel(val, base + off + idx * ENTRY_SIZE);
 	return 0;
 }
 
-- 
2.35.1

