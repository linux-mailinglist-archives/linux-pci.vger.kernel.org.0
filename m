Return-Path: <linux-pci+bounces-10462-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAE3934365
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 22:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FEF6282921
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 20:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EAB1849CF;
	Wed, 17 Jul 2024 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3P/iCMEA"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E43D24205;
	Wed, 17 Jul 2024 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721249725; cv=fail; b=KHUxgtygcp2w3xxLp5S7EKykiMmksqZ6isMOULScaboOE7cBNN+VeR7r7GaYuRSs5V/75w32gM8NYRMcUv2RG+zrPDXAfIsOcxYFdUABPVZdZXQJ3sbfDOz3UhBZNpmBFgbIuGn6y8KGbo/UtrcmyhMYDQzgnj6g0jlv/kzpCKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721249725; c=relaxed/simple;
	bh=AryFSUHqX9RU+hU4h8HORXhf1ce89m7g1yoc59JqK+w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QVvCZYAEzw9nO51rDiyIxBnu1vSwW2zNBUDVG4V+2sakfmMHyHeSl0C+AppP0UhzZVaP7s8rea1mU8gIeHe7sqcFnTvWgrDkFGyFnKW6xyzkgZv1sQQgWo0ungwjMLqT8i/k1opcYlod5rq4eArl80/PhkI20FHZ76aZPLVpAko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3P/iCMEA; arc=fail smtp.client-ip=40.107.96.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkbUetksdZDf1SnvpUN3mAVWBvLxTIbRXDMYNddX9y3OgSiojLtlXfHv3sO6oSQvLW04VXuPBbvylmzGtjQZBqPf8VsgNxJr4HgTs2tfgAShgJaHo1RtcNKwi1dom4Wmf24+GNwRed/86xqfWuuxrcvvXmQUht1x/HpCDQ8t5GK/rmG3tovv2DMcLqJzcpFgcn2hJ2BrMPaxeO1Up4+pmVFr8lCrsBu4JgVv/00eWYV7roDWfEE98AM6FepGvuUaIqZYyJnkg8l5S6LAuTh68p92V0O4u0ltpWZehEAt3YfYQ5tENz/etS5t3cHZlm6d2hqaGdtgS5qK7cW2FwiXKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptY3iz/SRdcYrROG7Q9Za6gbXt0fXG74XO37aohEZZY=;
 b=dAK8H8RBPeVcAwVcXCE9Ev9fKCjQlCWRsbEIN/SFiJEnwxASanQx84KRSFtQDEG6FrJ1wlGHoSb/v0+P8//0NjxejwltRyYlbe+98yLuu070vmETur6cx2bSFjKxHGwaG6Axb9gNSoIv5aG5o2t1oUENUvP7tBo82N2xOJv1/hVUZ9pZIyt4E903osNRN9Q15pGS0tGR2S4JGjOwJ63hvltTY2JjHiAmdYPAof79Pf9B48oKWUh+dpMozBEIfNePFAzkmtgJuqdqhukcJUu2/xTjMQGTi2mh0A5QqgdkLyNZntLNhnxUhFVT2N0l072wPJFWGI7QzTzd/vGk/rpHug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptY3iz/SRdcYrROG7Q9Za6gbXt0fXG74XO37aohEZZY=;
 b=3P/iCMEAwA8NDZBlhK8ITarQgxCY1325XTrB+U/XUIt4YazG2Pn5t+zSzJ9wCNV0F4bNUutUlShe7W+l++0aQuUQm5g3+WPpYX9p68ujaJQgpNTaS4UqZFaG6u5LAWqk8Y+OpfdVVGPQB44oqdYFuQUOgPXfQ8gR/kdZIOz09gM=
Received: from DS7P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::24) by
 SJ2PR12MB8805.namprd12.prod.outlook.com (2603:10b6:a03:4d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 17 Jul
 2024 20:55:20 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::60) by DS7P222CA0007.outlook.office365.com
 (2603:10b6:8:2e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Wed, 17 Jul 2024 20:55:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 20:55:20 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:55:17 -0500
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
	<bhelgaas@google.com>
Subject: [PATCH V3 00/10] PCIe TPH and cache direct injection support
Date: Wed, 17 Jul 2024 15:55:01 -0500
Message-ID: <20240717205511.2541693-1-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SJ2PR12MB8805:EE_
X-MS-Office365-Filtering-Correlation-Id: 437752b0-a835-4b32-376c-08dca6a2c544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aHKe33DFSNjjmIJAHQV21kNg+Yda1lMs3K6WH4YN5/aCNCp2d1kVSbYhmtqZ?=
 =?us-ascii?Q?vQD7yWJAgC5u7mrHywMox56ldrFrbXDvhzg2m1zs7NTbHDxHxCGSSPWzyqdj?=
 =?us-ascii?Q?9OTRyXG8TYP0qCe25sGfVcRz0WXaHoKBVxgEWRQwxINCZ+LS+zJwi3+5KzGs?=
 =?us-ascii?Q?7Zgm7ARzQBIllwq1f/T131j3UsGX72XHH4Jc0CfrRwAMN4XKPABT7juq8BUW?=
 =?us-ascii?Q?cAB0iFizvz/VdYPy2BoYsPtdCMi6mvBhFXu4fkLy9lyGLV2g2SbEkdKZlweu?=
 =?us-ascii?Q?GgmLvGzvq5lxLIoCpXQjf3487OBDYsp02sDtKlAv+pLL++eem+2qJGpLKeXN?=
 =?us-ascii?Q?e40wxoIBumEPEzp1NNOr1pjF6/Gp2d4mBj14mSFmefWctxQJBoGoiSiIoiUX?=
 =?us-ascii?Q?pFPMFYTrnghWwHVdniBtmfSzY64VSI3WzZwIQi4DDHBx15DSQB7OnGujD2/B?=
 =?us-ascii?Q?NCKpgIcTr9uIIRPJ4UVTlwwvZ51xq3h5AEuJoiI8ZFnN0bgcs9WtNWaVZEYb?=
 =?us-ascii?Q?mIdgmUH3047svwawDRCBJteWe2Xo2afJbi8gbf+d45zIWmjVJ29gsnhFxeDD?=
 =?us-ascii?Q?HgHoTnHhuXHFX6UJ7BPXu3cMKPI0/FfA+/P8qd9d71J24AHkU2GSmogNCYP5?=
 =?us-ascii?Q?JpIkSUSvIt/TPsytfWf4FmW19BhHxqH0C8s9Eh3xuEdX0A5TZK1S06M8BArc?=
 =?us-ascii?Q?W4eGrBjwOlkUeGoNldmsa2r9oGj79pwtIY5NzDdJRKZppQa4BYKIOUmzA4CC?=
 =?us-ascii?Q?/IsW82wyC4UdIz1LPz9EuMhKx8XrrJJdeMWPil0DZLuuzQTQXlCjw/tNmvI/?=
 =?us-ascii?Q?oWVTsTpgGr6tw8EK+CfPe0hChiZm9K5erjqjR8+W9RuBoL1hI5aaoJ1UnOxR?=
 =?us-ascii?Q?wpi6Pe737HG4F5kjhYr4S5DLaMNxNlSMq7Zu0Ozba//fAh3kWfUXzJ1NTZRY?=
 =?us-ascii?Q?ihVs1U5ijyg70uEzccMZ6WoD7qA9h4BlqaVsgfFhn6jD71r8K6wBG3CSsW3Y?=
 =?us-ascii?Q?+OPhY0EaTPMfEQAgvLn5mrjLX7gTLvWrMmJH4nFEQ7k31igrHaB5wR15S+Mv?=
 =?us-ascii?Q?Td2SPDeZ0yM8UjzaVmgMCRwZZr1QcjHxjzP9WRsAxXmAeJMfvKMQJWnfJQTe?=
 =?us-ascii?Q?VIk+S4/rONslbRlZVwKAl/h9eGAWi6OpY16ggLm7d8HPbGaMvDybQiFDvFi7?=
 =?us-ascii?Q?J2tnFEdxTb68icVL88cyr81u+MCIW1wT68P5avB7pAEfaUE3t7zstKQUeeHp?=
 =?us-ascii?Q?MaJHvz6oWYZa583Z/XsIM+ZFw2kPsYl7/jB3P6bLnv1P+AOjMoi5bel5S20G?=
 =?us-ascii?Q?cUydWQSfXdnvxN0omhw7Ek3KgZ5961JMKDcmXP4biolvPlma6nkoDyHiXCUa?=
 =?us-ascii?Q?Q3Lg+aA2HAXnyO59YbblTCYKqgA8y0be2BsEF4gekuQPRrSncw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:55:20.3012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 437752b0-a835-4b32-376c-08dca6a2c544
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8805

Hi All,

TPH (TLP Processing Hints) is a PCIe feature that allows endpoint devices to
provide optimization hints for requests that target memory space. These hints,
in a format called steering tag (ST), are provided in the requester's TLP
headers and allow the system hardware, including the Root Complex, to
optimize the utilization of platform resources for the requests.

Upcoming AMD hardware implement a new Cache Injection feature that leverages
TPH. Cache Injection allows PCIe endpoints to inject I/O Coherent DMA writes
directly into an L2 within the CCX (core complex) closest to the CPU core that
will consume it. This technology is aimed at applications requiring high
performance and low latency, such as networking and storage applications.

This series introduces generic TPH support in Linux, allowing STs to be
retrieved from ACPI _DSM (as defined by ACPI) and used by PCIe endpoint
drivers as needed. As a demonstration, it includes an example usage in the
Broadcom BNXT driver. When running on Broadcom NICs with the appropriate
firmware, Cache Injection shows substantial memory bandwidth savings and
better network bandwidth using real-world benchmarks. This solution is
vendor-neutral, as both TPH and ACPI _DSM are industry standards.

V2->V3:
 * Rebase on top of pci/next tree (tag: pci-v6.11-changes)
 * Redefine PCI TPH registers (pci_regs.h) without breaking uapi
 * Fix commit subjects/messages for kernel options (Jonathan and Bjorn)
 * Break API functions into three individual patches for easy review
 * Rewrite lots of code in tph.c/tph.h based on feedback (Jonathan and Bjorn)

V1->V2:
 * Rebase on top of pci.git/for-linus (6.10-rc1)
 * Address mismatched data types reported by Sparse (Sparse check passed)
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
  PCI/TPH: Add pci=notph to prevent use of TPH
  PCI/TPH: Add pci=nostmode to force No ST Mode
  PCI/TPH: Introduce API to check interrupt vector mode support
  PCI/TPH: Introduce API to retrieve TPH steering tags from ACPI
  PCI/TPH: Introduce API to update TPH steering tags in PCIe devices
  PCI/TPH: Add TPH documentation

 Documentation/PCI/index.rst                   |   1 +
 Documentation/PCI/tph.rst                     |  57 +++
 .../admin-guide/kernel-parameters.txt         |   2 +
 Documentation/driver-api/pci/pci.rst          |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  62 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   4 +
 drivers/pci/pci-driver.c                      |  12 +-
 drivers/pci/pci.c                             |  24 +
 drivers/pci/pci.h                             |   6 +
 drivers/pci/pcie/Kconfig                      |  11 +
 drivers/pci/pcie/Makefile                     |   1 +
 drivers/pci/pcie/tph.c                        | 443 ++++++++++++++++++
 drivers/pci/probe.c                           |   1 +
 include/linux/pci-tph.h                       |  42 ++
 include/linux/pci.h                           |   6 +
 include/uapi/linux/pci_regs.h                 |  28 +-
 16 files changed, 696 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/PCI/tph.rst
 create mode 100644 drivers/pci/pcie/tph.c
 create mode 100644 include/linux/pci-tph.h

-- 
2.45.1


