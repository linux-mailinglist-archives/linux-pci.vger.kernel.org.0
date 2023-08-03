Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E464876ED8A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 17:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbjHCPEy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 11:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbjHCPEu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 11:04:50 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6F23594;
        Thu,  3 Aug 2023 08:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIqDldt3RKAbSeELLmKRAjbMqbNiuikDIuMh6JEQyRejXH0Xcwc6qzivJQv+Kvz21LILloMGgOPDIVVahXVssd4hhsnwH/1b2I8mNde6p0NtsAOcGvMjt68Cz2/PoUiYsOHdd0DCIY/pQ9wyExgj5Gr2z7CXMMzY59xaT+Cy/Ev0kGufiPfEezBah4qbXKL6b8WBbAVDA7YY7FzN7eKbwwU94IARXUx9dEsH8KNVmRf4LKXnVoa4EOgg/FCOdOBB/PPLwnWiftKmuGh7BSizJPt2iuC7d8EUTUdzWsrdZrVcpu3blOFNx2G9ocl8S1U2TuoJwgN+EjBfVyU1CIudQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyVgJIG1xUEiHEFU0XONJstUNCHuMZBkvO+gavYseuE=;
 b=c4hX7P8JzxoEtVE+vv4hcqAqXfqX05ZVyGJg801rdV5jg40pmab+WnJprW86LSPQWa85GirXBTcbApxNpRFUsmGKWsREibPdXMS3VRM6A3O1MuEJy4zNpLYE/gnU7OodjuedIt9eTb0VVJBwir2bsPXx6n8f+0lK74yAQeJ0vUTbfg/6J1X2cwuC1OWMwGtKrqCaj2YaT32k4NHINJyGhc0RDiO4SIOr1EjvlHFTNUfuqmSMXgW1puV6l7xoTfig9FYOEJ0lrR5GIpJV3bx1ITsGYJ7jppd4+1CCNJLwr8B4M/xed1OwSr7+PupUrFoybic4SZ6Dv315pV+E10hhtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyVgJIG1xUEiHEFU0XONJstUNCHuMZBkvO+gavYseuE=;
 b=BisPwixGd5rvHkpj1w3l4H3EUK0O/bHdDsbbvIOuU8D9YA2cBCptzQbjogUpCUlX6eqUjzOlniHub4LgmCiVbZJUR5AwW8SV+WpJRyBWpsvJpQc6E2kEnuxJRjvHpfIMXDOHuRkuyPP7F1w7mTyUzJZ1cVct2Tyf8Lr1rE/xROg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB9769.eurprd04.prod.outlook.com (2603:10a6:20b:679::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 15:04:42 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 15:04:42 +0000
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
Subject: [PATCH v8 2/3] PCI: dwc: Implement general suspend/resume functionality for L2/L3 transitions
Date:   Thu,  3 Aug 2023 11:04:08 -0400
Message-Id: <20230803150409.271155-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803150409.271155-1-Frank.Li@nxp.com>
References: <20230803150409.271155-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:a03:338::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB9769:EE_
X-MS-Office365-Filtering-Correlation-Id: 526d092b-2539-47ef-b564-08db9432f72d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LH5sID4tVn45zVeow7pQWF8+WtKJDg7hGRO9yphr28A4/yRMvwJzTD7+rWrIbmEgNMJW2J7CbmFzrfzuiQBNG5DG7I+CtwGT43QVsM4M8JnL54Rl81jrWZG0m0P4lfSA0X4NbyrjAYwTn/WM3zqEzEH4/UeO5Q/tsxu30krBMbGmEapOvzpuAYHJC5TjJueRnNaTvbkk/NFpNOc6IuEqzR4E+qz76MW972tfL9X43xBIBJLyFDpi4NvS0xHC3bP6hYidPmajIS6xMy+Hiw9KYtOUCQYRuqlMkJ6KqpZvRJNrmPA2JJeaUL4qvGmXg4jq1RTOmCSwTPzFRr5/vkzAd07tlZSmDFaLJHOZ4fXuNpYin3qK/iZpmvIryy7MTUiDE0zMUxwYgsLM7lQ9+axHIfhXsNHDqJjLvhTC2hsiBDprwn6ODPAosWI181B7Xb5ZB0ZEk8eVuGoTuX/W+FvWpUfIi9dyhImY02thKcnJDux7CB8xgzPzqZQILoML4Am/XPJF+/tCZj/tb6I386IET/BlRZBoGtuJblBUhawulpaE69pg4svMLp6+YFkpD0xLR7McJlehXTmiIGpPZ7yQTXIdywUTu5n072RtXFmqH6Z58CO8xdo8vUeRSY63yr6U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199021)(52116002)(1076003)(2616005)(83380400001)(6506007)(41300700001)(26005)(186003)(8676002)(8936002)(66556008)(2906002)(4326008)(66946007)(5660300002)(6916009)(316002)(66476007)(7416002)(6666004)(6486002)(15650500001)(6512007)(478600001)(38350700002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rttyeW+evlMDI1KTl/YDiVRllTF32+KgPvY+Tk2IVTCgFjSRL0f6xlAouM04?=
 =?us-ascii?Q?QwZ+qMqKMrWrCQVOdrBbA11rc5Ke+rn7fZEf5nKHBK1NSav9HGKru65xCZzB?=
 =?us-ascii?Q?E0WiDa9kI/4drKq121NpNdzjq75ds0Qm4l/kE+QPZeqaZabIDf84uz1jP817?=
 =?us-ascii?Q?knXh7VNhyifwlbkMjNZ9v0KdZX4PYn0rd0foeafGpGyvmZU4+k3PVSrshQqO?=
 =?us-ascii?Q?r8AAby+KEREz736j0GjN0AAmx66njK7aY57D8jD/ZfPekGfKyfd52Yrl+9LY?=
 =?us-ascii?Q?/Tzg1jNgT1G4aa9cubqgraYP12L0yjIni9ohXxbiPm8LIzTSdtaiFO4/TO+q?=
 =?us-ascii?Q?RV6GK/05aNQxyp8Y/ltP5QDBCIGu2mYPA52E5be37JuL9J4LVF9jpfczN4m4?=
 =?us-ascii?Q?2icgSrIg7gbvQ/oNyF6Ksg867+qtpDZ/lfmXq3+l0VNdb+DKo+mTFxIS2oYn?=
 =?us-ascii?Q?5a8RPThpHjXWbRBbbYi6b0xT4izw9y0plZqSfEQMLJbwS1DtMEGMUZnI+d4k?=
 =?us-ascii?Q?3IQtKKiuIQtSKEF6uAoEiWzejDMrv1mBr4JV5ljvf26/eKg/ao7Mbz0KhtO9?=
 =?us-ascii?Q?PMIKhpZRNWeFmZdp/pzQbCwlFsfh/GKKF5ldVOudctz+C22eUDBHsrpcIC+I?=
 =?us-ascii?Q?tZTgNzF8NDn5a8dXRRwYOLh0ej6t8fAoDgQuIKsznsL34dR61JIS3jNuNg1B?=
 =?us-ascii?Q?DhnKVeLGCtP4OXchLNcknEpUM7R3RNh7HhHatxdzwCXZEXZNNDdUt2pIN9D9?=
 =?us-ascii?Q?c1wkLwnB3og+IzjtJRzb+umNEFnSUcqHXn/NvRhzv/Gd01aPHVFmCR4CmVhb?=
 =?us-ascii?Q?bslRm+ZVXSnJsO7OETCorRRWQuKfXHASr/EME/yPE8t7vVQ/6UpKLwlMSv3b?=
 =?us-ascii?Q?RcxJwcr+7vV1NV8NqQMze1SloEePLWIe2zeE2ztdHl6l1su/N+M65C+Owfhd?=
 =?us-ascii?Q?aOFhyT8+CwOfxVN8+Lou522IZJYh9NRb4Jaq5C+RIITBGVYa7rkQI2uG3HUr?=
 =?us-ascii?Q?dj3OdKJ/KaenwBLwZF8TuHZpn/VmHrk5Byk4YK38o6eRIGPKBRRVSxV4kzLT?=
 =?us-ascii?Q?phiMSJ6IH1rHDR1DrM+KrihP4Oh1L25kDg9gFhJIxBeyUuLx/84sftefilhf?=
 =?us-ascii?Q?DzH0u8CyDHr5GvVW+Elz/WFF39daWWOReF0iBCdacS/+BgOLub2NoR74a2Xy?=
 =?us-ascii?Q?J/gqoSLUhXB5b9MUaUrxcR4Jia5wgg1+6ASvYuoibDUCVzZ/yiyNdKZ/lh/H?=
 =?us-ascii?Q?m/u+w74mraGlTWtz331TXHBnl6/eOTl66hGY1TJ26rXNEfFQzxG/z0zO6VY2?=
 =?us-ascii?Q?kSonJlxtgQYpipVBd0NilMoHmhsHfZXJU37nSyXxPpq1BWn49iQkKHZFFgha?=
 =?us-ascii?Q?9It6xtuvZwVpint+s4ZqBKM9PTbiEY+KT6+/5NqZ/g3te9u/ceTwaWPxD6HH?=
 =?us-ascii?Q?cpzRzhLeEwGgDl31nwz1WWBdj9ue9BEj7Qeo05ncMFS+mFWv8JitCynO/y/F?=
 =?us-ascii?Q?zM95QKlT6/tiboBVw4hc2QES6zPhbyGDGt0SQ7DRLHQJZK7dsk2MrQ1YVdXz?=
 =?us-ascii?Q?m+3nE4S1YAAiLePrPeuz9n8u6bNc0G+F/3DYF21y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526d092b-2539-47ef-b564-08db9432f72d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 15:04:42.1278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGyTh6jAQ/TgTdEXWKsoKMpVmTpDpUtqXRTVN4ZY67nOE4Gt9+evVa+l+0O4mVyW4cLghRchXcLnk6a9s6UaEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9769
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 75 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  | 28 +++++++
 2 files changed, 103 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9952057c8819c..ec0bbd8bab40d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -8,6 +8,7 @@
  * Author: Jingoo Han <jg1.han@samsung.com>
  */
 
+#include <linux/iopoll.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
@@ -807,3 +808,77 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
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
+			dev_err(pci->dev, "Host init failed! ret = %d\n", ret);
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
index 79713ce075cc1..cbba3ed19b3c0 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -288,10 +288,21 @@ enum dw_pcie_core_rst {
 	DW_PCIE_NUM_CORE_RSTS
 };
 
+enum dw_pcie_ltssm {
+	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
+	/* Need to align with PCIE_PORT_DEBUG0 bits 0:5 */
+	DW_PCIE_LTSSM_DETECT_QUIET = 0x0,
+	DW_PCIE_LTSSM_DETECT_ACT = 0x1,
+	DW_PCIE_LTSSM_L0 = 0x11,
+	DW_PCIE_LTSSM_L2_IDLE = 0x15,
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
@@ -430,6 +443,9 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci);
 int dw_pcie_edma_detect(struct dw_pcie *pci);
 void dw_pcie_edma_remove(struct dw_pcie *pci);
 
+int dw_pcie_suspend_noirq(struct dw_pcie *pci);
+int dw_pcie_resume_noirq(struct dw_pcie *pci);
+
 static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
 {
 	dw_pcie_write_dbi(pci, reg, 0x4, val);
@@ -501,6 +517,18 @@ static inline void dw_pcie_stop_link(struct dw_pcie *pci)
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

