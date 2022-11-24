Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6580F6371EC
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 06:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiKXFv3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 00:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiKXFvU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 00:51:20 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2074.outbound.protection.outlook.com [40.107.103.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E3CC7232;
        Wed, 23 Nov 2022 21:51:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mf0ai62fMQU1zjiw4Co+PSgUD2kcbYSs1GTioAg5UyIKDyAkOG/SPl2G3baoKqVUP5EySj3syd71raL6PnrqvZRnkiBEpxRkqHp0OP3Mjgb/30ToLc1K0r5e0QSPOQ1ODzQn9uF76VpzdrfPNR1zH26Vr1Qv5+h3QAwj+1vuarN9kzBFYpwkLxtAYhy3qqT9itG8hRnd2r0clR3wdTIEUt7i7K80FmCtO2CDbYcNU/2JJkiMNyHiXysgg7iDoVGBV1nQOWSq1QSEXfsy9B1WQ/s+NQPp6TEjDaWkVLtP68cad/pVRURerItlZFSZjxEWzNDfiQZMq1N58dHkaxohWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDMBfQeDmKtajEdG5pqZ+Y+nU8gRsCayZGEtRR9MAJM=;
 b=AhEINoks2Ozkn+G0AePT3EePZybuVtN7tXcmKRhPK4n7tu1gm9QHV+mt1mOCZRqXgqP5WYZYPj6t83Tq7X3l7okMVM9KghEz1VqN9mFZKEC/cKOQzRmkD0/hqR0L2NwtE5Ji0ZnJVCU+OCUtT1NktRzTPMrNBOvHhme0CLGUmdHm82ml/RZmqifiT6XAn3jrOzS3Eb1Ep6wHf9M9DRqXOsxGHoqxGOKeB3AFC8AhM9Qk19W7d1q8L05ZkuFIirQCj91zTzTrUtPutDUYaexi8O1Ms6W2ssGUVoh5BDzB2HaH+m/wwwB895Tfeadhjpn3sf3clS/cb1zrJzpiBCF59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDMBfQeDmKtajEdG5pqZ+Y+nU8gRsCayZGEtRR9MAJM=;
 b=ffBrC9C+SRL6jfQZ0RdG4fBeLDPzNOXAfbeAB1VAGc7hYfVq1zs0nYayh9nLkMcxsMYDnRFvEMzNbpuPcxj3E7bIejYL/mBwOrdOsxwJImrtk9c0yhJHyZ2ir6wanv04hheenrNCAjXLUoP3rpY7+dzCOlTQ448Zm10MgXqe3BY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DU2PR04MB8600.eurprd04.prod.outlook.com (2603:10a6:10:2db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Thu, 24 Nov
 2022 05:51:16 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230%12]) with mapi id 15.20.5834.015; Thu, 24 Nov
 2022 05:51:16 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     lpieralisi@kernel.org
Cc:     Frank.Li@nxp.com, aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@ti.com, krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lznuaa@gmail.com,
        manivannan.sadhasivam@linaro.org, maz@kernel.org,
        ntb@lists.linux.dev, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: [PATCH v13 2/2] PCI: endpoint: pci-epf-vntb: using platform MSI as doorbell
Date:   Thu, 24 Nov 2022 00:50:36 -0500
Message-Id: <20221124055036.1630573-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124055036.1630573-1-Frank.Li@nxp.com>
References: <20221124055036.1630573-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:74::20) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DU2PR04MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: a351d714-aa96-4497-96bb-08dacddfe723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CiFnwpvaFTUosLntY7CCgSRX6JBjnVly+cE4eS1SadLmSbjSTXJ0AUAtdhv919dBn7iAGhhLfA/1Cj3GyYUmylilc8tLRG9FEqCQLIlG9rD3DCfckxz968iMFPLEfhQRReZrl9rBMhgNzTcbbcEJLglI+VdbGYVa+sHEVL9LqZyaHUNPbAABk2v52rN5trLQsnIrZ6VrAmf2Z2Yyn3Ubwl4oDZnS/HgiXt83/qZIhOv7YravVTqENXE4wrpXftN71boZXT5hSHqaKP9vqHtNDqALWc5/rPChs5QBnE65Szx0zX/iyw0W4BnqY6M3QPI82rn0sItdn85Acf8zEKVkrOh8uLnSXoS/EwwXofjT2X6SyIoJ/etFUfPW0xbIaID7NOebXBL/yM3ccNJD8KrqUNRPXvmoywlh87XNLeZEjNYzsH6+3cJmiFdUCn2RAeP+2ex7n/EXqo2Ixfro44O6/rCmDPU0lG2wS9hJpt19ouN7zkfS7qNkVIIS4zlB0yL3cH72qvB/PJNmXRL8jxKMI+PSPN9QgTW81jg2QLHqKxm6fh64GGFnlETXDSLGTXPJJ16KoTtrPAqte7gkW27pwdFTKtiQOBCeeJZpfCVcI2rMXlBlTpnMT76NDrhHFVBPS+PXJBmd/Mtxd2CpAMk5kdVwHk/OXKbSOXYa3+jLiyw60AydnXCyfzV+yX9eW9McObKsplYZn+sjxjvNS/tUdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199015)(7416002)(86362001)(38350700002)(4326008)(2906002)(83380400001)(38100700002)(316002)(8936002)(8676002)(66476007)(1076003)(6916009)(2616005)(6486002)(36756003)(478600001)(186003)(6506007)(66946007)(6512007)(5660300002)(66556008)(26005)(6666004)(41300700001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXBnaWhveXV3K2d0Ykh4UUNtVUY4eGFXdFhJOWNvVU9hTHd4ektHZk5SNmZI?=
 =?utf-8?B?Z04xcGdPQkpjNDBtK3lyYS9LWUZLTklheWlkVnBDTDExQ0l3V2R5bEJtVTdJ?=
 =?utf-8?B?NDdWTlBDVUpDdTF6VTZoeWJVbDh5ZDh1TmgwV0ZLNGxFZ2JndEQ4bzVaZzls?=
 =?utf-8?B?U01LK21NNnM1REVSYURRU1REeE01WVQ3bU9lTURCck9WczYvaDZaTE0zbEFu?=
 =?utf-8?B?aVNRZyt0RmVROHEvU3lTdi9IUDFhSDhmT3owdjV3cUZGYllZUzh2NVBDVnVB?=
 =?utf-8?B?S09ELzNpNkl6SnhSczQvVXZmZlZ3QWlCMkh6Zm93VzB1bVJ4aDA2VHdyakIz?=
 =?utf-8?B?TXE0WVNua0MwT3FORjcyczVMSDh2VU1GcTFHa3RpakJRejhLcXpIcDcyQklG?=
 =?utf-8?B?RWRxd3dSRUJZcXEwS21CUDFYRVFPYWxsTWduUVA1TkdPY0ZpaGNIWG1SVnpB?=
 =?utf-8?B?NXc5VzNkR1FTOUN2MVZWTkhENElad0NldHNCU0oydlNadnJRbjRKemxNLzFx?=
 =?utf-8?B?NE45REpXdTlQdDlwU1YvQ2FRRTl6ZzlaOS9PQ2tiYXZkMWxsR1dseVJCQmNx?=
 =?utf-8?B?eU5CRlRZTHA5dk9wNWh1SThXaHRiRWc3THN1TDhScngrbE4wVGhReHFNTTBM?=
 =?utf-8?B?aUVmVWgzMWtrM3ZzZFRzbXpabi92U2pWSm4xb0lwRC9GWWJsTmZUTHhIVkF5?=
 =?utf-8?B?UWl1ZW9ndEJ6RWd4Rk9aSG41L29kTitUZ0ZzV0h5YnlDa2htZG5IMlJBakQ0?=
 =?utf-8?B?emxUTmFjb1I2L1VrUWdCbDIzT0dxempRUk45ck9uK1BJMkdRUG51eGh3WXlL?=
 =?utf-8?B?QjlGNVF6REgzdGRITUE1U2o4K1FRQ20rNEptWkREUGxKWUdvZzR6UWZEakE0?=
 =?utf-8?B?SDA0TFFSS2ovSm1QelR5NXZwakZDYzR3T0dnL04rdmVRMWxVRzEyUDMwQ2k1?=
 =?utf-8?B?amVzd2I4bUNvazhudEVZMFhqVExpVEdEaFRwRnY1aHZ1REZ1T20vTjhsMFU5?=
 =?utf-8?B?K0dNNkd5V1pOTmErTmNhTXRTMituTTBRNkRSL1BLdkpJbFIwdWU0cXVZVGla?=
 =?utf-8?B?MXdaeEN4d1M3eVpEYS94dmpCbXRncW5UTnNUTnRyRXFyblpQK25ja3lCREUv?=
 =?utf-8?B?Wlo0NG1wT2tJYkl5cGRkekdzY1RYRFNESGVsVGhKdTJsYktUSWY5U2o3dWVl?=
 =?utf-8?B?dXBoalpUSGJpdU85Wm51cnk4N3hyZ29FQjBONXJ6M2lSR3BObjNuQkZBZExr?=
 =?utf-8?B?ckZXckhqeHpxYWpXbjdvWVpPZ3drTUxWTEUveVlpcmxHT09sTzlWeU5nMXNw?=
 =?utf-8?B?UkdkSG1yUVlBaGl1UlZRaWJSUks1eFU4OUNhR2g0OHhlYi9YWTFDT0cxaHIy?=
 =?utf-8?B?TUoxbDdzbjhaNzJzZEdRdVJLelFidmxxV01QZ0x5TmU2NGNSY1BHNEYwZkZs?=
 =?utf-8?B?NHllVGYxclg5OE9ad2wya21odjVQOHlHcFNmLytiam9KTnc3UG1nOWxYRVJo?=
 =?utf-8?B?aklObkNvN3BxSFlIM1FPYTcxTC85aFBRS3ppN3AyVFJOOG43RHF3aktTU2cv?=
 =?utf-8?B?RitPWnVFdXpyZFZYNER6U2NjbXRON1J6Y2tGL256MklBRWdQcFNsNDJGU3F4?=
 =?utf-8?B?U3BvVFlKNUNOWnowNjlaK2ovNEdFVlpJWHVTenRvUWtqMWM2NUNnRjBRelBI?=
 =?utf-8?B?TlB4aE0rcHJUYTh6aDFidThkYmxvS0x5OFd3TVRiUWpFTmdTN1RTcDRTM3E2?=
 =?utf-8?B?a2t3WHVxazBqbk1ieGlITU5sQW5UUTY4c0t4b1I2Tlc4MFZ6dE84eittdlls?=
 =?utf-8?B?U1FKY3NjcklhYk4yc3kwZGtadlhJZjFMVDRSMldHVldRbElNZUNyQkpnS3lp?=
 =?utf-8?B?anZSSVlaOTBBTWtQM045RzFDSDBMbDlkVG1BZ21xV3V2MDR2Y2YvS0F4bytu?=
 =?utf-8?B?YXpRTDhtYVlEUDB6MEx0MDl3bEM1Nm4wVG1SR28rbmZxZUNOam8xc3c1aFVP?=
 =?utf-8?B?TUYyVmd6NDdnYnl2cnRDb3ZIWXFzVTRGallDVE1ZdlpUSy95YktsR0JzenJy?=
 =?utf-8?B?K25laWZ5UTI0R0daYUUzNXB3N0ZkSGE1VkFqSGRSVG9GOEJZWnEvQ2RTRnh1?=
 =?utf-8?Q?D6gQeMu4pZleB4y8ET3a4a3iX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a351d714-aa96-4497-96bb-08dacddfe723
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 05:51:16.7491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51LwNqmToItrL32oWXZOoX2Al9KJzPvMu3YB/adWukbOYT70t2j+ecjPWXK1+bCbliqGE+vvk3q3VdqPyU+uog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
│            │   │                                   │   │                │
│            │   │ PCI Endpoint                      │   │ PCI Host       │
│            │   │                                   │   │                │
│            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
│            │   │                                   │   │                │
│ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
│ Controller │   │   update doorbell register address│   │                │
│            │   │   for BAR                         │   │                │
│            │   │                                   │   │ 3. Write BAR<n>│
│            │◄──┼───────────────────────────────────┼───┤                │
│            │   │                                   │   │                │
│            ├──►│ 4.Irq Handle                      │   │                │
│            │   │                                   │   │                │
│            │   │                                   │   │                │
└────────────┘   └───────────────────────────────────┘   └────────────────┘

Using platform MSI interrupt controller as endpoint(EP)'s doorbell.

The memory assigned for BAR region by the PCI host is mapped to the
message address of platform msi interrupt controller in PCI Endpoint.
Such that, whenever the PCI host writes to the BAR region, it will
trigger an IRQ in the EP.

Basic working follow as
1. EP function driver call platform_msi_domain_alloc_irqs() alloc a
MSI irq from MSI controller with call back function write_msi_msg();
2. write_msg_msg will config BAR and map to address defined in msi_msg;
3. Host side trigger an IRQ at Endpoint by write to BAR region.

Add MSI doorbell support for pci-epf-vntb. Query if system has an MSI
controller. Set up doorbell address according to struct msi_msg.

So PCI host can write this doorbell address to trigger EP side's IRQ.

If no MSI controller exists, fall back to software polling.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 146 +++++++++++++++---
 1 file changed, 125 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 0d744975f815..f770a068e58c 100644
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
@@ -256,11 +260,13 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
-	for (i = 1; i < ntb->db_count; i++) {
-		if (ntb->epf_db[i]) {
-			ntb->db |= 1 << (i - 1);
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
 
@@ -518,6 +524,28 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
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
@@ -539,27 +567,26 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
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
@@ -728,6 +755,82 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 	return 0;
 }
 
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
+	if (platform_msi_domain_alloc_irqs(&ntb->epf->dev,
+		ntb->db_count,
+		epf_ntb_write_msi_msg)) {
+		dev_err(dev, "Can't allocate MSI, falling back to polling mode\n");
+		return;
+	}
+	dev_dbg(dev, "Using MSI as doorbell\n");
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
+			platform_msi_domain_free_irqs(&ntb->epf->dev);
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
@@ -1336,14 +1439,15 @@ static int epf_ntb_bind(struct pci_epf *epf)
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
2.34.1

