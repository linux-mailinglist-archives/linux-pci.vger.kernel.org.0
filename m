Return-Path: <linux-pci+bounces-1079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07348815363
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 23:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DFF1F25500
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 22:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C9B13B133;
	Fri, 15 Dec 2023 22:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IgggiDUE"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9E118EA1;
	Fri, 15 Dec 2023 22:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFb0o2RWX5sq/uQmq9tI0K9ZfUU/hz5rhwowED3BO1x3iv52Vxz37YwYXVGvB+Gcfz7ThwFXI9YHBAaQWFS6gxW6kY1ydvjK34flgMx+RIiPtLtDV2+aNmIt737EDMAtU/UyENsMB9K8wCcKpF+g2wFq+4zNwnsNRdyIYqC1D3j5gEZNdEIY8LW0ILmIGt4Ygu26FjNPfYqVlorQTSoAAAesd3v6h8ip3/0HLGN4JZ5KXgA4/Z0pN92CnAGdJw3NK09Suv9UuQuhs3zT9BHNvyya0zWfq59KX2bqtjuf3jjjItUn+wuumBdXNORR+2XpoQKRHtnuYHwYs0KUNcuztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8yQiURzbi+JuTiylQT8sVzM/UD+jOTKzIg7VMaTVto=;
 b=U6WXLtrqP1snoH9vcjC89kO9usB1JQqZcamoltf/m7fixDTL3Ix/QJzSEt1UCZNa34NfR1BaRZO/Zj8xU4eqvq7ua8egwuItXIokFB9CtIf7DhhGayYUl7+r2Vi/fkWtIcTVWEDWGmu4h9kSx/hZcMgYBQ5+h2VghUMuv+AHcMajmgD7VEHK/lAry5wJZLSsMCUSu3aqgRepXWZ68VV5rA3bzHinE6IiF+jSzBT5LsQB2TcCRtWymyfofo7UmP6B2Stt5uusnioCwc8z5xEn0qKJjoIYxi2KJmLRg9xYhFLBaT8EWAzQp/3WwaqIuH0mj9Ffj9urQmYkp75q/3SLpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8yQiURzbi+JuTiylQT8sVzM/UD+jOTKzIg7VMaTVto=;
 b=IgggiDUEVdvRBzbJv6jY1ukH56/8FjrchIpNiLxD2goHEXnSEvB5mXswTtvrcCoCCdrd2LzZNyx9ullQcOvdz5yJGm9vUfIPBYs7cT5Wih6Ba9Llfcq6Ug5QP9Zy/s+XKjz3wANOY+z1evD+qU+8nJVv4XQX3p4ZNaPMlNtdpaQ=
Received: from MW4PR03CA0279.namprd03.prod.outlook.com (2603:10b6:303:b5::14)
 by MW4PR12MB7215.namprd12.prod.outlook.com (2603:10b6:303:228::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.33; Fri, 15 Dec
 2023 22:18:06 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::43) by MW4PR03CA0279.outlook.office365.com
 (2603:10b6:303:b5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32 via Frontend
 Transport; Fri, 15 Dec 2023 22:18:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 22:18:05 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 16:17:52 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki"
	<rjw@rjwysocki.net>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2] x86/pci: Stop requiring ECAM to be declared in E820, ACPI or EFI
Date: Fri, 15 Dec 2023 16:03:43 -0600
Message-ID: <20231215220343.22523-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|MW4PR12MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca13cbe-4fcf-4a24-48ad-08dbfdbbb631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2ZW2w8jTSle3yfckqkqBiSR/8N6dexdLn0niCSZBH8QcmH6oywZdlQKfc8isb+kUkrGm0BPu9MQWgOpF94CyU+UYMrptg+7MX3bV76bX+/vryFYX9w3c/GYpoKTnv002GFUoobfrWZUS9aPQwjpia1gcGMhObocJMjY5jfB8WnqCxmDoB3sgsq2i44EwoE+EMQzWzyl51kEbo3cBPTPGTg8qGPSD2f5IXUbRWPZ5g3VVYQYRY3rwcrkLQOcoit5Yzj8EirykexMmGxd31nTtk55gsTpEg2HnGk/89eXJrCZKcZrEJ9X7QTR0aSkRyoi+1302NLtjA09Gcggis21ixGEX0fUleZMXE5WSXZDLb17jh4NBN+twfscQxhgFPnNdYnFOHdamF0/8Yi+TMTAoOGQ6g9nUGKgCNbA+tLEsbnUDAz0Vlz+dD1dRNgl8i6n/q+J2nCtHRZatDJliXl8C+tTKnkaMtXLgPXfLdJfVOC7GskhsikDFO1kyQRFBrpLGt+I6KfThpF11ZFd4Zcp05abw6ujlnUCo3FqZAKoh6ru4QJtfDsofR/f44MRy3QH7aThJT7S/1Of2QIHOAnPOvgOVNYgK+xkyxwwHV/ceToOs85wWN9vJhNlUXm6m4BN9j3vgY4tw7Phvlupls250H/nXKuqYoZGYO34gAsYLbzpLC9z4kSzqnp1a/AjLyzcaIfUHgnsxaTMxhp1GS3WqlZGLZYVUkphoMiEjFyB6MO+Aq2HXGT+OBfQovMN5NFSceYOv/irgMfWDJU0dV7NvOA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(186009)(451199024)(82310400011)(1800799012)(64100799003)(40470700004)(36840700001)(46966006)(83380400001)(966005)(478600001)(82740400003)(6666004)(7696005)(1076003)(40480700001)(2616005)(426003)(336012)(16526019)(26005)(110136005)(54906003)(316002)(70206006)(70586007)(356005)(81166007)(36860700001)(47076005)(86362001)(8676002)(4326008)(44832011)(40460700003)(8936002)(5660300002)(2906002)(36756003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 22:18:05.8889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca13cbe-4fcf-4a24-48ad-08dbfdbbb631
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7215

commit 7752d5cfe3d1 ("x86: validate against acpi motherboard resources")
introduced checks for ensuring that MCFG table also has memory region
reservations to ensure no conflicts were introduced from a buggy BIOS.

This has proceeded over time to add other types of reservation checks
for ACPI PNP resources and EFI MMIO memory type.  The PCI firmware spec
does say that these checks are only required when the operating system
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
11 with exact same laptop/firmware stack.

Due to the stability of the Windows ecosystem that x86 machines participate
it is unlikely that using the region specified in the MCFG table as
a reservation will cause a problem. The possible worst circumstance could
be that a buggy BIOS causes a larger hole in the memory map that is
unusable for devices than intended.

Change the default behavior to keep the region specified in MCFG even if
it's not specified in another source. This is expected to improve
machines that otherwise couldn't access PCI extended configuration space.

In case this change causes problems, add a kernel command line parameter
that can restore the previous behavior.

Link: https://members.pcisig.com/wg/PCI-SIG/document/15350
      PCI Firmware Specification 3.3
      Section 4.1.2 MCFG Table Description Note 2
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Rebase on pci/next
 * Add an escape hatch
 * Reword commit message
---
 .../admin-guide/kernel-parameters.txt         |  6 ++++++
 arch/x86/pci/mmconfig-shared.c                | 19 +++++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65731b060e3f..eacd0c0521c2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1473,6 +1473,12 @@
 			(in particular on some ATI chipsets).
 			The kernel tries to set a reasonable default.
 
+	enforce_ecam_resv [X86]
+			Enforce requiring an ECAM reservation specified in
+			BIOS for PCI devices.
+			This parameter is only valid if CONFIG_PCI_MMCONFIG
+			is enabled.
+
 	enforcing=	[SELINUX] Set initial enforcing status.
 			Format: {"0" | "1"}
 			See security/selinux/Kconfig help text.
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 0cc9520666ef..aee117c6bbf9 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -34,6 +34,15 @@ static DEFINE_MUTEX(pci_mmcfg_lock);
 
 LIST_HEAD(pci_mmcfg_list);
 
+static bool enforce_ecam_resv __read_mostly;
+static int __init parse_ecam_options(char *str)
+{
+	enforce_ecam_resv = true;
+
+	return 1;
+}
+__setup("enforce_ecam_resv", parse_ecam_options);
+
 static void __init pci_mmconfig_remove(struct pci_mmcfg_region *cfg)
 {
 	if (cfg->res.parent)
@@ -569,10 +578,12 @@ static void __init pci_mmcfg_reject_broken(int early)
 
 	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
 		if (!pci_mmcfg_reserved(NULL, cfg, early)) {
-			pr_info("not using ECAM (%pR not reserved)\n",
-				&cfg->res);
-			free_all_mmcfg();
-			return;
+			pr_info("ECAM %pR not reserved, %s\n", &cfg->res,
+				enforce_ecam_resv ? "ignoring" : "using anyway");
+			if (enforce_ecam_resv) {
+				free_all_mmcfg();
+				return;
+			}
 		}
 	}
 }

base-commit: 67e04d921cb6902e8c2abdbf748279d43f25213e
-- 
2.34.1


