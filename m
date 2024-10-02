Return-Path: <linux-pci+bounces-13718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9F698E151
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 19:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5EB21C2433F
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 17:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCCF1D14EA;
	Wed,  2 Oct 2024 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J18J6n98"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422041D0F79;
	Wed,  2 Oct 2024 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888411; cv=fail; b=TmzWAgPZSDVY8lVnnbGFcS6QX3cce6RnAmXXTrcohwdSCqPUn/XYxuAN69t/0z0acmwux8q3c92ty7Y3yedap9hSprLGSBrO4CDA6jw+8bBvb7NZcbO9d4mm+EZX2dW0UZCZkM5yS7asUaEilBIVP4Y0Cg14MlwTFE0eDAbS0LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888411; c=relaxed/simple;
	bh=S8SlbyPLtTK/YEkPS9R8aVbwdsthEDYdBabb5HyPfg4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rSTWlJtDiV3qjwBJH91CZkQhEeg7DjZwwiXC2vy0CeSskzRS8OH19XB0C+vYamOJtZs/sw3r1UTUiLKPUJ2rArjq2rvDt1LBFELQVdyQ74dzgxkXU91Ms4xLSbw0APSw2NkGgeG9TBqhQC1pMVBx3+qiXn/PHPdrji2XuxeF0uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J18J6n98; arc=fail smtp.client-ip=40.107.101.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vziDLM7QhEh3y9HCBHiTN5Eskrnv3xnxfxbvT2p0hD3LwEERENdAXU8s5ke5FHxMqNyTsWwq9XkuwunhFzhGTKaUqTWGBtU3uSUqyeFuOPudCsA9whZHqizNlSamjBZTpHT5Qgk4ika8iPcuslTFCXYDAMDy7OB2pV08xn6GwFARY55Y1XN+CGiIS/7Ob7GmfhYAz8hAbhfKqHGVXki37sptZflC8nUoKX+CU7m2QcYV3DEC4z/16N5553PqWfvZyuDi5vUAfjb/SstSC+rZ4u2hiNoUeGI1mjQAav3jRYDBqjuAYsXGx2RjO/pY4N0iMgGCsJVGAGxGw40FtankQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfBW/8AV52D2z0Qm6zWUcugsvQClDyPedN2cAT6EqbU=;
 b=OCcXxFjQ0Yp9hEotciUZwT5n6kxSlhBmXxaA1215ESecSUFIP2+esUaEkHV720jTglnRCQa1qikhoXxKgiCsCLiCIrKiebRtBh9vHTV9hEQ5EPMqFasRY/wxffxGOaqvYrANIIpvh57NLJU4utf6hZ1M9gg+GJ3+mCZPx91hGrtEaH82HbRAtMH87eWDW8nE9JrcNNJ4UvXZxCeaeZ6A8kbuxefqyQQ7paZV6eDFeCBpZxqgOZDc9/rSJfMYmIAcQXYkYqJnKq72yX3oYwePJRxUG4FEG1BXQHIwlfCeWZM1h1HHdSErp/MmFCfQaOjLH/MksZrUoZXp+CvFFdeXfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfBW/8AV52D2z0Qm6zWUcugsvQClDyPedN2cAT6EqbU=;
 b=J18J6n98PhuOTATrPW8N99Lo8vlk3S6CqLujd6rJDD9w6aMQTFgo2x3gDxwpw9OAz4x9Q8kq3DPTua5SKBOQmm8JmAI119cYtZZ4d0w8oNP4gLWGuS8aSh8xE26HMtDQTjZG3rFoGxg7pLxwJAiYoIV6URjAZdkhQny8jEohGBg=
Received: from SJ0PR05CA0139.namprd05.prod.outlook.com (2603:10b6:a03:33d::24)
 by CH3PR12MB9219.namprd12.prod.outlook.com (2603:10b6:610:197::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.28; Wed, 2 Oct
 2024 17:00:02 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::2d) by SJ0PR05CA0139.outlook.office365.com
 (2603:10b6:a03:33d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16 via Frontend
 Transport; Wed, 2 Oct 2024 17:00:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 17:00:01 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Oct
 2024 11:59:59 -0500
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
Subject: [PATCH V7 0/5] TPH and cache direct injection support
Date: Wed, 2 Oct 2024 11:59:49 -0500
Message-ID: <20241002165954.128085-1-wei.huang2@amd.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|CH3PR12MB9219:EE_
X-MS-Office365-Filtering-Correlation-Id: 7706ae09-c669-4ab7-dd98-08dce303a7d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JuvAroCp9+kiiLHyddxJj4gZSRx9m3wABJQ9RD8ESN2h3IGL31LoBaXmqdos?=
 =?us-ascii?Q?BItDV3lcM4Bo1ST8YzUra/Yr2fWojtKrtM+JTnSrmjV4erby1zaU1p6MM31m?=
 =?us-ascii?Q?/yNgbeORADdVtax7smTtLwIsh+Oi5s8/swcoNGstDC0tHFuNxBQ0mBf8Ymr5?=
 =?us-ascii?Q?ppjX7IIC6xY5b9tHDqyHmB0xkYCdR5wF/6rL13/V9woj1o4pNQjgJQhlqxpK?=
 =?us-ascii?Q?DvL1yWsnLn5qNUvKi44E0nwoZavlM41M+rS5uUDcA71sJjWyR9IzU4AeZgk3?=
 =?us-ascii?Q?hrw0NI0323PtrF4EZV6jymRnKQEB0rvEOUcDz8N3ZvN98xCwdaz9+BH7eHaK?=
 =?us-ascii?Q?JhHz1WUrBsoZz0jR1qoyTDfGiy7qSD5/csdNN0eNWHWocmiozpSxyRNKy5Oj?=
 =?us-ascii?Q?j3K7eFwepFlYESO4UP7M3wJCCJizz7EH5LJMn2oAFckNiikHxDtRKTfheBdB?=
 =?us-ascii?Q?C7hiXX2LQ8b/6QHLviz/8pGprCDD+/Uz3mUbpW69xTJhFr3v/ZBEITdHrd+w?=
 =?us-ascii?Q?aiL6LCfuFe395Qbs8cVssve3txdbMxq3aylSN8vJelONqVVqrn+gb53rRWXJ?=
 =?us-ascii?Q?rsiEZcHHgY5WznWCqOL4R4HLLVk1x1spHlD8D+qWQxM5oCvy99HqZ246hzpF?=
 =?us-ascii?Q?9mgskgTg9FjXsGRtwF8iwxBGuidI3mFOpqe3eeds1xYp3Rh0Hrr5X7jM1k94?=
 =?us-ascii?Q?G1l/bJyxvaSJLkPCixGGU8wtGi4OViWJrlJ32WPL8453SGxOQPIiHXizsW24?=
 =?us-ascii?Q?dPmDucdlj51yJ4TY0qaYT+axxel79UgOnIRXEej81xX5Q79KPe7J0bHxYqst?=
 =?us-ascii?Q?JJkMByNUY7WrhHY2nQDvt/wjoroZM92AeTy7x/6jUg3rkC2cSsL6j8bFvvU9?=
 =?us-ascii?Q?izGYFFtq61BDm5NOMlA+yjPvcqsCSfGVgkfDSVLBiaPUv3YNltOcA5gM71by?=
 =?us-ascii?Q?Fz0mUGO+2aAH21zuphGETRvKCPQQudZg/3RoUmFYSHwMKH/zt3kLViUSkmiy?=
 =?us-ascii?Q?Av/36L1+mM2r0unk71wGXX3vXsYDJY7s73bT2hP4LLWC5K5dK5CIMJ/hYtCH?=
 =?us-ascii?Q?LnIbHskrqaXyrhrkBq5742Kruf/WDKwipi4/O0Vvkuee+YXpQxT7OQLTkZop?=
 =?us-ascii?Q?RYtFar1tK0jeT+w2ye+cK1lbKNmt64q8TbEwm+eE0L7mPRtp8zXpA/jdm54M?=
 =?us-ascii?Q?OqqJPTdN6P5HmUASMcDpvPwwb1TGhYLM9+9eDiGel3lOFHNlE8Tnh0mHaxjU?=
 =?us-ascii?Q?E4EQrsYnRAJwXt185qEPX3yLzpQCzzydLOjoHlrdHLydzggq1X/c9ejAx7iq?=
 =?us-ascii?Q?/0AQVqxA4Qtchv3HF2pPlYkU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:00:01.8357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7706ae09-c669-4ab7-dd98-08dce303a7d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9219

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

V6->V7:
 * Rebase on top of the latest pci/main (6.12-rc1)
 * Fix compilation warning/error on clang-18 with w=1 (test robot)
 * Revise commit messages for Patch #2, #4, and #5 (Bjorn)
 * Add more _DSM method description for reference in Patch #2 (Bjorn)
 * Remove "default n" in Kconfig (Lukas)

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
 drivers/pci/Kconfig                           |   9 +
 drivers/pci/Makefile                          |   1 +
 drivers/pci/pci.c                             |   4 +
 drivers/pci/pci.h                             |  12 +
 drivers/pci/probe.c                           |   1 +
 drivers/pci/tph.c                             | 546 ++++++++++++++++++
 include/linux/pci-tph.h                       |  44 ++
 include/linux/pci.h                           |   7 +
 include/uapi/linux/pci_regs.h                 |  37 +-
 net/core/netdev_rx_queue.c                    |   1 +
 16 files changed, 890 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/PCI/tph.rst
 create mode 100644 drivers/pci/tph.c
 create mode 100644 include/linux/pci-tph.h


base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
-- 
2.46.0


