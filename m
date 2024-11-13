Return-Path: <linux-pci+bounces-16702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8949D9C7DED
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 22:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FB2281684
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B97A18C003;
	Wed, 13 Nov 2024 21:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bzrnWt9w"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B821632FD;
	Wed, 13 Nov 2024 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731534928; cv=fail; b=MbiotwAOelIXtnoTpWKge4aDzPzc4b6sWGCAyrfRFTBSw6cdNMNSJGq/wRCS2lL9hONvcYoo0xJiB6O18jMNH0B46tibKlprIpva5guc/cl6TRLFhysyfoI+pbvMgm79zCABGDGzWSl0EagyNJViICt1XFFyk9Gdg4XzoUWo2g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731534928; c=relaxed/simple;
	bh=ZBuUM8SG5EdLQJ2R5ge9rgup/R7vP3IVYoZDdFBnqqI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kuefIT1mxPIzSWktrXF9SA4vSFt+5g/2g2DPkniiPwaVtkiBpRk2ypksuDy+6HRldHBiUibOsEa6OP5QDz803Lm3TMoVv7LfjaNX0jBS76zvS0pHfpWzt8AFGjGQemKrR2ByNGpMORAOSmwbd1Lzxt+h+NZW7KEm0QGFi+HpwB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bzrnWt9w; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbYnyy1ogDOtFrVep7lUrZ+2EE65Nt6kedGnbFkR2kev+gzGS+x4++O/zzwubZqCEDAFXcI2LP+2a8AMbaiOrEtZbUqsxRgJX8NGGfL1+TMSR4mPpl7alsxxsj0FJ2ApRgs3zAOqxDRZaEAECXT0tlalibS9641LkI1ulFWccrdwC0gkjoZ/Em6P7Eskn4/N1l2ya/kyeyr6AK2MUVLJ+bxPA8G/dMXS+F9ut1oXJu+o3YS+Q+bc75byv2M57xFTM91pqrcR9evsIlRb/FFU1ievH7HJfcPfjATXeD/Hee04pD5MVUwUU9qEIWcs/alabcL5zFRzyOYOyqDmLXoCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xABIalKPiUbSakFCC0gi1+YWxkSsqB+qdVXHkyN1Y7I=;
 b=bUy2gPS9cJ+jIOHRh1UQfm0VS7C5faw7IVMUbetLgtXDpWENbkVvSUFS54Ez9MF3K04db9QRACk2+vqMiyiR6XoggvIPFZP4AwbnR4rXFjhCgTKbGQR2yI8TGJ8y0lQUxh//P+nVq8ZffAlJekVQC49eRj66+wfBHHUveWaVv1F18ZN2Uuy07t3yuHFqNiWfaNvpa2d9fRxIqU/FRuDEX0t57Vb/0RFickMAbDtkT2uCVjVtsRJsYEUrXH0OAxwm2dUNIUGOqea0KD84uP2nKPDJV+X2hbZqwCi+eXOUVDjE3LsnHZTL2YU3DHv8n8IKYyUcSm65ULehP2alQxuydA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xABIalKPiUbSakFCC0gi1+YWxkSsqB+qdVXHkyN1Y7I=;
 b=bzrnWt9wUZ8jV3IS+hAEwyfUHoKXyvIFjhlVw5Jc5ra8KEVFX7b2HV6zKyjaLWGI4xXHlE0d1W2/t68S+jcmrFnLkAWOMqqNWc8nb6OMHwV8v5FC09X8Nn7QziYEQoaMerSj8IrmUh+4WKtta3D6cjCtBaKlg2nNsmkto3RZOs8=
Received: from DM6PR10CA0033.namprd10.prod.outlook.com (2603:10b6:5:60::46) by
 PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Wed, 13 Nov 2024 21:55:22 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::aa) by DM6PR10CA0033.outlook.office365.com
 (2603:10b6:5:60::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Wed, 13 Nov 2024 21:55:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:55:21 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:55:19 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>
Subject: [PATCH v3 04/15] PCI/AER: Modify AER driver logging to report CXL or PCIe bus error type
Date: Wed, 13 Nov 2024 15:54:18 -0600
Message-ID: <20241113215429.3177981-5-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113215429.3177981-1-terry.bowman@amd.com>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 269ea3cc-40ac-4255-6c30-08dd042ddf16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N9oPJCiFPgQ5OPL4rin6t+lMvUYb7WdDdujsj8/7Rb6OWeOz5EzJMaI0PzPe?=
 =?us-ascii?Q?Tfo2gg41/1RjdMkabUSPqCtoPcHGYYZvWnkW2DIfGlkprCNm6z4rfkhVt0p9?=
 =?us-ascii?Q?yKPvI0mXxMML6Kjxlb0tdGfR3aR600W45O3ZQiOKTOC6k8pUvwEJeY/IKdca?=
 =?us-ascii?Q?p/6uTdlSuJ+xLvRnN/x3Knken+/8NN7oyVH75v0Lgm+NwjFyq+uGH/YHML0j?=
 =?us-ascii?Q?GLNIQ/O1EGsNZfYkfgI44mLSewrK2kXnHRfPie9c2ZjqoWIBeEltYs7Vhsbi?=
 =?us-ascii?Q?kUl/M3BICpmpLvP56nUl2OioBGeanmdYu4LABMPfUcOcrXtobxkfL9ugoYo5?=
 =?us-ascii?Q?uNO8hFWebwrqSE/xXk1/4SKStL6s7pKg2GD/XfqGsNXuz8dU0690pr4BiQ2C?=
 =?us-ascii?Q?zHHzSSgtZtaY3vKDUxe9VI6+gUtRGTaJHnbskkPSkZTL1ZbC1/JgSAAtSRHN?=
 =?us-ascii?Q?GnI+k/16PTvkW1gQE9F2oLRjPKVveRqWeJrCOZZWVqQg1+QO2Rl++I3mb6tV?=
 =?us-ascii?Q?skqOPPuAEApTPobS20UUhkSSGjj2Oe/jb1ySxjzeZhSkd0tbJNO8Nc8/2890?=
 =?us-ascii?Q?jvyXBdwY2zGoJYe9RJoC5AnDAIsloVPVBKucViBoKIdGuImX/i7v7+l0W9ei?=
 =?us-ascii?Q?xvLJ3sQi/8B7EDtPgs8n4QQSbWWJNAeHZEqkOZ8iFzAtQ6hFVuynoYiYvvEO?=
 =?us-ascii?Q?4kgHjxLPT7YXb2iSFtmHlEMeh0soPoDCLTxK/JH87xtGDQHzgpsdS+Juv49T?=
 =?us-ascii?Q?kEE43O7FJju6GlbuWmXFbtQ/GJPP6T4LayNRTL9XparkKyYYBaW71r+jEXt3?=
 =?us-ascii?Q?P/1skhu13iN+IgtgNg70qwYVWa9mP8Xte8u/1Y+h0F+bfpRVNwYHGs5h0ois?=
 =?us-ascii?Q?nX7FLKK+ete1+cW9F60kfh+MchKnzVAOS4WjXjsiwQJ9KvFnmIm4Gr1aeQdq?=
 =?us-ascii?Q?pVlw/nUhWteqdq+ol0/pC96SltkDOH9VxiqHIX+TNwB7360qMueQk9MP9YZ/?=
 =?us-ascii?Q?ePp/9D8azbsoEtdTi8lOYFk/vXSmIOiqMeB3jmY4ZcpWxBxowYI9n2gU1ukq?=
 =?us-ascii?Q?HbDnQ1n3R74s1Pmhz7EbWk25m11jyAuZBPFXde840zBrbMEeuMpSX13qzadB?=
 =?us-ascii?Q?aqsFY0IpQsWwcseEwICsJqr68TL8xuyGS3s/QXjG+tzZ5ur0+MFSFwgaoEcw?=
 =?us-ascii?Q?yWo4uknjdCSEWNcV+QeU9z0EuiTFHBg9vImQoWYVVFIAcVTdsZeAzdnwZFnO?=
 =?us-ascii?Q?7c9QeLa70ITszomb4UpOCYsAb1upuODao5edFmJtoC7a2PYV/tUrI0Z2EHcs?=
 =?us-ascii?Q?zqszyg3bAJb4CTlnpzj3NbVLalrlbrRWHRKikzun1PI5VS7L7x8o6TFshRH2?=
 =?us-ascii?Q?LZ/BITJefmPolOHYSrldQvHa+BcaHOHpHQbd/2kLkBGReSgkEA7IRN/CDTr+?=
 =?us-ascii?Q?2hRKOIHNT0s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:55:21.6337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 269ea3cc-40ac-4255-6c30-08dd042ddf16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136

The AER driver and aer_event tracing currently log 'PCIe Bus Type'
for all errors.

Update the driver and aer_event tracing to log 'CXL Bus Type' for CXL
device errors.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
---
 drivers/pci/pcie/aer.c  | 14 ++++++++------
 include/ras/ras_event.h |  9 ++++++---
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index fe6edf26279e..53e9a11f6c0f 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -699,13 +699,14 @@ static void __aer_print_error(struct pci_dev *dev,
 
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 {
+	const char *bus_type = pcie_is_cxl(dev) ? "CXL"  : "PCIe";
 	int layer, agent;
 	int id = pci_dev_id(dev);
 	const char *level;
 
 	if (!info->status) {
-		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
-			aer_error_severity_string[info->severity]);
+		pci_err(dev, "%s Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
+			bus_type, aer_error_severity_string[info->severity]);
 		goto out;
 	}
 
@@ -714,8 +715,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 
 	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
 
-	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
-		   aer_error_severity_string[info->severity],
+	pci_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
+		   bus_type, aer_error_severity_string[info->severity],
 		   aer_error_layer[layer], aer_agent_string[agent]);
 
 	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
@@ -730,7 +731,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	if (info->id && info->error_dev_num > 1 && info->id == id)
 		pci_err(dev, "  Error of this Agent is reported first\n");
 
-	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
+	trace_aer_event(dev_name(&dev->dev), bus_type, (info->status & ~info->mask),
 			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
@@ -764,6 +765,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		   struct aer_capability_regs *aer)
 {
+	const char *bus_type = pcie_is_cxl(dev) ? "CXL"  : "PCIe";
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
 	struct aer_err_info info;
@@ -798,7 +800,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	if (tlp_header_valid)
 		__print_tlp_header(dev, &aer->header_log);
 
-	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
+	trace_aer_event(dev_name(&dev->dev), bus_type, (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
 }
 EXPORT_SYMBOL_NS_GPL(pci_print_aer, CXL);
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index e5f7ee0864e7..1bf8e7050ba8 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -297,15 +297,17 @@ TRACE_EVENT(non_standard_event,
 
 TRACE_EVENT(aer_event,
 	TP_PROTO(const char *dev_name,
+		 const char *bus_type,
 		 const u32 status,
 		 const u8 severity,
 		 const u8 tlp_header_valid,
 		 struct pcie_tlp_log *tlp),
 
-	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
+	TP_ARGS(dev_name, bus_type, status, severity, tlp_header_valid, tlp),
 
 	TP_STRUCT__entry(
 		__string(	dev_name,	dev_name	)
+		__string(	bus_type,	bus_type	)
 		__field(	u32,		status		)
 		__field(	u8,		severity	)
 		__field(	u8, 		tlp_header_valid)
@@ -314,6 +316,7 @@ TRACE_EVENT(aer_event,
 
 	TP_fast_assign(
 		__assign_str(dev_name);
+		__assign_str(bus_type);
 		__entry->status		= status;
 		__entry->severity	= severity;
 		__entry->tlp_header_valid = tlp_header_valid;
@@ -325,8 +328,8 @@ TRACE_EVENT(aer_event,
 		}
 	),
 
-	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s\n",
-		__get_str(dev_name),
+	TP_printk("%s %s Bus Error: severity=%s, %s, TLP Header=%s\n",
+		__get_str(dev_name), __get_str(bus_type),
 		__entry->severity == AER_CORRECTABLE ? "Corrected" :
 			__entry->severity == AER_FATAL ?
 			"Fatal" : "Uncorrected, non-fatal",
-- 
2.34.1


