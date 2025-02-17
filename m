Return-Path: <linux-pci+bounces-21647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 772FDA389E1
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 17:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3DD7167D67
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 16:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E500227BB4;
	Mon, 17 Feb 2025 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jK4f+tpU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6073227B82;
	Mon, 17 Feb 2025 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810525; cv=fail; b=P1LWEUPKQxPCwerjqxokg2G+kM+kNg+If4D6FYAo6VxdH4wmLfcgatfJ0wBc0Hzhlkm9FTNJPRwWhb6xtNz2gw4g5k4L+Ls/+7H52ZWr4mPLhZVM290JH9i1WQE1f5vpeuvqZdrnYkngOFR84QbAqmIXcYvPJ2Z2Agjo4l8Iqjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810525; c=relaxed/simple;
	bh=SlHA42N8vicuBD0LsTxSAFmTG3EZwu+qT6RkjjaZ2x4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mS6u/4wFJMtkgJlisZrPTDffwJ8BWvEXWcQ349Vel1eMKVTs4oTptTqAce1B0MBvZGI8eBCXRMF6hSdfVdMV0+X7l8hYcwQ1bplwuvmHLGoTQDwZmifsYZZCyPAtmuWtmwtg/5tPhQdJlyd34yawfcWH10ohm33jhhMbLEotiBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jK4f+tpU; arc=fail smtp.client-ip=40.107.95.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gu/9v4q9U8XhgbGNXrMgnaf3bMcttJ0/o1ALds9nxrMWh7rBUj5uuYG+ULmXc8S5ICPniKINBh5bv7AQd04PTjBO7fU5EbnSN4wPmC3TPPke1YQBT3NIrk7HXMadP/Y+p40gB4RebvCeMhT2HZfUUPaCjbxlZB/NfS0yaMkLKedqdZjemBt9EEHq3EIWRIQrG2eYtOUAV972VpLWVfAAVLcZLHwqDZPxtTw51PEPstOtdQVxcuLYvLHpfvKa+98CeQKbmo7vjeZFZFeImrkvTEyVTfLaPInWu4BpVZrehMTQVvIZYe3pBadDSke8LBneRD72EqRNZ2IqXMGrn46RCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xST5M7eWYTybAdc12g9e0aNkTCugsa/UJlxUFutlZ0M=;
 b=hKOH2T2vRQh8ubNNkdMfY2D4Xn485RVVX3F8LNvOrlXdDf00OeZU8fK4PwxwJqQMm2RhkoaN8YG4ol0MYhyvLX614flwx69/1xoGds64tfuHHp91FWFhtNR+RjlAp1iaMvRMy/AnY0R0/zOTYGRYdK84SPqa+Qeof+ouzM1oVYtl1jNiaX7hTpPFzTj8pEjuPUXUL8bcUQqxoZvs+rDQu5HXDuQuitRINrKo2zXU94ZIRO8eZWxqguqbzlHQFdaJdXcupDF54ViRKtYcs8zR3Qj72qyesgWcuxuAwaXmKT/9HyXP6TT/WGLM4/57HJyrFT/cDjdLf21DKpocPLYMbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xST5M7eWYTybAdc12g9e0aNkTCugsa/UJlxUFutlZ0M=;
 b=jK4f+tpULd/SAzgbBBVvc9AjKwIkCGWQQTS191X6uIukUvpwwtSuqahRRjLaK6YiIsOAKNUrQqNRHe5lQld4iRJVLHZoDL+wuWNrs0WqK147UP9Mg2g+E/87Z53Nj3OBYrA7TtCYALoPx6CRvGn5m1yM0XhZbRG2121sGTFiAto=
Received: from BYAPR07CA0095.namprd07.prod.outlook.com (2603:10b6:a03:12b::36)
 by PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Mon, 17 Feb
 2025 16:41:59 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:12b:cafe::26) by BYAPR07CA0095.outlook.office365.com
 (2603:10b6:a03:12b::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Mon,
 17 Feb 2025 16:41:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 16:41:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Feb
 2025 10:41:59 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Feb
 2025 10:41:58 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Feb 2025 10:41:55 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <jingoohan1@gmail.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v11 0/3] Add support for AMD MDB IP as Root Port
Date: Mon, 17 Feb 2025 22:11:46 +0530
Message-ID: <20250217164149.678927-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 07804741-308a-4afe-e565-08dd4f71ffbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N7MqcXCbrPrNFE7nNe+YaUoo/g9hUR/gqrgIhwsL0JIxAs6pExiQTMbe1nOs?=
 =?us-ascii?Q?jZlzDskDMc59QJvvp4O7rMgwntNvuTi1PdYX8pr2KBVb2evrlg2njRtUPERz?=
 =?us-ascii?Q?qAUtp2SUAuzcdSos1gWPSkXru2KMkPbaERg3vMgPQY3vgDt3jo6b7KdTwyOp?=
 =?us-ascii?Q?7bnkk4bnYrCpQUthoN3F5KuFkM2UWvKKxPIUk4LvBQs530FdVyxV9n8Mlz2L?=
 =?us-ascii?Q?bKd/nXOHt3LvDW2UrQbLprMkuFVQXNND2tGgg02/Y3roccLjdyrGbnP9bjrr?=
 =?us-ascii?Q?uozBccAuOKCYXvzMTes3INLx4TDuK23ouIAdOHbzw5GIvcgquvuDcxGnH9B6?=
 =?us-ascii?Q?5JpJ41Q2A/8d7B44Sx0T+yP+O65HuiBe9/iQteehh7EGd2nghYXaiAlpWqif?=
 =?us-ascii?Q?xar5CXNr1c9X+9FW3Uqm6V6cqt9++WrqL65iGkZz1mLJ0yEj8GeOh5kxQNZd?=
 =?us-ascii?Q?zGkIlvLV8PZqvX8PcSXv3/uJ2gjsqvTyxQ8LsHMMd/JW0tpK48ZjUv2izpNw?=
 =?us-ascii?Q?0MkTpRleDzOponFbRbkKkwnLcSlgQNDP2KNEL85szGHv4i1HPwq4LSNXAaiy?=
 =?us-ascii?Q?cFCsNn56Rpo+AnNP9b9dcWu854JlDPvQOCWDiKaElhZ5tfuKOGxRKGDuMUqG?=
 =?us-ascii?Q?qJ5hz+W+hWNTYVqMLnvURStydAP0KabBAC53WZZdCEvNHJPMkxYIKfXadcPV?=
 =?us-ascii?Q?hrXIT/fRXkpUEmhCNkXFBquf4+dMSSBhxy6CarC3NnRjyv7eDA7k+7hKxmnl?=
 =?us-ascii?Q?uS0IFaLxUG9HBOq6LHOneN6CsE8AHW2C1i1hWeQ0/qeujwgea+9tE02wu+oM?=
 =?us-ascii?Q?mmj9u/UUUvuKhwchTcWFtLzdzGLLc2hbN6Kx+KGOfQHrOzqS9052chrdUmxi?=
 =?us-ascii?Q?qldslqHbzw+fXeXxFIOAMCdLo5ompNvGqoKWzLGRAk1pDiM5ptk4s9jh27NC?=
 =?us-ascii?Q?eIbqQbTH8/S2K4qPVCR42zPx6ZqGk01Zxe0G5CPGERsqIaUXlyJqJ2xz6Ma6?=
 =?us-ascii?Q?NnWmX5VN4ZbpsdtzJGR0L+E8oGGc9S/0JqxBNUKpfMd6lZeP23y8ajjxZnE2?=
 =?us-ascii?Q?S0DeS4r9Xa1X8Br2zNK/G5jzDkY+0WVpz7TEgCsMrE7LJ7wWHYIpibl5xDYB?=
 =?us-ascii?Q?wL7am8WX75IyPqDSw+kQD8rHY0VwgGwRMallBQesLDO5GodlOdEnyIULjjIP?=
 =?us-ascii?Q?z9q4W44+4RL14mQYZXrlT3EzZQ+Uiwq8XQEIutIOq4TnND6SoOGHsl4AQMue?=
 =?us-ascii?Q?1jR+L78EiJxLBE2Ak+p+DBNnG8tu76wZ3N/UOte+b08eitusGAwynW3fY9dZ?=
 =?us-ascii?Q?Ok3H9ijrrW/kFOXGFc8EL/9qvM4cntZbkjoz4oHSh1BQIi0N0SKk1sLD7LRr?=
 =?us-ascii?Q?q0LpkR3IeoAV1peeXLS/Z7hUZmMtytOUQgSeUJDYjH0HdmJk4mEdnEIXJLh2?=
 =?us-ascii?Q?Hm2e+8oFsxXeDU7AIRv7Ci3rnqwThmHDlgDjfSWUKqmyWfzvZu8X6httpwpb?=
 =?us-ascii?Q?pQ2mECEQBEoKjBc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 16:41:59.5449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07804741-308a-4afe-e565-08dd4f71ffbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012

This series of patch add support for AMD MDB IP as Root Port.

The AMD MDB IP support's 32 bit and 64bit BAR's at Gen5 speed.
As Root Port it supports MSI and legacy interrupts.

Thippeswamy Havalige (3):
  dt-bindings: PCI: dwc: Add AMD Versal2 mdb slcr support
  dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
  PCI: amd-mdb: Add AMD MDB Root Port driver

 .../bindings/pci/amd,versal2-mdb-host.yaml    | 121 +++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +
 drivers/pci/controller/dwc/Kconfig            |  11 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 474 ++++++++++++++++++
 5 files changed, 609 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c

-- 
2.43.0


