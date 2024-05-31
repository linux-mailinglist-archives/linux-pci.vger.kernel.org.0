Return-Path: <linux-pci+bounces-8142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB3A8D6BB5
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 23:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE831C23A17
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 21:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC077A15C;
	Fri, 31 May 2024 21:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LElijR8C"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001121DDD1;
	Fri, 31 May 2024 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191540; cv=fail; b=jX7lk4hm7zNNT1BFIBSQIwQJWv3WuHyg5ajO9k/5loYPTwmFo3BL7jJcUOjFV1vsPoNmNbPf+k7EFtrwcGMqj1dOtLW8kXLw3Q0/fGLgXd/Vwr+2GIRe/SRD6nQhdkpBNCjaDQ+UHr/w3Kbk1tHAiKNimmsE1AjNn4z6UUwMKiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191540; c=relaxed/simple;
	bh=v8E0kkBYUBrqQJJIeLKOzFXacKhwqjx+SWhN2eKd+LA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MpLqasgEy3F8EvDDTsE5uE3ETm4rzj8+qum4BmvFNG4DrqEGYuLDs8yPHmgOX+sSqfK+gllPPRXHilThc+BSz2eNC9CwV7+xKGanRR9eQHSaUth+q+bJekujpfxj+5fVPJlPQ76QD/rhHmPmHKijJqCTBVKdPXIqxgGgD7aqHi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LElijR8C; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HT3toomvlKFHk3iLqRx8tQFDNNKhGDb3zqDaJblxbbB/tdmwMvrXvutpvb0z1aIcVuaVCUDHWfPLCAdswsHZVWH3IqL5VjvrLRmpJlal6aY+WG9EVxIh5C230A7acaljUmjDZjqc+k6T8HauvyWCjlWY4Udo/15yE9Jv0vTEGuM+M3D+MBMEoRjEvx+76cYI0nyoCA+QDN6A5WVgq+ii++EiYwqxIoCoDbL1Q0EqB8JGRWgaWJPqgEF4uwp1ea5d8l9RNwjSs3ndBate+xjgUGJRoPFXd929grrct3dUosuJQ0ZoAsPFgWDLWD2UY4H3Buyheb5oXD1wCd/zVERLzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEaH+lcRkbHItOwR8ARAzg4Q+VIIwskoMCC8C1nhRFw=;
 b=eHLSBFozw7/Tj7/MuUlxy/GO0nuOKtbkOKJE6HzhcdMgziFoxy2bMk2smpdXyvQB4jd9HFarF12COVnodp9iO5Am9UvQLb2SgW1dKMJ5oPmgHVTKj47WVdVsCjJ8atJTSarkDoDZauETkoxFwQsHrhE4EkH0oqqUn5NYJ+pfOJr/SrQITK07bjmp1Cl68C13f8lQuRrhgqaIpfb/OLk4LkcOaHoHA6DFI+Xk9U+00q+zQVwrO/Zby2OsFXuGSq9XE/9/I7C76Jp4rvMf8bN6ab43yHJCXqPoAzXwMdlJXRyabkrX028YmuimJXzjxdNWxOAG8+2r9uWqepC8a7S6SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEaH+lcRkbHItOwR8ARAzg4Q+VIIwskoMCC8C1nhRFw=;
 b=LElijR8CiRko0/f+oJbC7RaIQMlI5OYoBO6XAOhIjhDCtMm2OZSvz7P3Twe2GSFIAeyarNdcciD3Zv+TbJ71vBxeMErB0kza7azXi4qKHkhq777tK7BFnPHWv92KSWwUMttqr5aj6u9Qzb3WVEO8LNBOvudvTDWsVucs8/NXN8c=
Received: from CY8PR11CA0032.namprd11.prod.outlook.com (2603:10b6:930:4a::25)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 21:38:50 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:4a:cafe::11) by CY8PR11CA0032.outlook.office365.com
 (2603:10b6:930:4a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Fri, 31 May 2024 21:38:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 21:38:48 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 16:38:46 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <bhelgaas@google.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>,
	<vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>
Subject: [PATCH V2 0/9] PCIe TPH and cache direct injection support
Date: Fri, 31 May 2024 16:38:32 -0500
Message-ID: <20240531213841.3246055-1-wei.huang2@amd.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|SJ0PR12MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: 67da1e8d-02fc-4422-a2f7-08dc81ba0e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BVMBrWnktqBxZwc3H1lx5XO0+w8RkxPk/RDqmcxlBcmF03085zLAs17KexJI?=
 =?us-ascii?Q?UzQHQpbKmna3v6YL9DJFrF6+yznsT6Ou+1jdVFa1nDovRJdmOi/8rVzPGoiO?=
 =?us-ascii?Q?POs1DlFzQyldlNCdtGysHdYfGYy18GvhEtM5A5YAZAGBHQw8GsLP71xAJO2C?=
 =?us-ascii?Q?3Lu7Gt7iqfpu/EfISsSZErFfQ1kCZE5xe47tf4+yogeZcJTdYeE4ylTMYcjX?=
 =?us-ascii?Q?X8imLobPeJalV/xTl0Mvz6mxSwWMN1dCBD+63vvGwT45ibkbi9Hg6f5ok11g?=
 =?us-ascii?Q?r6Fpsv7G0R2IY63xx5qqiSJedKsIQk3ecqAXKweBgPF/VGjoP2b1R8aDuA8j?=
 =?us-ascii?Q?UKytrk6NxJv1VBj2A57CA47AceIFSsln4D5tkvO/PAdsE0L7QicEj9x0ZAWo?=
 =?us-ascii?Q?+Vn7zpM4KCKn/qzFaQ7Li79F+LePVRAmQq0GTAkg8eyCgZ6ZXaeuP+z066zi?=
 =?us-ascii?Q?ppQ6RPh4AufoIJFT/49nXlaZsd0uwqgmf6sJqmsimrz5X9Jyzk2dCB+xwtqu?=
 =?us-ascii?Q?rejdQSl3ldQFSxE/bowuwLJMURSfTwwsEOzmvHygTuCRcWMpqXnOxYchxvAC?=
 =?us-ascii?Q?7kJ10akXjiaZXc9wb8HvSYB050d8jTtx4o4u8EPV8IGWuSOSBDgGKAnOFc4p?=
 =?us-ascii?Q?ZnrsjIp6ApjXgbkvx6hT1L7rdhMKJkiVNJfpA0Sy4v/mjkMJQbhwGfApx5cr?=
 =?us-ascii?Q?48EplAZyczf5vCyELputWdjId1NiI2rJDbiaB7Fzr4oTDNLAfY66zgKdoaSp?=
 =?us-ascii?Q?Ha1YLeyvsNa4+nUDrxdg7A0rqquXlqUprbiZ62ngZOFIGuK218Ib9NJfSPk8?=
 =?us-ascii?Q?GSecXW/D3ck6aCf7hE+nvydw3ThXk/5ONCm1VFR4LVRm/GgOUAf6EUupb4oe?=
 =?us-ascii?Q?1F54Tk7+uwarjZxPOiY6e1HZWtIxpx5IXs8k622VGQjBIaLD0wZt6K9urd+h?=
 =?us-ascii?Q?yhDMYHqQhcH1iYMqr6D2H41zEdJCWELxsazz7rBU4zn/E9qIagisUzo8bcVw?=
 =?us-ascii?Q?RrIsJX274LDF7U3VUhrWV0A7CS3X6CX2N2Vtv2Z9gZrcGYs7yNYVKbUplh24?=
 =?us-ascii?Q?qZsvaArbSFIrzILAZI6CnH0XK200grcGVlD4isde4yoHcF5Yel5Cp4ml4UiV?=
 =?us-ascii?Q?TwpgLiEzqargPoEMkUYgo/cRqQ91nGi2x/0atzn0u2BAZu59uDdWzGwRiii8?=
 =?us-ascii?Q?L61vmAOzINNTzVQzP4QKI0XOyGuITXYIp898IiDYMRjQNacrtd9Ar7B7vTKQ?=
 =?us-ascii?Q?9EuzATec9ySLPv0Tku8ZObhKbpiB50Ulf/JPaecPilDkaraUKdUFTiNTB+Un?=
 =?us-ascii?Q?5ZvzxMtnvKl2jc6nacm4OTjr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 21:38:48.0118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67da1e8d-02fc-4422-a2f7-08dc81ba0e28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663

Hi All,

TPH (TLP Processing Hints) is a PCIe feature that allows endpoint devices
to provide optimization hints for requests that target memory space. These
hints, in a format called steering tag (ST), are provided in the requester's
TLP headers and allow the system hardware, including the Root Complex, to
optimize the utilization of platform resources for the requests.

Upcoming AMD hardware implement a new Cache Injection feature that leverages
TPH. Cache Injection allows PCIe endpoints to inject I/O Coherent DMA writes
directly into an L2 within the CCX (core complex) closest to the CPU core
that will consume it. This technology is aimed at applications requiring high
performance and low latency, such as networking and storage applications.

This series introduces generic TPH support in Linux, allowing STs to be
retrieved from ACPI _DSM (as defined by ACPI) and used by PCIe endpoint
drivers as needed. As a demonstration, it includes an example usage in the
Broadcom BNXT driver. When running on Broadcom NICs with the appropriate
firmware, Cache Injection shows substantial memory bandwidth savings in
real-world benchmarks. This solution is vendor-neutral, as both TPH and ACPI
_DSM are industry standards.

V1->V2:
 * Rebase on top of pci.git/for-linus (6.10-rc1)
 * Address mismatched data types reported by Sparse (Sparse checking passed)
 * Add a new API, pcie_tph_intr_vec_supported(), for checking IRQ mode support
 * Skip bnxt affinity notifier registration if pcie_tph_intr_vec_supported()=false
 * Minor fixes in bnxt driver (i.e. warning messages)

Manoj Panicker (1):
  bnxt_en: Add TPH support in BNXT driver

Michael Chan (1):
  bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings

Wei Huang (8):
  PCI: Introduce PCIe TPH support framework
  PCI: Add TPH related register definition
  PCI/TPH: Implement a command line option to disable TPH
  PCI/TPH: Implement a command line option to force No ST Mode
  PCI/TPH: Introduce API functions to manage steering tags
  PCI/TPH: Retrieve steering tag from ACPI _DSM
  PCI/TPH: Add TPH documentation

 Documentation/PCI/index.rst                   |   1 +
 Documentation/PCI/tph.rst                     |  57 ++
 .../admin-guide/kernel-parameters.txt         |   2 +
 Documentation/driver-api/pci/pci.rst          |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  62 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   4 +
 drivers/pci/pci-driver.c                      |  12 +-
 drivers/pci/pci.c                             |  24 +
 drivers/pci/pci.h                             |   6 +
 drivers/pci/pcie/Kconfig                      |  10 +
 drivers/pci/pcie/Makefile                     |   1 +
 drivers/pci/pcie/tph.c                        | 582 ++++++++++++++++++
 drivers/pci/probe.c                           |   1 +
 drivers/vfio/pci/vfio_pci_config.c            |   7 +-
 include/linux/pci-tph.h                       |  78 +++
 include/linux/pci.h                           |   6 +
 include/uapi/linux/pci_regs.h                 |  35 +-
 17 files changed, 881 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/PCI/tph.rst
 create mode 100644 drivers/pci/pcie/tph.c
 create mode 100644 include/linux/pci-tph.h

-- 
2.44.0


