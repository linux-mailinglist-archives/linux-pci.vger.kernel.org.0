Return-Path: <linux-pci+bounces-40825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60684C4BB09
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 07:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D9FE4E7656
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 06:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707732D978B;
	Tue, 11 Nov 2025 06:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2TLQw/WR"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97092D878D;
	Tue, 11 Nov 2025 06:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762843133; cv=fail; b=ac6PyeI92AgQwEjwzbs1NEKK2zk2wNc2MMkE/M06oox2UDt9kiTIxKzxXtPrb2m/7N7rNBoAg19rL3JKTc9XdoTxARcRXyuAyrhgaMoazi6VtdE05tZYeZUhJCiV1Kn5j4lQxJ7FIcSMsKvkD7FhbJjy7V6yb1jGBaW3IAGgKCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762843133; c=relaxed/simple;
	bh=qOCW5qmGvY5JhE+3ToHl+690wxL074OecmpFkTywc7E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A6CIc4N2kqowWw5saStzCaG6HM1PDZMp03hdGFVx1axWFqc1fCYVs4R4nIFCMxKYte0gpxiEg5gaPSmFYuIF4xygqu0MYcKS/YAiuEzI623utw3+okF0EQGt07dvlvuje/7TdB7fd60yRQbkvBm53Tnc17wQISkKMy7FazMQgec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2TLQw/WR; arc=fail smtp.client-ip=52.101.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cV0UuvR5W5ZkxczZ/MrEFl5ATVoFtxtFwGqzdsBR2sENGDR4Ool4yrQ6WpyhzacyYGfTqnK8p73kDE094eweffiEPYr/TorDKSfej7qndH+8lnwXWkj9KHRBaFshLMtf28hedC9/NVpo+qqQ6HLdfDNB/f4JO1FePjRB/B4D6NseqMdN3szWKpCNkuDxl9vqFYjQomEaVXefllOXGiM8394X9lelRKYXXvvJDhqQuyZ+L/+2fOZ8Ay+dUPf+M4HcyzLSjUMZgssAK/pc8cn/epkQP/gp8WXXXjhjWP+KrpfS+qTZ/unvUs5skOINV1RRevOQH/9YgJSYKL0B3nmOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMXZd/qYl7pQZCZWhzVZ9/2gt11G61p9zoPIb7u6PM4=;
 b=mUdOI0FxGsCYK4dXGNfY/rFVAtZuWcVjNLex2xPn0bUkoc73rQGJZnZwcpSvWKQNqQUTKNixzgSARzd1/YLnOuXwxJs7pzDF8gxyvHyntjrTOi7AMevp8A0Zq5I4WKh8TCgzYz6jOM+tXt7+EHs1aiZSrYQr4szEjT0bAmH+xiwDKPpprAAxA485arGdNKmEC2/qhYL9/sWt13G0ZaZGY0qcCx3EaCFfdrJ7DUf5N0EHtYfuSOCJlxNskYcZrnr1ZKTcED0lg8/oFw5b82+8QXDM7wnGdY1+zs6pe0V60GGLVM5caHqOrYPzFbMsVNuTWVKzNH3bdpdlnYeTNSqGvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMXZd/qYl7pQZCZWhzVZ9/2gt11G61p9zoPIb7u6PM4=;
 b=2TLQw/WRpbPVz+fpVSqgoc/RJ26UJGDH3MgBLBZLc4MKRcN9SoHquvdCLY77xMt2zZsUfFOgKiTrOEqXqo4n1Y8X4QQMCgtuWNKVX9OB+9jajSyA06M+wqp0QbGFwe6FwiQjNUXKQ/3etmdEjbf2nxQZuBSX8DX8gRiJjxY+uWM=
Received: from CH2PR03CA0002.namprd03.prod.outlook.com (2603:10b6:610:59::12)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 06:38:46 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::bd) by CH2PR03CA0002.outlook.office365.com
 (2603:10b6:610:59::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 06:38:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 06:38:45 +0000
Received: from aiemdee.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 22:38:34 -0800
From: Alexey Kardashevskiy <aik@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-crypto@vger.kernel.org>, <linux-pci@vger.kernel.org>, Tom Lendacky
	<thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
	Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Dan Williams
	<dan.j.williams@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Eric Biggers
	<ebiggers@google.com>, Brijesh Singh <brijesh.singh@amd.com>, Gary R Hook
	<gary.hook@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Kim Phillips
	<kim.phillips@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, "Michael Roth" <michael.roth@amd.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Xu Yilun <yilun.xu@linux.intel.com>, Gao
 Shiyuan <gaoshiyuan@baidu.com>, "Sean Christopherson" <seanjc@google.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Dionna Glaze <dionnaglaze@google.com>,
	<iommu@lists.linux.dev>, <linux-coco@lists.linux.dev>, Alexey Kardashevskiy
	<aik@amd.com>
Subject: [PATCH kernel 0/6] PCI/TSM: Enabling core infrastructure on AMD SEV TIO
Date: Tue, 11 Nov 2025 17:38:12 +1100
Message-ID: <20251111063819.4098701-1-aik@amd.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e690b8-ca99-4bd5-d4c0-08de20ecf6d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A+5YUZFwiISY6RyGNxHoJfQlFmxYJ0nZNfJ5zuY0elAfJtYi+qEm6rKHQM2F?=
 =?us-ascii?Q?H8kAuV2rgHDLrQHhtSOFlLxM0mzu+zQX0LurV4jZk/W3vQNIplueYSpXi5Hr?=
 =?us-ascii?Q?GqY8Y49HrEUocuqPo7+z85sYy1/Rbba/EqJSG9zvORdtWYyQVl0Hn+WPGcE8?=
 =?us-ascii?Q?LbO9oXMFNN0n3t5Vy4JWOVKcH9CD6RCEmGad5AX1vA0nzSPmUZ0TT0NWWEHu?=
 =?us-ascii?Q?n468g1juhd3PEsuUX+L0mzWgqajmhL9X52GsCYczqieIjFeNYq6RcZzKadh8?=
 =?us-ascii?Q?AMMxDvtx0nm73puymKPRUN23XQ/o1aHSyX7wsImplVz77c6lnofqN/ev+tk6?=
 =?us-ascii?Q?43plyVwxCZcfPtM+zwSy4Uu+pcMNZvG+jUzyDpzvpIetQJk/UGeWEKijj1Lr?=
 =?us-ascii?Q?37xc4bRS3lmiYNmbng15vBhTKMMBHVLoIq3cDrFsrZaXLP7zjREaZ1pCreBS?=
 =?us-ascii?Q?DgQefeBpWkcKq+epB6hwyRNfZWkhK+eY14z7mNzsvWJyrktQ3juHdA70DGtH?=
 =?us-ascii?Q?UTN3417ZwouCnib8e3nDo60IUOXjFt6PPoT63sS8TysbElpVXlNUxRphHC/n?=
 =?us-ascii?Q?8gDqcR28S/k+351Xf16Tw+HjAaPmdtMM+XV0zTmCL291MkULjM15E7li3SSb?=
 =?us-ascii?Q?7IZ9afyDIKwx6fOUbnUJy2BC81qj0BpaHJgNS1Zn4XTKZOIMFWlYSqB2kXg4?=
 =?us-ascii?Q?yxumWtlwO8LWt47OsSNajd3/6/3F/PsAAkZam8nx1n0Xdjx2mGyIbmWSmCp5?=
 =?us-ascii?Q?76wxRhzu+eUulq8CuUdpj8lb5mBdTcD154X3cqK105bnjsurLO4zuQ9zXt4o?=
 =?us-ascii?Q?txcghM0uCfgf9b05CEkhNTI2w8tvx/bZRFLzCff931qJZ/ItG0DbJ8LXyz0y?=
 =?us-ascii?Q?wT09ZkdBSts5z1uxloLp+SYAIQKnivLujvPn0JaifMCEkyBtfxDcH0dwra/J?=
 =?us-ascii?Q?CoyiokjxcbMO021mt1yXZAzEZwVu1+YbpcR/mF/61ioEwzt9++OG9KrFYuru?=
 =?us-ascii?Q?FaIqdIIbuXAmdb+ID+MHp2ndPqcuX+9amwci+YBKfsK2z5WU6o1N32KqxyGB?=
 =?us-ascii?Q?5AQmOefdanf5J2eYtrxxrxUXXaGpcQrxTx3sN8qmxPDEOlIORWvIbI5GkLQA?=
 =?us-ascii?Q?JzU3otM3ZqOws1bYY32ovQ5xdDPv54weqcJ5qEeBjEBTe+pFQ8vdSW9KbMte?=
 =?us-ascii?Q?IYICSrS8LqWveAi6TvFqEBxiSz56Yk4eL3NOqv64CSdvI5e1uyKjixGk7LDZ?=
 =?us-ascii?Q?sWGzZf/2wVLJaXIzb3P3AYlxskK3GHNTM+L5qMC5duQ78I1ZOgPtTRVlSMWa?=
 =?us-ascii?Q?K1EduOpX9oTyUPL1v0loFBR9YkSjPOGQ1VQ4S4mkR6ast4+mkJprjkg6ksZH?=
 =?us-ascii?Q?0UUcG4xxrHZclI2FazmMzfmqFiUN3nf2/fQBwVpXm0XsJbyrZihEiCtFuHF1?=
 =?us-ascii?Q?GzfWat5tTKDH+EYEBCJDLhpf3UQBbey6vEQV3nHhuc7Ib7D6fiyY+ogktNe3?=
 =?us-ascii?Q?2Ho5dKI7y2YMJI3iz/4VwqtomADRIMVveZJw49IXrbY4NuISlvqXVYNhVtNH?=
 =?us-ascii?Q?2S8svhyr7xz5GQYvRUgDeailXHdOCRZSpZ7fJs3n?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:38:45.8102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e690b8-ca99-4bd5-d4c0-08de20ecf6d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105

Here are some patches to begin enabling SEV-TIO on AMD.

SEV-TIO allows guests to establish trust in a device that supports TEE
Device Interface Security Protocol (TDISP, defined in PCIe r6.0+) and
then interact with the device via private memory.

In order to streamline upstreaming process, a common TSM infrastructure
is being developed in collaboration with Intel+ARM+RiscV. There is
Documentation/driver-api/pci/tsm.rst with proposed phases:
1. IDE: encrypt PCI, host only
2. TDISP: lock + accept flow, host and guest, interface report
3. Enable secure MMIO + DMA: IOMMUFD, KVM changes
4. Device attestation: certificates, measurements

This is phase1 == IDE only.

SEV TIO spec:
https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58271.pdf

Acronyms:
TEE - Trusted Execution Environments, a concept of managing trust between the host and devices
TSM - TEE Security Manager (TSM), an entity which ensures security on the host
PSP - AMD platform secure processor (also "ASP", "AMD-SP"), acts as TSM on AMD.
SEV TIO - the TIO protocol implemented by the PSP and used by the host
GHCB - guest/host communication block - a protocol for guest-to-host communication via a shared page
TDISP - TEE Device Interface Security Protocol (PCIe).


Flow:
- Boot host OS, load CCP which registers itself as a TSM
- PCI TSM creates sysfs nodes under "tsm" subdirectory in for all TDISP-capable devices
- Enable IDE via "echo tsm0 > /sys/bus/pci/devices/0000:e1:00.0/tsm/connect"
- observe "secure" in stream states in "lspci" for the rootport and endpoint


This is pushed out to
https://github.com/AMDESE/linux-kvm/commits/tsm-staging


The previous conversation is here:
https://lore.kernel.org/r/20250218111017.491719-1-aik@amd.com

This is based on sha1
6fdb0d839738 Dan Williams "PCI/TSM: Documentation: Add Maturity Map".

Please comment. Thanks.



Alexey Kardashevskiy (6):
  PCI/TSM: Add secure SPDM DOE mailbox
  ccp: Make snp_reclaim_pages and __sev_do_cmd_locked public
  psp-sev: Assign numbers to all status codes and add new
  iommu/amd: Report SEV-TIO support
  crypto: ccp: Enable SEV-TIO feature in the PSP when supported
  crypto/ccp: Implement SEV-TIO PCIe IDE (phase1)

 drivers/crypto/ccp/Kconfig          |   1 +
 drivers/crypto/ccp/Makefile         |   8 +
 drivers/crypto/ccp/sev-dev-tio.h    | 141 +++
 drivers/crypto/ccp/sev-dev.h        |   8 +
 drivers/iommu/amd/amd_iommu_types.h |   1 +
 include/linux/amd-iommu.h           |   2 +
 include/linux/pci-tsm.h             |  14 +
 include/linux/psp-sev.h             |  22 +-
 include/uapi/linux/psp-sev.h        |  66 +-
 drivers/crypto/ccp/sev-dev-tio.c    | 989 ++++++++++++++++++++
 drivers/crypto/ccp/sev-dev-tsm.c    | 435 +++++++++
 drivers/crypto/ccp/sev-dev.c        |  69 +-
 drivers/iommu/amd/init.c            |   9 +
 drivers/pci/tsm.c                   |   4 +
 14 files changed, 1733 insertions(+), 36 deletions(-)
 create mode 100644 drivers/crypto/ccp/sev-dev-tio.h
 create mode 100644 drivers/crypto/ccp/sev-dev-tio.c
 create mode 100644 drivers/crypto/ccp/sev-dev-tsm.c

-- 
2.51.0


