Return-Path: <linux-pci+bounces-40247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E060BC32406
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C19AF4FB236
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D91B32BF40;
	Tue,  4 Nov 2025 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R3MzeVcv"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF7333B97C;
	Tue,  4 Nov 2025 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275966; cv=fail; b=cTJSXWbkdV+5W2QvfMJ469NhpUMqka7ZoZ9ZSR+4qeJplZ2ZG2xgoHMK8P732wVdQFqGRjoI+iOgOsHzAPeuowHCOgzRRd8nsNAk8xI/QGNOXZ89Oy9lKQ4ReLPZ2PEbL8xhBS289I/vGDuT66jgbYP39oq2KhZ6HgGOIIwt18I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275966; c=relaxed/simple;
	bh=jYpSg8BUMU5uq3/sC7BfEYjhd/7FwHXH7JXGQMWPS9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HGVCHpmSMZ7aJl5YSjnPbAr3OSXEjs+n1jtClp8UPIGe7/n1wS2ZZF+r26Q9uhh4goSu9gNkMs6dP+GJq5IwZAElvc698CH1XQfVaeHrDglTnYawjfqIbCI0bMGyFTeSgWEPg6yNS64pRGiMv4NhihMLOjCW5O8bJHfwByleRo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R3MzeVcv; arc=fail smtp.client-ip=52.101.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+T2zl+l8nWrPMUjSv6peU+MA0rq2d/z34+XC5ixvMtU/vAzip+KdSzrK+Cq4u0YsqS6wYYjtmCshhdqwj+5y70GlPW2woF+A1/cUcUc2ZWHo0NF1Rz2XysF19t6DNQ2/IzP2kCd3WBMazF/GLBTAyAk/DXgPoBUhgb2TLSoOkGd10/0FPdZYRqfzQafmqoYlOPccnIB09iNmlUUdzD/5dWbIdfWKgVSUBD2p+pOtoYQdGSikTpl7qjOVz3a4QS9htyQCJGBLAJEy0PVEoKwV5ziNi9bt9vKEIAuXIpe9BItJnijs+svy/Zsf2+GDRWlDrXQKw0iNWSZyzvq166sOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpcJCPtg5qodL8K5bXMNbjXYGZGPqY+JpbrwVrnrX7Y=;
 b=C5j4/+i8hZ9aUmvJXo/RCO7/pwdU8JGhni+gv/u6OnCdZiKpdd7//vgk+vnhQTPmPm8kVr4+pS9IENvjVWXpd2Vu3p2o+ZDsKEJlLdStAKUOp1yu9Jl9fA2YhvnVz+PqJtGpwGdwR9QO8TdfJRoh6SsOPsL1e3zJBWARKNyhyDy3CeH7R3fdSboeMwcBrvuptOc66b3HKkOp8avb6R7qqSLYOBookkyhgh7cLHtvIOJGoNHMFpngI32MqQ6j+IiVdhjst7fFjUCWJ/oWpjyeTMrJpRpdhI+Imo4mTr66gfT65vaELezDy/Peb1FG0rTc+8TujTTWXK5/up2bLiRt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpcJCPtg5qodL8K5bXMNbjXYGZGPqY+JpbrwVrnrX7Y=;
 b=R3MzeVcvr7RHdCzyEHmNPYW1Vs6PZyAaIo4tk4R3I0SUCsetiTIwkPbuYrdNZI3AAptBtimwz9OF4wfk2a0F5vpSD0OxXZOM2Cv3KgF5PlVjT/Aqad5LAS0vgjjClHAuFKOWDSiIltzw5gtKg/y+tO4VHYoe8C+L4j0oVG89slE=
Received: from BN9PR03CA0963.namprd03.prod.outlook.com (2603:10b6:408:109::8)
 by IA1PR12MB7711.namprd12.prod.outlook.com (2603:10b6:208:421::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 17:05:59 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::36) by BN9PR03CA0963.outlook.office365.com
 (2603:10b6:408:109::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Tue,
 4 Nov 2025 17:05:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:05:58 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 09:05:57 -0800
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
Subject: [RESEND v13 15/25] CXL/PCI: Introduce PCI_ERS_RESULT_PANIC
Date: Tue, 4 Nov 2025 11:02:55 -0600
Message-ID: <20251104170305.4163840-16-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|IA1PR12MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eab398f-8773-4b30-bf72-08de1bc46cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nnLsf1fksX7pJ5bkDNqLaC2Y6bdyqRfrOaMzPaYdxqfd8em/6ATkXS30hoIE?=
 =?us-ascii?Q?dFl5F+raYo8CEBocgMZKrjpSD2nXSsWAa5hleDbAuzedOovz4vu7LNq/Vezf?=
 =?us-ascii?Q?Ky/eEVwvJGDQKGOkC/SkYARBotu/M3zWgAm9LISFDlK0UJ3VzAvcazkH/UDe?=
 =?us-ascii?Q?8b8pOcNQzf/tWZMdnsiEnmGX1J0lD8R4A1xLvLoL5QctAcCTcpIoYoCFz7fu?=
 =?us-ascii?Q?zuYnebGNOvEqop9GKbnmTWMM1cysB/xhoLy8sCns3Y6xBd9ZsR9Rl1JfC+00?=
 =?us-ascii?Q?lMtqT7vubHAizKMcmALWOSc3rs7y+E7Fn8AW8qSRLZoHx36BUMVYQ28VkKBP?=
 =?us-ascii?Q?z8kdn6uD1c3fgbHlkRwQ8fgQLQegCNezePI1mPM7/C0cgm4ENBHg7XWDbjf/?=
 =?us-ascii?Q?49AHTNWV2AYNG6wOl6Qy6pzL1J6NnQliUL+QFdJ+QReWKnO2kWeNLCG4TxKu?=
 =?us-ascii?Q?sQNaq49xZ9TUx8yZ8KFg2GvSdwNDgB0k+qck5b7qchmuXdFHDEu9qC3Ot4l+?=
 =?us-ascii?Q?PujuVSQ7UKuQdVGawX5UbCfTUAg1u5V2Fa3/6IPTbW3oHPS7B8myVGnV+PhS?=
 =?us-ascii?Q?h6M7OhOeVxCeQO9Y9XFRGIQ8W4Ua6iL2OJvxVaUc6Xy4mCA3lGa7yixydtxT?=
 =?us-ascii?Q?2ddnPO+oWUPQ593MoXX+tRCauSevJrhdt+pXogeT7hmPBgZgBTy3s9WfigWK?=
 =?us-ascii?Q?Jt69k0saBm7C3EgD4Q7blgzbDxu2N8TPvKnb9F/76z6WvtPoG8lIC6DkQHke?=
 =?us-ascii?Q?kFx78GsDBeVZZghr04Na2NpMiLHSjzaIRk3JB/NlPwKbEOb9SGCvXDCST2hJ?=
 =?us-ascii?Q?Jcu8Su6RwVGW8BtTsmujAKxSftgvoq26bW/M/fJhPpC704pqDldE0qnGLa7y?=
 =?us-ascii?Q?ajwbjJFhoOGG5MSnxV6lTepS9+FTjKBFrlfghSdXoWyoYUc/InFUrjvRymKJ?=
 =?us-ascii?Q?yOMbydUF9YxG5IcdpZs2b6C1oFdj7WBJwX0bp/kDaGBd1IOuL+goNNP4Pzoz?=
 =?us-ascii?Q?4Q5Yln/MfWE4RLYooA4JSq1CS04+oq6eklAKGeSoffKN1tjEVRcq4CyWBsXn?=
 =?us-ascii?Q?cBq7CORSQrhTnpKn3kcYmXW68JrYzmn8w0XT5SshbywPk7ssoPOiuD9C11jR?=
 =?us-ascii?Q?6yD6adaN1QIyabxVDg7t8zE31EBMsw6xeqZZmdZRpblh4p1s52bXGqUIMoLb?=
 =?us-ascii?Q?ynhzBij0BhgDGV+jXqadOb3c/C5xmwZDaLF1W3Y+cnMDxkpeJgBcE/PXVwkR?=
 =?us-ascii?Q?DoD14A6RLLF032FHL7YjIWW99ZYY/kkvbQErb3dSWF2g1lkXYXa7hV2nlwXA?=
 =?us-ascii?Q?CATv7+f4HgPQ+7Jon6iJQ9ACiYIgWWfHjCtkWHdJs5IcIEO5gIou0pBrnBsx?=
 =?us-ascii?Q?e9RgIFQKV8lAx0Ao5RDP8E+kY651fgHG/R8FnvL19QUS4VLkYPvyVpRYzlgZ?=
 =?us-ascii?Q?iQbejb4gBz4PtC9VpXITyQQRFs+mGZdDsLDHKgb/XxtbHxJWCaJSWiUgCcDx?=
 =?us-ascii?Q?3RqxYZBPs7zWPHBP3M+cP6Rr3BabLkcB4utv/7McIDvq9K/yqChqF8mJisp4?=
 =?us-ascii?Q?Hy12ab/L3CFmva/zBY9efcqVrJaN+JPOYet64iku?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:05:58.8169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eab398f-8773-4b30-bf72-08de1bc46cf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7711

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

---

Changes in  v12->v13:
- Add Dave Jiang's, Jonathan's, Ben's review-by
- Typo fix (Ben)

Changes v11 -> v12:
- Documentation requested (Lukas)
---
 Documentation/PCI/pci-error-recovery.rst | 6 ++++++
 include/linux/pci.h                      | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
index 5df481ac6193..83505a585116 100644
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
@@ -116,6 +118,10 @@ The actual steps taken by a platform to recover from a PCI error
 event will be platform-dependent, but will follow the general
 sequence described below.
 
+PCI_ERS_RESULT_PANIC is currently unique to CXL and handled in CXL
+cxl_do_recovery(). The PCI pcie_do_recovery() routine does not report or
+handle PCI_ERS_RESULT_PANIC.
+
 STEP 0: Error Event
 -------------------
 A PCI bus error is detected by the PCI hardware.  On powerpc, the slot
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5c4759078d2f..cffa5535f28d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -890,6 +890,9 @@ enum pci_ers_result {
 
 	/* No AER capabilities registered for the driver */
 	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
+
+	/* System is unstable, panic. Is CXL specific */
+	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
 };
 
 /* PCI bus error event callbacks */
-- 
2.34.1


