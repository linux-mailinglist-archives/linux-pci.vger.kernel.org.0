Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948DD5AF4A1
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 21:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiIFTlw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 15:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiIFTlt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 15:41:49 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDD982D35;
        Tue,  6 Sep 2022 12:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jL/EGuLS/HViwsRcRPOMIkPQNs/CIFoCSY3OCVwBMvrMrOQfivr4J35Mu2RZvRYTaetFJg30Gwk50ETbO7bXNg+pX+MtJzX3koiAL5gz7U+QRfq9v9GtjIGm8IcSlW+dyIkmGa7zgE+1AuGvB0qtrO2yrSD1eggxwbNF14duHV8btuCqHYeEG+DO2VYEU1FaTGnMzAZJPJmxiEXRS3ZxaurOz1DlaLtUiWslxC6KtXnNfiph/k5/mu9RgMZ2LhgN6DEpXDKN2Cpifk3zXBHt1GxZ1tdJLcaHFwNIzfwSz+H1jVryBl1w2TM4/rIsX17kp+0Jodop15j8GCSpDxv1Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luNuA87ZdAV700jTSvPtoctsb3rd8ltqs7Sjx4ZnBbs=;
 b=Y+T6Deyv09Y0rblMxeLsHKdi+By8kFGM9aR+QCDYr91bMJtM/SLBAFb1rZ8Q2rzxqDHY9R/yGLaiB+rGqrH32t0QirsWRQu36iryRhxzwjkaQCOQK9EtzgFhGuU9XVp4xAAsbLWAFnSMgykYLqcVDFCWe19a58s7rmoAeXnNVJS8uMtF/Dgt4TvlwD6kgnsQKA4kTE65vbL8MN3Q6PO3JDEnPJsQftBOMZz86q5A4QjGdTPZVAOSM6VtPu2NK0qeCDuvdFqXeodql3j9m0qs6xW062gfGH0AgbWLRe2ILDbrG0r4RL3rhjDAe0Byk3v2Ml/VM/rP+PItzttqwKLogQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luNuA87ZdAV700jTSvPtoctsb3rd8ltqs7Sjx4ZnBbs=;
 b=N0PsTT+XRSgZM6m4dsen/KFVN74P2USpwgj3MucB57FI/jn+kaMIJx+Y9v6LtHIzGygqPdT6xWc1gxshaW2HU2eP01yuuwZtMe5dlb7LO45Zc4a9ci2zQCxQhW2BO1a/atzOMBBgYqlWVf9YqvBczJMli/Zd7Kv6oRuB88Pl2zQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by AM0PR04MB5059.eurprd04.prod.outlook.com (2603:10a6:208:bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Tue, 6 Sep
 2022 19:41:35 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb%9]) with mapi id 15.20.5612.012; Tue, 6 Sep 2022
 19:41:35 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com, imx@lists.linux.dev
Subject: [PATCH v8 4/4] PCI: endpoint: Add vNTB MSI support
Date:   Tue,  6 Sep 2022 14:40:52 -0500
Message-Id: <20220906194052.3079599-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220906194052.3079599-1-Frank.Li@nxp.com>
References: <20220906194052.3079599-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0042.namprd11.prod.outlook.com
 (2603:10b6:a03:80::19) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|AM0PR04MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: 44bdd7ce-165e-4d75-06dc-08da903fced5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CPsYo9Ose6v/2IBYr6sc5tkO24lNRAHc11k1HIGiB8BxftBeqwRWfg21vPJsBsJFO6oYCo0pBf8+m/Pwng2OZ2aJGUGmWoJUfgHiwUZ8GOVr54ed5cXVjImyvf+hJt3bWyzBt1EwnDWUSOdTnbWx28wa0526y4OBUb1KT8J9JzC+0Hg+Mzw+yN08fseYc2bifZc+jLOLPVhLTuE9cXjBtSWlamTvCkGe9YzsAmOF9QgRvC00w0rDBFy7a+KeH4xse27Hd2ks0t+59+meN9FnmAFSwQsMZDM/iPvgZNOl/omgHe+Ghh+Lv367tTB/fABtl7ZhZ/FVOC1DxNfQqlGV6e0FHg+BEwNjh7NdJKfzD5E48+PV/HWY28WeoYX3UmVsK1VDjAQy5YLppZRdegEqSvHpfnHMVUkz42HPOobspPWKa3ESRqZ6aR3ldBPhpRROl7fYI7QCNB4IrUhfeWtEzyc7WF1eirmEGd6RhAqoJyJsJPNfjvycmEONdU13X+5ahgUPjL2XGVnLfzCO5jFJ6fHY5fPTC0Wo2vOXfVklQE3EuXqtBZNKCbza8YrkTpNxmWVjHPpPIIFC2bGq6njYf/j6hd9+JtT3NZIqI73Ua0ytB0F438M3IVJcipU3Q06P2yKE5eMa+T+pCVxTtoddm3OmebAq5FUtW7yaeCYhfZVw5vOzlC1D/ix1+RIOSWmD3dwNxc6dYMzpDagQwvpK9LH781dBpa6UZd4BjLlIh7uK77v+/FNsnjs53hGSS/BzvwD63GStOl6JvZDPcxx8bQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(6512007)(2906002)(478600001)(26005)(6666004)(41300700001)(83380400001)(2616005)(186003)(1076003)(8936002)(5660300002)(6506007)(6486002)(316002)(52116002)(4326008)(66556008)(8676002)(66946007)(7416002)(38100700002)(86362001)(66476007)(36756003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG85Qk5velZqVzVBTTFSLy9mZDVWZmdSc010dWVmcW9RTm9YN2grd1YrRlZt?=
 =?utf-8?B?cU1FcHp3MXhPcVZRQzFCUDZlZzBPVCtSV0NZbUJiaWttVnNVeTc1eGVTa1FE?=
 =?utf-8?B?ZkJWOS9IajlXeG5tbEhZTnpzYXV5ZnNCc3RFRThTUC9DL21qVE9VdjFrZ3hP?=
 =?utf-8?B?RnlVejlQeU93SllibnNCSWZaTVMzaTBqMEpGNUpGZmt2QkpRRUxaZWtvZFRY?=
 =?utf-8?B?NlBLT0VyY2xHc1lNYVVrYWFnVWlLUmlyRjY0WUtmaVcxMlhuSUFPRVRsVm91?=
 =?utf-8?B?SUVQYitoQW9hMlVpaWEva2JqeWhoMDhIekthK3J6R0ZURmhTVTB0TTRVTzdI?=
 =?utf-8?B?akFjQysrTi9QQ0JPcmFJUlBUcU9FWjVyL3hnV0Q0R3llRFlQVUY0NTJTWWVM?=
 =?utf-8?B?cmdGa2RnVkZuYzBMYXI3NGlXMVU3U1ZPWDNwOGJWbGZJamxsQmJEbi9WQkVv?=
 =?utf-8?B?WklZMFI1dTZuSzMrdGxFaTc2UkZtZEhzcW04eG9SSkhjYXlxRW41RG9wbXpz?=
 =?utf-8?B?cUgxQ3Q3VVlIc0hVTFdIc0s2K1JpS0RKd0VKY2V1VzQxV3FZNlQ1cEEweklm?=
 =?utf-8?B?R3R5VTVIY0RoOTZDYncxcGtkdzdjdjFPdDdDakU2YUk4d1VOQ2J4T0hNRVlY?=
 =?utf-8?B?bklMcDk4Qmw2QkI3OHhzL1VZeHZNazNRdEFvY3FQWHBzeDdSTDRwaG5Iclpq?=
 =?utf-8?B?K0RmNFh1TWRHTC9CWWlsUEZndzdNMzU0WklkQ0RhKzdGQU5LMGtUUGtqUmU3?=
 =?utf-8?B?WlNtaWQrdWpYcjA0ZFRRdnA3eDhlWlFBS2RDNkNJM3Fja3FvYUVxVGgrRDRM?=
 =?utf-8?B?VmNTejdHVGd6OVpCYnR5c0d3SDVkVHY0NzNRSnV0dDJOdHNZR2RoWk9QRklL?=
 =?utf-8?B?NmU2V3k0amIwMnJ3WWlSVXVnLzkxTTFzZmszSTJTMjVzVjNWTGNaSDJjR01s?=
 =?utf-8?B?RkNzK2ZNQVgzeHdtYzZIRGt0M3ROUDE5TXBPdjd0dHZMWmxsTFFEY3ZrV3M1?=
 =?utf-8?B?bWRtMzVOVVpvc1hPQjBDemlONXlkcDBNd1FYVWhVaFVvWGhwR0xJZlNQckJ6?=
 =?utf-8?B?cHJib2k3WUpXTXlIekZrWGtNc1N2VnZla1BMTjloRk0wQ3hERFQvd2I4N21C?=
 =?utf-8?B?czRVdHg4YTV5b2w2UEMwREo0T0JCQ283ZXdORXVYS05DM01TRE56MzNSaHRn?=
 =?utf-8?B?UXhFUC8vbC9ObkowNThCMGRiMG9QVENsY0JaWEtBUnRwYU5PcE9Tem5ubkk5?=
 =?utf-8?B?Y08rdjZkZ1hxMlp2NzNJVlN5ZjF4VkYzVGFFdDk3Q2FiZjdwd2JDcC8xS0l4?=
 =?utf-8?B?MFFyZFdwa1hhSTB3cnp5NC9VQkNwZ3AvcVdQNG56MUgrVFJQc0YxY21oZCty?=
 =?utf-8?B?b1ZweE9PVW5IeGZseW9seG5BTTVxZGVnVkZ2ak9MQ1VxamV6eFpvaFpuZGc1?=
 =?utf-8?B?cjMvUmpNV0JNR1B3RS9uWjA1dXczVmozNGdiL2wyOHNON2taQy8vbldIdjd0?=
 =?utf-8?B?UUR0KzBzSFJvSWtTYWM5UmVEYWFVelRBZ1NObjVVeTlzSFQrd29WTmp1RTRJ?=
 =?utf-8?B?WGNFc2dQOWd1Q2dWbXoyQXRqM2d3dVRLN3pMdmdKeURxSzVVb1BBWFFDVTlG?=
 =?utf-8?B?L0s0NTJ4OWZQRjkvMVRQS1Y4bDliWUh6U0xuSWhSL1JocmtzY0pVWjhqdk9H?=
 =?utf-8?B?OHNwNlVSWWliY2UyWmlHbERuekIvS2N3bThteThNSnVLcXMyLzlTY0RwejBW?=
 =?utf-8?B?aWIwcHd6MVRTMzk5ZkNrcnk1MjB4a0swYlRSVEtpTFpTZ09CdERucTRlbll6?=
 =?utf-8?B?akhOTzdnSURoWld2WHN4MjJDZjlCUjNSeDhDaWlwNURWSEQ3NnNXVS81ZUhW?=
 =?utf-8?B?c1pxbWJVV0NyTFJiNzhMcCtDUTVEai9OZVZGMWNKMXAyK0Npc3VESEhDVnB4?=
 =?utf-8?B?ak1kMkovN1h3V1lEZXJ0aHZGanZ6bFo2b0NCVW9kUkNpZEx3OXFtYnI4RGNB?=
 =?utf-8?B?Um1EY0FYZ0hNTlZqMmxydjFtNzBSOHRvK3J1K3JMaHhncCtnM25tVEJIUTcw?=
 =?utf-8?B?YzlxUDU1aVdsZlVBOEtYdTlWbm5iVWJnamUyQXkzd2VVcVN0T3pTbjZWMDNo?=
 =?utf-8?Q?u+opl4w/neyHToUeJzb1L4rSU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44bdd7ce-165e-4d75-06dc-08da903fced5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 19:41:35.5169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5UDaGVdToQz/7FT0fRcEHqasyVPUpFlKjHGlEjMVhdgr+m5Bj0/Dixp+q36zQGIRcazJ2sVZuIRkJ92pTONTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

                      ┌───────┐                   ┌──────────┐
                      │       │                   │          │
    ┌─────────────┐   │ PCI   │                   │ PCI Host │
    │ MSI         │◄┐ │ EP    │                   │          │
    │ Controller  │ │ │       │ 3.MSI Write       │          │
    └────────┬────┘ └─┼───────┼───────────────────┤          │
      ▲      │        │       │                   ├─BAR_n    │
      │      └────────┼───────┼──────────────────►│          │
      │               │       │ 2.Call Back       │          │
      │               │       │   write_msi_msg() │          │
      │               │       │                   │          │
      │               └───┬───┘                   └──────────┘
      │                   │
      └───────────────────┘
      1.platform_msi_domain_alloc_irqs()

There is no defined way of raising IRQs by PCI host to the PCI endpoint.
Only define MSI/MSI-X to let EP notified RC status change.

The memory assigned for BAR region by the PCI host is mapped to the
message address of platform msi interrupt controller in PCI Endpoint.
Such that, whenever the PCI host writes to the BAR region, it will
trigger an IRQ in the Endpoint.

Basic working follow as
1. EP function driver call platform_msi_domain_alloc_irqs() alloc a
MSI irq from MSI controller with call back function write_msi_msg();
2. write_msg_msg will config BAR and map to address defined in msi_msg;
3. Host side trigger an IRQ in Endpoint by write to BAR region.

Add MSI support for pci-epf-vntb. Query if system has an MSI controller.
Set up doorbell address according to struct msi_msg.

So PCI RC can write this doorbell address to trigger EP side's IRQ.

If no MSI controller exists, fall back to software polling.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 155 +++++++++++++++---
 1 file changed, 128 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 1466dd1904175..426205b980a09 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -44,6 +44,7 @@
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 #include <linux/ntb.h>
+#include <linux/msi.h>
 
 static struct workqueue_struct *kpcintb_workqueue;
 
@@ -136,13 +137,15 @@ struct epf_ntb {
 
 	struct epf_ntb_ctrl *reg;
 
-	phys_addr_t epf_db_phy;
+	phys_addr_t epf_db_phys;
 	void __iomem *epf_db;
 
 	phys_addr_t vpci_mw_phy[MAX_MW];
 	void __iomem *vpci_mw_addr[MAX_MW];
 
 	struct delayed_work cmd_handler;
+
+	int msi_virqbase;
 };
 
 #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
@@ -253,13 +256,15 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
-	for (i = 1; i < ntb->db_count; i++) {
-		if (readl(ntb->epf_db + i * 4)) {
-			if (readl(ntb->epf_db + i * 4))
-				ntb->db |= 1 << (i - 1);
+	if (!ntb->epf_db_phys) {
+		for (i = 1; i < ntb->db_count; i++) {
+			if (readl(ntb->epf_db + i * 4)) {
+				if (readl(ntb->epf_db + i * 4))
+					ntb->db |= 1 << (i - 1);
 
-			ntb_db_event(&ntb->ntb, i);
-			writel(0, ntb->epf_db + i * 4);
+				ntb_db_event(&ntb->ntb, i);
+				writel(0, ntb->epf_db + i * 4);
+			}
 		}
 	}
 
@@ -454,11 +459,9 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	ctrl->num_mws = ntb->num_mws;
 	ntb->spad_size = spad_size;
 
-	ctrl->db_entry_size = 4;
-
 	for (i = 0; i < ntb->db_count; i++) {
 		ntb->reg->db_data[i] = 1 + i;
-		ntb->reg->db_offset[i] = 0;
+		ntb->reg->db_offset[i] = 4 * i;
 	}
 
 	return 0;
@@ -509,6 +512,28 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 	return 0;
 }
 
+static int epf_ntb_db_size(struct epf_ntb *ntb)
+{
+	const struct pci_epc_features *epc_features;
+	size_t size = 4 * ntb->db_count;
+	u32 align;
+
+	epc_features = pci_epc_get_features(ntb->epf->epc,
+					    ntb->epf->func_no,
+					    ntb->epf->vfunc_no);
+	align = epc_features->align;
+
+	if (size < 128)
+		size = 128;
+
+	if (align)
+		size = ALIGN(size, align);
+	else
+		size = roundup_pow_of_two(size);
+
+	return size;
+}
+
 /**
  * epf_ntb_db_bar_init() - Configure Doorbell window BARs
  * @ntb: NTB device that facilitates communication between HOST and vHOST
@@ -522,33 +547,32 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 	struct pci_epf_bar *epf_bar;
 	void __iomem *mw_addr;
 	enum pci_barno barno;
-	size_t size = 4 * ntb->db_count;
+	size_t size;
 
 	epc_features = pci_epc_get_features(ntb->epf->epc,
 					    ntb->epf->func_no,
 					    ntb->epf->vfunc_no);
 	align = epc_features->align;
-
-	if (size < 128)
-		size = 128;
-
-	if (align)
-		size = ALIGN(size, align);
-	else
-		size = roundup_pow_of_two(size);
+	size = epf_ntb_db_size(ntb);
 
 	barno = ntb->epf_ntb_bar[BAR_DB];
+	epf_bar = &ntb->epf->bar[barno];
 
-	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
-	if (!mw_addr) {
-		dev_err(dev, "Failed to allocate OB address\n");
-		return -ENOMEM;
+	if (ntb->epf_db_phys) {
+		mw_addr = NULL;
+		epf_bar->phys_addr = ntb->epf_db_phys;
+		epf_bar->barno = barno;
+		epf_bar->size = size;
+	} else {
+		mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
+		if (!mw_addr) {
+			dev_err(dev, "Failed to allocate door bell address\n");
+			return -ENOMEM;
+		}
 	}
 
 	ntb->epf_db = mw_addr;
 
-	epf_bar = &ntb->epf->bar[barno];
-
 	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, epf_bar);
 	if (ret) {
 		dev_err(dev, "Doorbell BAR set failed\n");
@@ -704,6 +728,82 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 	return 0;
 }
 
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+static void epf_ntb_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct epf_ntb *ntb = dev_get_drvdata(desc->dev);
+	struct epf_ntb_ctrl *reg = ntb->reg;
+	int size = epf_ntb_db_size(ntb);
+	u64 addr;
+
+	addr = msg->address_hi;
+	addr <<= 32;
+	addr |= msg->address_lo;
+
+	reg->db_data[desc->msi_index] = msg->data;
+
+	if (desc->msi_index == 0)
+		ntb->epf_db_phys = round_down(addr, size);
+
+	reg->db_offset[desc->msi_index] = addr - ntb->epf_db_phys;
+}
+#endif
+
+static irqreturn_t epf_ntb_interrupt_handler(int irq, void *data)
+{
+	struct epf_ntb *ntb = data;
+	int index;
+
+	index = irq - ntb->msi_virqbase;
+	ntb->db |= 1 << (index - 1);
+	ntb_db_event(&ntb->ntb, index);
+
+	return IRQ_HANDLED;
+}
+
+static void epf_ntb_epc_msi_init(struct epf_ntb *ntb)
+{
+	struct device *dev = &ntb->epf->dev;
+	struct irq_domain *domain;
+	int virq;
+	int ret;
+	int i;
+
+	domain = dev_get_msi_domain(ntb->epf->epc->dev.parent);
+	if (!domain)
+		return;
+
+	dev_set_msi_domain(dev, domain);
+
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+	if (platform_msi_domain_alloc_irqs(&ntb->epf->dev,
+		ntb->db_count,
+		epf_ntb_write_msi_msg)) {
+		dev_info(dev, "Can't allocate MSI, fall back to poll mode\n");
+		return;
+	}
+#else
+	return;
+#endif
+	dev_info(dev, "vntb use MSI as doorbell\n");
+
+	for (i = 0; i < ntb->db_count; i++) {
+		virq = msi_get_virq(dev, i);
+		ret = devm_request_irq(dev, virq,
+			       epf_ntb_interrupt_handler, 0,
+			       "vntb", ntb);
+
+		if (ret) {
+			dev_err(dev, "devm_request_irq() failure, fall back to poll mode\n");
+			ntb->epf_db_phys = 0;
+			break;
+		}
+
+		if (!i)
+			ntb->msi_virqbase = virq;
+	}
+}
+
 /**
  * epf_ntb_epc_init() - Initialize NTB interface
  * @ntb: NTB device that facilitates communication between HOST and vHOST2
@@ -1299,14 +1399,15 @@ static int epf_ntb_bind(struct pci_epf *epf)
 		goto err_bar_alloc;
 	}
 
+	epf_set_drvdata(epf, ntb);
+	epf_ntb_epc_msi_init(ntb);
+
 	ret = epf_ntb_epc_init(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to initialize EPC\n");
 		goto err_bar_alloc;
 	}
 
-	epf_set_drvdata(epf, ntb);
-
 	pci_space[0] = (ntb->vntb_pid << 16) | ntb->vntb_vid;
 	pci_vntb_table[0].vendor = ntb->vntb_vid;
 	pci_vntb_table[0].device = ntb->vntb_pid;
-- 
2.35.1

