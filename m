Return-Path: <linux-pci+bounces-24024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF35A66FB5
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 10:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67325167FEA
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 09:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A2820764A;
	Tue, 18 Mar 2025 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ckcKt7oZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D910205E0F;
	Tue, 18 Mar 2025 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290026; cv=fail; b=HLjrDpTpZpOECPdZRbizN10Se9v4qtM4R7g036+YFx+78JM7HMJiV7Q+IL0WS5BCspL71SuY9EZUoIihxtfX4Y175oWvJ77jHJakNQlweNbKsR8EknoV9LUB3x5PK1P2/7HlntT3549yCi2gieTm6HwJWuM81jQR+kFVoL5kU2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290026; c=relaxed/simple;
	bh=f3zp18Tnp7Mz9ZOfXYwTEIUGZaGzP/25PB3R5IocrEg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A/AsMqOp22JtotGDlviQGvlpdQc5p3LRnDZ27jV2x2zLnTTdQB9npeysPqqhYSJkyPHJj/qzbv6dnd/wC/Nl5llfnm/CVFjVMtW0+RIADnuK7EmaIOmvOxJv9yP+SQzfF48QS2kujkPnYiIi7lauBPe67/0tICt+OHR181bxTfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ckcKt7oZ; arc=fail smtp.client-ip=40.107.102.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1LA0+sIbhe+coxYKDj6Z1qY0IEhXtlKx+FT8o1oxWaxFUsCVZKeUtZ3WPbk9VfoY23HMIq4DQIe1XYG9TCtcxHlRnG+JpqtsZ5ac/c4br+eib97bA85VA4GdtbEgTOqoBgUDglL3VuYl66YO3EqvPfZCmzp9p0CgQH2GhcQlhUoxqHxjmQrFxhUxo6lMDYDE/yW5kqY86V0XZEzwkUiny1iq3klP62Xh4BCgugLAx9zsx6GUFsSYVEryl87JAl+f5PRnbtiS4tqJnA9E3aLEWQ20LXOJDgtgwEKcXUQyvJnnCaFLc4c74mgu7+qIMPyYkRDWtGEv4Hmz8lfKl3fqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqCzsOzfymeZDWnPioulr+ZxMXQ6Q6i3Wi2mPwmh460=;
 b=wFG8pS07UCnS++8cYv1mkvjVNh4ap/cS5Gja3HXBjeyuDzmdxuIrUhUHU3wfuUK1MktVhWl4LQs0lGbkRIM+7zeFa2U53I99nBn7ClMyOGq89H6ZS/HO0LLgNg3b4EnAwOIR04eyiV8owvopUHzacovt27YKRvrYyCHTdgVvKv1mimkXJa8ypRA75whR9GZDQA9CBFzX7G4t26xrWMOxhFViiKWyrmaguIH0ipQ1Ph35XRgsUiB8pr7drOJZVa7stEDXaL3m7Hhxn1NsQp14dl8zHuh6rmqhi8ol40aUmSYP6t5ecOvxIYS5mgj2rvrwmnS6i3pAHUC+e8T7NwlXuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqCzsOzfymeZDWnPioulr+ZxMXQ6Q6i3Wi2mPwmh460=;
 b=ckcKt7oZGxITD9rdXQGCuaKgon+3mM3eBkRoSdBq4CrNQAHaD/m8EucVUMwSLiLITSBfY6ZEhJ5lNxLI5RNTnBAG0i/zcWX8oHCDpoEB7o4qcwXLn+hnNXEu0wsoxZvx35v/Y1w+XT4WezO6OfVkfkC0WyHw4TtNgwxLytZ+SZc=
Received: from BN0PR07CA0011.namprd07.prod.outlook.com (2603:10b6:408:141::32)
 by CY8PR12MB7413.namprd12.prod.outlook.com (2603:10b6:930:5f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 09:27:00 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:141:cafe::55) by BN0PR07CA0011.outlook.office365.com
 (2603:10b6:408:141::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 09:27:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Tue, 18 Mar 2025 09:27:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Mar
 2025 04:26:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Mar
 2025 04:26:59 -0500
Received: from xhdlc210324.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 18 Mar 2025 04:26:56 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v4 0/2] Add support for PCIe RP PERST#
Date: Tue, 18 Mar 2025 14:56:46 +0530
Message-ID: <20250318092648.2298280-1-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|CY8PR12MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b7ddff-aa37-430c-d3bd-08dd65ff0940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tP0nAYnsTqhMVhYLqAD0+A0ehamzTAORMdnJ4+/QAXdKziUIKyXOAsVP6YdN?=
 =?us-ascii?Q?uYSOKMgVkiWt9H+OLJxk3IjSqeDyQ8rbgcoFOQD+yJInvq0s8FsL+EVqQC2j?=
 =?us-ascii?Q?JZBji65tEFZJ5PjmLoO1ZvG2FB/9DBrTORR19jlLbeQQuTNBWoKogkuazeuA?=
 =?us-ascii?Q?ZHEEh26Fc/Q3BQPStIoGApm8w71Ue10cTmxJ5o/l4V/HC9kCsbBl1DOCaRQE?=
 =?us-ascii?Q?7Cx0ShaZE5t0cUnuVRnUR+wLrz866+TIpnGHupBpDJtRCf/IL66oBuIFutdB?=
 =?us-ascii?Q?AE7jiwIye7DsHk6miQbDAGfzx6RCpKpuadiH34b8Hn3zFXNv6FyFnEL1ESph?=
 =?us-ascii?Q?2+YeZFkRYDHMMTmLz8m6o32axlU9Qo2K8BCXRyAP5Z1ziZwjSGQrDK074EMS?=
 =?us-ascii?Q?4WhJ9pmi9+0KZEEui+UGnYiaCGu073K+RM6jhin3xmxvMwQ2yeaH2AYfvhzV?=
 =?us-ascii?Q?KpQCPsgjSP3mQT1e0jU8rULCh3KvpEDzgScrdQ3MZsNYL0+V3Bh9FJn5/Uz4?=
 =?us-ascii?Q?kUU4u4OHMlrRHVnLtkX4yHhSshNJ/z4Yu4i0eFh74ZmfLHmHNPr+fSSeE422?=
 =?us-ascii?Q?CbIFBkRZqW5r1cCGWWA/s/T2Q3ys5xNe95zzQYB21THgh5sWiFBXVMazElJ5?=
 =?us-ascii?Q?L+J2KVxGZkVeJtewbKFBozjgS4jdpb3wbJcrvCC7K6jyYPBtIN9CzchZEOud?=
 =?us-ascii?Q?o0dxVpxAALTujtRIC6mWKME57TVzgtW3HgOBooi3731MKLFg4EBBR2cCXClu?=
 =?us-ascii?Q?jS0/swdPxOioySIsIV3MMeBwn+gMe+RMTJzkOtxyxznp5dX0bezJvcbHCjOC?=
 =?us-ascii?Q?fST5NirpFtj6UJNklE11QtfR0UpR9YXsip8O1ZMUxRoE9dL8vPeeIE7eUen5?=
 =?us-ascii?Q?ulHiX6lEMo9R9LS5MXeNQ3kzIKcMJowwigz5/JVyuLzIvHdC5+kZdEDqtP0i?=
 =?us-ascii?Q?lxfSH3VkU2D9QXUxKVMRI3zz5z+C+v7ldntXnNDiLwJO7YMb48s3/ucB7BeL?=
 =?us-ascii?Q?ngTb3cdxT0S3WYvgI6r6rp5UFSiSytN4m46R5A+sifFjozPotwg93j9STleg?=
 =?us-ascii?Q?7n8O/VYobLfG0PjiP0Eh7KR4KHeUk7FpQboF6zq+XoiMoMJOC346K7ulp0T0?=
 =?us-ascii?Q?riy4w+VOJL/71Ge+pK3QBH+5q8c2JUll+cgbNuV4OfzD0Ii7KEPTzz3npdyI?=
 =?us-ascii?Q?Vedu8l22L14kvvcHMqEjaOcpILQkrv7aUGXlLC+ZlMxj+PI3WFwnPn8PSFNU?=
 =?us-ascii?Q?vZx9oRbPCytuijsqddwTWzxlL3pXyX/PKZqNh6zMcCew/LsmJn59K4N/ZGuc?=
 =?us-ascii?Q?OlHNlVeENfxS6Kt/GhzbeC0p+Hg4WjmvnxAPldDEFqBxFhGZ4kdqcgB3C1P7?=
 =?us-ascii?Q?StHZQRcIK1T3SCP0img4LvjTgrR2Ara0CZm6mhx5I4vvw3c4crCBzz3I1TNT?=
 =?us-ascii?Q?vVpda7rA/b3BiWc1DCWzXMBchU4rXt+U3/PDwPX1WuJ0FCYaa2D1bfzs6Kmo?=
 =?us-ascii?Q?YO+IFfDUhIsFbQ4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 09:27:00.2318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b7ddff-aa37-430c-d3bd-08dd65ff0940
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7413

Add support for PCIe Root Port PERST# signal.

Add `reset-gpios` property to the Versal CPM PCIe controller binding.
Add CPM clock and reset control register base for handling Versal CPM PCIe IP reset.

Sai Krishna Musham (2):
  dt-bindings: PCI: xilinx-cpm: Add reset-gpios for PCIe RP PERST#
  PCI: xilinx-cpm: Add support for PCIe RP PERST# signal

 .../bindings/pci/xilinx-versal-cpm.yaml       | 21 ++++--
 drivers/pci/controller/pcie-xilinx-cpm.c      | 66 ++++++++++++++++++-
 2 files changed, 81 insertions(+), 6 deletions(-)

-- 
2.44.1


