Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96FB759A47
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 17:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjGSP5m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 11:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjGSP5j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 11:57:39 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E20CE47;
        Wed, 19 Jul 2023 08:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lT6elCoTotyP1e+HRuVVarguQ9zQARKS71DPCS9ksmsAUZ27vyxhFugxR6j9JYkGGnmSniG8mghGBu6sqJvo93IAR5WQFAdufJzO07VLvwEqnJ12K52Ms6xJtZgl2nHSCcSadR5rkyjmWTUEb5ng/1jdd12eh0WWPZtEHgM1dymUUK3+BcLotFtP3JV9HspxJThV4mXUrIeBYuGj6y5I0oFbTTvDtv4PCoPB1SAV6XNIJC1pDfBXkO6/mP+q6dNNlPhQpDJyYaZuA4GTcwbrkwzQKA2+nE7I3QhAoyU7qP0hW/6GlsfUzebfUpuoEz41H6SisVU9cHEY2qdX0JPpnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6Daic+IBKy143NJIvPCR9+fRCcKKLeKW9qtvvZfZkI=;
 b=TKsqtr+yrxr4o+yOy/sIT+ki1DFTpzO5HCD2tvbuzY2dHZ8Qvs4b7oPNrzREJ1p84vtIRZYX6vbax9Bd8Pi9y2iPWyRd/P6uQ/p2AVu07WIsnPB1QKatyiFJhTQ6t270YwMl1ACxoxL2oCPHU57L29IYInVa0TVaS6ymKLOi7Gr+do7p+epUojVXkvlvncxPQB9Nm2VXLDXXPR6ViMkgj8B0WJabq+4cFt2MFzKSfkjQtIYugqv7Ga2MQ8YXvqdID4csEytDcmwlvkrnWrLpGCcB5ie8x9osMyuVtezHcyGymeo+waqtnjNyguDUmmHSPazHnfd+jGJ1GxSv7n/hdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6Daic+IBKy143NJIvPCR9+fRCcKKLeKW9qtvvZfZkI=;
 b=JoPnAxxhpoWf42+BSmHij25c3DyG65uzMLf6dYmXnlVf5lBt6mJjFBfv5BVXlfHd8g5sl7r/5/lBLYHqADG7NfT9OSudZJIiE6i07xvJq4JG1MOI8AIoNH8xb9l5xiHXsLBveJW7q1OVCHbxwknx71ceZJ6IEa0uPrNwQoJd0os=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBAPR04MB7399.eurprd04.prod.outlook.com (2603:10a6:10:1a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 15:57:36 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 15:57:35 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     markus.elfring@web.de, lpieralisi@kernel.org
Cc:     Frank.Li@nxp.com, Zhiqiang.Hou@nxp.com, bhelgaas@google.com,
        imx@lists.linux.dev, kernel-janitors@vger.kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mani@kernel.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        robh@kernel.org, roy.zang@nxp.com, xiaowei.bao@nxp.com
Subject: [PATCH v3 2/2] PCI: layerscape: Add the workaround for lost link capabilities during reset.
Date:   Wed, 19 Jul 2023 11:57:07 -0400
Message-Id: <20230719155707.1948698-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719155707.1948698-1-Frank.Li@nxp.com>
References: <20230719155707.1948698-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::22) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBAPR04MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: 727afc9a-fdde-42f9-bdd3-08db8870de29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EL3EGK4fpdxPteGAtKYr2+SrnEHOujCY/JWDp63Aeihz5Hjjgqg8S5uhCXxLQnrPORYJlDxYcvJPoEHfz+0fbEi0NJU8uSCxEAEbCkqSjUWS2+qTewcvqlqy9H7NTJXRx6DoH2ZmsaHDSfSPfzIKqN6gYMe2H6O8YcrcDu5URE2zIbVDeZfwoKj3BMOPhmPJIMYbBl5CJEXVV1xbcJq3LU4UHBOU8AZJm56ltzampAF4FDu3IM2AQ1EQyDb3C3skc8zI2aQ37NyeXV0YXOUA1CTK7vw8kpGtdhmqMENHyeN+pzL+4ieOycdNAv6HH4CXm1cNPchX8DSPe4Qb7u63FhVnCCZzfKKkE01+/mF6SBcjr5Lk/jouAFDKKQVf85rXWyNOWKsidvDsLI5xB7rZ4jqpUqvanDci2F5P8QPBPn8niBCmZXt0RlNhrJvyTbE+48wG2hHN91CFymcpbLLdtvE1wSsIoG2z2XvEQQ6Idf9RrDLCqsfewTMYdW8w46CcVDrCtiS4zKjS7p8exMVYMm/MdI77CuEdAm2tGPt7RhflHjB3whPxdXxWgygw7TRoHBQTDpJfQMxeMTlbgsjAwzwGCIIZrKaahLdCOQ8jwdJ90bXaMRDAmfhOBiarbKkD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199021)(6512007)(6506007)(1076003)(36756003)(38350700002)(8936002)(7416002)(5660300002)(8676002)(86362001)(4326008)(2906002)(316002)(66476007)(66556008)(41300700001)(66946007)(6486002)(26005)(38100700002)(6666004)(478600001)(186003)(2616005)(52116002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r2sbUlG3+ypTowdRX4/MwQNZusNjUEWe+qhouJUq1X4J8TDHOVEatqth8EPe?=
 =?us-ascii?Q?wVhC3vs66YZgcxKtD2KfXPDGqIrlcSRuDtrIS0MKSafzzLUHB45suUZM6ryQ?=
 =?us-ascii?Q?EvGQuEJnHJMafuFpht8R8t2lPnbj0wHUXRPKxHd6CCHDVavExn08dEQzw8hP?=
 =?us-ascii?Q?3AHV5XWm20jwpaQRTUsZKElaLX8xfiuTbTv4DuK/79MEvX7qHYAIJsUNDwZ4?=
 =?us-ascii?Q?zfdcHEUnzay0GFSD6poxvkDV3YWSArIMx+qIlhE/SZfnKrE8TnyvQ5mDJlyu?=
 =?us-ascii?Q?gAVw2LUeUfv4wuwUXlDrZw0UBtOv5pPZJ6jtnlwHorSI6oSBgllrNRQ3SvTY?=
 =?us-ascii?Q?3Xuos6WeVunAw9WUL1MXthTBCeWZCQ7ZtSaqMLUUbZXDU3aCDWSwyJd9eZU/?=
 =?us-ascii?Q?6ztddxymtgDVSjdQMxaYX7qv6/5LpJ7MjOyO7yuDAICeTXjg0ZGPM7Qnxcx6?=
 =?us-ascii?Q?4luuBUolW1ffYasvFZt+p3XYmn3L0mbifk6ZZ1chX9w+m1RWiFsqTVvreqea?=
 =?us-ascii?Q?EYfQoCu5fCfy7GaTgne32D+aFiK5SVENuvhokmx1g6qg4+u4SywKCHW2nhFa?=
 =?us-ascii?Q?ycYj3oQ5PvbPyUs3ilNMY6DeIZXnN2v5QQJF/VCHfQwZ3F4V27pIHnfBqe5f?=
 =?us-ascii?Q?hQ+b3QjpXeUo1Qi2uX76q7AcG+tgGojBULzjzQZuCshzFKjj6jvl9jTGngdo?=
 =?us-ascii?Q?c0Ebb2Mpro1l/xRlkX4ziE44nNAz3UetcWfb3FSUZlRu3a1H4oHKJg0Rd3qS?=
 =?us-ascii?Q?4jzq1N6h85VMYWSOmGmrshgeA1MgLa1ydqXD7es1cIGCdy8pDE+mg0KbzWiI?=
 =?us-ascii?Q?eQhblr+ntXjY842Xi3jmf+a8AOEHqde3de1LUnCKvwtzzu1EjrVpvwiox3xz?=
 =?us-ascii?Q?ya9X1BCGWzE1Lb0umr9FyeoB7gXrtTuf3k9jTa3l6SQUJCC6nvoDhhQpe9m9?=
 =?us-ascii?Q?tY7mg2owdOotHJ8t14wlHajoegqCFCAWfzhLB/8ecPx1PsPXdYNfLMeGnLOT?=
 =?us-ascii?Q?otqlauvo/ByI5o5LWe5ZdDETG9dTQmQRvBJqxDeRIvzGeq+i+T08fbtNQqZn?=
 =?us-ascii?Q?wu9SbvntakUQz6XacPe1QoqA/JqMROfYgTbJ1LHeEmGxr0QG1+zFcoCE6BVI?=
 =?us-ascii?Q?KPknV5BQxGQLnzGHwrC9S8kPz+kgR6MLOPM1Ig++87DEkqXMA6NTK4bywM5C?=
 =?us-ascii?Q?pX6lyqvt/9hwZmr3FvPnx9fq++1ErtW7lIKHhvE5dS73vJ7+fJTAMlZ3/3TQ?=
 =?us-ascii?Q?SCSucqLiw3HZf4PBorbcWKEUV0fga17YC1O2v6NKmISxPSEc3BdutO3EcaIH?=
 =?us-ascii?Q?PV69t7F2mxocE9GoL9JHYK0kgm43QiSP58pM+2Ibu0SH0CDqNGapUVcQT6ka?=
 =?us-ascii?Q?YsYnin8fMmEe+CSFoPyrAaCgs22Uh1ej+Yz1eeCL1t5H5AWb8dFjlOSPkF6C?=
 =?us-ascii?Q?WyaIEp74tU3pUwW5VYD2eitzttrKjZZjykeRgSii0kAzEwgy0J3lbBYyByj9?=
 =?us-ascii?Q?nvgbjBzTitxlaj/yhMvqKyrLHJ/nsuB09TXMUkgnfmOLjKeFBpv/Nu8j6H0Y?=
 =?us-ascii?Q?sd8kai3UMaiAD07Ib+0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727afc9a-fdde-42f9-bdd3-08db8870de29
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 15:57:35.6196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rea4yXLnMHiybkNebnnFA5+Mtmo03MDijRuYaPn3Lw7QtJVL9kpaykearym4DuFl8bQEoFI6df+/HzAkkOoN8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7399
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Xiaowei Bao <xiaowei.bao@nxp.com>

A workaround for the issue where the PCI Express Endpoint (EP) controller
loses the values of the Maximum Link Width and Supported Link Speed from
the Link Capabilities Register, which initially configured by the Reset
Configuration Word (RCW) during a link-down or hot reset event.

Fixes: a805770d8a22 ("PCI: layerscape: Add EP mode support")
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v2 to v3
 - fix subject typo capabilities
change from v1 to v2:
 - add comments at restore register
 - add fixes tag
 - dw_pcie_writew_dbi to dw_pcie_writel_dbi

 .../pci/controller/dwc/pci-layerscape-ep.c    | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index e0969ff2ddf7..39dbd911c3f8 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -45,6 +45,7 @@ struct ls_pcie_ep {
 	struct pci_epc_features		*ls_epc;
 	const struct ls_pcie_ep_drvdata *drvdata;
 	int				irq;
+	u32				lnkcap;
 	bool				big_endian;
 };
 
@@ -73,6 +74,7 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
 	struct ls_pcie_ep *pcie = dev_id;
 	struct dw_pcie *pci = pcie->pci;
 	u32 val, cfg;
+	u8 offset;
 
 	val = ls_lut_readl(pcie, PEX_PF0_PME_MES_DR);
 	ls_lut_writel(pcie, PEX_PF0_PME_MES_DR, val);
@@ -81,12 +83,25 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	if (val & PEX_PF0_PME_MES_DR_LUD) {
+
+		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+
+		/*
+		 * The values of the Maximum Link Width and Supported Link
+		 * Speed from the Link Capabilities Register will be lost
+		 * during link down or hot reset. Restore initial value
+		 * that configured by the Reset Configuration Word (RCW).
+		 */
+		dw_pcie_dbi_ro_wr_en(pci);
+		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, pcie->lnkcap);
+		dw_pcie_dbi_ro_wr_dis(pci);
+
 		cfg = ls_lut_readl(pcie, PEX_PF0_CONFIG);
 		cfg |= PEX_PF0_CFG_READY;
 		ls_lut_writel(pcie, PEX_PF0_CONFIG, cfg);
 		dw_pcie_ep_linkup(&pci->ep);
 
-		dev_dbg(pci->dev, "Link up\n");
+		dev_err(pci->dev, "Link up\n");
 	} else if (val & PEX_PF0_PME_MES_DR_LDD) {
 		dev_dbg(pci->dev, "Link down\n");
 		pci_epc_linkdown(pci->ep.epc);
@@ -216,6 +231,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 	struct ls_pcie_ep *pcie;
 	struct pci_epc_features *ls_epc;
 	struct resource *dbi_base;
+	u8 offset;
 	int ret;
 
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
@@ -252,6 +268,9 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	pcie->lnkcap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
+
 	ret = dw_pcie_ep_init(&pci->ep);
 	if (ret)
 		return ret;
-- 
2.34.1

