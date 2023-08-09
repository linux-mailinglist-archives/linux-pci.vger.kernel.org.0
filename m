Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C68F776930
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 21:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjHITsU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 15:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbjHITrg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 15:47:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C269210D;
        Wed,  9 Aug 2023 12:47:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SG/V6ZrxslfLLJYzmfaRnLLMUtl082REVAp/7MZ0xTtGj1O5GhNHvi+B6GnpsWBzRolew01VnTm851QaCsLphLLXa88Q8d+k6cnyeUCIkKriDD9NQkOMedz5oxsHJQefqxIKbEaV1D3rmHOW6mr14TMHWA7wlXZadG8JuSuflB413xe1wfttogROMI08LH0Kp5Tk17xJ3Eqwmn/o1ppw6I5ebhmyHfR6hj7QlsQdoajK+b1wsyUIAQ/wRYtmXnunB1v4HKYXhG3JoV2WzZgwrBHtKUDHKa+YFG2b2SiLvOQVPmZc5LmV1zGnFrMqNXa1+BdDCwlBUvbhWLukkdxlgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7IljWi8fyJCaKaHKU70C/9A6XxwrDPhSFrCKPfFtKY=;
 b=WO67AGQfg1g2mZqBe5VhseRg/RkxRMhbfexNJDxxxmoZRHLt2Rkk7zX82q52C9Lyy0qbj6xET1h7jPuYDg7RFGGlzJDJ/ouvhu09KRkInmTsIw3wiRCNlBDFc89TxweZZxO5WCJwk4deLlmYjQSnv2oWvXmYAaRg6fkXdS2mFVsUhAvN7oXR7Qx6NGeHb4NXtIZRvJghW6X7/s/NWDID/AHN4MvFVFdoFx9NR+hI0MAjWeJocBufe71L+wo/nUn19lEsG/KBLSUQJfB2OtVvRONjNjl6DTiNiogRwIx5EjRmXaCmxCqW3Oqi6njXRccuXcpvwcHAFQScQtqQFoM9Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7IljWi8fyJCaKaHKU70C/9A6XxwrDPhSFrCKPfFtKY=;
 b=46VVImrOUqrOszIcJMllAyK9grmcjgup1j8pV7pSrWk82E89j5ZJHV+a61ps+nvsWwwoYtZ8cr3MiLLVXgYs2GEJY2t0W7t7zeoE8B0tXoavI4mlp/OOVY85cw0NoOzhLPxOnriO5QucVEXVDaS1r7f5kcybkFFDYbWgXLx/Hgg=
Received: from MW2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:907:1::34)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Wed, 9 Aug
 2023 19:47:22 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::74) by MW2PR16CA0057.outlook.office365.com
 (2603:10b6:907:1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 19:47:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 19:47:21 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 14:47:19 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        <linux-acpi@vger.kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Iain Lane" <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v11 8/9] PCI: Split PME state selection into a local static function
Date:   Wed, 9 Aug 2023 13:54:52 -0500
Message-ID: <20230809185453.40916-9-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809185453.40916-1-mario.limonciello@amd.com>
References: <20230809185453.40916-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: da5aeb87-5ed5-4666-71f3-08db991172b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YVkYUY8kmZ/BydUO2qrjjIWDdSxd+kaiCeriLKumzdgWf7wW3mtUkIwyY5L/ipSqzKXzkgv38c6ghclQ8k3XIP79vTIM45LOS1l0Z1Qtr+bA2Vas9txE6pwooMeoG1UDfsplsPWNUa0ZH92gqodXQDHvC+aQplIa3h8G0FE7mqoWAlNEI+O7PaAW1njO13kotlN5VH2rODNZFsR6VPkDXYNIM1AaHO4dljcIfRb5axl0S/zE5195RuVUBZ81TIVNJmTVchUCY9qpQ+k9ZQvnj2tNue62Z8H7pkeJaf4RapLlrHKlDi81Vu+UPZ8zak40x60u1vbBg/ziLZSsxnBpQuEu6aoAKffItN5Fo3+UL33JyoWE52zoT49FayplzuImFx66xW9tSHXJuh6NdJbz+AY/BQ0+tHvGfG4OWfIq4mW3kjcUnVbxqsw1K9gAzV8hiPOnPDaJkDV4LNP5wzD09ydbpJ8kR0fmygf+mbzAl3C7IwdjMedm+cByScMks/omqOhtat5XqjzpfRN0eeqnpcEthT1Nb2wS4eCJqvP9jIt+QWfh467C/Wyl2RcZwmF+NNXi9S/ubfLbtZMdg0JyBTVzsYlFw6VOk+TVl+TQy75aU3PfiORwXjBWLmDtUWsOenKlg4t5+Z1ryElmVAO6xFd3BSJCH0YeyZAV4Qy+79O4/DODSl2KJUCLs1ddbyO1/p++y+0BbSuc9+Dg+1vgGRfpPKj8pOt6/Y3thQNfF3pJsHr9nLsyBimdvbFVkqUKbrlF2ax9Xu3dbZZ35alcCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(82310400008)(1800799006)(186006)(46966006)(40470700004)(36840700001)(6666004)(7696005)(40460700003)(86362001)(1076003)(26005)(40480700001)(47076005)(426003)(83380400001)(2616005)(36756003)(36860700001)(16526019)(336012)(81166007)(356005)(82740400003)(44832011)(316002)(41300700001)(8676002)(8936002)(2906002)(4326008)(70586007)(70206006)(478600001)(54906003)(5660300002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 19:47:21.9310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da5aeb87-5ed5-4666-71f3-08db991172b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When a device is not power manageable by the platform, and not already
in a low power state pci_target_state() will find the deepest state
that PME is supported and use this to select the wakeup state.

Simplify this logic and split it out to a local function. No intended
functional changes.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v10->v11:
 * New patch split from existing patch in v10
---
 drivers/pci/pci.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 60230da957e0c..693f4ca90452b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2660,6 +2660,20 @@ int pci_wake_from_d3(struct pci_dev *dev, bool enable)
 }
 EXPORT_SYMBOL(pci_wake_from_d3);
 
+/*
+ * Find the deepest state from which the device can generate
+ * PME#.
+ */
+static inline pci_power_t pci_get_wake_pme_state(struct pci_dev *dev)
+{
+	pci_power_t state = PCI_D3hot;
+
+	while (state && !(dev->pme_support & (1 << state)))
+		state--;
+
+	return state;
+}
+
 /**
  * pci_target_state - find an appropriate low power state for a given PCI dev
  * @dev: PCI device
@@ -2701,21 +2715,8 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
 	else if (!dev->pm_cap)
 		return PCI_D0;
 
-	if (wakeup && dev->pme_support) {
-		pci_power_t state = PCI_D3hot;
-
-		/*
-		 * Find the deepest state from which the device can generate
-		 * PME#.
-		 */
-		while (state && !(dev->pme_support & (1 << state)))
-			state--;
-
-		if (state)
-			return state;
-		else if (dev->pme_support & 1)
-			return PCI_D0;
-	}
+	if (wakeup && dev->pme_support)
+		return pci_get_wake_pme_state(dev);
 
 	return PCI_D3hot;
 }
-- 
2.34.1

