Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E58E771F3E
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 13:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjHGLE5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 07:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjHGLEz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 07:04:55 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D60103;
        Mon,  7 Aug 2023 04:04:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7RQSY46pTewEVT1/hJofijB9SrNN8igQGUI1MreGmkYceU0ErHIneApr2/Y/WZ0BET/6ISuNF2Ovv9mo1sLdtSqe632UWO0MlBlkyYLWHfigiY8LkNh5LtIexRaR5fPz0wXGaUdzf4F6FvlNwkbCj5GwVEqv7D47yhhtyj/nLKttD7uE0GlI4hoZ7N3N52ReWI1PUiXh6sOTPVl/dZaUr4r2BEKd3Zx/Xviuprd3+dybdAOHxzM1uW27bTtl1kSBXC+aMgseglp2VZFwj7xnq7+DgWPNsH5LSg9jI+Jo6pdiwlKIvqH5YowBjH2lpMvwpkYkqv41MWmef+Jhdll4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akB1xvTbx0BTgXcPQfmOaM49N3KYget4rr8n9oenZtE=;
 b=EkV/FquWStTYbVBBkjJnDWPol4bdO+TZl4kEWcNNp6XZtYF5yJflov2IZsBt7NL+d4MjmWugCvGpX3pf0OPYius9qJsiCproYhNVT8+fPDXZX2Qdl23/a0ySTe8RVfXcieuSwEIFw5+tLXurBVdGRvhZa3HeEZl+76oWBIchHir32EYOzVL79LXomKnb50Op0Q9acD5GiGkh1jgenYIt3yN6jVjdllCJzL8adgXaYN/1FwjnjoLziabO7srsME2L2k03tJZS4c2US+HHVbsUi3HoIUVAQYIpJbyfy8wkmJ5D5Y7Xo2rRgRdngZ4ltXJ2YwOf1V9ZZaPSPgYd5Mg7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akB1xvTbx0BTgXcPQfmOaM49N3KYget4rr8n9oenZtE=;
 b=YJvUWWnCE2v/IDSdnWV373v4Q0SkehK7TnpVFgZo3BG+dcx6vQf32XHfmiWorM3FcY6Ze44b0VBsiZ9OLioTZBQOiLnvqfLSoOd8wYZD24xcsJtQFo5sFRFdDSh52FJghQFdlkjBxsUdeK3QWfSpDVjTyYBiAH6QN9kiAlRL12I=
Received: from SJ0PR13CA0226.namprd13.prod.outlook.com (2603:10b6:a03:2c1::21)
 by DS0PR12MB6557.namprd12.prod.outlook.com (2603:10b6:8:d3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.26; Mon, 7 Aug 2023 11:04:44 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::3c) by SJ0PR13CA0226.outlook.office365.com
 (2603:10b6:a03:2c1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.16 via Frontend
 Transport; Mon, 7 Aug 2023 11:04:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 11:04:47 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 06:04:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 04:04:45 -0700
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 7 Aug 2023 06:04:42 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <lpieralisi@kernel.org>, <bharat.kumar.gogada@amd.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH v1 1/2] PCI: xilinx-nwl: Update ECAM default value and remove unnecessary code.
Date:   Mon, 7 Aug 2023 16:34:36 +0530
Message-ID: <20230807110436.77287-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807110436.77287-1-thippeswamy.havalige@amd.com>
References: <20230807110436.77287-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DS0PR12MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: 240f8c36-8d1d-41b9-2d6a-08db97361d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FP2ZqdJb8mvT1XDgQOCOe6IJ5d44OEiGRlkAOcnyGq8zifn+CYMQmeJF3DPJA10smfi13BVd5Z59Pnj7XbrfmjD8NySopxo+eAXzLMgVrFl+Me8m6dxBDGjJ+ZhZijsnxJlRg4AphH+EMLWganpwRXjnEIehM9Cw1MlZvQNczTYDDLL16ZQtV4RAr2ki3Z6cxyj16ZhIzw3EWpbpEiIkS+yEAx/isKga5C4ruGIv1nZdm2fmTTItDERwufot2XWYc0LF7LqYIJV4JShfQSKwz1wzd7vB/B5S1KUNeYZmEopr1uHiwQUnbYE53o5kYNSOxjOc4mEmPtnetRzPJHY7nFl5XNdR+V4ZZXKE9p/KoCTTcF3SjML3gAexBbqI3RezAyIMMGTfsmMw0GEgrjstSR9QG7+jjQFLuuwLJbh7J1GFDztQfbHKYJRmxt110lzpHkuUCbiNKQoZrvvuGDaa2ELneeXQoOSnwGxugznXAhBrD+zrBSw3hzezRdbk3T0+wIlAfv232v6kQdDQ3oNgZqRqXZBuI+NyeafxrUz4sRwd4Qt6kNGE9qeX2iYhK9JH4LGYoAX0e4tjz7QVdTDa2brCKBxxHLPHNEgYyMMjbYsPvsC2dgvz8f2PiahJnbuQtxDC+q7ueBIAlV5crSVjkO73bhEoSh3VyKGd0c2HV54UTzIAJosyQ1te3Tw1vrQo41TdL079yRHs60WwWeOYi+LgOxJeZZ/kefKiitVg5iiXBGNRqbDOuo9J68zK/Ak9fI9H4JP2Y5UWnZ4tcmzUyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(82310400008)(1800799003)(186006)(46966006)(40470700004)(36840700001)(40480700001)(2616005)(40460700003)(6666004)(478600001)(86362001)(966005)(82740400003)(81166007)(26005)(36756003)(1076003)(15650500001)(356005)(41300700001)(316002)(8936002)(5660300002)(44832011)(8676002)(54906003)(110136005)(4326008)(2906002)(70586007)(70206006)(336012)(83380400001)(47076005)(36860700001)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 11:04:47.1982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 240f8c36-8d1d-41b9-2d6a-08db97361d01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6557
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Our controller is expecting ECAM size to be programmed by software.
By programming "NWL_ECAM_VALUE_DEFAULT  12" controller can access up to
16MB ECAM region which is used to detect 16 buses, so by updating
"NWL_ECAM_VALUE_DEFAULT " to 16 so that controller can access up to 256MB
ECAM region to detect 256 buses.

E_ECAM_CONTROL register from bit 16 to 20 uses this value as input
to calculate ECAM Size.

The primary,secondary and sub-ordinate bus number registers are updated
by Linux PCI core, so removing code which is updating primary,secondary
and sub-ordinate bus numbers of type 1 header 18th offset of ECAM.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
---
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: 
| https://lore.kernel.org/oe-kbuild-all/202308040330.eMTjX3tF-lkp@intel.
| com/
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 176686b..b515019 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -126,7 +126,7 @@
 #define E_ECAM_CR_ENABLE		BIT(0)
 #define E_ECAM_SIZE_LOC			GENMASK(20, 16)
 #define E_ECAM_SIZE_SHIFT		16
-#define NWL_ECAM_VALUE_DEFAULT		12
+#define NWL_ECAM_VALUE_DEFAULT		16
 
 #define CFG_DMA_REG_BAR			GENMASK(2, 0)
 #define CFG_PCIE_CACHE			GENMASK(7, 0)
@@ -165,8 +165,6 @@ struct nwl_pcie {
 	u32 ecam_size;
 	int irq_intx;
 	int irq_misc;
-	u32 ecam_value;
-	u8 last_busno;
 	struct nwl_msi msi;
 	struct irq_domain *legacy_irq_domain;
 	struct clk *clk;
@@ -625,7 +623,7 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	u32 breg_val, ecam_val, first_busno = 0;
+	u32 breg_val, ecam_val;
 	int err;
 
 	breg_val = nwl_bridge_readl(pcie, E_BREG_CAPABILITIES) & BREG_PRESENT;
@@ -675,7 +673,7 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 			  E_ECAM_CR_ENABLE, E_ECAM_CONTROL);
 
 	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
-			  (pcie->ecam_value << E_ECAM_SIZE_SHIFT),
+			  (NWL_ECAM_VALUE_DEFAULT << E_ECAM_SIZE_SHIFT),
 			  E_ECAM_CONTROL);
 
 	nwl_bridge_writel(pcie, lower_32_bits(pcie->phys_ecam_base),
@@ -683,15 +681,6 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 	nwl_bridge_writel(pcie, upper_32_bits(pcie->phys_ecam_base),
 			  E_ECAM_BASE_HI);
 
-	/* Get bus range */
-	ecam_val = nwl_bridge_readl(pcie, E_ECAM_CONTROL);
-	pcie->last_busno = (ecam_val & E_ECAM_SIZE_LOC) >> E_ECAM_SIZE_SHIFT;
-	/* Write primary, secondary and subordinate bus numbers */
-	ecam_val = first_busno;
-	ecam_val |= (first_busno + 1) << 8;
-	ecam_val |= (pcie->last_busno << E_ECAM_SIZE_SHIFT);
-	writel(ecam_val, (pcie->ecam_base + PCI_PRIMARY_BUS));
-
 	if (nwl_pcie_link_up(pcie))
 		dev_info(dev, "Link is UP\n");
 	else
@@ -792,7 +781,6 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	pcie = pci_host_bridge_priv(bridge);
 
 	pcie->dev = dev;
-	pcie->ecam_value = NWL_ECAM_VALUE_DEFAULT;
 
 	err = nwl_pcie_parse_dt(pcie, pdev);
 	if (err) {
-- 
1.8.3.1

