Return-Path: <linux-pci+bounces-24327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7718A6BA0A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 12:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA3316C4A2
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 11:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46733224B09;
	Fri, 21 Mar 2025 11:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DoI4g7gg"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DAE22423F;
	Fri, 21 Mar 2025 11:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742557344; cv=fail; b=u0YHx08jWlJiY1Y7e/Ubp5g9dK+txUIcJCzXT0TlOibMkLEhJzA8Tk4tgpl+xLuPhQ3hcx1bYg3XZ3DDtlo8m4eLmOEASRa4M0OaIKIIoo4N7rt8WWbsmuglbeUo9VW7sLtIMcXwHNr47V592T5KDEfApiHa+5vzfcSPSLRrfqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742557344; c=relaxed/simple;
	bh=FGpfo3Z7mksI+Hpm7VDfNzYqGZMjQAFf5Gc/uyWebOQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UWUOmZLlwoXKfwnBaCkeRm66QAyQTPHSFwc4Ba9k+Lbj//RrBdSeYXRnk0lzE91AHz0iFEBmko3MKjRC2r/f4ftD/rHX7cIawMl7NyF6nrPaWONxbU/WQRyV0Fy8q/KqR81kTSb2QWu1+2t44GZm8exX7dZQM7+SIp3Cm7cLxOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DoI4g7gg; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ls7lXU0pU1anmp1BY4lL/qaU3rSOhvAX4uDoO7bBX+DfskUpj31IdTOH7LwpihPwyoFvZ1Nk0oJ6YJNtJeGFeAFGZHNL/L6u9lIRclxAiQVOM/Wh/1hWoIYJI9GFXIbmZ7OpzGXnPCVm9iMxyl8uKdOfNiLxTu1DOgWVvONpARZj8CZ8snMg+RijrbYjZJ/WicWjtg45bdyz07aRRr/5W6ZP/PBdxwDE5xChKswI07j6uAajMd2+J23H2ncM/9AAYzK9IL0DIc1Atkd/IxvszAdWFv4oPZKrTOh0xyS1NVjP0XQDK+YnjDZ8zsJQ1QHafvljrKFl59a/ICNQWe65Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K81K/m6/F+TvWM9JfodKRaqiAYdfY+2MJLsZF23fMbE=;
 b=XZ67cuHMXmWegqbze9v8whiPFUSzzWVScMbjaAZDrimnLq9XG53qLuJExCwEdl5AwpZO5HlOsC1MbsqAzBZkVcUESmWtCr2Lu0GMfFs30eoFtGBUzLftBu/+cYH82MJFaVX04dIMrLYdfO7qDWhhu8i7ZoBS7Vm5Yf6J1lsYEUT1v31o1Vu8YbhL7gUZfByO4fEd3JDIxlRPsEBmEia9n/bzXe5LLHSJgHFvMDu/G1f9HuIGIxfuo4ZWwtBQ1+FDmHTjISmAEuxMcFm1zYY0m7339FrjVFS8CSBSX4NF3OtDXk26tas9BztU8ncgUFfxmzXxPN+m4gBTudTKyu5x4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K81K/m6/F+TvWM9JfodKRaqiAYdfY+2MJLsZF23fMbE=;
 b=DoI4g7ggLKjKpVGXqaXHAIdxSh+9yXo5VT/3oZIh3JryipYasFWhn6V/O4AA3SLifEzour2UhcnpjBuKCCMYdD/IH5u5WrYXa8jOXw4iAgovXXK1OgCKCKsHb3NX+9u9Pe/2cf/LWOBlSdvF3c2RL7Bfjpk7k6U+kn1bO4Uz4hw=
Received: from MN2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:208:134::40)
 by MW4PR12MB7119.namprd12.prod.outlook.com (2603:10b6:303:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 11:42:19 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:208:134:cafe::1d) by MN2PR16CA0027.outlook.office365.com
 (2603:10b6:208:134::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Fri,
 21 Mar 2025 11:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 11:42:18 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Mar
 2025 06:42:17 -0500
Received: from xhdlc200235.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 21 Mar 2025 06:42:14 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v5 0/2] Add support for PCIe RP PERST#
Date: Fri, 21 Mar 2025 17:12:09 +0530
Message-ID: <20250321114211.2185782-1-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|MW4PR12MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a30d87-c0dd-4096-15d7-08dd686d6f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qe74uy1BGmBrbf4YRsdDZaFM6jDppv+nnra5Fc758wsSF+LQTOjO8skomxx1?=
 =?us-ascii?Q?9qJ15EIQMzFiWrQCzmRna5Gv4j/lYEQM/eG+nRUaaagr6XU5qkKeTzT9ugR2?=
 =?us-ascii?Q?sznz+SBc5gL6n5DNv4u2e1fM5C+qL5qoAUwOuGzZm7rm4FPFyXMwVCqz+lwD?=
 =?us-ascii?Q?ceIYnVJ/lxb+D3kfQmRI/f1xVyMLopCD16yknavCyPEe1+qvNzQcxYQj6FvF?=
 =?us-ascii?Q?oxFJeBcoXOZnN0pzH0CPsjPGr5vBb5Zwkngd7Lz+tj/T+OWAVxFrepF3Bgz/?=
 =?us-ascii?Q?EsopnOyYRUhksBkwUUB4w5XZHRjYIUmLmyA5SiuEmHtLxj2JvdyAww3Y3Ji8?=
 =?us-ascii?Q?QhyCa25zQPkfktFlEaoEXP0U2q73eu4Hk4GJn3JddJIejyCC66p6A/IyZT5i?=
 =?us-ascii?Q?t7hr4ikSm8liSjXuKqiaasnaW/f48mh7Ilk4QLKoCHYMp5RJE9sojHAYos9b?=
 =?us-ascii?Q?36/6LJexVoK0Acz3RXxBSHif2MJdOFjmIPNo8LAgS94o9tWDL6L8rZXNSmle?=
 =?us-ascii?Q?9K1akjDnWQqx5PYrDd60hUeiJns66M7sRSGqL9U04xY0NNx6D6+Ji/xL51y/?=
 =?us-ascii?Q?EsuYNQzTbBIWrkTsoirAYY17XX+OyLcA6g/+J4BU5ruoSKq3jG5lb4cJXSjG?=
 =?us-ascii?Q?+7dN17QpJkBnaozrfFQxB2vIvDCiheuuN7FM+wG63nyIFvHpkmz8kbrZRPEm?=
 =?us-ascii?Q?d/sr00l4qVb5d4iIoCGfhlB3PcvD+tfFxFhn+Fp0kCWNO3inDInvRYMGY/g8?=
 =?us-ascii?Q?+kQzcSUgtEBlBYDSX+I3UTyIoppB/GKafsImd9Xjf1DS5TDNMUdGwBXXWsfu?=
 =?us-ascii?Q?Gz9tUPgm0Cnj4bciDjlvSupd5H461OOcFiG+m/T5viJPAfFMMejtufpPwBDA?=
 =?us-ascii?Q?drhDeEuwYAiib0DaJpsPzvPhSqHGDBPx0JvqFkZU+XyaDb1RChGwInBaoq63?=
 =?us-ascii?Q?sYhVGiSbu24UzbvyucPngbdu9Pj6t6ZdQizQXiNbk5+L+5TmRyfRp5Ebc+BQ?=
 =?us-ascii?Q?h2+PSlBtRy/cdvFbaAMtxBlh9dhLUQC8EdIGSM/wAOFy5r5dJm6S7LP+nJjL?=
 =?us-ascii?Q?QWzGwPrlSI27VjT7wJcW3lA58ineUzCbRYro2wMzRs9URjRo4/sFCRm3QKac?=
 =?us-ascii?Q?B+yfN2LNW27HbDokfM+7rR58lY1CgcTUUNAZNb8YQdcP5PfbuW/oieEqUW8k?=
 =?us-ascii?Q?qtdSjpo9z4Vgn/mej0jT9JhfcuHWcU8VPjN5vciau2WIe9vYWiKf54vyXkyZ?=
 =?us-ascii?Q?RLmD+i3T7ya5NEJgwr8s47p9IsapqBVryS7GyhPybmBtPx8Dph+abFbt6Fap?=
 =?us-ascii?Q?LfbfAplx9YULNzILd3UUsWLzXo+nHavBxqtH5MpYtZDiFuaZJ6A6UkvheRAT?=
 =?us-ascii?Q?PlbnSSayMDC+BSIZaqP72sUCRVpuodSECNILsyUjjnMVF7LkkYhTjD4RhV6F?=
 =?us-ascii?Q?DM9wxfad/hDJ4Qm9V6q0hybo+jL3R3SlZk0bKprFaXCF6q9QCvRJdC3cf7ID?=
 =?us-ascii?Q?vh7lGCTmbbqhvNY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:42:18.6873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a30d87-c0dd-4096-15d7-08dd686d6f78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7119

Add support for PCIe Root Port PERST# signal.

Add `reset-gpios` property to the Versal CPM PCIe controller binding.
Add CPM clock and reset control register base for handling Versal CPM
PCIe IP reset.

Sai Krishna Musham (2):
  dt-bindings: PCI: xilinx-cpm: Add reset-gpios for PCIe RP PERST#
  PCI: xilinx-cpm: Add support for PCIe RP PERST# signal

 .../bindings/pci/xilinx-versal-cpm.yaml       | 17 ++--
 drivers/pci/controller/pcie-xilinx-cpm.c      | 86 ++++++++++++++++++-
 2 files changed, 94 insertions(+), 9 deletions(-)

-- 
2.44.1


