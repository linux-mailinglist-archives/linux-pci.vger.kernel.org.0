Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2EE70F9FF
	for <lists+linux-pci@lfdr.de>; Wed, 24 May 2023 17:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjEXPWw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 May 2023 11:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjEXPWY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2023 11:22:24 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA29F5;
        Wed, 24 May 2023 08:22:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWZv8JIbrwYTVqpgZuRDP6a19dUkdMPBtjsq+qTTyqZG+b5KT6PbCGvTABJ6O9B6zozDTcGLmaEVncM90zRDSkj+fMFw7ha3cg0wy6UwbI+RhJKOHxzMsQU9qAub0NExDcaXzyJW1MSzi0TsQLqqh+M7YI/LKuBenKd/V6efdAaexKNft/9UwMN94SoPC06DrZY2wK/nSMxeJqwFAtBcOzxf0xjZSo/4dJYS4CdWD3E8qYzj1TuoXEdMKsQ6z3lmkdtJoTe1eOy+G4L/0an6XnRueGi62esq0vBL5j3DeGqiTjfrK7Hx0YQUaa1LRi6vIYbmk3qsAs/3+OTtNVNcHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYLBkh1JwuGcWKNkwufe7MgWSU5eNBqDSsmnx43WOIM=;
 b=DIVhgxVZ8A6bkAkoLuE5qr/MyXTInfOJKRRIgdhU+63hIXpHJaPlSLpr9KkWrAxZm3wCtw+sJhUvim9EEQQWui+8I4s5+vFhhu6uBV1cdbuLJn/I6PxnhLc8wBOGRRqGxtm21wIBa38k7ZaWEXvXWFX3nwX6EYs2Ey4PQAq9ESbhRQO0aMzdDMjZoclkP4q3uLbSNOl+0sQeawDxGfIUya3arLCTLCTivM+1NrpGogdZw+X1acaF/QIUjInhAGxaaNXqgkIs5EZ/vHsSrlaPubt/RPzY6bNpzW5k5Hj+POVoEDakAW41fl0Nwde7aeoBxuQNvNFSN7TPMcTHoT45ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYLBkh1JwuGcWKNkwufe7MgWSU5eNBqDSsmnx43WOIM=;
 b=jkG3rCsC++Irs4HmSQ77diWZI042SawpP0NLZyp1mmo4QYqukSUHHr/Q0yMF8knt50DCAyxldwT1J9woZ/HuMTUmv3X3oTyV4F4Be0poJiQNK1UFQC37U4ZI4KEnBCKDBljPfmtynAMrt5OykKn7P1x/Pmd14mA6YgmVVy2SKU0=
Received: from CYZPR10CA0002.namprd10.prod.outlook.com (2603:10b6:930:8a::6)
 by SJ0PR12MB6902.namprd12.prod.outlook.com (2603:10b6:a03:484::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 15:22:19 +0000
Received: from CY4PEPF0000C973.namprd02.prod.outlook.com
 (2603:10b6:930:8a:cafe::c0) by CYZPR10CA0002.outlook.office365.com
 (2603:10b6:930:8a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Wed, 24 May 2023 15:22:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C973.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.7 via Frontend Transport; Wed, 24 May 2023 15:22:19 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 24 May
 2023 10:22:12 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "S-k Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        <linux-pm@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Iain Lane <iain@orangesquash.org.uk>
Subject: [PATCH v3] PCI: Don't assume root ports from > 2015 are power manageable
Date:   Wed, 24 May 2023 10:21:36 -0500
Message-ID: <20230524152136.1033-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C973:EE_|SJ0PR12MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: ad197781-c17e-48eb-6328-08db5c6aaa3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4/79Siq/efG6Hl8vqDMt/nnE1k0/D5ua61M5n3YoCQ/vxEzKX8WWI4uKHwz7bEMK2uUjasCYzth7TlT8HTgrWSEQc0ZTF2u1VtGF90LZD7RWzEZ74PnCqCF8QdTuIjI1mqZQFshwjEAtdlT6XszBBiZKeaTnYq75fyQMAtAgSWEIpj5JUEqC6029mfVEx+m4VmKUcwlqoGGivB+lqSIv41/yRdaSSHD1GWqshq8h3pfEVdyfdr8Cy8i4oE47W3Nuq0O3Qk/mwGGSr4DI/f/N/2DUndGGfSGbpZ2eh0CouxK1eyCKC4fWhr3Oxo3dfNwb5Mi7zymH7Pj3UuK5FSFTOX90doaGEORbZgww2GFIJf/Ix3yrlxq58897vpW824/yVUMeuIHbtLXN6PloF0l+uSwnDd/IUIrrSPY3re5jwDX2tWZiGaey/V54TDzLhR2mZ15e57xuJvPeZYyeZGsVDT14fZRS5QnMyaNCEDIXyYwQ411K3Vvryx0D3JfChsk/XGdZwRNyZPogweHTT17h+j/g3DyRjkHBHRtMgdoWM+VCl9XmGCeItsYSRbBJzDdYG82l5G8pWc5XQ7qOA8GAgbzY0Vls1jGmiNXpDyESlB5gjcr3HmDtee4Hy2xIqWe+jynRtU+pJ/LzNJxaPmpv7ZYn4vv/L3DQ7XB5kloXuBVD2D2pLnb8GHoXEU6GfqcjhPQmPqcKNvbDWS45d0T+tH2rzG61cBf4uKX8kr0DrTYWldkfzAuJaZ1e0LcUIGgnUUB4RF3sYwpGcth1yo51Vg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(54906003)(110136005)(6666004)(26005)(1076003)(70206006)(70586007)(316002)(4326008)(7696005)(41300700001)(966005)(478600001)(8936002)(8676002)(5660300002)(40460700003)(40480700001)(2616005)(83380400001)(86362001)(426003)(336012)(36756003)(2906002)(356005)(82740400003)(81166007)(82310400005)(44832011)(16526019)(186003)(36860700001)(66574015)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 15:22:19.4532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad197781-c17e-48eb-6328-08db5c6aaa3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C973.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6902
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Using a USB keyboard or mouse to wakeup the system from s2idle fails when
that XHCI device is connected to a USB-C port for an AMD USB4 router.

Due to commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
all PCIe ports go into D3 during s2idle.

When specific root ports are put into D3 over s2idle on some AMD platforms
it is not possible for the platform to properly identify wakeup sources.
This happens whether the root port goes into D3hot or D3cold.

Comparing registers between Linux and Windows 11 this behavior to put
these specific root ports into D3 at suspend is unique to Linux. On an
affected system Windows does not put those specific root ports into D3
over Modern Standby.

Windows doesn't put the root ports into D3 because root ports are not
power manageable.

Linux shouldn't assume root ports support D3 just because they're on a
machine newer than 2015, the ports should also be deemed power manageable.
Add an extra check explicitly for root ports to ensure D3 isn't selected
for these ports.

Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
Reported-by: Iain Lane <iain@orangesquash.org.uk>
Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Only apply to root ports
 * Update commit message
---
 drivers/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5ede93222bc1..51126891a2db 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2976,6 +2976,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 
 	switch (pci_pcie_type(bridge)) {
 	case PCI_EXP_TYPE_ROOT_PORT:
+		if (!platform_pci_power_manageable(bridge))
+			return false;
+		fallthrough;
 	case PCI_EXP_TYPE_UPSTREAM:
 	case PCI_EXP_TYPE_DOWNSTREAM:
 		if (pci_bridge_d3_disable)
-- 
2.34.1

