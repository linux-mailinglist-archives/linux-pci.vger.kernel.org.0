Return-Path: <linux-pci+bounces-21147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD7DA3058D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 09:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE0E97A2DFE
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 08:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3321EE021;
	Tue, 11 Feb 2025 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vo9mL2cX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805CE1EE002;
	Tue, 11 Feb 2025 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261856; cv=fail; b=D8bz6qXwhkX4AkEWv7sUcZNf01lhd3M1mYU95J7YYsDzK9BHGOSETUY8D0SQoxg8hozIuZ2SdRawljVaeUcgdx+OE5Rm8M01b+FLR6ERl/UfxOxlRjlWd+a6yD2AteQhL2qZLpgj00fnc9SChh8jYd5+LYNKWGxxetwnAIBpBvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261856; c=relaxed/simple;
	bh=63GXouE8AImSG2HJ/VALUjm4BPm5WhT4qvjajGumnuE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lljvUe8FumK/2kaYkmrWoIc2Iw4QE1b7UW433ttmL4MK3AG05sPQvZt5vfQvI0z0yQdr8kuYm5AKLlrSjw/LmvyhPQY/BLES0o4bSeQy5QOTcvo0wZtwF8vpJ26+LTfgvWil5NKX32BOfcuoMLXHKsBPzybVLxnKFE0bCFkHI5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vo9mL2cX; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8VMRUYL9jMAhyqltgTwL4/i+A5GCIqoPZK/3Ykcsb9UE4AdWe+pJneJK0l+xakhbmD+3jF/Fr10D7F179g+LbmHCCN6YlNqfu6d0xzLJZIjC3mydRkowVyoiOZ5LW1mtrdd/DZibp2cXr5ocER8O1pumecrf1jKfoTtiYa1lTW/cUhQnkXv+h1C3QVrQpKBEHCkS7igcV0rj7Cwe4rUEkfKa35FnN7ozINqZuMmVWuk7PU35YRwZbirIyk+Tju4CLGFsRdqqMdL9/HIM8ml8SBxrDTYN3p64Radvbl8q1/vv1cd9QrV/7pTrJWFT1j4bym10dSPuofNDRp8svUOOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQ6erO71IM0BotEKCYe7kDqXI7og67JOuE2ov+Aoz70=;
 b=Hul9ZLLIcvOQJbjYgnpYDxZ2XhRebdi90kwU35EpvO2Kef3mlHdJ15NUDjNoWQp9ZqMwU/aJv4sJrz05RUJAahLLkQldk3WWlBg8ptcjwSxtF/8QFtTHZRdeKeLnem/b37xPOcLUHGCydSvz52cyozGYOqFh3RfiaWaU7G+oRZ/53lVOV4DRQ+zk0uXOS/kXZm1YhIm4tOYxveQwEj6misPSMnIUj2Ra1M51NDzKG8Zk0QFBaX4Ckynj/io3CLZCRXiPRjs+5AXQP1GEDNETLb6SU99fdCZyetmrqdYa1BrbffTrxzolb+hq3uwWMeU6ZM0CqHdgU26R/0FGV78aYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQ6erO71IM0BotEKCYe7kDqXI7og67JOuE2ov+Aoz70=;
 b=vo9mL2cXiQiOSlls4qNkZ1kB8aelZFfaAd685e5HtOfGtKOp9w3UqRcEugUfctWg2pR4hcBhZ4bIsJutwdrpShYvAWPMskzw1hV2e0vGuBr6c+XTse7ZycscADsNTq8JBp6T+QYvCZoI/iqM9UJNmkMEh/EB66IicEmu4JDLTDs=
Received: from SJ0PR05CA0175.namprd05.prod.outlook.com (2603:10b6:a03:339::30)
 by DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 08:17:31 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::9e) by SJ0PR05CA0175.outlook.office365.com
 (2603:10b6:a03:339::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.10 via Frontend Transport; Tue,
 11 Feb 2025 08:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 08:17:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 02:17:30 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 02:17:29 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 11 Feb 2025 02:17:26 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH 0/2] Add support for Versal Net CPM5N Root Port controller
Date: Tue, 11 Feb 2025 13:47:22 +0530
Message-ID: <20250211081724.320279-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|DS7PR12MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f886acc-b828-43b3-c77a-08dd4a74878b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RQOytg8HiuqV2+tghKvJe+e1xWzUApLyykWE5mxVR9QC4S8Wh4cSaH/NJtGX?=
 =?us-ascii?Q?GOTdbb6J7s2NoHriUykhTiLLFLNgvOSa5JtQj5MeYHNMv94PHuu28L9Dqk0s?=
 =?us-ascii?Q?/QjcZiYd3zWTln7SJllXneniXeHVAdlAQIySVAwbu2ePOCLzy/B0T814O+3x?=
 =?us-ascii?Q?fkCHo2z0ixQ/ZykQpgK08wTIOvsJpdKjC2wnfzrlRSkO9N2rPyn/ej5MYjH9?=
 =?us-ascii?Q?fVckIuTXHSNucAySAZZp+Xq6691tCFP2/Sc1FLn544amQyBtgKgLOcHWQ8GU?=
 =?us-ascii?Q?7G/CfSpJAa+VxgASjcgOwWYJAk7FMGtZhOOlgW86snvyfJ/MG5T1r9APTfli?=
 =?us-ascii?Q?uDMANM7hh2qjZZ6jjT2ot3IGwmkbwOKAS66zdG0L6Y5Xddt65Xd92hdPdsVc?=
 =?us-ascii?Q?Mtt/MwV6xcUTi18B9t48RxIiINAw/gCkNJsmsol1hpGsDzRCAKLN3cfht6SV?=
 =?us-ascii?Q?VnNcVGVuLwDdJxrdKZlTGRK7Tv6qBeZjj0kGoBpEeaeS9pweCWT9oiCrE4B8?=
 =?us-ascii?Q?vD3gh86UcFDW6oERjMXjMqVNnLhZOgbWCvsHgvsk/C8s0BWQK+C9Mi7+TPyy?=
 =?us-ascii?Q?L4xTM+gKkNrMeOpw8DYaskl4k8gR8eTV5ihF1JlHOrMa3ZvP+uCTw1u0P5IU?=
 =?us-ascii?Q?V53ol7AKZRwIihMd3U4ckwMRF3k9cQGJOvKJibqSojQiTCcqNEux85AoTT7j?=
 =?us-ascii?Q?zWWt4wuISvS/rpLW+NlPYzjQzqNtGLJyF1Q4u7f2bJXTSbXNC+VmStAJdJIY?=
 =?us-ascii?Q?pfMiakrG9yBOrM45DtdsGPUImFTkmeroKXFdidsTlzvHOZ0pf8w4SpTDtTtN?=
 =?us-ascii?Q?B3ogI2KnINyB/8Wl22lmv2Gmv2lNutiCkW63K0bGziYgnncDLgbk829EX1Vw?=
 =?us-ascii?Q?I7iKBv4Z8HDz6L2LLxPg1gpyI/mZYhPJgULv5VqZGFxRGjcCq4w07dXmPMxE?=
 =?us-ascii?Q?lq3pvoppW0wFPixmwXvA7uy7KsqEHHCKog/Qno9z4x76eaM3G947hWspbcY/?=
 =?us-ascii?Q?KkcSgWa2Cpo0XpTgNVFxKJTLI3x1CPMhaVsksSeD1OyjxxMRZEoBLlZ7NhQS?=
 =?us-ascii?Q?NIitnoQ7lL6lPcYmd15LyZjqL0ACRmYKiGra/W0pdCnzmZB5dyL2nhKkpLCf?=
 =?us-ascii?Q?2XT0+gz0ddrOe5C4gxS3YUuGBmJ3WpEFb8Jcgpb+QuDen4qqw1okO8PW6Pua?=
 =?us-ascii?Q?Kh10nWZeWHEkmmisXK5+fPyrweu6ZtsI+eop62lFBs715JdSPivB4nwlICTi?=
 =?us-ascii?Q?wY8NM+UzC08VZa4fGtl+KqthCWkAQkuWFGylPlEOTCaS3yXjhyKFbt+jne19?=
 =?us-ascii?Q?SuinTNEZXjrehwFRbaJntpiKzniRhb8TdjjnEceW5uCu8Ku47qAQlE4GWwIG?=
 =?us-ascii?Q?p38WpBGyhXTis6GhYDx/FGbYvCmBm5oXdvUFPMHZKb6jIP4dwX5pAUNQwI6V?=
 =?us-ascii?Q?uR8LUB1EIRZTtDQdW3uldHrFPr3dMBaF2JIh5pFV9MpnAiZSIgQW0NY83AZy?=
 =?us-ascii?Q?uaN2Sc80KXuAeHk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 08:17:30.5662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f886acc-b828-43b3-c77a-08dd4a74878b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8371

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


