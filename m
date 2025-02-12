Return-Path: <linux-pci+bounces-21272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85271A31E3B
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 06:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204043A8C44
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 05:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D71D1F8EF7;
	Wed, 12 Feb 2025 05:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sLtQnIB9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD803271834;
	Wed, 12 Feb 2025 05:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339472; cv=fail; b=bHTIxu9x/iO2U0Zra3xwc9zPN2rd5wmbtx/DnBPQwYrqDMq7EpeQgFLwskbLJcCwLTo3/cF1d6HgVqsTdL+OQXxevza0+vsEecaNnRzTmnCItk18hFH3Uq6RadgVZdtAjcBZ8uDcfOZEtpQKjwFqCmKJjp3cLSg3NhKRN4TsdSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339472; c=relaxed/simple;
	bh=63GXouE8AImSG2HJ/VALUjm4BPm5WhT4qvjajGumnuE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LOSY8ldDO0BkxMPIprDX4zguhorWQLZ0iiU2i0wApeR6NtZ7+eZT8GefTSkB0RwcDTRPdLAL4Akxvm+euL6VNolZLTugThsfZg1UUyPnMZ3e2CdA++jpEf22JnpqPgRT+zxn7+gCZSQC+YGbSmO5bKE5ECehCeRBgimChOYWsmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sLtQnIB9; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRdKz0jcyEQx36yP20jTOip4VPHR6MwtgmqNnGdKQqA7NdtyIMrQi3ki01Cv2ib5zkfQU8pfw5E3zWFTJaomE8mZGGonJmSWyit5Di5dNbNfRpEQnvRWQIT22+3WyJw5frD08VCnPVP3Qot0VMiKSPZh6KThGradiPFCLDRc/zsWsyTETetmj81SC8a1DB6/DtJY15571CHCkU9pxVNNpGuIQLNxF3Wc/iZgmWQL516xXhn66JWNLjyqwHht9ZiM+MV9Sj2a6RwdGAzyJBU34AsA+HFO0xH7G5i8UJ63FO6UXjp9faOYfIU1KiB+t3RX9xRKflK5i/3VeOG3q8DD0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQ6erO71IM0BotEKCYe7kDqXI7og67JOuE2ov+Aoz70=;
 b=t/vl0qcEGxR9AdAx5a9qQgt0Vcme9R+IOtZNuo7dXktZPAFKE4fJUgMPxcy4vfoIBSn4J51YKVvZ/PdZd3L9JG4ywAqUL7PDgiw+rdD5YR45lkH/yHjTuj5rpE+PmMYg5beeTtLZvSon7HnMUZ+tFAjFVjLganIDnPynOkHeoTwrDxrA2IrZXdg1YdwYM1BFPmvYOQMX/4+TGcjlmrKO4PXZFVXcLQAj8m+y3KKbIDY+UxvZ+NcM8ASi7O+DwKzjidk/gMl/8GZMzcsf//H2onS89Z529OIrHSlX4T1YVE6rk5qd5ZVBnpqGX9YDhj8NV+xMIsrOPkTYbgT2XFYLKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQ6erO71IM0BotEKCYe7kDqXI7og67JOuE2ov+Aoz70=;
 b=sLtQnIB90Pa3Z9u+fneTul2t50poZo6Gfzpo4tTHHRxwdlClVZNMsrlnjr1zdDKPf03veYnUvdJ9ifF3nNsSOpD4OwQ4I5QXevoipMaWHJC/lhEAfbKPw6Ns2NOjdsnAAIGrMXY7fpv21Emyq0uejTPJYVlL7z6LXlvYU8dBSMA=
Received: from CH0PR03CA0251.namprd03.prod.outlook.com (2603:10b6:610:e5::16)
 by MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 05:51:07 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::24) by CH0PR03CA0251.outlook.office365.com
 (2603:10b6:610:e5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 05:51:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 05:51:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 23:51:06 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 23:51:06 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 11 Feb 2025 23:51:02 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v2 0/2] Add support for Versal Net CPM5N Root Port controller
Date: Wed, 12 Feb 2025 11:20:57 +0530
Message-ID: <20250212055059.346452-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|MN0PR12MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dcf425b-192a-4f3e-5dcc-08dd4b293eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o16Wprt4Mm0NXuw5bGBntpw0MAfoQeobKrFP8KtZX6hQolTBpNb7HHWsQyF3?=
 =?us-ascii?Q?7WtGabwcZpwaFfYioe2r3ArOLt2x+ZaHClYbqu3gv1i0t6WTJ2HL5wp+ugWR?=
 =?us-ascii?Q?qomibYhzMt0Qp92rUSF5ZJZTAM5GmYcj//L0kIGN3xNaCNUByNLMnP92Tys7?=
 =?us-ascii?Q?lCDKEUimMAGg8ZLYwlY8ur5w+blsJ2HwZhBlFkto+POEDyP96Gkg+8Uz8Vhp?=
 =?us-ascii?Q?kqXwyFF7nhPadRDmjRZply3wDCKYedzguCQuf3xEBqx4OeLXp7r+uaBX+7kh?=
 =?us-ascii?Q?xoqHqCOcsbHDnJK9jLVGlDuxg4lo2TKI/0b07wiXMrO+voJXXBaVc3PoeNAJ?=
 =?us-ascii?Q?bIMMGT94S8HcWSmPf1G59JCsIOOyEnfS8T1KxcJo5FMjly/DbCQCejRt25sd?=
 =?us-ascii?Q?T3R418ucDC5QM/dmgl/TL7VlkkZL6mQ+2r3hxXk3yRAVz1ssD6AMsdzRKggZ?=
 =?us-ascii?Q?zpEzflGcwuuxZKnTQXaJPlGL6x+y68lgUcSQgTnYI8/c1b4xqxF9zgvwIdwF?=
 =?us-ascii?Q?EQt5+HM9yM4JAFvnumTPN3xShDubsOyjg1ccgo7J60PiPeuKC5kSrdYP7Qql?=
 =?us-ascii?Q?D1HkV/1YdVhoMsIOWUPkEOZK07KKqb3rxTeitlWVT72SrbHjpwALj2D7iMyw?=
 =?us-ascii?Q?hjJrbIEnu/E67SVZ9DDaEEsb5iN91A2DN0zybIcO+BEs4qSzFBa1uWGi2Mhg?=
 =?us-ascii?Q?4zTpIJt/lWN6eLBvg/U6+RtR1bbzsa3QEotc3XDJgCkEOg2oyDy+Ywikoek4?=
 =?us-ascii?Q?Gd2jdXckTq6NyTNH1CN/YQneiJIE+iXjVX5aSDSwjGJ2mB7GuZLh+dHE++Wc?=
 =?us-ascii?Q?QsJYqe2J4yFu2CKdJVAGXdXhM2uqWuhIjwH5YPitr4Kb+OTe+90zlhML7RwL?=
 =?us-ascii?Q?bXm8mBaLgImp+1AVpuurGRWoLr1cagMMqfyhP+ovnEtqHqUAzAqk7RjEZYVJ?=
 =?us-ascii?Q?7TR0IBlPJRKNN1y57W5WvvRO9RCQ/lZElARsWUoaPAILPHBeTFzQC8w+Wglt?=
 =?us-ascii?Q?emd30vlkS+OLOw5dzFvt+/6g/EbJvRkIxwfAZC1HUhVdHNYOsPQJu8FedoA8?=
 =?us-ascii?Q?bOEGWL/OccImytpiZmLAmkOeuOEuWSi+JsrPIXsb58bJxkfFDcO2MVhi91zY?=
 =?us-ascii?Q?ABq/eDvmweGaZ63ZavdZ8GgX+hZIzQ6cC7yP3dYrd8nmGNvEi4cdcCDYslNR?=
 =?us-ascii?Q?zOr3ELxoGIoa+ZgS7QWy3BvAFC8iuz8I415rv6ikNb5MhncJHRrYnxw8qGdD?=
 =?us-ascii?Q?jhjZPzKD1yMYjNSJNxqAIMkLmI52sMD8qDXZTZmVgKZOV7lzOFk+npaBouj1?=
 =?us-ascii?Q?hui3gpV454E6wHfQmlQra1Fyi9Oe0BxedtONdmugOR2gM81lO1JI+234bQWg?=
 =?us-ascii?Q?UvrSPltaDcqWcAuT69GzKN/Ihn2tBfHUnnXDNDLbOWEaPM0l/wicKOfeoBZg?=
 =?us-ascii?Q?cUNcWtWh9QANtif2O2nyLgyXwBexOTiJrv6BTogusyYUx6HbH3UYxWOMNsgw?=
 =?us-ascii?Q?h6EOyOx2lPGnY90=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 05:51:07.2701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcf425b-192a-4f3e-5dcc-08dd4b293eab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5716

Add support for Versal Net CPM5NC Root Port controller 0.

The Versal-Net ACAP devices include CCIX-PCIe Module (CPM). The integrated
block for CPM5NC along with the integrated bridge can function as PCIe Root
Port.

Bridge error in Versal-Net CPM5NC are handled using Versal-Net CPM5N
specific interrupt line & there is no support for legacy interrupts.

Thippeswamy Havalige (2):
  dt-bindings: PCI: xilinx-cpm: Add compatible string for CPM5NC Versal
    Net host
  PCI: xilinx-cpm: Add support for Versal Net CPM5NC Root Port
    controller

 .../bindings/pci/xilinx-versal-cpm.yaml       |  1 +
 drivers/pci/controller/pcie-xilinx-cpm.c      | 85 +++++++++++--------
 2 files changed, 52 insertions(+), 34 deletions(-)

-- 
2.43.0


