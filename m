Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BD87C9E8E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Oct 2023 07:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjJPFLx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Oct 2023 01:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbjJPFLu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2023 01:11:50 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A141F2;
        Sun, 15 Oct 2023 22:11:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXdEOC7+V2JsnPv2+4UnS5UIX5uEAaQnvmRpWacvUcoZTamFxBpywSs+Xdmu0jsoAV1DAwOu/jscq1zbexVw2rxhN5iZ76FkuvljsqZedZsj7Ddt9MwlhIA3gMhALZ9AVDyafuWaa70m/GM8mZPNSi0jo5axfGsLVI+bEA7/PQHTJc+IEIvRZMzsVnSSl8EaF78V3y8hBQn4bjeP/gq2OwKqq58U0VW1NKU4ehW6aSGYcop6ulqmwzPHrPAabEmt62MguryJ7qwQeszKoUGmh5luPCvAT2I2DZY16hUbDLa8zuW6Gvh04ScThbq7Gqt2p7E8IjsH7X13twUq/8uD1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ESYLK1Re4VerwS7kWjWSjaIYrADQbJMwrXP7iIWn9w=;
 b=WCEynGq8OZU+KmsaiihUYrN0uHlUwK7uk8ssLWGF87Noja7qw0qAiFscC+FyZq65YepafNfROeMYzpm5p+Gp6wlsjxDGrMtZzLyHLcqLCTF4ozL+U95WV3VrrHkaCwWx4hoYe9spVuOL+6utCt6K+Vl9PpxezLTyKbsfZkugBuFGzMj0iW7ELuyLBw8fft+zYRSrOaN16GUoWxBZz4ZT+YC399p+s9Z5NrJIC/MBXKpyVHwLA6iT3UqLnWBvatiPlC3GFCl+zCqNQnys3KKPtZQhe6kaxg+Yp5BveiM5iPy0akREAOnMNfo5R8LbRqbK/Y5vrN40qvXdVXgVnjKDrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ESYLK1Re4VerwS7kWjWSjaIYrADQbJMwrXP7iIWn9w=;
 b=yFT4xlDVJRyAyjQ7UoWmY13/t5k9jnBmKEFb7i0xmjiDWCc8ZXMlCuyS13YFCfFbBWYpTj4183Q2Lt1zYVKkW3aXpuXP+cvg9lghCOYp1AFMcmEa2KRPwnCQJSvScqECHmAJYGtSiG80kamhg+QU5EIl0sFQ/tzPvkfI2arZJHU=
Received: from BY5PR17CA0059.namprd17.prod.outlook.com (2603:10b6:a03:167::36)
 by DM4PR12MB7597.namprd12.prod.outlook.com (2603:10b6:8:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 05:11:44 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:167:cafe::30) by BY5PR17CA0059.outlook.office365.com
 (2603:10b6:a03:167::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34 via Frontend
 Transport; Mon, 16 Oct 2023 05:11:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 05:11:43 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 00:11:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 15 Oct
 2023 22:11:42 -0700
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 16 Oct 2023 00:11:39 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <colnor+dt@kernel.org>, <thippeswamy.havalige@amd.com>,
        <michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>
Subject: [PATCH v5 RESEND 3/4] PCI: xilinx-nwl: Rename ECAM size default macro
Date:   Mon, 16 Oct 2023 10:41:01 +0530
Message-ID: <20231016051102.1180432-4-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231016051102.1180432-1-thippeswamy.havalige@amd.com>
References: <20231016051102.1180432-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DM4PR12MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: c14822e7-13ea-4a79-13fc-08dbce06638f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vCDoZvNy6ovvi5dnC/bu5NLRdkg04E0eRas2k171ZqXcWgD2CUyLTDtcr9g6OPbuYvjbN9UCKztvcVwPAud/8hUYB5qhmMqRzQzWMyar1o+QsNRviVA8xFoclS2FPeSHTnr12WCNN/1jDGvcymZd3T0p3a1g+aOMX0ntqJ/cuuU4kAMg5OzbpgwDqns3Bc8znPjZX+7OlCBw++VxB3AMzR9KjU7w8px74KXsF3gCw2j6/96VOBDG2S9/8+UuA6pSCwXpA2lie/iXjn/584Jd2ysg+MpT+5HPvamAyOECb6dJWSh478XnBw6kWLtqHYruN69S7WEwuPohNgjY4wc76p6xpyBpSjUUwn41sZlgYxy0qfZg89PzLH6US1u7aC8IP5aU8GoIAbbwMEVXT0zNTSU/53wkShnmJlZVU7EupDrGbXaFVhtPeRflWcqISyhlAcYzESt09/MiZfVxnePahwrYZmNn6zkK+/HRlN8C5Q66UvdYEnUMzoFfKwEtzS13x5MRa9coXY0tf4QX/e+EZdkHruior0gnDEn8f0hOg53l4zqsaCjij6iUnPpQf7zjTaGCPppomSH9svql04IDdZSa6mSqyfTo8lUx1qRxMkJlFYlQhI61nS+rX8YoyPh1duGNGdlckYZy7l5fpt7GcoGemDEWWsLKdjdO4uuOUicnE5tvOOO+NZ9AjTMCybVQVNeplzUgpkmOfoc6EVmDLFh1LQOWg6tVOQZb5jnQU+ukw95Zl/AZKfYc7P1quNplvERqV6BuSR7R9qxJINi8xQLMPKiIr9ekA7F2ree+XCc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(82740400003)(36756003)(81166007)(356005)(36860700001)(47076005)(83380400001)(6666004)(26005)(426003)(70586007)(70206006)(316002)(54906003)(478600001)(1076003)(336012)(2616005)(110136005)(7416002)(44832011)(41300700001)(2906002)(86362001)(5660300002)(8936002)(8676002)(4326008)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 05:11:43.7097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c14822e7-13ea-4a79-13fc-08dbce06638f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7597
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename "NWL_ECAM_VALUE_DEFAULT" to a suitable macro name and remove
redundant code

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
changes in v5:
Remove period at end of subject line.
--- 
 drivers/pci/controller/pcie-xilinx-nwl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index d8a3a08be1d5..8fe0e8a325b0 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -126,7 +126,7 @@
 #define E_ECAM_CR_ENABLE		BIT(0)
 #define E_ECAM_SIZE_LOC			GENMASK(20, 16)
 #define E_ECAM_SIZE_SHIFT		16
-#define NWL_ECAM_VALUE_DEFAULT		12
+#define NWL_ECAM_MAX_SIZE		12
 
 #define CFG_DMA_REG_BAR			GENMASK(2, 0)
 #define CFG_PCIE_CACHE			GENMASK(7, 0)
@@ -165,7 +165,6 @@ struct nwl_pcie {
 	u32 ecam_size;
 	int irq_intx;
 	int irq_misc;
-	u32 ecam_value;
 	struct nwl_msi msi;
 	struct irq_domain *legacy_irq_domain;
 	struct clk *clk;
@@ -674,7 +673,7 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 			  E_ECAM_CR_ENABLE, E_ECAM_CONTROL);
 
 	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
-			  (pcie->ecam_value << E_ECAM_SIZE_SHIFT),
+			  (NWL_ECAM_MAX_SIZE << E_ECAM_SIZE_SHIFT),
 			  E_ECAM_CONTROL);
 
 	nwl_bridge_writel(pcie, lower_32_bits(pcie->phys_ecam_base),
@@ -782,7 +781,6 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	pcie = pci_host_bridge_priv(bridge);
 
 	pcie->dev = dev;
-	pcie->ecam_value = NWL_ECAM_VALUE_DEFAULT;
 
 	err = nwl_pcie_parse_dt(pcie, pdev);
 	if (err) {
-- 
2.25.1

