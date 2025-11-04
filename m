Return-Path: <linux-pci+bounces-40241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B264BC32396
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3575534AB7E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF5733DEC1;
	Tue,  4 Nov 2025 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K28DAUWw"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013055.outbound.protection.outlook.com [40.93.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5188127703C;
	Tue,  4 Nov 2025 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275899; cv=fail; b=PE3KwxPT0swZ9cbbbq9x9D+VLGgFDvJ0s171QVVqxRyvm0VLNcHIJ3su4Cpe+IR1+OZdmaex6fVZOqq2jhYFYjp3YI4VF4uuxtJLgJQyydckA9Ua2o1n/mV2MZTbOvoHmtioujRWWeHQFmOCqw+6S2J9PqqBmDq1MkHCXknV2pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275899; c=relaxed/simple;
	bh=LDaQ05vWSrxHjXMoEmyYaBP/ZSEvMr5EAqbHY+OAY5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9dqWaK0aVmN4NdCR0KTSdFGW+3Yo7SK0uzNG1njETTJSNOUueyfRGs3fiQ/DcMez1iBmva41diy838IFDSQGDWu3wSFFTW81ZJtO00GMfJPXMFt+gk3iMi8v/QczApFDtlNWegClwOkg1pFiDvANfQx8iGqpOUdpk2yxVjM/qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K28DAUWw; arc=fail smtp.client-ip=40.93.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntQ4yXSpYimhY+XXrYUOIK68k11frjjMV67VnFz8jcbcL0b2edJRF0mKPTXPq04w8Bk0eURzR4LFzsL/7p2NSEOOXx1sfAYqKPgGWJLtxyIAIAflBSO3JsfuQwSFBy0ZNZTKNG2OqfC6IBwAwSJOsfNr6Qnn0MrUNLc/EkDd18ZLG4htxB9Odf0BhGs03AJnyFAVnvvbPQihO0G4+g7uDTgeuNNcCYjfore7GVs4WCZamjZSYuMkoM1LneqcTzQU0GToiaYZVn7t0ChLjW8GP0J7UpF48RGic85P1mWMOmErzilPsc5dOo8epMshpnkO+Bzp1MWJiZjgojLV9MJPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwkFNx7/ZlWByHIut9/gjEHKNHdTxSHDE+sJyi3Sc6w=;
 b=AEuKAkv/AyKyPUW1C21tBiR9hG3qbNhhnPBxkoDglvUIRddtPlaiNOH42BHxyV26iGZEyjdqwwd7yHjGQ6auwhiCWOafvGIRYUvf0McShdYl2vTPYjCZY+iju45azwOGCcHPGLOP5l5sBWF8n2fqhAEpboVqmywiAtePU4YtBUZrpnTwE3fUcqKt0YlsY7nSXNok9+cvIt7JZa6i3uCW8H5mC1iHmtitwfA4t715SB6PBb466JtrX2SJwB5BAi1WrENlWdrqggaODNCfi4tLuB/WIfUzrUWv4w1kOTu9RZBaA+uK+nnmhs1ee7yK8k6FRgbmuBpGt3hkMqWEiVqn4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwkFNx7/ZlWByHIut9/gjEHKNHdTxSHDE+sJyi3Sc6w=;
 b=K28DAUWwSnU2TTxVuSXm97wVUPsmHftf5J+fjI+laxo4tCcIWJcn9+FNgwKij1Se4yC8b7gWXbQZKfjyAq5WTvuym/PvztykHuW/hG0Hlo77YKKajzndBE0cSnsanV5V8kv+Cd4M/7jMpVGc2B4/9OJJoLbrRTsJjGs2LkgPe4g=
Received: from BLAP220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::19)
 by SJ2PR12MB8651.namprd12.prod.outlook.com (2603:10b6:a03:541::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 17:04:54 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::b4) by BLAP220CA0014.outlook.office365.com
 (2603:10b6:208:32c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 17:04:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:04:53 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 09:04:51 -0800
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [RESEND v13 09/25] PCI/AER: Report CXL or PCIe bus error type in trace logging
Date: Tue, 4 Nov 2025 11:02:49 -0600
Message-ID: <20251104170305.4163840-10-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104170305.4163840-1-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|SJ2PR12MB8651:EE_
X-MS-Office365-Filtering-Correlation-Id: a30a7882-a478-43b9-5e1c-08de1bc445e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xP9MwyFxrN1FrjVCsVK56vux3hWcNac+bCYY89tfQ7YCINOCysPgGNrOWAOb?=
 =?us-ascii?Q?rW4Y7SNV/vDgj48GbIdMlL/zu+0ZelxTaDPGmsS3rlkmOKwO70Wx8YWjnSxQ?=
 =?us-ascii?Q?eSECNMZIUQM0e+5Qnm1pzOBsZVU6kpAqK+DNn/UHdvv/OK/NGsxJJd437aHc?=
 =?us-ascii?Q?5+PTEEJrGHcA2axYtKWxLUYtlqiQ+OrfWf0ynP5fgNpfeNdHCSydmv8Cdhur?=
 =?us-ascii?Q?GnEzEh+H1vqGKuDFpVHuCZa+lMgTGtk7R4uqVvgirZ7VSJDO8Gooch0+dV68?=
 =?us-ascii?Q?M2+3nmV+f80Gu/kC2xHNM20FCXyTHL5Fuj0dkhMOX0K7TH1+xpOn0CJkJv8q?=
 =?us-ascii?Q?mwKNTw4VsoNi+2DJN1MmEL7D8+jqO97mq5g3xzDp9/+OfBNsift2fwO2JrQm?=
 =?us-ascii?Q?6LxQoHdRLP8wGAgnUMMTUQVli1nVptVXrmO2ldU94aZ7VKOnFkS60aGXHu0A?=
 =?us-ascii?Q?PNri8Afo66qvTc8s0Q8SGVclazaw6/fufdwMlzkKxWSWuPUaPe+qrUJt1LCA?=
 =?us-ascii?Q?EdFEWe72rRifqG/4ruJqTVcbAd3r4Te3BM2pXJPCwqnSpxqAwo11wc8bPpMy?=
 =?us-ascii?Q?uEzANk9BH/jI4naHADEuN/eH09WtaYPElb1vpr7WbMPHsEyAtXiS+hubASNr?=
 =?us-ascii?Q?I1FySQub54bsfqnv5UTSvFLE1ZSZ1zQh8Eh2VJPA5Rnztmnbxw0ruv+SvQha?=
 =?us-ascii?Q?EUeikBgv0mGKh3sw2fFuC9eRzravjXwnDzoXChfDfXciiel7fHolq6oljtGB?=
 =?us-ascii?Q?sNpPG+ovy9IjgLmDIBhcr2BfaHR8raL7x6UOQSBVaryeqhyznSA+PFTMNQH+?=
 =?us-ascii?Q?EERD1OI+lF51yKzYfJRpogAZNZb1MPFzmuz9j0Ixo2mHwWQWePaBwu9AdNVH?=
 =?us-ascii?Q?E5xr++L8CT6Io67L7huxCG8c3oo0zt2mEzbN7QhjQjA6LbDDnFfWiuvQgb5I?=
 =?us-ascii?Q?GFt2BIRI79PHFVUWJziFFNJ+awmY9uMqKqLgqQiNhISFNMRWkcI7midy0dc8?=
 =?us-ascii?Q?OCxvDE/+e9PrcWYNTO5P/GNKdixeAMuH9PFuVYDPyt23dgduKvxqyWalftIf?=
 =?us-ascii?Q?stB3EeJUjjm8l0TcXEWUQt1UpUCxqAUF7SEEy12nA1/huErNeUplX5Iv0GEt?=
 =?us-ascii?Q?UcIotHLG/rAFJRfDbU6QtTblxw08tGevJ34U4s4rx45bAgrJKr6+lqJ50ROc?=
 =?us-ascii?Q?eBor6KMSJRVKbjgscmdMbPWBum81HuBTHeTwZi9JLPhxYzrXyeBjGNRIoLH7?=
 =?us-ascii?Q?2oFn9Q5ToSkn9xwYVNwtm8HiCC43naksY9Pe2l4CCrxQnk3hRqWzlzaH14Ku?=
 =?us-ascii?Q?8E7e+UBP3u/qhwp6DaRLoiV9dBe1SNYDXRd0lrygajinlSk7N88lM3cFu8kI?=
 =?us-ascii?Q?zuKpHp6CNVh0MkgiKxwzLoQ37Ondw+G2pe7PaNnuTvLF9lUzJE9TF39g1MgW?=
 =?us-ascii?Q?qYtTnXSGSBaCnLfZebP+Kp/pzqqoDQziXzCuDa6PPhp8nqCd4UVkgNaxM47i?=
 =?us-ascii?Q?NFrGdWAX4qivhBnOS/UbkTIT9qrKMxOKafsExg9bztQnpYUxcP2sn+2Jm83u?=
 =?us-ascii?Q?ZjpkGlqgsZ+rRg0uVgsPUKXU647qtuXCL6HWx9D4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:04:53.3201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a30a7882-a478-43b9-5e1c-08de1bc445e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8651

The AER service driver and aer_event tracing currently log 'PCIe Bus Type'
for all errors. Update the driver and aer_event tracing to log 'CXL Bus
Type' for CXL device errors.

This requires the AER can identify and distinguish between PCIe errors and
CXL errors.

Introduce boolean 'is_cxl' to 'struct aer_err_info'. Add assignment in
aer_get_device_error_info() and pci_print_aer().

Update the aer_event trace routine to accept a bus type string parameter.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

---

Changes in v12->v13:
- Remove duplicated aer_err_info inline comments. Is already in the
  kernel-doc header (Ben)

Changes in v11->v12:
 - Change aer_err_info::is_cxl to be bool a bitfield. Update structure
 padding. (Lukas)
 - Add kernel-doc for 'struct aer_err_info' (Lukas)

Changes in v10->v11:
 - Remove duplicate call to trace_aer_event() (Shiju)
 - Added Dan William's and Dave Jiang's reviewed-by
---
 drivers/pci/pci.h       | 37 ++++++++++++++++++++++++++++++-------
 drivers/pci/pcie/aer.c  | 18 ++++++++++++------
 include/ras/ras_event.h |  9 ++++++---
 3 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d23430e3eea0..446251892bb7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -701,31 +701,54 @@ static inline bool pci_dev_binding_disallowed(struct pci_dev *dev)
 
 #define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
 
+/**
+ * struct aer_err_info - AER Error Information
+ * @dev: Devices reporting error
+ * @ratelimit_print: Flag to log or not log the devices' error. 0=NotLog/1=Log
+ * @error_devnum: Number of devices reporting an error
+ * @level: printk level to use in logging
+ * @id: Value from register PCI_ERR_ROOT_ERR_SRC
+ * @severity: AER severity, 0-UNCOR Non-fatal, 1-UNCOR fatal, 2-COR
+ * @root_ratelimit_print: Flag to log or not log the root's error. 0=NotLog/1=Log
+ * @multi_error_valid: If multiple errors are reported
+ * @first_error: First reported error
+ * @is_cxl: Bus type error: 0-PCI Bus error, 1-CXL Bus error
+ * @tlp_header_valid: Indicates if TLP field contains error information
+ * @status: COR/UNCOR error status
+ * @mask: COR/UNCOR mask
+ * @tlp: Transaction packet information
+ */
 struct aer_err_info {
 	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
 	int ratelimit_print[AER_MAX_MULTI_ERR_DEVICES];
 	int error_dev_num;
-	const char *level;		/* printk level */
+	const char *level;
 
 	unsigned int id:16;
 
-	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
-	unsigned int root_ratelimit_print:1;	/* 0=skip, 1=print */
+	unsigned int severity:2;
+	unsigned int root_ratelimit_print:1;
 	unsigned int __pad1:4;
 	unsigned int multi_error_valid:1;
 
 	unsigned int first_error:5;
-	unsigned int __pad2:2;
+	unsigned int __pad2:1;
+	bool is_cxl:1;
 	unsigned int tlp_header_valid:1;
 
-	unsigned int status;		/* COR/UNCOR Error Status */
-	unsigned int mask;		/* COR/UNCOR Error Mask */
-	struct pcie_tlp_log tlp;	/* TLP Header */
+	unsigned int status;
+	unsigned int mask;
+	struct pcie_tlp_log tlp;
 };
 
 int aer_get_device_error_info(struct aer_err_info *info, int i);
 void aer_print_error(struct aer_err_info *info, int i);
 
+static inline const char *aer_err_bus(struct aer_err_info *info)
+{
+	return info->is_cxl ? "CXL" : "PCIe";
+}
+
 int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
 		      unsigned int tlp_len, bool flit,
 		      struct pcie_tlp_log *log);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f5f22216bb41..39e99f438563 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -868,6 +868,7 @@ void aer_print_error(struct aer_err_info *info, int i)
 	struct pci_dev *dev;
 	int layer, agent, id;
 	const char *level = info->level;
+	const char *bus_type = aer_err_bus(info);
 
 	if (WARN_ON_ONCE(i >= AER_MAX_MULTI_ERR_DEVICES))
 		return;
@@ -876,23 +877,23 @@ void aer_print_error(struct aer_err_info *info, int i)
 	id = pci_dev_id(dev);
 
 	pci_dev_aer_stats_incr(dev, info);
-	trace_aer_event(pci_name(dev), (info->status & ~info->mask),
+	trace_aer_event(pci_name(dev), bus_type, (info->status & ~info->mask),
 			info->severity, info->tlp_header_valid, &info->tlp);
 
 	if (!info->ratelimit_print[i])
 		return;
 
 	if (!info->status) {
-		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
-			aer_error_severity_string[info->severity]);
+		pci_err(dev, "%s Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
+			bus_type, aer_error_severity_string[info->severity]);
 		goto out;
 	}
 
 	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
 	agent = AER_GET_AGENT(info->severity, info->status);
 
-	aer_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
-		   aer_error_severity_string[info->severity],
+	aer_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
+		   bus_type, aer_error_severity_string[info->severity],
 		   aer_error_layer[layer], aer_agent_string[agent]);
 
 	aer_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
@@ -926,6 +927,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		   struct aer_capability_regs *aer)
 {
+	const char *bus_type;
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
 	struct aer_err_info info = {
@@ -946,9 +948,12 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 
 	info.status = status;
 	info.mask = mask;
+	info.is_cxl = pcie_is_cxl(dev);
+
+	bus_type = aer_err_bus(&info);
 
 	pci_dev_aer_stats_incr(dev, &info);
-	trace_aer_event(pci_name(dev), (status & ~mask),
+	trace_aer_event(pci_name(dev), bus_type, (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
 
 	if (!aer_ratelimit(dev, info.severity))
@@ -1309,6 +1314,7 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
 	/* Must reset in this function */
 	info->status = 0;
 	info->tlp_header_valid = 0;
+	info->is_cxl = pcie_is_cxl(dev);
 
 	/* The device might not support AER */
 	if (!aer)
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index c8cd0f00c845..85dbafec6ad1 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -298,15 +298,17 @@ TRACE_EVENT(non_standard_event,
 
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
@@ -315,6 +317,7 @@ TRACE_EVENT(aer_event,
 
 	TP_fast_assign(
 		__assign_str(dev_name);
+		__assign_str(bus_type);
 		__entry->status		= status;
 		__entry->severity	= severity;
 		__entry->tlp_header_valid = tlp_header_valid;
@@ -326,8 +329,8 @@ TRACE_EVENT(aer_event,
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


