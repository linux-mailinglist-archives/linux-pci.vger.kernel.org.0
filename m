Return-Path: <linux-pci+bounces-15352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A45A39B114A
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 23:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27ECD1F27B33
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 21:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6218213140;
	Fri, 25 Oct 2024 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H+zCpy1i"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFCA20EA55;
	Fri, 25 Oct 2024 21:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890211; cv=fail; b=guA56N0qPq/tkmUFXtWnS8/t1uvvKQZvedDTyY6fD3qgSwkCHpNq9J3wMF9R6n626p6+aQN90V1uWUs2YJSHUYnyuycIfngLmh251utSDnVVPhoEiDeZPHflLfxKue7L4CdNDRe+Ww/yOe+xCfJl+O84+k1oZCx8B00hdXAa7/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890211; c=relaxed/simple;
	bh=CzfXmIaE0cpdI4NO4JzPEKzraqK+NSd/DiOSUgLFjCA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LG21RiRx+mo9xaO/HYsB75uKIkB3WFtfUCIpEBHTVw7f6fLU2l3jAsz5i7lA+C9stEUEacTjJKghEwimiruEvBHl7s+e9WFICuzkMkkPtyVERfXFviQ1zSFf8+05XOSy+VUoYDw+QNxU72ctE71FWdNUxM/mHceTGJ490m8Voow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H+zCpy1i; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIDLQbs5wR8St4z96sl7CvzwXcfHdhf+JLKsqwTAulSniaJjGphqnLqGejRe9zJ1SSX706g8x2MoFmyjo6BVjCxDntnhRcJWjrNpEeF/rFFvt30RYHoHogd+0ahNE18K8CtznUZAL1JIksZBrAGDBn5o/JeDZJYTOUjQb/Wzqt6tKCDknQeEyt4GZPFLfK6kiV2BdFI5IEfsEjKp/iXCetAx9AgguaJsKlka8QXYD5zI6eJSNAUzysRNh/xozjuTEy8Rq5mJCj6XRzyQbVHj8lPeCWAXTOS1TyMBxBAzRG3h0LUnm9VxbFx9XPEJ6DcTlzTjn5+j4APIfXI0lRwZ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4YPnP8xfTu4E3D4mZ0VQtiJJkSZl/mZ8f+jOzFr7jY=;
 b=rf/IZ9ZCmuaowpbjypfgCANOneZngLD5G+V4P80Hs/+dnl3r/j+OlyTVLV+gekIAqW9uJyx4B+dKmtS8SYPnM837CpM/SVT1V0tsG1pk90h2bjsLpuNyaMzzv+jNQK7YlgRMz4cy7iWBQTGtBtUt90FmMoQqOZGnXpHi8V2VWVKfT80I9uHFWwxEz1YGdxHTaX05RGM4zYnBZoYo8pupiocTiE8ykU8dcGZVsA1M4MofumuC4oOJgx7NJeooHThNXdcIlcoW1jWzbw5Wx4sCQCU6GTrIbM4vpiBhaxWEUT4egGnViTYBz70Aezy6EzIfPrS2fiVpRNODGYeeGbEzNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4YPnP8xfTu4E3D4mZ0VQtiJJkSZl/mZ8f+jOzFr7jY=;
 b=H+zCpy1iixAbMlzJPPc5zPMI9XHF27l/yXJH1WlinEcunlJJn7QGx3tNbWNTlLn9UJO7EN/s8kKDt4eRMCI3CTuQNSEi/78AGPV3Cl87FVOVtk8dNwFiLDvhR0Jq5ezp5ZrB6Z/5ez0epjhP15W26AwBMUuMnzo6nJdWH7Dfbc4=
Received: from MW4PR04CA0287.namprd04.prod.outlook.com (2603:10b6:303:89::22)
 by DM4PR12MB7645.namprd12.prod.outlook.com (2603:10b6:8:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 21:03:23 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:89:cafe::17) by MW4PR04CA0287.outlook.office365.com
 (2603:10b6:303:89::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Fri, 25 Oct 2024 21:03:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Fri, 25 Oct 2024 21:03:22 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 16:03:21 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 01/14] PCI/AER: Introduce 'struct cxl_err_handlers' and add to 'struct pci_driver'
Date: Fri, 25 Oct 2024 16:02:52 -0500
Message-ID: <20241025210305.27499-2-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025210305.27499-1-terry.bowman@amd.com>
References: <20241025210305.27499-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|DM4PR12MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: 205b2065-1b38-41f8-f38a-08dcf5387635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qchirn/nxDfcR2R0F8fsIkeDbGbCnK42QD0kleWt/iaQX0Y9d4ZItHVDOixA?=
 =?us-ascii?Q?35TgkR4Oo2aL4Fbfqr0AYrssQ8Meaa4IdH/yjdt4KhQ8kC5nMmZvpHeXTerC?=
 =?us-ascii?Q?I3P/4E46ZmGuZYX7IBPX2AG474QVGTKorZirOWfJfbuRfyX2o0gW7924L9EN?=
 =?us-ascii?Q?id0GHIJrqFF4ykPWIP0hDlKZnXGBNkRP3/COyewcfG0LvIwQA7IjfngZIZfe?=
 =?us-ascii?Q?ztOjyC/eECZJZdjL35mCVtFvJV/6fLV9hTY10LL9aAetQoM7gYmQqiEviOtt?=
 =?us-ascii?Q?Ouzx4cX2rdD40bcqpOh34EgAxLChNFWXGfHlEbgnxhvOwhTm94O/yIiDy8f0?=
 =?us-ascii?Q?91KXyGhK7PwUWFdMXNR0oD9gYLaLu2Cqggchaf5ULGebY3lkh0ZFxv/Yliu0?=
 =?us-ascii?Q?IJKZt5H3AsPyVGsU+uGz7PyQnODBKUKiGMcGRS+BpHMKTayIp1bxIB8cY//p?=
 =?us-ascii?Q?Yk5My7z4eRUqM73/wNRdbUE6F2JSH/5zBI/2SIbWyM129U/oo0i9JoIvTp/0?=
 =?us-ascii?Q?+wVr0packd9M2oZQE+x0EY8Dh/pc25FjXHmXE8vNZguYuPg5iMnZc2vVp10O?=
 =?us-ascii?Q?kpXoy+cLxMYHRINGnSGrLTT/+jaZih32d/Js4i7V/x/AnCkiGfAcb4hHcGK2?=
 =?us-ascii?Q?BuAwZfltF95ThPnQYQ0b/JXb57XS9XikBNT6q+ku1RKaXZvkF2LvrwMnZosI?=
 =?us-ascii?Q?CNay371QYcd5ptdVHd/NOmBzF0IXgF9dWL9BWltJRzZnE0MFo6FXyeevEVkV?=
 =?us-ascii?Q?l6FkAi2VueqQ/MhUGbVuZIWBCwQvrxDZLqd463HPkFenXeysaTMGtOmQGZOT?=
 =?us-ascii?Q?UB9l8nguPitT1Orq2aOMmHngeXfYoKhdn4cGqP4NhmA6vS5zchQCBfKz4DlN?=
 =?us-ascii?Q?Zup0x/ywuNHh0cz/z+ReD+A25EQf0uV6QF+LLliKDCw8Qt2M8LxiRdcTMURo?=
 =?us-ascii?Q?RlHekg17I3Ic853ke6HvA2HzM0lvgA6hod3W7gM0ImOaXAzLEyRbx10EvYrW?=
 =?us-ascii?Q?TbdJIm6g5YCjNz87cStALcORCDraOn3ue6PsrMU/Nn431wzrJLoIE7irE8hj?=
 =?us-ascii?Q?q//d5t8pI5BWHj0W4H3XZO9mZz6fygLhkpV649P1InXzFeXm0d76qUm8+CZR?=
 =?us-ascii?Q?ZAxMCGF5f1CzflQu1oGpGDEFJVkYUE+DerhpZ8QoP7I7u07kcCFw9g4pnd3S?=
 =?us-ascii?Q?2/RvGbK74JinVlEvbM/C6cJ/rmVR/lV35CSpWp+is8xuW2FH2yyWjiWOETTK?=
 =?us-ascii?Q?BVAiTQvkAP+kztzHaLfRL/wOGZoFvtF1Ih3pb8TCeMgERhZ+tQa1s5/OgFHQ?=
 =?us-ascii?Q?Gs+I6fnFwIeVmarXy7hgOFZRrm4eKqfXeCu7QV2+jNSCJCms3IEO4i+uArAw?=
 =?us-ascii?Q?h0eAyL215jaWCq3h0DJRJXiWMB/O?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 21:03:22.8113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 205b2065-1b38-41f8-f38a-08dcf5387635
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7645

CXL.io provides PCIe like protocol error implementation, but CXL.io and
PCIe have different handling requirements.

The PCIe AER service driver may attempt recovering PCIe devices with
uncorrectable errors while recovery is not used for CXL.io. Recovery is not
used in the CXL.io recovery because of the potential for corruption on
what can be system memory.

Create pci_driver::cxl_err_handlers similar to pci_driver::error_handler.
Create handlers for correctable and uncorrectable CXL.io error
handling.

The CXL error handlers will be used in future patches adding CXL PCIe
port protocol error handling.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 include/linux/pci.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be6..106ac83e3a7b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -886,6 +886,14 @@ struct pci_error_handlers {
 	void (*cor_error_detected)(struct pci_dev *dev);
 };
 
+/* CXL bus error event callbacks */
+struct cxl_error_handlers {
+	/* CXL bus error detected on this device */
+	bool (*error_detected)(struct pci_dev *dev);
+
+	/* Allow device driver to record more details of a correctable error */
+	void (*cor_error_detected)(struct pci_dev *dev);
+};
 
 struct module;
 
@@ -956,6 +964,7 @@ struct pci_driver {
 	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
 	u32  (*sriov_get_vf_total_msix)(struct pci_dev *pf);
 	const struct pci_error_handlers *err_handler;
+	const struct cxl_error_handlers *cxl_err_handler;
 	const struct attribute_group **groups;
 	const struct attribute_group **dev_groups;
 	struct device_driver	driver;
-- 
2.34.1


