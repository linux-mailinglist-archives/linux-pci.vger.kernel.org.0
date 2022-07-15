Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75541576755
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 21:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiGOTXJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 15:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiGOTXI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 15:23:08 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E7C79ECD;
        Fri, 15 Jul 2022 12:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1dBuytd2HijtkKNWvIGL0/8firelYlk3FVjzQ2VgmugbbZBB2TqVqrROqrnsEqlNCO0By9ID2VEmw2oR6RaXEVPlr8hJFAo2ss/zGzLT4LhdbGzRbqALrfoXDQpTGFNkoFUmR0Se7A3GJhnfprd9bi/Cl0/NukwQMxg7u6XQdQK1LZc9TuNcjvu0Q/o3hy1zzW4GkKi4jqU/iJb5pHfKSNkzh2/3Ees0BkExIvvnNAHuFqe3qZuTq8Q4CBzH0GEDqyyUXpnokj88NBXt0f7g/7+ynAnGV8XnkQ0aUBX6dlgc96YArUC9LAolq5LLTQ71OT0xUmPOlAzWGN+9FwP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULw1nL9NyHvjmPP7EleoBnExAoN6KkMrzd8vqZ+cQxA=;
 b=WzVHJY0cOC6Vqid+smtbS3BTrOVGUygcrpd50tlneEZel4zRYvEX3FqjzHh4iYlMmFIctrMoiRkg9d1frn/78/tjzdCWAqiFp8hJrPVBzSOMWf6TGSMnyq3sIMdoG4ZfBsa7FYWPhRgx4zB/DC28H7jJXF1dfwZOopWmNRJcbU7pkKJ9cREWMfn1blNjHNBNfsGAmGdNN+7CFcqUP5K88Y+1kSusOivmfI3M3dXhaaZQnPePap6o1aU6894t/Zv5GcphVSS2n9M15AvPI5SgzB6vYDINl1E+6Sh3lWmN+XVKlojWpcEJ6MPA4nIt7F2ryGRZ6ctwO/Bs9PUZGqqzrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULw1nL9NyHvjmPP7EleoBnExAoN6KkMrzd8vqZ+cQxA=;
 b=eRruc3LW2vYTFuOudZQW6QIUczoAQlneAHRRdAusSNZUoRzrpz4w+W6BN3FhcJ0iAlsjmCtpvG8Uacry8A/pXnU2c7Yj/sifVxbwvG4LU1WCRim2uyfVYpXTxP37MmdkZzbnFxCQRs/mol3NRZPEzSnv45KbSdmZAiPAjDr6Qp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by HE1PR0401MB2490.eurprd04.prod.outlook.com (2603:10a6:3:82::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Fri, 15 Jul
 2022 19:23:04 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab%7]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 19:23:04 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev
Subject: [PATCH v2 4/4] pcie: endpoint: pci-epf-vntb: add endpoint msi support
Date:   Fri, 15 Jul 2022 14:22:19 -0500
Message-Id: <20220715192219.1489403-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220715192219.1489403-1-Frank.Li@nxp.com>
References: <20220715192219.1489403-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0084.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::29) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d55d283-b6ea-407f-20c3-08da669770cd
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2490:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d4FyNYa7jgxgHKZafJGLEIqsgFgMVjA2gMJuKcFoCa5eijcf9W7q9Y7EvCDNmPl/IiQmdPTY4cSNEBlBMJRvTp9VPKp7D/i3PQPfAFYMosr3ghJwpgUgJyCqnoBarwJyjqbtTsCkOyPTpQ+/dhd/iTTVT5Qs0uJdNBKh/5hFHEFZEUzQHHiWyZ0WFpJ/zXIt9kcoNGnWr5ZtPee9TRjD8TdTbh1DdIzlEqM4/dpe6GgcY2uJl/87ikZ8wc9HMmID51dA9liP+LXC8vlH6CXuwidJ0CrEtsc6RgY8uvckp1LzD4vPblCqwfKLWILTo2e/BUnvnupJMA1H6NKqohA2w3GK6D2YQ6JGgQ0BJQoZShWocYBuJH5EiCf2joVHKV+tsKAxGQ4ylIsGyBTZ+z9ojMXS0lmg3uyBEWMXLv7VjAoQCePkBlcbohEiImoqwP3DCN3W+FK6P0eOadNSLZ8kbM7lGW2/JRzLuxU2X7Q6Bqxngk4YAuGUJDPvjQmOw57PhFF2MYm66kNPhFLaH+qJgDc35jA8MjXNX14MS39Xf6QTg4XZJbYMU8gEN42SDMik5mLFeubCSR3Qj/o8Tgsx5ZnHnUiGgTwsvMDbFM2qkyyjfN03TqWAEDevcOwkcGzCh4Rv7c5CERqfc9S/eK8o7kvFr5Nw57zUTdnCNVVzTW+JzslVzlooD+3RPnfjOiibQ6OiVcN0YMWrtpXAc3DH5h/C1ss6LTOhCTUXMVkOSlMI7Lr0xp2tY7jPbrqFtQk0e0SxB/bfzwBU0p+jsMTw258vURUusGTEQOdHAYOPZ2S+4OecchKy2BLPY8JYr2HF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(316002)(186003)(5660300002)(86362001)(8936002)(66476007)(66946007)(1076003)(66556008)(6486002)(4326008)(8676002)(6512007)(2616005)(41300700001)(38100700002)(38350700002)(478600001)(26005)(6666004)(6506007)(52116002)(2906002)(36756003)(7416002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dA1qIxcWaJFBzWcNsWVVn4xZG4kOzjQ2IdYbIKkSRo5LKvhhyWoGMBuD9kz6?=
 =?us-ascii?Q?JPX9RryDjgFAR7TGoZo0joJ32Rjan1Q8Q9pftc7e0sntXErzzjZuNI7jKfTm?=
 =?us-ascii?Q?542D6hsUQuYs5M0GekVv8VMfLqnlNpyuaem+hkLReHGeG69GyQHjBM5vWWkO?=
 =?us-ascii?Q?sKarQcoBs5n+ZSQ70hJUqvV8wNfDHTCPlIOUPlmsisL0/MQuLauGBdIg5pFR?=
 =?us-ascii?Q?DB8r/NWXv2ZTTg4FbP59jral2P+ewM9WNtOWOXo+9g3Hk9btqyjW5o8VsbId?=
 =?us-ascii?Q?m2+T7LDvuzYPO8mPgJUKUdet+1lIK8S3N2JV5EUrbyHp8oP8aQeUvoZJtP1q?=
 =?us-ascii?Q?eSU7FIiFhjeFPxDjo1GFHrmIsjjbnBrD6hosV5ds+XATqSgRdcO9JMYbmOC/?=
 =?us-ascii?Q?TNKXsW6VFjZSEBwwHCwVUKtTes3RGt2m4nkU7O2/uG+FQqQirMlIJAoEiS6+?=
 =?us-ascii?Q?bxBcIeIqwK/XgPJyb85Mdyaj9iAEG9stLEFTCIPZYNYE71qharCjP0YpiP1+?=
 =?us-ascii?Q?3tXL+TCVsapONXNWTvH8asxstxKTXbea/ZAA7EYtwzJzp5hMyJ8Z2YpsY+Uh?=
 =?us-ascii?Q?X13mFOHtFfUNH77GUS8nzOGtbkF8KVqtTfCmSCwlrLt6iXL+JmDgD+NfQEyx?=
 =?us-ascii?Q?0pR2KfjMxoQPmW1IdLOY8c4oHP99jrmZhIIwYKgbRyer315OdiE2fT2DdZpG?=
 =?us-ascii?Q?t60ccC9Z3khKhRzPCSPZV1sNtUVfSLekn3RZUK67t93A2SzyqfcdW6TjA3OZ?=
 =?us-ascii?Q?GC2h0nUll7H3Rmf2dOvO7M/MfgLNlJa8zFaLY3GorRgmpULPrWu+8eYSL3bl?=
 =?us-ascii?Q?jgIXxd1to0goEqNZqfeDawvkLRnDll6/VZOHk/SxZ++x64LcepcmIw+EF8TH?=
 =?us-ascii?Q?+qGSyYTHh2heWh9Dk5EOjpkBdRH+TYB+GtjtuKNoaYw0LBaYTCNhbIw/OmMF?=
 =?us-ascii?Q?E4BTIisckEFZN/w1iAE/Mc9+/0Nb6b76nMFQ7BaMZAZXd9f0dHe5fFF/OU4H?=
 =?us-ascii?Q?Mff7GQBWjwbFzLiUJbUP7gXIMyfvmTGF3dMVkHURGoQGI385ztqr847F/iLR?=
 =?us-ascii?Q?tRHoRPRnmHpQec0B7L1vCOjAyHPCiQ9otPBgN5JO7XUz5XYQp5Sd4DmxPVAe?=
 =?us-ascii?Q?BU6oNbNV3Ghd++LZN0lwpzrixYCdX/6lqyS5V5RqWIuvW18IizMHf5GXTro+?=
 =?us-ascii?Q?fdnw+oB0B7T0PPIoCIC7YERDBOEd56v8dzt23YWQ0DqdTrYjIOMszEI0+Tzf?=
 =?us-ascii?Q?GcuX69ybwpbyjQsnBWe8d+hXVJF6Ds7FhNVmBADtoGAdhnNuU/ZOoLktG3Ph?=
 =?us-ascii?Q?HE2U8TXsR/zPfgTS/Pf9o9wAPlj2Rpw1RcW+C6H8MkT21E2TC9Fn6Zqk+YYE?=
 =?us-ascii?Q?d67ot3BEY6arhTNKBFB+6IqdGOMxpq/8CG2c9aAimhkt82ujIFiIT/LCEamL?=
 =?us-ascii?Q?9KYn49gPq3k/l3cxq0lYV81MxzBJ97NQTXFxGN8Azc8yjmApHtyb363OH/B2?=
 =?us-ascii?Q?BpXpnHC/1VRP6MsTYiyWoyqqwYnlL7NY295iOHn4T/fw2ZZt/SASQreHq1bl?=
 =?us-ascii?Q?P3awQmEhIj7rSNSkntg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d55d283-b6ea-407f-20c3-08da669770cd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 19:23:04.6338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdOgqvbwhHQMWE8QsuUYopY8/lhsxdIL4YDAF4e6wLFKtNHig+Ue/D/Fl1lsVUfQdmE/bhOT4+2xv1DPydTenQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2490
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch add msi support for ntb endpoint(EP) side.
EP side driver query if system have msi controller.
Setup doorbell address according to struct msi_msg.

So PCIe host can write this doorbell address to EP
side's irq.

If no msi controller exist, failback software polling.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 134 +++++++++++++++---
 1 file changed, 112 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 1466dd1904175..dcaebcda4d7ad 100644
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
+	size_t	size = 4 * ntb->db_count;
+	u32	align;
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
-	align = epc_features->align;
 
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
+	struct irq_domain *domain;
+	struct device *dev = &ntb->epf->dev;
+	int ret;
+	int i;
+	int virq;
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
+		dev_info(dev, "Can't allocate MSI, failure back to poll mode\n");
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
+			dev_err(dev, "request irq failure\n");
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

