Return-Path: <linux-pci+bounces-509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CCC805911
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 16:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF92C281E15
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 15:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EF05C900;
	Tue,  5 Dec 2023 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dM5DBmVH"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0A0BA;
	Tue,  5 Dec 2023 07:49:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJF5XWnKPS9qusgEry5dttgFRiOC4Nb52wf1GtLz/t9ompvZ5x//rnDzMatYX0KHpEalqQgzxLU/EC+cxadTB/yfed4j0VY7n/E3bbkFskQV8kKBh6vi6y2bCdKqoFcXZNBvIeSy2MCORSQdpq/DBcIvJzmlMzKQ4vD/g9dTG3zqTGUZLJUVcxrDT0nulfGFDKo6Ez5NmCszeWpGZyf6y2azBUa/3UICbT0+mlWEyUyWbxEBVQbvpCcqcFpcbuuM8HnU0x6LFMqNn5oASf51g6hi5yfNS59asqQazWmm6s+wt2h0D3QNIz+lexF69+u/7jmRHpV5BEH4KE7pkqvy9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLuQYjjCa83wy5FxCm9aqnG3UyNRRCE2OjcDryFxIyQ=;
 b=iaRLIqzBjm13w/T+svuj1rzt9Dx5oSBdlMU+31qWZ2DS1j9UQIqm0uAI5r2gX39C3Ej/z2uHTJIFCZVKUfEyJrf74kYzLpGTIc1Pci7iauEeUThkezcq30LEjLNiewA4OZ21Sy+sCtWr8YIEk46IuHe07mUfulDnjAINvA/TaTUTxw3dAzsfUbJ3WR20xadukdX5Af1WK5RjGDQbaaHvhLa8mxLBgf+plPV3LGgfKSxdpNAp7jAP5lHrE/x/S5BpiuhphmlyYVEI53CHUcvydiyZ+ia9UpZMSH4bm+cW2u5FrwnDlaeAeYiKW8Eb3Fpmju9vgJveieUy2j5tfWE7/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLuQYjjCa83wy5FxCm9aqnG3UyNRRCE2OjcDryFxIyQ=;
 b=dM5DBmVHsFSazC45RlTJg4xhzv6VqLpz/Vtf3IDnwbZ4nXakkZMDVdndegbS83sXFR8LCCR0vAxjH5aoOMl0K0EcgjGv9bDb4xre8BeIxXLDK0Ucid7Z569qbudP5i+WV5gATj2uMSkL4qU8s/zOkrHHvq2J9wSWmZvf9gHjtJg=
Received: from BL1PR13CA0318.namprd13.prod.outlook.com (2603:10b6:208:2c1::23)
 by MW4PR12MB7359.namprd12.prod.outlook.com (2603:10b6:303:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 5 Dec
 2023 15:48:57 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::31) by BL1PR13CA0318.outlook.office365.com
 (2603:10b6:208:2c1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24 via Frontend
 Transport; Tue, 5 Dec 2023 15:48:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.24 via Frontend Transport; Tue, 5 Dec 2023 15:48:57 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 09:48:56 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki"
	<rjw@rjwysocki.net>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] x86/pci: Stop requiring MMCONFIG to be declared in E820, ACPI or EFI for newer systems
Date: Tue, 5 Dec 2023 09:48:45 -0600
Message-ID: <20231205154845.44463-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|MW4PR12MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: 6786bc5a-dc38-4388-2e1c-08dbf5a9b141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T6VRhPSJE0AI/K6ZEXouq7+aebw9KJiwxsYNBM+zHxW6Ypnw0Kf5FnJ5ZCNN+S37TG7+kt1w1MjNX3GVC0n0bNPPXgwGy38eu0wepyjCPxvpWmhl7DJnM+ixtKj4J7lo3XbJ805XSd6c1sdFfJEIyZMFTWk8iCDx/7ymXlR3nFwqSrAT4ZIp+2pzYr4WJYi9kPuziUPMI678nQ4C4OXyaAujZDLJTnhqvILrEkUGeIzDLDGDejSad5BjwfvrlsM38xJMzAg1/6lTqUL4e74+nWfR+hIh4T9u6DBxsRyrTRzp48fS++556scNBXUnEkrwQN6XSfMIaivAkJ9vXWhk6yG2BnjVT7DuKzxlDDId249LwOjlW/rRKBdLwbSfdngdaMcomAoODpNfhvDL3s8VhmP7JTGZfmhQ0hYrrgiYSeeSeC8SbqzXdKgwm1+ZO9O/wnSK3unzmD0xa6kuNtHHfY4llBi/g4HWAK+OfogksHcL5Qs5LkrLnPnVSNVG6x7ImA48EZg50i61qtrKdEINBDg513RPNf0ARVfvz6pZflQ72D9QWi+TnzAE7qN2LpgaFrWwyWPWuxBUSG2oNFmjiXV7uWfwXbUTjZtesfRTqgDa8NBWJUMok4HPQ3E46MXIWHH71NNDXLFAEsEY+e1OW7ol1qcKh8znSsEWAhOFoZykpYYghomr8arhqM5CO8YMKgAdrZWSizV51VfXx58Mo4HmsRmDPxfNm8JRt/PCKGkeCElvl6MT1ovzF7K5XqYgJfNNpExj7HYg+T1KYtlB9GsbK+riWPRfn4r98obocKq12u28EZMwk4eBHswEpqMk
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(8676002)(6666004)(8936002)(4326008)(7696005)(110136005)(316002)(54906003)(40460700003)(966005)(40480700001)(478600001)(81166007)(356005)(47076005)(2616005)(41300700001)(36756003)(1076003)(86362001)(2906002)(44832011)(36860700001)(70586007)(336012)(26005)(82740400003)(83380400001)(426003)(16526019)(70206006)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 15:48:57.4861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6786bc5a-dc38-4388-2e1c-08dbf5a9b141
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7359

commit 7752d5cfe3d1 ("x86: validate against acpi motherboard resources")
introduced checks for ensuring that MCFG table also has memory region
reservations to ensure no conflicts were introduced from a buggy BIOS.

This has proceeded over time to add other types of reservation checks
for ACPI PNP resources and EFI MMIO memory type.  The PCI firmware spec
however says that these checks are only required when the operating system
doesn't comprehend the firmware region:

```
If the operating system does not natively comprehend reserving the MMCFG
region, the MMCFG region must be reserved by firmware. The address range
reported in the MCFG table or by _CBA method (see Section 4.1.3) must be
reserved by declaring a motherboard resource. For most systems, the
motherboard resource would appear at the root of the ACPI namespace
(under \_SB) in a node with a _HID of EISAID (PNP0C02), and the resources
in this case should not be claimed in the root PCI bus’s _CRS. The
resources can optionally be returned in Int15 E820h or EFIGetMemoryMap
as reserved memory but must always be reported through ACPI as a
motherboard resource.
```

Running this check causes problems with accessing extended PCI
configuration space on OEM laptops that don't specify the region in PNP
resources or in the EFI memory map. That later manifests as problems with
dGPU and accessing resizable BAR. Similar problems don't exist in Windows
11 with exact same laptop/firmware stack, and in discussion with AMD's BIOS
team Windows doesn't have similar checks.

As this series of checks was first introduced as a mitigation for buggy
BIOS before EFI was introduced add a BIOS date range to only enforce the
checks on hardware that predates the release of Windows 11.

Link: https://members.pcisig.com/wg/PCI-SIG/document/15350
      PCI Firmware Specification 3.3
      Section 4.1.2 MCFG Table Description Note 2
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/pci/mmconfig-shared.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 4b3efaa82ab7..e4594b181ebf 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -570,9 +570,13 @@ static void __init pci_mmcfg_reject_broken(int early)
 
 	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
 		if (pci_mmcfg_check_reserved(NULL, cfg, early) == 0) {
-			pr_info(PREFIX "not using MMCONFIG\n");
-			free_all_mmcfg();
-			return;
+			if (dmi_get_bios_year() >= 2021) {
+				pr_info(PREFIX "MMCONFIG wasn't reserved by ACPI or EFI\n");
+			} else {
+				pr_info(PREFIX "not using MMCONFIG\n");
+				free_all_mmcfg();
+				return;
+			}
 		}
 	}
 }
-- 
2.34.1


