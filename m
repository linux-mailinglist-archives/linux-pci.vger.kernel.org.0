Return-Path: <linux-pci+bounces-7296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 599768C12D0
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 18:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F32C28107F
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 16:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DAB171E5A;
	Thu,  9 May 2024 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hpHQaI13"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D82F171675;
	Thu,  9 May 2024 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272073; cv=fail; b=e3VyHIgvu17kba2QMXZHmae9vkjvHpDKEiJtXlD5c2dZQTiwSF3wc26Z8D4kAM3kNSKA1ygygo1SL6z9HyCeSA6kQBbVQ19O7FdqiGPN3Jw1fAQ3ZdCw9MDTTvBq/bohmIOq5sT43zc7YGe5CCryWTMQpgbx1MoW1ZaS3dAEl/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272073; c=relaxed/simple;
	bh=g6M8nR5jpp6HQVOwZm+kMy96gKvIyflppDFeQeEwqNM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oOveqNMY2ackhMW61wI7fF/HvvoeGlCp6EBQ5nP6+TDqg00XCIpqIjkZl5xz39Uw6omqZ5ieNUFwsPiMwnGcghEUnX8Vuu7Qii0j0+sBxB2YtBee8z+YJKqwE4v6dFHi5HBlYi1uHuTYPaTd9O0r+5Hz5jmrqr1zh4pSWwMI3Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hpHQaI13; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyCj2EgL53731mNQ1OOJ0SWr9dMvLJgYsM1iCuKarzlRy9Njo/omoDxux4OeA/nK4rez/MvveWlNbdvlGwtOBL9bvw/KjVA8aKfjW+A0MKt2r5JKHmJ4eqSlX0KIQ32xO4gfD65rKgr77vnrzAhlc09TeywIg6lGvhyWxp2S8QtZzGbjyGXhO7+lupYovm3wFucBU9X1Vs5QsUpc3Fnb8iMzJHVCFenOx35WGONCkjqGwBhjsSiDbSWrN6YBk53qrOE+j64XvJadwYn3klggC9tlNiy36U5WxzkuFCCv3mWxYrf3VMeBN8ibjrKSKSAAAUCrCMniJ1dFsJiwetGGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ulu29tCwtF0oVLhiPKZCiFaml0a1Py983lIVHpudZGE=;
 b=Ci4Fgq48XL1W3VXfXqqm3KHotWU0k9RVpEK1Gyn6VPl2JOXax+3Fstp1P/UwlVVMoao7LnCSHQ/7BgUM+OdCL4bFJMCKuHZlMgLrGjpIfabpzfgSbMMb1f3a6MHBCOoH95zCFxGcxkwAJFTqTKJvGBwKs2Gw+6N9DYc83zIbNUpNHQjkYxkB/xshM2esF63O7dNMdaCUofmGnacd7bK6zafHrLjRCgItCk6CS3eoQuMJfn2YfvDwIoTYulWHBTzO1Kx96cxyeQmpe0ArHe0vvdO39gBKAlr3SZli977OzhcPHqZzAJ5Zd+wEcy/YhS5nqkn3QOEol1Mhz//MHsV4Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ulu29tCwtF0oVLhiPKZCiFaml0a1Py983lIVHpudZGE=;
 b=hpHQaI13pym1SIdbFhiomBarRLVrav4ISQjdsWtcBpmAQvIkQnNUjAhsm6f0SF5RddEwwv+uJ+lUUafQDk6ql7kcoG4HePn+o5SLwpklmgTJ2H4jkiYmK1KPOetFyvD6OTkPp1bfLW92mJaQFpiVyCWi9HaShb8qh4b/+Lbojy0=
Received: from CH2PR16CA0016.namprd16.prod.outlook.com (2603:10b6:610:50::26)
 by IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Thu, 9 May
 2024 16:27:48 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:50:cafe::78) by CH2PR16CA0016.outlook.office365.com
 (2603:10b6:610:50::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Thu, 9 May 2024 16:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Thu, 9 May 2024 16:27:48 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 11:27:47 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <bhelgaas@google.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>
Subject: [PATCH V1 0/9] PCIe TPH and cache direct injection support
Date: Thu, 9 May 2024 11:27:32 -0500
Message-ID: <20240509162741.1937586-1-wei.huang2@amd.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|IA1PR12MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2761ae-b4f5-43a9-41db-08dc7044f6e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|82310400017|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/nAGtA77da5Tw2RWfQ8EwhM8BTuBfu5yHuWuur637kL0BqAor5/aypRQDJU+?=
 =?us-ascii?Q?uCpm3pyDAsQCs55QbIMCmY+XgIdu5HiaJ13NmPxW/OUIcZoNb+hsOPKJofdR?=
 =?us-ascii?Q?kax+BDMdHKtLhtRiomOxdZXYfj0riej4CLITexpB+DwpFq5cfFRJn1ytdAMI?=
 =?us-ascii?Q?Yj8SJ879L90pV9jYoNB2KjYi2h3kCeJ9iOJoUwKSVUjL6AfLnMrzQ11HJ5bh?=
 =?us-ascii?Q?qYzpP0nlxTFpKUeDoBf98H+fX7PNzT+0pmLyfvq6t0Yt8wxHQTfVQw3sQfr+?=
 =?us-ascii?Q?LLmvgjyEYaB8Cm65hVrnIdZ6+G+pHdaTuSoDO6MukEZ4SWUDuqrsM0ni5IC4?=
 =?us-ascii?Q?9Jez1IR/Qzkbutk08XJo+QO1ScVNZfdG3vlwDyWo/zAQwC0bVj50zkiRVZct?=
 =?us-ascii?Q?LkH9mTB3RU+meOUQ6qJHwXv5bF1bdxyctpjj5jgPrgPINJzlR/CN4JgBekky?=
 =?us-ascii?Q?dmLaBwPIuKrdjxKsmIqC7uGFAvJWyY8fRxwtdUYdXA0TVofNLw3LRjhnqZDb?=
 =?us-ascii?Q?ubFzLz7HMCafWz1as4rASCtIey5SYh4M74yHIK46aeKokyW+IWLYMKWmCBgD?=
 =?us-ascii?Q?4cPkMQnkoeQVXPh/GUBLFN7J/hF2kVjJvyCg7MISg3S/2KQ0xQUV36nEtDFI?=
 =?us-ascii?Q?zjUxsHNlB0zycmlCH5+Q5EuPg24qAexoHmW3fGTKpmJKwYeghfweBnKkdaaJ?=
 =?us-ascii?Q?J/sw05IWvDNlXVgwozLQEuN/ShrG5IcfUY7e8dzZRVos7Kd2aJONxIFBSlU2?=
 =?us-ascii?Q?/D0edvf3UQvpb0e781EKT9xSrX4DPbx+Pl07+K6SqeCZvZk3LFhuuC4cy8EM?=
 =?us-ascii?Q?Id8MZ+rKyPVl2Ikwm0Mi14V3OgE8K3ELgzLs32lbvWNY5zpL0vRoXaOKrZ57?=
 =?us-ascii?Q?cirDl3BczhVVrcGYir5iYT99fEK25tnLaBetUU6bwFLr1FI57Sv4lv523fUz?=
 =?us-ascii?Q?ThXJvZ/3dJKp5YMnXpGZtZH7F3CtaTGt0fgoVM77LHtvBM6TcjbCyYhXA9Wn?=
 =?us-ascii?Q?J9cziAFZO3Gh1MivfaQEBqthRXHJ3Vqk+i5GmJ0FfQ91VCvzJeS33aULk738?=
 =?us-ascii?Q?8EnVmpi/NUCBTfQ/xuqnOXOpJv9AhfrPkiIpMNTfDEuzzaJPUlbNSJ5L5cNr?=
 =?us-ascii?Q?b7GDId63fIL1AEPvADasH2/foljjteyEESjM03w8RrI4NxQeUfPI3Fz3KiKj?=
 =?us-ascii?Q?z4nCARG4hmJsDEKlkTovdMFlG8AJU1lIIhv38yW8L4nk3snG48BAk4Cmzcsf?=
 =?us-ascii?Q?fqLsFIPuiSuhA0dQ5DUPCW/iCZb5hWE0yw/3CZibgw9klKf15FSGrhr7UeWe?=
 =?us-ascii?Q?t0Q0ZO6hCBqDwMyG/abz/rCDyuK7MvqM0cEaLtSgCCANJm/KbCSTY99eu3Z8?=
 =?us-ascii?Q?7NQOKkxmR9Tuj0T/wonDh1lVut/2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(7416005)(82310400017)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 16:27:48.1646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2761ae-b4f5-43a9-41db-08dc7044f6e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663

Hi All,

TPH (TLP Processing Hints) is a PCIe feature that allows endpoint devices
to provide optimization hints for requests that target memory space. These
hints, in a format called steering tag (ST), are provided in the requester's
TLP headers and allow the system hardware, including the Root Complex, to
optimize the utilization of platform resources for the requests.

Upcoming AMD hardware implement a new Cache Injection feature that leverages
TPH. Cache Injection allows PCIe endpoints to inject I/O Coherent DMA writes
directly into an L2 within the CCX (core complex) closest to the CPU core
that will consume it. The technology is targeted at applications whose
performance is sensitive to the latency of inbound writes as seen by a CPU
core. The applications include networking and storage applications.

This series implements generic TPH support in Linux. It allows STs to be
retrieved from ACPI _DSM (defined by ACPI) and used by PCIe end-point
drivers as needed. As a demo, it includes an usage example in Broadcom BNXT
driver. When running on Broadcom NICs with proper firmware, Cache Injection
shows substantial memory bandwidth saving using real-world benchmarks.

Manoj Panicker (1):
  bnxt_en: Add TPH support in BNXT driver

Michael Chan (1):
  bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings

Wei Huang (7):
  PCI: Introduce PCIe TPH support framework
  PCI: Add TPH related register definition
  PCI/TPH: Implement a command line option to disable TPH
  PCI/TPH: Implement a command line option to force No ST Mode
  PCI/TPH: Introduce API functions to get/set steering tags
  PCI/TPH: Retrieve steering tag from ACPI _DSM
  PCI/TPH: Add TPH documentation

 Documentation/PCI/index.rst                   |   1 +
 Documentation/PCI/tph.rst                     |  57 ++
 .../admin-guide/kernel-parameters.txt         |   2 +
 Documentation/driver-api/pci/pci.rst          |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  59 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   4 +
 drivers/pci/pci-driver.c                      |  12 +-
 drivers/pci/pci.c                             |  24 +
 drivers/pci/pci.h                             |   6 +
 drivers/pci/pcie/Kconfig                      |  10 +
 drivers/pci/pcie/Makefile                     |   1 +
 drivers/pci/pcie/tph.c                        | 563 ++++++++++++++++++
 drivers/pci/probe.c                           |   1 +
 drivers/vfio/pci/vfio_pci_config.c            |   7 +-
 include/linux/pci-tph.h                       |  75 +++
 include/linux/pci.h                           |   6 +
 include/uapi/linux/pci_regs.h                 |  35 +-
 17 files changed, 856 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/PCI/tph.rst
 create mode 100644 drivers/pci/pcie/tph.c
 create mode 100644 include/linux/pci-tph.h

-- 
2.44.0


