Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166095E6836
	for <lists+linux-pci@lfdr.de>; Thu, 22 Sep 2022 18:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiIVQOf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 12:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiIVQOV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 12:14:21 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE62102534;
        Thu, 22 Sep 2022 09:14:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXebeBFGqN9oN/398IVvX8/cWo02xRCaEiHGezvogpv2s6QMg/6/zFSkEvmOLnz2EEKl2GEtVUM/NzxGIyyMnDFNUgRo9M6yWiVpMARd4CLm6jLvDSflfY372Xv5s7mkWrClT8ErXc0BWG5cv4Qnk5fU1wKBwLrSUSQ67GN/PR80kAI456dIqnkEhLkbReFWVTyWQqVHFDL84fSAtVPUCN4KtH5YPeZMPu3m4iq9mStMIi/ep0Z+4zpldXPfgAJB/nJlFcLVXhFkEUK3csJjDB9pcEXVi5BBj884nw+W2mqPhjebpTcO0kNpgCxVDdnELZrk4aMPKX8VbZFrxnQrUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8JUx96keiGr1tQ4OD3B9n3DTWQBrLQzOEmt0GmiB7M=;
 b=nSAWIBnH0Yvu1jpgs2ZoD6LQxTCQrd/mUCum1n2ysG3fo8t1Qi/2oGU4IoQdo1KfADXAZuQERzi65/GoGk8EdrE0b5fWrD+cuPpRyk7UYYwk8vJasC93PP1uIfe0zqHb/jcrN1q+JvaNRczGT2AJ19/+4CCNtElA+fia18jVh7VwayoXshRNHm2yUSIfNAvctYP15ihvn7JFTUXIK1hG4xkEmXrpIJXHaoZuZlurvOKUfBumTuqqecN2MbZh3Uvsga0upz9MMi7sWwf+Fzys6pKIdN3ItMXMPa42vLZaPyJC0FIh9bgSy3GSukocPzzMOUO0qFkNUNBMT3cwhsXXIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8JUx96keiGr1tQ4OD3B9n3DTWQBrLQzOEmt0GmiB7M=;
 b=Uw9XpGgg3RmoGPoo2V2yXSyswauisPO3dSMNdeH+l1E6KMx4zWMeKkvJAyZ0thnccl+BU8R9CegGtIuosSC4VGZDUJ0tYKsmBbXhzEoy6eyXSrQ0WczCQZ1vXMKalgKxOiXFCY6onYiZ8SZmqJ1eGnPhSaN60WtQVqTp5yTlBcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8789.eurprd04.prod.outlook.com (2603:10a6:10:2e0::11)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 16:13:59 +0000
Received: from DU2PR04MB8789.eurprd04.prod.outlook.com
 ([fe80::5c5d:d0e4:cd13:6428]) by DU2PR04MB8789.eurprd04.prod.outlook.com
 ([fe80::5c5d:d0e4:cd13:6428%5]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 16:13:59 +0000
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
Subject: [PATCH v12 6/6] PCI: endpoint: Add vNTB MSI support
Date:   Thu, 22 Sep 2022 11:12:46 -0500
Message-Id: <20220922161246.20586-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220922161246.20586-1-Frank.Li@nxp.com>
References: <20220922161246.20586-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:254::21) To DU2PR04MB8789.eurprd04.prod.outlook.com
 (2603:10a6:10:2e0::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8789:EE_|AS8PR04MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: e753f173-4b89-4095-057b-08da9cb574b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TrcDWnWEBo9Ffo0Z+ihQ3e22txuO1nRCVqOYjgKV2drw5cvKzSgUd28othD8nVHBs+CCWLhNo55Q0q9T5dSZj/CR31fB6XmJ/M1Imm9LKQPxxuBU/eNpEuz8EiTUyhqMZMzuK7r2oIRKJT2u7qzd9j86v7BaRL2fAgWMvO6+cQp5iq9xtD9D3Obknrn7NeuDtL3pPOohcozgcpnbAiRqum74gQEIF3q9bUEz8WwXF9yq/9dqGoaE++9fVcMwx8+gUAU+UMrMk6OYPxH3n0nTJSCqeBMti0n4E9nL1DoGSz82DjFvGh7jSHnGR0sp18OsIWqmIASYutjSZ87FolmBOHvEAwNrkmgaqXLQKmN0oEbKQ/4ekZm2o5HuxYuEQ5eyAOjouc/a8tF/6CZXPZns+hkET/FwUYWHiJWNXBPY13UwHu6HzMPw24Q9WjZSdeTmOUE4bGkb3qLhHsTzbAjv1f8UYIUmRerCcmgMpT79kcueFMuNoQljXfwu7bQn77ARxv0dlSNv6szuBpJu+4Ob/fKcfbzTUuip8xbHKzryd5r3PkeGpmW/dQUzVGeNNl3XrOQMv4PDu8nO+s9pjnG2LTguVCiCSum2vpfI6vT7mHc9HJ4EFmo8P3XyxY6f/DGYsiKv6ZKueHprYRz6VyPwNVcFPTp9+976CdPmp9DUDs1BjwQ+BYjm40pRQAKAqs3R5S9M2jwIExgzbOgZqemeLASlw2WnpYtcxts4Si/fsS1qyCsbXq0LC9tW+8JoneCL6NOWXMOBjWSh2UznREmysQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8789.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199015)(83380400001)(1076003)(2616005)(6512007)(186003)(38100700002)(52116002)(66556008)(38350700002)(66476007)(8936002)(5660300002)(41300700001)(478600001)(2906002)(6506007)(6486002)(26005)(7416002)(6666004)(66946007)(4326008)(8676002)(36756003)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0UxYjJqTjFESWxXNkFIQW9JV3B1YWhPNFFHZlJJT2lCZkx0cmRic1grR0lE?=
 =?utf-8?B?U2FvUG00eDZxYzd3ODU5UHFXNFAwNXR3L0crTHcycmlGU3Z1eFNaNDRNK1FQ?=
 =?utf-8?B?RXZGY1F0cUNLVWZtS2hpN1JudnNwdFVwTjRnS25TTlhKcHJXdWxyN0pzQ0oz?=
 =?utf-8?B?TkJ4clJESHNyd0NnM2ZqYmx0enlvK3F4TXBYaklyU3ZQZExRTGRIYXR2bzl6?=
 =?utf-8?B?TG9wTXloM3d5eFBYTHZsY2VITC9VOVdxQVVaNEIzd2tjZkVxbjRuaHZXQldH?=
 =?utf-8?B?S25nSVBkZmVjR2I5UGdDR1dJTUx3YXNSOUJNR0pVZkRKcWtUWHMzdTlndFRJ?=
 =?utf-8?B?SFRwOFVOcEJ3cEJZQk96ek8rT3hTTmJUbDkzTG9LQmRrYVduODUrMnhoT0da?=
 =?utf-8?B?ZlRHWVpzTCtnWDlDeWRDRW1kRWdhY0UwRGx1UTlQMmxIQWdCUjVFdnlrTGVK?=
 =?utf-8?B?UTZPWjB3K1NQYURzbGlvSmt4YlZkUTl0OGZ3RHJhUFZJczlBOVBEc1FWMlNM?=
 =?utf-8?B?TTNBVHR5clYzbFRHbHVpdUVOOVhiaDI4bElpbFdaZ2U0QkRaY0d2QnFiQTE0?=
 =?utf-8?B?MHJMNkovcWl6b3hwQVVRNVUzTjViUnlQeW1pSDVCUEVhZGVwSmNTaXhxYUxS?=
 =?utf-8?B?NHFTSThleUxUTElmVHZmcXNiTW1wanB2T1RldUdTU0hub09xUVZZeFd3eWFo?=
 =?utf-8?B?aDZVMndlUWlHeDI4eENLRnpXWWJUMFYyWllvK2lkQTNBYXFJRWVEN2RRSjdI?=
 =?utf-8?B?eGRBcG0wMzdQVVcwelJucS9BTjJjYXA5RXhseEsyU0dvWXVPQS95Qm5QTDkv?=
 =?utf-8?B?cW9yQmNyZkZVS3hsT1crK0xhdWFSQzZhWFZHdEdxRkc0Y1Y0SDg1S0c2ZkNm?=
 =?utf-8?B?RGZ4ZWtFSVdoNFN4R255RUpCT2lIRkpUemg4Q0E0SXRFWHFHc0ErSXp0R09B?=
 =?utf-8?B?L3BjR0N2Z2EycU8yTU00SU9jYzZ5NXBka3RaUGs3cFp5Z2hxRENYdXoycWlF?=
 =?utf-8?B?NjdTMVBKeFhyeGNDR1BQRTh1WUZYWnhOR0REaVJZSzJVN3ltUG95dmRLL1do?=
 =?utf-8?B?dFJsUXFkY3R6WDJpQ21GMWpNOUl2b2J3cTBFbVg4bFBaN3pmWDFGWUNOamhC?=
 =?utf-8?B?WitEa3JLR2pPa3ZpUzI1UFJlUVA5ZUU0RTl0emsrczl1NXlwaHZYOEFoNFhW?=
 =?utf-8?B?K0h3SzY2K00xT2x5bWI0R2x5cWhQR2FwOFplMkdSNHpEcndBSGhQUEE2WDVB?=
 =?utf-8?B?bkVGdVNKOEV6UXJUU0g4VjRtZkRXZlhTK2RvcGpwWjZHcE1kRjJScExYWEcx?=
 =?utf-8?B?cERTTU42L3JXWkFDK1NyNUVMbDZ4Q3NYbDZaZzZyNk9wa0NzYTVTNXJybTNw?=
 =?utf-8?B?ZnNKWXdaNUtZLzN2RjZQQVJrWHpaKzlhZXQ5YllZV2pMNStEYXhPN1Bnc0FU?=
 =?utf-8?B?V1JrY29IZlJhTVQyZFMzREJ2NVc1U0RDQ1pIRWk0aXpNL2YzcFZNSXFKaFRi?=
 =?utf-8?B?bDBBMm1uZWh3c0RnZklpajRsRldRQUkvRUxRSzJMSVZ6WWw1bnVva2puZUM0?=
 =?utf-8?B?NStoTFovdUtPclZsNlRBZW1BTGZjVFp2S3ozaWpZVWpxUnExMTQzZm1VN2Rz?=
 =?utf-8?B?YktvSWdQczVxTmx5cHFLSHBFZ3NSTklUZ1NDVGxMM1dGNDBzaHJsV0ttQkVM?=
 =?utf-8?B?YnQ3b3h4ZXUvMUV5V2tZcFhuZGNyNFdSTmIyK2hIRGJJaDlCdE92S2czRDR4?=
 =?utf-8?B?cHJnYlIzL00rR0ZOR3RUR3R1aUhhakZ6Z0k3VEFGbzNRd003T1ErNW0wNEk5?=
 =?utf-8?B?aXhZbkdlSGdRL01lVzRaVHdwMGljUlNlakd1T1VQQlNpMnkrVFVvN0FBMHE5?=
 =?utf-8?B?SjZ3OEdLejdmcVZOZXlRWWh5WXg2Rm1VUHVIakZuWG5xNHAydE55K0Fzb0tS?=
 =?utf-8?B?OTlLa3ZRKzE3K1p1VURoM2xQV1BpNzRlVER6dk9OWlY4WE15SGtiYzdpRll1?=
 =?utf-8?B?R1BPOU03OGkzbDBpb1lhRnR6T2lxZFJ4NEdXb3BtMU1QenF4em9nenlPb090?=
 =?utf-8?B?VTJMVXFVNGdxMFFkdVZSckRwbzAvdSt1Qnl2QlQ3VmhrWlEva0xGdzMyMEhy?=
 =?utf-8?Q?Ej/Sc0EIXT0kgeyK3/nhq4yxA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e753f173-4b89-4095-057b-08da9cb574b3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8789.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 16:13:59.0061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q97chNE2FekQdpMvl+yvI3J89D2sKyJa+vCNbYX7yWbfNthLln7rHZIODF3l+nwK/BR9bTt2lCLYYm/YvIOVTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7541
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 148 +++++++++++++++---
 1 file changed, 127 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index acea753af29ed..8fdeac2201e29 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -44,6 +44,7 @@
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 #include <linux/ntb.h>
+#include <linux/msi.h>
 
 static struct workqueue_struct *kpcintb_workqueue;
 
@@ -137,11 +138,14 @@ struct epf_ntb {
 	struct epf_ntb_ctrl *reg;
 
 	u32 *epf_db;
+	phys_addr_t epf_db_phys;
 
 	phys_addr_t vpci_mw_phy[MAX_MW];
 	void __iomem *vpci_mw_addr[MAX_MW];
 
 	struct delayed_work cmd_handler;
+
+	int msi_virqbase;
 };
 
 #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
@@ -256,10 +260,13 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
-	for (i = 1; i < ntb->db_count; i++) {
-		if (ntb->epf_db[i]) {
-			ntb_db_event(&ntb->ntb, i);
-			ntb->epf_db[i] = 0;
+	if (!ntb->epf_db_phys) {
+		for (i = 1; i < ntb->db_count; i++) {
+			if (ntb->epf_db[i]) {
+				ntb->db |= 1 << (i - 1);
+				ntb_db_event(&ntb->ntb, i);
+				ntb->epf_db[i] = 0;
+			}
 		}
 	}
 
@@ -464,7 +471,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 
 	for (i = 0; i < ntb->db_count; i++) {
 		ntb->reg->db_data[i] = 1 + i;
-		ntb->reg->db_offset[i] = 0;
+		ntb->reg->db_offset[i] = sizeof(u32) * i;
 	}
 
 	return 0;
@@ -517,6 +524,28 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 	return 0;
 }
 
+static int epf_ntb_db_size(struct epf_ntb *ntb)
+{
+	const struct pci_epc_features *epc_features;
+	size_t size = sizeof(u32) * ntb->db_count;
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
  * @ntb: NTB device that facilitates communication between HOST and VHOST
@@ -540,27 +569,26 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
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
+			dev_err(dev, "Failed to allocate doorbell address\n");
+			return -ENOMEM;
+		}
 	}
 
 	ntb->epf_db = mw_addr;
 
-	epf_bar = &ntb->epf->bar[barno];
-
 	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, epf_bar);
 	if (ret) {
 		dev_err(dev, "Doorbell BAR set failed\n");
@@ -719,6 +747,83 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
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
+	if (!desc->msi_index)
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
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
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
+	if (platform_msi_domain_alloc_irqs(&ntb->epf->dev,
+		ntb->db_count,
+		epf_ntb_write_msi_msg)) {
+		dev_err(dev, "Can't allocate MSI, falling back to polling mode\n");
+		return;
+	}
+	dev_info(dev, "Using MSI as doorbell\n");
+
+	for (i = 0; i < ntb->db_count; i++) {
+		virq = msi_get_virq(dev, i);
+		ret = devm_request_irq(dev, virq,
+			       epf_ntb_interrupt_handler, 0,
+			       "pci_epf_vntb", ntb);
+
+		if (ret) {
+			dev_err(dev, "Failed to request doorbell IRQ! Falling back to polling mode");
+			ntb->epf_db_phys = 0;
+			break;
+		}
+
+		if (!i)
+			ntb->msi_virqbase = virq; /* msi start virq number */
+	}
+}
+#else
+static void epf_ntb_epc_msi_init(struct epf_ntb *ntb)
+{
+}
+#endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
 /**
  * epf_ntb_epc_init() - Initialize NTB interface
  * @ntb: NTB device that facilitates communication between HOST and VHOST
@@ -1320,14 +1425,15 @@ static int epf_ntb_bind(struct pci_epf *epf)
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

