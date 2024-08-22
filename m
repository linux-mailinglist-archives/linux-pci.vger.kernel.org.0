Return-Path: <linux-pci+bounces-12039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B89595BFAC
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 22:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83591F239AD
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 20:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB181D0DF1;
	Thu, 22 Aug 2024 20:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B+hawQP4"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EBF1D04B6;
	Thu, 22 Aug 2024 20:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724359294; cv=fail; b=RzorlZ3QGy+QCSyik5Oe0Rxi/OhzmXEBPzZIdP5Ha87PKDbon+B4R3LxtpF4/FAjgozvV7m29ArVO98s24WGRzzV7MpFgva4DqudtEuVzYgANgnLafzYKNaWN1ML0PDVoAADpPaUHJTc5Yr5Jm4tecp6aV+3tfYWqJeik4LtESY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724359294; c=relaxed/simple;
	bh=sjjHFlcn7IbSAoCj5vFmKvnSrfHM8ZZKwKDM5JAw720=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tAcN6rtSu7Mt65oVs5+JunY9uY8+VVlcX74JmZ3qgPGXZCIFjOphvLuPIEoPjc+L5VSEEyFR7YUG/DWzjA27QDjtTPr+SbHdcO4bamEW88W9qA1+THQTLk1G84JjfdCjSkviGmilUbEBSyUrJcns9Pj5esXGT2z2zGfpUKcLEeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B+hawQP4; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8oxzB6uYIpZalCdy10saNOsW4kxp8E7Qdok/OQ/PLvLAUJCc39LWz0Xfowxa1BqvikF4E9sECeleORMPUMYZFHL2KzerJoos9d4eyKJGiIQqY+0wfPOWLcoSzabU9p2yLBGRd6LQor9BuNiQVPvtnro1b0R7BtlVE8qjvMyHpH7RAR8KqPuZfxdFbumNLl7oJokg/sfEXqaOvFvDzQyGKkwFSO8X+4QPPxwfD5xw8yTVP2TzrFDoa3LtHtpUzRr2G7+btJuiAhCF2C685TYPwMg3jUBdAVStCcmvz4ruxqZI9RTioV/yYvPipftEq/vW9OCNipDaTW2pmg28ZR5kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UrNcO8RAk+PbXtyFQQQm7frv2H27uuOJEWOmstzjX8=;
 b=qc0z2Npwuh6aVqm1ALP9sZQtm5OQlBFmEQwTPyTaoz12uX4nvccYla0+THtFvtrsoeDsX3AniTSSRSmrTBT1Faht7uW2bIn/mS0ngGNTakp2zxVZVS/jLpmLKRS7Ks1OvK2q/9qt/bdgVWYFd3P0/NiiwgVaZzpsxjfY6oVjv8yeBY49iT3Uz3CcjF2NjkrTBLAcrDzIfJ8gMD/cIhNZRWDaNKvOlOEvacHaJBubvxTuW+dZHxqD+IQXOP1CA1MD0ZZdJwPL4V22GwHSGlxhP844tXUzGe+VADjofnPv+gJoOQKVIINWxAA4Hfs23FpF+/IfQdh2xospNSQ6w6aJOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UrNcO8RAk+PbXtyFQQQm7frv2H27uuOJEWOmstzjX8=;
 b=B+hawQP4dpxrMS8nTa2N1xDKb9CXmtX2K4DDCwtntK3yH/PQrusMsh5hxkSm+V+yeo/KJmODtBSR/emFVwRfxwggVz9ssLIDL4lICs23SUUFP00f2E/OL9L98XbqfY8EK68c6Sk0TS4GdV8BmA0Zo+hQklv4tJg9WEIYKXYlhX0=
Received: from BY3PR04CA0024.namprd04.prod.outlook.com (2603:10b6:a03:217::29)
 by MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 20:41:28 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::c4) by BY3PR04CA0024.outlook.office365.com
 (2603:10b6:a03:217::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22 via Frontend
 Transport; Thu, 22 Aug 2024 20:41:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 20:41:27 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 15:41:26 -0500
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
Subject: [PATCH V4 00/12] PCIe TPH and cache direct injection support
Date: Thu, 22 Aug 2024 15:41:08 -0500
Message-ID: <20240822204120.3634-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|MN0PR12MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: f874f0d0-93a0-4a56-9dcd-08dcc2eacc0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZWMOCNJr2DnzH584GpGyKGUNYba+tAC5CzjaMkBbB9wpEMW/n4RiE7PvwDPx?=
 =?us-ascii?Q?q+BWZBQRoQglMGTKyEJOcbxwlomfdCxV9oYidGe+/tfyd7bg3c6+m8fWNVcf?=
 =?us-ascii?Q?bIzfvPaHz2JEzhoXYURv/SdQTRVqtn+Wr1JtsLhm1ZrWoyabGi+xE6rcqscG?=
 =?us-ascii?Q?Hopk8Kk+deZiyfXQv/kAz+rbIy+38SDLZ7Vh1zE/VdscAx6faZGbFBulv8q/?=
 =?us-ascii?Q?p6j80aZjoZU4vgJhQXTvagYTex/AYPaboTFtZ+uXmJfUbVZ2kpuv5x7U84gE?=
 =?us-ascii?Q?SNe+OdgLil/Q5EUt0stDWsLh6jh5ffr1e6z+zeP3HzXi/uXrEeVPawpq8AFp?=
 =?us-ascii?Q?plbXtFaHwmMjngdDSp1r+MFuUPrrWfsm3cgtcFI1px6ijm4qZn3VOMIDRvJf?=
 =?us-ascii?Q?5+ZZE+Xhdjp4Z8ZvVDoDTXQIFOHS3qffBWuTjwMMsQ/2fRbm0iCMRGnTl8uA?=
 =?us-ascii?Q?2PylVSm4S10CqQwNM9MtYb7YmFcJj4N0daYpj6VIx7uL63Hgj10UJKSNz5JD?=
 =?us-ascii?Q?xxbofxeGu6GZuNayFF8057XXAHPx7TDKmwOchjjXabpaT1yQ0ZQu21MSVNao?=
 =?us-ascii?Q?P17nc8sY7bDXpDYV+52qIr6BdIK+63bfUCnSw7Nh03SAXVYBQyK3eY4vQv9c?=
 =?us-ascii?Q?ewpzqw/d0XDhq3afB5F6QzJpcHhCPEYJOYQ6ykuds/JrrlITNANNwgajJqLZ?=
 =?us-ascii?Q?SeUQaKewjHNqgrcQz2Anhy+1LCCaQrVzmdhLq/IwG//lPhj4NAtTur1tr2rD?=
 =?us-ascii?Q?CtTizXHfJbCNM2xubvIc3CblvGYWe6EdokvDn0KMIwo85CqgwMh9FT3MoGHL?=
 =?us-ascii?Q?YUd/YI4u6qv3sY/PTddVwDdmhym1VLk5yWAGonbFgYTQ9oxK/GI4SfN52KvV?=
 =?us-ascii?Q?SpbwIhDQKD7zOh4Lg2Sx3tBmue6UfNjUwgW9rpKGXpJARK7hRiLaYVGzssMe?=
 =?us-ascii?Q?CMZwsBsxCtiA0JdCcVXj097+iR+/OFbJReihsnxJNySLHHpm0TLgM5S82Qu5?=
 =?us-ascii?Q?IqRYGbu8w8Ox4QNxc8Alc82azZ7OjRfhskBvjL8TvIF8k2wrZEQsfSprvvrn?=
 =?us-ascii?Q?b53oiXrCVgEQzJC+qCVNz6O/PZV//U2cZVKVXuwtn7Ugozas1sn4iSw2tC2P?=
 =?us-ascii?Q?OwPQFHer5yh0Lgk5ysr/iscvWOPF+TbuMX5WryMNv5g5iBRvPl7JL2GcQsG/?=
 =?us-ascii?Q?KzUeQD89vtGT3s3SozpsNDa1n2l7waDWM26g/wpd+aYzTj7MA9WVTjPeHxdI?=
 =?us-ascii?Q?CMWvdxbSCBphMPYyinBfsu1ijNJpxzbcVbtmjD8tYXB+peoo5w4I+fbgVAlB?=
 =?us-ascii?Q?0DyR42Qhk/ry9rvp9515kKQoN2afxcyMLpyqYRUKpR+Rqx1n+ShBDxYXiRcG?=
 =?us-ascii?Q?e3KComsNX7pGrQFR5oF/ZcPUPnpd+Jm2jfn8m5+djHrHK0upPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 20:41:27.9654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f874f0d0-93a0-4a56-9dcd-08dcc2eacc0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5716

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

Paul Luse (1):
  PCI/TPH: Add save/restore support for TPH

Wei Huang (9):
  PCI: Introduce PCIe TPH support framework
  PCI: Add TPH related register definition
  PCI/TPH: Add pcie_tph_modes() to query TPH modes
  PCI/TPH: Add pcie_enable_tph() to enable TPH
  PCI/TPH: Add pcie_disable_tph() to disable TPH
  PCI/TPH: Add pcie_tph_enabled() to check TPH state
  PCI/TPH: Add pcie_tph_set_st_entry() to set ST tag
  PCI/TPH: Add pcie_tph_get_cpu_st() to get ST tag
  PCI/TPH: Add pci=nostmode to force TPH No ST Mode

 .../admin-guide/kernel-parameters.txt         |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  86 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   4 +
 drivers/pci/pci.c                             |   4 +
 drivers/pci/pci.h                             |  12 +
 drivers/pci/pcie/Kconfig                      |  11 +
 drivers/pci/pcie/Makefile                     |   1 +
 drivers/pci/pcie/tph.c                        | 563 ++++++++++++++++++
 drivers/pci/probe.c                           |   1 +
 include/linux/pci-tph.h                       |  48 ++
 include/linux/pci.h                           |   7 +
 include/uapi/linux/pci_regs.h                 |  38 +-
 12 files changed, 768 insertions(+), 10 deletions(-)
 create mode 100644 drivers/pci/pcie/tph.c
 create mode 100644 include/linux/pci-tph.h

-- 
2.45.1


