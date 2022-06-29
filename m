Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74E155F627
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 08:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiF2GGL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 02:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiF2GFy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 02:05:54 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9F32AC7B;
        Tue, 28 Jun 2022 23:05:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5kvcLdvTs74q4FrhqCGg+UXbSh7Bate7LPd7F0wnUg8ixaKYxocqMOZbCcUGjpwjbNgfj3oUXUMnZBUHMjaS07/ojlDa9tGYgSHVZRDv/3f1MjpBZs0+ERf+Ek/1CbV7OLdgU6nNa2NiTYm6ABmS1LBuSgtyieN+pzXcVSql5xluzj7CuXC6T1eBhfy2ABjIewUbVNrdyx4TsOJS3A6uGH2oGLdAPOoTREwSRhbe90kGmq7NV6omF7OguwCACcXiwGfFOSKi+JbcMdoQz30n9BNZzMiVFoCHiDASLwaCMAOSWEZbCMAQXfrMn3w4EhjFUVAcZsFfmQuXgBfev4g1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgp+3dXxK9xD3+uV2wfo6zDAY3U70RPSigdYySeUjOA=;
 b=HogHwo5mqTCBjZS+6Re9aVN0X81RCpK8/On9Opy63oC5zUPtVA5P/9s4i/V+3vNzb7/J0a+J5qNphWQwb+wGT9kTHIjatOHD3zzwTi+nyFPIOGhGZUHy5VyYzzqcrFmcACB2yKGJgCHsgys9dvRNjC88h7h0IfvONmHymnuDkksjAQCWj0tyZzaW/s2K10Jnqu2xBlcETGGrTOHKOaVfnSQ2hRaFJVEeXXwYciZ6NAEizMrEQb9MhU4+6txfp8srKv/4w9oMNW4WO9wQ1lSM/yUgHZmd9RF7Z7jJrymRCxS3KRmLUAEzJOqm5ZQ1iWhM9k55TplDbWztGiEFVZbZOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=ti.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgp+3dXxK9xD3+uV2wfo6zDAY3U70RPSigdYySeUjOA=;
 b=LMpewmZGUdHI24SFkv7yclC2EGxS5EWhN5J7tj8eLrsAX8pRynUcekaMB8775bhEQWcCV2ZvVejI8uuuY/0lenUmoWuXWCa4bQpoq7MJyvwwSBLEt9+1WRkhbGUQOPg9lRrt11YpfyoHkQHXVQVJjvwPn5K3JziumuJG6RAPchIR4Vxv3EDkoYGq7ct2k+uwbbpLVv87yp9xgjGkWPMoZszdcC/aCMDicp7AIGQlfa6apZTLNJfSlB8Av8Hi53pRYsWvHSphKEAAhjU82iYBJhAurgi1PLLJzif0MRtN4mu9MkXjKcWij3qOxFbuEd5+0EhlzDDbMSAaPNSvXJwS8g==
Received: from DM6PR17CA0025.namprd17.prod.outlook.com (2603:10b6:5:1b3::38)
 by BN6PR12MB1201.namprd12.prod.outlook.com (2603:10b6:404:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 06:05:50 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::d2) by DM6PR17CA0025.outlook.office365.com
 (2603:10b6:5:1b3::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 29 Jun 2022 06:05:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 06:05:49 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 29 Jun
 2022 06:05:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 28 Jun
 2022 23:05:48 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Tue, 28 Jun 2022 23:05:43 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <kishon@ti.com>, <vkoul@kernel.org>, <kw@linux.com>,
        <krzk@kernel.org>, <p.zabel@pengutronix.de>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V3 10/11] Revert "PCI: tegra194: Rename tegra_pcie_dw to tegra194_pcie"
Date:   Wed, 29 Jun 2022 11:34:34 +0530
Message-ID: <20220629060435.25297-11-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220629060435.25297-1-vidyas@nvidia.com>
References: <20220629060435.25297-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3828ad3c-7d13-4dc5-6a56-08da59956a9f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1201:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KGh9wve1LLeN+r8Qt/g14Fx7BG/GRSTWRl9ydKoe7okIw8K8cELyCbrU3tdTKoqwVVwpEHrFkjotq6vKjxs+hAsHuMMhCl3mkw9/ieMRF3yrAI68M1S6pJbXlUoqC9zACYMlzaoesxScFhFpP4ELxsdbGzAMNVLdmDrjAcbpNxh6QXHShoULXO2rfUKrY8UxMe2cLafWc3f+/2xYUC9SxBcjaWMXVU3E0jaxFVsvQnWElfnv3Ehotyruv/LySM/pTC/1Ie8WKXykpxkYjEQOq/1Eh6GW4WL0CYYw9MOu8QhBKU7TuugWzuwjUUzqI1Bi5FWoQm6ZusXkHwNFqPbfCVCpmhOj9szCcPMFKWl95oaZy8nMcPswCu9cVz91a3YvmKmDR78Xh1BG6W8LTVaHDjfSBcOQ6lxp8wO3n8Q/oIV/1rWcSDoJXGLqUhNI7wfDrL23RSXZ++++Tn458b/HQRpDQYrZKAlAxVCl7TtZY3RcVCdNDKkNRtJw0Ygadr8g+ohrqlxRTtCPJ0O+TxXP40AIXa3+2yBA7bKXRuNREYO/jd1SJiyIAidOwayzFgcZmGnfVdoegDclAuuJRRKp3N0ljjOgmpungWcvpm+3WuYwtvLijSfd8vI0CwbYha0CX/u5n/L1CINZtCSqHsS2nvgl5v6Mj43GzqnHFNps0hPRd8LOcgxY3qRY9OHOPiy8/9XNqFjacenJQxnHYNPV+rZ8vymp5jLZGmFXndtVD3D/9cEO5hapBT9pNVdKbXYi1lHv5sEr4MIsaM2uGZo3FENBfaHXTleXKO41MWcg/ZuV03MvuS/yB5thl2tmsVN6bgR+c1VmA8RTbBvbEj3Jag==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(136003)(40470700004)(46966006)(36840700001)(426003)(40480700001)(356005)(70586007)(70206006)(336012)(47076005)(478600001)(41300700001)(2616005)(36860700001)(1076003)(186003)(7696005)(82310400005)(6666004)(40460700003)(36756003)(6636002)(316002)(54906003)(4326008)(2906002)(81166007)(8676002)(82740400003)(83380400001)(26005)(110136005)(8936002)(5660300002)(86362001)(30864003)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 06:05:49.8459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3828ad3c-7d13-4dc5-6a56-08da59956a9f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1201
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit b572569183993b68dec0e990b33641e6f77744ba.

It keeps the names of data structures generic and not contain
any one particular chip name. This is a preparatory change for the
upcoming changes that add support for Tegra234.
This has no functional impact.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* None

V2:
* New addition in V2 based on Bjorn's review comment

 drivers/pci/controller/dwc/pcie-tegra194.c | 222 ++++++++++-----------
 1 file changed, 111 insertions(+), 111 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index d992371a36e6..bd16245fc2c4 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -243,7 +243,7 @@ static const unsigned int pcie_gen_freq[] = {
 	GEN4_CORE_CLK_FREQ
 };
 
-struct tegra194_pcie {
+struct tegra_pcie_dw {
 	struct device *dev;
 	struct resource *appl_res;
 	struct resource *dbi_res;
@@ -287,22 +287,22 @@ struct tegra194_pcie {
 	int ep_state;
 };
 
-struct tegra194_pcie_of_data {
+struct tegra_pcie_dw_of_data {
 	enum dw_pcie_device_mode mode;
 };
 
-static inline struct tegra194_pcie *to_tegra_pcie(struct dw_pcie *pci)
+static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
 {
-	return container_of(pci, struct tegra194_pcie, pci);
+	return container_of(pci, struct tegra_pcie_dw, pci);
 }
 
-static inline void appl_writel(struct tegra194_pcie *pcie, const u32 value,
+static inline void appl_writel(struct tegra_pcie_dw *pcie, const u32 value,
 			       const u32 reg)
 {
 	writel_relaxed(value, pcie->appl_base + reg);
 }
 
-static inline u32 appl_readl(struct tegra194_pcie *pcie, const u32 reg)
+static inline u32 appl_readl(struct tegra_pcie_dw *pcie, const u32 reg)
 {
 	return readl_relaxed(pcie->appl_base + reg);
 }
@@ -314,7 +314,7 @@ struct tegra_pcie_soc {
 static void apply_bad_link_workaround(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct tegra194_pcie *pcie = to_tegra_pcie(pci);
+	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	u32 current_link_width;
 	u16 val;
 
@@ -347,7 +347,7 @@ static void apply_bad_link_workaround(struct pcie_port *pp)
 
 static irqreturn_t tegra_pcie_rp_irq_handler(int irq, void *arg)
 {
-	struct tegra194_pcie *pcie = arg;
+	struct tegra_pcie_dw *pcie = arg;
 	struct dw_pcie *pci = &pcie->pci;
 	struct pcie_port *pp = &pci->pp;
 	u32 val, tmp;
@@ -418,7 +418,7 @@ static irqreturn_t tegra_pcie_rp_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static void pex_ep_event_hot_rst_done(struct tegra194_pcie *pcie)
+static void pex_ep_event_hot_rst_done(struct tegra_pcie_dw *pcie)
 {
 	u32 val;
 
@@ -446,7 +446,7 @@ static void pex_ep_event_hot_rst_done(struct tegra194_pcie *pcie)
 
 static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 {
-	struct tegra194_pcie *pcie = arg;
+	struct tegra_pcie_dw *pcie = arg;
 	struct dw_pcie *pci = &pcie->pci;
 	u32 val, speed;
 
@@ -492,7 +492,7 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 
 static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
 {
-	struct tegra194_pcie *pcie = arg;
+	struct tegra_pcie_dw *pcie = arg;
 	struct dw_pcie_ep *ep = &pcie->pci.ep;
 	int spurious = 1;
 	u32 status_l0, status_l1, link_status;
@@ -535,7 +535,7 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int tegra194_pcie_rd_own_conf(struct pci_bus *bus, u32 devfn, int where,
+static int tegra_pcie_dw_rd_own_conf(struct pci_bus *bus, u32 devfn, int where,
 				     int size, u32 *val)
 {
 	/*
@@ -552,7 +552,7 @@ static int tegra194_pcie_rd_own_conf(struct pci_bus *bus, u32 devfn, int where,
 	return pci_generic_config_read(bus, devfn, where, size, val);
 }
 
-static int tegra194_pcie_wr_own_conf(struct pci_bus *bus, u32 devfn, int where,
+static int tegra_pcie_dw_wr_own_conf(struct pci_bus *bus, u32 devfn, int where,
 				     int size, u32 val)
 {
 	/*
@@ -569,8 +569,8 @@ static int tegra194_pcie_wr_own_conf(struct pci_bus *bus, u32 devfn, int where,
 
 static struct pci_ops tegra_pci_ops = {
 	.map_bus = dw_pcie_own_conf_map_bus,
-	.read = tegra194_pcie_rd_own_conf,
-	.write = tegra194_pcie_wr_own_conf,
+	.read = tegra_pcie_dw_rd_own_conf,
+	.write = tegra_pcie_dw_wr_own_conf,
 };
 
 #if defined(CONFIG_PCIEASPM)
@@ -592,7 +592,7 @@ static const u32 event_cntr_data_offset[] = {
 	0x1dc
 };
 
-static void disable_aspm_l11(struct tegra194_pcie *pcie)
+static void disable_aspm_l11(struct tegra_pcie_dw *pcie)
 {
 	u32 val;
 
@@ -601,7 +601,7 @@ static void disable_aspm_l11(struct tegra194_pcie *pcie)
 	dw_pcie_writel_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub, val);
 }
 
-static void disable_aspm_l12(struct tegra194_pcie *pcie)
+static void disable_aspm_l12(struct tegra_pcie_dw *pcie)
 {
 	u32 val;
 
@@ -610,7 +610,7 @@ static void disable_aspm_l12(struct tegra194_pcie *pcie)
 	dw_pcie_writel_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub, val);
 }
 
-static inline u32 event_counter_prog(struct tegra194_pcie *pcie, u32 event)
+static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
 {
 	u32 val;
 
@@ -627,7 +627,7 @@ static inline u32 event_counter_prog(struct tegra194_pcie *pcie, u32 event)
 
 static int aspm_state_cnt(struct seq_file *s, void *data)
 {
-	struct tegra194_pcie *pcie = (struct tegra194_pcie *)
+	struct tegra_pcie_dw *pcie = (struct tegra_pcie_dw *)
 				     dev_get_drvdata(s->private);
 	u32 val;
 
@@ -658,7 +658,7 @@ static int aspm_state_cnt(struct seq_file *s, void *data)
 	return 0;
 }
 
-static void init_host_aspm(struct tegra194_pcie *pcie)
+static void init_host_aspm(struct tegra_pcie_dw *pcie)
 {
 	struct dw_pcie *pci = &pcie->pci;
 	u32 val;
@@ -686,22 +686,22 @@ static void init_host_aspm(struct tegra194_pcie *pcie)
 	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
 }
 
-static void init_debugfs(struct tegra194_pcie *pcie)
+static void init_debugfs(struct tegra_pcie_dw *pcie)
 {
 	debugfs_create_devm_seqfile(pcie->dev, "aspm_state_cnt", pcie->debugfs,
 				    aspm_state_cnt);
 }
 #else
-static inline void disable_aspm_l12(struct tegra194_pcie *pcie) { return; }
-static inline void disable_aspm_l11(struct tegra194_pcie *pcie) { return; }
-static inline void init_host_aspm(struct tegra194_pcie *pcie) { return; }
-static inline void init_debugfs(struct tegra194_pcie *pcie) { return; }
+static inline void disable_aspm_l12(struct tegra_pcie_dw *pcie) { return; }
+static inline void disable_aspm_l11(struct tegra_pcie_dw *pcie) { return; }
+static inline void init_host_aspm(struct tegra_pcie_dw *pcie) { return; }
+static inline void init_debugfs(struct tegra_pcie_dw *pcie) { return; }
 #endif
 
 static void tegra_pcie_enable_system_interrupts(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct tegra194_pcie *pcie = to_tegra_pcie(pci);
+	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	u32 val;
 	u16 val_w;
 
@@ -739,7 +739,7 @@ static void tegra_pcie_enable_system_interrupts(struct pcie_port *pp)
 static void tegra_pcie_enable_legacy_interrupts(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct tegra194_pcie *pcie = to_tegra_pcie(pci);
+	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	u32 val;
 
 	/* Enable legacy interrupt generation */
@@ -760,7 +760,7 @@ static void tegra_pcie_enable_legacy_interrupts(struct pcie_port *pp)
 static void tegra_pcie_enable_msi_interrupts(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct tegra194_pcie *pcie = to_tegra_pcie(pci);
+	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	u32 val;
 
 	/* Enable MSI interrupt generation */
@@ -773,7 +773,7 @@ static void tegra_pcie_enable_msi_interrupts(struct pcie_port *pp)
 static void tegra_pcie_enable_interrupts(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct tegra194_pcie *pcie = to_tegra_pcie(pci);
+	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 
 	/* Clear interrupt statuses before enabling interrupts */
 	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L0);
@@ -798,7 +798,7 @@ static void tegra_pcie_enable_interrupts(struct pcie_port *pp)
 		tegra_pcie_enable_msi_interrupts(pp);
 }
 
-static void config_gen3_gen4_eq_presets(struct tegra194_pcie *pcie)
+static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 {
 	struct dw_pcie *pci = &pcie->pci;
 	u32 val, offset, i;
@@ -851,10 +851,10 @@ static void config_gen3_gen4_eq_presets(struct tegra194_pcie *pcie)
 	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
 }
 
-static int tegra194_pcie_host_init(struct pcie_port *pp)
+static int tegra_pcie_dw_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct tegra194_pcie *pcie = to_tegra_pcie(pci);
+	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	u32 val;
 
 	pp->bridge->ops = &tegra_pci_ops;
@@ -912,10 +912,10 @@ static int tegra194_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
-static int tegra194_pcie_start_link(struct dw_pcie *pci)
+static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 {
 	u32 val, offset, speed, tmp;
-	struct tegra194_pcie *pcie = to_tegra_pcie(pci);
+	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	struct pcie_port *pp = &pci->pp;
 	bool retry = true;
 
@@ -980,7 +980,7 @@ static int tegra194_pcie_start_link(struct dw_pcie *pci)
 		val &= ~PCI_DLF_EXCHANGE_ENABLE;
 		dw_pcie_writel_dbi(pci, offset, val);
 
-		tegra194_pcie_host_init(pp);
+		tegra_pcie_dw_host_init(pp);
 		dw_pcie_setup_rc(pp);
 
 		retry = false;
@@ -996,32 +996,32 @@ static int tegra194_pcie_start_link(struct dw_pcie *pci)
 	return 0;
 }
 
-static int tegra194_pcie_link_up(struct dw_pcie *pci)
+static int tegra_pcie_dw_link_up(struct dw_pcie *pci)
 {
-	struct tegra194_pcie *pcie = to_tegra_pcie(pci);
+	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	u32 val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA);
 
 	return !!(val & PCI_EXP_LNKSTA_DLLLA);
 }
 
-static void tegra194_pcie_stop_link(struct dw_pcie *pci)
+static void tegra_pcie_dw_stop_link(struct dw_pcie *pci)
 {
-	struct tegra194_pcie *pcie = to_tegra_pcie(pci);
+	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 
 	disable_irq(pcie->pex_rst_irq);
 }
 
 static const struct dw_pcie_ops tegra_dw_pcie_ops = {
-	.link_up = tegra194_pcie_link_up,
-	.start_link = tegra194_pcie_start_link,
-	.stop_link = tegra194_pcie_stop_link,
+	.link_up = tegra_pcie_dw_link_up,
+	.start_link = tegra_pcie_dw_start_link,
+	.stop_link = tegra_pcie_dw_stop_link,
 };
 
-static const struct dw_pcie_host_ops tegra194_pcie_host_ops = {
-	.host_init = tegra194_pcie_host_init,
+static const struct dw_pcie_host_ops tegra_pcie_dw_host_ops = {
+	.host_init = tegra_pcie_dw_host_init,
 };
 
-static void tegra_pcie_disable_phy(struct tegra194_pcie *pcie)
+static void tegra_pcie_disable_phy(struct tegra_pcie_dw *pcie)
 {
 	unsigned int phy_count = pcie->phy_count;
 
@@ -1031,7 +1031,7 @@ static void tegra_pcie_disable_phy(struct tegra194_pcie *pcie)
 	}
 }
 
-static int tegra_pcie_enable_phy(struct tegra194_pcie *pcie)
+static int tegra_pcie_enable_phy(struct tegra_pcie_dw *pcie)
 {
 	unsigned int i;
 	int ret;
@@ -1058,7 +1058,7 @@ static int tegra_pcie_enable_phy(struct tegra194_pcie *pcie)
 	return ret;
 }
 
-static int tegra194_pcie_parse_dt(struct tegra194_pcie *pcie)
+static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 {
 	struct platform_device *pdev = to_platform_device(pcie->dev);
 	struct device_node *np = pcie->dev->of_node;
@@ -1154,7 +1154,7 @@ static int tegra194_pcie_parse_dt(struct tegra194_pcie *pcie)
 	return 0;
 }
 
-static int tegra_pcie_bpmp_set_ctrl_state(struct tegra194_pcie *pcie,
+static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
 					  bool enable)
 {
 	struct mrq_uphy_response resp;
@@ -1182,7 +1182,7 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra194_pcie *pcie,
 	return tegra_bpmp_transfer(pcie->bpmp, &msg);
 }
 
-static int tegra_pcie_bpmp_set_pll_state(struct tegra194_pcie *pcie,
+static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
 					 bool enable)
 {
 	struct mrq_uphy_response resp;
@@ -1210,7 +1210,7 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra194_pcie *pcie,
 	return tegra_bpmp_transfer(pcie->bpmp, &msg);
 }
 
-static void tegra_pcie_downstream_dev_to_D0(struct tegra194_pcie *pcie)
+static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
 {
 	struct pcie_port *pp = &pcie->pci.pp;
 	struct pci_bus *child, *root_bus = NULL;
@@ -1248,7 +1248,7 @@ static void tegra_pcie_downstream_dev_to_D0(struct tegra194_pcie *pcie)
 	}
 }
 
-static int tegra_pcie_get_slot_regulators(struct tegra194_pcie *pcie)
+static int tegra_pcie_get_slot_regulators(struct tegra_pcie_dw *pcie)
 {
 	pcie->slot_ctl_3v3 = devm_regulator_get_optional(pcie->dev, "vpcie3v3");
 	if (IS_ERR(pcie->slot_ctl_3v3)) {
@@ -1269,7 +1269,7 @@ static int tegra_pcie_get_slot_regulators(struct tegra194_pcie *pcie)
 	return 0;
 }
 
-static int tegra_pcie_enable_slot_regulators(struct tegra194_pcie *pcie)
+static int tegra_pcie_enable_slot_regulators(struct tegra_pcie_dw *pcie)
 {
 	int ret;
 
@@ -1307,7 +1307,7 @@ static int tegra_pcie_enable_slot_regulators(struct tegra194_pcie *pcie)
 	return ret;
 }
 
-static void tegra_pcie_disable_slot_regulators(struct tegra194_pcie *pcie)
+static void tegra_pcie_disable_slot_regulators(struct tegra_pcie_dw *pcie)
 {
 	if (pcie->slot_ctl_12v)
 		regulator_disable(pcie->slot_ctl_12v);
@@ -1315,7 +1315,7 @@ static void tegra_pcie_disable_slot_regulators(struct tegra194_pcie *pcie)
 		regulator_disable(pcie->slot_ctl_3v3);
 }
 
-static int tegra_pcie_config_controller(struct tegra194_pcie *pcie,
+static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 					bool en_hw_hot_rst)
 {
 	int ret;
@@ -1412,7 +1412,7 @@ static int tegra_pcie_config_controller(struct tegra194_pcie *pcie,
 	return ret;
 }
 
-static void tegra_pcie_unconfig_controller(struct tegra194_pcie *pcie)
+static void tegra_pcie_unconfig_controller(struct tegra_pcie_dw *pcie)
 {
 	int ret;
 
@@ -1440,7 +1440,7 @@ static void tegra_pcie_unconfig_controller(struct tegra194_pcie *pcie)
 			pcie->cid, ret);
 }
 
-static int tegra_pcie_init_controller(struct tegra194_pcie *pcie)
+static int tegra_pcie_init_controller(struct tegra_pcie_dw *pcie)
 {
 	struct dw_pcie *pci = &pcie->pci;
 	struct pcie_port *pp = &pci->pp;
@@ -1450,7 +1450,7 @@ static int tegra_pcie_init_controller(struct tegra194_pcie *pcie)
 	if (ret < 0)
 		return ret;
 
-	pp->ops = &tegra194_pcie_host_ops;
+	pp->ops = &tegra_pcie_dw_host_ops;
 
 	ret = dw_pcie_host_init(pp);
 	if (ret < 0) {
@@ -1465,11 +1465,11 @@ static int tegra_pcie_init_controller(struct tegra194_pcie *pcie)
 	return ret;
 }
 
-static int tegra_pcie_try_link_l2(struct tegra194_pcie *pcie)
+static int tegra_pcie_try_link_l2(struct tegra_pcie_dw *pcie)
 {
 	u32 val;
 
-	if (!tegra194_pcie_link_up(&pcie->pci))
+	if (!tegra_pcie_dw_link_up(&pcie->pci))
 		return 0;
 
 	val = appl_readl(pcie, APPL_RADM_STATUS);
@@ -1481,12 +1481,12 @@ static int tegra_pcie_try_link_l2(struct tegra194_pcie *pcie)
 				 1, PME_ACK_TIMEOUT);
 }
 
-static void tegra194_pcie_pme_turnoff(struct tegra194_pcie *pcie)
+static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 {
 	u32 data;
 	int err;
 
-	if (!tegra194_pcie_link_up(&pcie->pci)) {
+	if (!tegra_pcie_dw_link_up(&pcie->pci)) {
 		dev_dbg(pcie->dev, "PCIe link is not up...!\n");
 		return;
 	}
@@ -1543,15 +1543,15 @@ static void tegra194_pcie_pme_turnoff(struct tegra194_pcie *pcie)
 	appl_writel(pcie, data, APPL_PINMUX);
 }
 
-static void tegra_pcie_deinit_controller(struct tegra194_pcie *pcie)
+static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
 {
 	tegra_pcie_downstream_dev_to_D0(pcie);
 	dw_pcie_host_deinit(&pcie->pci.pp);
-	tegra194_pcie_pme_turnoff(pcie);
+	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
 }
 
-static int tegra_pcie_config_rp(struct tegra194_pcie *pcie)
+static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 {
 	struct device *dev = pcie->dev;
 	char *name;
@@ -1578,7 +1578,7 @@ static int tegra_pcie_config_rp(struct tegra194_pcie *pcie)
 		goto fail_pm_get_sync;
 	}
 
-	pcie->link_state = tegra194_pcie_link_up(&pcie->pci);
+	pcie->link_state = tegra_pcie_dw_link_up(&pcie->pci);
 	if (!pcie->link_state) {
 		ret = -ENOMEDIUM;
 		goto fail_host_init;
@@ -1603,7 +1603,7 @@ static int tegra_pcie_config_rp(struct tegra194_pcie *pcie)
 	return ret;
 }
 
-static void pex_ep_event_pex_rst_assert(struct tegra194_pcie *pcie)
+static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 {
 	u32 val;
 	int ret;
@@ -1642,7 +1642,7 @@ static void pex_ep_event_pex_rst_assert(struct tegra194_pcie *pcie)
 	dev_dbg(pcie->dev, "Uninitialization of endpoint is completed\n");
 }
 
-static void pex_ep_event_pex_rst_deassert(struct tegra194_pcie *pcie)
+static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 {
 	struct dw_pcie *pci = &pcie->pci;
 	struct dw_pcie_ep *ep = &pci->ep;
@@ -1807,7 +1807,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra194_pcie *pcie)
 
 static irqreturn_t tegra_pcie_ep_pex_rst_irq(int irq, void *arg)
 {
-	struct tegra194_pcie *pcie = arg;
+	struct tegra_pcie_dw *pcie = arg;
 
 	if (gpiod_get_value(pcie->pex_rst_gpiod))
 		pex_ep_event_pex_rst_assert(pcie);
@@ -1817,7 +1817,7 @@ static irqreturn_t tegra_pcie_ep_pex_rst_irq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int tegra_pcie_ep_raise_legacy_irq(struct tegra194_pcie *pcie, u16 irq)
+static int tegra_pcie_ep_raise_legacy_irq(struct tegra_pcie_dw *pcie, u16 irq)
 {
 	/* Tegra194 supports only INTA */
 	if (irq > 1)
@@ -1829,7 +1829,7 @@ static int tegra_pcie_ep_raise_legacy_irq(struct tegra194_pcie *pcie, u16 irq)
 	return 0;
 }
 
-static int tegra_pcie_ep_raise_msi_irq(struct tegra194_pcie *pcie, u16 irq)
+static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
 {
 	if (unlikely(irq > 31))
 		return -EINVAL;
@@ -1839,7 +1839,7 @@ static int tegra_pcie_ep_raise_msi_irq(struct tegra194_pcie *pcie, u16 irq)
 	return 0;
 }
 
-static int tegra_pcie_ep_raise_msix_irq(struct tegra194_pcie *pcie, u16 irq)
+static int tegra_pcie_ep_raise_msix_irq(struct tegra_pcie_dw *pcie, u16 irq)
 {
 	struct dw_pcie_ep *ep = &pcie->pci.ep;
 
@@ -1853,7 +1853,7 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 				   u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-	struct tegra194_pcie *pcie = to_tegra_pcie(pci);
+	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 
 	switch (type) {
 	case PCI_EPC_IRQ_LEGACY:
@@ -1894,7 +1894,7 @@ static const struct dw_pcie_ep_ops pcie_ep_ops = {
 	.get_features = tegra_pcie_ep_get_features,
 };
 
-static int tegra_pcie_config_ep(struct tegra194_pcie *pcie,
+static int tegra_pcie_config_ep(struct tegra_pcie_dw *pcie,
 				struct platform_device *pdev)
 {
 	struct dw_pcie *pci = &pcie->pci;
@@ -1956,12 +1956,12 @@ static int tegra_pcie_config_ep(struct tegra194_pcie *pcie,
 	return 0;
 }
 
-static int tegra194_pcie_probe(struct platform_device *pdev)
+static int tegra_pcie_dw_probe(struct platform_device *pdev)
 {
-	const struct tegra194_pcie_of_data *data;
+	const struct tegra_pcie_dw_of_data *data;
 	struct device *dev = &pdev->dev;
 	struct resource *atu_dma_res;
-	struct tegra194_pcie *pcie;
+	struct tegra_pcie_dw *pcie;
 	struct pcie_port *pp;
 	struct dw_pcie *pci;
 	struct phy **phys;
@@ -1987,7 +1987,7 @@ static int tegra194_pcie_probe(struct platform_device *pdev)
 	pcie->dev = &pdev->dev;
 	pcie->mode = (enum dw_pcie_device_mode)data->mode;
 
-	ret = tegra194_pcie_parse_dt(pcie);
+	ret = tegra_pcie_dw_parse_dt(pcie);
 	if (ret < 0) {
 		const char *level = KERN_ERR;
 
@@ -2145,9 +2145,9 @@ static int tegra194_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int tegra194_pcie_remove(struct platform_device *pdev)
+static int tegra_pcie_dw_remove(struct platform_device *pdev)
 {
-	struct tegra194_pcie *pcie = platform_get_drvdata(pdev);
+	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
 
 	if (!pcie->link_state)
 		return 0;
@@ -2163,9 +2163,9 @@ static int tegra194_pcie_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int tegra194_pcie_suspend_late(struct device *dev)
+static int tegra_pcie_dw_suspend_late(struct device *dev)
 {
-	struct tegra194_pcie *pcie = dev_get_drvdata(dev);
+	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 	u32 val;
 
 	if (!pcie->link_state)
@@ -2181,23 +2181,23 @@ static int tegra194_pcie_suspend_late(struct device *dev)
 	return 0;
 }
 
-static int tegra194_pcie_suspend_noirq(struct device *dev)
+static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 {
-	struct tegra194_pcie *pcie = dev_get_drvdata(dev);
+	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 
 	if (!pcie->link_state)
 		return 0;
 
 	tegra_pcie_downstream_dev_to_D0(pcie);
-	tegra194_pcie_pme_turnoff(pcie);
+	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
 
 	return 0;
 }
 
-static int tegra194_pcie_resume_noirq(struct device *dev)
+static int tegra_pcie_dw_resume_noirq(struct device *dev)
 {
-	struct tegra194_pcie *pcie = dev_get_drvdata(dev);
+	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 	int ret;
 
 	if (!pcie->link_state)
@@ -2207,7 +2207,7 @@ static int tegra194_pcie_resume_noirq(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	ret = tegra194_pcie_host_init(&pcie->pci.pp);
+	ret = tegra_pcie_dw_host_init(&pcie->pci.pp);
 	if (ret < 0) {
 		dev_err(dev, "Failed to init host: %d\n", ret);
 		goto fail_host_init;
@@ -2215,7 +2215,7 @@ static int tegra194_pcie_resume_noirq(struct device *dev)
 
 	dw_pcie_setup_rc(&pcie->pci.pp);
 
-	ret = tegra194_pcie_start_link(&pcie->pci);
+	ret = tegra_pcie_dw_start_link(&pcie->pci);
 	if (ret < 0)
 		goto fail_host_init;
 
@@ -2226,9 +2226,9 @@ static int tegra194_pcie_resume_noirq(struct device *dev)
 	return ret;
 }
 
-static int tegra194_pcie_resume_early(struct device *dev)
+static int tegra_pcie_dw_resume_early(struct device *dev)
 {
-	struct tegra194_pcie *pcie = dev_get_drvdata(dev);
+	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 	u32 val;
 
 	if (pcie->mode == DW_PCIE_EP_TYPE) {
@@ -2251,9 +2251,9 @@ static int tegra194_pcie_resume_early(struct device *dev)
 	return 0;
 }
 
-static void tegra194_pcie_shutdown(struct platform_device *pdev)
+static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
 {
-	struct tegra194_pcie *pcie = platform_get_drvdata(pdev);
+	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
 
 	if (!pcie->link_state)
 		return;
@@ -2265,50 +2265,50 @@ static void tegra194_pcie_shutdown(struct platform_device *pdev)
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		disable_irq(pcie->pci.pp.msi_irq);
 
-	tegra194_pcie_pme_turnoff(pcie);
+	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
 }
 
-static const struct tegra194_pcie_of_data tegra194_pcie_rc_of_data = {
+static const struct tegra_pcie_dw_of_data tegra_pcie_dw_rc_of_data = {
 	.mode = DW_PCIE_RC_TYPE,
 };
 
-static const struct tegra194_pcie_of_data tegra194_pcie_ep_of_data = {
+static const struct tegra_pcie_dw_of_data tegra_pcie_dw_ep_of_data = {
 	.mode = DW_PCIE_EP_TYPE,
 };
 
-static const struct of_device_id tegra194_pcie_of_match[] = {
+static const struct of_device_id tegra_pcie_dw_of_match[] = {
 	{
 		.compatible = "nvidia,tegra194-pcie",
-		.data = &tegra194_pcie_rc_of_data,
+		.data = &tegra_pcie_dw_rc_of_data,
 	},
 	{
 		.compatible = "nvidia,tegra194-pcie-ep",
-		.data = &tegra194_pcie_ep_of_data,
+		.data = &tegra_pcie_dw_ep_of_data,
 	},
 	{},
 };
 
-static const struct dev_pm_ops tegra194_pcie_pm_ops = {
-	.suspend_late = tegra194_pcie_suspend_late,
-	.suspend_noirq = tegra194_pcie_suspend_noirq,
-	.resume_noirq = tegra194_pcie_resume_noirq,
-	.resume_early = tegra194_pcie_resume_early,
+static const struct dev_pm_ops tegra_pcie_dw_pm_ops = {
+	.suspend_late = tegra_pcie_dw_suspend_late,
+	.suspend_noirq = tegra_pcie_dw_suspend_noirq,
+	.resume_noirq = tegra_pcie_dw_resume_noirq,
+	.resume_early = tegra_pcie_dw_resume_early,
 };
 
-static struct platform_driver tegra194_pcie_driver = {
-	.probe = tegra194_pcie_probe,
-	.remove = tegra194_pcie_remove,
-	.shutdown = tegra194_pcie_shutdown,
+static struct platform_driver tegra_pcie_dw_driver = {
+	.probe = tegra_pcie_dw_probe,
+	.remove = tegra_pcie_dw_remove,
+	.shutdown = tegra_pcie_dw_shutdown,
 	.driver = {
 		.name	= "tegra194-pcie",
-		.pm = &tegra194_pcie_pm_ops,
-		.of_match_table = tegra194_pcie_of_match,
+		.pm = &tegra_pcie_dw_pm_ops,
+		.of_match_table = tegra_pcie_dw_of_match,
 	},
 };
-module_platform_driver(tegra194_pcie_driver);
+module_platform_driver(tegra_pcie_dw_driver);
 
-MODULE_DEVICE_TABLE(of, tegra194_pcie_of_match);
+MODULE_DEVICE_TABLE(of, tegra_pcie_dw_of_match);
 
 MODULE_AUTHOR("Vidya Sagar <vidyas@nvidia.com>");
 MODULE_DESCRIPTION("NVIDIA PCIe host controller driver");
-- 
2.17.1

