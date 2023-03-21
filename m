Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFA96C3677
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 17:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjCUQCp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 12:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjCUQCo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 12:02:44 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2053.outbound.protection.outlook.com [40.107.7.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FD1E1;
        Tue, 21 Mar 2023 09:02:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAjAujM3Q/LpXFVW8uDOLY1u9hxIWIV9GP387VBzo6NocbswOAdr3/V/CojsjARizoYkHmC2Hds3ZOya5aU/fRkd+/fHLOCrfu6LTzDfIh2j79oHN/QNVoVsPTs7MdglTH66WAk6PEovIuw0l3BtteWCnZQKzbxxuAouqqtNefl2pfXWSE5U2R4sxWmKXbCM0DF7Dh7T5YGpOjW3gsnwcw0fSwm6CmOHI3qBK0lm2RTzdSh/ER+BR9mUAYNqRRQwwwDGcQTUpf1fkw2RMc8kH+W9b8XkrMVDoAlVtYLsR23tkKXlVLPcvB/HQKQiJKyNowkrv0QlD03in44zOd0TBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGjv6IL9yZBrGpuf27KognGjoBH1qW3SVofhXkbNPFk=;
 b=ZkfmlVXSwXCF3UWb+zd+G4OmoHBrJav0TQ6yeSK7cjA2y+4/9W2GM92EngLxPLO57wOlMVfB754jgJ/Jqbm6+LuaUuDzfqcDjGmBvJ5Jq5s+/w0n3hmoO04GhgYI1l9QG7+gR1LbSFq3vfddYhR/jc8Z5CPDVGcnc2DJwj4VNDuBnSg3CU8YPXXYasRI3z5Qb8qlVzOwN9qZPtxAfhm9kVgYz9/8IzQ5zTY4r8t+xjU1APtENYcg8OfsCc/AtJ2FTsxaL/qeqXPor8gMcob6yWwrKH6V7fK8nxQBmLOlzFJ9o4hFkofsGkXzAwJcS9yGqqEhCPgO5VTwtQl0P2T5RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGjv6IL9yZBrGpuf27KognGjoBH1qW3SVofhXkbNPFk=;
 b=l8cD591SLr85W4D2/oyTZkMc1ac7CcTvt1DeB32+2d/tqAylgOr4h9jDyiCu/4oe983I+lELwhZBoo0XLwTAE5KFDAQH4IQJPCKFxW8jDNEVf8Vyaqntd+bMmIp0EPyAY4iDbx2PIcrfQJOq8gkbIQby9cPh9gHXwi9f/z+A+zE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8745.eurprd04.prod.outlook.com (2603:10a6:20b:43e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 16:02:39 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 16:02:39 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, bhelgaas@google.com, leoyang.li@nxp.com
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, helgaas@kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        minghuan.lian@nxp.com, mingkai.hu@nxp.com, robh+dt@kernel.org,
        roy.zang@nxp.com, shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: [PATCH v2 1/1] PCI: layerscape: Add power management support
Date:   Tue, 21 Mar 2023 12:02:20 -0400
Message-Id: <20230321160220.2785909-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0050.prod.exchangelabs.com (2603:10b6:a03:94::27)
 To AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: cae675b6-e6ab-4551-0c69-08db2a25b1a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: enAmV2jLY7H36ZN7zczoVjqmlYikZF7oaO3LjsI9sscktVOOF9p/Ne1YBtUUKEj0trSo/kWT1NiZ1c9DD4KFPQx9A69U75PscCO6HyGd2tJ8Y2uQTRGRwhN0MKAEhuzC2MUxNqLWDJLd1Uezq6nwYYW7NHCpcr/2lJFlDLBhMatPEEaAv/yKuMNdw0tm3de2oAhADwLeOV8jlK3qP8fnJ96qcutk5iQqe7sHpZyRaRLgEp3cu1AChdWf0V+O3FmaB5z0lyM5h7nnRB8p0As3n7gawcvjYPNXqfrEakzKaEeOewW+s/1M9z4OxXIuod2pJ54GUtDOqq/4c9iNyjH5ZcThxIBWBaq533P3XbPO6wiMOCAIpTptd4gS7xH++K+SsGT26AesE/3AtX0rqpEfs0XUJEvwPti9PXELePgVB2IQERW3MbDlXDVIdVFATZGXaoHc/2DOCRE1VjzMDVFRmzR3k71jq598iIR3xaqlq0p0wl4QJxmBc/5i0eP+EjzCvvrV4wSWJ4RYts//v+po7y7IZs1EMemUHlW/+jRXDMPU7paZkQI1SCz/rwCpnacvDWCcmxb29dgjP9gg38MDP3YwJYhbO521c4pghjNdJBH8UPiJ1bOcwGlJ01Q4QyQO1EsF+L53vbuZaP680ORddFQlhOegAGNX9Ff5HlA5nNrYjSnXiIlUdDutFClYCkOcXloH4r6fBzNOJityaAC/Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199018)(6506007)(2616005)(6666004)(6512007)(83380400001)(26005)(6486002)(4326008)(66946007)(66476007)(52116002)(316002)(1076003)(186003)(478600001)(6636002)(8676002)(66556008)(7416002)(5660300002)(41300700001)(8936002)(2906002)(38350700002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mPVIOcKSMClB/OPPxPWlK3LkdT3jXLwFaj0xPR/mrf80QnN5a/TKjSr+rVsG?=
 =?us-ascii?Q?pZwN+suKBFyMJ+TDi4DqTlQOL4ScOzxEZkVVydkztUq4xSpFaqFDNEGuEZbc?=
 =?us-ascii?Q?gX8raATUBHYfsGiGczHdctWFXIihKyapQKsi2bJuImJ2aG/GAbAqej8/GKHK?=
 =?us-ascii?Q?v1OIPimSGTyskZO0A+vpXOvabh/K5lhBzffE46pXJYRg2bggKJPBFq/kCUJH?=
 =?us-ascii?Q?7R8S1QmGHYQLBKS0ioMNSRDQivxSoqxop4IF0m+H5F/lUYvykdNYnE7gL/jk?=
 =?us-ascii?Q?TSYq6/DJOwVN78BqmHkTXg6pPTTUY96PPAs1zj9yNnJwgINMDaEf/AtQhLCC?=
 =?us-ascii?Q?5E0KjO/qDA80VkV+CTC3nINBi5eIOCGU+Mhzfna92DswbXEYwEfd0X/nbFGA?=
 =?us-ascii?Q?iFK6MwkBn4p8PkZjd1xbt5X6j1PYKzd62tZpkbrpcfvvOsE+hdr+dOjLlpi/?=
 =?us-ascii?Q?FJtHUlUIlttTm7oKDDey6IqHDMVc3SA96mtpSffJqHe6/7pHiu7Bj7GX6RE3?=
 =?us-ascii?Q?ubAZ+u5gDsUaXRusM2DOz8G52s9DPTl8z8zi0N3udf171kS0irRMN85HtpWm?=
 =?us-ascii?Q?CUuKGf1RLEbHzJ1bevXc7tuh05bt72+gKRfSgMeu6o+ztPKubn6p1rQ1SMZf?=
 =?us-ascii?Q?mgGNKMRulGRxCjrNpPHdLqogHDTtrT3YqOK8xI+UZ/QVAOFyIKUnY02hOie3?=
 =?us-ascii?Q?RI5gq0/o+ky381HUv3kMmBa5gzjUbVObSdKzkKfiji46SRhExciy41Y3vvHz?=
 =?us-ascii?Q?+PBIZXX1gkQcy4GExjza0jEkWq8QS/Itl+/ghDyjbmjVnN79MpYdPvXiJO6r?=
 =?us-ascii?Q?0C8oTqK/qv1qQtj4z30h45X09j/BGJC00ck4Tnwb9oFYwabVyHTTJZJNbC3o?=
 =?us-ascii?Q?3z+jsH6OKi3pX+8fKqDbHNkjhvHwvtvNWTh4Vyek59wCpssCJvEShTupjViE?=
 =?us-ascii?Q?bp6FIDqaXVstt1DqC2E75VeieyV/PCN6YPQsblc7DU+65RqiDWVK8MQAZjNn?=
 =?us-ascii?Q?WUkZR29gsDtRHFquKo6GTkRV1VQw/Y5tiUkwuoa3BE3XFc3KF2wggCBDDDHP?=
 =?us-ascii?Q?LMD5nwcfWy/3hhD8EQ3reB7CnN52TTgQswjNjPpW6kAOk/OFO18NRXHSiRKf?=
 =?us-ascii?Q?8brXfS4vgKbS07rk8AVfT9H4z/L7hSiThA0xCVk0lyfXTcYgXsmE4S/qPwHl?=
 =?us-ascii?Q?KF8I3KHnBqDcPdPn2x3gGxZmi0SoE62mE5CAKPyvnsYn4QXQKrnmeH4GqN96?=
 =?us-ascii?Q?MIPY+/SAVUhGmpl7KlNvC26IFKbVpEfUbAjti48G4JPxjkWjlxlBQ1M8f1rd?=
 =?us-ascii?Q?iqlteFphDQD6tNZ0xkwa+WdwIMpqySl6AjW4Rm1gYJgH8EdEeMz1ZR9gTrKM?=
 =?us-ascii?Q?dQYmWQV2f9cK9tp7n9N2CGNGSUuGKVdkXrErgbcbUz89NIjUqh06JdPtaxWf?=
 =?us-ascii?Q?VuAlWjJvy44pSmDAHq4cv2hfAGY1YluPcd7Kl9Uf/uJl9kz282izk5iZ8mql?=
 =?us-ascii?Q?fLMT62duYLvauLDE5T725wjseQkDH1gxpDqRgfrSYqNi/tD2+D2IuqOO1vPD?=
 =?us-ascii?Q?P44PX+vn+UMxHifCs7XJbj8dh8vnBvMZ2mlhC4w/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae675b6-e6ab-4551-0c69-08db2a25b1a8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 16:02:38.9543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWI0i/GsilsyQAU3ZpjDXGiaPz10MZbGga6ZqC6G6kDVSYuIATo7cW51FDy5d9xtuPKIGojA/G86FpSpeylxdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8745
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add PME_Turn_Off/PME_TO_Ack handshake sequence to PCIe devices, such as
NVME or wifi module, and finally put the PCIe controller into D3 state
after the L2/L3 ready state transition process completion.

However, it's important to note that not all devices may be able to
tolerate the PME_Turn_Off command. In general, fixed PCIe devices
connected to Layerscape, such as NXP wifi devices, are able to handle
this command.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- fixed Bjorn Helgaas's comments
- remove ls1043 and ls1021, which PME is not self cleaned. After check
spec, there are PME interrupt to indicate PEM_TO_ACK command. but I
have not these platform to debug it.  I just can test ls1028 platform
now. 

 drivers/pci/controller/dwc/pci-layerscape.c  | 219 ++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h |   1 +
 2 files changed, 211 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index ed5fb492fe08..5fbc9151ff82 100644
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
@@ -29,10 +31,40 @@
 
 #define PCIE_IATU_NUM		6
 
+/* PF Message Command Register */
+#define LS_PCIE_PF_MCR		0x2c
+#define PF_MCR_PTOMR		BIT(0)
+#define PF_MCR_EXL2S		BIT(1)
+
+#define LS_PCIE_IS_L2(v)	\
+	(((v) & PORT_LOGIC_LTSSM_STATE_MASK) == PORT_LOGIC_LTSSM_STATE_L2)
+
+struct ls_pcie;
+
+struct ls_pcie_host_pm_ops {
+	int (*pm_init)(struct ls_pcie *pcie);
+	void (*send_turn_off_message)(struct ls_pcie *pcie);
+	void (*exit_from_l2)(struct ls_pcie *pcie);
+};
+
+struct ls_pcie_drvdata {
+	const u32 pf_off;
+	const u32 lut_off;
+	const struct ls_pcie_host_pm_ops *pm_ops;
+};
+
 struct ls_pcie {
 	struct dw_pcie *pci;
+	const struct ls_pcie_drvdata *drvdata;
+	void __iomem *pf_base;
+	void __iomem *lut_base;
+	bool big_endian;
+	bool pm_support;
+	struct regmap *scfg;
+	int index;
 };
 
+#define ls_pcie_pf_readl_addr(addr)	ls_pcie_pf_readl(pcie, addr)
 #define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
 
 static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
@@ -73,6 +105,69 @@ static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
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
+		return iowrite32be(val, pcie->pf_base + off);
+
+	return iowrite32(val, pcie->pf_base + off);
+}
+
+static void ls_pcie_send_turnoff_msg(struct ls_pcie *pcie)
+{
+	u32 val;
+	int ret;
+
+	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
+	val |= PF_MCR_PTOMR;
+	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
+
+	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
+				 val, !(val & PF_MCR_PTOMR), 100, 10000);
+	if (ret)
+		dev_warn(pcie->pci->dev, "poll turn off message timeout\n");
+}
+
+static void ls_pcie_exit_from_l2(struct ls_pcie *pcie)
+{
+	u32 val;
+	int ret;
+
+	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
+	val |= PF_MCR_EXL2S;
+	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
+
+	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
+				 val, !(val & PF_MCR_EXL2S), 100, 10000);
+	if (ret)
+		dev_warn(pcie->pci->dev, "poll exit L2 state timeout\n");
+}
+
+static int ls_pcie_pm_init(struct ls_pcie *pcie)
+{
+	return 0;
+}
+
+static void ls_pcie_set_dstate(struct ls_pcie *pcie, u32 dstate)
+{
+	struct dw_pcie *pci = pcie->pci;
+	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_PM);
+	u32 val;
+
+	val = dw_pcie_readw_dbi(pci, offset + PCI_PM_CTRL);
+	val &= ~PCI_PM_CTRL_STATE_MASK;
+	val |= dstate;
+	dw_pcie_writew_dbi(pci, offset + PCI_PM_CTRL, val);
+}
+
 static int ls_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -86,23 +181,46 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
 
 	ls_pcie_drop_msg_tlp(pcie);
 
+	if (pcie->drvdata->pm_ops && pcie->drvdata->pm_ops->pm_init &&
+	    !pcie->drvdata->pm_ops->pm_init(pcie))
+		pcie->pm_support = true;
+
 	return 0;
 }
 
+static struct ls_pcie_host_pm_ops ls_pcie_host_pm_ops = {
+	.pm_init = &ls_pcie_pm_init,
+	.send_turn_off_message = &ls_pcie_send_turnoff_msg,
+	.exit_from_l2 = &ls_pcie_exit_from_l2,
+};
+
 static const struct dw_pcie_host_ops ls_pcie_host_ops = {
 	.host_init = ls_pcie_host_init,
 };
 
+static const struct ls_pcie_drvdata ls1021a_drvdata = {
+};
+
+static const struct ls_pcie_drvdata ls1043a_drvdata = {
+	.lut_off = 0x10000,
+};
+
+static const struct ls_pcie_drvdata layerscape_drvdata = {
+	.lut_off = 0x80000,
+	.pf_off = 0xc0000,
+	.pm_ops = &ls_pcie_host_pm_ops,
+};
+
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
+	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043a_drvdata },
+	{ .compatible = "fsl,ls1046a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls2080a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls2085a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls2088a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1088a-pcie", .data = &layerscape_drvdata },
 	{ },
 };
 
@@ -121,6 +239,8 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	if (!pci)
 		return -ENOMEM;
 
+	pcie->drvdata = of_device_get_match_data(dev);
+
 	pci->dev = dev;
 	pci->pp.ops = &ls_pcie_host_ops;
 
@@ -131,6 +251,14 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
 
+	pcie->big_endian = of_property_read_bool(dev->of_node, "big-endian");
+
+	if (pcie->drvdata->lut_off)
+		pcie->lut_base = pci->dbi_base + pcie->drvdata->lut_off;
+
+	if (pcie->drvdata->pf_off)
+		pcie->pf_base = pci->dbi_base + pcie->drvdata->pf_off;
+
 	if (!ls_pcie_is_bridge(pcie))
 		return -ENODEV;
 
@@ -139,12 +267,85 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	return dw_pcie_host_init(&pci->pp);
 }
 
+static bool ls_pcie_pm_supported(struct ls_pcie *pcie)
+{
+	if (!dw_pcie_link_up(pcie->pci)) {
+		dev_dbg(pcie->pci->dev, "Endpoint isn't present\n");
+		return false;
+	}
+
+	return pcie->pm_support;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int ls_pcie_suspend_noirq(struct device *dev)
+{
+	struct ls_pcie *pcie = dev_get_drvdata(dev);
+	struct dw_pcie *pci = pcie->pci;
+	u32 val;
+	int ret;
+
+	if (!ls_pcie_pm_supported(pcie))
+		return 0;
+
+	pcie->drvdata->pm_ops->send_turn_off_message(pcie);
+
+	/* 10ms timeout to check L2 ready */
+	ret = readl_poll_timeout(pci->dbi_base + PCIE_PORT_DEBUG0,
+				 val, LS_PCIE_IS_L2(val), 100, 10000);
+	if (ret) {
+		dev_err(dev, "PCIe link enter L2 timeout! ltssm = 0x%x\n", val);
+		return ret;
+	}
+
+	ls_pcie_set_dstate(pcie, 0x3);
+
+	return 0;
+}
+
+static int ls_pcie_resume_noirq(struct device *dev)
+{
+	struct ls_pcie *pcie = dev_get_drvdata(dev);
+	struct dw_pcie *pci = pcie->pci;
+	int ret;
+
+	if (!ls_pcie_pm_supported(pcie))
+		return 0;
+
+	ls_pcie_set_dstate(pcie, 0x0);
+
+	pcie->drvdata->pm_ops->exit_from_l2(pcie);
+
+	ret = ls_pcie_host_init(&pci->pp);
+	if (ret) {
+		dev_err(dev, "PCIe host init failed! ret = 0x%x\n", ret);
+		return ret;
+	}
+
+	dw_pcie_setup_rc(&pci->pp);
+
+	ret = dw_pcie_wait_for_link(pci);
+	if (ret) {
+		dev_err(dev, "Wait link up timeout! ret = 0x%x\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops ls_pcie_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(ls_pcie_suspend_noirq,
+				      ls_pcie_resume_noirq)
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
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 79713ce075cc..7de8409e2433 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -94,6 +94,7 @@
 #define PCIE_PORT_DEBUG0		0x728
 #define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
 #define PORT_LOGIC_LTSSM_STATE_L0	0x11
+#define PORT_LOGIC_LTSSM_STATE_L2	0x15
 #define PCIE_PORT_DEBUG1		0x72C
 #define PCIE_PORT_DEBUG1_LINK_UP		BIT(4)
 #define PCIE_PORT_DEBUG1_LINK_IN_TRAINING	BIT(29)
-- 
2.34.1

