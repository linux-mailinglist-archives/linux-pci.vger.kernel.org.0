Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FE76E7FD2
	for <lists+linux-pci@lfdr.de>; Wed, 19 Apr 2023 18:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjDSQlr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Apr 2023 12:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjDSQlq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2023 12:41:46 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1415FFB;
        Wed, 19 Apr 2023 09:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyurcoVdgs8zy4y7BtoxNzvKz2QB5ZsmkP8r2oiNsQrfnXgCNvrHs2ZvoxdCE9ErYXA8m6o/FRBa1rv/7f6ETyrPA3AyljL1oe9h6+5nUCvE4gnhdqLKCgTUYd723qYmpbTLSDiaz+ouKU3VnoytAKORY1PCgBx1AOorOpqmpr1TDxaFM2DKgT8w+Ex+/0OKX9lvNVNSMGEat4uDs6oX8OYQBIM+5iA2Eh6t9yt792ge4ioMH/rKU93h0aWWvQ9ALDVfJfvHdVNSOheYPbjFyHLlDGix8S0Hs0VPSGF+U+LwvGojPBHKKQ1fBi9RbEjm1KsSQgWsfcMxwvG3wRtDiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Vap6u+EpxdzKeyIWaF2meftUjVAxJFs8PYN10EWWXA=;
 b=g7tjhdcY8uMOd8KtDQLzYZIG7IPIicmIVfH7nfQXB316i/3lI4kPDJSmMMNho4DZpVRTpJy2MdqAd6zoi5AUfRrDhEV22xfe/0ZegvWCjzKCyFpA5qakHCh8Y/uC+E9fbLmiFcEx0+NkwtZbUFciBp6Kdqn5N/bGC+wUi0SZ80DL9pTACCvjOa2C5AskxI/xjAAggoIt1Lz5/phkEzivFVBiXY8Pqg4n3dB9sZkNj0Uxo571xyKzjMFsIf+LfRlr9wZasbut23jJIHTz3sCf1u8dfvIfv6dGeCTalcMYNYz1hc1GUMhXSZYgcQ5LrbO2Mt+UQfSkEP3pBejYIMzXiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Vap6u+EpxdzKeyIWaF2meftUjVAxJFs8PYN10EWWXA=;
 b=JJzCZEZ7A3J0hSqYqhOhaG3bO3m4Ewkd7PI6tdvbmigMsiaoWNVNV70V3mIObs9QZIzMV00XU5CgHUGLc5D2PcT3HObHG9ZfOW+8bFNeFH4y+x4C2poPZu67O0+3ZAYlKXcBC/1B+RndCiTlVQ1Brxq9o12gjWV3wlvQZRrTwnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7535.eurprd04.prod.outlook.com (2603:10a6:102:e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 16:41:42 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::f1d6:f05f:b8c6:4353]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::f1d6:f05f:b8c6:4353%6]) with mapi id 15.20.6319.021; Wed, 19 Apr 2023
 16:41:42 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     helgaas@kernel.org
Cc:     imx@lists.linux.dev, bhelgaas@google.com,
        devicetree@vger.kernel.org, frank.li@nxp.com,
        gustavo.pimentel@synopsys.com, kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: [PATCH v3 1/2] PCI: dwc: Implement general suspend/resume functionality for L2/L3 transitions
Date:   Wed, 19 Apr 2023 12:41:17 -0400
Message-Id: <20230419164118.596300-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0163.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::18) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cbf5b88-9d24-4602-48bf-08db40f4f463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H5aT+idE54p5Fz+KJjcoPs2bb5VlwOX1w74LeEpbWRGzA77s4kWClrLFdKahfU7WuwjYh/fgrlnmqspN+qvSnzqf+E6emJsIGIkUIQIM3tEsQQPdXyxCmnA/ZT7sX+BWnGIIpDDxVxDQ2+SE6m2NVv9K1aP3WjnbH3g1ZtJn8Hia4vXZU0Kkf48G0pJkkWpBbFjWesJj1+0xTeqy6EsQb5YsrvzTAPCdtFhjDDWcCJ6RjPDP8mr++iO6xPQ+q8mrRoNYDR9k9wuPCIyKyXaTC1fh96fO10tBlWHOoJUtO3Z7awo4Exmv1E88mmr77M6w77FNB9XY88rRV3Pv0ApkEXVqhYK7oUGB7LywMf3QM7okfRADHyDOgMSuILBBYQyw5aWMWq+U/uoza4BFhoro53/KBgkD4ZQQYf881y/PjHIXh4Q+agMI2TDRC14C1Lorr/VfXYHkUDQpwPXoW8j0lJEGXAhHCL8FIpJHxxqXVTLyQAfEfs7XIQNgZ91i85rMWgZSx7nNBmNKZmPvtuq+4wCB3gRxCel54l1tNDJIQQKa3ZonC87kLPdk4AVYzUK44rX3qvCoftzeUCg4OMQeP11qDmhG3iClfAR97l/C4Om8D80ENCNf8Ly8ksBIxMY/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(66946007)(66556008)(66476007)(6916009)(4326008)(478600001)(316002)(8936002)(8676002)(5660300002)(15650500001)(7416002)(41300700001)(38100700002)(38350700002)(186003)(2616005)(83380400001)(6486002)(6666004)(52116002)(6512007)(6506007)(1076003)(26005)(86362001)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sFU0t0irwSa7KAfSAD3sUK2dvpA+qHtDbccJzOZTBr7sqbY/HLC5JRsnPrYV?=
 =?us-ascii?Q?fNui1DkvI0r55vsW6QnnRgh98NVF/NYq04ZJiLCQR/Rk7ByZw6Brx3MJ4Ku9?=
 =?us-ascii?Q?v/chdhK2dxPl8VK00gEq7J1e7/FS6IZQWn+Us7gsEBQKZIWz92YnaH00k5CW?=
 =?us-ascii?Q?dfXSqJegCbXQTprzB1mZ/BzIwmme+ezr67axOdKyFBL1KrnUw6HHMpq1aZtV?=
 =?us-ascii?Q?EIKMTNlh8AHRVg6ob3LwBXG7xblQBwJuT8Hx0isgjSM4mjAKf+hLzbQXEV23?=
 =?us-ascii?Q?Qb0iafHyFs31j8WLtV93bkZUeYaQq6+Uq2Pd6dAclkCIvxfM6tKvZSGc/9pB?=
 =?us-ascii?Q?FikstIhuxq2c7A0cpnzpe/wt0BW5eUkbo+CZWd4eN2cKF5ljxD/BOp9NUCLY?=
 =?us-ascii?Q?dSyO/Re9DG0jzT/TUQu/aTpqP+tqk98ElyZJnmFpZYCe5SX7CkazSNJDlgz/?=
 =?us-ascii?Q?RefjEbcAmqcEoXl0D1ZNWLOzqPM6ypnfObeB6t/xGayox8s1EYKUkLYfcF57?=
 =?us-ascii?Q?sAWIkp3vIx56VJYKvUDyE6bDV34jnr2+W9hDBdfX07l62ni60bb4CoCzwy39?=
 =?us-ascii?Q?fHQ+KXl+vbWD3s0Hd7O2cJlCqgr8DlKMVcaxZJue/CoYLeO1nk6jao6tUcZF?=
 =?us-ascii?Q?8NqjmxAFbv5yRwcrZBz0kK0jHPLgUpMEtnLGV03YUX7zHaoqjuoz01pkP/21?=
 =?us-ascii?Q?UxJk6KKZImXy30pd/2nlixvdNoo3L6bbEvKkCvJ7ww9o5Oq9hNddW6L/I8AZ?=
 =?us-ascii?Q?CWYC4+DE4hY6HuoP+jAh9hNwdtHQHjsIf8K6uhly2A6IQDScV6w0xxXtJoqG?=
 =?us-ascii?Q?nCwLsx8sGQuGlkHdGqpxnXiJeSpATrGUawFhsOnzEpI+lprKpHd0Zah9phgV?=
 =?us-ascii?Q?hgVzf7Jl9lQHvV5eA5wkGg9wvN+xseUeWElNOiF4XGNLHTITITazZppCYisp?=
 =?us-ascii?Q?3I9lcoZ1HeLkhRWyhzpm6tjuiEWnT+t+sVUATWmgBEegIyVrpdMGJVywmoIM?=
 =?us-ascii?Q?OQRT61E1e7Dgjd1p3BKWJhGjEgwcxFkeqYCSWJHUFH3p78QRM2IT7eGae22E?=
 =?us-ascii?Q?+spDOEbhB3A5pQUFPHag8UoKjo2qxlPXa2Ab6z4z5Z1ZAme6AcreUnON1OZ5?=
 =?us-ascii?Q?x3afEHPZxuhdwOByfVKxzJ+yJyoju2agFsD1KURbfxwa8ig4W75+OFgIcifv?=
 =?us-ascii?Q?GMVOIjmATQlxxbLY1mDevdNI1XPOtR+/GVVY5HazGmB8lEp2Q7xGHiM1zOm+?=
 =?us-ascii?Q?3cW9TB1ORBThOOsS42ETwN3qpgfwLBr8dBFDXjtDsSGmt69q3uMLv2HB5RI9?=
 =?us-ascii?Q?EOM3lmABZWGcoZ2KEFCmnx0Zm8Sg1o4Gnk0r7SHiOYN2iczCmhDpmA+Zeehr?=
 =?us-ascii?Q?h7Qsy7gPW4nzZd72hr/cxrKe3RoJ6vBV1jseZJeD457uxPeDfczoZ+dP1/61?=
 =?us-ascii?Q?xvVZitxwYtSva0he4nbeRW2OrT74suyG7MHWYZC3RRCLRW64UJNCMbDmRI9Y?=
 =?us-ascii?Q?ellp+lz7y/P7w5SirVjvmV5QuO5YOPLn1dwsLpHTZ+e0KUPAqTWhCmSkmnhi?=
 =?us-ascii?Q?dIQoNcbDGp+8c+wqAOcxvPQteLKlpN6tyfUgdtd4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbf5b88-9d24-4602-48bf-08db40f4f463
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 16:41:42.1006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnbelfTXd3MJE59kC5PfAQM1mlV2Gd7uGFwhcRToR0gNIPqb/0iEd4vP3qE6SQkB/35gAfXEOKyVBdRY0pzQAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7535
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduced helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.
Added API pme_turn_off and exit_from_l2 for managing L2/L3 state transitions.

Typical L2 entry workflow:

1. Transmit PME turn off signal to PCI devices.
2. Await link entering L2_IDLE state.
3. Transition Root complex to D3 state.

Typical L2 exit workflow:

1. Transition Root complex to D0 state.
2. Issue exit from L2 command.
3. Reinitialize PCI host.
4. Wait for link to become active.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3: 
- Basic rewrite whole patch according rob herry suggestion. 
  put common function into dwc, so more soc can share the same logic.
  
 .../pci/controller/dwc/pcie-designware-host.c | 80 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  | 28 +++++++
 2 files changed, 108 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9952057c8819..ef6869488bde 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -8,6 +8,7 @@
  * Author: Jingoo Han <jg1.han@samsung.com>
  */
 
+#include <linux/iopoll.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
@@ -807,3 +808,82 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
+
+/*
+ * There are for configuring host controllers, which are bridges *to* PCI devices
+ * but are not PCI devices themselves.
+ */
+static void dw_pcie_set_dstate(struct dw_pcie *pci, u32 dstate)
+{
+	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_PM);
+	u32 val;
+
+	val = dw_pcie_readw_dbi(pci, offset + PCI_PM_CTRL);
+	val &= ~PCI_PM_CTRL_STATE_MASK;
+	val |= dstate;
+	dw_pcie_writew_dbi(pci, offset + PCI_PM_CTRL, val);
+}
+
+int dw_pcie_suspend_noirq(struct dw_pcie *pci)
+{
+	u32 val;
+	int ret;
+
+	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
+		return 0;
+
+	pci->pp.ops->pme_turn_off(&pci->pp);
+
+	/*
+	 * PCI Express Base Specification Rev 4.0
+	 * 5.3.3.2.1 PME Synchronization
+	 * Recommand 1ms to 10ms timeout to check L2 ready
+	 */
+	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
+				100, 10000, false, pci);
+	if (ret) {
+		dev_err(pci->dev, "PCIe link enter L2 timeout! ltssm = 0x%x\n", val);
+		return ret;
+	}
+
+	dw_pcie_set_dstate(pci, 0x3);
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
+	dw_pcie_set_dstate(pci, 0x0);
+
+	pci->pp.ops->exit_from_l2(&pci->pp);
+
+	/* delay 10 ms to access EP */
+	mdelay(10);
+
+	ret = pci->pp.ops->host_init(&pci->pp);
+	if (ret) {
+		dev_err(pci->dev, "ls_pcie_host_init failed! ret = 0x%x\n", ret);
+		return ret;
+	}
+
+	dw_pcie_setup_rc(&pci->pp);
+
+	ret = dw_pcie_wait_for_link(pci);
+	if (ret) {
+		dev_err(pci->dev, "wait link up timeout! ret = 0x%x\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 79713ce075cc..effb07a506e4 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -288,10 +288,21 @@ enum dw_pcie_core_rst {
 	DW_PCIE_NUM_CORE_RSTS
 };
 
+enum dw_pcie_ltssm {
+	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
+	/* Need align PCIE_PORT_DEBUG0 bit0:5 */
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

