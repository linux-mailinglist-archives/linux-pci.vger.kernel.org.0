Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AEF74E38A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 03:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjGKBi2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jul 2023 21:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjGKBi0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jul 2023 21:38:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20609.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::609])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69F2127;
        Mon, 10 Jul 2023 18:38:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFS8o9pFEV0dUIgVUcMRBquji1fKNklvXJUe9TPxRIPbH0ayfsuARzocOICBZcwLvR4HJqyUKOfQAp9t0j9nM2elNSsKbTLfUK4Nh13cyRswEKBeH4kDnznuzq7t5Ex6noYcOXf645Xx8qAfvYQcK/+V7G/PVT8FvFfaFuGqX8KIdk3WsQDHc+DcHXugqtIzTPvKPi8RUPrb+Kx8PPGnMj3tTmX/FPXmM9LLjqqKyJpAPBTGXahqhWuDbrUn2HI3ipwMUX206oF1UgF/rx8GZNj4M1lARx2n27HZEaHrVMIGJ1ld8WujtmdHVOZpk13M0fJra1ArSDp3ATc7JqR9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjqRBZV/BRWYoL1Op7sNBPP8iaAjNShEAKeUMswYBQM=;
 b=g7zLOLTfUhYL6y7wi8xI9IISSE++190BhRUxnTBgV+WwTx8RuoFsDYO6T0dnY2FIZYEC6tRC9UGYn8Yr4hjsspj3gWZckt0xafFoBlUt0jCte3ijzpYaw+4XxIXcse7dzsCZOcvPhIWJKI7V208kKwEzwDIqaDW7B30+IAZ9o8t24FGKpcLTnNZ0Bk8CeneveyXjn6xY1BPJOwz4E3nF8a8CoBewb56hBYKfGJym7mlKWSUrItx94y5kqSg3jmZFXRt68qTxysRlIS3lDY69afGYMvlEspHLt4itjXfgUZ3RHEnP0FKO+eQMBGMEowtTbGPzLFMQCv4arj6l+kz+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjqRBZV/BRWYoL1Op7sNBPP8iaAjNShEAKeUMswYBQM=;
 b=Z7DiiqgT2KQNQBKnRJrO7ZTTGiI3xx2Fu3OkGkjvRLUDQIQxLdz8hTwZ/SeqhZCnsGDSlZDAg4bfJTw8iqtDll1aU+f2pM/wHh5PaVh9hGdbUOXxSEPg0x8fbXlmKImXHPObRn3aJjuEn2gf2VUShYrmo8ZqbnaGL+MSerm2sxo=
Received: from MW4PR03CA0047.namprd03.prod.outlook.com (2603:10b6:303:8e::22)
 by CY5PR12MB6035.namprd12.prod.outlook.com (2603:10b6:930:2d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 01:38:23 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::ca) by MW4PR03CA0047.outlook.office365.com
 (2603:10b6:303:8e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Tue, 11 Jul 2023 01:38:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.19 via Frontend Transport; Tue, 11 Jul 2023 01:38:22 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 20:38:21 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v7 2/2] PCI: Don't put non-power manageable PCIe root ports into D3
Date:   Mon, 10 Jul 2023 19:53:25 -0500
Message-ID: <20230711005325.1499-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230711005325.1499-1-mario.limonciello@amd.com>
References: <20230711005325.1499-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|CY5PR12MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa9c40c-0637-49db-111b-08db81af8380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mCdjBFgUZLGYswVaPHe2ZHQZbl3MRpYU2rKZmm48nggnmAZnGQdQ+CKaWKp6k4bSdJsEyClI4j79SJMdwQPf7IADkmyrwPCiEVuqnAMc16eTMqO1RwGiUFwuGMjwQAJEJUogoZe2yPoDVCG6IbX2IItc7yxGXjGylDKF3+zMCFsxgQG5JNoFupRFEGOp8qk/NI1sFalN8KIAtKl+IiZUFJAuX+7aQpB8U07sJUgepJEwOmHzGzS1AL2gktVP82DAssvKc0+kNVQO6ozZa5Uq7oUO+6xGS5IqTLMRYu/lND02a+XQB+RKBGnCpC2i99WpqgIibCfn2jxCwOK1bb2TRr9j0/gO1pA+YavXBxny+LVAKf1UP9XDfVH74IMiJsU0Vcq3vSl1YSIHRVKXaFUZmlSoyO7kWfEGw4+rGnOzE5OtSZVPNZAoNFdZNVMyuDdxUy39TZoWcRaJnvjYzS3ZYjk2zrM3cjtMZXLy5NeKrKtrAjh2LU511Tuee0+CkeF1LUG3MB1tx06WhDZSEUuaZmfVNSJuzd/dpPm3Am6g4+qfHskA+fdYk2HqS5+9EHo8CnibGXo27tmFsp+ZyB7hmqQjC0XavtPhqkmrdANnkL6jpkoE5xbMfGtotdJoiBs2XQdfUKEENXof5Gp0wEm12xrPtfsOUfipvYvmgCSd/4h0j88S2jkGWJCXGK/03dH28I5osVVlqj1t/DwqUQWJawmVWohMDrYv8USK9vD3LPquqqjdSp1RblDEwsIQsOC+aITOE167YlVRe7JtFvs0xvNsZXScrsMnT1G6Um3a51w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(336012)(426003)(2616005)(41300700001)(26005)(1076003)(83380400001)(16526019)(186003)(36860700001)(966005)(47076005)(478600001)(81166007)(82740400003)(356005)(110136005)(54906003)(7696005)(40460700003)(4326008)(44832011)(70206006)(70586007)(40480700001)(316002)(86362001)(8936002)(82310400005)(5660300002)(8676002)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 01:38:22.6806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa9c40c-0637-49db-111b-08db81af8380
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6035
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
PCIe ports from modern machines (>2015) are allowed to be put into D3 by
storing a flag in the `struct pci_dev` structure.

pci_power_manageable() uses this flag to indicate a PCIe port can enter D3.
pci_pm_suspend_noirq() uses the return from pci_power_manageable() to
decide whether to try to put a device into its target state for a sleep
cycle via pci_prepare_to_sleep().

For devices that support D3, the target state is selected by this policy:
1. If platform_pci_power_manageable():
   Use platform_pci_choose_state()
2. If the device is armed for wakeup:
   Select the deepest D-state that supports a PME.
3. Else:
   Use D3hot.

Devices are considered power manageable by the platform when they have
one or more objects described in the table in section 7.3 of the ACPI 6.4
specification.

At suspend Linux puts PCIe root ports that are not power manageable by
the platform into D3hot. Windows only puts PCIe root ports into D3 when
they are power manageable by the platform.

The policy selected for Linux to put non-power manageable PCIe root ports
into D3hot at system suspend doesn't match anything in the PCIe or ACPI
specs.

Linux shouldn't assume PCIe root ports support D3 just because
they're on a machine newer than 2015, the ports should also be considered
power manageable by the platform.

Add an extra check for PCIe root ports to ensure D3 isn't selected for
them if they are not power-manageable through platform firmware.
This will avoid pci_pm_suspend_noirq() changing the power state
via pci_prepare_to_sleep().

The check is focused on PCIe root ports because they are part of
the platform.  Other PCIe bridges may be connected externally and thus
cannot impose platform specific limitations.

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/device-power-management-objects.html [1]
Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
Reported-by: Iain Lane <iain@orangesquash.org.uk>
Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v6->v7:
* revert back to v5 code, rewrite commit message to specific examples
  and be more generic
---
 drivers/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f916fd76eba79..4be8c6f8f4ebe 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3041,6 +3041,14 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 	if (dmi_check_system(bridge_d3_blacklist))
 		return false;
 
+	/*
+	 * It's not safe to put root ports that aren't power manageable
+	 * by the platform into D3.
+	 */
+	if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT &&
+	    !platform_pci_power_manageable(bridge))
+		return false;
+
 	/*
 	 * It should be safe to put PCIe ports from 2015 or newer
 	 * to D3.
-- 
2.34.1

