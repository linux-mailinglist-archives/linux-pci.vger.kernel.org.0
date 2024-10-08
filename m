Return-Path: <linux-pci+bounces-14006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 904BA9959E6
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 00:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4764B22B74
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 22:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC10D21643E;
	Tue,  8 Oct 2024 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HliNjP42"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291092C859;
	Tue,  8 Oct 2024 22:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425841; cv=fail; b=NlkL2WH0vnfYFPt68fq/NzJrhocV11wES2oh0GZtAQZ6tlcmmbsCo1OvuCgvKr38lV+0DWC9DhlTv/5zu0SNbfLjXPTC3MUNyRiESgCBNBihSdwHl01m8nWHcozLZcS7bC1XDhv9Xoa2BBOEd2dmeW+aYbVMdteD4ozUpi4w+HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425841; c=relaxed/simple;
	bh=3ajCeJWwKGnIuIRxtZoHxudNg8Sh/rhnFW2YiHLoLsg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tWZW/5WYhlAXJPA52RZEM2iq1RKecstQkxdoxd/OB1Ij5xPRgsg7jfvq58zkGQzxFnpf5TZuFoiV+2D8LL6Ua0slMu+JL6S4zhPai07yL/7FRuEC3l5POW8JBVkO6/Yg6wcH1cNY1+Kb5RmvLFI10Y3PeJewlZUgu8TY7Z/raCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HliNjP42; arc=fail smtp.client-ip=40.107.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dnqhJNaFlNbg06zpbnWd9AUwqAXSmusK8V7zmrcLEOVxc8iV1bdfgNCANMyVFJL/lAlKs/tA5OUAtZCKZz4+1bosyA/NYOphjffFThvonB978HmM9QzOgGYGFqPYqEV5pNQB8ykvKv7wjZaKTN/ojXJHAofyvrLhwUaUMXedlqHqdAGOcidjaQpMr5QaMfLzMf6edcvOyrzy10XtB+QyVTJER8EOdeC4tmBFEd1k3EPI7K3PyeA/5RimEQ/ZF8hwCiHdQq+L9fN3VpG++lcLwZAEXji/gEmAVqoDXPtgA2gfLVwACgah520yhIOfgYzUlWtfxZ1cVPSds62AEHYIPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzeuONoSBQVkfMYVqHFiOWzK8/y4jh1+ot/IDWAMvdU=;
 b=nUIH3MnNz/D8ak4izxi70EfPzr3tUNCRu0JGxypAZo2Juz6Xla4b+vb//gYYLehUuu0pdsGyIdYr2Dfaygf82JXUndOBa9dAZG696ojs2ytSb+zCOzuRQaXMl/s2/2MAZ3GievEG89FPA7s6geUDPcnsP5SQmMq+ggNZRzSW+4fpPInD9OrWXj9sTljwiv9qK5+FAd7iHIpv1KbJ3il2QoZmDrYAHnKQnTmHszDBAN7XYpW0oJ+fs4mEAdL4QIerlwJp8N9642sYZvefQCI9i2klVrbO13odOnuhSggx9gKuYgIOANUQviQGp3ml3U/EXw1tWi/g/GKnxxIWY0SbRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzeuONoSBQVkfMYVqHFiOWzK8/y4jh1+ot/IDWAMvdU=;
 b=HliNjP42pghASFZmoEaIDdBjAZWhnYBgXhHoeizbXFw323vYFZNZ3iBfhTRO79RPOxIG2DsZC9mHp+XOugc07/Kr6gC4kCI0Y4u0CCyauvYe1TV7nWC8wCf8s06MEPrIJzkrt83BqIZN1WaSEzPsINaKO/h3rY6vbaXu5XTu2wI=
Received: from BLAPR03CA0090.namprd03.prod.outlook.com (2603:10b6:208:329::35)
 by SJ2PR12MB8159.namprd12.prod.outlook.com (2603:10b6:a03:4f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 22:17:16 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::2b) by BLAPR03CA0090.outlook.office365.com
 (2603:10b6:208:329::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 22:17:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 22:17:15 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 17:17:14 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <smita.koralahallichannabasappa@amd.com>,
	<terry.bowman@amd.com>
Subject: [PATCH 01/15] cxl/aer/pci: Add CXL PCIe port error handler callbacks in AER service driver
Date: Tue, 8 Oct 2024 17:16:43 -0500
Message-ID: <20241008221657.1130181-2-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SJ2PR12MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: dbbf03eb-a5d0-41d5-0394-08dce7e6f6fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?68BUTrfqrAkzFAo0Da87kN0FeUuI1sjuDq1G/qKHk/O+q//MFWxJ1ZQjpKvJ?=
 =?us-ascii?Q?TS9wzo/hvtaBZji1GaOBOnWY7iThQTSDYPiQ0O+yQAsaKBzc7qGXnXi0DCgj?=
 =?us-ascii?Q?oyXBNOyrT2/i+Ni4zG5pHrxUdhHRzU+YT3HALW648olO/YAIfUjw7OsbFGfQ?=
 =?us-ascii?Q?9TSfdBCKq8nqSXLvcyZ7iQiuuISVMCxCDzmKUH77dQeUjtvM661+GlJEXXQy?=
 =?us-ascii?Q?F5cCDw8czcNs9iF1wHBplb60iqq4kiCpaMiDV1Z0ck14RCC7Z4Y2JzfJqR8r?=
 =?us-ascii?Q?XWimlAZnGLPhVN7/o9SFMEHRLX5w7/1EH8Vuv+O3ai/71nm4XXjOhnY91yc3?=
 =?us-ascii?Q?ToRXAMz6qykHb17yJMq9GLFYkerwatMjEf/2b79Oog0Y3z4dtk1PytuSh6lu?=
 =?us-ascii?Q?KAQqU65zZVT6DGM66yJqt3OsRc71Jg2y5R1zoqwLaWl5yu+ugwsSmEdl3AN3?=
 =?us-ascii?Q?bV3KinTM7/2VdKb0sVsMTChTbCAoOgyt5v7fcPUZWprXCqQRfiX7iskX/HTZ?=
 =?us-ascii?Q?nfp9SFbiBBtionmHoIfJmgX2N/3bMjQ18MjRocY3cfsHORXZMyoFtqLTOQXz?=
 =?us-ascii?Q?oExbSaqk4bMngYYHyZpayFzxowjL6pBDYWuM0S1Y+NZ0hw5lO73Tpa1Q1/RV?=
 =?us-ascii?Q?7Plvyu+LK1Y+IbyubswlqSufAIUOinM1Ppj9C9zqBz1/JNsZ77a2YRqhayZN?=
 =?us-ascii?Q?TLl5Nwcd33L/yAjyL5sZRDTukYmmg/nxRI/MzM5fw9SJeU92DCYpM+byBkf2?=
 =?us-ascii?Q?qr6JtY+kR1Ll+Gr+/1Rju1FpbBAy0uC6IK8lc/ZTDPJwr6EXnuIEPMBU3PtL?=
 =?us-ascii?Q?/57CGaTg96IiuJ2H73NwdWcmbkJhUlJTjA3JfXUEJVrZOvv9eV1kcGraVKfq?=
 =?us-ascii?Q?Zek4FKe6Y+CnYfQS1Feah10WT+zKokI1XVvtFJrPFam/SXCYZRYjex5n8C23?=
 =?us-ascii?Q?Afpc5hbvD2pSLnODGLoNiiZogkaXz1VTwNAt+Pqk97GYhkCOgF/HorcYDnyA?=
 =?us-ascii?Q?jkc0kG2XfSW3RHZgJvyFlOOX8M6D/sW7aC9QvnYfxlOadN/V/bX/geINB1WA?=
 =?us-ascii?Q?BZO5V8psZPrNI4qy/QCgyn6Gm26r0+H0BkXSVo4JmVLhjQwBWmY8KnUzNHL8?=
 =?us-ascii?Q?8wWRHNwMxz2w8b+U7lFY7zBShIMjzs8/NV4qQlQXz7mmv0lnRwhxfdubWiCW?=
 =?us-ascii?Q?eKm59ccE/jWI4kruKjjiM8ZhrUk9P9v81lBSCKONSWXjX7verDB7oWvOkEQu?=
 =?us-ascii?Q?RYMKhzsnXpf46hXpEBsOQ8PUCXgNstOFUEvW8Lml1eUYR7pIM02IaBUu+GOo?=
 =?us-ascii?Q?A1O2grd+CUlyVmwSnGXWoT8L89UgSgt75yHCg5skIGp4Zzw+hZ18z4bxAQ1r?=
 =?us-ascii?Q?+JkgOzTRwJGMf+vgipnypjqQ6TJW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:17:15.1323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbf03eb-a5d0-41d5-0394-08dce7e6f6fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8159

CXL protocol errors are reported to the OS through PCIe correctable and
uncorrectable internal errors. However, since CXL PCIe port devices
are currently bound to the portdrv driver, there is no mechanism to
notify the CXL driver, which is necessary for proper logging and
handling.

To address this, introduce CXL PCIe port error callbacks along with
register/unregister and accessor functions. The callbacks will be
invoked by the AER driver in the case protocol errors are reported by
a CXL port device.

The AER driver callbacks will be used in future patches implementing
CXL PCIe port error handling.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/pci/pcie/aer.c | 22 ++++++++++++++++++++++
 include/linux/aer.h    | 14 ++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 13b8586924ea..a9792b9576b4 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -50,6 +50,8 @@ struct aer_rpc {
 	DECLARE_KFIFO(aer_fifo, struct aer_err_source, AER_ERROR_SOURCES_MAX);
 };
 
+static struct cxl_port_err_hndlrs cxl_port_hndlrs;
+
 /* AER stats for the device */
 struct aer_stats {
 
@@ -1078,6 +1080,26 @@ static inline void cxl_rch_handle_error(struct pci_dev *dev,
 					struct aer_err_info *info) { }
 #endif
 
+void register_cxl_port_hndlrs(struct cxl_port_err_hndlrs *_cxl_port_hndlrs)
+{
+	cxl_port_hndlrs.error_detected = _cxl_port_hndlrs->error_detected;
+	cxl_port_hndlrs.cor_error_detected = _cxl_port_hndlrs->cor_error_detected;
+}
+EXPORT_SYMBOL_NS_GPL(register_cxl_port_hndlrs, CXL);
+
+void unregister_cxl_port_hndlrs(void)
+{
+	cxl_port_hndlrs.error_detected = NULL;
+	cxl_port_hndlrs.cor_error_detected = NULL;
+}
+EXPORT_SYMBOL_NS_GPL(unregister_cxl_port_hndlrs, CXL);
+
+struct cxl_port_err_hndlrs *find_cxl_port_hndlrs(void)
+{
+	return &cxl_port_hndlrs;
+}
+EXPORT_SYMBOL_NS_GPL(find_cxl_port_hndlrs, CXL);
+
 /**
  * pci_aer_handle_error - handle logging error into an event log
  * @dev: pointer to pci_dev data structure of error source device
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 4b97f38f3fcf..67fd04c5ae2b 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -10,6 +10,7 @@
 
 #include <linux/errno.h>
 #include <linux/types.h>
+#include <linux/pci.h>
 
 #define AER_NONFATAL			0
 #define AER_FATAL			1
@@ -55,5 +56,18 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 		       int severity, struct aer_capability_regs *aer_regs);
+
+struct cxl_port_err_hndlrs {
+
+	/* CXL uncorrectable error detected on this device */
+	pci_ers_result_t (*error_detected)(struct pci_dev *dev,
+					   pci_channel_state_t error);
+
+	/* CXL corrected error detected on this device */
+	void (*cor_error_detected)(struct pci_dev *dev);
+};
+void register_cxl_port_hndlrs(struct cxl_port_err_hndlrs *_cxl_port_hndlrs);
+void unregister_cxl_port_hndlrs(void);
+struct cxl_port_err_hndlrs *find_cxl_port_hndlrs(void);
 #endif //_AER_H_
 
-- 
2.34.1


