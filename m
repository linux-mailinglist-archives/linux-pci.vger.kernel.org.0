Return-Path: <linux-pci+bounces-34827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3D8B37720
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01563605AE
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D88B21D599;
	Wed, 27 Aug 2025 01:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PMXzhWxT"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F2321D3F4;
	Wed, 27 Aug 2025 01:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258662; cv=fail; b=retI06BrMGDsy5tureDGxeQRMzxL+GiinL9doc4fu6Jf/CLVdZS5LXvn2PE83YDDLy9H/rmMq6h6Ta0tqvzo+qQ6oydxNf7Rppuf8FDPKph/GYOCB4WUcxvfb0v4spJvifyd5g4q7PHcToiYBfAGXqcGWPF10Fcy8kULKzyIv1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258662; c=relaxed/simple;
	bh=Ty8bWSF5Vs/1d15A+pO3gM3aEtOC4y7Eih5G8zo01Xk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pC67UXdqa7Fk1bVHDS2Mt3uEPMrUo8ecR7zSzaMhwE5DGu7gkT7EnDtGPGj5OUo8STonwDAZQp4btOdpcnuokHHLKzKD4IB/s1J29RaxsDR6/lfdX/2ZMX/teZLFDghOvN5XXz7/pFGyTsF5OI7DWrW0xjbbPUqjgfh64hgdvaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PMXzhWxT; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0zBS+aVI0+ucPTCWP/UdakkZ1bMi6io7LOAPM2utodKTB4NN5bRhOTanWy8LxgdSk5KfhXE4dWrNEEreP/dpD/FFW8CbnrsroZdFPe2tBQaWN9AtmCXy3M7dsJlUEZPaGZhgxoPOpIyqYZFMLsa+K/FugQYCoiJc05BsYDMvv+8Iq5o8JVDeIsm0ZGuySh6fb2+slNKWAjEKXEtreeeBp9tbKIjSC7UmNkpn3krlskIsrlqlWRFjg5qz5mbOYoHUQ+dnlIpYMFe22A1YK3ryT3HI7otw55ubmYyBpTpdrhbogDDK/mZcTNQH9wQImtW6KYKDbkU4wnG5QpNk0d9Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PtT/S9FmG1En4mMAcIluDShD20WYYJVulazmDJxTMs=;
 b=hl8yK+yC8kg/c3NES2g4frqjLyFMh08k8ms2kL05KuIvIcpG8FkEhrZZyrFtNrGj2OJT42VldSK6OHsjWriJOtd8TA7ecJI83B00GRXaqkui2yWh77EG0J8bEAu44WUhtFWEEUBQa/3+4jDzKw19H1OKQhXol5wmlYft7xZdyL1eELGFdUD+BLFDG5AlBwjG6bEX1P8IPdEQbOB2zk227SsylBZtsM6uspP2YGm+rq7i+YqDK808VSNfrPNu1JXYA/dONMwhqgWG74LyFAyiTMhgjtv1WA8X/RmjhAQrP4Lzqaf87a875TJ3nAXqs+nY4g49oDQr2jbne3/B/wYqNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PtT/S9FmG1En4mMAcIluDShD20WYYJVulazmDJxTMs=;
 b=PMXzhWxTYqMoSW78W6ue/P9HaRCse6o05f0yZb4iQApBSiHZZ9ICGcVaeunsVBqlZ3mCoJCoep3M/oLvNWjSMDVRJPeGhqcyK5KWOlpGwRTBpCb9eUwxB4+81j8oWhQWQ+IWsCLUMX9sJhhf3PDzf3sOhbziIHdI6AmcEU8TBig=
Received: from SJ0PR03CA0112.namprd03.prod.outlook.com (2603:10b6:a03:333::27)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 01:37:37 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::93) by SJ0PR03CA0112.outlook.office365.com
 (2603:10b6:a03:333::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Wed,
 27 Aug 2025 01:37:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:37:37 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 20:37:35 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v11 10/23] CXL/AER: Update PCI class code check to use FIELD_GET()
Date: Tue, 26 Aug 2025 20:35:25 -0500
Message-ID: <20250827013539.903682-11-terry.bowman@amd.com>
X-Mailer: git-send-email 2.51.0.rc2.21.ge5ab6b3e5a
In-Reply-To: <20250827013539.903682-1-terry.bowman@amd.com>
References: <20250827013539.903682-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|CH2PR12MB4040:EE_
X-MS-Office365-Filtering-Correlation-Id: 628f6649-a5df-4516-1934-08dde50a4db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4wnYnzirPiDB2ykuIFlUJLCbnZkIXl3A1LybeK4LlKftlwVNXKJqtepA8Zt/?=
 =?us-ascii?Q?i6jw9/LVOBXp8Z6kzLiOjL5IlwkUNOLot1TJZ1iSxcpn7qSvWu84DZNzBkh9?=
 =?us-ascii?Q?F44FMyCLcP3hpJdIo5MmGXTfR+kcqyp0IgezLbnjwelXUwU6J7QwM9XfNQT8?=
 =?us-ascii?Q?yDXWTfPeY3NGexp2UoTOtXFMQluIPmhYGFekYRIGeQr86QUSJP+BS/Cu6eDk?=
 =?us-ascii?Q?kwATfkDiPNFIIyl6ucVsmkZEHNj/v0AQPFgIKJ90kxyWTbju9VR2YpjR7CIs?=
 =?us-ascii?Q?iX6ZS+tOd/02Yz+MLQZnaH7wg4fjxiJENkysz8sp3KqznCSyPv9my2PnMSON?=
 =?us-ascii?Q?CR5PRPkhl4NanlgKlacauPXAn7I5uyIRO3mRnnL83hxLmvksdUf+20Vj8Xn2?=
 =?us-ascii?Q?piTAgfIs5deUDfKUnhJUevIqxHhV3pj3LAU8zzK6I8KQ55qPsqqeygXDOvTa?=
 =?us-ascii?Q?CJ8GbeCJuFuAXG76y6zsmfKGsUDYhjiEzY0vMoCw3bNEicCvU10WjZNOOXxJ?=
 =?us-ascii?Q?gEfI7ZF5UDdKZSYz/kDRYa7h1WwrwtUeG626y7GugS53DD3IyNOzlCr7DcHI?=
 =?us-ascii?Q?63lPFkEdrcc2AWR+kO0XYl8acUxBWkfP2c5B2U1oFE+3Wa2ga4h4fCWPsRV0?=
 =?us-ascii?Q?HXKB76/Bjn47nKwXTyCTSamKYrqkYhpqqfGmJM1NpGAiM+3/nzzR8FDlghyQ?=
 =?us-ascii?Q?om7+98qKvfpJqvDnrbQHRk0dXescbBtWyu07XseKnzC/DBABMyydO4bufokt?=
 =?us-ascii?Q?9tW2LmvnTQjSC4gYfx8kM/CfUJV5+8lWvtToy/ooyXq8ftW4OIt8Lgbe16aE?=
 =?us-ascii?Q?enSU68EcyNEmzwmqFxP9ywR+Dzcl3UKGpBb55P8hkBD1f8RBNR8DMuw3TMyn?=
 =?us-ascii?Q?YtcAfRccXdR4dkUVMP+4QI9yYVEiXaUt6PGyTvaWEmhA9ouPLNSBOGeCVG2j?=
 =?us-ascii?Q?pwUkVbfqprSADxKKSz3QqkyXerwM1YRmtrP5G6AtwZk35UpSFVZIOwcUHGYg?=
 =?us-ascii?Q?N5LMAp4OKPQgyqKDU89eY+BpetKc5dQO+PE1GfGJmJ+nEOOc9+ERBl6srYrd?=
 =?us-ascii?Q?XOxw2o37+yOA/2A3WvfHL0IwpL5rF/cN80dL3/SR5MgPf0aBD4OV/U0wC0TP?=
 =?us-ascii?Q?fW/iuA2lNd3a2zkXYFZQfBgagLjto1ils/xDXswOENvyqGrKci0rfQbhUjX5?=
 =?us-ascii?Q?z+OSOJ94Mf8t2uu3fnO/tJu0ElJfiPY3WyEpp35g+UWWwrB0fAgWWpnWHHae?=
 =?us-ascii?Q?AyX5vWEhVKQZCfqjaBiaO8U4g45DQwecAmC++up5onjjTaAXsSJCFojKL9kw?=
 =?us-ascii?Q?zL3HLS2XhBRN5mbBKtuPDlatmLx/nxzte1pzEsYCgtzlAxKnW4FCN6axMxrE?=
 =?us-ascii?Q?YHxDn4+CgWqyUkb5tHnwiGy4v1rIiZLUf3IwfunK8tNG87qkj+eqXXuhqlg+?=
 =?us-ascii?Q?mMrntod1dDY3CfLp36F9Qf2wFiBcMu6ZQs5G1Qzf0ehDjvmWv1wUUqoIUDtS?=
 =?us-ascii?Q?DLF26Bj/HGMwmPWFX+GxwjXj7vjoUzIq1ikIJ8b4Ug4geuhWwTk3pBHaow?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:37:37.1066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 628f6649-a5df-4516-1934-08dde50a4db2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040

Update the AER driver's is_cxl_mem_dev() to use FIELD_GET() while checking
for a CXL Endpoint class code.

Introduce a genmask bitmask for checking PCI class codes and locate in
include/uapi/linux/pci_regs.h.

Update the function documentation to reference the latest CXL
specification.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---
Changes in v10->v11:
- Add #include <linux/bitfield.h> to cxl_ras.c
- Removed line wrapping at "(CXL 3.2, 8.1.12.1)".
---
 drivers/pci/pcie/aer.c        | 1 +
 drivers/pci/pcie/rch_aer.c    | 6 +++---
 include/uapi/linux/pci_regs.h | 2 ++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 1b5f5b0cdc4f..ed1de9256898 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -30,6 +30,7 @@
 #include <linux/kfifo.h>
 #include <linux/ratelimit.h>
 #include <linux/slab.h>
+#include <linux/bitfield.h>
 #include <acpi/apei.h>
 #include <acpi/ghes.h>
 #include <ras/ras_event.h>
diff --git a/drivers/pci/pcie/rch_aer.c b/drivers/pci/pcie/rch_aer.c
index bfe071eebf67..c3e2d4cbe8cc 100644
--- a/drivers/pci/pcie/rch_aer.c
+++ b/drivers/pci/pcie/rch_aer.c
@@ -17,10 +17,10 @@ static bool is_cxl_mem_dev(struct pci_dev *dev)
 		return false;
 
 	/*
-	 * CXL Memory Devices must have the 502h class code set (CXL
-	 * 3.0, 8.1.12.1).
+	 * CXL Memory Devices must have the 502h class code set
+	 * (CXL 3.2, 8.1.12.1).
 	 */
-	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
+	if (FIELD_GET(PCI_CLASS_CODE_MASK, dev->class) != PCI_CLASS_MEMORY_CXL)
 		return false;
 
 	return true;
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 252c06402b13..c7b635f6cf36 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -73,6 +73,8 @@
 #define PCI_CLASS_PROG		0x09	/* Reg. Level Programming Interface */
 #define PCI_CLASS_DEVICE	0x0a	/* Device class */
 
+#define PCI_CLASS_CODE_MASK     __GENMASK(23, 8)
+
 #define PCI_CACHE_LINE_SIZE	0x0c	/* 8 bits */
 #define PCI_LATENCY_TIMER	0x0d	/* 8 bits */
 #define PCI_HEADER_TYPE		0x0e	/* 8 bits */
-- 
2.51.0.rc2.21.ge5ab6b3e5a


