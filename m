Return-Path: <linux-pci+bounces-19436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C072A042E5
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023E218850B1
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A900E1F4262;
	Tue,  7 Jan 2025 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gBl4OtW1"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101701F3D4B;
	Tue,  7 Jan 2025 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260890; cv=fail; b=A0mwkoNr0ddBAn7BbCE3aSmYfaFpdEcaK/vN/MPIrQKBQe/3hHr7Z7rtvuUNIhorZqRyOWTbiLEW0kWtmlzZs+hXfwQnGcmhFNdiAleuLDMjFkSq1H3i+IGNGXMLR0/3amV83jm4WWA+SzMoytL+Nt3oq9eNbPH5+094/pk6/uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260890; c=relaxed/simple;
	bh=EKaGMXJHJFc82XYjf2IWE374c1h9Fscjih1LLaoPw3k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bC82xovC/pIRZlFcNOJ67vlJsB1Rl2aQ6zGoKFgyRagwC3ltBy8gg0eLnyrlAf49oJBsvjHUYLTP05CRgkAH2IBAeWZ2l6ZjIUzN514AnRDwl1x/wHn5Zj3GorJsxeKZnDID77Wg/n6irSEpR7Yz0sc3NcG8kGNxXMKSUXZFqSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gBl4OtW1; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyC/9CVA06biHwltogXRbbqHiTojvTMerXrEBBZ4ZyoVY56gEsr74my0+uMU/1vae8jvsDDXlA7nebv7OHPu03MsmABfEHPtd5wGd9k+H0uXxpCvN/ECb5Qj28aDlGPOjnaSr9liFtZ5LmPV5g+9o8clSRvImW+xwKfcj5QVk8W7/3I4YRDvah2sYS6kHZz3hsxvZ0bit+A9FjAxCBmxDfmRyUxXYHjzywCTvlWdRLaPXzxxF0DRQTZS5KF8Rv4enlHkFlO0okyTc1+o0lsjo4MguAbRViJEeXP6mvS1FVVAxMIzLnBR4vQSrJpBx+nggFPbbs8jWsi45yMdPrKEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKR0DQYNlFVg8A3h69PDFxbLTLfI96xqjXwncc+I/IU=;
 b=aY0bCvDxLuqGYE+K849NRXTdMVOx/7nMyJaBeuV7eaIreD5id439Fg4nQRoT51dHwAqVJriawwChgIlOK+9EaiuyO5oaICAN3QG2GWwqUBKrE57RYylUYK4RYrrTMtJzHt8ooUUjgRM8N0J6zIsB8ogWwqsE4DUNo0wgXSYqK5kKgcQ9/tAqp0NSlv6RdBTwpKJB72rQ6X3+eMr5i57+7U5LVgoHQxMQK7j/SLcolNX7qKzd8FJ8zcJ/nEd6msnZt+4otHlgADmbrVui8xQwizeclN0csNlF2EPYeQqOUqapL2Exuo6ikeuCtJlR2/gj7cd0yqpouyP6lgzZzhQ/Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKR0DQYNlFVg8A3h69PDFxbLTLfI96xqjXwncc+I/IU=;
 b=gBl4OtW1o9mNnglYnvFtjqmHwVPomMOeD0/ePUdatael51uzlSHs2+Hz70WY3gdabSRDNNg5Gm9Al+OPc1Ak3Enh0KRccW0q9NCPrzbJUxUn3+mZTZnNQEUu+A1Lv3uXi3F5MmgrVOjWjnQ/hHEICF/Apu5qoALtFRbz/JNM8z8=
Received: from SA9PR13CA0078.namprd13.prod.outlook.com (2603:10b6:806:23::23)
 by MN0PR12MB6176.namprd12.prod.outlook.com (2603:10b6:208:3c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 14:41:17 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:23:cafe::a) by SA9PR13CA0078.outlook.office365.com
 (2603:10b6:806:23::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 14:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:41:16 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:40:48 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>,
	<alucerop@amd.com>
Subject: [PATCH v5 10/16] cxl/pci: Update RAS handler interfaces to also support CXL PCIe Ports
Date: Tue, 7 Jan 2025 08:38:46 -0600
Message-ID: <20250107143852.3692571-11-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107143852.3692571-1-terry.bowman@amd.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|MN0PR12MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e47119f-93c9-4d35-314f-08dd2f2957b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QDp2cMd9rRk1zGWGbu+FnHeXFaZbCbCvqYFbMG7D0NDN2ibiXTyhcvHLDjFr?=
 =?us-ascii?Q?L3qdSdwss/Iq2fAWyvgxygaeYNhOKPjvzAmiDd2xadXtl2xOsY85HJ1qlR7E?=
 =?us-ascii?Q?C2udWfsITGZp/UbitL1gox9LBQglZBmO1lMUBPMiuAIEi2lPXIl0TKAOqAaE?=
 =?us-ascii?Q?qosOO6Ra4urpLl1EPDPhRFFjc4j+PAl1jCMcqh/c3myjx/Q2IXvxxE/TRzCU?=
 =?us-ascii?Q?VJpcJywbk81EFIifNjMn4ISHfPEOAVZdjlsKsbePKRoELKDA7RoKnOK+K1Ia?=
 =?us-ascii?Q?qOfLnX6Tlqg7xpPUJN5htzJcvxeX76dH77JdQCOkPkJPavi6+HPbiEMz3nfz?=
 =?us-ascii?Q?mEWdQivuc4Y78OIfKCP2bx5rppc8alZPq1DiFMNBH8NySxEjZ/3XSVxI/AmJ?=
 =?us-ascii?Q?w4Ws6/C8N7t//ePkMzjL6LXeAo8I+huuT8i3ahpJhmEOVRKFLuJG2wwJ9unj?=
 =?us-ascii?Q?Y4SJ34R7KVte4yU7AezXOxL37rso4YoCHKQIuvxa/Il3K0u4wFxuBBsgS98s?=
 =?us-ascii?Q?7U9Bf7LgfmoY7yDdvj8yghYwEWlXjiDhfUNtcZ98y0RQEOkjGvl5nEQCxG/x?=
 =?us-ascii?Q?PuHS/gimwxmJlsC9gGR9fFCe7PRn6COEO57gJeNsoKWD/iOunlaP9mpKgf0X?=
 =?us-ascii?Q?+hUPz+/t3VaLFGNMBmDdx/j+r1Haiv//MIwzulnnZrF7f3tlQFzAK4QMgrTL?=
 =?us-ascii?Q?BKlG3j+pZDXOBVdW8Be6pIsW+AgY81YPoQN3IPtU3r6U45oKDFOaBorRyfSQ?=
 =?us-ascii?Q?hDEYrRx6why9FLe2eNPmXt0yo6ZidDv7pP778PYLnTi6pD6XSR+sT5OPR9w3?=
 =?us-ascii?Q?xE5ikwJI83QkDxhH22K42UBqQTLeUrO72qwYEvLTBo/VY6dk2QVsY5hc60Ig?=
 =?us-ascii?Q?AgJ2DARhmHx2XPdgTpUqVs2FdQ3A+bGcCcUOqM03SINCEXcm1gQ+mRfAtKpZ?=
 =?us-ascii?Q?52pnFzi1+WK+c1YnxsFzu8a/Z7egwudU1QUsEbaAXpbJ8rc5JRX0VbQc+aUS?=
 =?us-ascii?Q?ClFevqxD6Xew6BJb9SrvNN7FjcNDvvb9mBXLnbSmaluIuV6MlY8BCoaql8H4?=
 =?us-ascii?Q?ohQoTFby+i1SMNk2JHtR/zqtpPitbyXZwtsS9n69v8sAOqh5g/+XazHHhtrw?=
 =?us-ascii?Q?ZVS1aEqpGy5pCvrJTdXlNdSmU7HetZGkzLBUibqhQ7N5i5tCoJHvU0bgP71Q?=
 =?us-ascii?Q?VnXebfI9w/bbmuFGnjwvtz1mqGf5CAuobb1G8i0kGbIxSGOpYEzIWjbVxQbF?=
 =?us-ascii?Q?ExQOTWFlh/sERDJIt6RrKEXREzgOy05Zp/lcLNSO91JoFLqonM+UNJZsYmqX?=
 =?us-ascii?Q?gjoT1qF9mx96aZL7f2E10kVqug8y62U3HUOLVvbHJTJ3Pvqd+u8DNWFaCeNy?=
 =?us-ascii?Q?bTM9jdqFProG6PmM35LQIkT49l9MIWsgCWw0j8YDILqNUCwEWDe/UQiH4/zH?=
 =?us-ascii?Q?tM7ld43ijf67acY4wFVHZ13Y3qP3vkR0pLRvOoHSaU0Wkon+kUormct40pY/?=
 =?us-ascii?Q?bHww2E8FEAXE+hbZaPbhCC5TXDL2Ku7bFcxo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:41:16.7347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e47119f-93c9-4d35-314f-08dd2f2957b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6176

CXL PCIe Port Protocol Error handling support will be added to the
CXL drivers in the future. In preparation, rename the existing
interfaces to support handling all CXL PCIe Port Protocol Errors.

The driver's RAS support functions currently rely on a 'struct
cxl_dev_state' type parameter, which is not available for CXL Port
devices. However, since the same CXL RAS capability structure is
needed across most CXL components and devices, a common handling
approach should be adopted.

To accommodate this, update the __cxl_handle_cor_ras() and
__cxl_handle_ras() functions to use a `struct device` instead of
`struct cxl_dev_state`.

No functional changes are introduced.

[1] CXL 3.1 Spec, 8.2.4 CXL.cache and CXL.mem Registers

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/pci.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 97e6a15bea88..5699ee5b29df 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -650,7 +650,7 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
-static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
+static void __cxl_handle_cor_ras(struct device *dev,
 				 void __iomem *ras_base)
 {
 	void __iomem *addr;
@@ -663,13 +663,13 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
+		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
 	}
 }
 
 static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
 {
-	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
+	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 }
 
 /* CXL spec rev3.0 8.2.4.16.1 */
@@ -693,8 +693,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
-				  void __iomem *ras_base)
+static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -721,7 +720,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -729,7 +728,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
 
 static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
 {
-	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
+	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 }
 
 #ifdef CONFIG_PCIEAER_CXL
@@ -818,13 +817,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
 {
-	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
+	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
 }
 
 static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
 				       struct cxl_dport *dport)
 {
-	return __cxl_handle_ras(cxlds, dport->regs.ras);
+	return __cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
 }
 
 /*
-- 
2.34.1


