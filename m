Return-Path: <linux-pci+bounces-22230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7EFA42710
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 16:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DCE53A8E7B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 15:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F34F261386;
	Mon, 24 Feb 2025 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="By2E8A8q"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C89156F44;
	Mon, 24 Feb 2025 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412243; cv=fail; b=ZZNYhyGD7JTu+2XemtFhbRYJURbe7KrOF6woSxj1+nJsaU9c8ytxo8VYFF546DDeAFV+jDEUiCnlVh5JpUqPAuxBa4Jy1JZ/wpjO85srhMdKO8CdRo0/HNRpNuUVHMrVYfodeU4tOYuAIlgD6YuBPW3GPGR52pzLrtKawzBF2VY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412243; c=relaxed/simple;
	bh=YuaqAC024s4cW+CYJkFeg8/igmczIBJZELtgKUeFtgE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DS7yu5dK2H7nHEweh+mJJZxA/wUhVvNUINztW5MNgN+nSqEXehREeYk/hwZmSUYl/TWHhPMx5okphkDxMmYfu2iWIsnpoFP2VA/Qx8WsY5HS8vE/I4daiRiQvm+faHd8GCbnviXHWrQabCNkkeHmTZ3l1hIzT7in8List01BJyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=By2E8A8q; arc=fail smtp.client-ip=40.107.95.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bebqjdVAOSne6OZdZVV2J6hk/T14gW/FEduKQv8WMfOMmLAMe5KHO490isfhewBoEKPDXiEQAgpxe/BYMbANTn2RMm5Jt3tL4G0dSGfRg5NHL/pwgbjLEOt+J+x9+LH1z/gnJIV+gM+ETOh5vPtYy+f3uLbPI1cRPClJVN6r2vs373Q6Elbasa3cc8LPY8s+IvWxMDCl2uIPdlUKD0J8IhVz2r5/T0qPHH0wB5Kkl0PnefSmIeKEhJfaQqW1vL9ZCCD9B8t5JmkEeCdvaU0XWoUwiAVMsirFokveU/q92tIOYOtlsPM9s92XyOWJKSy4Rym4n92pqRbaxTQWVbT0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiTQgyrIUbk8KmC0fqbZmUAXxg13wxaLNn3sG0etunA=;
 b=mHrxQE9Iv7AByTx8AGB2Oz3zBC4H6ScYi22WizqjqIAwBU33SRZH/XHR7qZwBLRm0HUTRNQb99CCR+3R+221Q8KbSzXsiGbv6zXZ9IlN0p5aF6RZxq7gh1BApswkW6V0zmVmStflFHcDklN0dKWHALWUbv/Id29dL2O1CXKt7GL5lCECFSN3CIlAqvCkyAjMEfQq8O3w4VQyczfVppxywHV1JZotFgq5Y+a9O/mNBUbCexO6gnbnZFqZIMz120LF7zAz9jVF6o+c2O8ms/m8zQcP1Qbuke6jtG3CRX6Dcm5QS/G8ADXiR0n4bGasc03DKAdIZPC00JpecSiJiiIy7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiTQgyrIUbk8KmC0fqbZmUAXxg13wxaLNn3sG0etunA=;
 b=By2E8A8qY7+qOeCRsIc5UHCz2vrtinU0mGO8y3/lzEod76aoNMjArm1gK6gsErXaFn2L8u8QxqZk/52yG3NHoB+toBDoILPertatueO8FSf4wBJZgmhm8QursbiAo4CK8s9nBOThOu+PGQMsZrsp+s16OWB8H4fVvDL+zUViik8=
Received: from MW4PR04CA0244.namprd04.prod.outlook.com (2603:10b6:303:88::9)
 by DS0PR12MB8020.namprd12.prod.outlook.com (2603:10b6:8:14f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 15:50:32 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::15) by MW4PR04CA0244.outlook.office365.com
 (2603:10b6:303:88::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Mon,
 24 Feb 2025 15:50:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 15:50:31 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 09:50:30 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Feb 2025 09:50:27 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v5 0/3] Add support for Versal Net CPM5N Root Port controller
Date: Mon, 24 Feb 2025 21:20:21 +0530
Message-ID: <20250224155025.782179-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|DS0PR12MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 43bb7e4b-9770-4381-e93c-08dd54eaf818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oDiueU1soCt0F5hRLK0JzsvEMRuB+TQY9zw8FneunhLPbrEku1c+oAt8nt9n?=
 =?us-ascii?Q?r4I4RS8YqTsWJpEcDioa2H8jMBEqSZJFxGP4JamaSNZKuZfRe2kqBj1bM+xd?=
 =?us-ascii?Q?GTKlGJMTWW/iA6RllFyPY0L2ZfhA4FAwTbZVLRhBD4nyvDfHWU8lz5uaxejy?=
 =?us-ascii?Q?IWUiGZohpW5ajF3CTd+KVdaL6gHEHZVrslC8hsXwhFH3B5ZEl3tsBFVtFOb2?=
 =?us-ascii?Q?P3SbxezM4SJwV1d8YeGCXSng1w14jWdL+Dd1eZ9vv9IkiVztx1g6lmaiKz/M?=
 =?us-ascii?Q?0adTFS7If0+KXKU+fmju8w0ZyjUs8kFtpRr5Zk+dUeCfKyW9ZRRZxE11IvaK?=
 =?us-ascii?Q?JNmmlTyzQPEnWd+bHlHbASBHus23Nqt7VesaQjdniCWyLIXGmS9cdBUQOmg/?=
 =?us-ascii?Q?Pe8kE9vtAlFWH/x4w95hyX+f7WPglDycgJWk4WKtU20NNd3tMEcRHgw1cseu?=
 =?us-ascii?Q?0yUFFBbuQx4Kn/I4Ib1arxpFIeHOWpfjuPhsBla1qEEfzzoBkI2jkhQwtZjs?=
 =?us-ascii?Q?5oqJTyZ10O39qsKlakCT2neyfLVNu5Sy4PK1m0psGKsmSfy2unW6WXjOLrAJ?=
 =?us-ascii?Q?w0rUguK4CefaNCpBwOZ8uw8KnXZRQLAj55hgNJDnG6g6rOB7MqbZ1HRSFbCN?=
 =?us-ascii?Q?YtoywjXyBbqtJooTW2REQ0lEZ95BlspJlGE9Awyd8TgSQxo92y22io8bcG5B?=
 =?us-ascii?Q?FumLADhDL79yVMK8Q79OidBBXMRnMmaQ0StY7tc2lObZ5rnFKZgsFhu2BqK4?=
 =?us-ascii?Q?gP+S93aoPDG4S2vCauRAIMEepZ+XRDZdeDJAgzmuRs5Gh5HXQwXM8PaHOkWr?=
 =?us-ascii?Q?zQa4dDCrA5kld8Si7FMY8mi2UXUbU4de95pi/3MjSKYGDDZHuFpLwr6pdHLW?=
 =?us-ascii?Q?OAS/OrmB36MyhfPIEfsdz6l5Z6DodaMAC2AZc1MvXNUHk/1ffQPJNwLKgRoi?=
 =?us-ascii?Q?lv7yPhW7BKmD+0RW5TnGov6NMvgWEuFvX3Z4r3ZrW6wXPMacb9Ctn9hfpNLi?=
 =?us-ascii?Q?5iR8iqtAvwr0TlGpjpKWPDGVMMY0g795/YV7s04sxd/oAZq8Paz2G2iqKUcS?=
 =?us-ascii?Q?0ohCKP9rZyvfGVmnxSIHVbPuadnJpXQtghJMSrulBywFiMZOnoGOP6+Dw+Gz?=
 =?us-ascii?Q?cGBlgx6OOYbMkZWARAXTNqSA9Lq2qL1zX3/Aj9ilqEHr6j0vJszeF6wJXXDz?=
 =?us-ascii?Q?v6SiKhyz3iaIHAQLCxfIkjnbiImfwfLNuMgAA8IAYGaYyQHNpM/w/1Pzqty1?=
 =?us-ascii?Q?AmK2lGJ0svcf2pRNKtg1VI/1r62uoY84cbnfMMcFlH2PA1HP7yXulUUi3DKL?=
 =?us-ascii?Q?a40rk1EwSbEC/QLggX9EQk5SvgJyYw53XXwx8/0DM7gyQ7+XOpFNUAFgu80O?=
 =?us-ascii?Q?4xEC6TWJibt77PfH6Wo9D1vNd6luM7CJWNrI2Gc6f/wqQVHRPM6ScDDwJY63?=
 =?us-ascii?Q?2VSewzu5kH7UCH2fYBwbtJnHkrTjBpF2DZQPWsNBOOLn3pKgPyQrQtHEQuvt?=
 =?us-ascii?Q?PzaWvVzzfMvmSEY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 15:50:31.6222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bb7e4b-9770-4381-e93c-08dd54eaf818
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8020

Add support for Versal Net CPM5NC Root Port controller 0.

The Versal-Net ACAP devices include CCIX-PCIe Module (CPM). The integrated
block for CPM5NC along with the integrated bridge can function as PCIe Root
Port.

Bridge error in Versal-Net CPM5NC are handled using Versal-Net CPM5N
specific interrupt line & there is no support for legacy interrupts.

Thippeswamy Havalige (3):
  PCI: xilinx-cpm: Fix IRQ domain leak in error path of probe.
  dt-bindings: PCI: xilinx-cpm: Add compatible string for CPM5NC Versal
    Net host
  PCI: xilinx-cpm: Add support for Versal Net CPM5NC Root Port
    controller

 .../bindings/pci/xilinx-versal-cpm.yaml       |  1 +
 drivers/pci/controller/pcie-xilinx-cpm.c      | 44 ++++++++++++++-----
 2 files changed, 33 insertions(+), 12 deletions(-)

-- 
2.43.0


