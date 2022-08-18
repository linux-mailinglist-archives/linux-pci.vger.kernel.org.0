Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AE25986FE
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 17:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245462AbiHRPMb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 11:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344150AbiHRPMP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 11:12:15 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BC2BE4D4;
        Thu, 18 Aug 2022 08:12:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2Wo0/IV+WVfok7DEk20VU8vVibjyKzySi9IHHfBKODLezSTDO5clzW25Nv/ncRwZTRBHh7q6D5MD+m0RJS1oKOEj9H04uhStT0RR0/ykApBrt5IZgz4BI9N7z1NpHUlwYWPfRNwrOFfAJqRVPFcnTEYpwL889/NsKrpoY3SSGms1BuTqCQlkZAmSR/AbVX1wl6V2lf3qgQYmz9a6Wqwry3Uw6sCVfZnnPHNzShxqh4MBdSCsE+oBpEcPsNuORJelbdEl1G1L7D5DwNofnIwVYlsUj0XCsQtB+g3M3HBIMRuRoY6rn2ExceShJgXBAGYRlVGKirAOxHNx0XyUJiEtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1NdUcLeUXF4fzJDgh+3FCiqhJxBXQ8qbrSj5WgwzKo=;
 b=GpskljL6i91pwjDY1KtPzRBB+VEklgvxglOvwXIsMLYCfaIzi9bb1hWBaDbcB/hEkEpSBd0kPY6jKKTLafZGdfQXhK4Qhd1xG84wKhZrmIxTccJxOjs7m7x2xZkWr8c79MdtJ0FNVI6/vjtrKXfdTewH0REkzbc7cvyv8lsEYFPeFurYTqopBpAhNU98+Pz84ybPSZv+GHqJJHFpNYusZlspL5cAl7cIzK7MTZlMRPqAiSdm/6+PsmVp8vtQpizHSU2C/V5fP2ryneMiv88t9gFhehI93NsHDJWOrff9Tl/g3aUk1y463t7MjZnFmsCLKj0JAG3HbG1NGGXjGH2SVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1NdUcLeUXF4fzJDgh+3FCiqhJxBXQ8qbrSj5WgwzKo=;
 b=jqpMV+abWyWFXop5n1wuqQPMvpg2V9CU8yRiUQTNJrwXVlcKUsBHc9EyqCyKytXZHqMR1WcfTE2zLY6b9Y4B5edbCRPq+ZtcDpLDTFRyahgxcvFp3gdk/294mGBAUBDuc11Zr8KuWrO3Zb0tUCzv5TVFnc5/bmS11E9KZ3eiCe4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB5713.eurprd04.prod.outlook.com (2603:10a6:208:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 15:12:11 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::40a9:93e4:75d4:f73c]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::40a9:93e4:75d4:f73c%3]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 15:12:10 +0000
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
Subject: [PATCH v6 4/4] pcie: endpoint: pci-epf-vntb: add endpoint MSI support
Date:   Thu, 18 Aug 2022 10:11:27 -0500
Message-Id: <20220818151127.2449064-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818151127.2449064-1-Frank.Li@nxp.com>
References: <20220818151127.2449064-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::26) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bbd2ff3-ab45-4661-bc50-08da812c0613
X-MS-TrafficTypeDiagnostic: AM0PR04MB5713:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S8A04qEaiew4yspKLGL9XKD5QKhJCHIpQCS/0KSbT2doQKTySCav6c+KHJiBcDWHNEm3jo1xX5Mu82rdEnab4wlwjQ8uaV7E4nBRHgM7s6+mkNLk4/Fbp1Sb8z1k7C6US4ZJvmUkYPL5ajaCXdhhXpgd8IdMBehHxd0Wu7cnxNfswsj9coeSx0Oa9/5JvP7++dH7R+0hhGgtPdA/5OhmJjfRDiSQznJb+PtKELxMPAkNziW7bqd5LPQVf0nKvrLyUWncpXVWQbE73bttkaDFd3JdNR9mayp6rOVIK+Tw0tbY5WFmiebw1Hia6rwVve5CBLuMF04s2lVhTrh4PZLAQbeHGtyvLjt/hKrfXmmW/tHPBcnMD8va3aagV4I6kIfa+JGlSgaAbwXSMWeRwwR8lhC5RYaHzNiZTrl6fn99s6eZGlaK6xgIBrNcy7KChOrCCOYefvxx1zqlpbLXjRe4mE03ETb5kBOXoNShsEXutCS0ZBZdJ51T+exaw91zFrTkvAMR2iftLIzOmvuhtxjavz5tJuFK5uSMG4LlqL/NtuC80rkisuJC44ckZdqRqutoGb1qxc1m49q47Js8f9ZLQvVUCvXqkXBiochJtcYTS/+EQnzPPG4kMj+ZRd7wdb9s7/3MT44ESsqJmaj97gD1To4uRbQbBmfyrf9trx8IjC1QHI93diD9UZvfeEhcjU5StCABtG44p+oWsY5v46lPQelNX2h5Zlm/hXAkE8zxIpcGNr8oUGUfmJ1+HgJgsO9L2kArhwXwYM91hxE7vowd9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(2616005)(316002)(1076003)(186003)(83380400001)(36756003)(38350700002)(38100700002)(6506007)(52116002)(4326008)(66946007)(66476007)(66556008)(2906002)(8676002)(6486002)(86362001)(6512007)(41300700001)(478600001)(26005)(6666004)(8936002)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEdwMVA3dk9KWmg4Yzg2Q2lpdkdiTUowSUlxZGRxZFpNU2tvUXZsSVdFWXdF?=
 =?utf-8?B?YkNJTWVNblRDNjI2SWJhSm5oMWNaamhGWFRuMkpVT2tnNElrU2o3amlMbDVv?=
 =?utf-8?B?TnIra1Z1NUI3U1E0MWVhZG90dEdSNUFULy9FcVNPWFJ1U2ZkR2R4cGdlZlhl?=
 =?utf-8?B?d011Qlg2RXFoSmZyM3BkZXZpQjQ3YmRXbHB1MUZtVGFTa3VCRHNFWEJYWlND?=
 =?utf-8?B?eGtpMFMwSzJOMjljU3ZTdUZ0bmJjYlA1RERmNk1ka0gvWkgxUTJyUmFpTlJT?=
 =?utf-8?B?bXpsQS9jenZVaklCdWJGbTBlbDFpZ2JNUVkrRkI5aGJpMitNSnQzOGRYaWw4?=
 =?utf-8?B?QmFlQzBJcmp4MERmOFRiWTFJRzJzY1NvQkZsK0NndTNIeWNpOUVhOGo5YzVW?=
 =?utf-8?B?aDk4OWxRREpjQ3hXNFlNUDUzNWJmbUNoRDVraUJGc3ZMNmFDYit6UGdMUmJR?=
 =?utf-8?B?aFJCRnQ1K2IyNERzQ1o1anRlallQU29LdXhhL0t4WTdiNmc3N3lhcGxNc3l6?=
 =?utf-8?B?U0lwdG5USDRCRW12NHB6RzUzN1pWZ2JQc29lMExxU3I1L3pXL1NjeVZFdmRB?=
 =?utf-8?B?ZUVpZHF6WXlUSDlMd1g4Yk11Kys2Y1pLaURnTDU1UUZnZ2NXeWFvMTh0MFFF?=
 =?utf-8?B?SmZPRThtZ2NLYS8wN1dnblVVVi9IU1hsOUhPY0tFWkRLT2FNSVVkMnNKQnNU?=
 =?utf-8?B?RkJ4N1NHQVpraDFTTGN2Y25mZUorYzFxRnA0eXlISFFnWGdJOXR4Q0VuUEZF?=
 =?utf-8?B?QlhDWmRwU0FCQzBvWnBYMEpZdmZoeUttTk5ZeTJVZVNvSkJVUTdLKzN0MjJ6?=
 =?utf-8?B?MkM5emdQU1B0b0R2aVFQWmhKUVYrTDkyVHhXZDVaelRWaTJmQzd6T3dQaEV1?=
 =?utf-8?B?bXFMZ1UvYUM1VlZpQ1IyWlRyWlg0eGZBWC81bkIzYVhFVmlZSC9pU21sTlVq?=
 =?utf-8?B?S3pwWlpOU0RKTm9WMnRVL1dOYXp3UmNjMnpBWUh6M24rVERtVGFPU1R0TVhz?=
 =?utf-8?B?dERxYW1sT2lUOE0zRlMzSGRveklUTlFiQ0l2MTl6dHpiTHk0enhsdkw2czd6?=
 =?utf-8?B?TzI0YXRSZDczd0hvd0xlTktzNDFLTUlPZGVDMDNyWVNTWEhhNUEzWXhnQmxr?=
 =?utf-8?B?ZmlnWFJYWmJnaFBqY09RQ1o4SHNwbnJwU24xRHVEK0RMOHh4ZHdJblRNbTlE?=
 =?utf-8?B?R1FpL2psSHlDbXhRKzZYdXF4VC9Uc3ZZUzcycjcwMlRsNHY0NE5YTnJIL3R5?=
 =?utf-8?B?NzJJQ2FITW9ySzZwN3hLNS9QK04xK3l6ak02MkhlODRyclpvRmpCS041bmtt?=
 =?utf-8?B?cGdIY3MzbnNyZTVaWVpPa0F6RGhuMUZVWmplQkYxNkJiRDJNWXVRaTNTamF6?=
 =?utf-8?B?R01DT253WFQxQ1FrSFI4a2VuQVdTbnlYSUxxbGF2cWhoemRKVjMzTUw3ek1O?=
 =?utf-8?B?aitndTZ1dXc1WG5CZm1QcXVXV2Q0TUNYOUUxaDZRaHU0M04yS2JtcXlhYTJz?=
 =?utf-8?B?QkpDZWRnUmlsNEhzaERVR2o4S3dsV1k3bFlVdVd2YXpQNjZrRms2c0d5RCtS?=
 =?utf-8?B?QlM0cFBKM1hXUTdJdS92dmhadHg3Rk5xNGg5L1l6Lzl5NHlOdXF5WjlXN0k2?=
 =?utf-8?B?aWRBMkhGQlYzcXoreDcybDNSOVlsSkZmandQcW1ZTlNycE9xRDJvQkdvZzVT?=
 =?utf-8?B?MWxuUUtVNysybW94Z3pyQnFPdFpvMW9MaW9aZHk4L04rMFVMVnlkNWI3V0Zt?=
 =?utf-8?B?OW5DMkQ3Zld1NHYrZEM1dVRNOGMzczhBbkxmekUreE1DUkVXL0xLREZnN1o2?=
 =?utf-8?B?SUE5MUVBbkhNdktVUE4xb1FNY21mNWoxaXBGM3dTY0dYRjFjbHA0Q1dLSTFl?=
 =?utf-8?B?VSsrbHhTNTdacjE2dlVCYjNOK3NEUHdsZ2dNWXVGd1RsbjU2WHA0NnB2cGFt?=
 =?utf-8?B?djIxWjZYZnRWNS9ndWx3SElyNnFQdXBLQVk0eXkrSGZBOVVYdURYYURYbTNO?=
 =?utf-8?B?bjQxYUNPSWc1amhWOTZucFl3RU1RaGNyK1c5c0dLSlY4Z0t2VElFZmI0Nzdr?=
 =?utf-8?B?cDZwdmJZamlzM1poVFFsZm9DSUlzRnFIVUFYdFExSTU5UEhYWFlrWGpVYXdh?=
 =?utf-8?Q?+SvQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbd2ff3-ab45-4661-bc50-08da812c0613
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 15:12:10.8878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDE5gIA9p6DHAuzYbEkVdgz4Jd9ssdkKzSIc2T/zDw5PFnNpX0aHZ7H4r1mj9wjtwzeMb8bKdaWow8pBKYTi8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5713
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

                        ┌───────┐          ┌──────────┐
                        │       │          │          │
      ┌─────────────┐   │       │          │ PCI Host │
      │ MSI         │◄┐ │       │          │          │
      │ Controller  │ │ │       │          │          │
      └─────────────┘ └─┼───────┼──────────┼─BAR0     │
                        │ PCI   │          │ BAR1     │
                        │ Func  │          │ BAR2     │
                        │       │          │ BAR3     │
                        │       │          │ BAR4     │
                        │       ├─────────►│          │
                        └───────┘          └──────────┘

Linux supports endpoint functions. PCI Host write BAR<n> space like write
to memory. The EP side can't know memory changed by the host driver.

PCI Spec has not defined a standard method to do that. Only define MSI(x)
to let EP notified RC status change.

The basic idea is to trigger an IRQ when PCI RC writes to a memory
address. That's what MSI controller provided. EP drivers just need to
request a platform MSI interrupt, struct msi_msg *msg will pass down a
memory address and data. EP driver will map such memory address to one of
PCI BAR<n>.  Host just writes such an address to trigger EP side irq.

Add MSI support for pci-epf-vntb. pci-epf-vntb driver query if system
have MSI controller. Setup doorbell address according to struct msi_msg.

So PCIe host can write this doorbell address to triger EP side's irq.

If no MSI controller exist, fall back to software polling.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 134 +++++++++++++++---
 1 file changed, 112 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 1466dd1904175..ad4f7ec8a39fc 100644
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
@@ -253,7 +256,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
-	for (i = 1; i < ntb->db_count; i++) {
+	for (i = 1; i < ntb->db_count && !ntb->epf_db_phy; i++) {
 		if (readl(ntb->epf_db + i * 4)) {
 			if (readl(ntb->epf_db + i * 4))
 				ntb->db |= 1 << (i - 1);
@@ -454,11 +457,9 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
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
@@ -509,6 +510,28 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
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
@@ -520,35 +543,33 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 	struct device *dev = &ntb->epf->dev;
 	int ret;
 	struct pci_epf_bar *epf_bar;
-	void __iomem *mw_addr;
+	void __iomem *mw_addr = NULL;
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
+	if (!ntb->epf_db_phy) {
+		mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
+		if (!mw_addr) {
+			dev_err(dev, "Failed to allocate OB address\n");
+			return -ENOMEM;
+		}
+	} else {
+		epf_bar->phys_addr = ntb->epf_db_phy;
+		epf_bar->barno = barno;
+		epf_bar->size = size;
 	}
 
 	ntb->epf_db = mw_addr;
 
-	epf_bar = &ntb->epf->bar[barno];
-
 	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, epf_bar);
 	if (ret) {
 		dev_err(dev, "Doorbell BAR set failed\n");
@@ -704,6 +725,74 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
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
+		if (ret)
+			dev_err(dev, "devm_request_irq() failure\n");
+
+		if (!i)
+			ntb->msi_virqbase = virq;
+	}
+}
+
 /**
  * epf_ntb_epc_init() - Initialize NTB interface
  * @ntb: NTB device that facilitates communication between HOST and vHOST2
@@ -1299,14 +1388,15 @@ static int epf_ntb_bind(struct pci_epf *epf)
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

