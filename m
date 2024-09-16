Return-Path: <linux-pci+bounces-13244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A1997A870
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 22:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0F91C222A1
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 20:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502F915DBDD;
	Mon, 16 Sep 2024 20:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="viLSCYSS"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C910101EE;
	Mon, 16 Sep 2024 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726519879; cv=fail; b=TVrEuh2RR/45SnXeEmXn34r7Qao7m1NFdClbQt+wUwQ0gdhzd6yP79mpCgrPWJW5OXPWybivO/NU99/aK5k5F2OzZ7IQEYdQ6rEtGXFs/TDM2/jbYYnsegwrQOytRNBdjQ/0YcXrXDV7S6AvUBzxh33FD/znK+vhj/G55995A3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726519879; c=relaxed/simple;
	bh=3piiQoPmxrrtbPzWerp4VO1mEunFqj6Qv4pfHnTdKZk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R2WfPaIOcTVYZenHSaGQPYGxmDen3gPJMRZs6mALyNXslBC1Ey7Ms9rlHPD9vE2OHP5mISUyq+/5Iw2yCtJB7l4CHkQK65dKa1tbt4gNzGACsz8uSpr/rXC1AkdxIyqqS2vb38kflXMv2v8jFW+Jt/iW19mmVamV9gqiX2MfAlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=viLSCYSS; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYwEt45H8zPrUpOryz71hzjGugXAzT/zMFZvxxwjmFPnhka+w40WsBT/kDBQushgU0gtKAt2uKoCK0ndwoEO7uXoth/lt3zHr/Lkav/Xr1eKWO7f3CLx9diBkj4vZyhhb+ySrMdQYWr8HyzsCgeeCdnmkV/n+ud1d2AO5H3Q2rpXzq4vbmeHAvGsUhCeHT+SB4CeyTeFIqfcOa4IdUc0NYiVCY39ahBp1hQI1fGFM7ZS99sRCVO0n7fiNcuS2/QKR9gjfX1gH8Z4vLC5TSQkf2AneD4g0/AccOtxJgkRGIP8/haCfREqCVcUsrFmypnLHJyoxnZhuRnLpUMDLRt0tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38qc3txcOG1jD8X753o9umrcSFNStJ42WrJJo7k/q0w=;
 b=AN2unptr8K8FIJtX+n9joTLavBxAHT3TaluyWDpvUOyFRYUNMQHLP9MQe4gWvdDIulEiii1dKI74sCCJNlGbQHL8oblkmsp9hIL+BZ/dc3mqOE5o0YHhrSQ7uqMLKCvDXpuVUfLHjLKu3g0mNXnoiOQ8R0M4pEykvZztU1TdANeGZv3wYtMjoQXugrWzZ57HHih4GvxMTx3CYEm/OLRm5mEX2RPuz3m5c0z2F4bLI1bvaHDXF51xZoKT975QJCSsCODGuSqKSc6AZ1VLksHDWcCsSUhcHHM7fJ8EkYK2hwe+GxFMl9YU9/QUyJmjPH0XWtCaT8Q7XvaKaTDR4IMGjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38qc3txcOG1jD8X753o9umrcSFNStJ42WrJJo7k/q0w=;
 b=viLSCYSShwfvsTBTN5zhYvQY9FpyzUB9inI987jvB+06gBJ86RDCcH+9540hHYO8oIpIO9I2ScF6d2Ct6RXysUJGCbSlFuwBXla4p60rxuI2uuIuFJTT0jcpnU9pk7iI1inkDi1+JjExHZsnfUhT4bATYzJ2+Jrh0i1cpoUiWRE=
Received: from BN0PR10CA0004.namprd10.prod.outlook.com (2603:10b6:408:143::18)
 by SA1PR12MB7411.namprd12.prod.outlook.com (2603:10b6:806:2b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 20:51:10 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:408:143:cafe::90) by BN0PR10CA0004.outlook.office365.com
 (2603:10b6:408:143::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 16 Sep 2024 20:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 20:51:10 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 15:51:09 -0500
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
Subject: [PATCH V5 0/5] PCIe TPH and cache direct injection support
Date: Mon, 16 Sep 2024 15:50:58 -0500
Message-ID: <20240916205103.3882081-1-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|SA1PR12MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: d90aa1f2-8104-4a1c-221b-08dcd6914b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LNbAvE341MLt8t/ggfX7xtum/7u9biDXi006VH1VvATX+phUCfWUX27Qi1PH?=
 =?us-ascii?Q?oNxNNhI0WuKEbwsUA6ys4QJ/kqsStoQNBjbVU+sHQPjgS2BpQI71Gvn82/Yx?=
 =?us-ascii?Q?2Gq7r0C+nr7IXHFzNqmr+8Pr4vbpbJUzlloULfQoS0/NpZHSAfFBMCu79hUN?=
 =?us-ascii?Q?dLWllFbAaJmbYi1kdM57aWrGgDg6Vi2AYnCQmauYf2o9uvEearIIgEp+4IIj?=
 =?us-ascii?Q?B6IvQXxzrE737uzPt/2Sav+xxW8eYghAm6zdyDO83k8H3LBYnl67uTlvSIYz?=
 =?us-ascii?Q?erw1JMaY4WE/GECu50oMI4bsrLSRI/gkwBSrNQTsGJjbWms9oZSwg1h2/4Jg?=
 =?us-ascii?Q?P/j7vlGvLK6+S7UhBfCmDuIDgyOTFxfvCCNnKwHLOigDMwvKFt25d8pqUWaU?=
 =?us-ascii?Q?vAHs8pbXqEQTd+zp56lE/HkL2ubDCiPE5Nzt/1/ZLSpYyz8T1keyb2sxSVD7?=
 =?us-ascii?Q?htSs7YJHRqqncTJmav113dw9oCw6y4klIgu+IgMaN21tdHS5dLIdSEvKvSym?=
 =?us-ascii?Q?LTb5eF5/J8oVoN9tJ5V1qBdaWo4hezjXaF+KgxsPCmFDEuYozTlcig5cxIO2?=
 =?us-ascii?Q?zrkpWRIBAOuI4zq9uJnT0+WxSEhIylfx4YPxd5wzVCwhmJpqPjZD8xWmAW7b?=
 =?us-ascii?Q?R8xYDFvxKhc9HLPbzI1s5xmWg+dEV4dUuklQLgFINVfT5Lbz2lO8RjEXVpso?=
 =?us-ascii?Q?7ryUOk41jRQPP1HyX21lv30TbyJFj3FAqaDOvTBp6Gulnrf6mF0AgMwPoqNY?=
 =?us-ascii?Q?gpcfVGu+4Exy0vxeQw8Nbw50GTTYsQQAofvY60c4bqoXgaMfERYLwWAXRZuq?=
 =?us-ascii?Q?qG4BqJa8BRF4N01/c+y4Zi1ryI7PZm4PDQblO5een4nayxiwvPEHCb+aLk4m?=
 =?us-ascii?Q?Uhhzo5aOqCR2elATfixZT+0GxNv2CGKQ5F5kYiigUQNafsxJv0ls+BRhd25O?=
 =?us-ascii?Q?GGlKz1WeysFnmc8lL9/sBysTJ74t3dSbjAk08sKC+RWx5QJje72HHpV7As+r?=
 =?us-ascii?Q?vWKFA+0kG3GRKr2OQ8d+LZIBlLbte3rnWhsGidzVAeEVBEn9BaCjgMmz/k8n?=
 =?us-ascii?Q?O6ctCoVvDRJ0VfnYSTr/9u7tCJczgL3olimdSRiQuQnsIrd+I/eVjkRM+byy?=
 =?us-ascii?Q?pkFkMNbkE0cGgLKdB9rvebcw5obTWS4LYYIv55QxHrCY8hGi0y3+F6FmCsPm?=
 =?us-ascii?Q?pAKC9ld29whwn6nK0/pD870225PlSNiTCRRORSFf9QTP6q8kWJB/WjaSrN0c?=
 =?us-ascii?Q?Spo+SmzuCydTpsiWUIZhTtqgHgcybEtR9ET6p1Qq85cIGweTrx3IUnZmNJif?=
 =?us-ascii?Q?TSpkPUFLx+zPtkpAphkcArkge/Vhz/dtsSyIE3RXRO8ndHLS1soH80B32C20?=
 =?us-ascii?Q?B27LZd9TUzxYiU17+Drdr4fGyEnZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 20:51:10.1706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d90aa1f2-8104-4a1c-221b-08dcd6914b73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7411

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

V4->V5:
 * Rebase on top of net-next/main tree (Broadcom)
 * Remove TPH mode query and TPH enabled checking functions (Bjorn)
 * Remove "nostmode" kernel parameter (Bjorn)
 * Add "notph" kernel parameter support (Bjorn)
 * Add back TPH documentation (Bjorn)
 * Change TPH register namings (Bjorn)
 * Squash TPH enable/disable/save/restore funcs as a single patch (Bjorn)
 * Squash ST get_st/set_st funcs as a signle patch (Bjorn)
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  93 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   7 +
 drivers/pci/pci.c                             |   4 +
 drivers/pci/pci.h                             |  12 +
 drivers/pci/pcie/Kconfig                      |  11 +
 drivers/pci/pcie/Makefile                     |   1 +
 drivers/pci/pcie/tph.c                        | 536 ++++++++++++++++++
 drivers/pci/probe.c                           |   1 +
 include/linux/pci-tph.h                       |  44 ++
 include/linux/pci.h                           |   7 +
 include/uapi/linux/pci_regs.h                 |  38 +-
 net/core/netdev_rx_queue.c                    |   1 +
 16 files changed, 885 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/PCI/tph.rst
 create mode 100644 drivers/pci/pcie/tph.c
 create mode 100644 include/linux/pci-tph.h

-- 
2.45.1


