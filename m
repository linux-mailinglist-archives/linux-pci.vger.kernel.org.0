Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C5B776408
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 17:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjHIPhs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 11:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbjHIPh2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 11:37:28 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1f::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC758268C;
        Wed,  9 Aug 2023 08:36:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0NIJjDtOnQ9MVYXT6AV3A8kiLL6NS1mbVvlX9u8gL6UhteZkUzUADx5q6AihGU7sON9g+W00SzXxRzCDa565j2+9Mw+WU59NSWRIllGXqPar62YPoJGzYhakRvKGK0XrDhVtVa+41IzFX/YN1OA26VkvgysNXolr2uhMFHThBuNzS09us5fEpt6YFnortqIHrpL5JgfZfZkWgxK3OvW2H4lqqTHI9n84Rdqs6g1uy5umDJtcxmchG0TR9936Hr0NQ9c7LiZ54LEmLt8ut7AJhKPS2ytvOPcwZdEuFx0AFiAEWV/Mo+n8IOSD5vnimODeyvTdG3HXd28hHyJ6es82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5XqlhIvj0wmCBLbDTFuS8VlJYDc/6v3lmGOHTjA4SI=;
 b=RdnE35RLT5lzNbxda6Fi52XH81pt+VwuWIdaF9zQcdtNJ9gwAwEzGaA7iuxBRzKP5cPAVINtr3FPpMVbbVjNOaBwh2mWz7dVQIwbbx0OJ+AiD+vqw1eyyxT4RwHsTMbXIo+q0WL4K06DYcN+WLx+9hb1HC9d2tnnTWL8TCPTdNowA4yWanYc7FLsqbS/dSqWGEI6nvG054Fi/kkAUExamq6VuUzu4geHptH8PsjHRjWKzxSqWtwYAfeREon882HS3KI6Ha4oMjq5yp8s9RzWQ5kpvQ/QKKKg/D9K5knphkLblAQfOfpAvRagJXRvigyj+IlCCJyqFWc5K3CszLgVrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5XqlhIvj0wmCBLbDTFuS8VlJYDc/6v3lmGOHTjA4SI=;
 b=YSCztjCMA2y/UxUdCFSCL2weuEBedvFqpmcHOSteGeIW4JNgnz5uY3j4BDL0eRwqp+jGEy8dunbfO+V8mwAY5GiQ/MrT6TwGfnAVMlGYXpMNr1GAG1BiugyGZK0LVTm2kCvlkBhG+T+vEuHVIfzQWv43razCFVYUx8YYvDnAlWc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB7161.eurprd04.prod.outlook.com (2603:10a6:10:124::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 15:36:19 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 15:36:19 +0000
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
Subject: [PATCH v11 3/3] PCI: layerscape: Add power management support for ls1028a
Date:   Wed,  9 Aug 2023 11:35:40 -0400
Message-Id: <20230809153540.834653-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809153540.834653-1-Frank.Li@nxp.com>
References: <20230809153540.834653-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::28) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: f06533cf-54a9-4acb-ca2f-08db98ee608b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YG63MEe6sV6LSmc+HwNE8Z7JHHLF7t2uDKe3V5anQjKBsJNVhaAPOd37p5BUdLlLRz+nXYNVorNlXN8xj6/6QXSzaUqY2nSZOmR2lHAaXPveXkL4CRvaG2eGAFfNSW4hd1fsi/bp2sRVez/PIhrzw1hAoJyavspKOzmnq3zI/dB8/E9ypE8sKqWGtI9qIP4ekFsxfNFmSKyGA18ztf/YVYCGiVJFtZQrufoMza8tWEikaygGssDWLlT/sihJBULBnk7Qsu0uWo4nARaCUlSnPGHM4QO7mXe7jLnl9I+Qv9VrPEzNUvPIy7aUBtv7uB7K648d+Etm28gSHhELUdD5PebH5VdllTtt+euVa0OCjk/WJK1ncyXzFopTZ5YkyUk22buS+AOtwsH7715KHAAUjh4Po0WAII9Vd+37tvzP3alkPyvofU4w5m9HIe5MAH1MLKHbM9GK5hn7LVh69jD9qMZ11Zm2LOq5yMtoftMhPBlTAdPB4ktSDYPKE52lYbfAkWQD8ZnTQliggvUkhcqoBotmVe3bpP10j9Sy5uDl3beFUIkAwtSBLUFPkQ/D2fh6wjb9ZUedD7SAvvNrFFlrWkSQTDUgcXo8twPbRpMveAMA60Exuqo02t1c77mqnb33
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(186006)(451199021)(1800799006)(6666004)(6512007)(1076003)(6506007)(26005)(6486002)(52116002)(66476007)(66556008)(8676002)(8936002)(316002)(41300700001)(36756003)(83380400001)(38100700002)(38350700002)(86362001)(5660300002)(7416002)(2906002)(4326008)(6916009)(66946007)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9hBBSccPrNCRl100DQD86l1ptTkytZ2KxK5+MSmu3vnyEXtYB7Mukxi8O8cG?=
 =?us-ascii?Q?TtGWLSDW76lzH9kBqMY877lZaG3VbCesnFkbXkB0mUc3ZciPGlQ5cgNjGNq7?=
 =?us-ascii?Q?/sGtfLDDulnzU6C788OsSy5ztnnbCQNyd/Aw/BTU4QkyyvpXMWlqe/hySV0o?=
 =?us-ascii?Q?JDNdwaOwSssCipAOM/GAMTBtyC/KwAudogt09IiepLrIbwHQyu+xE+43Jf8F?=
 =?us-ascii?Q?tTt6FzBmriGD74XPh81Jz5eAIYfwY7DY1b+Y+gIzSyYqDMJDa5rCRbBvkWNH?=
 =?us-ascii?Q?TwvuERMNeMUREA9cN7eDmNQCIY1jnNuUKDNlnrYbHQl423nM3hIkgks36qMH?=
 =?us-ascii?Q?SoO3JaekwK5MK7JGLT5laAEPA5Q+4RQvuYrq6iGpfEfkDIKWGSsWur5VvPOJ?=
 =?us-ascii?Q?a7LiUytaRppFpIzhpcYAByJeEWz9/Jf3hUF8jHFNU9wa6F9OSwbh0sSJeCX5?=
 =?us-ascii?Q?IQVRFfaPj69q9N7sBaE4fTEX67ZKBOB94Nptzj1qeGoB5TA4IlhGn+pCJHwk?=
 =?us-ascii?Q?n2Xxb2FbOO01WLEbeU4H0yP1lr2kbB/roA25lM8A3zfGbuuP6DDLbeGRVw/+?=
 =?us-ascii?Q?XH/MaXxweiL8zWyyBjXw9K3teEtG8QP7tfI7MciJI/r58hZT4CqbVSgd232j?=
 =?us-ascii?Q?3v4i4h+FxblkFi0dE63p9nkIDxhHcna3P1iqjucMVU/BdVqsmoPUDVRmvvUk?=
 =?us-ascii?Q?xZK7A4uaqVPo4Z9wfvW9MHZE/nE1Lt68+iovsnBMi+bMBbceXNGo62n/ZkuR?=
 =?us-ascii?Q?3rhMaRmeIIxrehtvkBvOeQJMrXxVgyq1N07AXwNXV5rRQNRr9LcnwbH+I7U8?=
 =?us-ascii?Q?YmAE/mHJt6wnzuLpETsNK+LY95x959/feDLq6GWItUQk6Rw6wEz2+VlXHKOJ?=
 =?us-ascii?Q?I7cyvt/LEzWvpO8cM0yvc4aHeAS9V2i5wG1l7DlufuwizoCgEgkt7j7aUqvV?=
 =?us-ascii?Q?MTVg7uhNX0KVqkqMRFC2ots5md7S+Wc4yZVZapkDgkiQOu6lT8x/J7hDDBfk?=
 =?us-ascii?Q?t70XUbyHpGIGujpAC1EKZSnGc9JrJhhthyUJncgTaoxN/TGuwSbjA8hyLgHQ?=
 =?us-ascii?Q?dDJBww5dSLejXJvu5pYgv3kftPux6kScJ6vL1KpbsJfaKr/IfgEgwsKgZjfc?=
 =?us-ascii?Q?smXHuxfCazbh/V4VWfuNLv0OBxgyn0Kj5VcIuZWpjpmVg8IoAMpr79WbzOJC?=
 =?us-ascii?Q?563WjAoeym/efpVitadDMhGBPE1FtQ/ypdYNhnoTkJ9+aCMT/fy6sPSjG226?=
 =?us-ascii?Q?LT2WP93EzvXNbhGVK+OE8X23OU1C4LBbr9nVk5o2jCYKN3UhgQ7hEd6r/Udf?=
 =?us-ascii?Q?/O1VRs0kdU9Gq0fK3K3nJdeI5Tk9k+dgZlQhuWrBs2AovQKYKhSpcqnDn2eJ?=
 =?us-ascii?Q?y7TcGj6McKagU+4xO97gDCrJxO1zv+WImAZ2kpRuy/VMKTdBeugkxGVnCRpI?=
 =?us-ascii?Q?WxQBjK1TW2b2sXrPjGbny0GhN16iDmE6ogJ/b5dkt6DK9Ap4cKLxiRKG1Y/V?=
 =?us-ascii?Q?SWgkblW23IMdurAUv1WnmxUhqec8e7nW/HCg/+oV0qvh5caTac5pAVG/shUJ?=
 =?us-ascii?Q?E8J36r9y7GrgXSe37rA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f06533cf-54a9-4acb-ca2f-08db98ee608b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:36:19.4187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 600BUEewzv4mIZqpsNYInJYLI+WHSb77F8jxBAho1B/JJn+IUSKCk8nhNELa1odZyK0HtyCgXX8oKUn52G/+aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7161
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
index ed5fb492fe084..b49f654335fd7 100644
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
+		dev_err(pcie->pci->dev, "PME_Turn_off timeout\n");
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
+		dev_err(pcie->pci->dev, "L2 exit timeout\n");
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

