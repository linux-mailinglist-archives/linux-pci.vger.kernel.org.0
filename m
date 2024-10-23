Return-Path: <linux-pci+bounces-15128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC139AD271
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 19:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C476A282399
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 17:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B251CDFA3;
	Wed, 23 Oct 2024 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RRO7P0Fh"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC26F2F2;
	Wed, 23 Oct 2024 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704129; cv=fail; b=Pu/yEnUJLFYdDfgbtFgYHomVxNk8jO3bseY03LG5xhlPVf6F7euPj4ycV+K4Zu0mTzYW3we7MpkYrHnt80isCDt4llA5fC5+KexEYm7dfcSxFBm/+eeVHY6E6jVy+toc1cG0eqJwlPEuUVB8H9XkHChXGwj5wYNS0G8j/73sKhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704129; c=relaxed/simple;
	bh=e8xn0zfFplC2dAITb/W4k0ZZndFD3XKqKrSES8D+E+E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SwCpBWtiCu0jwj+lk/6PAs54HzHKvAARjvNTXHDhUZOGpL04D/v3qAfUXOuverJ/ONRwwg5CSK9zkZ1TiatKm9QLrbYAdZVz3IFBEYXa5KjzIcbFXdShxmdrb1v7lEGtXUupHEpdQmSCW90s5c0lIly8lyYSJBb3uehLWtUivqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RRO7P0Fh; arc=fail smtp.client-ip=40.107.100.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATPNpikiXbAEtRWR/3Eab/qlqJD3RiWpewQdbWrGBTVqRf2g0Pi+t4v0AaYa9jwf8TixAxzeH2EPIwGSOMSDkc1PlffQJCWnNMycwIsjzuRzVHcBdNasDKXqU2JXcWrJ2DtVNd/8ZhS1EtDNmoo8Fl2DNkPDgPgCxRPZNsj2H+S8G41cLzg9b6O+WR1iw26CJ0PXREffsunzUOl3IzquhrXJnW8dDQ6VEUiYYA8HQNF6FmSlHW0k7Bh+Lhw/lWLBvTwWXBcJrfnV89fJaLRO3cv7L3J6dTLrBO9DYTMS0bk3tS8RpfBQi1SRu8kus024dtmkvWB38HvKEeEPRR5nSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJxMvRuW8zDKZVBNR9CCiUrwh1fcxdS67tT1ccgOqeo=;
 b=hHuvKcfCFcfzmVFfp+k4MzYBCN0SwJ8F3dnWILmwmx3pcqArkunI3v59irBnfzC8mplMdvwxSOzbWYOfRRz71pajk5mz8sc5pUu3ponRcp07E+BuBRRziwILL6Kdqc2zCNkcjbX08k2VM5IefRz+v7qklIRi9i85vjQleA+xIyQVV8Y/O7W0uwsuF9P87d67OFD5vqJZYchX2xKSMwsmvkwrTuNwRP/tboznM3c48PiPFoA+0zrKteqjBviMoWnvmHTHiRpOi0OjKv57RbhYVDhv875480p+mhK7RBpKydDgCjfhLPvGUEqpG9nNlOzjSWvWiANnlKWaCS/ZwsJmqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJxMvRuW8zDKZVBNR9CCiUrwh1fcxdS67tT1ccgOqeo=;
 b=RRO7P0FhEjNxm8jD1wOb3ZduDEjMlPrQRk3mtfhsloVWn+EYFXo0zr6gGsfuVz+sU5qQWToq3dIa+eEtP8Zyrt6qwWfvRxui5NF/A2UO617kn99pwXQUjaAaepn3aYnjcgCkh5VwWNF+0vgIdrhn/9XnN0wMBjpTPk9Z0UL3AeU=
Received: from IA1P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::10)
 by IA1PR12MB8261.namprd12.prod.outlook.com (2603:10b6:208:3f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 17:22:04 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:464:cafe::14) by IA1P220CA0016.outlook.office365.com
 (2603:10b6:208:464::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Wed, 23 Oct 2024 17:22:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 17:22:03 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:22:02 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, <mario.limonciello@amd.com>,
	<bhelgaas@google.com>, <Shyam-sundar.S-k@amd.com>, <richard.gong@amd.com>,
	<jdelvare@suse.com>, <linux@roeck-us.net>, <clemens@ladisch.de>,
	<hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>, <naveenkrishna.chatradhi@amd.com>,
	<carlos.bilbao.osdev@gmail.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 00/16] AMD NB and SMN rework 
Date: Wed, 23 Oct 2024 17:21:34 +0000
Message-ID: <20241023172150.659002-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|IA1PR12MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: a59ed889-bebd-4b80-923d-08dcf387367a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IYMo0zmag9CN9qvCQ8O47L9f3CmyLz3+b0/681FZSplH/dZhbYfkUUx6eTih?=
 =?us-ascii?Q?rRYAV4/gBI4bRPmGRDdzsBu1fEofQF7rZRgZSrkKboT7kbWQbHrapP3023OT?=
 =?us-ascii?Q?0uJQkKTIOT5pXuTwvzAjjk+KgC3QaQqhsvISu9A+iGOktWQe78U4A0z1YzK0?=
 =?us-ascii?Q?QWY7WE98pJeL+3k0yIj/7Ku1qvAOcPsNgWvFIU+aRUA8cJa/mKiDY2SuNPja?=
 =?us-ascii?Q?OqgpsuUVAO6oY5nFeWTjxqO2POk2S9cQltEzRBZLBdOBxHySuKS9QZG73yD/?=
 =?us-ascii?Q?1rHdgIpCHDm0ezbFIF7DWoh18MrNrsiHNJ/Y3cUWRVGDA/lM4QPligzcnstc?=
 =?us-ascii?Q?sTB9661uto6Mql0YHTYjbWfop3bEXECLDCnAtZN0sbZHjYZnM0ONGG68hVe0?=
 =?us-ascii?Q?YXg9i3OvvRGsyOZrZLmjGNm/awa9OaiD6AydQXFHQmHPW69UNo2fA4zUvee5?=
 =?us-ascii?Q?hyydYo07/soRQ8m2yzOyK1TUFjmpTBsl3ZduW2Dax2t28fy764fcVVxkDiLm?=
 =?us-ascii?Q?QSvrWg8BJ6p+GWjSh68KiEmFdTierlW3liZIvWTD/nWAvTti52fgkGdRTpuf?=
 =?us-ascii?Q?25zsP7bt9QSeaYm0TIxqJ7qTfd26P5tCEAVZaioYtbcqN2RbiMzBubIw1+Wn?=
 =?us-ascii?Q?tPHj+P79tHdA4+Y+HgJcmuwzr4/z4kKzU+DmOqrMlQjSZ4yOkRUKxyx6WCeU?=
 =?us-ascii?Q?M9f32GToxKl5tTpGc8a2xsXdWC85o0oRFnqQ5yg9S2dcMb8WIJEcLRvaCCA4?=
 =?us-ascii?Q?VYsnw4gvCXPPVAqWOB2f9leUPfuA1FLVvRL5ujTbVVmqv8DbSn7iwhWfglMT?=
 =?us-ascii?Q?L9vfbtcxYV6f6fdv8RCTrg9IF8HpOyaFbpHfMOD/T/AB+yWXWXoQfFurpCix?=
 =?us-ascii?Q?3qQF7bvj73WfNgzGIl0UQMA1XoQ+F1ErSJm3LnCW+WlHS85yMK+KwTPax1c/?=
 =?us-ascii?Q?j21kl3vchCP1SVukFto02ebUl6dTf/JfPVe1IuZCCNd+JavxssWtZVmr+glv?=
 =?us-ascii?Q?yiKyd9QFvCbvLdgcTOiSOxTB69uMtPGYjulHn3CYNwawTCzCmMGZ0NlJ65gw?=
 =?us-ascii?Q?ldF2pfydXw2erKy11v5cj9tQjQjYCdgIewNOpOZmkv464qo/Zgr0rE+8vBDP?=
 =?us-ascii?Q?fuyhahLF8Cm6gU7qyC9nbIZFqPCX5+ynygQQRhk3G0v1Vo755jqzDDs3aj99?=
 =?us-ascii?Q?C2XM1rNf4HyvHOTKVDg5AQPr6JrqilbpYm6jpVwbO/g/WEkXTATa72qKCHOA?=
 =?us-ascii?Q?HPmdHI57ogekCA+rIap2CRalpA7QAMyn4JRtnw1NvqMEnNokrCpXnrBBWL97?=
 =?us-ascii?Q?wTrcX7HU/MTEXeb64Pp2F7uuybuB5lV4KJ1l+cuJySZvWHDBwmNXBALyyHeJ?=
 =?us-ascii?Q?5dsGOmAf0ezoEVoSNqY0r/InXM1vvp/1qQ/BJ/ad1o6UWkSbdg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:22:03.8967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a59ed889-bebd-4b80-923d-08dcf387367a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8261

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

Mario Limonciello (4):
  x86/amd_nb, x86/amd_node: Simplify amd_pci_dev_to_node_id()
  x86/amd_nb: Move SMN access code to a new amd_smn driver
  x86/amd_smn: Add SMN offsets to exclusive region access
  x86/amd_smn: Add support for debugfs access to SMN registers

Yazen Ghannam (12):
  x86/mce/amd: Remove shared threshold bank plumbing
  x86/amd_nb: Restrict init function to AMD-based systems
  x86/amd_nb: Clean up early_is_amd_nb()
  x86: Start moving AMD Node functionality out of AMD_NB
  x86/amd_nb: Simplify function 4 search
  x86/amd_nb: Simplify root device search
  x86/amd_nb: Use topology info to get AMD node count
  x86/amd_nb: Simplify function 3 search
  x86/amd_smn: Fixup __amd_smn_rw()
  x86/amd_smn: Remove dependency on AMD_NB
  x86/amd_smn: Use defines for register offsets
  x86/amd_smn, platform/x86/amd/hsmp: Have HSMP use SMN

 MAINTAINERS                          |  15 ++
 arch/x86/Kconfig                     |   9 +-
 arch/x86/include/asm/amd_nb.h        |  53 +----
 arch/x86/include/asm/amd_node.h      |  39 ++++
 arch/x86/include/asm/amd_smn.h       |  14 ++
 arch/x86/kernel/Makefile             |   2 +
 arch/x86/kernel/amd_nb.c             | 294 ++-------------------------
 arch/x86/kernel/amd_node.c           |  91 +++++++++
 arch/x86/kernel/amd_smn.c            | 269 ++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/amd.c        | 127 +++---------
 arch/x86/pci/fixup.c                 |   4 +-
 drivers/edac/Kconfig                 |   1 +
 drivers/edac/amd64_edac.c            |   1 +
 drivers/hwmon/Kconfig                |   2 +-
 drivers/hwmon/k10temp.c              |   2 +-
 drivers/platform/x86/amd/Kconfig     |   2 +-
 drivers/platform/x86/amd/hsmp.c      |  32 +--
 drivers/platform/x86/amd/pmc/Kconfig |   2 +-
 drivers/platform/x86/amd/pmc/pmc.c   |   2 +-
 drivers/platform/x86/amd/pmf/Kconfig |   2 +-
 drivers/platform/x86/amd/pmf/core.c  |   2 +-
 drivers/ras/amd/atl/Kconfig          |   1 +
 drivers/ras/amd/atl/internal.h       |   1 +
 23 files changed, 495 insertions(+), 472 deletions(-)
 create mode 100644 arch/x86/include/asm/amd_node.h
 create mode 100644 arch/x86/include/asm/amd_smn.h
 create mode 100644 arch/x86/kernel/amd_node.c
 create mode 100644 arch/x86/kernel/amd_smn.c


base-commit: 94559bac4d403b1575b32a863f5c0429cdd33eaa
-- 
2.43.0


