Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A4C772779
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 16:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbjHGOTP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 10:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbjHGOTI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 10:19:08 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2066.outbound.protection.outlook.com [40.107.6.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2988C10F0;
        Mon,  7 Aug 2023 07:19:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqMxQhuqwllmWSXsHZYXlG+lI1n/NKP9utZ3jZ0rr/cC5JIiUzdmHcUlqOqGygr5B5VQ3KwChEj7uwpoiyaLWXnP7ze/OinjQSgBpOMJ71rGrsWCmbY9ckgnqUBNkdL8vQnNuZy0qXj9L5Bh+NmIi5NT5vVvG25CszckIeWQiouYnUV0BPg/bXyVo01ze9U9Vvb+sEQWLJUYvOeNyuKlVMfUBl7eg1t+qfkjyQSvs+//ZdaRjRACPUNmCaaa2ZKfaB9UOHaq1gFbHjlX2mNaPxmhKUv5v/Q5TAFTFXiQsSshR+xUqMSAR2Qy+y17dxUs0nMiCKKOksSaQPwJ+zLFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuZYozsszV04m9+f6PLw4EoD1EIVUX6sjonI35T2M80=;
 b=Lgls4P+1I3PMSt3Wv8bwTEF7n3JVPXk9cKSpSYvYM5OukMurljyVVb2jGtjmMCDuhuw/71prkhvYsc1REQFJPWLLBJKHG3kGTgvqvV9/OGRkWLhnOzPR27wIYhTVpM3WQXGnyO+t9zLC7F6h1zX/JfaEuJe+3uLyBkwHEOC+ldIhbechf7urNKVLAeBfhZz7cEK+f/y+YKdAQ2Y6LEOU5bhXRN8euVN1c18KeGq6dAuyQElgxh3U42PLpHNZjzDKnMPnemCZ4O3ZpQ1LBqgOuwEd0WEcnO0RXaxT6IzP3JsCzvKsPofahirYGjEOhLhoMPu1OWzUyXXeeLiwYppy1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuZYozsszV04m9+f6PLw4EoD1EIVUX6sjonI35T2M80=;
 b=pe+h2odG3BIF1A63qQIW4A+9GHP01ZVFKgM/sMRhmARmfXwWt814cfehj+l+bvU+PQk2dP6V0OrLYway7zqEiCdTltGbeQMCICix02ZEhZCKJEc0fpNAPiJsON9QNzU6TE9OTNJ0OiBDZx6NUH+3SEMNoafC0rjZeSyjmJFgSOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB9798.eurprd04.prod.outlook.com (2603:10a6:20b:654::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 14:19:04 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 14:19:04 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     helgaas@kernel.org
Cc:     Frank.li@nxp.com, bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, imx@lists.linux.dev, kw@linux.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        lpieralisi@kernel.org, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: [PATCH v10 2/3] PCI: dwc: Implement general suspend/resume functionality for L2/L3 transitions
Date:   Mon,  7 Aug 2023 10:18:32 -0400
Message-Id: <20230807141833.564479-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807141833.564479-1-Frank.Li@nxp.com>
References: <20230807141833.564479-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0057.namprd02.prod.outlook.com
 (2603:10b6:a03:54::34) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB9798:EE_
X-MS-Office365-Filtering-Correlation-Id: dca6eb67-2556-4cd9-3d87-08db97514146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KfuQKC+nxnEgEq3K6Ivxz7yORx3xKGTVANl7oM5EWYaEDKGb8y+O4oj2jPL2IKEzdq0mslxgSZHf04nTxJ64tnkUv9442ftiO9+WNs3P/IJcyhrCPeY8xpPvqW5KE2rndl8mg8rvepeWTi81RdUrTsu3ZIDTvh4tKINtlKVdFun0HkvmU5OWNEGY1BxL4JQEcrtFu/y6fjjub9nptIn8On8ISGNaCDYu1zJ5Eul16nFdIZuqKC2cEeuq66q9imeHa5IhGjN3Ma/vT5EkIM4cacuLjiFdzSxqOjhwbz4uFZuO16EKcTmhMF95pnovL0BxaPyC0a03+RmoY8bmYG9RFmIX2dJ6SbZsZZTXsYtppHsnqs7+geAhQki/8+y7yrRJbv1A3kG4uLaRx9X2nUfrf2Olom9WQdBLPzItusEs9//r77ITJrua2L9MvC1zuKYJA3J8bFk7RJ3zEeAHokj7hvvTzYwDt5VdMgOdQFmwX9OIQ3Rp8Y3XjS5YAFagFn7FhINaI2N2/OWBLAwd4D3VvybDZxklsh/vlHXZp6CAPxe2TshTaVVxYiU3TJRyHduEP7uqkngmUJC5gREvGTd5i8jr4F08M4fphZIuFpJmqKzmLF9u63I+t66u84G4imaS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199021)(1800799003)(186006)(6512007)(26005)(6506007)(1076003)(36756003)(38350700002)(38100700002)(5660300002)(7416002)(86362001)(15650500001)(4326008)(2906002)(6916009)(66556008)(66476007)(41300700001)(66946007)(8676002)(316002)(8936002)(6666004)(52116002)(478600001)(2616005)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cUvjwTXkueofUC0zBpFrw4a/dSwt2rdQZ2cCUHD+0sAtR1Nmq/Wido/ANVu1?=
 =?us-ascii?Q?ut/JLTynbIUzsszRnaMTMvDWicEyr3ZstOZFVuOE+tCMLygdJBESKu47T146?=
 =?us-ascii?Q?sqlgmXgIkcnxNJw3BoHJOOyEBotLe+1n+b94eJbuX/7A7F2jlIO+BkWbtFLx?=
 =?us-ascii?Q?VuLsRfDWk5O5Ag6Q/OtXBgSIs2twVpCoVQrzb7hXUyIyJLoxqufFzx42yIcG?=
 =?us-ascii?Q?4lJfJRYwSyIIm4szUnH04pFCyRKghdjZBmLfONJkYsFS1aaNusPY900LOFue?=
 =?us-ascii?Q?rigz+Y9R5eKkjP0KU3GpOgfBoDT0blTeK5BFaW6EqZY4cb3TxnfH959yAKuU?=
 =?us-ascii?Q?4Ple5m16q80K4fLr/KkxxOS6BLrKb8bchHf8ha1G8mM0Y126t8u2MkZUWmK/?=
 =?us-ascii?Q?FKrcrj9Vyhp7MX7cd9FoA8bgttpPcHas3+J6Gpe2fA2eGzMj2EusFNKG9zi4?=
 =?us-ascii?Q?VlZCXI/hVMyUZDKdUyTkrKjRfiidNsaIziSRIDFgb//Tb0rt7yzPBu8I4+BZ?=
 =?us-ascii?Q?xHMZxv5u9F6epOIODOmdE1+zPfp9lC0glcaFR7etPfmvg5kxGkOjMQixNYC8?=
 =?us-ascii?Q?DfhOD9kmc/DkZKzvkLaTZP1otNlL2ZerWfYxGIzCPb7jVkGcpW6b3D59ZJQU?=
 =?us-ascii?Q?t6c3QL9Gsk1+OQYS8WF5zLS2UOAhWErsd3z0GGMu8knpobvgM2a4cQ5ZZq9x?=
 =?us-ascii?Q?yRoc3lAlYwMLV5QolfWZ3iLouSpj3+LF7jXIN1iXpgLqErcOF9G5HBOrZiGL?=
 =?us-ascii?Q?//02pSou1dXaGdaDzM3RwmhTM3JbYXUAA7E7/Myh9Q12jAbHunRSilRG83AH?=
 =?us-ascii?Q?ZVYys4KHM3SrZ0+XgoZmB3rnFditdUgdCL1mTwTxqKVitRR93hgasBq5KODV?=
 =?us-ascii?Q?c0N7La2BgxnHtiP6zyGcnMeqWqs2//WsYinJ5hgNfL1zb9TsjaCpOCltn73S?=
 =?us-ascii?Q?ttqXpjO8sq1kbbYoBZjpj2VCxKQ57vHmUPWsiHARNL1j7uKTDEADUkUGaiBv?=
 =?us-ascii?Q?XIqSQBGmD337LhQz2NfD3pqjisQUTQ+IVEQd/3zvUo3MCoDQhx6Qrzn/h+/v?=
 =?us-ascii?Q?1ebYQgRjtV/iJrl6WOfDVnYytK9mdHN1xSmYuq2tWbKVenQMY9CqtbEu/hmB?=
 =?us-ascii?Q?2Kqx+QXF1dhIeWfim9QOJZXjdvrIvDbE5L6rPVpm9zYsUjMylIycYd0yPyIY?=
 =?us-ascii?Q?uPDXTQfCTzxilRsliUJhQB5Bq14mM0G+fpgstuSyQxP9Ugbxq1OYd3ZmFaDR?=
 =?us-ascii?Q?6WQFuTKusJFbPfh3w5iwIjsdTPWT4zRlc6FZ6EBrSSryiqrRsUzV9rKzBWTd?=
 =?us-ascii?Q?5yuDSKaSrhFvXjDNT0alggPmxN3sfRoiNZaxb9h5eXi/Wryq6a6qRkoWwAnD?=
 =?us-ascii?Q?XBsR+6yvxeej0/0le38Xifgf0KWbFEsWPl8m9Fh0OZyqiVMB+JiVpP4IzMkq?=
 =?us-ascii?Q?8U4hh/GtC7wH5quW2/3hrnNGpM+QD7xGvZnRWzQX0R1oiowbSyd0aYmZ6VU4?=
 =?us-ascii?Q?cpOkLoEWvpO5+RP+II0zfe3gGiDXe+HbkSlWScZTHQoDCXMFpBowYod7rxHY?=
 =?us-ascii?Q?XK9gyNPDGTifHORo5BI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca6eb67-2556-4cd9-3d87-08db97514146
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 14:19:04.7869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dxly7dSKueQ3yVjR+vh9HYN+Kl4NFT10A1XMN+NOfpC+caHxSr+Jg1Z3l+YKYSDHB1xoyUZ9OPOuhGLeNQWhJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9798
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce helper function dw_pcie_get_ltssm() to retrieve SMLH_LTSS_STATE.

Add callback .pme_turn_off and .exit_from_l2 for platform specific PME
handling.

Add common dw_pcie_suspend(resume)_noirq() API to avoid duplicated code
in dwc pci host controller platform driver.

Typical L2 entry workflow/dw_pcie_suspend_noirq()

1. Transmit PME turn off signal to PCI devices and wait for PME_To_Ack.
2. Await link entering L2_IDLE state.

Typical L2 exit workflow/dw_pcie_resume_noirq()

1. Issue exit from L2 command.
2. Reinitialize PCI host.
3. Wait for link to become active.

Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 76 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  | 29 +++++++
 2 files changed, 105 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9952057c8819c..cdbff11a7d00e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -8,6 +8,7 @@
  * Author: Jingoo Han <jg1.han@samsung.com>
  */
 
+#include <linux/iopoll.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
@@ -16,6 +17,7 @@
 #include <linux/pci_regs.h>
 #include <linux/platform_device.h>
 
+#include "../../pci.h"
 #include "pcie-designware.h"
 
 static struct pci_ops dw_pcie_ops;
@@ -807,3 +809,77 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
+
+int dw_pcie_suspend_noirq(struct dw_pcie *pci)
+{
+	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u32 val;
+	int ret;
+
+	/*
+	 * If L1SS is supported, then do not put the link into L2 as some
+	 * devices such as NVMe expect low resume latency.
+	 */
+	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
+		return 0;
+
+	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
+		return 0;
+
+	if (!pci->pp.ops->pme_turn_off)
+		return 0;
+
+	pci->pp.ops->pme_turn_off(&pci->pp);
+
+	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
+				PCIE_PME_TO_L2_TIMEOUT_US/10,
+				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
+	if (ret) {
+		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
+		return ret;
+	}
+
+	if (pci->pp.ops->host_deinit)
+		pci->pp.ops->host_deinit(&pci->pp);
+
+	pci->suspended = true;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
+
+int dw_pcie_resume_noirq(struct dw_pcie *pci)
+{
+	int ret;
+
+	if (!pci->suspended)
+		return 0;
+
+	pci->suspended = false;
+
+	if (!pci->pp.ops->exit_from_l2)
+		return 0;
+
+	pci->pp.ops->exit_from_l2(&pci->pp);
+
+	if (pci->pp.ops->host_init) {
+		ret = pci->pp.ops->host_init(&pci->pp);
+		if (ret) {
+			dev_err(pci->dev, "Host init failed: %d\n", ret);
+			return ret;
+		}
+	}
+
+	dw_pcie_setup_rc(&pci->pp);
+
+	ret = dw_pcie_start_link(pci);
+	if (ret)
+		return ret;
+
+	ret = dw_pcie_wait_for_link(pci);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 79713ce075cc1..629bccfa92ddd 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -288,10 +288,22 @@ enum dw_pcie_core_rst {
 	DW_PCIE_NUM_CORE_RSTS
 };
 
+enum dw_pcie_ltssm {
+	/* Need to align with PCIE_PORT_DEBUG0 bits 0:5 */
+	DW_PCIE_LTSSM_DETECT_QUIET = 0x0,
+	DW_PCIE_LTSSM_DETECT_ACT = 0x1,
+	DW_PCIE_LTSSM_L0 = 0x11,
+	DW_PCIE_LTSSM_L2_IDLE = 0x15,
+
+	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
+};
+
 struct dw_pcie_host_ops {
 	int (*host_init)(struct dw_pcie_rp *pp);
 	void (*host_deinit)(struct dw_pcie_rp *pp);
 	int (*msi_host_init)(struct dw_pcie_rp *pp);
+	void (*pme_turn_off)(struct dw_pcie_rp *pp);
+	void (*exit_from_l2)(struct dw_pcie_rp *pp);
 };
 
 struct dw_pcie_rp {
@@ -364,6 +376,7 @@ struct dw_pcie_ops {
 	void    (*write_dbi2)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
 			      size_t size, u32 val);
 	int	(*link_up)(struct dw_pcie *pcie);
+	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
 	int	(*start_link)(struct dw_pcie *pcie);
 	void	(*stop_link)(struct dw_pcie *pcie);
 };
@@ -393,6 +406,7 @@ struct dw_pcie {
 	struct reset_control_bulk_data	app_rsts[DW_PCIE_NUM_APP_RSTS];
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
+	bool			suspended;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
@@ -430,6 +444,9 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci);
 int dw_pcie_edma_detect(struct dw_pcie *pci);
 void dw_pcie_edma_remove(struct dw_pcie *pci);
 
+int dw_pcie_suspend_noirq(struct dw_pcie *pci);
+int dw_pcie_resume_noirq(struct dw_pcie *pci);
+
 static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
 {
 	dw_pcie_write_dbi(pci, reg, 0x4, val);
@@ -501,6 +518,18 @@ static inline void dw_pcie_stop_link(struct dw_pcie *pci)
 		pci->ops->stop_link(pci);
 }
 
+static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
+{
+	u32 val;
+
+	if (pci->ops && pci->ops->get_ltssm)
+		return pci->ops->get_ltssm(pci);
+
+	val = dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0);
+
+	return (enum dw_pcie_ltssm)FIELD_GET(PORT_LOGIC_LTSSM_STATE_MASK, val);
+}
+
 #ifdef CONFIG_PCIE_DW_HOST
 irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp);
 int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
-- 
2.34.1

