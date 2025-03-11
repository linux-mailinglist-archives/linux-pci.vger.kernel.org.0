Return-Path: <linux-pci+bounces-23405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDF5A5B9AD
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 08:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0DFA1891CDF
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 07:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530DC1EDA03;
	Tue, 11 Mar 2025 07:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lvzt3MUq"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B04211C;
	Tue, 11 Mar 2025 07:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741677855; cv=fail; b=S9hs5N8G7voXsMpfXG9kZlEJNdNkdwtuzod/0dkrxeAXzh8neSaJ9/WbToehiPTMlpF4CREXwo8Mx2czVuSQURYfmY7hCULKCshYCUSLKuDkje7aD0bYpq7fPBuP0d8/k8Zkp/3Wi3GovX4AEMRcFLu8+X47hTMW4KiTocMFEpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741677855; c=relaxed/simple;
	bh=GlCKvQloTVSKr2mCOLSAx9H9nvMtpmZOJX050EwoTY8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gX4JpomlsG9kx9bQ2rcV3eU/CcINMQSYw1b9ul4RbmvtwZgbPWeeoNT0vGztbN+2lJggI0dmrlZG926FrA2HQuOeHl1FaVI0K7wHScMNpxOmfwisT60i3szTkj7/rZ0aw86P6QyCnY2ltWkLfFx2bQySCPGs8ABPI8Q0vyeYEgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lvzt3MUq; arc=fail smtp.client-ip=40.107.102.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUKXQHA8mP0YhWhgCAlseK9KxDMHe5eo0QXH32fLSgvf5zt+Gna/45BTkbXIEkbWFUVGQAnYMzC0CoPtRPTNNVDq5Mk42lmWc18zfddfRhgLJ7LO+v+bNJjNksjh3MCBM48ih/8PCq1H0EIsnekJ5Pax7+0xzJxggrygpl0yA/7a5k+CAGVwGB+PJQuD3o0q7P4RLCYULKXjOhHy0Uu6ZKM7Q+SiJoqmpHJNa1WalNdoiQw6R+3woZypyv+Q9J51zeoQnkIx5d59B6hg+AIt9jqPV9nBa3L9pLK1ePC4dlQ7LmjN2V//3H1ZHDtvWn9Ib6IPerBQguy+OiYZhvswSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kc0G90WWbMCggjkYNxb8Gto8q2pgDiYE75wPpmLLFIY=;
 b=pLitaKTubXWN5OK3mI5HB2N99mHmZJYH8ZNKYuGJTHj9+XACLUaYAFgLFMiwAxKttVxF6b+GnYEqAs+B7zNlx9MfXGqGPSApYaNK/t3moT/EnBpgwWN5dNKMA3RNlf6nfqV/9mLSM37Lbj92BOat3C5w6E2CKA623gE1Ct8viLlV6LOanNxo5Vrzk4OwIWDBIt5XLq5DOefofFfshBBa+E5d5iNuT748ZPUWreHpiOYZUPsPeILDrZrbwqHOthYu4b4PA+6GYmPbOypMWcP+Qpo35cI/zoooFuRjx4weuhrVsyOsOk239XU8bD04oNcTwqw9wjAXCJMb4I/MbelVCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kc0G90WWbMCggjkYNxb8Gto8q2pgDiYE75wPpmLLFIY=;
 b=lvzt3MUqQ2OvBJ3YntRc3vaBruiqCNLrq750cR4nVjQFkYN4jrtmljAV3LiQ4n9pjrDWpBYL94Wq1gj/6mQ8mNW/vTsypj0/opg8wnQB+CLw+GEsGy3Qg2IRxkkLFGDwmuCqHBzl8nLjN2Fem2jmx4ZWMX9nyQRtE6eGZQSgKkk=
Received: from BL1P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::9)
 by SJ0PR12MB6968.namprd12.prod.outlook.com (2603:10b6:a03:47b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 07:24:09 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::2a) by BL1P221CA0003.outlook.office365.com
 (2603:10b6:208:2c5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 07:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 07:24:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 02:24:07 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 11 Mar 2025 02:24:04 -0500
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH] PCI: xilinx-cpm: Fix incorrect version check in init_port
Date: Tue, 11 Mar 2025 12:54:02 +0530
Message-ID: <20250311072402.1049990-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|SJ0PR12MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: 885a8548-d91c-4482-804d-08dd606db67b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VMfbCcMEyGHy/DWCAKR7hXfIiH4m2mbaVSueeyEoq3ZoY+rgEeHrf+Nd6YPi?=
 =?us-ascii?Q?GMpC17mkY2w4VNvj8wGiY3E8FEfhZLejplSg1DJeP5pgzOT6ZAUu0DZlhcDH?=
 =?us-ascii?Q?7Aas+dyOtdnMrI1qaJhghWVqgrfBafLI10r6ShZJFYzIDbkkmk/Ei3blYSYt?=
 =?us-ascii?Q?OK9jGrrYOJIdPf9c06pU5ySIhLdjw7+serrVGBfUVjKehPVCBBP2+fHDPpgG?=
 =?us-ascii?Q?Wz0fLbVvnU+RdPoNuloCAarH+fYYJr3jretTcb8Hxn3W0LXNl3YL1md9dh8a?=
 =?us-ascii?Q?xEcSWcJa4iJjU7yptUMowFm/EbAjELeaFCwgAwPsFZFqVydmxZwpnG1UbBlF?=
 =?us-ascii?Q?RTYH98zbSESGKzDle+JmfMPyvAg/u8tuzXau79RzGVNVFQ0hOSrJ8Gceglc3?=
 =?us-ascii?Q?nGN/yZM7tysDkaM6HI3mn3eHVGPY1kzamupunaKDaBvPMf7VV7bradYZxcv1?=
 =?us-ascii?Q?FKpp4M4+L4LFh9rQQ82SIR5s4x6Sl56/mNOUEJV6e6z8E7RWhuHT5H0NAXQ2?=
 =?us-ascii?Q?6vVeJ9hzC8E2kUNuPrw4LWkJjo8BFGm0glrSd/ppUsY7T7b/C8J2WIF8DQBi?=
 =?us-ascii?Q?BeCPDBhVmOAl4Iu79lAiif0pF2seU4tQTiPsZ2ReVODDHvkrA7ZZBA1SG/AC?=
 =?us-ascii?Q?eytZz62vG43ko6bDveh0SRa+t5Yx4SSmc7z5+vSGkescIrfkcPY0DuqyLVXE?=
 =?us-ascii?Q?ditihci25GZ2UZaFQ9YSeOxKm7Pvq9GihtEUbehO47QZXyCVX0kQozBlMjY4?=
 =?us-ascii?Q?7ELBV773PO7VPLAl+HEMcZqbfRJwq3ryHos3jLd5UtjMETPSJHgIw5jTpIUP?=
 =?us-ascii?Q?pMMK4Fb/f9zGIR6G620JUzBQlYy3MepBnGKrqWLfnJ4dFFVKwvWUslJBSh6+?=
 =?us-ascii?Q?46Y7OzdLwZpImE+MiVfwJZi2AFzl0FV911MmLLP3JdXM0XK9rz5cSJgFg2FL?=
 =?us-ascii?Q?nKsCvFvRjVSBOYMQyw1smv5Nir0SCk/IFPYirr0/66KgN/lH9YJKRKP6d1XJ?=
 =?us-ascii?Q?Te5YFnoGkgzq1dksFID9Yot2aeBMN8fjdCcvGFEh5NBHOBiR01rI073VDQdH?=
 =?us-ascii?Q?WJ12JDLHpeb0y4PL1VAXP7yzACemfvkHzSRwrtnpauvZ5ucWN2beZPtPTb1U?=
 =?us-ascii?Q?JrM9q0dz2eOCGPu1WgWECtpLmDG7MSHFUfytBLOanFwfHlow3f340umtvVIn?=
 =?us-ascii?Q?0yO0XvxNcz4w9ej/BJEkL5zizHy39wlZZmsJTdA3z4gQ0bX09G5eG8frQmJY?=
 =?us-ascii?Q?0T8UBD7kKkYZlocFH7v3rjqJtpI311oSzfucKj38TODbuQDVGn5ix9l8smrc?=
 =?us-ascii?Q?oX6vRPMEIyRR/3ogR4ZvZM4/cvZVE/tekKVSL6tKEu9MOsc6oTI5qAhAjM6s?=
 =?us-ascii?Q?YVTU00qZbD+F5tyrzIU6hvJ2V0j7Dp+rUIw7Yv8++ghZ+X9GaCXO6WJka6by?=
 =?us-ascii?Q?d/bfyFQqlQsHX3DUhDbMCWwNsacMEka29bn0hsqm5f6g9bMIeo4UPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 07:24:08.4946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 885a8548-d91c-4482-804d-08dd606db67b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6968

Fix an incorrect conditional check in xilinx_cpm_pcie_init_port().

The previous condition mistakenly skipped initialization for all
versions except CPM5NC_HOST. This is now corrected to ensure that only
the CPM5NC_HOST is skipped while other versions proceed with
initialization.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Fixes: 3f62f3280275 ("PCI: xilinx-cpm: Add support for Versal Net CPM5NC
Root Port controller")
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index c2dd6fda905f..d0ab187d917f 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -479,7 +479,7 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
 {
 	const struct xilinx_cpm_variant *variant = port->variant;
 
-	if (variant->version != CPM5NC_HOST)
+	if (variant->version == CPM5NC_HOST)
 		return;
 
 	if (cpm_pcie_link_up(port))
-- 
2.43.0


