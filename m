Return-Path: <linux-pci+bounces-33206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567D4B1687B
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 23:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3195A59E5
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 21:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A65021CC63;
	Wed, 30 Jul 2025 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ioxbHazh"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C672C2C9;
	Wed, 30 Jul 2025 21:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912092; cv=fail; b=Nkn6mfXLV9M0falG2uqjak6GI84tYrbiHjZU+CyLDrA4USfrjqq62IaIhHXnm2Vwprag3hjUoTlX1fgGfMFNDkVLRPMTk19Udzf/gDcovxppHw+lCzFq4yHQrVSEEkwYTCSACrQq5i5bKzP8g8J2gl2cI2ubSmbz7AXUiRjeDvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912092; c=relaxed/simple;
	bh=vEd2WP3Ncv2bCmV5YKWz0PYAk6iSPV1lBBn4gMLxnQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/ICuuhnn9JlRsGbe0EaGpwpFMhKezLLPVWvOCS5BJs7k3UzD/fKjzYD+CQ/2zduSBXp/GjACbxuziQJodPnIi+DgCejFqr5WB4I0F+r7rYAVwTBuPgMuqy/UO5V9EmAz9z7T53dopKhb/Spu3f0PNQzigAsXtP9pvjYt5VwNaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ioxbHazh; arc=fail smtp.client-ip=40.107.100.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iluyEKnBMfcET9HnOixfyEfrf6KaMvEbmhbYzVGWu2f0ck9ZUU5Qp/PsxJNQnrfKwBSqX7ua0fcvC4MYJRv/+qPNg2gIDq4YMwbA5vgHLrk/6Vlwfm+/ud7uz2NciX3EktWzx5121v7rFoDz9U8sMD6hg31Xa7jFyjACpsbHsHHGqnINLTnx9OtEke+/XA90ZyvVZdV+qaebfhNSIQ4aspdxExybsxHoBFT815+B5b5Ih+MeyvrcULw/1FN2bJd5RzjNlPNVxy92pexzeCaffedK0+rMO5MTDELZ10wXjD2pGInbfijshhwBmhGNIzD1Pp8APGPQbcIBEoWqBsS3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHDRqsEKNCDl+QcR22vXvyzT7jBsKyafwrI1563tjdY=;
 b=CLnxml4NhKCXUOa5lG/QRlZ4/O1dtAvuRju1YnfTV47NbRpZLYbMFHMOT5LYVMGNehFYqodSLLOUoGyq2WEIgRxRWKR7gJqhP2gnZj5sqmdQDHs2gigEMPZsvE0hOg4Ho/IS8uKbGjZlS78uQrE/xd8qSYGA6fyztgbtRM9U5ZLv18/bn8fVQNkqye0IGc4uAqIgOPcxJn+KoK8rxesoXcUVSxRgiwsGABROlpHKVE64pH6qP1iOqe/VLfaA5iCeWw+zu075ouS705e0+iJwyXgGCYAyUJAn4QFT0RzAAQRHXp+rR0sBnWyDW7UAiqW7/l0txToPG9lBUUXohGOBjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHDRqsEKNCDl+QcR22vXvyzT7jBsKyafwrI1563tjdY=;
 b=ioxbHazhlN9E9CtmJJyKmBi+VWxoMva2jysKJj8V3p0CLbh2ef8iq/sLsOFNgoWJTmrluX4pGPhPeCXMzoXv9hH7CEMargaD4Ia0ONF2S3TZZLpxl9+T/DEhEC6WZQyWcNJaLt88GzGcJJkQTmG0XdTGsT31ZfF+QNyAmuweDLY=
Received: from BL1PR13CA0400.namprd13.prod.outlook.com (2603:10b6:208:2c2::15)
 by SA3PR12MB8811.namprd12.prod.outlook.com (2603:10b6:806:312::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 21:48:07 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::22) by BL1PR13CA0400.outlook.office365.com
 (2603:10b6:208:2c2::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 21:48:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 21:48:07 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 16:48:06 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 02/16] cxl/regs: Add CXL Isolation capability mapping
Date: Wed, 30 Jul 2025 16:47:04 -0500
Message-ID: <20250730214718.10679-3-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SA3PR12MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: 72db3985-4561-4141-57bd-08ddcfb2c528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N6sCJpNMvIwP254TuTG2g+MtZQa4Vx64V+ZrD56H1ApKngysypdCMpeoMjyA?=
 =?us-ascii?Q?YL2wIV7eCgXe9yaH7CZDIuxkIVTwxzL7deEtObHqBW95747aR33Pycor+ts7?=
 =?us-ascii?Q?tgLLW3Jm64oLD3+kvR2hS12QBN18yUsaa11QPJ+c1bMo6m0K49vvtt89139N?=
 =?us-ascii?Q?13BL7YY4cAck3sorYIH6vjhSEn2tjVjTy0nmC17s8ETeDi5rM9FGKs+f7qOV?=
 =?us-ascii?Q?VXXJTWp9u/GvqmiMQzRkuza9HCndgXOyLlVGOum0hmFWIS6pxT4L0qZe0SZK?=
 =?us-ascii?Q?sT64viebnaJbPOb/CtwCKdjSD9p6P+OFpi/TAs7T+bDj3YNCyxQ2FG5YguRZ?=
 =?us-ascii?Q?UpBa+zVbQdYMHfzbc0FxOWPEADDnq8HztUcAyP4jn/myEPiK7u4YyIx04XRD?=
 =?us-ascii?Q?46zspHSdhHDD2A5Yp/qYY5vJf54nUicJvvp0ZmFwCX+xBOoZ9n5vhwAGTIBv?=
 =?us-ascii?Q?ZT3ZLCaoagtPHpbZMm6f0w/uUgUGup3Yq0WZxB0SJOWZRDixXd0R78FL1N4K?=
 =?us-ascii?Q?FMXbChZREi3U/U8pnGhGNLXE2gOaUkqqlGrC5+mF10vpXlZxWvwSMA7RPxLn?=
 =?us-ascii?Q?0BVEqZiUuNHL+1lTod2067vvXK8Yvzrl7O3NNacHDE8lOzJwViiAj+nwCtVB?=
 =?us-ascii?Q?Tbs8+risBTOPJ9fOtkLj0cO0XGmh/jk5R8MPO1GKULlHUJqbzjrZCwQlOLak?=
 =?us-ascii?Q?CyJ/S3NV3j5L860fB8OTPhnDx50RO2eaxTWyefOE7AKnhhFjZE9mEM4mNCm0?=
 =?us-ascii?Q?Sy9MbDCQR6cIzqIgAlYv4bQLM4ShIxLpB00zeiGGmCAz+yLmVuoB7XZHQnTj?=
 =?us-ascii?Q?eC8kFcbKRWBNieYPrUXnebAkzDVH5LxZF+A1fMTbESiRcuSs3y2Sx81Jvbx0?=
 =?us-ascii?Q?WmPBiir3S+mxBbmcrCG1Vg3ZEC9NK/SPk90edbQOOmegQSuVUfMkf95Ov/rd?=
 =?us-ascii?Q?jlth58eTvzhFOKlFiFYohusxFgPnTRWGzc9WkG3t8HQYGshyJfywqqgDcfCr?=
 =?us-ascii?Q?JmKm2I37pHFaJY8G8S7i2fF6wUCPxE3dcLLnsar2HAxkSwyjxgGdlygtyswH?=
 =?us-ascii?Q?rZeccKkCBhrqf5XGUxnUm7aK5fHoCUaUL2y2NI7cECfMOH6el9IfIWYCU2fF?=
 =?us-ascii?Q?Pq4x/yC0mhyhJjpUoJD1DUsKFHfG0QEsG/PSEWf5jJC84NVKlJs4inPYqK55?=
 =?us-ascii?Q?3cJ2DnX5YOvyj+Euh1omFSI+uHhKkVN767EkT8T9gkhp1M4r8UepNuM3myfz?=
 =?us-ascii?Q?Y5FvE6h3EOPF7S8YMxJ1KLiYZ3VoC4B4EC179YbDg5VC+IoAt2rPnoKiFl6U?=
 =?us-ascii?Q?R00CWmMsiKxfJxSfpl7FISXXyiEvyzGtvGmdW3GGUe1aKqhGWRilOFeKW6Q0?=
 =?us-ascii?Q?uXMUIYnrSTDMZheo0dvLR8QrS8MB8AZER66ey3rXTsgoF0Y6th8o9X0j6H4A?=
 =?us-ascii?Q?CawQPiB9doOCoxdS97hHy6P1StdXVGN4+kTkyX8az5ToICGx9LACXVIKZ10a?=
 =?us-ascii?Q?It4fSD7JktxUPDzKBuBj6HJ0ZkDtY0OVkgK4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 21:48:07.4912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72db3985-4561-4141-57bd-08ddcfb2c528
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8811

Add necessary information to map the CXL Timeout & Isolation Capability
(CXL 3.2 8.2.4.24). This will be used in later commits by the CXL core
and PCIe portdrv driver to set up and manage the capability.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/regs.c | 8 ++++++++
 drivers/cxl/cxl.h       | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index da8e668a3b70..bdc1eb59d69c 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -92,6 +92,13 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			length = CXL_RAS_CAPABILITY_LENGTH;
 			rmap = &map->ras;
 			break;
+		case CXL_CM_CAP_CAP_ID_ISOLATION:
+			dev_dbg(dev,
+				"found Timeout & Isolation capability (0x%x)\n",
+				offset);
+			length = CXL_ISOLATION_CAPABILITY_LENGTH;
+			rmap = &map->isolation;
+			break;
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
 				offset);
@@ -213,6 +220,7 @@ static int cxl_get_mapinfo(const struct cxl_register_map *map,
 	struct mapinfo mapinfo[] = {
 		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
 		{ &map->component_map.ras, &regs->ras },
+		{ &map->component_map.isolation, &regs->isolation },
 	};
 	int i;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a0fda305e25b..3013ba600ba3 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -41,6 +41,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 
 #define   CXL_CM_CAP_CAP_ID_RAS 0x2
 #define   CXL_CM_CAP_CAP_ID_HDM 0x5
+#define   CXL_CM_CAP_CAP_ID_ISOLATION 0x9
 #define   CXL_CM_CAP_CAP_HDM_VERSION 1
 
 /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
@@ -133,6 +134,9 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 	return 0;
 }
 
+/* CXL 3.2 8.2.4.24 CXL Timeout and Isolation Capability Structure */
+#define CXL_ISOLATION_CAPABILITY_LENGTH 0x10
+
 /* RAS Registers CXL 2.0 8.2.5.9 CXL RAS Capability Structure */
 #define CXL_RAS_UNCORRECTABLE_STATUS_OFFSET 0x0
 #define   CXL_RAS_UNCORRECTABLE_STATUS_MASK (GENMASK(16, 14) | GENMASK(11, 0))
@@ -211,10 +215,12 @@ struct cxl_regs {
 	 * Common set of CXL Component register block base pointers
 	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
 	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
+	 * @isolation: CXL 3.2 8.2.4.24 CXL Timeout & Isolation Capability Structure
 	 */
 	struct_group_tagged(cxl_component_regs, component,
 		void __iomem *hdm_decoder;
 		void __iomem *ras;
+		void __iomem *isolation;
 	);
 	/*
 	 * Common set of CXL Device register block base pointers
@@ -257,6 +263,7 @@ struct cxl_reg_map {
 struct cxl_component_reg_map {
 	struct cxl_reg_map hdm_decoder;
 	struct cxl_reg_map ras;
+	struct cxl_reg_map isolation;
 };
 
 struct cxl_device_reg_map {
-- 
2.34.1


