Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62CE78138E
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 21:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379676AbjHRTlY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 15:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379707AbjHRTk4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 15:40:56 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA034225;
        Fri, 18 Aug 2023 12:40:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSew1JGCqImcuUdzCYPZRIgTie2Z1KSXAqdj6DobMqNZx7yvpWtIeJXOnXJnQsak3IdHTsxFoL4y2/n3BU7MSEp5F451v2DW1fdwK0y8CZju7/cL7b/PRCrtaCMSyjtOcrXbIb93otqMgtZWywtumJpYoiMgTPmM7LbTplt9Jl6ferBGDVpCcwsjvFL9JeRWUUrvinUD82yJgF5jv+uD/06hqkd0ZL52FyVO2l/cN0lc3Mk39Cdec4Zv5xh0R9zoOJqO5liNffwt8pSkrjqOjutReL6agioy4MIfxiRYosFjlNobvDkYMmGs/xcaVHMRCR29UaseZz+LyhBD08VT0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pL0+sK/RovTc+zxBCvYHCivCtW4ghCXnZL0l7uED/KM=;
 b=SUjcgkHBG1q4D82X1MQWdEH4RtmHiXYEE07qRbkYA8NHENZgg2K08ZCc0LHTFHcpNDUwUNgKvhfL+bi9bejUO2VuQIkYyYYSc7C5h7ncOVcarFaARe/TuoDRftAV7Pz/KzX+3ztI2vWaWYzrGOzvOglkbHN2lvUTYMe1VVzBcfucH2iZjQ6rXdEi7HN13m7nO/fs3AYYVKlROA/4SImnm4qFcfrvrivnNTzCpn9/Mk+WP/hqvB264vyCJs5vcU+oanZfGRc/Flpx0LNh52Vjg7zi5Zei3Wzl6SfLLqNaKhqweUANtS0gBKQOqng0VDuY3k0wTvpXzYMLSSKNfwkF4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pL0+sK/RovTc+zxBCvYHCivCtW4ghCXnZL0l7uED/KM=;
 b=0ilIWUxl1pM/Oc9Xl5bgHL+8YCZSgn2Fx//cfdxDvLqtjGMxzF5bJi+hPTQAMkFgUuAKPZRg8oEMYEAogpR0gVxNkEuhew8YIB/z/fbDk9WmEYjMeRBTrRXUalPIpoqNxZtAxSsuHuS9FSwH2vRCDk7F3ADKli71LuFX5t9x/Pc=
Received: from MW4PR03CA0164.namprd03.prod.outlook.com (2603:10b6:303:8d::19)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 19:40:49 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::91) by MW4PR03CA0164.outlook.office365.com
 (2603:10b6:303:8d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Fri, 18 Aug 2023 19:40:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 19:40:49 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 14:40:46 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, Iain Lane <iain@orangesquash.org.uk>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v14.c 3/4] PCI: ACPI: Use device constraints to opt devices into D3 support
Date:   Fri, 18 Aug 2023 14:40:26 -0500
Message-ID: <20230818194027.27559-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818194027.27559-1-mario.limonciello@amd.com>
References: <20230818194027.27559-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: c2cf8a10-add1-4ae2-5e20-08dba023063d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pkGBmr7InCpQqAZ5tevKmrtlR6BK/dSZ3WKOueuSUQvWJSdQR7M58VWYZ69rkbZF/AxazqSg4Ew95dEKeurY+o5JNx9UZTPSbgOoYZopSGYI+XUJQE9vVfaFnmS01nwjV/9s5k7kFZAvgCv5osX+S/vZeBhKrH/4yphWvhzfeSr9JDa675CYxVtLV6KGm6eJ//2qPShyylW+0yN6p7E6XhDA/fOxf/Zb/VLbSVhYZAwrsOCxI6I0p7AJYRY6HB++ONTishgak50gfWWnVcHD0VTa6uwz/gIv6/ntL0ynDVjgr/sjePZhzo3gD0LT31MIgJsqZ0bX4FFAViT4ETtBDlUZ0TsWymutq2I0BnFXLn3zU7KY0dEww2s5OfVNWTwaEjlgv3V9+k4mlfpZuuM2YAZUkRthEhrBSONT+rqGeUyToUH7d6W2Wb1aN9UwiabDlIqNXJausLR+PThyDnTbP5/Ai5Kn2qly2mbo6kZgBQ1ongvgpiuTu7D5mv15ZMLZd7HamyxfRWGuYQseSlzyHIY60B0hBBCbRXp+f28zpm4Q3R3EM4pUmQzh7lfyZwf1zfLGcD20ymezvGbwU7jMxgGyhwofEibtA3d5TPyjtZ3O2oLd8xZrXEp3icmQ22ZziXHPSTJwqnkBo2CWynHuRuiS9ge5oInj4AEE3BLZuMh2LHZlCIlvr5UKAzSisSDJ8xARd06x27vgWHF4AxBjMJ6cAeZeZw1VLstF0cT/kfHP69tKiG6oVCTQ1TdGBSGbGZAu+i/C8IwpUvWpmd1PFEXctty7U04OxGKBcyCiuRU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199024)(1800799009)(82310400011)(186009)(40470700004)(46966006)(36840700001)(40480700001)(83380400001)(40460700003)(966005)(70206006)(70586007)(316002)(54906003)(110136005)(478600001)(81166007)(356005)(5660300002)(82740400003)(2906002)(44832011)(41300700001)(4326008)(8936002)(8676002)(426003)(36860700001)(47076005)(2616005)(6666004)(1076003)(26005)(7696005)(336012)(16526019)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 19:40:49.0635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2cf8a10-add1-4ae2-5e20-08dba023063d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In Windows, systems that support Modern Standby specify hardware
pre-conditions for the SoC to be able to achieve the lowest power state
by using 'device constraints' in a SOC specific "Power Engine
Plugin" (PEP) [1] [2].

For each device, the constraint is the minimum (shallowest) power
state in which the device can be for the platform to be still able to
achieve significant energy conservation in a system-wide low-power
idle configuration.

Device constraints are specified in the return value for a _DSM of
a PNP0D80 device, and Linux enumerates the constraints during probing.

For PCI bridges (including PCIe ports), the constraints may be
regarded as an additional source of information regarding the power
state to put the device into when it is suspended.  In particular, if
the constraint for a given PCI bridge is D3hot, the platform regards
D3hot as a valid power state for the bridge and it is reasonable to
expect that there won't be any side effects caused by putting the
bridge into that power state.

Accordingly, take the low-power S0 idle (LPS0) constraints into
account when deciding whether or not to allow a given PCI bridge to be
put into D3.

Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [1]
Link: https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf [2]
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v13->v14:
 * Move code as another way to satisfy acpi_pci_bridge_d3() instead
 * Update commit with Rafael's suggestions
v12->v13:
 * Move back to PCI code
 * Trim commit message
v11->v12:
 * Adjust for dropped patch 8/9 from v11.
 * Update comment
v10->v11:
 * Fix kernel kernel build robot errors and various sparse warnings
   related to new handling of pci_power_t.
 * Use the new helpers introduced in previous patches
---
 drivers/pci/pci-acpi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 64e6ada024235..8331aea22d327 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1022,6 +1022,15 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 
 	adev = ACPI_COMPANION(&dev->dev);
 	if (adev) {
+		int acpi_state;
+
+		/* Check if the platform specifies an LPS0 constraint of D3. */
+		acpi_state = acpi_get_lps0_constraint(adev);
+		pci_dbg(dev, "LPS0 constraint: %d\n", acpi_state);
+		if (acpi_state != ACPI_STATE_UNKNOWN &&
+		    acpi_state >= ACPI_STATE_D3_HOT)
+			return true;
+
 		/*
 		 * If the bridge has _S0W, whether or not it can go into D3
 		 * depends on what is returned by that object.  In particular,
-- 
2.34.1

