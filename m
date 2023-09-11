Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E0379C1AC
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 03:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbjILBab (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 21:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbjILBaU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 21:30:20 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on20630.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaf::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A737F184470;
        Mon, 11 Sep 2023 18:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vz7skDRsoECeM2FCmTjf6BK2RIt7V0fZgwsBE9MTcsFffMPoSZe944w3xdL/Pqf/PB4T0DoJd/K9mc2XUcC40gGv1el990H20vPWA8gO5y2Ya7gIEFCfAa4Wkmu8kK6AsKtIY/ues5iVUQ6fQdvTi8Tj5ysbAq0p/PvUfTTbp0122ZgXpyCR/5r4JWWHjHYGm5szO1LRkqa4Eri2R2aeuZKnTv7yBka3lEFk/2JuAHaginAeIxLRdnfyyfQDlNjMW68/8p99F1dz4s8LGt7s8p6hkC3iLDjCcfs88Sx08HQC5X0O9P6Rl0eSNWL6yuFVKvgeVTr7QXAVT2ho/n0NDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kn/xKL/kdfC5LoTDOItOlRfR7cNqoPTQczNOO7CdilI=;
 b=Az1Uvbkpp80eaA3vdi7facqSMq3zY8YQcPdyjo58jftCMQ+nybl28R0vj9Mz7V7qtnzheTnv7/ksY0iWalGbF8GFDjZEsZ0BICOTvjZzzJWUGVQtjG3n+EtPUfrAy2cTy7pF//YDV3VfEsAP5MHI3qhtWrza1cdmTjyy3gsaf9eyYcm4g8SFBK3AZXEh03ldZLX1NshQqtkJssL4HSMGb6qCcqYN2/kdnjfpQO3uquXS/jlzw5aQeLL465wR49m5wY3ybKnj9cnMlyfIWkx8hVAMQmFU9ZEmWxlCTKr4Ee9f3POsO/yz1ltbzh0w5DCHUdlQZPCbjqgB4HgRvFuDRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kn/xKL/kdfC5LoTDOItOlRfR7cNqoPTQczNOO7CdilI=;
 b=AAeWW+K5AJyMFKtZFf+ffnJjoLrakmseMR1DooNvvIxvODgHcjrAMjuJIZUh3O3RNSZ/Mm2lSG+6eRcijc5+FoV0kPBzX0+pQCOu9H37jiUIv8mZtaQUKtJMWItHaVaEtKe8yRAEYezr1iEaXPeXs0AVDYX2PwmofVA+gr31fSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8125.eurprd04.prod.outlook.com (2603:10a6:102:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 22:09:57 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a%3]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 22:09:57 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     Frank.li@nxp.com, aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: [PATCH v2 3/5] PCI: endpoint: pci-epf-test: add doorbell test
Date:   Mon, 11 Sep 2023 18:09:18 -0400
Message-Id: <20230911220920.1817033-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911220920.1817033-1-Frank.Li@nxp.com>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d7a292-805c-4abe-b487-08dbb313d5b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KsSfjwz4koHw+bRPf0t8XgpnhFBhRnMoyM9mnZxRnju6k+CIVvIOoeYSBb5EX2gNoPOxcsXIPSTNy7WY4NPs0xG8iQQ0s6rXiiGxcte/wawQRooUB7UwIdHYgjEMg/c5U4T4ROutf6jHcobO8AGf8yyiUUcwd5zTL2SONkXoNQ06QhBJEyfKk1Vh+CvmD0lkPAgs6VZU5qH6DmRP3IZxpxG1cFuh3gFKo+tENYum8mlOe3hnBIe/pYdhAc5s0ZpNQuE9RCmOvYN54fXh2Xn4rVaw4M495TM8iTBhXfyA+zGS4k19+wUOak7iP6y3LoggVZm9XG7as8wWBcZsI66XcuCcmenuxXQcA/7txktC1AfNx5vmZq5B50BUckDvbA7sG/I9lqT886+jzGwJhiYRLo9/C+Msqj1lkXaj5FZByCRFg204524LzluI7ws6wC3pZkjDtvytfQX99VPzODFcGoQ4xf28rDRx5Qcg88SlTD89rWuT+AukZkOL16ydUkp5uhRxzImiaX5mna1Csguw7oIaxWyCwlqIGPvZZhqMRv80x/pT8FN+4d2RkrIMKTnz6E0BaN0roqTijxDXArY6SnJxRZOxHs8eXq1nz3QbD2VHUJuP+xATgl4/E3LqbCSX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(1800799009)(186009)(451199024)(6512007)(26005)(1076003)(86362001)(2906002)(83380400001)(6486002)(2616005)(52116002)(6506007)(6666004)(7416002)(38350700002)(478600001)(38100700002)(36756003)(5660300002)(8676002)(8936002)(66476007)(66556008)(4326008)(6916009)(316002)(66946007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T9LPQOR5e5E86dXLc4fzC1LjQYSC2G6E0piM8pAMxvdzxE2bdpgD6/i8+ZYa?=
 =?us-ascii?Q?l0aOeqbmUSi0DbKjsjTtJI+mblMM0UR97UXc/LjD7FD62J/5GHubjXHRFEfx?=
 =?us-ascii?Q?BZwWx5oiLY8msxiA/J5i+wii+n+FvFE7X/Sd3z7S3hLvn3RYoonS/TgMtKR1?=
 =?us-ascii?Q?NV94jlbAZv38EWj1IOc/KVL2x3tY6f2hJysxO0IB+8QT8PZBcy7HCPYBDIck?=
 =?us-ascii?Q?5upGB9gih8aWC6A5oFBsvrXc3NL7NIv8L52+Lno/rxxqRrXiGNTeZ4BJFlFT?=
 =?us-ascii?Q?FPM+IDTpGLzRO01nb20wfeJQBQwEKFxBStjmLWVd2K0ok3jlHUZeWTPeHK1/?=
 =?us-ascii?Q?qOrVs1XzB17opyPAH+Jm4US3x/ImOzHb0w9EIUYU6HAhKBWesb3H4cv4bCbF?=
 =?us-ascii?Q?6LXL7OPrTAphNqLycssofBNtNxvVEcRJaF/iwq6AVtQKC+ylfZjh9QeugY+L?=
 =?us-ascii?Q?oQouJsH6xhra3w4bzEo1YGHVFF7bbn62HnDSXo7MStCsnow4cGxNzfgLRVew?=
 =?us-ascii?Q?U18Gjsmag1iQ0yIO2eGSRN3p65jBBGCVKDrIVz/sFTuMpHZ1fwjP6et493cB?=
 =?us-ascii?Q?A4sNMpI1hi71E4POqfMpcjQD/Lj1bj0FkE6Iwfs5Eh3j+r5+8OPRE0RbMV3J?=
 =?us-ascii?Q?2LgrsZUPMFgqu2bA6gdEdPgh079sekujtF3bEuiN95F4oPH04SfPFbzHf8MP?=
 =?us-ascii?Q?RyZOuRW5n0yIuE+n5wIE//GQy/ifactEYAcYYj/OlngJCYnedVHtdKQSdK8b?=
 =?us-ascii?Q?aUu5qZky/ot7BAcwEpV85e/1VpwDRe1zPtCYyFwRTZzT91wtPmxjYBc9xtus?=
 =?us-ascii?Q?6e4YWhrwIPqtUPrEO0IAbxwsIIHagMrL24X5cqLoq0lKz4oKrDdWYWCH7DS3?=
 =?us-ascii?Q?qcjmD2evvaR0t+PJFZQeoWj88yVF0yhrzgbS/pnNQlz95nH5LHsr7El2ZEyT?=
 =?us-ascii?Q?fajLzfS29iY0Gt8tWQ/sUP2pRQ5fohuSmZK1tHxd1P4AfXBHRb8zvgyGNKhj?=
 =?us-ascii?Q?McDcvbkAsPo7+QAKdK8txJki1s34mlYfdehEc4F02x6bHVgnB/JkRQiGY1mn?=
 =?us-ascii?Q?OiKd9X+QAg1otLZ/BuojaeVN5H75Uvjnz/T5DcU1+Fhnju5cqeBqL2/bkYB+?=
 =?us-ascii?Q?Bkh+47m7bXmRmUJPo6iuKLQAYvzNd8lJ7qfff+RgKAfU6DV8hQIsie6mArzx?=
 =?us-ascii?Q?7uULkoX/xc9IolWdtU1GcbgVNJZCBS5lLlq4EQ5EHBHCjJ2e6uYxaO/tuFYT?=
 =?us-ascii?Q?ht0S3gP1Bk2EimgJnzmgOqV4u7H64gJxk1t2Zubjuip7YHL4whSKtiJ/hAfI?=
 =?us-ascii?Q?PMy86B/Ou76MZdj5f09zRDCS1JS+LvAjL5qlhYveEvMXhz4RVhAWYLEdqK9A?=
 =?us-ascii?Q?8POGgQA63GjljY8/i/ssL6UH0j/4dxL7WN4RDrYmDR3T3SjgtqVJ+U7Go6Q7?=
 =?us-ascii?Q?8+MRiA55xguYcZYk2DPf0i9ZGqECxb7ZGbLDev/TMLx0FGOWhpK75CTs753G?=
 =?us-ascii?Q?KGoX7/evP08yFU2SWG5xth2vIFdFjWeEOX4TpFNoI1T4gJITjDQVXPts2j9c?=
 =?us-ascii?Q?YXfezZOwMFtC3WxZUwgLNz+SrvAnzWEnuBHTq7tx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d7a292-805c-4abe-b487-08dbb313d5b5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 22:09:57.6113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3HESZIgw61deJWHKoBqR37OdJOK0brf9/bETwqkTJYOTFg6/YEA/OT9jTkdu0vjosradiSm/q+O5kk/FCIfJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8125
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add three register: doorbell_bar, doorbell_addr, doorbell_data,
doorbell_done. Call pci_epf_alloc_doorbell() all a doorbell address space.

Root complex(RC) side driver can trigger pci-epc-test's doorbell callback
handler by write doorbell_data to mapped doorbell_bar's address space.

pci-epc-test will set doorbell_done in doorbell callback.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 59 ++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 1f0d2b84296a3..566549919b87b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -11,6 +11,7 @@
 #include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/slab.h>
 #include <linux/pci_ids.h>
 #include <linux/random.h>
@@ -39,17 +40,21 @@
 #define STATUS_IRQ_RAISED		BIT(6)
 #define STATUS_SRC_ADDR_INVALID		BIT(7)
 #define STATUS_DST_ADDR_INVALID		BIT(8)
+#define STATUS_DOORBELL_SUCCESS		BIT(9)
 
 #define FLAG_USE_DMA			BIT(0)
 
 #define TIMER_RESOLUTION		1
 
+#define MAGIC_VERSION_MASK		GENMASK(7, 0)
+
 static struct workqueue_struct *kpcitest_workqueue;
 
 struct pci_epf_test {
 	void			*reg[PCI_STD_NUM_BARS];
 	struct pci_epf		*epf;
 	enum pci_barno		test_reg_bar;
+	enum pci_barno		doorbell_bar;
 	size_t			msix_table_offset;
 	struct delayed_work	cmd_handler;
 	struct dma_chan		*dma_chan_tx;
@@ -74,6 +79,9 @@ struct pci_epf_test_reg {
 	u32	irq_type;
 	u32	irq_number;
 	u32	flags;
+	u32	doorbell_bar;
+	u32	doorbell_addr;
+	u32	doorbell_data;
 } __packed;
 
 static struct pci_epf_header test_header = {
@@ -693,6 +701,8 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 	struct pci_epf_bar *epf_bar;
 	int bar;
 
+	pci_epf_free_doorbell(epf);
+
 	cancel_delayed_work(&epf_test->cmd_handler);
 	pci_epf_test_clean_dma_chan(epf_test);
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
@@ -808,9 +818,22 @@ static int pci_epf_test_link_up(struct pci_epf *epf)
 	return 0;
 }
 
+static int pci_epf_test_doorbell(struct pci_epf *epf, int index)
+{
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+
+	reg->status |= STATUS_DOORBELL_SUCCESS;
+	pci_epf_test_raise_irq(epf_test, reg);
+
+	return 0;
+}
+
 static const struct pci_epc_event_ops pci_epf_test_event_ops = {
 	.core_init = pci_epf_test_core_init,
 	.link_up = pci_epf_test_link_up,
+	.doorbell = pci_epf_test_doorbell,
 };
 
 static int pci_epf_test_alloc_space(struct pci_epf *epf)
@@ -859,7 +882,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 		epf_bar = &epf->bar[bar];
 		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
 
-		if (bar == test_reg_bar)
+		if (bar == test_reg_bar || bar == epf_test->doorbell_bar)
 			continue;
 
 		if (!!(epc_features->reserved_bar & (1 << bar)))
@@ -900,9 +923,14 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	const struct pci_epc_features *epc_features;
 	enum pci_barno test_reg_bar = BAR_0;
+	enum pci_barno doorbell_bar = NO_BAR;
 	struct pci_epc *epc = epf->epc;
 	bool linkup_notifier = false;
 	bool core_init_notifier = false;
+	struct pci_epf_test_reg *reg;
+	struct msi_msg *msg;
+	u64 doorbell_addr;
+	u32 align;
 
 	if (WARN_ON_ONCE(!epc))
 		return -EINVAL;
@@ -923,10 +951,39 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	epf_test->test_reg_bar = test_reg_bar;
 	epf_test->epc_features = epc_features;
 
+	align = epc_features->align;
+	align = align ? align : 128;
+
+	ret = pci_epf_alloc_doorbell(epf, 1);
+	if (!ret) {
+		msg = epf->msg;
+		doorbell_bar = pci_epc_get_next_free_bar(epc_features, test_reg_bar + 1);
+
+		if (doorbell_bar > 0) {
+			epf_test->doorbell_bar = doorbell_bar;
+			doorbell_addr = msg->address_hi;
+			doorbell_addr <<= 32;
+			doorbell_addr |= msg->address_lo;
+			epf->bar[doorbell_bar].phys_addr = round_down(doorbell_addr, align);
+			epf->bar[doorbell_bar].barno = doorbell_bar;
+			epf->bar[doorbell_bar].size = align;
+		} else {
+			pci_epf_free_doorbell(epf);
+		}
+	}
+
 	ret = pci_epf_test_alloc_space(epf);
 	if (ret)
 		return ret;
 
+	reg = epf_test->reg[test_reg_bar];
+	reg->magic |= FIELD_PREP(MAGIC_VERSION_MASK, 0x1);
+	if (doorbell_bar > 0) {
+		reg->doorbell_addr = doorbell_addr & (align - 1);
+		reg->doorbell_data = msg->data;
+		reg->doorbell_bar = doorbell_bar;
+	}
+
 	if (!core_init_notifier) {
 		ret = pci_epf_test_core_init(epf);
 		if (ret)
-- 
2.34.1

