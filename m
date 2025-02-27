Return-Path: <linux-pci+bounces-22514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED54A47462
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 05:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58AF77A281C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D4A1D63CD;
	Thu, 27 Feb 2025 04:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4qryMEoF"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D692B17A58F;
	Thu, 27 Feb 2025 04:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740630334; cv=fail; b=N06JdgHa9QFUKzaBNkV+9BsXaOG4dZPifeP5AGFXerdw+gOEXN5sFH6sZOsKPC5QqFnm7ko0ZLhM1UiXaSBzY2zE7etNsC4NR2qZWqZigTsMUgsy5uRCnwQgCW0zZV58mjzCv86MRCPzj4qNtqHEyKyxZjnxjwDBOWWx/JlakLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740630334; c=relaxed/simple;
	bh=X1d5umld7C9emHSfVv2nZusPtOrcBUfUPO1RDgP9DO4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dwnde9MnjyvMe69Ht5l0LNP+HBMFxDUwFC10JMiCHD8pFfyWGLHn1nB3ouUfHtaK01GquBkOuPgF+Ubfo8XHTEoVYY1AoiMaPlYP3dKcc/nyxz3yUZBrruMwZXKWc6ykw2l31CrXPZV2zE7MuKVJqs5iM2DQQXc9tUve1Ye8xL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4qryMEoF; arc=fail smtp.client-ip=40.107.95.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WAYfnu0fNMKaT7pIRnS2/9+QD5TkmzwG7g/COeFFu0VCAmw1XDL/SsYz3HyQOfc2WQN+ky/mo1ixUI1kMOuMk5daAlzOldPV1z6hnM9BxggOHiUQznxUjaCCPztAgXRTUKGDPY5R6SVoBzZcla5Oo5qHPP9fHoWJABezHtaSwE6o+CRta9yPnGrrbFlLSwaukMmCWdwUS5bJDeOwcaWo6/OWkCsxxGKtmDBGmAHJa9hpLzNCpDl8GN/+xxIMXU2MYp+jrr5GUV7XMJds1b7qogmuauEBHLMUuTEZw6RZAF0ZOGUulrj1f19CmPw0UKa9mQgX0kpbTRiBoVqfvUIDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAPXE3V3VNUP8Btc3olfEe4ktxVe5gM/ueBIkxdX2YI=;
 b=Sr2WfyHL9iwrIISMlKsptTX6ccgrP6fvxU4ug/zx3aLbvXnqZ8wGE6e8CTpQfFE8c+7niAmoq/9v9vmxLgijSZR8dkt+B0ulxe/xwzYl5GEz4nDYmgMZZm9VdOaej/LtBkqbYUEKg4+AqGt7rC7KwJj/4mb2sun/a6/sJpl3GZUhHWf7/08FMxStketY/ziSEaOsebWop63rOLctzU9fafWLl4Lo1gEsNvcOvbUh+cgDfGTSWTDvs28yXOWPzQiiBOeGZRXL2OB1yEdrfKCG/5p7yof/C0ztzhwOGs80YITHygM+5ProMWO6BfnBNMhzXCuofzRW7z16WfhhJS/PNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAPXE3V3VNUP8Btc3olfEe4ktxVe5gM/ueBIkxdX2YI=;
 b=4qryMEoFmzNSPlFHE7s0KsPdeD1UFdmOYnoSZVI6J+GpsaAt85A8orHRQPyNMRsQGtfI/UW9uhyLdNKD3r+JZD/fdW/lXpGBjh7GLK1A4RSYudHXo4ZWvhgo8kL8uKV7eftNL21dh1SBRhgEOGhGCFlgvof6h98pXsnaUI/9oas=
Received: from CH0P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::27)
 by DM3PR12MB9433.namprd12.prod.outlook.com (2603:10b6:0:47::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.24; Thu, 27 Feb
 2025 04:25:30 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::d5) by CH0P223CA0026.outlook.office365.com
 (2603:10b6:610:116::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Thu,
 27 Feb 2025 04:25:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 04:25:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 22:25:29 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 22:25:29 -0600
Received: from xhdlc210316.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Feb 2025 22:25:03 -0600
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v3 0/2] Add support for PCIe RP PERST#
Date: Thu, 27 Feb 2025 09:54:52 +0530
Message-ID: <20250227042454.907182-1-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|DM3PR12MB9433:EE_
X-MS-Office365-Filtering-Correlation-Id: 441b6fa8-a83d-4955-128c-08dd56e6c4e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LMHYIvBLA/WScamILhvZCHzfGetEtoS3zzLnLEhuWYzGrTa/QRAGwTfWGpW9?=
 =?us-ascii?Q?oWEDHnHvxcEH8TpyCsuEWgX4CQyq+UFyGQCZ4twloQH6os5XSV3a5/N6HIk6?=
 =?us-ascii?Q?7qrtvMkhFAzTl/thIgAv2Gq6Z554IiPnYMv5yUf0pN5LmSu+WGywKNd1b+he?=
 =?us-ascii?Q?eOKQAf7oj6eZCTnlyMHyLc+w/Z18TAfopcc8ieAJZJOz9l/rnEEH3UrS4ne3?=
 =?us-ascii?Q?RK2GP2mUNB/eNcZe00gy+bqFfB9ohBeis2LV1RFoMuDiT5nquvCYT0rAcgdI?=
 =?us-ascii?Q?6t55sVkJBypu4nK3uZjP32dpi1DKdpp2QeJjGr+B3RHjbGIla2Ba17ZmqB7y?=
 =?us-ascii?Q?dk9NpXlr9qRazgEVu+rAzLFyBa39ft8WG7P+JmW2W8hTt5eNog6ot1RNY8Ri?=
 =?us-ascii?Q?0b7Zh5HKPvZDfPTMAFqilaYbWfQlzPgWWiL5s4NTdSJjuCUQbdCpSGF81uKq?=
 =?us-ascii?Q?CoaEO9jXRkYfrMhgQICeNDbQ/4gimOg7LyM12U3cF4Lw68PerAjbk2PxCJr1?=
 =?us-ascii?Q?55dZ687O+1oZv6z60gIvDaFlQxA7A0eIVUAcKmZpUUCVxLGhq4QsVVCNxQE+?=
 =?us-ascii?Q?txfIg+xU0HnUN47T2q3/Q8tJRK7UMiEW+ntlYAaPChWcYB4qp0Zw10v/J+UL?=
 =?us-ascii?Q?VmjaXEdW2kp5z8mWbs2M/fON1U7kBHtbkeioShTAXmX24TqZ0BO8yl+tj88i?=
 =?us-ascii?Q?mlnzBDxfTJYliXetr3KjIm371aQ9IC2dTlKMan4XhzFOiDCflAGN1yL/vN4e?=
 =?us-ascii?Q?3i/RLtSLv5Mwu7TFrsP83iakcoQPIIi1snBCB3IT+qIgOtZSCjMxmjJSODIp?=
 =?us-ascii?Q?ln17nVIn8OOGMROF2v0rSNGohC+yS6bplhGnIrhzRHTS8BRjZFj4to/iOxZU?=
 =?us-ascii?Q?Ch4eBZ5cQVKo2rBJEddFxhB7yC4w3Atoxsczq+FmthrNo4hG2H2hbIKLUiAR?=
 =?us-ascii?Q?uIT+po6XfH7Nb8E4nPo+ups6yl1DwIYCHTFTijo7W4JABh0vilfVa6bzUI9H?=
 =?us-ascii?Q?+T97twBc2qH4w9sHpJzN4Ph7hQqHoEv5ygcZhCNfCyjLrTisAdbRC+M5kKw0?=
 =?us-ascii?Q?VskB1pqLc1aSYWAUq50XEsbR0JaOywFJwIHuRaiLsJ7f5HDefF5kBzdA51fb?=
 =?us-ascii?Q?qAF4TTrHMfZV4SRbO5XVJmUjacZbyt6v1No9Zpi8ZRAXKxdHBOrh/QQguDCp?=
 =?us-ascii?Q?JAooOT54MVd0k1aOTPJTQVuPXNLSSCc+x07vBg7t6H1COqGGWJgXt4c/4DkS?=
 =?us-ascii?Q?aVpurWxVl6evw0hR7Pcz+rUvUOpaWnxrpsqKKM47AC+aGhZNQ336y4SpLOva?=
 =?us-ascii?Q?sEVmvVkNiUebBI0GUzqmHCyxQKvwNcCBUnxQRitsm0Ub5Rs2SryZFjbCuf/P?=
 =?us-ascii?Q?k2UPoePbT6ECMYCzfG43n0h/qXYCDVx7wlQux6eHcfM8wMJ1GlUMb85OcjeD?=
 =?us-ascii?Q?psIcB6WULo3aAh94H9tqNHEXnzz4u779Qn9dNM2Sk1vORildWLHMF42Nna4K?=
 =?us-ascii?Q?4YSM78k8xKUPGXM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 04:25:30.1495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 441b6fa8-a83d-4955-128c-08dd56e6c4e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9433

Add support for PCIe Root Port PERST# signal.

Add `reset-gpios` property to the Versal CPM PCIe controller binding.

Sai Krishna Musham (2):
  dt-bindings: PCI: xilinx-cpm: Add reset-gpios for PCIe RP PERST#
  PCI: xilinx-cpm: Add support for PCIe RP PERST# signal

 .../bindings/pci/xilinx-versal-cpm.yaml        |  7 +++++++
 drivers/pci/controller/pcie-xilinx-cpm.c       | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+)

-- 
2.44.1


