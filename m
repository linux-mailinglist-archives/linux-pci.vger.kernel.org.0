Return-Path: <linux-pci+bounces-13605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A02988C0E
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 23:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312FB1C217CB
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 21:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED6C18B475;
	Fri, 27 Sep 2024 21:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EWKZu0zF"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F7814BF8B;
	Fri, 27 Sep 2024 21:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727474227; cv=fail; b=ecJyC/X69DMs5CT5eB9t5M006L5RK8/Dm/as0TE7tM0rane2fcV18ilqFnaARITIIbCzPXBvEN/hBWUb4HrkdBNVhw9GcQa5nHI+V7Zj5sAjnOFOLdoqPSiLzfhdNPqHcUXtx9JRPwuMbv8oClHH0fvNmYr/rbeTRiEn2UdAp+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727474227; c=relaxed/simple;
	bh=XWXn/3yxWostKFtQvvPRUYhSto6vlf5RdhYCYe6Y1qU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NvHoPNRL7gBEWltL9OHt6peJSolawQB0ITBa4qhTPumVOQKUdaH6WpfKnjN6UHa5cz/j4NC5UdJ30NYpdMV6ukovL0hLQik2DOpnrY9xJI5rOJJlDTjpZIblEq8wMPfpO4nB72/OVeXcPRlrqDaOpcJRemK0zLHDK+HmCeUUNQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EWKZu0zF; arc=fail smtp.client-ip=40.107.212.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WbEA4EmByGzkjI90/znByGAGy6024SrIiY+3mkKLfrUY1i3PdwqaRL6sFvNl7s4uu2CdEJSXBIbWTCGB9gwPY4wk/PvUvOdw0J/RiCVsnXScfQtsOAtTe5g7JVpCW7YZ0K8IhagBXQe74+HTpQSMnYOb+pq2UjS93vn5CrAnbV/9A6rc77O3GPV0CwnaR7aa7w44NxqpzgsFhv5KRequntkjVRfcsC60GrDsaPgqp7p82ArFB5TEBAyvK5m1FKPhHQfN4aG6Yv+PE5S5mc0wWpWSHmMTUZzlY3flWgkbZLLtyp3CVqL75ubcSj/xnZAH0jVAWpuMLiyf81xVuUfmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNDQ8Vwli0DTWS6NSCszwavEMFO3ztz6ft9bNaGmyZg=;
 b=Hnxf5dKcIUK/6gpe1FE9NxOKwoiG1FCXBATF4EAUTLmduSrrOPvOYN8yk1bPMHvUMz6uiqF4kXfccrYMLyT8i8NtN8kt5ntMdGwMS7FhTyLiVRYmYuLgYZNM/tHeLfwiOvayxBwDVKU57xVQcaP+kIIYpxAfv3WjlbI7HDpeTUZftMP4v7ckCK0LQcyKKvEapv0W2gD5wf9Y7mWOzr+dipudxFkQit8X8AaB5smirR+2YrwKhABBoheJF3XTrzTA/VbDMZtFpvF1KD7seCWuYQvSI5QJ9NZEzHAFqv6LxyysfRi7HKYMMCJTdIFXTcUh2lUvt/N53qUK2aCqB5B0ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNDQ8Vwli0DTWS6NSCszwavEMFO3ztz6ft9bNaGmyZg=;
 b=EWKZu0zFLpXXtGh6CiIbpmqerjCT2LcO9XqxwHho/kwA2TB1eZ08sdY3ieo4W1JBTpFeT2O/iyxb8mxJ9Gb+VdHYE2a+yzw3a7b6Yy/6gFRnslu8qybbHO4Jpa/IRl2E/DM0IsjdG2+9zf9ElytAuDyDEokiXir/BqqyW3sVKCI=
Received: from BY5PR04CA0023.namprd04.prod.outlook.com (2603:10b6:a03:1d0::33)
 by SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Fri, 27 Sep
 2024 21:57:02 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::38) by BY5PR04CA0023.outlook.office365.com
 (2603:10b6:a03:1d0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Fri, 27 Sep 2024 21:57:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 21:57:01 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 16:56:59 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <Jonathan.Cameron@Huawei.com>, <helgaas@kernel.org>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>,
	<vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>,
	<bhelgaas@google.com>, <lukas@wunner.de>, <paul.e.luse@intel.com>,
	<jing2.liu@intel.com>
Subject: [PATCH V6 0/5] PCIe TPH and cache direct injection support
Date: Fri, 27 Sep 2024 16:56:48 -0500
Message-ID: <20240927215653.1552411-1-wei.huang2@amd.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: 3efbcd87-f7d0-454b-a8d2-08dcdf3f50f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ez84TrZmrgu7rGtCsboANQKHoarrKBHFb7lzOYHj4/nC03xsumKY3nYJeHG3?=
 =?us-ascii?Q?h/kFgQupqcTbWBL9LV+ZYIm4z2MnOjUg3FXyWK4+TgiXe8k6aUDriaXe6udJ?=
 =?us-ascii?Q?nPX2pqdr9GvZmbL7paULxVJnnvZ8rKd67pAQxqmVWju3EoBvchdNfuwR15Kl?=
 =?us-ascii?Q?L0e4elDEwoKE3la0Vj5oXyer77yTEL44MCx9b6lM2pIW8ysDVOmMsIH7puO2?=
 =?us-ascii?Q?QNhx273g1OFEzPlLGLxdd9AvqlF/4zwAjA52tewYX9PHdambBEpL8p7G5Eig?=
 =?us-ascii?Q?5mcxUDSyrYNzbWpZnTwD/eU1M1wPCQxXWyLaL/CqnyQHJtX7PWvlAFiydNWr?=
 =?us-ascii?Q?TmbBfFseVsbv4ixrGqVpHB4rRZBt52N+XktrI7DnWlMBEvl18UvGzysfPqDo?=
 =?us-ascii?Q?PGclk8se1xHuu9BfaOXoeODZ+qkze1FFnXQbwRqKp86n9sUl+25iu0QXf8nY?=
 =?us-ascii?Q?dMYsACIoYhVJb9zGinWNtchk+D0HRDoKUMPtgvpKDwpd1Lq+ZwP09fp0wH6H?=
 =?us-ascii?Q?9LFUcLgnQWg0R9o/n+PtfIpTR+nHBGp4io3/LnJq2xOQzwjC6izA9TDMQXGd?=
 =?us-ascii?Q?NkLn72tf+gfDpElykqmcI+tINYLCkU81vdeb2EEUfcNpdAlK8mc5G83V02fU?=
 =?us-ascii?Q?3+KB5PcgVrlJDfhvrJzh5cZEG6V8PPT9ZBs2+vBUqLh9DJgQAE/7IoS8tYL4?=
 =?us-ascii?Q?zzlsz00YSIocIzI+Xq9eCKRZBlkqxzaAY61NitpHfjjid+RzordA1lvOXpRa?=
 =?us-ascii?Q?NejqbGDUtAUDzLSRQWy6aEyQDm5ukB0OnQlx1LYZP0pJ4sSIJqc+rLC38PXG?=
 =?us-ascii?Q?8CH5UFrrE4jipMzokzL+sxCrUSBfys6L5S4juauJGkXWPqB19ADASRrmY+1o?=
 =?us-ascii?Q?t9lNjXXEk+V/B5okFoC8rtau8JAjJhObwmMhSHV2x2/LzfmM/+3xsbzzD2nn?=
 =?us-ascii?Q?M+p4I8uPyMfrLSQjtWTarmFYc7j9lk/gmoBspEXvi46WslithmCMHUy6jLOh?=
 =?us-ascii?Q?rvaMXd5LoJJfpfifOYoOJ1tUzgCWvaMy2cFPGwg1B2NXzrEdDM38awy16xx9?=
 =?us-ascii?Q?vJ0hlgg0W1sEUWjLCJvT3YmvWeeeq9WLliWMiB/PvC/gOjk526i5tHJJaTbK?=
 =?us-ascii?Q?6xhX36jLBa6lRCiEKZErgOyVPr0wNeI8MYjQdcgURleEF5n0G+2PaRcpprhh?=
 =?us-ascii?Q?V/FWowuVp2STEz3rnZLJKeTS8+y/JS0BcMULwxgNUuDBZniaVbTXeREHZ3Jz?=
 =?us-ascii?Q?JpfF0aeDOr+g98jinePL/2b+5JiXk/2U7kRzOmCBkqzapFhN0oJwZb4sN0tP?=
 =?us-ascii?Q?SRBcQtSmyjtFQyOKs2Qs2/EYCjbr467t0IoZ9gp8eaDS6yNyNnaeNb9v/ccx?=
 =?us-ascii?Q?046UAren4T+FabcguqjRTi58CM0E?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 21:57:01.1790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3efbcd87-f7d0-454b-a8d2-08dcdf3f50f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085

Hi All,

TPH (TLP Processing Hints) is a PCIe feature that allows endpoint
devices to provide optimization hints for requests that target memory
space. These hints, in a format called steering tag (ST), are provided
in the requester's TLP headers and allow the system hardware, including
the Root Complex, to optimize the utilization of platform resources
for the requests.

Upcoming AMD hardware implement a new Cache Injection feature that
leverages TPH. Cache Injection allows PCIe endpoints to inject I/O
Coherent DMA writes directly into an L2 within the CCX (core complex)
closest to the CPU core that will consume it. This technology is aimed
at applications requiring high performance and low latency, such as
networking and storage applications.

This series introduces generic TPH support in Linux, allowing STs to be
retrieved and used by PCIe endpoint drivers as needed. As a
demonstration, it includes an example usage in the Broadcom BNXT driver.
When running on Broadcom NICs with the appropriate firmware, it shows
substantial memory bandwidth savings and better network bandwidth using
real-world benchmarks. This solution is vendor-neutral and implemented
based on industry standards (PCIe Spec and PCI FW Spec).

V5->V6:
 * Rebase on top of pci/main (tag: pci-v6.12-changes)
 * Fix spellings and FIELD_PREP/bnxt.c compilation errors (Simon)
 * Move tph.c to drivers/pci directory (Lukas)
 * Remove CONFIG_ACPI dependency (Lukas)
 * Slightly re-arrange save/restore sequence (Lukas)

V4->V5:
 * Rebase on top of net-next/main tree (Broadcom)
 * Remove TPH mode query and TPH enabled checking functions (Bjorn)
 * Remove "nostmode" kernel parameter (Bjorn)
 * Add "notph" kernel parameter support (Bjorn)
 * Add back TPH documentation (Bjorn)
 * Change TPH register namings (Bjorn)
 * Squash TPH enable/disable/save/restore funcs as a single patch (Bjorn)
 * Squash ST get_st/set_st funcs as a single patch (Bjorn)
 * Replace nic_open/close with netdev_rx_queue_restart() (Jakub, Broadcom)

V3->V4:
 * Rebase on top of the latest pci/next tree (tag: 6.11-rc1)
 * Add new API functioins to query/enable/disable TPH support
 * Make pcie_tph_set_st() completely independent from pcie_tph_get_cpu_st()
 * Rewrite bnxt.c based on new APIs
 * Remove documentation for now due to constantly changing API
 * Remove pci=notph, but keep pci=nostmode with better flow (Bjorn)
 * Lots of code rewrite in tph.c & pci-tph.h with cleaner interface (Bjorn)
 * Add TPH save/restore support (Paul Luse and Lukas Wunner)

V2->V3:
 * Rebase on top of pci/next tree (tag: pci-v6.11-changes)
 * Redefine PCI TPH registers (pci_regs.h) without breaking uapi
 * Fix commit subjects/messages for kernel options (Jonathan and Bjorn)
 * Break API functions into three individual patches for easy review
 * Rewrite lots of code in tph.c/tph.h based (Jonathan and Bjorn)

V1->V2:
 * Rebase on top of pci.git/for-linus (6.10-rc1)
 * Address mismatched data types reported by Sparse (Sparse check passed)
 * Add pcie_tph_intr_vec_supported() for checking IRQ mode support
 * Skip bnxt affinity notifier registration if
   pcie_tph_intr_vec_supported()=false
 * Minor fixes in bnxt driver (i.e. warning messages)

Manoj Panicker (1):
  bnxt_en: Add TPH support in BNXT driver

Michael Chan (1):
  bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings

Wei Huang (3):
  PCI: Add TLP Processing Hints (TPH) support
  PCI/TPH: Add Steering Tag support
  PCI/TPH: Add TPH documentation

 Documentation/PCI/index.rst                   |   1 +
 Documentation/PCI/tph.rst                     | 132 +++++
 .../admin-guide/kernel-parameters.txt         |   4 +
 Documentation/driver-api/pci/pci.rst          |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  91 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   7 +
 drivers/pci/Kconfig                           |  10 +
 drivers/pci/Makefile                          |   1 +
 drivers/pci/pci.c                             |   4 +
 drivers/pci/pci.h                             |  12 +
 drivers/pci/probe.c                           |   1 +
 drivers/pci/tph.c                             | 544 ++++++++++++++++++
 include/linux/pci-tph.h                       |  44 ++
 include/linux/pci.h                           |   7 +
 include/uapi/linux/pci_regs.h                 |  38 +-
 net/core/netdev_rx_queue.c                    |   1 +
 16 files changed, 890 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/PCI/tph.rst
 create mode 100644 drivers/pci/tph.c
 create mode 100644 include/linux/pci-tph.h

-- 
2.46.0


