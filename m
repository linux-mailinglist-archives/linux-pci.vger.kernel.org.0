Return-Path: <linux-pci+bounces-14007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FEF9959E8
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 00:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50121B22377
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 22:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960E81E0488;
	Tue,  8 Oct 2024 22:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vi3K9S2S"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0B414A82;
	Tue,  8 Oct 2024 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425851; cv=fail; b=vB5F60b9Ev08qhhAXw6UXIwJIl65AblMsr9NXRochC2HRR9N+PwUaOmc8QgHsAcTIjoi/khR9j3ABYFIqjs6GgW52peyrK9R9RLuzHzpo/WjG0hrB5IGQwm1uAax+VEj6sxB6h+NpJzxpMJ4I/UYdg72ZFI8APBBCGk93m+6pXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425851; c=relaxed/simple;
	bh=SSMpZoRLutuTarErOJMvSEXKfHRL9sFXLu5OJJxOQjQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f3FRF+RHirYKA2ALm9FqaPGPl+kNHD4VLedNXplMcFpmLD7vHrzZBmsL1cP+oW62/xtyyYySDEvYJ51zpW/ibuMvmt2ZjF8dTUQNVCTBwFhAIdefz5hW1a/H9XiBn9PZkQ+I4Q+d/Zzy7Ip6O4jxpB5bFgqIpF8WAeuMYG7UdbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vi3K9S2S; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqhX20KxOSHLWKbRRir+TCeLZkFtuZt+Vo2eqH+VIgLPiRbSSabRqp/05ar8tfumkh2jPZwudOTyCMJQ2gGdN7/8w4NHtdaHshYjtKdQ3V/9wxYXjgtV+F4swSvZSe+eYqAfzOG3lN+iFSOcEzjQp+F+i9TVmOPDYAildSi7bFeErl0Ghmra71i43E+tojZ5WAF/4AVeh8Rl7F7fFibDZZPfDhjtIEZdgKaBqIIlPXzF0cRtjEUxLCQkOLhZt9FkTa+GuQ0YY8PamII9pznUOK38dKNDEPxiiSPtcIYNTSSxOuo0efSA/QWyMYRMwnf1CwjYxVwRn5X2wy7AFx+zvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sk7/Vpa10zq+0W20CuOYCvwvBeBBvNOMtj1SLJC5/I=;
 b=admtcMLbTIeSf+XIcg1mlBw7GjTkVxjwyArqoxWpoEriShMIKGmVQVDQHQSeqM5maRsVGhCusCpjHS21B3pV93h51m7IbyO2SpizxvEbiBI2ZngIsFI1ulEnk9FkBSKJliv4MmupX3Y51pMY0vwaxvKoBToyZORoYm0hyLkouL8311CYOlURH/8Ndbdu051x8gEwWVVpm0TBdmCpAcnoQjp2WbJPlpq1ulQ7rCqe/KzSihMNgvmbCAydLRb+an5O2yVnkcZd8tlNLQJ/YQNyFwXBw6PvwutHHRT9dyaLo6TFxWBUGPONJSj7xXaKxj5vw5q/LgHtrggrAnRY6VX4jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sk7/Vpa10zq+0W20CuOYCvwvBeBBvNOMtj1SLJC5/I=;
 b=vi3K9S2Seh4PtyCXII7kgpPcTjDIVW3b0Ngn4RKoe3cB3tgAczQH1jHOvv+IRKwnoHWU0mww7510RqLU+hcL1+QDSSs5vBc73eq7qyO3iWnuV4aYnJ7fUcAeejcjzv3OHr8Cppm0UAyLK++AEH8dZWLi2O9vSWqFaHUrR6n0XA8=
Received: from BLAP220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::32)
 by SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 22:17:26 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::e9) by BLAP220CA0027.outlook.office365.com
 (2603:10b6:208:32c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 22:17:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 22:17:26 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 17:17:25 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <smita.koralahallichannabasappa@amd.com>,
	<terry.bowman@amd.com>
Subject: [PATCH 02/15] cxl/aer/pci: Update is_internal_error() to be callable w/o CONFIG_PCIEAER_CXL
Date: Tue, 8 Oct 2024 17:16:44 -0500
Message-ID: <20241008221657.1130181-3-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008221657.1130181-1-terry.bowman@amd.com>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|SN7PR12MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: bd1dc2c2-3d7c-435b-58b2-08dce7e6fd92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eSmBi+i8hv2iDhumEYjMH88Gaui4STGoBBnBA0cHCQ89fIG3uRNxpxAyo8gB?=
 =?us-ascii?Q?z2LD15qP0X34uyAw3sxnO8EFeZnBI/ql70c7MXeMW35ri1yvH0u2dVNH9lAU?=
 =?us-ascii?Q?Fn+72r3TXwClWaB0Mtdy45f7QjYRTLLluNeJJmgp509VtVXpmwlJqapH+P54?=
 =?us-ascii?Q?PBe8btdsBaCVs3zuAjFYn9hOvuTdcOIVux5ahMqK50WTYm+MxQUEDUQrxUkC?=
 =?us-ascii?Q?UNKEjz5SzhsB83BA97pF8TALGtVRdvT6ovQZu099ZY6RR3XuXDF/nQ6vTDJZ?=
 =?us-ascii?Q?ZnCZwUvFtsmqpD1YPJyRdhIn7d1EArp8Rsyo0BedD/V80dcKLlMK/5d0JAnF?=
 =?us-ascii?Q?qZQidFrZp4lnJKpslbD09omKHITncvmocgQRY3l2ccCfobtMC5ND+NDcMcWz?=
 =?us-ascii?Q?2nLn5n4Vvkhamcb90Y9PzRu4P1UAm8pjI/lyfFIJ+O7dxNTTNwUq4L50cZEJ?=
 =?us-ascii?Q?+C2HYPmMVNwxI5aVTcfzl/AReyIymGKN8beGvQwDlBpcAN8TfRHPAnSxAbpU?=
 =?us-ascii?Q?8o2la3v4PhcbpqVaoW+0KSjWvI78J187SuAzpZCbVbjgHicd/RT6v0xy9vPq?=
 =?us-ascii?Q?lxhTBcDJl0I5XB18lsRpCIdG/fUhtBiS4KUV5pLwh5/F6JOR7Iryo3ogeZsR?=
 =?us-ascii?Q?e6xuHAUJokJO8n5Oa3Z4JrRZFnJ171+XFa295sARzgmnMGlvbKGt1D3PooMM?=
 =?us-ascii?Q?85QnzuvOYAsXq7OuNz5tb25mIgXIoCqu0RzYRwOC+80G90UMv6HmyFiy+R9M?=
 =?us-ascii?Q?i7ZI2Ortlk7aSOdtq856f9oVNZRZs0+eA8iv475uDSrnpljfyr5ImPlKzEGY?=
 =?us-ascii?Q?toEVWY4ubjdnURGzJK+gREbZc5i2cCMzG2Ow0U/siyYP5J2k42aKvg8dqMX0?=
 =?us-ascii?Q?2QjNdVtqYVDLRkKYcltuUfCUeS+OUlptHHmxoPJREbtpdQQdjgqr4io2APop?=
 =?us-ascii?Q?y+TscQlBPqYa9hj+hKMg5IV/RrdYDoGCn4roweB+ow98yYcl5JYoWV1giRhk?=
 =?us-ascii?Q?HRV6DgwG1fcTOaNFGbs2lmg0pSZU2JmgWFyvkqhAovYeg4YugKcIXzXZNdXC?=
 =?us-ascii?Q?sQqDzl7o103xkrDgMwNhJcU7HgRO7UtJ90AKTzSLW3RzghJZwLHUDQYIVACk?=
 =?us-ascii?Q?CroqNTnF8+ElU+bD8nieDE+pCBD/OjhqQHB6Non97FhAai4SKXlsjPx3uepl?=
 =?us-ascii?Q?RSorkmUM9iRTu8iESROqu0940Kmo3cZLNxTMQDwYWCicZoqFNiQHPTJrORGn?=
 =?us-ascii?Q?2WXs3rR231rtNtnVNrtU+H1yvy69Nd6GZYsZtAQj+T2HtyndBhOEpBHCYq4t?=
 =?us-ascii?Q?PTyE6B6Ih7MKFX1S0Y+QRldPcLyEYQw2KmiHAlG5UYkgzuWGYsyNRvyYbUDm?=
 =?us-ascii?Q?tg3Rg+CKHobJlB8y8a11UDGHvESq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:17:26.1863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1dc2c2-3d7c-435b-58b2-08dce7e6fd92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8770

CXL port error handling will be updated in future and will use
logic to determine if an error requires CXL or PCIe processing.
Internal errors are one indicator to identify an error is a CXL
protocol error.

is_internal_error() is currently limited by CONFIG_PCIEAER_CXL
kernel config.

Update the is_internal_error() function's declaration such that it is
always available regardless if CONFIG_PCIEAER_CXL kernel config
is enabled or disabled.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/pci/pcie/aer.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a9792b9576b4..1e72829a249f 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -941,8 +941,15 @@ static bool find_source_device(struct pci_dev *parent,
 	return true;
 }
 
-#ifdef CONFIG_PCIEAER_CXL
+static bool is_internal_error(struct aer_err_info *info)
+{
+	if (info->severity == AER_CORRECTABLE)
+		return info->status & PCI_ERR_COR_INTERNAL;
 
+	return info->status & PCI_ERR_UNC_INTN;
+}
+
+#ifdef CONFIG_PCIEAER_CXL
 /**
  * pci_aer_unmask_internal_errors - unmask internal errors
  * @dev: pointer to the pcie_dev data structure
@@ -994,14 +1001,6 @@ static bool cxl_error_is_native(struct pci_dev *dev)
 	return (pcie_ports_native || host->native_aer);
 }
 
-static bool is_internal_error(struct aer_err_info *info)
-{
-	if (info->severity == AER_CORRECTABLE)
-		return info->status & PCI_ERR_COR_INTERNAL;
-
-	return info->status & PCI_ERR_UNC_INTN;
-}
-
 static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 {
 	struct aer_err_info *info = (struct aer_err_info *)data;
-- 
2.34.1


