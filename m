Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19625B7C9C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 23:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiIMVLd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 17:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiIMVLB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 17:11:01 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80044.outbound.protection.outlook.com [40.107.8.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D33760C1;
        Tue, 13 Sep 2022 14:10:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEmaRp4V+6k0xPtqvcgPh068ClNYlEWBn29I6IXFcG7GVT1xsgDhuCn/gAABaW/s0tAhMizR+VJ3gvztGiHKCG1BsN/ojr3aCWr10dl7tl9qf2VocBZQz0+U6u8NKLLnUagd1ZEI/9gCUmj8+DkZRJw+IUg3ZDV26w0/K3+DRe7CG6/JtfETLpk/jE0hsJHYTJyqk1IlLmi2mX65pWWSG8HqYhJFhIma40yVGRtXcZ4h91EaImD85ihiVIhBQ6IBbj/A0J/FT2qNiZPWEOpnXSKrywtCbFZi98k84CVJF2ifuDm+tKZXa4thfsCT986V8osQ0KmERw63jCSKgQROnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5h9QONj1wM2kOAz9yNa0R0Oclz4E1q1LBoedTWh3DLM=;
 b=L0QV6dni75VS51/lB/iwUi6U4ppi3ZYz20G8y63TwhFkTp5nMxWKzZZ/eT/ISQdgoBnTU9WLAgl90VQXwJ7XupM7WnvJLZORx0Oz3FsDue9V+U2fBphq56XU0qjuilCmx2xT7NdPngBnnswTK4JDy6vpJt1UgP5LAu7XsBaOXpiSwcvMmBqZG3be9+F0eNg3kcVCN2MHs8qrU9inSLxaccUd4jA3RGUjq+3k5ORpuX8P2YklliOWiqOSDhmS2YATunBSzLCNwsVnHj5o5gKR4HJtbHYa2nB7IVHNLtTbB77C7ZLgD0K9BMy2d+XqwWI0Q0qcaCCOsmKLzgFAW26b1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5h9QONj1wM2kOAz9yNa0R0Oclz4E1q1LBoedTWh3DLM=;
 b=G2iROw8jhnalwQOIYm869pT/TOc3TdohO6uIQ+SmbyVriXCe1O0PVQrdnujkuw2njZgfs/RVhOP9eZDuNjsXIqopJqepzqB2wGSNBJ+COdQrJh+9mtmBR4IxbDpPmoAABFW1apx/Kc+zZoccO1fsUPX+o+9bahI98iofrARsJ4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by PAXPR04MB8621.eurprd04.prod.outlook.com (2603:10a6:102:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 21:10:50 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::e5ca:22d0:52e2:15f5]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::e5ca:22d0:52e2:15f5%3]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 21:10:50 +0000
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
Subject: [PATCH v10 6/6] PCI: endpoint: Add vNTB MSI support
Date:   Tue, 13 Sep 2022 16:09:57 -0500
Message-Id: <20220913210957.3493826-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220913210957.3493826-1-Frank.Li@nxp.com>
References: <20220913210957.3493826-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::36) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|PAXPR04MB8621:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fec1a48-2d4c-4a28-4a3b-08da95cc6f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKb6VEPLtddZz5RR9Uc5JF6JRjt1qppZ1Bir162WuFrY26vOqI0P4B8jlcMCgGpj4z+5d8UHkUt7IPML0SBGDsgNMmCE6dycL/ZDN1kOBJh4Kv5RA6hhYImMN5HUtS3zIlYz3VGjuhTomvdQ14tDBAIfpwHDPTL7hrvyZGf3QD3mmaB0Qz79vK+oZC+Q0B8cuPBvG5MgUmvMfYD1oY4dnrrGh4EOAby7dNV6IVSWwj0Ixbd3Z4ZbQ46jqIG60QlH9CeS+xOSBJVUZhXt5JRxeUJv4+bKp6TnG9tQVqdI5/j0bs+9KZYjiNQEbw5+hJInv9W0QMpj92Qwjx4qIIsqtj4e4CtC0mcCeoXpvj7iPIhy46Q+jbv1iPvxlpSeKpeEMOf1uaFGGn5Gkx2hROcYvtGu+0atRB+hRMIND5XYT8wv3mRAbOtOW/cjCIK2Q0YkFTus2q5gmgBFBP4FP53Do1EFm7D/hEi+3up2TAVmlrpMs0Ipd4Ji1fKszLRCBWzbtoM+V16Aj++kR2Nd8u/+rdA31KVqhKx489ea+ViqDgMLxv4hOLO08fdi80uVK8yPlBHytrwYEOSNDX/4d7pKnbtL4Af+BEOgOMSnxMMxv6gF6kNaUsz4N2TiGT7n/lvx8yiWWFTkpgZVBRc33Kaeppw54cuwNn6CbIo4PHApGHIovAq5WrGp16uVHS/SmksNsweluEWdYlDiDd7S4NXOo8f/EQO+E9J5/KA4geuYuzz1l2Hkp4mMKxRDiB7BzLM8cdsZwjw/uq6lnf23IeRChQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199015)(38100700002)(478600001)(316002)(83380400001)(36756003)(8676002)(66556008)(2906002)(26005)(52116002)(2616005)(6486002)(66476007)(66946007)(6512007)(86362001)(6506007)(4326008)(41300700001)(7416002)(38350700002)(8936002)(5660300002)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnBHbXUyQzJZUWNzV3JYelFQRGtQWENjWVlYQVVYSUgxUWFVd21vbDFVcmFM?=
 =?utf-8?B?UHRPTjh5SUNzR293eEZWWVl6OWdxVFgvQXZNZEI5Z1RxSjZkVk5vUTBmeFVL?=
 =?utf-8?B?bFh5bHpjaU5YOXZKbEk5UFM2NVFsNVJIbzd0RWJuLzJXd21rY2E3Nm1iUGJm?=
 =?utf-8?B?Y0F0VTg1QlZ0Q0QreGJuYWN4RDhWaStsZDVYOGxSVUJDeUVZL1JMUDFhc1pG?=
 =?utf-8?B?VjExMHlhdWFzNlc3Q2E1d3N2c2U3NGZzU3JLbkhRK0NHWHJ3WTZGQW9JZTNu?=
 =?utf-8?B?d3pqSTVZMi9Tcm1DdmFuUWloQ3dGVHBWRGJadkNZdTlRMjR2QTFSMFJ4a2ZI?=
 =?utf-8?B?N2ptaWRLQ0ExdUF5TkMzamtHNzNRS1lYZS9Tcy9zTDIxc0c0WEFQNkVWZ3A1?=
 =?utf-8?B?bGdzY1FURExheTZVNDd3NUp5WkdDb2lFUlBmcUY4TjMxSnY1OXhQOFZpSzVV?=
 =?utf-8?B?S2poKy9NU0x3QjIvb3hKQUJ1VFNTK2IwV0Q1T3Z3dFBvY2JVL0JxTzY4MzV6?=
 =?utf-8?B?R0srRUMrY3pKbXVQMDQ3Y0M3eExsQ1BudDM2cnJQaG0wRm10eDdra3Bha1Ry?=
 =?utf-8?B?bEwrc0pWa3NrY2JEbnJJbkY0bEZsVDZNQXc4amN0OUlNKzF0dU5ORGR4NFhK?=
 =?utf-8?B?N2Q1RzRxN2tXY011K1RITG1lYTk3KzV2Zi9kVUx2UnpTbFVoVHRYL2k5bzJ4?=
 =?utf-8?B?Wk1aUnlQTUREZDZEWWxwYTFLS3FWRmRBcUE4RFMxNFRsMGoyOERvQlpYUFRU?=
 =?utf-8?B?YndyaklrcjdxOUtFYWwrb0t3T2w2U0dxMzFVZiswRnNIa3RCYlh0dEltNjd6?=
 =?utf-8?B?ZlBVblhyNHMxT3luVDZKK09JSmNRQk15a3k1V2ZBc0F6NzZ6cmltdVZDRy9I?=
 =?utf-8?B?SmVJRmh6K202dFQ1dXczTUtMMFNxdDlBZjgvUW5SQTlnb1MxOFM0TDV6K1RB?=
 =?utf-8?B?SnhWN2t6Yit5SmE1dmhtblVBS1FzZnFUYzRtZ0tmY29ZOEtRNjA2aFltdkk1?=
 =?utf-8?B?aXRvRGtWaTJlOUFjQnVJK3VEUkR3L3o0SXo5ZUJTeDhBVk1EY2tlVlNSbFJV?=
 =?utf-8?B?MGIwSnZtZWF3MFI0SWNqVWxvUFp0UkJ4SWRMRTdXZkZhalcvNSszSXR6bW9n?=
 =?utf-8?B?eWNaVTN2OS9od2ZTekhYS0J0d0JiTVRZYVFQZGhQRFN4bGN3aVNvN2tZeWNk?=
 =?utf-8?B?VlJzYkphbmowVHBnVFQ5anVJVDJyNHYxZnZudHc5Z2FvUjlaUTdyZkx1S1N4?=
 =?utf-8?B?a2Z6akdEbi9WcisrS0VTNUNKSzJoMDZvWWkzZXJqWE1lTm9aZ2w3d1I2TDVH?=
 =?utf-8?B?NHBETnZiMHNTdW9uVytTejQ2WmF5a01pT1Q0Z2twWmx1ZWxkckZkVGpsdmtU?=
 =?utf-8?B?NWlEK3gycU45WHVpdGt0RUtYc3l1QSt1L3hSV2Z0VU5Eb0VHdEUzS1VYZkdo?=
 =?utf-8?B?UGlwbGxsOUdwT1g1RzVtNVo1NitIVXZ3QmtkbXVhcDFNWk5Bc2N4NTRDUUNS?=
 =?utf-8?B?VEYxbjU1VDhBYllFbXlWYVJqYlpOV3M2OElHU3BHSFZhQ2xwUXpBd1BBOUE4?=
 =?utf-8?B?N1VuR2NVY0hPU21UMGtjaTI0R0I2VFkzSDAxVFJuSDh3RzFNM0pxcEJHazM4?=
 =?utf-8?B?S0UxWENKMHo5eHdzODlvdFV0NlhhM1NnMTNDKzFySEdKLzgxNk1zMFRPOTE4?=
 =?utf-8?B?V1A2djNPUzNnOGtiMXdBcG0vSlRxbFlkWHN4SytaNHFrczBhd3JQZ2I4eUE2?=
 =?utf-8?B?c0xFSmpWUnppRHJ3eDFuMTdETHpzcEJPZWloMVZuUFlMY2tNdGtRVFpsMEs1?=
 =?utf-8?B?Z1F2VnBvZ1ZxVEZGeldGSHNkUUxGdWdEMURJdm84RGVBMVpJalpWRTdNNnZQ?=
 =?utf-8?B?WDFVbVdhaHB5K1h0STJIQkZWK3NVNC9NT3htaUY3ejFxMkdKOEtqWU5LbFha?=
 =?utf-8?B?T0RGRkZUUTYrTU9hWkdjY2lRSHJldHpRbmQ2a09YNjBzSWxRdnJ4UnZLczdE?=
 =?utf-8?B?M3U4YmcvOG5Lek53SUpYTTBkajkwbm4vbHBacTBqdGpzMlV2d1pBeHBxYlZQ?=
 =?utf-8?B?VksySldRYU43d3pCU29rLzNhQUJNUUR6ZHp2WFppVlFJdFdBeVMrc0kyNnlQ?=
 =?utf-8?Q?bu/4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fec1a48-2d4c-4a28-4a3b-08da95cc6f5a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 21:10:50.3539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XO0ncBdrMu4U2VRzHXiw3FfQrI7fYeX5B1v5EryMMuQSdKYTPmizKBqSAbGn55nH03LkTMuMY1dtyFpeems8eA==
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
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 151 +++++++++++++++---
 1 file changed, 128 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 17f030befde52..90271c0394e83 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -44,6 +44,7 @@
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 #include <linux/ntb.h>
+#include <linux/msi.h>
 
 static struct workqueue_struct *kpcintb_workqueue;
 
@@ -138,12 +139,15 @@ struct epf_ntb {
 
 	struct epf_ntb_ctrl *reg;
 
+	phys_addr_t epf_db_phys;
 	void *epf_db;
 
 	phys_addr_t vpci_mw_phy[MAX_MW];
 	void __iomem *vpci_mw_addr[MAX_MW];
 
 	struct delayed_work cmd_handler;
+
+	int msi_virqbase;
 };
 
 #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
@@ -254,10 +258,13 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
-	for (i = 1; i < ntb->db_count; i++) {
-		if (readl_relaxed(ntb->epf_db + i * ENTRY_SIZE)) {
-			ntb_db_event(&ntb->ntb, i);
-			writel(0, ntb->epf_db + i * ENTRY_SIZE);
+	if (!ntb->epf_db_phys) {
+		for (i = 1; i < ntb->db_count; i++) {
+			if (readl_relaxed(ntb->epf_db + i * ENTRY_SIZE)) {
+				ntb->db |= 1 << (i - 1);
+				ntb_db_event(&ntb->ntb, i);
+				writel(0, ntb->epf_db + i * ENTRY_SIZE);
+			}
 		}
 	}
 
@@ -456,7 +463,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 
 	for (i = 0; i < ntb->db_count; i++) {
 		ntb->reg->db_data[i] = 1 + i;
-		ntb->reg->db_offset[i] = 0;
+		ntb->reg->db_offset[i] = ENTRY_SIZE * i;
 	}
 
 	return 0;
@@ -507,6 +514,28 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 	return 0;
 }
 
+static int epf_ntb_db_size(struct epf_ntb *ntb)
+{
+	const struct pci_epc_features *epc_features;
+	size_t size = ENTRY_SIZE * ntb->db_count;
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
@@ -522,33 +551,30 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 	u32 align;
 	int ret;
 
-	size = ENTRY_SIZE * ntb->db_count;
-
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
@@ -704,6 +730,84 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
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
+	return;
+}
+#endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
 /**
  * epf_ntb_epc_init() - Initialize NTB interface
  * @ntb: NTB device that facilitates communication between HOST and vHOST2
@@ -1299,14 +1403,15 @@ static int epf_ntb_bind(struct pci_epf *epf)
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

