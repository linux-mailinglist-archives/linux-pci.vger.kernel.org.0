Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF11783078
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 20:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjHUSxO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 14:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjHUSxN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 14:53:13 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D176A24C;
        Mon, 21 Aug 2023 11:53:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9ae8hjFC9sL8BwJh3d6z54P1AUUU2XruIdtkAZzEotFLpqYJmHGbydM6HPahUhnKAPWyV1kyhvtLK39NctUSJbnJzrSWfB3OgQ5HEanb04OfBjds5akFBwR5r02vfhGggX6aU8PPvISd+tlwMDnk6ri7mpIPczzPFRZ+fNwhrtB1TFXysJm5EoPCglDY94JdPE7JVKpSYJQ8kph2DV750Mjv2x7gTzEcbk0KTzKoORuw0Ugqa7/27E9Mwoc4RgDSkv/c6433OJHSoj7ulhoUHM0xdC3EuLaInJ8Lf1LrFxYGPZcBmqTawJ41m3uJCS00IgM9g3JVW4spQTRtvejGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHMaH/4kxsdx1QZ/NpZYByEUDHKdk1r646t1LOIrrS0=;
 b=b8YSEeN+sOY4CAQb+8+5SlRkRioh1YMatfADLknXjMUAjDmzLDE6rOOFLeJKoTPmmogpAhPr+MmarZxdbhp3YYGK4oyi1MH3KQ7K9x1FMx8CF4UwowudByiGtkGnNtYYNVa1t0uHkQXL07uIY9w8E8ptmzH0VUrizrvX2p2rg92XlTKUST//2/uuUB4lTlbJgDjM1MdEGMt3mHLUt/s48F1JKx4rWp8xANkmqbmdSxWcvHFR0Qjo2wQUy5Vekerq8IPbcroIrlFTBsAPNqPzkhbBNFhxheAwiZAAE0L94orfhhTvTCKLGWRDsiryPkjL9Lhi9Tq3/wJgkm0enCYKJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHMaH/4kxsdx1QZ/NpZYByEUDHKdk1r646t1LOIrrS0=;
 b=RNpaflWYPRjiOIu4cz6/EyemLkQM40408DsqlHRiYbIVawUhf70WC3BDmb+3KzRVqxQUE0LMjU5tVHPy1GmvaR6ELmwMshYA49udYovKXLb3OVFNEUs5vBdr4AmR0w6AXP35IxsmJX0Rw/2dGuasLDE+6mZG0Z+SiICwyl0b6Cg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB9566.eurprd04.prod.outlook.com (2603:10a6:102:26c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 18:48:45 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 18:48:45 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, helgaas@kernel.org,
        imx@lists.linux.dev, kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: [PATCH v12 2/3] PCI: dwc: Implement general suspend/resume functionality for L2/L3 transitions
Date:   Mon, 21 Aug 2023 14:48:14 -0400
Message-Id: <20230821184815.2167131-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821184815.2167131-1-Frank.Li@nxp.com>
References: <20230821184815.2167131-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::27) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a28ce1-2525-4939-a2fb-08dba2773faa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zteWQFNeeWZTKCyvDvcL6Obg5nN1+reMlEwsnHmiZuDQR72K+I4VN4vkXLPvPPBs838WIZRsuh3ukoaLfC7+JfWeJDPaSey3zbI6wRnPSFIJlmxlrKd3BykY1Oz96dNTwiLMKxoipapQ7uLPTPmuMxGFGsheW994H7nHYkIZO9qvBvDLwVGKL2aZ9UtH9qldGgdyFdR20RExaxuKm7HyZdpWi3u7ifFTMOotyMMxcqFFcYMH+m0fXefWUc7nGTRpQEu/ioitFkXwqR+GXGNX3KtTF/eScBaep43I6fGA181AUa8a+uMgwwOnct9Qah1aYuA5hHqcINRgd9XxV+ws+K9qmuhxiQtZO/LROSCiD/rqG119TnqysThfgKt9CIvFL5/Cm+oS1HnhDYfIMF+wPRRd80UckWZBxPQjOcQp2iffStWhU6m+o/xKlLmgckU9iWR590JzmxU3QYHHt0u6NYDDDXaiBPUF8mtJUHPmKB6d3+/vLrUkZt3C3PuZM5rXKzTD3Wk1C66LPopTtqhcP/w/KTz+VkawdfFSHoa8p2byYyFerpeU4lhJhMRIeZIsUMANor9xupv94ecZl5cAUL7zi7Zv2UwjiuPEP8tPLqvrz7KbJiqeuBt+cc8dJagl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(186009)(1800799009)(451199024)(86362001)(36756003)(478600001)(66946007)(66556008)(37006003)(66476007)(34206002)(316002)(41300700001)(38100700002)(38350700002)(6486002)(26005)(15650500001)(6666004)(6512007)(52116002)(1076003)(8676002)(2906002)(5660300002)(7416002)(6506007)(4326008)(2616005)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GmJagrndznNRs+PQbEEw8suJeM6wwNhEZ0Ka2ITW6a+TMAF7t1cXlyHUEVbf?=
 =?us-ascii?Q?+VClW05QBFPZZrngt8rZ8RT5rG/2yyU05jlgy7wkPvNE1oehyzvyKiTgoPwv?=
 =?us-ascii?Q?Y0wP/XYAYCaNvcQr1f8efK/2yvgKkjIS5685o0jBnvmxYt7CGshvl5PXEP/B?=
 =?us-ascii?Q?bUOn/v8+bIjYb5YeeTxAYT3eAjpcsNOcWiw1jrgDCXg4c8vLSgdC9LbY9lCY?=
 =?us-ascii?Q?1HyJvfQrhwo8H5PlFZzDae/0tKmC6ARgAEr1woqe4Z9Xcigla42sn4Fg0PDL?=
 =?us-ascii?Q?kSKjypmlTL4gmMo+mfDdzF6L6VDBSN7Nj8o1mt9v1u6SuUqsYhwHt6uHn2Pr?=
 =?us-ascii?Q?YDTLjQodJFP8elgs8J0w6E1lThRQUQSV98EeuOsbr25eJOsPaF4wQhFOPkdV?=
 =?us-ascii?Q?5FOgQHjoE0vAn5vrBlcArqOlPOZS9lCalUaItYou6wkhgadNEGFrVzfIEwHo?=
 =?us-ascii?Q?Qb8/ejgCsfuB8P7D+VCQgJ6doCeBQt+16X+2xqsimhYQQhIQS4cl9qhcV+js?=
 =?us-ascii?Q?hVwX7/65DekN7pUD0wUH4C0in0jqezuMJHCsVH7IASYMHzvic7QaiJHhsKW0?=
 =?us-ascii?Q?0kPeQrqn0rU2EU1c6bIbfL9P/v0VbVSu+AROHz9JKz58UPv7rYmPZ6Uxfj+H?=
 =?us-ascii?Q?PYmID/Vw2ChWCblAVOLtmS2cA43S8imSS2LBfUK2sfJaJhkw0Hg3lFasmozd?=
 =?us-ascii?Q?g1jwV1tcOH0wpyhPCwWD/bmZXyzelcF2EHRi+2YMfl0F3pGpgYm5iqJg/Nva?=
 =?us-ascii?Q?1Xrp+V9ISsQuBqTNkz2o+FhNvLE3B6TBoUZLCvS/RI+tGYvv5vllYgcg+kAn?=
 =?us-ascii?Q?aqnTNrvGtvgJ8jDWAkGQ7D4ZAsGCoVl9LXcneXdNZTeeczX0MrQysvM7lqbG?=
 =?us-ascii?Q?7iSgVnThkR2gTPuxN4FyM3KUCagqrI7lWimRTabXBrdWHcCsU/LX9Ku1JMb4?=
 =?us-ascii?Q?DhGMn91TSjLf+Zgidzpqfny/noJXH7scFdtqtr/IBEFdqjudlJ46KLlhe2z7?=
 =?us-ascii?Q?RxBc+L1pTlGFN/XjJOE0lsCSboIgc9LRzVpI8DDFPtNFvp06Bjq61wXWLO9V?=
 =?us-ascii?Q?57fvxj8rZtC0PUsP1wU7jGi6ILRE30S3LyeO8oHCy+OZFtjE1Jm4gWP3oXSi?=
 =?us-ascii?Q?kDpprlpCEVsUinJBNZItzC57AGLS2e4V5p1I8PXoX6RlSAtL4jGdlQNmUfNF?=
 =?us-ascii?Q?Bm5qmF5CF3L8/FQY44cGDjGGfz12zp7C7keZSyGcYThYbLSQdaSVMmnE+1s6?=
 =?us-ascii?Q?i9roztEWv+1y7kLIw7Pxo5ZBN7pP1G5DZhLTyAFiteNJ7OJ/HcqxkjDaFQ1M?=
 =?us-ascii?Q?i/y+Ypq9F3lBGGJMd+/CKuKNsrUkQfEmgtHJr4/hHuB9X5hxqLOfjBfHyJfX?=
 =?us-ascii?Q?sW/cwrdSnrJ/qPvDPuJcy19sCnNLLOpfJsfp/wJuSUkIjbaGeaWCRtJE1/CY?=
 =?us-ascii?Q?MBeD9uuIjw4i+rupGGa2ZrxE6a15spN6ti+wJ9U8ddEFuZeWTLpR0lxESRGl?=
 =?us-ascii?Q?ycTBO8W75eyEu+5C93kaRi75mBANVSDJ2CnP7rSeSFjk2VAAtYePCX0Tf6eG?=
 =?us-ascii?Q?XhwJsaPk3Z/gOmgL/aJkgYBDw38+BAakzAwrDXpR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a28ce1-2525-4939-a2fb-08dba2773faa
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 18:48:45.7879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yU80pfIV5BXRR7NApUHX/Lror3PMSwON0X6WB80QYpU/Wqhzc12PvN9q0q4aMYdekMKR2XNmeVfPvQqiS8D7XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9566
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

Add callback .pme_turn_off for platform specific PME handling.

Add common dw_pcie_suspend(resume)_noirq() API to avoid duplicated code
in dwc pci host controller platform driver.

Typical L2 entry workflow/dw_pcie_suspend_noirq()

1. Transmit PME turn off signal to PCI devices and wait for PME_To_Ack.
2. Await link entering L2_IDLE state.

Typical L2 exit workflow/dw_pcie_resume_noirq()

1. Reinitialize PCI host.
2. Wait for link to become active.

Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 71 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  | 28 ++++++++
 2 files changed, 99 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index cf61733bf78d..5c8cbc3afae4 100644
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
@@ -812,3 +814,72 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
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
index 615660640801..91d13f9b21b1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -288,10 +288,21 @@ enum dw_pcie_core_rst {
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
 };
 
 struct dw_pcie_rp {
@@ -364,6 +375,7 @@ struct dw_pcie_ops {
 	void    (*write_dbi2)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
 			      size_t size, u32 val);
 	int	(*link_up)(struct dw_pcie *pcie);
+	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
 	int	(*start_link)(struct dw_pcie *pcie);
 	void	(*stop_link)(struct dw_pcie *pcie);
 };
@@ -393,6 +405,7 @@ struct dw_pcie {
 	struct reset_control_bulk_data	app_rsts[DW_PCIE_NUM_APP_RSTS];
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
+	bool			suspended;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
@@ -431,6 +444,9 @@ int dw_pcie_edma_detect(struct dw_pcie *pci);
 void dw_pcie_edma_remove(struct dw_pcie *pci);
 void dw_pcie_print_link_status(struct dw_pcie *pci);
 
+int dw_pcie_suspend_noirq(struct dw_pcie *pci);
+int dw_pcie_resume_noirq(struct dw_pcie *pci);
+
 static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
 {
 	dw_pcie_write_dbi(pci, reg, 0x4, val);
@@ -502,6 +518,18 @@ static inline void dw_pcie_stop_link(struct dw_pcie *pci)
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

