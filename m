Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1313771F49
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 13:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjHGLHz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 07:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjHGLHy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 07:07:54 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8267BE8;
        Mon,  7 Aug 2023 04:07:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lhp8A1ksVG1olCMj28NUgPcoYbzvF9lMEQYhphNMuRBx1eaax23k9gavvu55wRMiwTrQOhxgIFiyFWU4ubc49W4gNJRTXVKC1oebpOdaL1+B7mzAD9p/F5fdb6tlV4C2mRa1woL37vANT2ZeZHp6u4LkVwe222jaKH5rSt7zd99EK47wDCiZnTTwfX80pOSCXO101utJpBUqgIM1ZeVe4EAdfFdL7xjadbU0Sr0tASozOQWYjmLDuUqI0uonVOuWoonqIlV8c5B0sBZbgPFD5snjNu7Upteb2c8FVmBm2LzGwqHrcr8YLaRPgwogajkF9cect2YaXWLdeYxl9KE/jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akB1xvTbx0BTgXcPQfmOaM49N3KYget4rr8n9oenZtE=;
 b=W12lhCMQdNXNgC1AqkYRx9ejpHftOXcURAqFLoQifgWZW4UkOxYFLM7o8dkx1uz4/OynSesDOiXSN/WsRMQ7aWJnKNyijVleCLiFCixjQ2uNqu4USGZ33/eKda4WkMFSz2+e2/FLrCC8N/ES/G1TdfkpOrpZkoLlN+WVVEswAGQlaSgMuXyHyYHDUKLVMSXUoOuCP+e9mU6HcbrTvZokHqBm+4PteKN7llu7Nzba2uuhUIQv+ii4stdR7dYd/uv354G7+XIKDB2XFgy32S5QWX6Grk84l7CjALYz19Q0B7ZKMp9oIplxeLozb9VClKpswQ01jCT8243SP6KTbjjaEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akB1xvTbx0BTgXcPQfmOaM49N3KYget4rr8n9oenZtE=;
 b=HP7rhWOmdRzYG5uTquU+sGy0xnuU8yQwz4kvMZ2BeBxyMcYdl2d3tzworV/1KMdncWvZhOpvv/lsH2khXYLLM2ILnJPDNx07hUFTfDr++MCRjPitv/AuffbRyol686feZge15b4QcGLMq9dUzmU6+nF0GjUfeunnGVNq8g0g+bw=
Received: from SJ0PR13CA0180.namprd13.prod.outlook.com (2603:10b6:a03:2c7::35)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 11:07:46 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::84) by SJ0PR13CA0180.outlook.office365.com
 (2603:10b6:a03:2c7::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.15 via Frontend
 Transport; Mon, 7 Aug 2023 11:07:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 11:07:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 06:07:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 06:07:42 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 7 Aug 2023 06:07:39 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <lpieralisi@kernel.org>, <bharat.kumar.gogada@amd.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH v1 1/2] PCI: xilinx-nwl: Update ECAM default value and remove unnecessary code.
Date:   Mon, 7 Aug 2023 16:37:32 +0530
Message-ID: <20230807110733.77364-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807110733.77364-1-thippeswamy.havalige@amd.com>
References: <20230807110733.77364-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 7211efe2-6a18-4f65-a1da-08db97368748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uVfah3SyLDelixuK5j9c3O0k/zBWsU7CY/sR8Iy5nb0+Vb/ocy9gddBO92lUSXjOwrUaA4qs6lvpr+0qJA4FmnTne/JltnOATE7fqPIcnvm8/xc2MCeHmEF14/JKQq55YBRjtq1thWP0MAp+jWv5OT4xeVvb+BYIzDZvRU+aNLX9pth18juJyspARAX8AByuMkceymPGMwT35wru82RISPx1b6rFIFr7gZvHbEskMfB4IWlQ264ODXxB7Zu8DsBzWY7ok5l417BKbpBCA3PSEnuecNfE+6PUYrQqb0+aT0K1rMXAAnwKCmgfrkNyT0wPdZbUl82hS8fFHduedd+UuMwqIkqsLxTZKUhEC3fMtOVerUGRyfH49HIrH84dUnNwpmJVWS3BWaTlD6zX6SyxTS61sp8nXAptEEmR8+hZ8fezieJd/gnqh5td10Txc/0s4SFXWjimX95jJ1GZOOxsJHjyrPptUu5vkHPC57xSyD+HyX7qN572H3wHMx9BFeDwa36hDMretAVmLtQHDHtKX7QmVa8Qab51s0SgdVMsC99/V+vUULQvyOvCNYIMEAoxmQvCcWsbDWYU7nA1LBVLv1ro7Ekr73AylPF1YqhgZR/cEu6XtbzKmvmwUgNzDOpABaArHHTZo2QGBC0jeQlM8HfyJ2bvxxChixDqizFvJ2yo+b1qGA+rCM9PeSzm1FfLIPmRup5bGo4Osv7iDDd23XmDx+R5oQ30Y/ZfqYlgSo8ewzKUHOFSNEzaM47e4yZqbYWlw1J0Vj5swY3+/DIcdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(82310400008)(186006)(1800799003)(40470700004)(46966006)(36840700001)(40480700001)(336012)(40460700003)(2616005)(36756003)(966005)(4326008)(316002)(86362001)(478600001)(81166007)(110136005)(54906003)(356005)(70586007)(70206006)(6666004)(82740400003)(41300700001)(1076003)(26005)(426003)(15650500001)(8676002)(8936002)(47076005)(36860700001)(2906002)(83380400001)(5660300002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 11:07:45.5206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7211efe2-6a18-4f65-a1da-08db97368748
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

