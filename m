Return-Path: <linux-pci+bounces-24814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B38A7287F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 02:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638BD189D185
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 01:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E9D1A01B9;
	Thu, 27 Mar 2025 01:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oglm2pG7"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CE61531E1;
	Thu, 27 Mar 2025 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040212; cv=fail; b=mKfbSKADrp0Zxv5tipY/zvV7lZGci3us+XT3vzXg7QAy9SohjMd3+DQUFdxQBWrvg4FrNulrQJcpsQy/Tz2J7YoQNfzI+eqt94CuI1LvdcaVv7656sip8f6mAIa8K0grMwS6qlTha8xjdzUqts9aghpx+3Fma6xLGnC4nLPC/tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040212; c=relaxed/simple;
	bh=1/a8P2ADIFvqFQqoMTdw3h7cZBiNNdm1LMCQzEKRY+w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MnproHJgymEkjpYs2Id+9+BS3P9PityiaYdu12j59d1x8QGWtP1Y9+ljghOLaWfTakYyOVe2v7WRyQIdth7YkmeVJLMwLFzcugZcbGvtzipth4i4/9NhA8GAIhS6echyL5t+P18tc88Km8S6GJXiCE++tqEacfod4B/sFwpgkMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Oglm2pG7; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OG7uBnaG0JEPm318sBqQWhL8dFVl+2uwmYej9taLwjZBYowfRPPShblA3zVnifs+JVScO/hPoZU0xqaqsba3y5lrBEqEVbxmmQ8RVrEgEs7rWydNdo24szl4mfcxUeRIeT5zjzURzSMLwxklU8/kJuTNwu4giPtYDhT1yOKf/n1livoRayzISy8GmXVcpInAVFMBsG2DLCT942AywxVPLJOPNbpZKbf1LyKnanihvqpL0FjMT5WP0BQYhKRr621LITWlw6LnrLdniuJU2O3WeklaW7gSK0Vhe0gEQZtLdU946QJ/vkrBGABc7rOyaUGOTQdLPjl35K2QIzmu6P3nrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KccQmjsMUYgdF0Fd3PhmMVSrOYuiGPTwG6CX+zqOyNQ=;
 b=vK+dUC1EmjNzL/2HbCXQbqiY6ZbdVvxeasBrNIDWz8mcppfbV6NG4t/9Xo+Whz6zvfYOB99C3vWYcwZ5VVqHFqtzF4TdIWSxQ55ZtRJEztAsixPUAjRIqmlEAmp+f4n/qVE7Rop8Dlk7HjYak0oeEOLSFs8Ov4twVU+OGeBGf3BT4J3p+5aEyLVDds9KGASDVhAL/JPrOW39f4BjmlR4Xl34nJROP8McQPwfeU+Lj2nObYseS7OHTwcemRpKue/uekxZmFF4l2yH8Seb3DZP7X6BqkKGsJS2qwKUfGabd5QYuhYGwbfkDVGQqFCzZHWG9ThVEB+v0qR4/jQa7sgw0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KccQmjsMUYgdF0Fd3PhmMVSrOYuiGPTwG6CX+zqOyNQ=;
 b=Oglm2pG7MKJdsgZRiWjojghIpUHG+PuddoeMIHlqxwqqOKVF2S0RmLUzFT50bMXp+HD+0u6YJc6xm30ZEYU67vbNqwg0pnvQ8x8uwRu4jrwPyfrzIaVwLISEZSzYwzZa7x4+9g/z6BwAenoA2qyZd1bgzBn4++aB9wA7WIufD5s=
Received: from BL1PR13CA0305.namprd13.prod.outlook.com (2603:10b6:208:2c1::10)
 by IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 01:50:06 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::cf) by BL1PR13CA0305.outlook.office365.com
 (2603:10b6:208:2c1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.26 via Frontend Transport; Thu,
 27 Mar 2025 01:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 01:50:06 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 20:50:02 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v8 14/16] cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
Date: Wed, 26 Mar 2025 20:47:15 -0500
Message-ID: <20250327014717.2988633-15-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327014717.2988633-1-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: d30beb38-5b21-401b-9e2a-08dd6cd1b327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C8wprnFZHgUuocyMLQamk/Qy90IAWSRUotiltvtN/bkF1A7liZXhRxni7vrv?=
 =?us-ascii?Q?mDTTBklZIp/xUJrOSFOnUh9CyJLArLkht9OarqVbfhmLk6aDMQdiN1KnMfud?=
 =?us-ascii?Q?C/lvvnaYqee9bMDNj9TLMLxucWqrAcxlLBO/3GJUhKTkUO7lsjtwg508zDV6?=
 =?us-ascii?Q?LAE4Z0kT+bjGDmPcGMzalH4R8eKrcd40VRpiofBh/j5uGCvPDOf1Ce4FFBhq?=
 =?us-ascii?Q?g9bIdQiUUE5dZl9UqCd4eWRwpJhcSjPF9WCPZI4+r5aiV1xZ/VvAjBIEN2Jp?=
 =?us-ascii?Q?0PmImtMRe3sb9MU61zwNWk41bQoF4nhhTEnWQkYH1AhsskbcGYVcqdGq+84y?=
 =?us-ascii?Q?uB6b5Bu/WQYrLIvWXYh39bxW0Av1oc1CdWHlcBF3v5D9d8B/wn4AEnuLzhdz?=
 =?us-ascii?Q?WW6bjrGliJ4sq5SpO1zwDpLaytDk0ynzbahJx3LSJXUwPMIb2oH0xYvvqgmF?=
 =?us-ascii?Q?XVdb7WBPN7wtfy88s/qK4K4xZhrPMe0Pq5FMCLA/tyMqfAYX21rkchbNoVwv?=
 =?us-ascii?Q?PbMiTqNyc3gxTab/xpqRLfUfAYWF9jLPp3EPq5510AfWvdGjiCBY98jruHbP?=
 =?us-ascii?Q?PLZh7nFt2eRnyAh/W390q6oS921ypjQNNIKEL/dzBRotpGHgymU8nu6l6W7b?=
 =?us-ascii?Q?tWPXi2uwpyTLK/6dQ0uV2fDpHbIE/YJQlespe2UE0UmNL0YhspfFQ0nYOVkq?=
 =?us-ascii?Q?NxadUvUtfQRVw3Bu4MPp8gUWrum3FzANjN7nCwR9mJN8s7epk+08BKkoVQqB?=
 =?us-ascii?Q?eyWumdqujCa/cm+JjzPI8Gt8rOyEUQEygj/ntR4Lo2bu3LrQe/i+EmM/Uxln?=
 =?us-ascii?Q?1k5k+YCH1JOWylxUZ1bjRKVLYBgp4Nmjivki7j54HKEPKiAPxPvsNwDEzked?=
 =?us-ascii?Q?J5VF7MgI6DQY6usvlYWLDN33QCtOAlawFV0XNds5GCvGXTzPquRODrVfTQ1I?=
 =?us-ascii?Q?CtttxAuBv09W0E/mZVw8H3NU9gTKXN0SxWsvwy3I9wnyGRxc00KI5xOwwgTk?=
 =?us-ascii?Q?RvyrJQFBdcpcQsSe0i5AhMbSb4ORu18d+9cF/pcy1X6QIKKUpJX8/re3bqvX?=
 =?us-ascii?Q?IX9EtyP+DLWsxGioJRFIaAUxZYOTcGSeIIgtxvG26Kc504U0iYZGPDoqa3Mv?=
 =?us-ascii?Q?jLUJMyJ7wHaj6sqO8tiIoTguYujep9Ipw3d46Xq0ZFG0ibSFWFv8WGoWmM7B?=
 =?us-ascii?Q?1SUn0RRYIvdcyHERw6hd9r5r+vYRfbAK9gnZAahzclp0IUKB8r7zVEzl/rWs?=
 =?us-ascii?Q?PW2MWy+5WaKgby+rfjQ12h5Tc9YIR3Z6dQNZgzbYYEa8HGA74HlOJJXPjjA8?=
 =?us-ascii?Q?DMNzbTFg1AesJbPNs61qXwAi+wa6gmvEKzpPpEvB7keLRim0VlKys4wzrqtj?=
 =?us-ascii?Q?tubjFl8WoDwHBDCimEUIWJnBSsuBZ5zPmB1PbVPbjBUUpjVFPZfsopVPkUGS?=
 =?us-ascii?Q?esXAzVIof0b9he+13bRIeWo46RZh+oDGrGhT268V6dNU2C7pP2XcDCvJV2Ex?=
 =?us-ascii?Q?+d7sctJz9jthxbeI4ZpCkG4xUGD/SiG+lHd/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 01:50:06.5849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d30beb38-5b21-401b-9e2a-08dd6cd1b327
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695

The cxl_handle_endpoint_cor_ras()/cxl_handle_endpoint_ras() functions
are unnecessary helper function and only used for Endpoints. Remove these
functions because they are not necessary and do not align with a common
handling API for all CXL devices' errors.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index f2139b382839..a67925dfdbe1 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -670,11 +670,6 @@ static void __cxl_handle_cor_ras(struct device *cxl_dev, struct device *pcie_dev
 	trace_cxl_aer_correctable_error(cxl_dev, pcie_dev, serial, status);
 }
 
-static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
-{
-	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, NULL, cxlds->serial, cxlds->regs.ras);
-}
-
 /* CXL spec rev3.0 8.2.4.16.1 */
 static void header_log_copy(void __iomem *ras_base, u32 *log)
 {
@@ -732,14 +727,8 @@ static pci_ers_result_t __cxl_handle_ras(struct device *cxl_dev, struct device *
 	return PCI_ERS_RESULT_PANIC;
 }
 
-static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
-{
-	return __cxl_handle_ras(&cxlds->cxlmd->dev, NULL, cxlds->serial, cxlds->regs.ras);
-}
-
 #ifdef CONFIG_PCIEAER_CXL
 
-
 void cxl_port_cor_error_detected(struct device *cxl_dev,
 				 struct cxl_prot_error_info *err_info)
 {
@@ -868,7 +857,8 @@ void cxl_cor_error_detected(struct device *dev, struct cxl_prot_error_info *err_
 		if (cxlds->rcd)
 			cxl_handle_rdport_errors(cxlds);
 
-		cxl_handle_endpoint_cor_ras(cxlds);
+		__cxl_handle_cor_ras(&cxlds->cxlmd->dev, &pdev->dev,
+				     cxlds->serial, cxlds->regs.ras);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
@@ -907,7 +897,8 @@ pci_ers_result_t cxl_error_detected(struct device *dev,
 		 * chance the situation is recoverable dump the status of the RAS
 		 * capability registers and bounce the active state of the memdev.
 		 */
-		ue = cxl_handle_endpoint_ras(cxlds);
+		ue = __cxl_handle_ras(&cxlds->cxlmd->dev, &pdev->dev,
+				      cxlds->serial, cxlds->regs.ras);
 	}
 
 	if (ue)
-- 
2.34.1


