Return-Path: <linux-pci+bounces-40171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA4AC2E8B1
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C35234ECE53
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83266186E2E;
	Tue,  4 Nov 2025 00:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KP1Rqn5t"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010032.outbound.protection.outlook.com [40.93.198.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58D176026;
	Tue,  4 Nov 2025 00:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215178; cv=fail; b=uBVs69bSNq1m8YfcR6f1z2QgSRSnJmIsk0YvzMnDKv7NC/2/+DcT2D3CJuxO8EYkEYam/AIM+NtD/jB9OJuy5N44yuXgZdlb53DUJc2UpSdyEEnNq6bLvMN1vfouz6MTKTeag/kmfTmMiKtPFuwI+SpNPqh1rqgSJnO5/2hbMq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215178; c=relaxed/simple;
	bh=jYpSg8BUMU5uq3/sC7BfEYjhd/7FwHXH7JXGQMWPS9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HHhoaV+qSpfTVknQ4r0cHPy40NDOwW0Hz6yWwcC/y32847kT63rqY7VSlOhrDgMDmIZQjTNmqZt9zgHufE82lxcQNjOPcm7PgXl6esmrKz3UJY3fGMaHF4iX9lD1kzVJ2+7/JG/47C8ZUkxBWuZwXAo/zYnWLUzsOseOgE20zW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KP1Rqn5t; arc=fail smtp.client-ip=40.93.198.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdcoOd1NobMLtOgccWSKMxsoPyYKVsoDLz16uvHQwzo8c5ryGruLr4WZdU+YLX45/jXH1m/CGzsN+/FnRYBcuJfbVSBJwXQ/YZAxQEbit50WRuzPvXjK9yVzittPDRj2S47R7+Zpg+q1r09oSriWfUJBlnN6y/qynkyktNZ6J8TZBTI2uscgU91yMRR10ASmWT1UgrP1yVNKL8pakY7gMM8T8SwOACZqDDe38aZgdC7u6F9jVnHnAn/rXLDXQ3TBHWSNGjC70Ofe+Z4p2hJlM239GJJuCUFw56E3BrZCk9l5pEoXb6EJtxF3/BLqLStx8LSf25RfR87mQc8A254zbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpcJCPtg5qodL8K5bXMNbjXYGZGPqY+JpbrwVrnrX7Y=;
 b=TRLh33AKteLH/Ske5tXO8W0RQCnMxQ8LoXdwa83i8Hvc2kckw9uEv+8qVMxRN1wGGT7PscWJCPvoPal4vDhOwORdl+5gurZQfqmIc/p0p7TS2IGetRdWrW1WGRTOjT5aGGL1F1QWcArEIX26Qk/ptFKGAbWiUA3pmA/XPkHcTkZxgA1bDXXI3kQJ25hyBJkXfq3cAWh2uC/U+Ih/ha+aLmvK4A4CG11405WnbBZ2GL1H42mEEalCfo40iJMr6LpjAbm8TUp7v3CPGbUlRAzp5F/3UJybK28oCbRknoieUl1znL8Ugqf0Apw4XnAkh1G/6Cj+1Kvm9ciVUj6y2GgCOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpcJCPtg5qodL8K5bXMNbjXYGZGPqY+JpbrwVrnrX7Y=;
 b=KP1Rqn5tPZ9qcywqELkkOL3Te7+YqEWiIEk8WPoF7FJTqyB4PBU6DNLtP7LL95a2pVBeevjHGkcEEfKbgo65yu8onmekkBN+GbSvXyEL6jzfI18tB/ABChOMwgR2nXIZB4G/iDxXbywZE/Tt/GNkiAuVDYuaZMyr1udLrQRswGI=
Received: from CH2PR08CA0003.namprd08.prod.outlook.com (2603:10b6:610:5a::13)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 00:12:54 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::38) by CH2PR08CA0003.outlook.office365.com
 (2603:10b6:610:5a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 00:12:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:12:54 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:12:53 -0800
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
Subject: [PATCH v13 15/25] CXL/PCI: Introduce PCI_ERS_RESULT_PANIC
Date: Mon, 3 Nov 2025 18:09:51 -0600
Message-ID: <20251104001001.3833651-16-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104001001.3833651-1-terry.bowman@amd.com>
References: <20251104001001.3833651-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: ddee17db-66cd-4ff8-6aae-08de1b36e695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dmXV5hJpnzKl16sJc+FHzL76aTBfek0PMAWGwTvPo/98A9Lp90dEiF+E6Dmc?=
 =?us-ascii?Q?vl6pyncDdPuNA0lzvlrx20VuLaQbPybSbMB2Lk1MkMBVPOUddXW+LTYnaoVP?=
 =?us-ascii?Q?2kHDLIEBEom16lbDcc4V/bR6Hj31cWdBvTNELT54fbeWAXYfNbqnisK0S9sK?=
 =?us-ascii?Q?8FLZROjvuNbBy3a9EjblCFxLv2C/r7cvj5vxkib24sR6mIIAeUEu3WFsLkK6?=
 =?us-ascii?Q?f2pKAcMpiv2B6Za01gtcdirX4i0laDmWEQfiHQhJ4oZZhfCs3HC1Z++5ulM7?=
 =?us-ascii?Q?JXbN2pbgLxhUxUAOh6qt8SS+ux/vhhdIK8BlN2FYkhG8EJVgVrgBNEOrcVKv?=
 =?us-ascii?Q?nzoGRxOH6xX10Z8GnciPdmPdWvHvXjkEQoFx1/wJs+CjqjekrxtPR4ijiOY3?=
 =?us-ascii?Q?IRetHsrCETy6/CfuabYGknBhqiUvGYRa475urLznkezhZhGIbMxGWpSj/+Lt?=
 =?us-ascii?Q?yAMwsYL4DtOeLOkEVUVy2h/snrHeMvq1QyooUbVbjLOMhWxr70vP2BUSU5EH?=
 =?us-ascii?Q?YjE9GagusBXwDhIEBqzTcJxtSuwK4vxIjhPqNepIgy65z/e7ZXtHOj2ok4Br?=
 =?us-ascii?Q?HbKt+501kj+cGlO1sT7MnbMmgjd+SWObLP4Fyf94Jc0XUSoTQ5wnkKWxYkHS?=
 =?us-ascii?Q?8iKZIzEuXByK6oDPPwUIM+t8CeMIR59e0tFxQKn1N+9GPR1ea1z0tGEJt6Id?=
 =?us-ascii?Q?88BzIo63YDSRGZtSRr6Ul2s+4XcyVBV6j7b3PbNGIOqZ/K64MEOH2lg4lIHh?=
 =?us-ascii?Q?oB7g/t9ln8+3rUN8zP0OS6OuSgISiBL0ATXIWPdbVp5p84Zofp32WdtKc7XJ?=
 =?us-ascii?Q?chpWhU90U9IJYBNUC91+On41YbX79t/zWa3QjMWRj8nNoi6UivdYuxLc6wNo?=
 =?us-ascii?Q?BQ9DvsRzO9gIH+u+JR6vZkXhXLkfFPVvrKFjDbIJpkra3mQqX/GizUrFmzJG?=
 =?us-ascii?Q?lSU+ZJPl0NJsf8G21G8c8vP40KnZ64ECRs3VLnRFiyerpuBaLqnyK3KIKc1F?=
 =?us-ascii?Q?PznylM5BILxMhHzLJY3It4rxWQXIZ6N8ryPNfIFHEc9n1s0MRO7EMj4ZRxve?=
 =?us-ascii?Q?eWt+uoraqGyrXvqluQkgWI4KTdNNxL3CgMOfGKA0oDy+i5xhmhil5iZSq6pL?=
 =?us-ascii?Q?53afGZF/WnHmFP1mULi8J6Ckx+uBSn5C1beWwJtU51bTVK/5H7xAfjeqC2qe?=
 =?us-ascii?Q?F6zZysoq2fNn+aDVKFbCgoGXKAE/km8RuY06qu1Y4o5ezOizyEQiyLAzEqGs?=
 =?us-ascii?Q?MZ1U5qTI/N0SEsvdPlMDMiYbk4IDHCpDqpFeviuqgbGm+fPUHJRdsx5tacYK?=
 =?us-ascii?Q?WR8+6kxcfvv0fxZhe8lzPgB7vp7ZMlqY0o3/+0DKtAhUsEXBGuAX7zkGm6Q3?=
 =?us-ascii?Q?WVf5dXAYQNQVzSAFNOcPf6CbFaQLfSss0IQgVk3F/+FQxiSFeJ/tYQf2wgcd?=
 =?us-ascii?Q?oU0qqRmUrULPdrT45tzqRo59YwMV4uIxDifSzOqjslIIzEFW7d36XMFFMkwp?=
 =?us-ascii?Q?HI8lAc+exTdhg4hc01aBvOQa8li5XbJ44tfPXcnzgfCaeAWPAn5wm7CCTNd+?=
 =?us-ascii?Q?gLb/UEWnB63imiLs3AE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:12:54.3350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddee17db-66cd-4ff8-6aae-08de1b36e695
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493

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


