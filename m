Return-Path: <linux-pci+bounces-17412-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7017F9DA742
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 12:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07619164061
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 11:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841071F9ED2;
	Wed, 27 Nov 2024 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sWTtqOQ5"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4291F8105;
	Wed, 27 Nov 2024 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732708711; cv=fail; b=E3aNFZw5SQQXBECqBvqPskBcWn54Zwe5M2X74WpywTw8cXCQzxc6iispFfEqpLtEoSEPqxsOpL31dDQpj9rNA6WTimxzOGhBQ0XtYKSK0Y/iBVWL63wYY5D8t8oj/SlFatvI6kBsvQ0oJ7dz98A+d7sp1tw3glf2Cz8PKZRXOK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732708711; c=relaxed/simple;
	bh=r3OdT55bNiqhbQaMgB8x6NNUVF5DOvVG/x2otruycss=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=egC8DBNL4okclb7nJarAb1XhF+/CFqjm+0ZRTSHpPHtemITSs3Ixy3PLH/Q1pV+3IgqhcL1fLxSbD7WvpH0viuY5qAYfVY1ZLnbLWXtutGa1/J18BV5jtX6RQHJr13L1KHVhi9NnTrp8a5a3n/en2F5PdHzeojs8wrFzdoA/6gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sWTtqOQ5; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYxW2iP88wWiZZWgfPJt+u+Jfz/rxUK/+Yjd8O1qU+ItCSrJ9Lt66KJnu15AX5nRDYsZhMsEtIo38/t0lMHDretkA72Fg72FNsF06iHMRfL/7uoEFL82fhaQiMCbXGje2QnrBjH3wQ2qQ54JaAk0IaIIaG5Tt/avgUS6XZdrcnNUFX74o7Dbf4tL9nkpk3IlXdL2PJTM0g2EGmqCPKFoxOojkPw+tk3Y2dj8ZqyeJ6or5yUTkNV0trNGWH2FIRCrc+rc5bREWneb+nNERlbmDbo1HOesp+JYOf/q5Atlkz6vpAXLnLroZF63+JDJAbBZOljuiBff7V8fUbPW+l/6rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0umGPM5kh0QPMnt2CBTEHVN0Bv+KoWF75+YLWey6tME=;
 b=yxVAo4lMpfuqyGuDjW+eJecx1bwhRnLVemBUmeFehjMWr1c+0tbA1sYIgpVe7nZvkxNAXVxKBNaQ6kJUR0NMi3DP6/RCl8UJ1cCcwLkEDG27ahkm46N8deKIU27fT2Emll5Wsaf907qPJdPAswN/MdkD+oo7sLiZI7vA7mzKH9OYFFq2CYJ72X9eImAhyXUoQwWGoFsxEHXe3Cn1wLiulo8IDI2fLO9Ig073ggHLfC7975tvfVVKVpPO1sKS9UTi1SNm/T/nD77rnIbuwGuO6IhyotYtFwOrCjmwbvh2pIIzQWc+O6kjZwpbOJzC2HF3DEn5j46QnZSnCxQkYjdjPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0umGPM5kh0QPMnt2CBTEHVN0Bv+KoWF75+YLWey6tME=;
 b=sWTtqOQ5F8t9uxta5BWddONSS20FNoh34UOP9qftcO11VFpFxKRHIRdG92cbzl0FBJVDYxm5Zj0pbsY4LDdcbGSGfRjdQhIYiBhzOcx57PVT4W3h0gJTrzhCfFl5Wxj1Yptbt6pi+SYdEql/pj5mHEvT0Lf6FFVZqp51ZljvPN0=
Received: from BYAPR01CA0070.prod.exchangelabs.com (2603:10b6:a03:94::47) by
 PH7PR12MB6585.namprd12.prod.outlook.com (2603:10b6:510:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 11:58:26 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:94:cafe::38) by BYAPR01CA0070.outlook.office365.com
 (2603:10b6:a03:94::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.22 via Frontend Transport; Wed,
 27 Nov 2024 11:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Wed, 27 Nov 2024 11:58:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Nov
 2024 05:58:25 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 27 Nov 2024 05:58:21 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH 0/2] Add support for AMD MDB IP as Root Port
Date: Wed, 27 Nov 2024 17:28:02 +0530
Message-ID: <20241127115804.2046576-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|PH7PR12MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c6c6cf-93c8-4e56-f508-08dd0edacd15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kBuDHIJMMeiYIm4QZNBEVY1dR8vNowJCQQLJm7Ws41XR8zXWP2IYpasjVpL9?=
 =?us-ascii?Q?JN3dZYxrxH6r+AcbPc4fyL1gdrCM7EIGd4ryEnkPe5PGlfPr69fMzHNfW57B?=
 =?us-ascii?Q?VC6pkNRC2xVDXnLKm5zrWQKdvdq/eyA20Pb95Kvtfi1R2jddfCf8IG9PeSJX?=
 =?us-ascii?Q?0u4S0bZSPEP/ANeo+kuDc8JFGFW5uF0juRfrnFNjf6foqEzeqErVUcz39lsn?=
 =?us-ascii?Q?PK8qrc9Vm93ZelL4WdpvPt9nqKLIuwnfW/CEYl8FSl5e5Vvel/TvWbfenAPT?=
 =?us-ascii?Q?DGgcW8zEJn2pt90qpJq04GiRw5XTx1nT5PrukeM0tpKZh17q6aBgwIbxltkk?=
 =?us-ascii?Q?MrJSPrOs26ZA7nmjeAsCYzgzhuw5ZM650/cE++2upzg/b2M7FAHk64na7LnA?=
 =?us-ascii?Q?EA/fvGwewTDUujKYuZSUjz+j4McNcrGFRi/VYMPhJsXrJjvgBdigYbX0q8UU?=
 =?us-ascii?Q?AwY/F7YGRXAZtj0UVFXbb1Ort6lmWYGd3QaqA6alETPTy5bjLTqodR5gNFK0?=
 =?us-ascii?Q?t/9y9XCFQOmbeDhs+Hl8X4bPVOgRYdDkdiCbERkTmHxpfsRdPpYnGIU3UACE?=
 =?us-ascii?Q?MxMOXaWs0C9CS3JAVUcitZkhScEgEkf6vpgTPsp+EyLCtipXxZ7A6XtHx1CK?=
 =?us-ascii?Q?ll2YkAqssZVLBVwNrd/oILNEBgUhjEdxh3leJ2giNsHdnrnCc5DfK67rnSUn?=
 =?us-ascii?Q?M6Z1fnCK9nRUG7x5v5hY72HwK4z1E7D+zDW2yKNUuaWkoJ7IBJVKr+hKgogj?=
 =?us-ascii?Q?RarqRrgdsl7oH/9wkBSHW4xvdoDnpnONk2NZIu9W/2Mwz4rHDQ7gpszM4TB9?=
 =?us-ascii?Q?yebNyIse1Pqwvt2uO4B/iwA0pLICorW8bQKfRpBy+y6FCLRyEVALzdHs9lhF?=
 =?us-ascii?Q?9z87yL+MjE3tOEmBSy/PomiZN3wplTwrZxgKpRdJ1tETwQ9B5WCsD/Rx2phB?=
 =?us-ascii?Q?72ZDNrs+AMeGIvCiVE7mW1MzzoLFAmsXhz5Ifio3xwFWLo3iOHY6yemesynw?=
 =?us-ascii?Q?rbLnXxpWNhLjeQY+DB2bMb5rblyLcB7RrF/3Z9QSo7O7bDat5qC2xW5D62iG?=
 =?us-ascii?Q?vR2U0orDRq85UIm1fLLlycTD09eKS9P5YWODFfY3+H3qgoxukDQUdl3vmlXD?=
 =?us-ascii?Q?FB7H+I1xZulP3cK7eLKP4vl+wfPPnP9ys/EQtbtL27Sy/zefjTQKR3K1UoIQ?=
 =?us-ascii?Q?N967j3G0bDy5zaz/2XNjILHSHmcS4ndLbN029X0cF6FUpojYKBL2fxdGYcsT?=
 =?us-ascii?Q?IrDmH5sOMtg7b9xJnxeK54FCFA2qKjMDXl+LUyBkofOTMw5+tCLuGk6bu4aO?=
 =?us-ascii?Q?HZInhhwTev57RQyz09hs3xojAxW9vodKIsdROi8uQiX2c78JvfuXgRw1vOmW?=
 =?us-ascii?Q?lX31x04ewZVYqNxEsIZePVblOoKPyN3rN14FtH5rzMYZXxu8YAqBMKxt6GPs?=
 =?us-ascii?Q?Qcp52Q/tDUqVwM0ijb6NAgeOpyCxXVYc?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 11:58:26.1343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c6c6cf-93c8-4e56-f508-08dd0edacd15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6585

This series of patch add support for AMD MDB IP as Root Port.

The AMD MDB IP support's 32 bit and 64bit BAR's at Gen5 speed.
As Root Port it supports MSI and legacy interrupts.

Thippeswamy Havalige (2):
  dt-bindings: PCI: amd-mdb: Add YAML schemas for AMD Versal2 MDB PCIe
    Root Port Bridge
  PCI: amd-mdb: Add AMD MDB Root Port driver

 .../devicetree/bindings/pci/amd,mdb-pcie.yaml | 132 +++++
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 455 ++++++++++++++++++
 4 files changed, 598 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,mdb-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c

-- 
2.34.1


