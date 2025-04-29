Return-Path: <linux-pci+bounces-26989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D77DEAA067B
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 11:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C021F1881CB0
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 09:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C4229E04C;
	Tue, 29 Apr 2025 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="23km6hkT"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ED929E05B;
	Tue, 29 Apr 2025 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745917260; cv=fail; b=KNkUtRxCVrIat7smI+QS0C/h68f6e04JaErlozUBCu7jiRhHQWIwPazp/en2GpdL5TM+dAWBlxASpap0vXJIh3rkNcopgbzYL0jyhpZhe4SplcP/bRrp4kDo8Rv3wXYTXHz/gTDX1NnfVPI9btzB+rpe8AkdlPSHeVJqbZgKR9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745917260; c=relaxed/simple;
	bh=OKPXnlTGhZandJ8zgvsU+sBp2Umfj1fcBqQM+kZg6No=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KlWvY0rJN+Wg3rdK/k2PpIbgqIY2GF7s4ui8VhmnhVLiVaDbT6oWSPjxYNn+gLJVHim/xNEqrelKCAbSU+FR4I7+GO4ZRY9SQygQFqyb7vpLIDiRUAMbCfdKrEQ1FthliAUge/CYxS82S9TguEWbBjRjTbPLk6+cUuBjoi284TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=23km6hkT; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CN4kB4qLlhH9Mof7zE97WeynuPC9n1sb1BecV/y4IL5enrb+ERR8qi5Lc+0wUyS6WLZ2nNReckEv+DfS8/ZZRLpuOg3AfIzlLGCjyQGxKP3DZztLrUGzTuPt9REpMD0MtknJ3AiIPZeTuX9/C0oIEcT9Dn81VOUF31HJwlOpuhZxv3PmeJW6251MVzYdGeMG3IYRd3Gfh1nnbPw0iyjsZYwiHTYPa2cfftrxI+25yCX9Uuc27S7bgb8qrgoLNBMLINyuft53H9YbNqONdnhbZcIQWSx/5sUMo3xR8eEBUqfMHV+F8GDS96ROscdzHvoDve9hgOY3DRPj/TNQIlP/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tm69Ta7oo5MXiRt0d3hVAcD1WV2WJqDpUtzBXaIRPs=;
 b=h7+RK1Cd5rDK+Xi2iv3wScSVGQcFZqkgbNghwAkMZ03vhOKmfJNzr5hiPrJ+ZYLxoP94Qtcrk+5cEAm/GhrBbc6TnB6F8KkYiqx8BbdmtAQ0/FOnIDJ+cyb7JYzaWeNnraueMjccI6hjv4luWN7qX9tmCBUb0KW+Nvn3PSwIIz07gkuGaFCXMoRWk5f/J6oTiTc0a2+AyS6+79ppUbVZcspnY0hsT7yh2P3/Gyu4iDaBqUu6CKIYzmQIkVURWf5qBon020TNTc1dnCis5gEU5XXX7WZ1pDelfCV8u3MZiVxEAnxMzTE898xXT26RkVOSwjzypqEFF5bWkg1YmV7muw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tm69Ta7oo5MXiRt0d3hVAcD1WV2WJqDpUtzBXaIRPs=;
 b=23km6hkTofJRi1WWFPB+vat9h3gakbm7sstmdu2Gb3HRL1fEJSW5ZW6Uy8pP4nQ6fjcRJmZ6hVyAzhe75ZjQzSGMKXPa7L9apZC8B9sC/4uSqa+3XhMcy8r13wY0mCMWZubX5CI3msjPdCqCn/agBVVy030uoBLyFHBlAVws+xQ=
Received: from BN8PR15CA0030.namprd15.prod.outlook.com (2603:10b6:408:c0::43)
 by IA0PR12MB8974.namprd12.prod.outlook.com (2603:10b6:208:488::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 09:00:56 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:c0:cafe::63) by BN8PR15CA0030.outlook.office365.com
 (2603:10b6:408:c0::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Tue,
 29 Apr 2025 09:00:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 09:00:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Apr
 2025 04:00:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Apr
 2025 04:00:54 -0500
Received: from xhdlc201955.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 29 Apr 2025 04:00:48 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v2 0/2] Add support for AMD Versal Gen 2 MDB PCIe RP PERST#
Date: Tue, 29 Apr 2025 14:30:44 +0530
Message-ID: <20250429090046.1512000-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|IA0PR12MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: d8454e59-bff9-47a9-3531-08dd86fc5a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cgYy2AHXI5m6aSt0ynK/VUrIh+wEwDYrbVO3VSVzxVDENsCqMO19u65cglXn?=
 =?us-ascii?Q?x6fS1IuFZSDP51gxTRb8fNXOtPTbIB6L8GkU2IYbw6Z9gOYwPqZZ5hcUdMYW?=
 =?us-ascii?Q?j18WVI8K6uneXC3zqBgGNdiwTKoMGr/aRxjkr3GDIdklm76J+mnuJ1MnqJ8N?=
 =?us-ascii?Q?0vkEkucbx+jJlJ//FxM4me2CrsKcgIkv6ruh48r6+Mp1U/DEy5bpoBGlmwNn?=
 =?us-ascii?Q?N/TsQDR8yrYWqojIdyEpD32KynXZUV0c5PLhH5uVa9fTyVreOC4dHQTGekf3?=
 =?us-ascii?Q?NPSgOYdPoZc4eKTrW8gKiNs7/NJEBud8WSJo5pE5eVheTjKtM1keL+xOxR7R?=
 =?us-ascii?Q?WDSqcSjuIXLogH6ebcVEkIsXpdvC5jDWKP1RqrSMYJM2gq75zbEs5a+X4yiZ?=
 =?us-ascii?Q?61TED8k+v+Cro5utqbJw2bvy2FFW/UOs/UHUn1ad7z0pf/HExc11LR+7kfTN?=
 =?us-ascii?Q?cNTmaSOyaL5sm5dlZjhMJo6g6thuCpLvydF+8SyKNsw/alnWesXf2B4WQ0Q4?=
 =?us-ascii?Q?k/nWuuLgh5WLavtOVJsKNm40Rr0mYdOwQcxspEsUTYadKbxVkFhxvDNKUt4N?=
 =?us-ascii?Q?P/jCAtaAUMycmvZyAqyeUtbgW5T6PdeloEu8KHV0f/mKdzz5asgQ2CX5lto8?=
 =?us-ascii?Q?nTBEfumoQflI1LL3KYC7fn4OJ43Y5IEVsi38phbWap7999wVZ+I+EARnJX+F?=
 =?us-ascii?Q?CvnhU6vA5IAdkvoJHucFZ+LyDRNcmtvMJcjgFUKiElIbnO1CodtIW+CygtHk?=
 =?us-ascii?Q?80SgC43g7D6QmcEJNkv8spkDCmtCueWH0lxN1/eRK0FdJNvNWZBr0czj8z3W?=
 =?us-ascii?Q?41Wue+AG0Ed/R61aFJg4TEhtK5hpEjP8IGVrjdh7WPr+PHTArV68X3s3hdX3?=
 =?us-ascii?Q?U+s3D6cysrNwq3naJzdYZc1QMhIT6x6//OqyFPJz+LuVhxtw6kFrUbFyOKA4?=
 =?us-ascii?Q?janbZ1olgKBSEiF8RyoWn0JzyWV6sD1DAbaYcmcI4b+SkYf5FW/J4+XFnlHD?=
 =?us-ascii?Q?A1ETqsMKNlUkPKDPhOjwwgdPLKfkDmjcQfD6LJpo92MgLsS/VT1Cbj6fb5LV?=
 =?us-ascii?Q?+woFsWfmkUozGu01J2tlU+FUUh0fV8AYhzUwVyF2ebk+tj1bREGz3mHSUHD1?=
 =?us-ascii?Q?eDnxZlDMPEGDwLSbWMMnKRMgEDdzOxDQvhSiuJ21XA9SnfoRXI5FxMycDkjV?=
 =?us-ascii?Q?VpvaQOmRxa8hc9fNyw2Zjjxbev061paw+Cbj6yIrr2z9mHh+vEX+VGGvnn9q?=
 =?us-ascii?Q?7x4nOLH/d+NYtvECn+PhqG8V7gpegjHj832V+wKKb6vr+FN+KWUmoSNWHsWd?=
 =?us-ascii?Q?V4STHeTP4mXyqR/X5XGFOwD3/+VvAWmrzavFc+1IVXv5PpBRfaZz7+t7ezcL?=
 =?us-ascii?Q?G5lfvFP46d+Nv1DwEudMkoID3BXOm66Rt5L9WtjDaw8ak5ASnefEd8npD35v?=
 =?us-ascii?Q?cl9WMKr8Krlsb0dXCR4ZgVl8cb70kw8Z2+T+6/2gTspJ5o6n0mOE3Y4wvyQy?=
 =?us-ascii?Q?JgffxgoBsx032HmNELV7hBecZiIlO9rtYr5p?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 09:00:56.1521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8454e59-bff9-47a9-3531-08dd86fc5a56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8974

Add reset-gpios property to example device tree node

Add support for PCIe Root Port PERST# signal handling

Sai Krishna Musham (2):
  dt-bindings: PCI: amd-mdb: Add `reset-gpios` property to example
    device tree
  PCI: amd-mdb: Add support for PCIe RP PERST# signal handling

 .../bindings/pci/amd,versal2-mdb-host.yaml       |  2 ++
 drivers/pci/controller/dwc/pcie-amd-mdb.c        | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

-- 
2.44.1


