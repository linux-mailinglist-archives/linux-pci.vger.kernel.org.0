Return-Path: <linux-pci+bounces-33204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A871B16876
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 23:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F2B5469C0
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 21:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A17A22068F;
	Wed, 30 Jul 2025 21:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LInNrWuX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED24C2C9;
	Wed, 30 Jul 2025 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912066; cv=fail; b=Uujf1Pw0eT9YdELxjN3DAP1cCgmAmS6g2KoC2ZoqBO6983ntO+X69hRDFD84QFEiQ/GXur/9QyqOrF2npOJjxZzBtRLelnmA2CzAMaQdU1Qg/MAymVg6dE8PLExW+r/WogQHktEA9piTF0pPWh9qZ9zVrqR5PKY9CrYRbc69ISg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912066; c=relaxed/simple;
	bh=1AyhPAdnL43TbCGuEEJlEgWFnW3st91hwaNc4L5bpEY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g1jY5hBsz1RK8NW01ahmusKFFPU4oBeei9JMDRur6dV3HRd/igC6/V4Iu3b92voBDmAbmMCribch8jQsr3oLQFSFzUXsZwCwyp9MK3nPGOhh5OlEL7FGcAH72XCpjd1HQN0H7C5vAIoqaDkHhprYE0CQLkCyEPjzEZS5ekoelTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LInNrWuX; arc=fail smtp.client-ip=40.107.95.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udMb5o3i6FIdmtrX3Bqy/SJ0g+zICVDSjKubk7C1viBtJc6icTsPymPJcOjo0wXyjwTaSZBOKf3jB3e9/T3bjLcXxbWKAw+CCyaSEsGeE/Rxcan+wdpq2oYAI9vdTpB0DK9pDMrN6FN1lWKVmIg/VriYhqlzkH7o9983m83zCK9TdmWBkRQH2E8IDfE8kSVoVKsOaz8VlrIqhzdK8bWA6xCYZtpq4CdmrgTy5t7AUD55syPCFrtyuJ6bsAfIBKBT3DoOuPDSXMZFJk6Nxl5NzNzQNqKe5F7jtiCG/WJLJOufPWQADZbu9WuVpDDytnEnTPdz9r7XjNUCLyv4jV1bjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqfBNxMiwn4s1ZNNck7fmnIrXK3Gk8ifT5ljXg4VJ2U=;
 b=TkfJ7PEaGcLmt2IMZiXA9WgIob87yGZzZvxznmlZz261l9oD10nScrZ8GHr8/ZIFvNb55jt5radmHAE7GUO8NGk8q6OzOlxy/uvo8L7tgF4fgw2NRvXOLgAjR35roGC/osOoGok9LesKOdvNAGDVO6aJ5rcpNRGCkim2qOCrLZzqL0m8opgQdV9N3o/b0G2fe+ZnQ9hH2zW47Jm876r0M/2rYF5c5+eIpHwTv1fHPmAmMFkpxK8JqcWsMWsNf6wV772vdnhP9DhIPcM8oKOEpzIlsO+bQehG1CzxX3mHz6SL77GI2he9tMwwcPkE/UiRQNTxe/zvGxPk4eCxE+4GaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqfBNxMiwn4s1ZNNck7fmnIrXK3Gk8ifT5ljXg4VJ2U=;
 b=LInNrWuX4LXibj0ml4n1NjiV2foxmmecQyiHkDzdaNKU9KQ+kI8dJzMbnfgSfyHq/9oEd3LJnqeY14zhclUd7lJB4mOhIO9XEIIth3Ak0ueDX+joK3sCJlPBsWvAvKvpsVeKnV494ydam2oeoFPL/FtPE1CleQLeg5RyCoueArI=
Received: from BN9P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::28)
 by CY1PR12MB9557.namprd12.prod.outlook.com (2603:10b6:930:fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 21:47:41 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::e9) by BN9P223CA0023.outlook.office365.com
 (2603:10b6:408:10b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 21:47:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 21:47:41 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 16:47:39 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 00/16] CXL.mem error isolation support
Date: Wed, 30 Jul 2025 16:47:02 -0500
Message-ID: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|CY1PR12MB9557:EE_
X-MS-Office365-Filtering-Correlation-Id: cfed2cdb-1f8d-4dbf-2f6a-08ddcfb2b58d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RPukX0og3r8Io9EY4FAsQRq1MDCAfDPCZMzodr96CthZH2i3Ava3sZ2TRVAe?=
 =?us-ascii?Q?9lBfavtyxJKDMxkWJt0VFbV/TOntztxks7+YiR5ftEkQ/sSqtFucx/8PR8o6?=
 =?us-ascii?Q?10M1CDYkgxGB1fOC/7xZvPLrO/k5tL5lfediqeMxXyAjVzps7qALxqaUm5oo?=
 =?us-ascii?Q?TPUOuX3vLHhlcublBawT2UJW6159f8ofgxOrtm4JHZ4alplW5A4aDXJtzUlu?=
 =?us-ascii?Q?mq+R/eGhF5bCrcUMBcmEkDwXyIG1x9RCTFxE9xxb/gG4BmmfwNDG8QNQeJ7e?=
 =?us-ascii?Q?vxSUGE5DXMnGcJ/UgItsTvt4Mt3LwGxtQR7L/S7zYYaxbnqTCk/ccCM3kVXZ?=
 =?us-ascii?Q?+1VVcWQBbW5nBvSQBlh06DqVkAT+/a2kKdXxRZHZ2NbhEVi2R/V+adVj9aUg?=
 =?us-ascii?Q?JgTZt6l5EPGhwflOj9JzQgL1Vwpshoz/SfPjzZLt9BbLOy6KeB461plhZKHG?=
 =?us-ascii?Q?iZ/Rp/GWKm3xcnsIFK+3fknIhMZdznMBdOxRbgi+cXgryHdem2cQQnpN4JrO?=
 =?us-ascii?Q?DbWph1xSGgyDEqRROINqYsVgvMeraeOC1lmnHGjKmziU22rY5vEzG8iT8pui?=
 =?us-ascii?Q?pL+IN/zFqmiyMQ4OBXB8TMP2v8icX2360yqBKu7oYIdEkhpYFE4+DAFx0A7s?=
 =?us-ascii?Q?63q1UsSWjmeJsYka+sSFXoTSOCxn9faZ6jop3j6ZiifioRQWUk1mkSKOKq7D?=
 =?us-ascii?Q?fYjbSEoLeqiSPXEenvA6Tuk/ZCo+rNJ/YGKIGsAZzgdaMsUdTp6KmX2wjSdW?=
 =?us-ascii?Q?yAYKV0M34Y4Qck2MBT+wa5OHLv9RL8Ns9IgNu9HGOW3qZfx/2QOvuO0zNno2?=
 =?us-ascii?Q?UdywPFwsk0p5u6Co6aaseJdayFcTtzUex33ouQ5RLdgtTaHd5XObf9zSZFd7?=
 =?us-ascii?Q?RwxeAXjbcZnovgB2J+atPzpg+r9ti5wytH0LBbWQ2Qvkcsp0n39iEPPi1dJ1?=
 =?us-ascii?Q?QAH3KGMdh2jOFzNuaDkAIOLdh0OKoHLuEuhDfDc4147D5weuV+iivK+5xSAN?=
 =?us-ascii?Q?rKBrOJ18mWSu7V0N9gJhpjvWCCVuIitKYrWumRGsf00+bHMa4AbV5/u6FDP+?=
 =?us-ascii?Q?3VuD/jPRmd4M/TNrKj2OLrl0DnD+RPVvUTyX3J2vlqz6zFA7wV8s9jLmM3fC?=
 =?us-ascii?Q?tLkXwfvFVGspdRS6Ryj7cwOgUN3SfQP4yzSiXAkC1jduicisw/CHMBASZFqK?=
 =?us-ascii?Q?x4IoPzHMhMbYL8GBZvSyTEzcsegClOJdFFJSnlbWQmEY2h+bKSh41PTHmc6E?=
 =?us-ascii?Q?pxRlWqGvyM+uayzkTH6AUTXQrHKWXp47U3saEoNwClDvAUNbKF4dNku+VbGW?=
 =?us-ascii?Q?unv+Z4Lnd/h7aDZr3B1Hg6/NeYtXpr22uWTc5tUg1A2alSQqHSk2v4ewFp1j?=
 =?us-ascii?Q?lgNxPS4PCMEwWilsl2fIQVPS0st/60oqJAPjpqohAl7eN/QrrlZf/u++ptBj?=
 =?us-ascii?Q?5iszf5pn7JzodqRBX1xzX8Xh+bRlyaHSfsLcpvmL577U3FmlNRTbbg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 21:47:41.3104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfed2cdb-1f8d-4dbf-2f6a-08ddcfb2b58d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9557

Overview
========
This series adds support for the CXL.mem Timeout & Isolation Capability
as defined by the CXL 3.2 spec (section 8.2.4.24), with some extras
(explained below). This is an optional capability implemented by
CXL-capable PCIe Root Ports to prevent the host system from resetting
when the CXL.mem link times out or goes down (i.e. CXL memory device is
suprise removed or dies). Without this capability, the system is
expected to immediately reset or power off when either of these
conditions occurs.

When CXL.mem isolation is triggered, the CXL memory below the port is no
longer accessible. Writes to the memory from the host are expected to
silently drop, while a synchronous response is expected for reads. This
response is implemntation specific, but an example response would be poisoned
data.

The specific features enabled by this series are:
 - Enabling CXL.mem isolation on link down conditions and transaction
   timeout
 - Setting up, enabling, and handling CXL isolation interrupts
 - Preventing onlining/enabling of isolated CXL memory
 - Sysfs attributes for system administrators to tune isolation
   capabilities

The Extras
==========
The last 3 commits provide support for an ECN [1] submitted by AMD that
allows platform firmware to modify how the OS enables and handles CXL
isolation. The ECN contents are expected to land in revision 4 of the
CXL spec. The link at [1] is only accessible to CXL SSWG members, but
I've done my best to explain the changes in the relevant commits.

The changes in these commits could probably be moved to earlier commits,
but I've opted to leave them tacked on the end just in case anyone has a
problem with their inclusion.

Intended Behavior
=================
Due to how CXL memory is currently handled by Linux, this feature isn't
all that useful for type 3 cards. The intended behavior for type 3 cards
is to panic when isolation is triggered, which defeats the purpose of
the feature.

The reason I'm sending this out anyway is twofold:
1) I've seen rumblings that CXL memory will be part of it's own opt-in
allocator in the future and the memory may be safely removable at that
point.
2) CXL memory provided by a Type 2 card may be safely removable, though
it's left up to the type 2 endpoint driver to handle isolation recovery.

I've also not included a flow for isolation recovery. This is because I
a) don't have a system that supports it, and b) it's not applicable to
the type 3 driver.

Building the Set
================
This series is based on both Terry's port error handling patch set (v10)
and Dave's deferred downstream port probe set (v7). Terry's set was needed
since it introduces the uncorrectable CXL error = system panic paradigm, as
well as the routines for logging the AER info from the CXL subsystem.

I included Dave's set due to a timing issue I saw where the PCIe portdrv
code would run after the CXL ports that have the isolation capability
were probed. This caused the isolation set up to fail because the PCIe
portdrv provides the information to allocate the CXL isolation
interrupt. I tried deferring the probe, but the deferral caused the
cxl_mem driver to break because the port wasn't probed yet. I could have
introduced a scheme to get around this, but it seemed easier to just use
Dave's set to fix it.

The isolation support is gated behind the CXL core being built-in
because the CXL isolation PCIe service needs the mapping code in
cxl/core/regs.c. I realize a rework is planned for the PCIe portdrv to
(hopefully) not make this the case, so I've kept the code as minimal as
possible.

To build the set I applied Terry's set to the base commit below, Dave's
on top of that, then my patches.

Patch Breakdown
===============
Patches 3-5 & 12-13 will need eyes from PCIe folks.
Patch 14 needs an ACPI reviewer.

- Patches 1-2: Register mapping updates needed for isolation support
- Patches 3-5: CXL isolation service driver & MSI/-X vector allocation
- Patch 6: Enable CXL.mem isolation
- Patches 7-8: Set up and enable CXL isolation interrupts
- Patch 9: Preventing onlining isolated memory
- Patch 10: Enable CXL.mem transaction timeout
- Patch 11: cxl_pci isolation handler
- Patches 12-13: CXL isolation sysfs attributes
- Patch 14: ECN changes to CXL _OSC method
- Patches 15-16: ECN additions

[1]:
Link: https://members.computeexpresslink.org/wg/software_systems/document/3118

Ben Cheatham (16):
  cxl/regs: Add cxl_unmap_component_regs()
  cxl/regs: Add CXL Isolation capability mapping
  PCI: PCIe portdrv: Add CXL Isolation service driver
  PCI: PCIe portdrv: Allocate CXL isolation MSI/-X vector
  PCI: PCIe portdrv: Add interface for getting CXL isolation IRQ
  cxl/core: Enable CXL.mem isolation
  cxl/core: Set up isolation interrupts
  cxl/core: Enable CXL isolation interrupts
  cxl/core: Prevent onlining CXL memory behind isolated ports
  cxl/core: Enable CXL.mem timeout
  cxl/pci: Add isolation handler
  PCI: PCIe portdrv: Add cxl_isolation sysfs attributes
  cxl/core, PCI: PCIe portdrv: Add CXL timeout range programming
  ACPI: Add CXL isolation _OSC fields
  cxl/core, cxl/acpi: Enable CXL isolation based on _OSC handshake
  cxl/core, cxl/acpi: Add CXL isolation notify handler

 drivers/acpi/pci_root.c          |   9 +
 drivers/cxl/Kconfig              |  14 ++
 drivers/cxl/acpi.c               |  75 +++++++
 drivers/cxl/core/core.h          |   2 +
 drivers/cxl/core/pci.c           | 138 ++++++++++++
 drivers/cxl/core/port.c          | 248 +++++++++++++++++++++
 drivers/cxl/core/region.c        |   3 +
 drivers/cxl/core/regs.c          |  85 +++++--
 drivers/cxl/cxl.h                |  35 +++
 drivers/cxl/cxlmem.h             |   4 +
 drivers/cxl/pci.c                |   9 +
 drivers/pci/pci-sysfs.c          |   3 +
 drivers/pci/pci.h                |   4 +
 drivers/pci/pcie/Makefile        |   1 +
 drivers/pci/pcie/cxl_isolation.c | 371 +++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.c       |  21 +-
 drivers/pci/pcie/portdrv.h       |  18 +-
 include/cxl/isolation.h          |  66 ++++++
 include/linux/acpi.h             |   3 +
 19 files changed, 1086 insertions(+), 23 deletions(-)
 create mode 100644 drivers/pci/pcie/cxl_isolation.c
 create mode 100644 include/cxl/isolation.h

base-commit: a403fe6c0b17f472e01246eb350f5eef105243ac
-- 
2.34.1


