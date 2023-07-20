Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA4675B95A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 23:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjGTVJo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 17:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGTVJn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 17:09:43 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2085.outbound.protection.outlook.com [40.107.13.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393991705;
        Thu, 20 Jul 2023 14:09:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3K5+0GEiE0+Yz8qNKn6emOx3IseoDO4ksilOvavRXR8pZeBZlTbofVQ6rEaFyy3Dz9j4RIAyxPp7yFOSy0PUJuva/R8tBatvmF2vjo9KeoxgJgzgLWWmfyjQYVyeL1ZtOi/RMR1SYL7TATscS4zqoOZoA90xEHgJvmyRPfUx/SCBAFDMaFbN7ZsGq4gxfTOvu6fKqqcgAUslgRy9/WMGbQ1/lNiKRuuLlp+uuOZhTfGA1y2Qf0pRbk7ntfjyst97QSQsX39h3yimvK2AEApE5Wp7uqmwhCKeRoo3+YMvNLEf7wn+u1gYKtNI6509iON2y2ZL9uXC3Ff/Vx6f27HGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CBxiKMPKjZRwetl/4LDJoYRYcKzNN3zgEQPID7AZDQ=;
 b=btEVNoPNTOjC8De4riX6yw7/MLBa1KgDx4570prHroTP5gsPRwm+m0Jei3YkWIKWgkdA2Jk+ktZlK4D1dQDFAy5r8R4ZZgHQAJ8xBHhtIQ8wFbRzMeQolHrHrfH6jJtYwe92pQ1DWnH84OTQobWcGBu/Ip3kFyUa2RvntlGY3cHBaE+1LWoortTSKQSFFleI7EWqTcQyhClINdWu2ezGzXj5pb5aO4zz70sIWzf34myBBmKxlanNZIfHESLa99ynEbEoPzRnet4+0Nd4+M/6jCGLtsZpeZGKzEBEGKn/kkvwejPjQKSHRK6UThL1+qYHRHeB483wXJBgEpnE2/esOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CBxiKMPKjZRwetl/4LDJoYRYcKzNN3zgEQPID7AZDQ=;
 b=CO1SuthB1AfdfBtiQGV0w6BezMV556VpRvCOBWjA6vKusONncemBtjJ3lj5Aed44iHQhDMNvpAjzX6+FAKWiXKEBtU3HDtaakJjLZMV6889I3pHfm8mfKBZBMW7kz4D/xOCuWz35L3ebw/dJxoW2f0VaQjGzkE9XGu+VeLAhRfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VE1PR04MB7392.eurprd04.prod.outlook.com (2603:10a6:800:1b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 21:09:39 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 21:09:38 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     mani@kernel.org
Cc:     Frank.li@nxp.com, bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, helgaas@kernel.org,
        imx@lists.linux.dev, kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, manivannan.sadhasivam@linaro.org,
        minghuan.lian@nxp.com, mingkai.hu@nxp.com, robh+dt@kernel.org,
        roy.zang@nxp.com, shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: [PATCH v4 1/2] PCI: dwc: Implement general suspend/resume functionality for L2/L3 transitions
Date:   Thu, 20 Jul 2023 17:09:13 -0400
Message-Id: <20230720210914.2030897-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:217::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VE1PR04MB7392:EE_
X-MS-Office365-Filtering-Correlation-Id: 8101ac5c-aa0d-42dc-76e2-08db8965a0b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o/aTvjpR6mNZuycRGEZ3Xl3rbKm42J4fW6dctaDXi2tVzEnQXJ54jh/nWo7u2S/UX/pQUT1dv9xDZRDawWsydWCnSn7YkUeTPdAySJVvfRTbwgJ64CMCxE5UnFZM1eew61f8Cqr50bsyXhlTYzkTmET17117dFgR4twtLtiiGzbx/VoUYyBXuh1zQj2wPoMUgsEDKCaYTZffbKx0/LQilgCJ/3Z0wuPbGHQRONgtyZd8FVnVdAbsffPMl83BjV3bO/i2dNk81O5T9HDjGocxqSvzHJZF2V4kec58WlGwcaeyhsNGj/d1oQSoId69qE+XqEOHXAdIRksqlU3R52WYAOAESteOSj6dRPYygkm5s+ArGR+tkOgcu8aneqj7B4XxNcXiIHYmG3zr5B+l4L6uetqe+iaGd3KV52wcwqIjTgucu52c6o1Z/UGv7wS3YfE+0KX9gcBPa6YDX5ktuQIZ7uLIaPwYBsO55GR3jM060VdaGclwgNiSgJuD4mP01+WD6iIEl7jj2LA6V9LyLTVPKOHGaoeinxb4sqYGhkIX7j6wXjiiya1U7b6RqgGPgaymPdusu9FEBNyPr5CpXuq+nSTRSznfrIT7dnqM4qTzI3UG1pM+xiuJ5na3nBITzkf+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(86362001)(36756003)(6486002)(66946007)(6666004)(478600001)(66556008)(4326008)(6506007)(52116002)(6916009)(1076003)(66476007)(26005)(2906002)(6512007)(15650500001)(316002)(41300700001)(8936002)(8676002)(5660300002)(7416002)(38350700002)(38100700002)(83380400001)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cmo5xQy2KkIRbxIumN3ZK4tpfq0t8zs/uK0PMjdWIRvh29R4gIpM899o9/dv?=
 =?us-ascii?Q?8T3FNfKpaH75J1pI6I+XhBlP8fbM/4II3y5e39oR3V88An+zLJJf4ripeK8q?=
 =?us-ascii?Q?6HD7WybzldXbokUwzYzo23rNpLLW0OsV2Eta5QQsYEcsPkltMTh4cnpHeGJx?=
 =?us-ascii?Q?Lyy3H6tVw5Tlwy/fOmVXU9fxbF5NBCHXq5pUz4Ssr+b8dzGelWW4ZdtH4fhV?=
 =?us-ascii?Q?aOZHO+CW/6NM1D5tT1t9EcoNn7rAo2y2T2G9qZxqDljUFsaOlgF3JkpkJv8k?=
 =?us-ascii?Q?iC8pLtE/3ICIBORjBT1ZWJt0nZzm5QPJVi1OHkMtGwQURVHCvrxTzIvdz8mQ?=
 =?us-ascii?Q?9J0IeYeWSsYrptsL5IXpYoIJrBQChuFWlTzxgTf5Q0WiJ/yfV2D9I0NUaqJp?=
 =?us-ascii?Q?/25LPrmcHSwBSTnOZE9qVprCoc3g089+SAjIQCLRf83ODRXPxz/hq1nqplkH?=
 =?us-ascii?Q?lNEmsr9KZ7KE34ntgBnEHW3o1qx4dMNLMl8ur+78TMFYyrQQHK1iwD3hJVlZ?=
 =?us-ascii?Q?Uo5IC4BuW1y48T8dQFTTnuSk1kBT73DsG4Cu5gqAmA8zdfVJK10KIoAy3WlM?=
 =?us-ascii?Q?bSeNBMd15FwO9FLSeY80Af5MQkbJF17Kb7NQIZS1/XcIW4BJ+/w5AHIApDfs?=
 =?us-ascii?Q?knH322wS8H/zccj1yN2TpZnlKEouhAB6hOPHc8mp/uSj1+1gOpygZCEfmvgv?=
 =?us-ascii?Q?eOBp1ccnVvo6Gd2g3fSertGLG3OneBijzW9mNMEVe9DXx+lhwVE4tUMRvO0N?=
 =?us-ascii?Q?YY5znTmO6ku0BWGYwV07SlkXNJh3A3KFSJth5q7hTpf0UtPxj0TCHYX3Jhwr?=
 =?us-ascii?Q?Gf3TiyCGy3udUAEaggJ+mdq85N/jyhNEcBgWNuip9tp50Yl8KleuL1WnwG73?=
 =?us-ascii?Q?mzZW3i/xJKaRgNyo/qzdy/lVSoh0KjbG1G28SOR8ZOXvE1T6cFhAFogbhRed?=
 =?us-ascii?Q?LBX6r0GxWGbKKuz+CN3kO8vjR+K766hX6R1gUkk+ZPbZEs23DOAOUE3eWVPp?=
 =?us-ascii?Q?jGDqm8FEV3vQ8d4hdmWFweDBqKjhiKl71/ZobY1y+Wn/m1XVkTPFv5Bt81G1?=
 =?us-ascii?Q?wRY/fj3mHhR2DMBYVBldQHKrN6jlxQksUhS8cW/n0NDpRA33lO98HVzczRBi?=
 =?us-ascii?Q?bwXMNaAxcvKDhhz1/QxjXy/2ez6Qe+ZmaPcmON6sIUbyaXWa6RFY91/UD0cl?=
 =?us-ascii?Q?THJVxrj0oXMdI4zVvYhBvALqqB+qMosgAHILn/wwL5eiytljt+VZxg7aYU3t?=
 =?us-ascii?Q?90KVBNJxRPX54VpCuajrel/LGViWDo39I68Yqg1F6om24Ua+SU1rKHA/qzT2?=
 =?us-ascii?Q?l3l6s1aWEctXQfmiquV4XmSAHWM9OQmUGRGhr8zEgUUFdiI0y7JrlJROWgb2?=
 =?us-ascii?Q?E2vIImGwZNUIWvqDqFcFGqo6XQ7+MkP/K+vxsUQj13S+ChnZrOHnFIuoSBFn?=
 =?us-ascii?Q?RzPexwKtW7L92y2R5K7OQWpaguvHjseqRPyoKNlKYtWfPtQcwrrZgnC5i8WC?=
 =?us-ascii?Q?acOroaU5+dDQbQ54loRDRHhbT6yYd2aj8JqdJDfro03tPhQIkG1q3oeHuMSV?=
 =?us-ascii?Q?+PCwv3eagzEKulgKL4Q3fbMZdHh9c2ws2GXAZ87t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8101ac5c-aa0d-42dc-76e2-08db8965a0b6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 21:09:38.5751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwQXi1YQTd658uOoGbkmmIqwTRt7PP9MR54XVQuz/KNHB3/M6hayfKa7whHaCUbWmnyCFePyOFFk43o9PgTB2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7392
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduced helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.
Added API pme_turn_off and exit_from_l2 for managing L2/L3 state transitions.

Typical L2 entry workflow:

1. Transmit PME turn off signal to PCI devices and wait for PME_To_Ack.
2. Await link entering L2_IDLE state.
3. Transition Root complex to D3 state.

Typical L2 exit workflow:

1. Transition Root complex to D0 state.
2. Issue exit from L2 command.
3. Reinitialize PCI host.
4. Wait for link to become active.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4:
- change according to Manivannan's comments.
  I hope I have not missed anything. quite long discuss thread
Change from v2 to v3:
- Basic rewrite whole patch according rob herry suggestion.
  put common function into dwc, so more soc can share the same logic.

 .../pci/controller/dwc/pcie-designware-host.c | 95 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  | 28 ++++++
 2 files changed, 123 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9952057c8819..a8d8495e4974 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -8,6 +8,7 @@
  * Author: Jingoo Han <jg1.han@samsung.com>
  */
 
+#include <linux/iopoll.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
@@ -807,3 +808,97 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
+
+/*
+ * This resemble the pci_set_power_state() interfaces, but these are for
+ * configuring host controllers, which are bridges *to* PCI devices but
+ * are not PCI devices themselves.
+ */
+static void dw_pcie_set_dstate(struct dw_pcie *pci, pci_power_t dstate)
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
+	u8 offset;
+	u32 val;
+	int ret;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	/*
+	 * If L1.1\L1.2 enable, devices (such as NVME) want short
+	 * resume latency, controller will not enter L2
+	 */
+	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
+		return 0;
+
+	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
+		return 0;
+
+	if (!pci->pp.ops->pme_turn_off)
+		return -EINVAL;
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
+	dw_pcie_set_dstate(pci, PCI_D3hot);
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
+	dw_pcie_set_dstate(pci, PCI_D0);
+
+	if (!pci->pp.ops->exit_from_l2)
+		return -EINVAL;
+
+	pci->pp.ops->exit_from_l2(&pci->pp);
+
+	ret = pci->pp.ops->host_init(&pci->pp);
+	if (ret) {
+		dev_err(pci->dev, "Host init failed! ret = 0x%x\n", ret);
+		return ret;
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

