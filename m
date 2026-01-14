Return-Path: <linux-pci+bounces-44820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E96BD20CC4
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E716F3019E1A
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C29C335074;
	Wed, 14 Jan 2026 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vqu70QBQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013046.outbound.protection.outlook.com [40.93.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B766C33509E;
	Wed, 14 Jan 2026 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415220; cv=fail; b=FFZEavitptnqmrFORq9znYYKNSYWQRUeOD+Zc1s6pB55Uv1JaKaqBtX/K+78GSmIb9nDgd/Wltpm4ubGP4FcDSVh1x0ACAuFc7W18izmFyPwqUhSfn384vu2cZ1B340AgqZwV1gPo0TMD4+4OvnKr8pIDcLfS8Mq/2py4nEaAo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415220; c=relaxed/simple;
	bh=SYoPOUPes3O2G30MotwPWNKamIdy6WrXo7ircUcevhI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGALkKozkOn/MBu87yM5goEEtgJ5SQbw34HvcG3zPVxP/JRGBbQ4h59o4YCuyaRWdg9SXpYNbdEx0uR8xDNBkCMVDePiRTb0TV6Wm7GvOgjeAS++q1dlT+qjygLOZ9YLMLIGJBtbdMuCg8jCsT62ggiDcNPNJ7xIaXMnt8z0Ajo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vqu70QBQ; arc=fail smtp.client-ip=40.93.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e211k10DWj8v7cXViWXfZqTi5TXWkIzs8d2MDOx61574eRSXXtf6pVxHUAFxMS9lkCJf37sTmJFtlKtx2FMOj49s9fh9/dZAwXX7k8JGb+pGeFBaRhPCzJ39hjsYj9PdXMzte2bHJOxXWnwfPvorF9KYPUXOAQ8NmPsh8jWjDyL1h4oh19uVswObipo9Zv7uBOOwEIKkUuTYgHbt9i9hMmjmzzrWln68cPChvjoTe2dFGQoKGvBzw5WhEwq6YAWO1H+MC3DtUjmbB4uipLEre/QWAW8OVyQ2QVq8RL65QcheBXHXfYG0POe44aHIuZNj2qh5MmDsjLFAFm5ENORS2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azeHrc/eF/Sft6KbrdkUg7KGblolwB0l+w1GJAV5Dd0=;
 b=NNkeaGY6V8XyLxUKMdbyGxNQMHN2h6z8ioTIT8hwtZxtejOAdPT42lyijho+XhCmQyrX6qoCaU2AOdJcbLGGjjfs+hGYl4Ogr+KL9r4gKEppDQIkBUYRZbRIAzwPYbsK+vH4mt3PKJYym6bx7d62IOjmNz4oje58zckLbKYLNRgAorRbZx7q6iCrrhHM7aSvKDfBaw4JFBQOtxZi9lqqZfl98pcWIDAv2s2xqD8BTLIqAGdhHARIcQrQbWw9K7LdPRz9TDL538FefpEc4Q+++vEtZJzYiqhNhMCMTYRBjtbVqmygrhSQ6RCyXaknecK7BH+UZqXGpnT4EMtmN+uQJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azeHrc/eF/Sft6KbrdkUg7KGblolwB0l+w1GJAV5Dd0=;
 b=vqu70QBQ395NMzcTMnAyXvleC8m6QNrGBG2e4HHmZwmegGCHTrz3g+mHp16M3KjIvHJaKGzQWU5Q8A6CbM4eDdePVVVGc8oOhxJNnQxYn2AyvQ7kKROBw9E54+IrwtdWBZ9Lm4NVoPswMxwx7D8541oH9IpM8ITjiPkkjnqRSu4=
Received: from BYAPR11CA0051.namprd11.prod.outlook.com (2603:10b6:a03:80::28)
 by CH2PR12MB9542.namprd12.prod.outlook.com (2603:10b6:610:27d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 18:26:54 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::de) by BYAPR11CA0051.outlook.office365.com
 (2603:10b6:a03:80::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Wed,
 14 Jan 2026 18:26:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:26:52 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:26:50 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v14 27/34] PCI/ERR: Introduce PCI_ERS_RESULT_PANIC
Date: Wed, 14 Jan 2026 12:20:48 -0600
Message-ID: <20260114182055.46029-28-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114182055.46029-1-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|CH2PR12MB9542:EE_
X-MS-Office365-Filtering-Correlation-Id: a6090c21-1cc6-41af-68e5-08de539a7d29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L1V6+obXr3r4lVqxEx6d8wxly8+H/pBJjKyYWqRmDpzS6jqjDd5O6veIl8Rc?=
 =?us-ascii?Q?V7pFEWZE8sVx8GgmPMBHTZV0lS3X4rjcpIhDo5teEoIohd+mWaMPsK+iu0FR?=
 =?us-ascii?Q?h9zft7WQP3S/aOdOB+WRAFXh1+qu3KyCt7dxtjEWRyoi72AfEOGjX7ABCueF?=
 =?us-ascii?Q?k9lVkfZx92EWia3muOD8djJjdt/UYlwk94LA/bDIgfrYcjibF3UA/RMpN4tn?=
 =?us-ascii?Q?xJkcjG4Zsgea7OoQPed/PqG2FoaSeCtiuDvmLGDjMiV5kvOwpkEe9xPtfrmN?=
 =?us-ascii?Q?RDdc6yzXS3+jfPii3ZJ4nN+Pr3+G4mzx2n8uBEeHlcbD6KUmi1jLri7PTkmR?=
 =?us-ascii?Q?+YmdjSYCiWAOO+4DlWMWgJ92B/O7N855UrR8AWstkScQFA420lvTEtkZO2E0?=
 =?us-ascii?Q?AVrHDGdBRHU7j4/0kveIWYiyvo99aXauVrm9k/RgFPB+sXybYfx7QhAjtPm1?=
 =?us-ascii?Q?Z8SaS9y1FW9PYBv9tB2MCgBDad51aAs1iy8GcJ735sRHBIM860YjQzRvWvHN?=
 =?us-ascii?Q?YTeLNJ61wr93nxOvNsZWSQSVeL3vH7a8uYAdZaEO87kHb0WulyZBXZhLc57p?=
 =?us-ascii?Q?dpE4ypKNDKBaC5OuqqhnFVPhDtkKg70MZ8L5TDeYRoGbMHWBEIhTPetprtfh?=
 =?us-ascii?Q?5A6exSKnIeaDnnYceWXvCruJzsWeEqC09Mn6J+HbPo6J4hXR2BI7WXYn6sAu?=
 =?us-ascii?Q?XcO0HpIOPol4DB9wLS7YL2eLrhJHYzwq67hpZixY1IsykLrVcHBdMLAUc56H?=
 =?us-ascii?Q?tjK6WIEogDqDyyAdqScWEvf7/ljwk9+DB7XqJtLzqPrqV4pZs986R8GFRtzu?=
 =?us-ascii?Q?NYyMEUKNQI8YgIQVGpy66x7EBjZbyLnCp+g7NKEz4ylDpVH73ZQPStstfe2Z?=
 =?us-ascii?Q?FdY3sfmTU1Rtb35NKv5STYlRjpcJTNLLv4FIRg3vjNr3/VRJOmGyw0hOc1B2?=
 =?us-ascii?Q?/FdWWpzTiE4DCyiPs5NfTdULL/PjDcm5gACaudpG3Om6O8JmNAP3iE+Q4/94?=
 =?us-ascii?Q?+t/gMJxrI7tnpkitKs2parZC6lPR/oaK+VFPD4vJuw0Kgeuohp0OYUTdnpY8?=
 =?us-ascii?Q?novDYINXpqPHI+z+tn/UDtBmWKeYz4jUd6XmqjoZJ3ahZHR4kHEvnyLEA0KU?=
 =?us-ascii?Q?DMgwC60TcfXA4rEVSb9FoTa3Yrbt4RRxlcJSqNNeJIfdAHewoYzSOPHEMx9j?=
 =?us-ascii?Q?BFqPhvbjPpEO5cBeLaBbKI1i732fL2TjJlRyGCBIKE1zNXPpfO3Ee1XuUIoM?=
 =?us-ascii?Q?1gJPKEaMYAplmEp5sx6hYQBDbaAdlXZrRASJaKrgOw91rUHjulJj9+VX8x8O?=
 =?us-ascii?Q?ra06BYn8J6GU6SlSkB3SR1UI0PAomGnEfmlyGtnbMF4oprlANiXNTg77gXxX?=
 =?us-ascii?Q?HJsZMrxRRqtBW9QRnpjWTrH1jkc/ELCAKCbvE7K+yN2AIuxyRyuh8+lrPIml?=
 =?us-ascii?Q?JSEAfy60ulsAX7D7ijk98eRnqvS89Eyw9DDBwQDokqGeQ9sFkMWzNinph3aN?=
 =?us-ascii?Q?1pi6y9/xOINGh0OiplFX0+Af/P21szj82Mr9yBPt+c0qLdj9HGZ84YQxM0/c?=
 =?us-ascii?Q?Ucmz80fE5wx/DTuqyf94mKcNyOvw/EPsycvFA1BhORQmvINrKKtT5Qhg5VZn?=
 =?us-ascii?Q?0DAibXPAkENKBdzcsl3+Im2833AlZIcHhwkS4mf9clKNiZ/0QBcgRw3kqT7F?=
 =?us-ascii?Q?YNHrvA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:26:52.1782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6090c21-1cc6-41af-68e5-08de539a7d29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9542

The CXL driver's error handling for uncorrectable errors (UCE) will be
updated in the future. A required change is for the error handlers to
to force a system panic when a UCE is detected.

Introduce PCI_ERS_RESULT_PANIC as a 'enum pci_ers_result' type. This will
be used by CXL UCE fatal and non-fatal recovery in future patches. Update
PCIe recovery documentation with details of PCI_ERS_RESULT_PANIC.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes in v13 -> v14:
- Add review-by for Dan
- Update Title prefix (Bjorn)
- Removed merge_result. Only logging error for device reporting the
  error (Dan)

Changes in  v12->v13:
- Add Dave Jiang's, Jonathan's, Ben's review-by
- Typo fix (Ben)

Changes v11 -> v12:
- Documentation requested (Lukas)
---
 Documentation/PCI/pci-error-recovery.rst | 2 ++
 include/linux/pci.h                      | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
index 43bc4e3665b4..82ee2c8c0450 100644
--- a/Documentation/PCI/pci-error-recovery.rst
+++ b/Documentation/PCI/pci-error-recovery.rst
@@ -102,6 +102,8 @@ Possible return values are::
 		PCI_ERS_RESULT_NEED_RESET,  /* Device driver wants slot to be reset. */
 		PCI_ERS_RESULT_DISCONNECT,  /* Device has completely failed, is unrecoverable */
 		PCI_ERS_RESULT_RECOVERED,   /* Device driver is fully recovered and operational */
+		PCI_ERS_RESULT_NO_AER_DRIVER, /* No AER capabilities registered for the driver */
+		PCI_ERS_RESULT_PANIC,       /* System is unstable, panic. Is CXL specific */
 	};
 
 A driver does not have to implement all of these callbacks; however,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f8e8b3df794d..ee05d5925b13 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -921,6 +921,9 @@ enum pci_ers_result {
 
 	/* No AER capabilities registered for the driver */
 	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
+
+	/* System is unstable, panic. Is CXL specific */
+	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
 };
 
 /* PCI bus error event callbacks */
-- 
2.34.1


