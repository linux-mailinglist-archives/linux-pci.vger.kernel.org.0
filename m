Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EED639045
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 20:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiKYT2D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Nov 2022 14:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKYT2C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2022 14:28:02 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2089.outbound.protection.outlook.com [40.107.103.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3890310FFE;
        Fri, 25 Nov 2022 11:27:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blDIRK3t6kmr7ybpwxOteYYAUzoBPbKANO/9XpkQP1igu7rIrjSufZj2IECggZW9EB+voNRxgPIgO7nU++4N5StXPq8WFpv1XsNL3d8qjFij8GQvpSdxJK83XasOJf/iCl7OJIc0N+Dr65LLLDUfl5i4XjZBYQyx5nELA6wwnF59NoPYsT0VMmINx41PCwVX4SC0fFogZoyfQz1qY6Yg25cZU6lPX5/9Abz31OzyRvCnauzU0dKXNt3bCFPKPrdnHzMAFiqWX+N6fb/kl+beymfSvlXRaHtFCKgiyubt62+W7wpGNNfegNPe3pvoQ2MqRyissA0NR+DWrR4wUQiFxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BliD91rB6b9DIOFaM02UGefXcW/ZvXEgr7HFbQOCd10=;
 b=Z+ixKBE20hyI7X4FCAtLhYMGJP4RZ7iXZTZ6txTAvEkcNmv2veEiP4hG1zM9ZeoErIULHctlMI2s2Ff/JwOTYLo+j/4v9zisuoYBig0J6ZzLXOI8YQNyXSKGK46AAL8l5V8BGhPsJA/tIXu1G/1fAHTUBUej7k6W42pIZ1S97Q+OhKn3NBermIkMOV3H+6Ho6X8LOmfV85dugoml2iqFiuHoE+HteI62DMUaBJhunvARK7LFEFNvQNjKYhEVLyM0E7Wv78eF6VFfcIfuR2uvq9J1SFlVZPmV1SQW7anT8hhumeX7vd8p5OyC+V2pAsfpK9f55/9GauBsF7XV/ykdXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BliD91rB6b9DIOFaM02UGefXcW/ZvXEgr7HFbQOCd10=;
 b=Ns9WztJulB7pOwQTGA8ALfM6AI1gWIi8P/mOzVh2Re9EcZXzV1l6NjSpR7tKMMIJfgT4VK+YBhBQinlRmwBE2kUyX/2581ZVE+6/0SAcr8xvnJaGK/0LETUw9792f7uCfjesSSc7/0Ull3SpElwJ/jENnnyqjWcwAmLHhMH1Krw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AS4PR04MB9410.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 19:27:55 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230%12]) with mapi id 15.20.5834.015; Fri, 25 Nov
 2022 19:27:55 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     lpieralisi@kernel.org
Cc:     Frank.Li@nxp.com, aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, manivannan.sadhasivam@linaro.org,
        maz@kernel.org, ntb@lists.linux.dev, peng.fan@nxp.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
        tglx@linutronix.de
Subject: [PATCH v14 1/1] PCI: endpoint: pci-epf-vntb: Use EP MSI controller to handle DB from host
Date:   Fri, 25 Nov 2022 14:27:29 -0500
Message-Id: <20221125192729.1722913-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0025.prod.exchangelabs.com (2603:10b6:a02:80::38)
 To HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|AS4PR04MB9410:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ee6650-716d-4d88-d94a-08dacf1b25b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zt2TtSYpJK4SrCkBnAjmhjQYvqCty1g4k9WGr1PHFqXPhURW/M6TBpFiU8BK5Hn59ie2fpQHwkBNjjgBzZ158VvM4XyPakceLQ85vs+n33Szi6Ln7ayGGz8vxZOnj0rxtX99mtFNH7n2RLSQCzfWxJZ4R8gVP2eN48NKKWwZr6FvKhnV48O44Os8r8TB10rjfgPKgTIm5REFssCkTbkDOCuMtyXkIZpcFw5l8QpY24dNuTt1nOm1Igte78j0aVXe0x7rUqxrzegi6djufGXSr3sEZQ8NstUcJ40sBTA7HqXeSDUja2EHVjp/WSKIiGc5czD5xcH8spbWdUJdSRLyOiaLt4JbwPGitJ3pqHEpFvHI4qf8ybODQobZaXZOO6eq/o5rRTz2I3Ds8p/R4CaiivNzw1ApfvCcPZhUpwtKN4itcX1UGrEPwhsuuc6kYjUYd+nUUboNgSJ31aGsH/I3RBLU2Pauv+9+cYFcKn6N9BXLMcqbvGa8Ay59N2G3Eo+w8rxN/Dlogmmd0gjuFPX4WM938j7vD5wz330J/2O9rqWOxY52HncMzOmT0N4zbZTeoVAibbTHdsidWd+shUuj4AgoPRk9K8rRy2kzXVmZOQJ5msM8hOewz9DCkruWjsaALDJPPQXOC5rJPoQSY9YYeVauRb0+sbJBDPSbmqcWGnwhK1sojY3s+PPe6reqQp+gQxbeA4PUg13gCMXgWppb+osBVr9+ft+WYn5+SboY7BbEJNPtIKr8uTmqqYPJa6oA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199015)(2616005)(1076003)(186003)(52116002)(36756003)(5660300002)(6666004)(7416002)(41300700001)(26005)(6512007)(6506007)(6916009)(316002)(86362001)(478600001)(66476007)(8676002)(66556008)(6486002)(966005)(4326008)(66946007)(38350700002)(38100700002)(8936002)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGJPVWc0eWFTUVh5VzUweU45OUNzMXZsdEt3cnprYXdSL05kRUZ0YXg3T3Jm?=
 =?utf-8?B?TVBBUTNyc0dIbWlCTFZnWmgzdFRSYURuL0p0RHlOeFZBWkppU25uOWJDbzg4?=
 =?utf-8?B?UHFtVFVxR1FxeVFDb2NSYWsvQ29BaWZlU0ozNzl4RFZBeGVFdGZsYTdnVW5t?=
 =?utf-8?B?S0V6RTBpZnRpNERFY2w1QnQxUXNjQ1d0ZGdhSWFHQld2aFA1TnQ2Lys2WmJ2?=
 =?utf-8?B?SWtPVXJKMlZPcmFiYXpTdjN4UXB6SU9idVhmdVlBZXpwZkRWUkdBTVNXNzlR?=
 =?utf-8?B?NlR1Rzk0b1M1QXdYTHdRblFDVmEzVEZaTEsrMGRoakQwdFZoalAweFBmRDM3?=
 =?utf-8?B?ZmdDb0hUNGNRZTdTTS9yZXZ3NmxmZzVMNko3ZGRrd3ZSdFNzN1krUnJPUmM4?=
 =?utf-8?B?Y1Z5UUx1MENMTXRlaW4rZWFJaW11aWxrUlZsdXZHanhnYWFRQkdrczBOeWxC?=
 =?utf-8?B?RGJybitYSjc2Q1V4ZkFrYmdQVHhlckdWTkhDZk5rdHVZcVVOVDlLc3hNTERB?=
 =?utf-8?B?enF0Q0VRbFgyN25SNTBOTDV5VWthUmU1UGNOQkxxaXJpVjk1eGlHYVd1aXVT?=
 =?utf-8?B?Sm0wOG82djg5VldMd1VVQUxWY2wvellmNE5XZFhqakdrYWhKRjVoamFiNE9U?=
 =?utf-8?B?YnMxSmEzbThGM0J3TmJ6cG9ETlB2ZXpwR1lpMnBZMHhndms3R2JWb09mWkkz?=
 =?utf-8?B?cFBXVjNlZnNiTFdJdHpRUU9TZGNVS1o4S3RGYVZwdFVNZHkzL1Y4YTdCUEpD?=
 =?utf-8?B?OHBUajc4cm11SkZ0S1ozQlZWQkhuL1JaY2RGRmU0NWZtaEdLMW1wQ3hna3NQ?=
 =?utf-8?B?U1J1MWhkdE1BQUtTREdGbEJUY1lpa0M0eS9uTEc2bjFYQ04yaTJFUUtxNkJ6?=
 =?utf-8?B?emNoNmZENlAzTlowUFlnK0I3OHBjdDNKZG90NFZaejh2Y1lmOEdHNEV1L0lN?=
 =?utf-8?B?UWR0U01JRlYwOGhCU0c2Nmg3NHhGcXlZMGM4QzMxR3NCd3lHeTZxZXAxRUYx?=
 =?utf-8?B?RzRIOGpNNHlNVXFNdkQzSisyZ041QVNvL0RTbG8wZ1loUnp3ZTdZZUVHcmhp?=
 =?utf-8?B?WEtGZldhRzZPdHpKclpMWmFRVUIxRXdwSndBeDR6QUptb0paRGFUM24vbFg2?=
 =?utf-8?B?ZERxclZxVnhnVG14U1oyZ2dRMTY3RWE5aU1nNXVWTzBFcUxGd3FrYmp2bVRm?=
 =?utf-8?B?SWJLUFZ6NFlDaDhPVVNLdkx6Z1ROTXdvOUhVWDAvYWRHUUlTU1NleGwyT0lC?=
 =?utf-8?B?dHdxSzNFcGxqenQ5bUdVTmhyTTU0M2xqdXE5NnhHREJSR1d2dzRod1E4d0Zp?=
 =?utf-8?B?TTRWN21FMWpRR09HN0FLQnZYckc3dlpQZlVkOGprZlBHa2kyWWdscXBlTm1x?=
 =?utf-8?B?OVhmay9Ld2xuMHJvVHJFNm5TZy8xWWo0YkR4NTY0SkxsenAzMGU2MWpDNlVU?=
 =?utf-8?B?RHp3UjluTE5XQ1dnaWZOSTd3cVBLTUNZb2tOMi9lbWNHN2hIRnlBeXVHN1ND?=
 =?utf-8?B?VTVJQ3BZcUlDV3hQWlhCQ1kxd1hoWWZnVW9vYTRzaWgrSkQvWHYvUTZBaGxn?=
 =?utf-8?B?NHpiTFUvTHB1Zys4ZHowZWFCWGFhcUYwNmtKcStHRnVFQXJ4T2VLc0QxbUQr?=
 =?utf-8?B?dWpkZUd0U1FMTGw1cStISTQ1cDVIMHEyZWZCb3ZsdXBuTFFXU1BRSFgyMGRQ?=
 =?utf-8?B?RWVqNStNOVgwdi95TWU4N1ZJdUdmbVR4Wk5yTFZBdWFpenZWNkFWSnE5OUkv?=
 =?utf-8?B?dGdyd3dMTXlJMHl4VUUxalVKREg5S3VXQytnbTJRVzBMMS9BckRVdUovV0Js?=
 =?utf-8?B?MHUzKzdrVEs3REJjanNIdlY5QkRUemNEa1RDVU54YlZqdjZ6aE1Cc05mekN2?=
 =?utf-8?B?QTJiRHN2QVcxeUZicWx4REJTQkpXMCtoemU2Q1hDeUFOWmZDazg0R3VsdHlv?=
 =?utf-8?B?VnFCMkQ3YzM0VkEzelZYRWl4NG5ZbWwzeS9YQTRha3RSdFNLMEVrbDNMcVN4?=
 =?utf-8?B?bjF2WmtZNzQ0T2RzaisvWDRIWU1RdEF3Znk3R0ZoOWtJQWZDdjRpVnJVbTlz?=
 =?utf-8?B?MzlJSHN0KzNUNnZTamY2aS9LQmE3Qlkxb05CQjlkVlh0dG9vVXNmQjZKbUlz?=
 =?utf-8?Q?7VN4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ee6650-716d-4d88-d94a-08dacf1b25b8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 19:27:55.3253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KR1gLCSpJLHgWRbqMiXkHCxP5NhsOxe6Wo4HoOqB+eqnl+lYb/7tvJ+YalhxoZagoq5w/QKdoIhDG17MO1xMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9410
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
│            │   │ PCI Endpoint(EP)                  │   │ PCI Host       │
│            │   │                                   │   │                │
│            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
│            │   │                                   │   │                │
│ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR[DB]        │
│ Controller │   │   update doorbell(DB) register    │   │                │
│            │   │   address for BAR                 │   │                │
│            │   │                                   │   │ 3.Write BAR[DB]│
│            │◄──┼───────────────────────────────────┼───┤                │
│            │   │                                   │   │                │
│            ├──►│ 4.Irq Handle                      │   │                │
│            │   │                                   │   │                │
│            │   │                                   │   │                │
└────────────┘   └───────────────────────────────────┘   └────────────────┘

Add DB support to pci-epf-vntb function driver making use of the platform
MSI controller. If the MSI controller is not available, fallback to the
polling method.

The memory assigned for DB BAR region by the PCI host is mapped to the
message address of platform MSI interrupt controller in PCI EP. Such that,
whenever the PCI host writes to the DB BAR region, it will trigger an IRQ
in the EP.

Work flow is
1. pci-epf-vntb function driver calls platform_msi_domain_alloc_irqs() to
allocate MSI's irq from the platform MSI controller.
2. The epf_ntb_write_msi_msg() passed as a callback will write the offset
of the MSI controller's MSI address dedicated for each MSI to the doorbell
register db_offset and also writes the MSI data to db_data register in the
CTRL BAR region.
3. Finally,the host can trigger doorbell by reading the offset of the
doorbell from db_offset register and writing the data read from db_data
register in CTRL BAR region to the computed address in the DB BAR region.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

This patch continue https://lore.kernel.org/linux-pci/20220922163206.21281-1-Frank.Li@nxp.com/
The above patch series fork to two parts. clean up and use msi as
doorbell.

clean up patch already been in https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/commit/?h=pci/endpoint

These patches based on the above git branch.

Change from v13 to v14
- fixed according to Mani's feedback
- remove first patch PCI: endpoint: pci-epf-vntb: change doorbell
  register offset calc method

Change from v12 to v13:
fixed Lorenzo Pieralisi comments in https://lore.kernel.org/imx/Yz%2FuMiElbqB3ThGd@lpieralisi/T/#u
- update diagram
- Add platform_msi_domain_free_irqs at failure path
- sizeof(u32) is because hardcode by ntb_hw_epf.c


 drivers/pci/endpoint/functions/pci-epf-vntb.c | 168 +++++++++++++++---
 1 file changed, 147 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 04698e7995a5..cd97f9f8ea32 100644
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
@@ -256,11 +260,14 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
-	for (i = 1; i < ntb->db_count; i++) {
-		if (ntb->epf_db[i]) {
-			ntb->db |= 1 << (i - 1);
-			ntb_db_event(&ntb->ntb, i);
-			ntb->epf_db[i] = 0;
+	if (!ntb->epf_db_phys) {
+		/* software polling doorbell event */
+		for (i = 1; i < ntb->db_count; i++) {
+			if (ntb->epf_db[i]) {
+				ntb->db |= 1 << (i - 1);
+				ntb_db_event(&ntb->ntb, i);
+				ntb->epf_db[i] = 0;
+			}
 		}
 	}
 
@@ -518,6 +525,28 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
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
@@ -539,27 +568,26 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
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
@@ -728,6 +756,100 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 	return 0;
 }
 
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
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
+/*
+ * Work flow is
+ *   1. pci-epf-vntb function driver calls platform_msi_domain_alloc_irqs() to
+ *   allocate MSI's irq from the platform MSI controller.
+ *   2. The epf_ntb_write_msi_msg() passed as a callback will write the offset
+ *   of the MSI controller's MSI address dedicated for each MSI to the doorbell
+ *   register db_offset and also writes the MSI data to db_data register in the
+ *   CTRL BAR region.
+ *   3. Finally,the host can trigger doorbell by reading the offset of the
+ *   doorbell from db_offset register and writing the data read from db_data
+ *   register in CTRL BAR region to the computed address in the DB BAR region.
+ */
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
+	/* ntb->epf_db_phys will be used as DB BAR base address */
+	if (!desc->msi_index)
+		ntb->epf_db_phys = round_down(addr, size);
+
+	/* In drivers/ntb/hw/epf/ntb_hw_epf.c
+	 *
+	 * Doobell register offset in DB BAR is calculated using:
+	 * offset = db_entry_size * interrupt_num + db_offset[interrupt_number]
+	 *
+	 * set db_entry_size as 0 at epf_ntb_epc_msi_init
+	 */
+	reg->db_offset[desc->msi_index] = addr - ntb->epf_db_phys;
+}
+
+static void epf_ntb_epc_msi_init(struct epf_ntb *ntb)
+{
+	struct device *dev = &ntb->epf->dev;
+	struct irq_domain *domain;
+	int virq;
+	u32 old;
+	int ret;
+	int i;
+
+	domain = dev_get_msi_domain(ntb->epf->epc->dev.parent);
+	if (!domain)
+		return;
+
+	dev_set_msi_domain(dev, domain);
+	old = ntb->reg->db_entry_size;
+
+	if (platform_msi_domain_alloc_irqs(&ntb->epf->dev, ntb->db_count, epf_ntb_write_msi_msg)) {
+		dev_dbg(dev, "Can't allocate MSI, falling back to polling mode\n");
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
+			dev_dbg(dev, "Failed to request doorbell IRQ! Falling back to polling mode");
+			ntb->epf_db_phys = 0;
+			platform_msi_domain_free_irqs(&ntb->epf->dev);
+			ntb->reg->db_entry_size = old;
+			break;
+		}
+
+		if (!i)
+			ntb->msi_virqbase = virq; /* msi start virq number */
+
+		ntb->reg->db_entry_size = 0;
+	}
+}
+#endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
 /**
  * epf_ntb_epc_init() - Initialize NTB interface
  * @ntb: NTB device that facilitates communication between HOST and VHOST
@@ -1336,14 +1458,18 @@ static int epf_ntb_bind(struct pci_epf *epf)
 		goto err_bar_alloc;
 	}
 
+	epf_set_drvdata(epf, ntb);
+
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+	epf_ntb_epc_msi_init(ntb);
+#endif
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

