Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F76A77277D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 16:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjHGOTT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 10:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjHGOTO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 10:19:14 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C49A172A;
        Mon,  7 Aug 2023 07:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkIO3adiHqWwZim3D4cNcUxtlrcvPA6/AzCbpIUgb5VydLlkK/RvoiSS9f7iP0pVyOceJDb6B1zAtFRjILkIxPJgq58xaT2kK0JWQMmaqpQKgO9Pl4OxJ+ixWWCgZMFPwxJ/kknBZDk+Hp7op8eBMWDt9xDCxgREcvR47eY61smj1KKx++UeyMSobXDl19U1aQxm1z6TPBGO99Dt3xBJIER3NtH57mCXnSfbgoSMVnIu9Gpqcv/Yu1rMeqMZ6NCJAnSehMDHGUsshsPaPFdm6fmP2WLb9RjG8hmxAe7i8tJzHez6QA4m9EWYVJA3ke46OdQZbCWB/ExrTDaiyFuzGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cemv0o+A4B4UVs6IecKdz+P02Zgm4E8Y/XAvJfrdSkY=;
 b=XjD5P08SrTI/1IRmEjINIeuvl2z7CtC1yVYxXuDNJOr5Qa51i1wJPkD5Aee9aExZlgq3ORwc4yigBbRC+fFb4S2j7X8Lu/0Cbfw+RhvjUaVrUvDM+Z4+okEc5Tv217RHmfxCgiEEldUP/nHUdNgWZrrVtQqqqAoxxlotpp/w2gQEIvLarmprRKEqrjKg77DYImcSLlqrkVEsHnQkB/F2Fz1nYOyAKmW8238iIuk0xJiIGqZMCx5ruGUXqp9ygIqeJM/AiYHGhsCDSU8DsIcYkl33Vm89XGyvHPKRxe8H1NSLqCIipjj3crznRxUcQtfsWOMP2UC0k33Wr3v6PmQP/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cemv0o+A4B4UVs6IecKdz+P02Zgm4E8Y/XAvJfrdSkY=;
 b=n/ca41OH7iYGhXcRE+mqGcxsB2xgbU+yNV9W09Z30Bcq9cd1f38NvfL1ppjVUpJK8vtoiOrThSj3JCiLUc5kHXyc0EBoPghlD9bN1JrZypNISn53QbdcDueA2yhE5jRPiViVqzZDHIZgNrxrOgL7Tc/tND/PFXUy7KpwWXRIwUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB9798.eurprd04.prod.outlook.com (2603:10a6:20b:654::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 14:19:09 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 14:19:09 +0000
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
Subject: [PATCH v10 3/3] PCI: layerscape: Add power management support for ls1028a
Date:   Mon,  7 Aug 2023 10:18:33 -0400
Message-Id: <20230807141833.564479-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: bde52dd6-7061-46bb-4714-08db97514448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: izSon6rldi0ZhVZzc/3WSFFvY4ewGHHxflSmwobfrIMZNLg+bbXBqnNhEkjOexGre/M58i8+j5huwvwrl+uoVyyKRan2VnCq6rUAf1L0MVz9Us9qsfGzGApuVw8MKHxWTPUBxc0s/q0Q/4BB5HPstHwuw0gwuU0VUUNoaOQCiGjyAHicntt71Mtf/V7UBcn023fyjG6Qtdcsp/RMsaKhF3qlq6z+PR2IPSFSY6qn/Lg2Eys9Hyvtu9l6xVApfatloxxjNi8ZGc5ZDyLMxfzrcQJLxf4UkpAJZnbaPVA+fceqUlrQa9ERpvv4Usa+bBj4w49eRI8wEiJo8UJCaBPJcb6VsGWqw8jh7juNFHgKNRzMrVY6FqgT9BOD0J/hweYCGYVpNPzyAhHvIAmX1I94ewnwyRfjl18E+pi/gIGQEHoNsAYC+/WlJ2ZCeKeDu+cNFVauYODu8dS5DeAnwWhNgYdSwV/qKCXeCGwZSAF2l5v2bV8d/ct5Eu61WyYIT32Jv6HW6fUhXqcuQETs1wYcZpsAoa6cMZp14AAyBb1prp4Tkh9ja+arkmBbGQ39XuDdNQtOduM66iUCzr7cTgELtAGa3uD+oTn4MBy14Pqi3QRuTQMfJB1l/Hxxk5FEM8DJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199021)(1800799003)(186006)(6512007)(26005)(6506007)(1076003)(36756003)(38350700002)(38100700002)(5660300002)(7416002)(86362001)(4326008)(2906002)(6916009)(66556008)(66476007)(41300700001)(66946007)(8676002)(316002)(8936002)(6666004)(52116002)(478600001)(2616005)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VEjXSkziGkEi+1Mpw8hag4Zj+sW+wxTJLI9xR0cuwNIg3Pv6BkwyOtg0zbvV?=
 =?us-ascii?Q?IvJ6UC7KMgeGxlCvq8vGVz+jf1WX0kTNKRAzSgK+FgYi+TUUUmRNaEWxyIu/?=
 =?us-ascii?Q?STAPHC7+svZ4rHDttm28aedquiKtEUz77CEw/pv45uh9zCltpHUK8NXMvlwv?=
 =?us-ascii?Q?KmkQVfmjvT0EvmQ75Wdj9NkCdXomnqJFct4t1PyUQpMPkNKYeHB2Q5TY3g5p?=
 =?us-ascii?Q?jkWhj43tloSIbH3hBii9F3yfQP1+Fy1Diu1c6ximtq53EI+cXXleyNaEW+GM?=
 =?us-ascii?Q?SiwDAI3Cvqn+LgaT9QNdGAaR+FvT0QQlTyJGkQQelJVtYSXQqW4wN7CrEM9W?=
 =?us-ascii?Q?VVLAvAv3caPYJyU0lOnx5PCHl/0gAAXjPThGfFz+/Lie56fE9PvFnOxX5qyZ?=
 =?us-ascii?Q?8IBqRxdEWOMsoaud9498VpZAVmE5aMnFXxeV612G/6ZfVo7S4PgYNnZfjOMy?=
 =?us-ascii?Q?rn54Wtlik9bKVAr7c7yeH+fCwupi5vB+m1mMcFOuT8kDcoVZHrFHVUOBjNBY?=
 =?us-ascii?Q?cJW1MXuLlTMYhwyNdWDxR4xO+hG1bDe/t6Dq9ODBPARpAyCwqfu6kSBbZSiV?=
 =?us-ascii?Q?5XpoUdPFUKJNcRPMPZ5B/pYxkVAWN/7XYc6b6U/29gd8CMEEJyFNdvCRVyqC?=
 =?us-ascii?Q?7yXaiMJXkFNlMwmwgoalJmr29coV0VBbizA2mmarotxPa1IKlc3TQDyJlq+n?=
 =?us-ascii?Q?dUUdPIOJKB0d4GLyQt/wogOgQ+38fpUm0u4zdY08ddJcY4hjxejp7a8MTCRg?=
 =?us-ascii?Q?helW4n7IYAZJ7JEOh9rnvczkulW4WpTk0h0kawJv97tpoKQYhU35K8AidMqF?=
 =?us-ascii?Q?kGIUR3KHkCnFHXErUCID339Fp1wr1v75tj5T1nv7zidAuVQygwmlrLffXEyr?=
 =?us-ascii?Q?Tz1tBZWRIjarXXsDBaMP1V2NDDzZbq3ZwfQA4sZAXyrdi4i7S7YMp4wphyjE?=
 =?us-ascii?Q?OYlmlsw5r9yK8IUrzRsaffNST2UfWkLMiJ+/CnCWWGIio1aYUQR0DzL4rBko?=
 =?us-ascii?Q?rSkrdas90sXBfpT9urjMnXsNaAcddU7ZYogumNPJIbsHtW/NpAwzJSt75PZV?=
 =?us-ascii?Q?i3H2jBAsjAMX5nJ4jN+J7keirpFxvLZpRxVbXhMNvdQUNTpDPAaRgKI/rRIk?=
 =?us-ascii?Q?ycThDW7PzMIUf1AE4jYkL/q50QAR9CS7ZNU/nhdFvF2/seTwd1GmwtXo6eT8?=
 =?us-ascii?Q?jjYk7+xifs8Hx5HvKJ56hNV5IypnM0xDAE2sTf+k8nAFeIH7hoFY14ycnUsW?=
 =?us-ascii?Q?f6qeQqT6cvso0LPxuO5mwSVG2jsB+v2blrvWvPG8K/4sAmsRZErSJpRA/ECY?=
 =?us-ascii?Q?ltx1ZygbK8ALDT0h+eB6KjL/Zpj2NVQXEp4VhvVbAh9H6UPlW9CZ8xL9Vyg0?=
 =?us-ascii?Q?G/9Y6TuEGRN4cq1cObuKYY0ys8bSMSUBm57r0SP+/B060R37DFptgQmOOvul?=
 =?us-ascii?Q?kaZzvU8B6c7m6WJCmQTKxZS0EW4TDWA0wNRg0EDCll29HZNgkyi18fA7gPj+?=
 =?us-ascii?Q?kYETxHzyMNekZEMveX5Ny6SpLL1ge22hlzC3Hn+jtP/mxwv4x4H4jRoYOh09?=
 =?us-ascii?Q?XzsSNqbNRdj+k6hYp0g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde52dd6-7061-46bb-4714-08db97514448
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 14:19:09.8310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/IJw+PtKGz9bLGb19uhz4GGSoAvl/l7UjIFwfopNa2nOYcWTuZJ+XWijqr7rJD/h2+ANOorl1p/hO7RPKRnVA==
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

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add PME_Turn_off/PME_TO_Ack handshake sequence for ls1028a platform. Call
common dwc dw_pcie_suspend(resume)_noirq() function when system enter/exit
suspend state.

Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-layerscape.c | 130 ++++++++++++++++++--
 1 file changed, 121 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index ed5fb492fe084..7586aece769b2 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -8,9 +8,11 @@
  * Author: Minghuan Lian <Minghuan.Lian@freescale.com>
  */
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/iopoll.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
@@ -20,6 +22,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 
+#include "../../pci.h"
 #include "pcie-designware.h"
 
 /* PEX Internal Configuration Registers */
@@ -27,12 +30,26 @@
 #define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
 #define PCIE_ABSERR_SETTING	0x9401 /* Forward error of non-posted request */
 
+/* PF Message Command Register */
+#define LS_PCIE_PF_MCR		0x2c
+#define PF_MCR_PTOMR		BIT(0)
+#define PF_MCR_EXL2S		BIT(1)
+
 #define PCIE_IATU_NUM		6
 
+struct ls_pcie_drvdata {
+	const u32 pf_off;
+	bool pm_support;
+};
+
 struct ls_pcie {
 	struct dw_pcie *pci;
+	const struct ls_pcie_drvdata *drvdata;
+	void __iomem *pf_base;
+	bool big_endian;
 };
 
+#define ls_pcie_pf_readl_addr(addr)	ls_pcie_pf_readl(pcie, addr)
 #define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
 
 static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
@@ -73,6 +90,60 @@ static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
 	iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
 }
 
+static u32 ls_pcie_pf_readl(struct ls_pcie *pcie, u32 off)
+{
+	if (pcie->big_endian)
+		return ioread32be(pcie->pf_base + off);
+
+	return ioread32(pcie->pf_base + off);
+}
+
+static void ls_pcie_pf_writel(struct ls_pcie *pcie, u32 off, u32 val)
+{
+	if (pcie->big_endian)
+		iowrite32be(val, pcie->pf_base + off);
+	else
+		iowrite32(val, pcie->pf_base + off);
+}
+
+static void ls_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct ls_pcie *pcie = to_ls_pcie(pci);
+	u32 val;
+	int ret;
+
+	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
+	val |= PF_MCR_PTOMR;
+	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
+
+	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
+				 val, !(val & PF_MCR_PTOMR),
+				 PCIE_PME_TO_L2_TIMEOUT_US/10,
+				 PCIE_PME_TO_L2_TIMEOUT_US);
+	if (ret)
+		dev_err(pcie->pci->dev, "poll turn off message timeout\n");
+}
+
+static void ls_pcie_exit_from_l2(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct ls_pcie *pcie = to_ls_pcie(pci);
+	u32 val;
+	int ret;
+
+	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
+	val |= PF_MCR_EXL2S;
+	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
+
+	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
+				 val, !(val & PF_MCR_EXL2S),
+				 PCIE_PME_TO_L2_TIMEOUT_US/10,
+				 PCIE_PME_TO_L2_TIMEOUT_US);
+	if (ret)
+		dev_err(pcie->pci->dev, "poll exit L2 state timeout\n");
+}
+
 static int ls_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -91,18 +162,28 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
 
 static const struct dw_pcie_host_ops ls_pcie_host_ops = {
 	.host_init = ls_pcie_host_init,
+	.pme_turn_off = ls_pcie_send_turnoff_msg,
+	.exit_from_l2 = ls_pcie_exit_from_l2,
+};
+
+static const struct ls_pcie_drvdata ls1021a_drvdata = {
+};
+
+static const struct ls_pcie_drvdata layerscape_drvdata = {
+	.pf_off = 0xc0000,
+	.pm_support = true,
 };
 
 static const struct of_device_id ls_pcie_of_match[] = {
-	{ .compatible = "fsl,ls1012a-pcie", },
-	{ .compatible = "fsl,ls1021a-pcie", },
-	{ .compatible = "fsl,ls1028a-pcie", },
-	{ .compatible = "fsl,ls1043a-pcie", },
-	{ .compatible = "fsl,ls1046a-pcie", },
-	{ .compatible = "fsl,ls2080a-pcie", },
-	{ .compatible = "fsl,ls2085a-pcie", },
-	{ .compatible = "fsl,ls2088a-pcie", },
-	{ .compatible = "fsl,ls1088a-pcie", },
+	{ .compatible = "fsl,ls1012a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021a_drvdata },
+	{ .compatible = "fsl,ls1028a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1021a_drvdata },
+	{ .compatible = "fsl,ls1046a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls2080a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls2085a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls2088a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1088a-pcie", .data = &layerscape_drvdata },
 	{ },
 };
 
@@ -121,6 +202,8 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	if (!pci)
 		return -ENOMEM;
 
+	pcie->drvdata = of_device_get_match_data(dev);
+
 	pci->dev = dev;
 	pci->pp.ops = &ls_pcie_host_ops;
 
@@ -131,6 +214,10 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
 
+	pcie->big_endian = of_property_read_bool(dev->of_node, "big-endian");
+
+	pcie->pf_base = pci->dbi_base + pcie->drvdata->pf_off;
+
 	if (!ls_pcie_is_bridge(pcie))
 		return -ENODEV;
 
@@ -139,12 +226,37 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	return dw_pcie_host_init(&pci->pp);
 }
 
+static int ls_pcie_suspend_noirq(struct device *dev)
+{
+	struct ls_pcie *pcie = dev_get_drvdata(dev);
+
+	if (!pcie->drvdata->pm_support)
+		return 0;
+
+	return dw_pcie_suspend_noirq(pcie->pci);
+}
+
+static int ls_pcie_resume_noirq(struct device *dev)
+{
+	struct ls_pcie *pcie = dev_get_drvdata(dev);
+
+	if (!pcie->drvdata->pm_support)
+		return 0;
+
+	return dw_pcie_resume_noirq(pcie->pci);
+}
+
+static const struct dev_pm_ops ls_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(ls_pcie_suspend_noirq, ls_pcie_resume_noirq)
+};
+
 static struct platform_driver ls_pcie_driver = {
 	.probe = ls_pcie_probe,
 	.driver = {
 		.name = "layerscape-pcie",
 		.of_match_table = ls_pcie_of_match,
 		.suppress_bind_attrs = true,
+		.pm = &ls_pcie_pm_ops,
 	},
 };
 builtin_platform_driver(ls_pcie_driver);
-- 
2.34.1

