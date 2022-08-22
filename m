Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9E359C375
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 17:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiHVPwV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 11:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236826AbiHVPwP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 11:52:15 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAC12A960;
        Mon, 22 Aug 2022 08:52:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdZ11DihJ4sdkkaUeWhIczIEJgE9nnlIHcz9e1U8VHn+XJO3jOyfk1EQH2a3ExAjQ5lQwhRRHjWYgtB2oAmDFQ4IMdMWqBo4XrrjHtLOPyKb4IJi7UX+8Ciei0Ueor11BAKjXIi6alOgAucH4GwTBZL9NvXilvMJU7sPqKqTBizTU6d79OyGp4/zMJiC1ydKzo7Oxhf8f9KUq3UxruL8GK2WTbuosQemuGNTNMgJA0V+YV2hHUWEGjywZgxaVgJjsbtFIUwj30mXgFFAbpARjHxFOoI9gv4OCPaJopp+eaGgYImdRVRd+XameIDGUy4Jo52krOYz9qBpLX6oJXeNTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQXsOmuWXBzf9yYCiCT7zVy4+e+0vl65Kcdrmv8mNtE=;
 b=Nh+6UJ5pd8ToJ9iUYeYCEse0FiTDiyh+PVfI0bS9Tc1nWJnK5E+3Vvi0+w8S1KKo/squ7fEVct/cgL9NGOoFYNYW45yAsoUo6gebAAghIRUSoZa8J6pvEoMjEeuyhRYjcrs5DfHLHaFEJogHIaddvpF6jW7MI2J2sNeNakwOOtGYMUivKnRmPhBin0F5ZGW7NTMeMCyWjEVastCQ3vasK+5JE3eOsimvBieTJofvoOAdw1E2M2jCyA6vHfza/52JrlFHxjhrAKgdRztgzKX5kZLYuSUQ6dCFLF/Skro+BlnG0QoOgzRUHaTyupb1RUNy3Zdkce1uWdSx9zOiHiPaIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQXsOmuWXBzf9yYCiCT7zVy4+e+0vl65Kcdrmv8mNtE=;
 b=ROzW+uBeoEQXYjxwqO9NDAi4nJyrZi2eRadbu63nEIHbP7ARkN7Hfe4l2rAiUMtvcNpvVJq6YlVDufd8IqrKgLhlChpwzYh3MRXXmSN6dX3+Zbaaoq2304i6h8bKr3E+IJMzbM4p8tuo7mel6v3Rvi1iZzSXAnBqzi3YkigO3Co=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM5PR04MB3169.eurprd04.prod.outlook.com (2603:10a6:206:4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 15:52:11 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::85cb:614b:9f52:2dba]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::85cb:614b:9f52:2dba%4]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 15:52:11 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com
Subject: [PATCH v7 4/4] PCI: endpoint: Add NTB MSI support
Date:   Mon, 22 Aug 2022 10:51:30 -0500
Message-Id: <20220822155130.2491006-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220822155130.2491006-1-Frank.Li@nxp.com>
References: <20220822155130.2491006-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::13) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd101fe5-0396-4866-b5cf-08da84564670
X-MS-TrafficTypeDiagnostic: AM5PR04MB3169:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: STQCcIy8v7SceW1nWizJtvE4yfJ24iW7rsciSCyE1df7Hc5sVlUWFVpNZCTRG5pSW+C4saXae7533fhFY3yeIaPijmAriZrT8pP1teKhjKKrmi6hUyN9i9jr+XiWsLmu0F49I3hNoe9wgFh5NRCZpDmd2R7mNCm4s1SJJeRW57lvBp5/rghyYCJc3Y54Pke7FCUw1jgySbjuj03ywlKT3HsAbyq+/jlgC565doyLm8ZRubsqBW4yMUyNAd+YN75K+MD4DuuS4c075w7jwLf8LTWsGp7X62xAnp/CM4tyhwwh/9lVADVvclSfECM9mB3SjMmXXAzLtuHBHn6qswQMhH9Sk+flQAOhCENioh4/OFTU65aBy5rX2hJPtBoEUFOk7RX4V8K0Ezr59HSiZI/uPqs9U2G9JllcO29lEygF/NyU+1RXY6lHPjOxxOz22qCL3WqjyOA+UcEk2lb08KdTTUlA/2xNQU5q6GgKc3bCtjcf3vSDW1YOFU9xHjJe77Zao4lKrZpqq3tWNLG4bIPJ6DZmIUFwwQpFVFDFrLEPl1s1MwsJvqBvqhXWjrC/sl9+vR6hLQK4t8cC89vJ00lOLGwEO1FMPhB+iX6mGIPmIbSVEgwWEBv7WdBvayp+AmVMGjM0w6JqTjExABZ0lt8LaqYUnZ/JUy8TUIEIipWKscyxQ+y/4oiWsArVtTLLZFoa0k13BYMedJDPievWdqtU6X4MV51TMx7jcTvHEoNxHc8jWvANQBavVDkBwvX1Ae44I0htkO+6dGJ9G9NggSXO2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(316002)(86362001)(38100700002)(38350700002)(36756003)(41300700001)(83380400001)(26005)(6506007)(52116002)(6666004)(6486002)(6512007)(478600001)(2906002)(66946007)(66556008)(66476007)(1076003)(8936002)(5660300002)(8676002)(7416002)(2616005)(4326008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHJzc1pqWWJZWHFSVWxUWStzdENIaFIyYzVkSitVTUZGZjdqclZhS3hFWG93?=
 =?utf-8?B?R3JUaDJPRlVTQ291Y2dyWjRkdkdtQ0hKN1QzWGFzKytZK29CWG9qS3VNeWZB?=
 =?utf-8?B?RDM2bXozanVmQlY3OVhFbGQ5bDBWQ01DM2xSb1owTi9QTnpFMkNjM3BRTVVK?=
 =?utf-8?B?UWRaUzZhcWU5Zm55UFFSUFNZWlhCcmxUS3lZSFMyRGdqbHdBQnpGK21ocU1C?=
 =?utf-8?B?WEQvQklCYVQycmNPODRWaFhhRDhyckd5dWRlRHI5SzR6NGVvOHV0b1pZSmRJ?=
 =?utf-8?B?RitSR1BMWmVwSGRReUFtSWpRMWhCV0YzWnRhTVdKanJERzlVaEd3YklLbitG?=
 =?utf-8?B?emZkSVBTd3U0OXljRFJLVnhPMWVYeWVkeEl4aWF5MnlmaXl5SVpyZC9HWEty?=
 =?utf-8?B?WnlnNUJyMkt2anBEdmxFRTdtbnl6eitiaDZxbXpZTlFTbHVtNFhQMExXcFhD?=
 =?utf-8?B?TThGdUxQTHpJL3pESFhJcTBMeTc3T28ydUkwQ1llUVVmVUZpT2wyRzE0Wjln?=
 =?utf-8?B?YlQ0UGlBN29iZ3JvcFVsUWNxSjBLUzJYSGJEc042OFdkamdDZ2Nhd1g4cjRx?=
 =?utf-8?B?TVZXOER3OXp1OHlaQXpPMG00WVZSOFVlZVd4YTNwTnpDdnNhZVNVTVdmTHFt?=
 =?utf-8?B?djJMM0NsbTE5SlIvOWZKV0FXMXRUc1RORkdTY0V5ZUhpYmtBRzVaQUFJVkZ1?=
 =?utf-8?B?dzNzc3dId1BDNy9HSEQ2R2ExaDNZeVNWZE54bnI0VURKVUlkVTA1VFovWTVz?=
 =?utf-8?B?T0dqQThtWFRMWXJRa1ovcDhuZ2JGTUdSNXVuNHE4YkdZcWtLTm5TUFk4MmVH?=
 =?utf-8?B?alJ2NU9hOHZUcjRLNzNpdS9rNDVSTXBsaVd2RlYreDh5QWkrQWR0M2hWKzlz?=
 =?utf-8?B?Z1BReHE5RlYwTU4zRUh4QUUzeFBYYkYrcDcvMEtqZXpEbmlveVd5L09DV3Jl?=
 =?utf-8?B?VGg2Rml4NFI3M29yOHROMS8zZ2x1cllib3EyRGQzRFR5ZU5LNWhDdjRtY0Nn?=
 =?utf-8?B?MnpObEJpMDhuUzNlYmpwRTA2TWgyYXUwcHI0ZHRVWHpDdGt0Zm12L2haL0wy?=
 =?utf-8?B?b0lwS0pBYTJiUjM1NDVBK05LcEhwajFRRW54emZuYm9BcE1SSVFWR0x4NFVi?=
 =?utf-8?B?Q005M2hxNDJPemFzU0xXUHExT01ucXJFeDRmaVJNNTdwVnFWdXkvUjdKQnJW?=
 =?utf-8?B?clF2ZU12WW5rd3djWm16amdIN1B5RG1uZW9iYm5MaWJ4MGx3TnJsOXJIVTFj?=
 =?utf-8?B?QXFYcmJNTytoOXdGRjAyUUlxeGQwV1h6TTM3ZGRqUHdWQUJ3VG10U1kxMkpV?=
 =?utf-8?B?Yy8zNEVHM2xSS3doN3Y2VlkveGpWL3dSNEJ2aWFrc0xLcndkWi9jREFkOGp5?=
 =?utf-8?B?MTRQbzlwbFNtN3ZWTjMvL2ExYUlINURBUEg4VjJXRUhaa0xBdWVyZ2RybWMr?=
 =?utf-8?B?dFRzVUlVa2VOTmt3YW5BciszMnVuZWVDUWhlNXRldURGb3Y0MkJTVnJ6R2dt?=
 =?utf-8?B?bkhwaWNUSlZmRjh2Y1d2eGhjem84NjEyY0JTc253MkYwTXFPRFpnSkdKYnZy?=
 =?utf-8?B?NG5TUDhxMTBnelk5U3Y0Z2p5YTU5SzRPejgxNEFiaEE5YlNLNVZOdFV0MHlJ?=
 =?utf-8?B?NVR2ODRVY2JCaEx2RzY3NTY1Kzdva0hubFMwcWpMZlRNVEZFVkgrQlR0Q2o3?=
 =?utf-8?B?QklXVHREUStTREZuV3NTcnJqNXRnU0dQSHI3R1F4VVVHZ1JCcFZpdTNXRHVo?=
 =?utf-8?B?YUo3NDBHUDhsWHl2VE5yclk1K3hYYlFMQWo1SFJZbVY3YzNrbkZCTjdBUnFh?=
 =?utf-8?B?RjFNdURjV1hNRHZOZXVzUjQ0ZFJ0Yi85cUZiQUJFc1hLb0pzQkdOdFlzaGt0?=
 =?utf-8?B?clNSSWpxN0tnYzJjQ0l3TTg1VnFQT0w4bXRSOHh4SWdKbmc3S0NzeU5kSk8v?=
 =?utf-8?B?U2JHMU0zTHg5cUZVcWc0dktETGF4WkFKREc2Nkc5OTl4VDFWNXRMbDg5YUpB?=
 =?utf-8?B?VmF4Z3BGcUR2NVJVWjdIWFpKc3ZFRFpsOW9UMHZyd0swSW1qNkNjd2M4R1Q4?=
 =?utf-8?B?M1NOOXdMcm5ZMlFHMWM4bEJCaXRVSXNKZDg2NnNrZmdPWlpTWlN2N24vSnhy?=
 =?utf-8?Q?KYhewZwvnh4nHEqtenyV96Vov?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd101fe5-0396-4866-b5cf-08da84564670
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 15:52:11.4410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yf0fKXliTZeQHgMGkL5gof1qFAnPQQcSjzCRhnPAQSshC5toNRNp+pMlvryUEQSsZmhIQmru0alzlPH67wf30w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3169
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

                        ┌───────┐           ┌──────────┐
                        │       │           │          │
      ┌─────────────┐   │       │           │ PCI Host │
      │ MSI         │◄┐ │       │           │          │
      │ Controller  │ │ │       │ MSI Write │          │
      └─────────────┘ └─┼───────┼───────────┼─BAR0     │
                        │ PCI   │           │ BAR1     │
                        │ EP    │           │ BAR2     │
                        │       │           │ BAR3     │
                        │       │           │ BAR4     │
                        │       ├──────────►│          │
                        └───────┘           └──────────┘

Linux supports endpoint functions. PCI RC write BAR<n> space like write
to memory. The EP side can't know memory changed by the host driver.

PCI Spec has not defined a standard method to do that. Only define MSI(x)
to let EP notified RC status change.

The basic idea is to trigger an IRQ when PCI RC writes to a memory
address. That's what MSI controller provided. EP drivers just need to
request a platform MSI interrupt, struct msi_msg *msg will pass down a
memory address and data. EP driver will map such memory address to one of
PCI BAR<n>.  PCI RC writes to such memory to trigger EP side IRQ.

Add MSI support for pci-epf-vntb. Query if system has an MSI controller.
Set up doorbell address according to struct msi_msg.

So PCI RC can write this doorbell address to trigger EP side's IRQ.

If no MSI controller exists, fall back to software polling.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 148 +++++++++++++++---
 1 file changed, 122 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 1466dd1904175..f6e0b682da000 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -44,6 +44,7 @@
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 #include <linux/ntb.h>
+#include <linux/msi.h>
 
 static struct workqueue_struct *kpcintb_workqueue;
 
@@ -143,6 +144,8 @@ struct epf_ntb {
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
+	if (!ntb->epf_db_phy) {
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
+	if (ntb->epf_db_phy) {
+		mw_addr = NULL;
+		epf_bar->phys_addr = ntb->epf_db_phy;
+		epf_bar->barno = barno;
+		epf_bar->size = size;
+	} else {
+		mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
+		if (!mw_addr) {
+			dev_err(dev, "Failed to allocate OB address\n");
+			return -ENOMEM;
+		}
 	}
 
 	ntb->epf_db = mw_addr;
 
-	epf_bar = &ntb->epf->bar[barno];
-
 	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, epf_bar);
 	if (ret) {
 		dev_err(dev, "Doorbell BAR set failed\n");
@@ -704,6 +728,77 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 	return 0;
 }
 
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
+		ntb->epf_db_phy = round_down(addr, size);
+
+	reg->db_offset[desc->msi_index] = addr - ntb->epf_db_phy;
+}
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
+	if (platform_msi_domain_alloc_irqs(&ntb->epf->dev,
+		ntb->db_count,
+		epf_ntb_write_msi_msg)) {
+		dev_info(dev, "Can't allocate MSI, fall back to poll mode\n");
+		return;
+	}
+
+	dev_info(dev, "vntb use MSI as doorbell\n");
+
+	for (i = 0; i < ntb->db_count; i++) {
+		virq = msi_get_virq(dev, i);
+		ret = devm_request_irq(dev, virq,
+			       epf_ntb_interrupt_handler, 0,
+			       "ntb", ntb);
+
+		if (ret) {
+			dev_err(dev, "devm_request_irq() failure, fall back to poll mode\n");
+			ntb->epf_db_phy = 0;
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
@@ -1299,14 +1394,15 @@ static int epf_ntb_bind(struct pci_epf *epf)
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

