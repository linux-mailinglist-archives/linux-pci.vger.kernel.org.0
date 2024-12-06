Return-Path: <linux-pci+bounces-17849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 031BF9E754A
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 17:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E2928B51C
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 16:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0D720E037;
	Fri,  6 Dec 2024 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S+rSEed0"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1378D20D501;
	Fri,  6 Dec 2024 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501554; cv=fail; b=OOVeXWL9HPHglQSNuve1D+FbxluuBNCqwP2nDymAjectMfnQKHWX6MROrH4kQA+JtRME2zyJJmpFh5JuorFLchyxroLcR3E67fjv6LM7m9KeO3Cl05kuZ6sO7LKn0xLBGid14U5KHi6KBp24uFDc61MyDucwq3LPdjY1ba90Yis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501554; c=relaxed/simple;
	bh=aS+2eXSXkqWuLRB6XIi/n4PS5LbuV0wjN/iVbiKXkLs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kIVavTAx4ZGrMS2oOGkjrDU85hGvPRbqByXTWAAEbQL7H7xqBPPJWbTllluxP9PhtTL7tRUAV5my83OFcX7+0/YAlkzR+4QLRoEW/DorvjK9nYQI8lhZSBqnmyeHva+hOowGxTknSOsNO7XEMe8djWjQ4adon6LZq5TULLX084g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S+rSEed0; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUrczr87xoqhCY9GlVZv7/hw+rtfWGnWUb8YItBfg4qjDqL3rUF+JQGG1Ls022f6VifHEoiv2cKBU3XQdfh4wJDmYNlZAF2y28aOyiIwi52ZKFdjDM2L2Y6KxIsBAiL0g8XkfImDFNP/eKYddH00IVQSB5xZZd0RMMVuzLQJvPFq5XaCqVYSTi/QZIx6FJok2XHKsRaTpf2dKkCwFSCchKotj+GFVkEgL4d6CI6ZC57ffQCu6rq2GPwWne1N/VMD86YchvjSOJql0hf2/PVTJZF3cmU9uECGKjKbMzZUa1bVUXG1L5SbfKTBTb6CYB+NzZdjo7uwR+5GDxXO3QrlEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzRSEWC36HwtjfHrD5e24rQ8Xe3IuD03xMcg7jMavoc=;
 b=RIFUrXcLlgcEI/2g3HjYmvSafStHsbwkarEOgDERFxRsWPf3F86zYsGcpcI5ERsLJKah/2NVwlJ14U5tvYtXEDe/kwPU3NetwXntYdc8Enry/0gbNAoHNnDtjaVS+TByVOC9kibMgU0M+QgyW5ESVMY1lHyDnN3UA6TCCjRbrI1TqnC0TtrJNEx/bGMwYGRUjyXh5fFh4eTzUB2vQnOaHxqeiFUaGcXosISgZAagRGw62FaHSzo5WBshFspn32nvd7gisN+VOEvtRBN0c4VfzlN8RCMosJy1aS2a+Yucj1fVBCl0MBi1PGxAJP+hJ30kjLeRSCkNvWyy+z6VLBuGJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzRSEWC36HwtjfHrD5e24rQ8Xe3IuD03xMcg7jMavoc=;
 b=S+rSEed0hIBSQE7RoMeeF49Mj7a5tI5RQ0ryN+xOtaAdGUOaFO7LBKAfsCcKiAAZejqTtFZUa24bQETK6pgozBb7kz5OmwUkfB1smDO1nEQvyRGFby1sb8ONYUtTfwUXpcDDJWkpIbFQqPk1lC+QTXEJYYqC/Y06NBMkATZlNxk=
Received: from DS0PR17CA0007.namprd17.prod.outlook.com (2603:10b6:8:191::14)
 by DS0PR12MB8564.namprd12.prod.outlook.com (2603:10b6:8:167::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 16:12:25 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::11) by DS0PR17CA0007.outlook.office365.com
 (2603:10b6:8:191::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.11 via Frontend Transport; Fri,
 6 Dec 2024 16:12:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 16:12:25 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 10:12:24 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <yazen.ghannam@amd.com>, <x86@kernel.org>, Tony Luck
	<tony.luck@intel.com>, Mario Limonciello <mario.limonciello@amd.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Jean Delvare <jdelvare@suse.com>, "Guenter
 Roeck" <linux@roeck-us.net>, Clemens Ladisch <clemens@ladisch.de>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Naveen
 Krishna Chatradhi" <naveenkrishna.chatradhi@amd.com>, Suma Hegde
	<suma.hegde@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>
Subject: [PATCH v2 00/16] AMD NB and SMN rework 
Date: Fri, 6 Dec 2024 16:11:53 +0000
Message-ID: <20241206161210.163701-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|DS0PR12MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 4099dfbb-4862-4eba-c2c0-08dd1610c615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3dTRQ616QhrmLlFQZZB6Prz5DkGr4Z1JVak+VY6A4XwO6BIX1ElPAYtFr5lS?=
 =?us-ascii?Q?1AZk5GQmk8Ge44xlVD4zL8S8UQxrwV0ovtcMBfevt8VQBoDu6aRBCMO4nN9S?=
 =?us-ascii?Q?CHT0BuHr2+l26mWcDCa4OtxB9cg9+noXxIqXwYM8dcX923m/W9ChaRCmyYsw?=
 =?us-ascii?Q?lFtf9dwA30u3Fji7xveFjHBRQBR2rMoTZxEoeQkHCR19chyubNosgyWfYHsT?=
 =?us-ascii?Q?7uXC+RYilXtBYJoieTg1CdfPojg01GJKrYGPc4k94zXOFoOQOIKt5zIwk9WO?=
 =?us-ascii?Q?vex3wMmoNM1YgmMvZRsDH/w0huiUHO+v05kRJFnVJe5i95umq8UkRbGigOTH?=
 =?us-ascii?Q?VklAZ3HcH6f1d59Lz9sSkQVh/tMYHW6uCeU+Ax9EMbuFQ60l9jVoPZofaQPx?=
 =?us-ascii?Q?ixggaEOjtCXIEx2Yi7tdnggi9qSQosmbb8BXyhoTf83oY2wHxK2533syuClp?=
 =?us-ascii?Q?QFgLHufeeBpsdaQqEV9y/y/2QEjPK/QanBRXzXXUQNZ4/1BChwRkXrqReNnF?=
 =?us-ascii?Q?130HwUofHbY0D7gyKTNC0rsnPhrJZt8yiW+fSWk9oy3FDRVj1acLxfGT0Tof?=
 =?us-ascii?Q?NkSOgzSlkROiUXsW9sT5xkkDZZmUpc/EK63JALAstUCc/If5nhwvVvzRzMS8?=
 =?us-ascii?Q?fCxBQpemAvqrKQj1iDiAWDZRuqd4tN6Sim/AqyWChHgX2vJIm9lRC9sRTUbE?=
 =?us-ascii?Q?6PFbHlJZMVgie30YprQcDInTgPJQ7OPeRBM2yXLGlz1lVbkFSEkoKv669cbB?=
 =?us-ascii?Q?fDS+LdjMu2u2mQC3D2J1ylLvgxmwumBZIrNG6LyzOaTED/lYCd4OGY+Krx4e?=
 =?us-ascii?Q?Pt+3JexJvZJgDdhtlqKiYSLi3nEcEx19HCYfEC59OTJFymkz0/+BVZ+q+Kuu?=
 =?us-ascii?Q?7dQPtgI+rj0XXcfv+miElouw+hmqfEPLqNp3ak8j9o1QVQ2H4Vf7aMS6OGFv?=
 =?us-ascii?Q?uMFk5u2pXdFcn//ORFpaQ+KzgWjgzRdZdcYllAbr2+Ra3ldzNEbYlNUB2Hwb?=
 =?us-ascii?Q?h2eMVcSllD5T/Jf2tAfMn6O8l0ebz+0IKi03uXeYLeTNN8AUZldQQ1g4T0NX?=
 =?us-ascii?Q?pSWssK8trKSmktQsLQXi4rv6Y+MOVFQmRq9IVpF5R1QBQ5usqgLtGcAmHtV+?=
 =?us-ascii?Q?O5jxlQe2zfyzoOYRD0aYV8gPgczgpx3SWdfHbF43FcaVkgeKYEsUKX0d6efM?=
 =?us-ascii?Q?PAKhuCfMDE37hUwBYKZVaIUDZvIzwOibTJoPe8KJAjvwyvPS9yG4yP4nbAL6?=
 =?us-ascii?Q?Crftt79znrq+T2nYrenGaj+a8ByPQTyE+fQSSYBkKULR8nYA8Ada4u5ZS2k0?=
 =?us-ascii?Q?ELAHqFdRCDMD8ZhkYh9qxC155F8bukSaF33OKOWtQ07LV94ULsUlvwoWtU4R?=
 =?us-ascii?Q?6BwlZM81Nm0r5ZWEdFBSXXNPzSHMpYzdyZ9Ng24Vauqo/hNIHHx1N8IGLlmM?=
 =?us-ascii?Q?9xHfrbydsEuOKzeC6eIVziLp/cmetWAxvfAYsBq2+yRS2X8Hu+QEHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:12:25.3987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4099dfbb-4862-4eba-c2c0-08dd1610c615
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8564

Hi all,

The theme of this set is decoupling the "AMD node" concept from the
legacy northbridge support.

Additionally, AMD System Management Network (SMN) access code is
decoupled and expanded too.

Patches 1-3 begin reducing the scope of AMD_NB.

Patches 4-9 begin moving generic AMD node support out of AMD_NB.

Patches 10-13 move SMN support out of AMD_NB and do some refactoring.

Patch 14 has HSMP reuse SMN functionality.

Patches 15-16 address userspace access to SMN.

I say "begin" above because there is more to do here. Ultimately, AMD_NB
should only be needed for code used on legacy systems with northbridges.
Also, any and all SMN users in the kernel need to be updated to use the
central SMN code. Local solutions should be avoided.

Thanks,
Yazen

Link:
https://lore.kernel.org/r/20241023172150.659002-1-yazen.ghannam@amd.com

Major changes
v1->v2:
* Rebase HSMP changes on latest upstream rework.
* Keep Node and SMN code together.


Mario Limonciello (4):
  x86/amd_nb, hwmon: (k10temp): Simplify amd_pci_dev_to_node_id()
  x86/amd_nb: Move SMN access code to a new amd_node driver
  x86/amd_node: Add SMN offsets to exclusive region access
  x86/amd_node: Add support for debugfs access to SMN registers

Yazen Ghannam (12):
  x86/mce/amd: Remove shared threshold bank plumbing
  x86/amd_nb: Restrict init function to AMD-based systems
  x86/amd_nb: Clean up early_is_amd_nb()
  x86: Start moving AMD Node functionality out of AMD_NB
  x86/amd_nb: Simplify function 4 search
  x86/amd_nb: Simplify root device search
  x86/amd_nb: Use topology info to get AMD node count
  x86/amd_nb: Simplify function 3 search
  x86/amd_node: Update __amd_smn_rw() error paths
  x86/amd_node: Remove dependency on AMD_NB
  x86/amd_node: Use defines for SMN register offsets
  x86/amd_node, platform/x86/amd/hsmp: Have HSMP use SMN through
    AMD_NODE

 MAINTAINERS                           |   8 +
 arch/x86/Kconfig                      |   6 +-
 arch/x86/include/asm/amd_nb.h         |  53 +---
 arch/x86/include/asm/amd_node.h       |  39 +++
 arch/x86/kernel/Makefile              |   1 +
 arch/x86/kernel/amd_nb.c              | 294 +--------------------
 arch/x86/kernel/amd_node.c            | 364 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/amd.c         | 127 ++-------
 arch/x86/pci/fixup.c                  |   4 +-
 drivers/edac/Kconfig                  |   1 +
 drivers/edac/amd64_edac.c             |   1 +
 drivers/hwmon/Kconfig                 |   2 +-
 drivers/hwmon/k10temp.c               |   7 +-
 drivers/platform/x86/amd/hsmp/Kconfig |   2 +-
 drivers/platform/x86/amd/hsmp/acpi.c  |   7 +-
 drivers/platform/x86/amd/hsmp/hsmp.c  |   1 -
 drivers/platform/x86/amd/hsmp/hsmp.h  |   3 -
 drivers/platform/x86/amd/hsmp/plat.c  |  30 +--
 drivers/platform/x86/amd/pmc/Kconfig  |   2 +-
 drivers/platform/x86/amd/pmc/pmc.c    |   3 +-
 drivers/platform/x86/amd/pmf/Kconfig  |   2 +-
 drivers/platform/x86/amd/pmf/core.c   |   2 +-
 drivers/ras/amd/atl/Kconfig           |   1 +
 drivers/ras/amd/atl/internal.h        |   1 +
 24 files changed, 485 insertions(+), 476 deletions(-)
 create mode 100644 arch/x86/include/asm/amd_node.h
 create mode 100644 arch/x86/kernel/amd_node.c


base-commit: ae61116b291c9358e8de38bd3505e83b85be2d0d
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.43.0


