Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056D75AFACD
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 05:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiIGDtp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 23:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiIGDtn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 23:49:43 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60057.outbound.protection.outlook.com [40.107.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8562713F05;
        Tue,  6 Sep 2022 20:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkljXKNRjXIdwrYclky8NAdEFhph9Vk56Eecj+fZdS6DH+nMrSRwnfASVwucbvgDT2A4JNyVVLBDLPls/kJSM+uS7xxIPg+sxfL4deeqbdyHWZu5rP8aGKX+PJ6tDzsxln+WAsbn/gW5776zyrCs2UaO2rSgSLSqt9CI8u+qfz70LSf4W59D3ZDfi3J4rHdOktFXm9HbH3Hm3UdcvtN1s9zKS3LRfPHMr3bqq7IksWmn2+La9J9+Wgy8e3c/vyLd2DuSS5d2TW5WE9Pt+5Cv6a8tvzMkP2VEK7Qj5RwKhhoq/D0WHvUgc+4QTzZwjt8lh8ruGUSAbw1gYM2inlv4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luNuA87ZdAV700jTSvPtoctsb3rd8ltqs7Sjx4ZnBbs=;
 b=P+BuxFVMr4A+xNuXw/q3VkLb2DA+FqC2ENevFcQcA6QUaL6wZ58Pye2J0bhg8IACb90lY+5y9wCCkGW98kE5wG68qVn9AAUbQuEnHAbj05+24id/7DMALbYZrsGJhPzdIp+7shbs1IqT3/ADfLLj6h4BoKCh7GXQfzXWqjvh2mkbf+t6nxAjr/ggt11K1EzrtvCkCI9DO3Rwt0YvGensi+gC2m6m9xxg+jrMaILyN7S63RnAXIlCf27zzjV234umhTYtq6+PCNU43NOrO+8Vubqv7wJVfywFxb9mCdzecaJeq1CYmpZoPed7YkEnabfz/xtv46FOaJWd/OhjyCx46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luNuA87ZdAV700jTSvPtoctsb3rd8ltqs7Sjx4ZnBbs=;
 b=o3gipIqWl8liCxzF6m2AKVJ+UdUonDySIsou1bh1ncvWKSZTPBe/QSBTPSPBtJxgKkjMLLf+KeMyF198ghTB+K/g+O2JUOp5BcgpTeeIciWw2o1CxEE2wxhKDdnSubX9a7WzkVOo/bixKBhtZbSu0Za4FYYLE9q+OXRrutCsp5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by DB7PR04MB4970.eurprd04.prod.outlook.com (2603:10a6:10:13::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Wed, 7 Sep
 2022 03:49:38 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb%9]) with mapi id 15.20.5612.012; Wed, 7 Sep 2022
 03:49:38 +0000
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
Subject: [PATCH v9 4/4] PCI: endpoint: Add vNTB MSI support
Date:   Tue,  6 Sep 2022 22:48:56 -0500
Message-Id: <20220907034856.3101570-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220907034856.3101570-1-Frank.Li@nxp.com>
References: <20220907034856.3101570-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:a03:217::14) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|DB7PR04MB4970:EE_
X-MS-Office365-Filtering-Correlation-Id: a2cf3b95-a5c3-408e-8613-08da9083fcb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cht3AwCiBRY7UPgt40QhIkjdgXHSvtAo/nMJGbRXM1PF+3X2cxn3cH9nl3jNWFzv1P5FhzttK5yLL3Rl3IB8tAwjePUNRAVIc3hvlt9e5xV2MqwwpmatkxnU2n1fxoFkBfP3AJVc3uA1Gr2rON3pFJHHuopRo48Q08PK72qhzPpys1PC5iYR4C/bNabfA3wPRLqIGdteuUgDxJwI8oZY5D1xCeiY4E+5qFKV/aqSNQEVRYbfFs/1eUSwWi6Mmi/OgI7CqadMcE/xaD7tW6s8iiDztLvbpUpgGlWOAqbSvu2WYTo/QkxP15vMxCgihwU1OsDarnCiOeYaHPTW4QZarjJDSxrtI4IGGr+SIzws8pQ+pHePoD2l1jMzrcyQQm7wxqY1sJaH76PGcN9tpgwZ5G/CoBEEIZnYLPgvrw1XkbZHZvvlWwk38VpaYntfLNi0Lx+7iCQ0qjXfbMksmnFAH3Ii+DaE/BXXxMeS02KFw1gRJkFQigmlCCVaIaii6npAZel+ny1+JEshaWA4hQ7dDnbOTxWdEXOEyB6aOML90TVRKAD/uwcNReHe+gg+xrsJLKZ5lBE5agcLRLkDrr0RxjZH4FfxUjAXTazXXIG6OZSg4JBcv5Bt7n/eGz39cYgeog0f1tw70Ke+Ke65SLVE8xWExm7MqAolxL9WDegl4mt8qxKuEQhnnKb2QUv6ZjXk7+T5vO/aaQ5knUr+th969t2sy3Gior7jtpw6grqK9FXysHFUun4WfTDIFWd4bNBTCBzXuLIXRCKKWyOhd3vg/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(186003)(478600001)(2616005)(1076003)(66946007)(83380400001)(8676002)(4326008)(66556008)(66476007)(6506007)(36756003)(52116002)(41300700001)(26005)(6666004)(6486002)(6512007)(7416002)(86362001)(38350700002)(8936002)(5660300002)(2906002)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm4vSWxjRlVlcy9xRlA2NWEvM1dOZUVlQ1FoK01qYUFMTUtEYnYzOHdjczI5?=
 =?utf-8?B?aFJGQWsvclVIUWxnVkVKaUFWVUQ1aUlCYVhmTVcwQWU0K3lUVG9wNlhYTUN0?=
 =?utf-8?B?UWVPTm1OMFNmM2JiczFMeUpCRVBNc1J2dEduaktLV2RZQ2V4Sk13QTdFVG1J?=
 =?utf-8?B?dVB1RGZSbXZvMVQ2M1dqN0MyOTBOeDYyeVdjcTJqYWRTVG5QV1djay9TUjMy?=
 =?utf-8?B?WHY4V1hPd2k2bko4MHN0aFN1NmI3dzlZaHhMaUJZT2J0ZDgvbWdRYWplc1hL?=
 =?utf-8?B?NUJ1Sjc0TEVYMDBJdDNiSmxsQ2VMQzZHc2pob2lvaEJpd0JrQVh6VWcwN0Q0?=
 =?utf-8?B?YWZ5aUFMS2hIYXYrZ0c0Ris0cENqanp1ZzJ6d21WVjE5RG5QTTJJalBSeEVC?=
 =?utf-8?B?VCtRNHB2MHc1NTBMaTdlZ1BSWHpXb1RXb1dwUS9PQUx4Y3UycElOMXczSDhD?=
 =?utf-8?B?Z2Q2QkZyMng4c1ZsZnppTklLQjNoZnZNR3dZVm9DRlludkJQOW91elZ5QTM2?=
 =?utf-8?B?VjN5MEt2WmozUUtzZ282V1REQUVwYTJER2lqSzlHVU9uRUxTNGxBbTQzb1k3?=
 =?utf-8?B?WWY3Q0FzMzYrbnZzQUE1RkhyM0tBSGVMQ2hTVlZBUXBaMlVwajJHK2ZPZnJk?=
 =?utf-8?B?d2lJTHNlRDduQVBiN0l3WVhnMlVUbVpmSEo2b2ZYT2NnY2tIWC9oNjhLSjVH?=
 =?utf-8?B?dU42aC8yTXU4VUYxYXdVcnk5bHNXNkdBYmQ5dFZLMEovUkhZclRnL1NRcFdE?=
 =?utf-8?B?Zlc1Tms5WG9HZHdYbXlkSGRnbzhMYlllVndWTlloanF3VjZ3dDVWelBlQVBZ?=
 =?utf-8?B?S3NhQ3lvdS9VLzQraDNRdjZjUEgySDBVUWs2eEQvUlhSRGh1S0gxUy8xRXlh?=
 =?utf-8?B?MXFUU29HdWRGRWlDMGdVcHFzVVYrWk5RNFFWa210d3prcDMvcE9xck56Um1y?=
 =?utf-8?B?K2p3ZFZLa09NaWRzMnFYcVBsMDhRSEZyaFdBaEJnR0p5dXZSMVlYaitYZmtG?=
 =?utf-8?B?MmNYdGx5VVRUdGZjYVRIWUppRGxJZ1NnNE9aYUZRaTgwcUdrRFcrcGo1bFp0?=
 =?utf-8?B?Mm9XQURYNWkrNUdEQmhhakduYXlNczFKK201QTFUeFlGTzB1MStjUnhPUzhh?=
 =?utf-8?B?RU54RzlvWHhXamhIZkZaRGpKbEdrb1BqbzA3Z1RoUjBZSzRuQ3QvbEtXOFN4?=
 =?utf-8?B?TG1aRkJJb25HdElyeS9XZHJMTWVpZHlYVkhkK241NDR3d2pNeG4zOWtBbTRH?=
 =?utf-8?B?d3ZzQTArakNUeG1uZ21wS2ladGpWaExzVzZFWlUralBMWjFjRHE1VmhPMFlR?=
 =?utf-8?B?NVBwdmxLd3U5Y0dYYmx4NmxXaEVIVUtLSzdiclE5eTZ0UkFXYnBjbDh6V2NK?=
 =?utf-8?B?MFpDcno2OUpFelM4dHZlMFZFSHZ5STJVNTc5THpibXRINHlJTmMzd0VTb3Q1?=
 =?utf-8?B?cG9zUW9MUUpGNVZmU2R1VTdYcldmR2tvQ0hhbVEralFnVU5ZZmxZcGRJMStJ?=
 =?utf-8?B?RHkyVWFBOUtoM1hqQmFXbkcvN1BHWGgwdURMMTgzb2MzNXYrOW54dDNWbFU3?=
 =?utf-8?B?T2dHVytnQTlhb2IrZzJsMTlJUkcrb1F6QWVvY3hLeDM1M3BNbmIwMU9aQjhK?=
 =?utf-8?B?NXFGeEx0MWcvNThzVWlVVnIrMWpKS0FIa24yZUZvTlk4ZWp4U3N0WVBGTmlD?=
 =?utf-8?B?bUtMS01HbTFWaVhrU2FSVlZRbWFxQ1NBT3VWRFpKcmV0WEhFVWJneVJJSHdp?=
 =?utf-8?B?UDhSb3BCTXdLL2JQMEIvUVUvT2VXc3pOMit0b2NWeTR1Y3U4ckFlN3JBeHNx?=
 =?utf-8?B?MU1IYndmR0ZMeEZRdnJhWkM3bkNpT2ovQ1pmcTFqS0o0TFhvd2VDNUhpWlNY?=
 =?utf-8?B?VExJd1V4NG9ZaUErL0FxUWllVkZkcWxLVXFxb0RxbGhPN2ljK2VQL011ZFUv?=
 =?utf-8?B?bEUrQlZ3SFYvZEM4bkZuTkpOQW1Sd1d0WHF6L1BrUDE1ZStHRGlCQk45M05Y?=
 =?utf-8?B?c3M4QUNOTnUwRkYweGIrY2ErWmI1bVhCcTQvWWVEK1lraTNDQW81RWt0WEpt?=
 =?utf-8?B?WjhMSnZPV0x3TUpHcTQzSVMxbTNaaVRkc0pneWhuT05aa1dwOXFyZDZGTXhC?=
 =?utf-8?Q?TbHhX31QUZuOrG2nsvb/42KyJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cf3b95-a5c3-408e-8613-08da9083fcb3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 03:49:38.2960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHGN81tG3vZ1I0yfbjLz9uXdFKlK5d7YAb4tae/dWS6KBuii8+NeiR/+7BeXi8taNt2bZ1ia7Ti31Arb1G/ugg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4970
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

