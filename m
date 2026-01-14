Return-Path: <linux-pci+bounces-44804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 521A3D20C89
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 040B6301515F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9ED2FFF8F;
	Wed, 14 Jan 2026 18:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uQTwvrhM"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBE8335552;
	Wed, 14 Jan 2026 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415019; cv=fail; b=Wv73gXWaE0CdNh5F8XU/83u8s9969X5QESwbZtcVmJ5mSCpO86PJgAkalvpgXC0DOlkgkA1O0nJEbyyRn/lm/xt24P8uyAxB+ZStvqp47hokRGkTKXa0Oa4eoYdRadpi3b+WgX0xI1jNQOLNgo4p2wR4ayuOypVBaAQs+I8ZxDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415019; c=relaxed/simple;
	bh=O4oHazr+1ROQRbOtkA8Ibwykfh+YjDK5Rfbbk4BbEtY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YzeDGtrBY/qCJKY1LUNkwfeLEzuZ17hfqq9aAAIUMLa6M13x7/ZW7D3Jt4s+/ei4pk9O7W+vziw2O9H8SgV8UZm+TqRzCnQY/H3LFxEw8RD3dFeoLKyulgpPQEy5LAx0FY+JId1hR2rQN9g+RAhXT+xOAAnjWNwDgHHy9p91vAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uQTwvrhM; arc=fail smtp.client-ip=52.101.85.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mM0eQfNbnql9NWkwUi/CZ7EudA7fPrbDPfOLA+5+73ytSSmxxE9qk9OJiPYRlRalw2rBm6KhOKBVzqX65ChH8nnB1K0uKNWBpv7xyo8qJTUzGsW8IeNhMNHgsKlHL2VV+Hs6cC79r55t+OCPgWQ/oA1BmjVTWCyN6whnJhJzd3fHevkbn9W5ns8HO276j9du1wPaAaVEx5eC4qEGP5nj1wLCrFso64q4Q7b+9SGfqHgJ3N0dQslcKpReyd5dEefN4WwpBe/UYpCaIJ9lm1YdL8X0XgUEd8YBaos7gQqWDVlPCLOoHVoi2zGHVyCLSBrQBq4TvScqKFByG3G9oJNgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9kZ6fB2coyrNS2bKN6NFRRSxLhSAZP1Rw9VYfU0Mn8=;
 b=F/Ndzr68oVtjjPnP/eM0wSdrFToHR31Nz2xeE3KtsAtbo8Mpbsk518cg0SFiONjUvu13C9e0ShLzAjMN54KzyQNth3R7Wl85ckfNo4Vyk50qY6IctIHiL7s+/DHgCpPkqOb+C8yJKEE9Voz0niM/vxMHHE1Zz1hpxwJ0U8R3uyBqwE0G4xiCR3H/rQysQQExEGbKliLcCrdRkcNBkw/f+mD8XTkWkQE6l30YI1UuWOj0y/ofOlWL+KoehDVVv3LOEoAF83L70gItbzMPOPkVQWtQihC55YmSgUPHGm+nm68SjDgjycRT9rKNS36x5FvBSJ4qEymYBUBjko5nbOT/QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9kZ6fB2coyrNS2bKN6NFRRSxLhSAZP1Rw9VYfU0Mn8=;
 b=uQTwvrhMS8CZodzChVkF0uDX8JAOgw3X25YWpz/D5U0UD4r6dWXrF52YjySPObQ9JELReByrj/GFKdhNWjMrGfsbDYuc/8uXFW63xP5wMoDDe/YQegzL6bF84jgjtsC0C23jbDrKnOH+3/PsBKGE1vChKDkZxCe8J9EixVtowEc=
Received: from PH8P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::15)
 by DM3PR12MB9414.namprd12.prod.outlook.com (2603:10b6:0:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 18:23:30 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::5f) by PH8P220CA0030.outlook.office365.com
 (2603:10b6:510:348::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 18:23:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:23:29 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:23:28 -0600
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
Subject: [PATCH v14 11/34] PCI/AER: Move CXL RCH error handling to aer_cxl_rch.c
Date: Wed, 14 Jan 2026 12:20:32 -0600
Message-ID: <20260114182055.46029-12-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|DM3PR12MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: 221bda68-1e83-453f-7ed4-08de539a0480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O4GFR1tDmo2STUmZR22VD3lxZOAIp5QMuaouRxuxDL3fYQBSRUcG4raGBJq8?=
 =?us-ascii?Q?/I1/2C3yTi4v9Mku+EsXyixQWSh4dreR3sQGbbH087W+GwNGWivHReDaPggf?=
 =?us-ascii?Q?e0GNAmuK+i66n1unzObg//kRqe6rpRs8jg3HWCLuRiF2gpgAbWBl9FX7n/l9?=
 =?us-ascii?Q?TSKM6ZSrtTWXlZcv1Zsv/9LQ8vqwf8kGnmYnukwYN7HnNfTG8giffjhAgLkT?=
 =?us-ascii?Q?BtpJZXdTS938nVm2RJ/fNSyEIEjj5KcET5qi5CjmlCrgN1+oPxiLOZtjLjKf?=
 =?us-ascii?Q?XBf0ikyhGpp+PbLD2eI1limt4/JLAMFw6zklGEY1pZyLiKM0T4z15xkUw2GN?=
 =?us-ascii?Q?aV0ejXyJnBtfG8rVZzLQAjiXNVMPURxGK6765viY4cHwmZdJFq7+LHtWHttN?=
 =?us-ascii?Q?GoF/pRGSaROOnJxEmHmE2IfN/tSj6OGdIf/LHTCg96c2X251bG0NmgAWxFRM?=
 =?us-ascii?Q?N1gVlCzXntSgAh7X0fKgfHxdQZf4VDdSNpM3HXogBD0w8TpAQaaFVNKsL1ve?=
 =?us-ascii?Q?BM3CWmE5ug3su1JlBRBWkRJICARmA5bir5gMNv+uaokUkt9f2+iSKdOdss2e?=
 =?us-ascii?Q?83fe0/6TcTBU1tzKNxhfqVEeXDb0+NsxFynNI0OOqxIXAnVQ1b/pcqrjDg53?=
 =?us-ascii?Q?f1tGKtSAhMIwpcO8VoBDlFaOeP7fVkMtacMw3t+6KfvH5qADV1L46/utGCgY?=
 =?us-ascii?Q?qpnRcw+EhWEbWdyy+6o432xvZMr/uGbYtPMYNpLvbOa2KwM7P1vEbS9NSplY?=
 =?us-ascii?Q?6H2omuG7MLMQUDCkr5UhNna1ciUDSlThimu/e1zfPJ+uTl7CIud4KCmgJKwk?=
 =?us-ascii?Q?+1fmlG1VT1qIGtjjM/3OmXc7DCagrtk6W9MUi70sQI0w7mHeUtZlslWGWzJt?=
 =?us-ascii?Q?Yoak4eWl++kwa0wrqDb98jeAs+iDw03Sypxg8zRve0U6tuQrw6EdxpETRsJR?=
 =?us-ascii?Q?gVlWZC5NDq/pHUJ2ocTDphPZ14AaW07xilUeY7H7CIiwlPI/uPWkYurMgZ++?=
 =?us-ascii?Q?ztKs0CB3WxgA8yyuaNUbWFX44ugypqrcU9gNG1f4OttfMlNcesPmAkSOgZ5k?=
 =?us-ascii?Q?vP3MiWLOWCVH3T9Yui6vp6b5+IS6C37BgS6hVsMDowO2OqWDuKnidmaEStsg?=
 =?us-ascii?Q?c3RpL8lLXCcC8DHM8Rx+Kz0tluou7RN4zCDF7cBlqc8pOZ9QQGhmJIB4Z7Gn?=
 =?us-ascii?Q?n4PZxmlv4l9kcyAFnT+i22x46OPHs1NBDjQzAXnkmAW2KbEZH6Vd7YLxhGZZ?=
 =?us-ascii?Q?Hn3xjljj4xCrTtPNCa+J9mtZMmXA2LoDfjq4CilHVunfiYAjzxqbGJ9HircO?=
 =?us-ascii?Q?4YppK63QuEGNOgtilhBmU39iNim4KXXzERfwuXPbRqIJZKZLCpPltmzOtoWj?=
 =?us-ascii?Q?yF73ycmD8HnKzev8GJLf/ZW7KjaJ7UUmL40NK9wwnoZmvjPvcaWhm2aBGHhN?=
 =?us-ascii?Q?NCML4xvsZX40yvbelwKHTqux91+21NFI/pdH1c8/LZbxKYx5szMBrUVXk6RA?=
 =?us-ascii?Q?NYzUHJnxX1FP8WSbw9yS5XYC0WViF+hHFjgQGO6hq5IyOdmO3b4XXemnKBA3?=
 =?us-ascii?Q?oK549N5em0d69Gl8PwTfRVIRn1TPWU4om+/2roOgSoPxLyME88+7IrtBUqjg?=
 =?us-ascii?Q?J89Vkx2vho1q/ddSFDSRkyBAOoDyxbLZIpmYsien8WZLGgz+tom6JwJ+1SVn?=
 =?us-ascii?Q?ueWDA/MO1ypzEivUFG8MSp1oBKw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:23:29.7889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 221bda68-1e83-453f-7ed4-08de539a0480
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9414

The Restricted CXL Host (RCH) AER error handling logic currently resides
in the AER driver file, aer.c. CXL specific changes conditionally compiled
using #ifdefs.

Improve the AER driver maintainability by separating the RCH specific logic
from the AER driver's core functionality and removing the ifdefs. Introduce
drivers/pci/pcie/aer_cxl_rch.c for moving the RCH AER logic into. Conditionally
compile the file using the CONFIG_CXL_RCH_RAS Kconfig.

Move the CXL logic into the new file but leave CXL helper function
is_internal_error() in aer.c for now as it will be moved in future patch
for CXL Virtual Hierarchy handling.

To maintain compilation after the move other changes are required. Change
cxl_rch_handle_error(), cxl_rch_enable_rcec(), and is_internal_error() to
be non-static inorder for accessing from the AER driver.

Update the new file with the SPDX and 2023 AMD copyright notations because
the RCH bits were initially contributed in 2023 by AMD. See commit:
commit 0a867568bb0d ("PCI/AER: Forward RCH downstream port-detected errors to the CXL.mem dev handler")

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes in v13->v14:
- Add review-by and signed-off for Dan
- Commit message fixup (Dan)
- Update commit message with use-case description (Dan, Lukas)
- Make cxl_error_is_native() static (Dan)

Changes in v12->v13:
- Add forward declararation of 'struct aer_err_info' in pci/pci.h (Terry)
- Changed copyright date from 2025 to 2023 (Jonathan)
- Add David Jiang's, Jonathan's, and Ben's review-by
- Re-add 'struct aer_err_info' (Bot)

Changes in v11->v12:
- Rename drivers/pci/pcie/cxl_rch.c to drivers/pci/pcie/aer_cxl_rch.c (Lukas)
- Removed forward declararation of 'struct aer_err_info' in pci/pci.h (Terry)

Changes in v10->v11:
- Remove changes in code-split and move to earlier, new patch
- Add #include <linux/bitfield.h> to cxl_ras.c
- Move cxl_rch_handle_error() & cxl_rch_enable_rcec() declarations from pci.h
  to aer.h, more localized.
- Introduce CONFIG_CXL_RCH_RAS, includes Makefile changes, ras.c
  ifdef changes
---
 drivers/pci/pcie/Makefile      |   1 +
 drivers/pci/pcie/aer.c         |  99 +-----------------------------
 drivers/pci/pcie/aer_cxl_rch.c | 106 +++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h     |   9 ++-
 4 files changed, 114 insertions(+), 101 deletions(-)
 create mode 100644 drivers/pci/pcie/aer_cxl_rch.c

diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 173829aa02e6..b0b43a18c304 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
 
 obj-y				+= aspm.o
 obj-$(CONFIG_PCIEAER)		+= aer.o err.o tlp.o
+obj-$(CONFIG_CXL_RAS)		+= aer_cxl_rch.o
 obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 2527e8370186..b1e6ee7468b9 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1145,27 +1145,7 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
 
-#ifdef CONFIG_PCIEAER_CXL
-static bool is_cxl_mem_dev(struct pci_dev *dev)
-{
-	/*
-	 * The capability, status, and control fields in Device 0,
-	 * Function 0 DVSEC control the CXL functionality of the
-	 * entire device (CXL 3.0, 8.1.3).
-	 */
-	if (dev->devfn != PCI_DEVFN(0, 0))
-		return false;
-
-	/*
-	 * CXL Memory Devices must have the 502h class code set (CXL
-	 * 3.0, 8.1.12.1).
-	 */
-	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
-		return false;
-
-	return true;
-}
-
+#ifdef CONFIG_CXL_RAS
 bool is_aer_internal_error(struct aer_err_info *info)
 {
 	if (info->severity == AER_CORRECTABLE)
@@ -1173,83 +1153,6 @@ bool is_aer_internal_error(struct aer_err_info *info)
 
 	return info->status & PCI_ERR_UNC_INTN;
 }
-
-static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
-{
-	struct aer_err_info *info = (struct aer_err_info *)data;
-	const struct pci_error_handlers *err_handler;
-
-	if (!is_cxl_mem_dev(dev) || !pcie_aer_is_native(dev))
-		return 0;
-
-	/* Protect dev->driver */
-	device_lock(&dev->dev);
-
-	err_handler = dev->driver ? dev->driver->err_handler : NULL;
-	if (!err_handler)
-		goto out;
-
-	if (info->severity == AER_CORRECTABLE) {
-		if (err_handler->cor_error_detected)
-			err_handler->cor_error_detected(dev);
-	} else if (err_handler->error_detected) {
-		if (info->severity == AER_NONFATAL)
-			err_handler->error_detected(dev, pci_channel_io_normal);
-		else if (info->severity == AER_FATAL)
-			err_handler->error_detected(dev, pci_channel_io_frozen);
-	}
-out:
-	device_unlock(&dev->dev);
-	return 0;
-}
-
-static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
-{
-	/*
-	 * Internal errors of an RCEC indicate an AER error in an
-	 * RCH's downstream port. Check and handle them in the CXL.mem
-	 * device driver.
-	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
-	    is_aer_internal_error(info))
-		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
-}
-
-static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
-{
-	bool *handles_cxl = data;
-
-	if (!*handles_cxl)
-		*handles_cxl = is_cxl_mem_dev(dev) && pcie_aer_is_native(dev);
-
-	/* Non-zero terminates iteration */
-	return *handles_cxl;
-}
-
-static bool handles_cxl_errors(struct pci_dev *rcec)
-{
-	bool handles_cxl = false;
-
-	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
-	    pcie_aer_is_native(rcec))
-		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
-
-	return handles_cxl;
-}
-
-static void cxl_rch_enable_rcec(struct pci_dev *rcec)
-{
-	if (!handles_cxl_errors(rcec))
-		return;
-
-	pci_aer_unmask_internal_errors(rcec);
-	pci_info(rcec, "CXL: Internal errors unmasked");
-}
-
-#else
-static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
-static inline void cxl_rch_handle_error(struct pci_dev *dev,
-					struct aer_err_info *info) { }
 #endif
 
 /**
diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
new file mode 100644
index 000000000000..6b515edb12c1
--- /dev/null
+++ b/drivers/pci/pcie/aer_cxl_rch.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 AMD Corporation. All rights reserved. */
+
+#include <linux/pci.h>
+#include <linux/aer.h>
+#include <linux/bitfield.h>
+#include "../pci.h"
+#include "portdrv.h"
+
+static bool is_cxl_mem_dev(struct pci_dev *dev)
+{
+	/*
+	 * The capability, status, and control fields in Device 0,
+	 * Function 0 DVSEC control the CXL functionality of the
+	 * entire device (CXL 3.0, 8.1.3).
+	 */
+	if (dev->devfn != PCI_DEVFN(0, 0))
+		return false;
+
+	/*
+	 * CXL Memory Devices must have the 502h class code set (CXL
+	 * 3.0, 8.1.12.1).
+	 */
+	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
+		return false;
+
+	return true;
+}
+
+static bool cxl_error_is_native(struct pci_dev *dev)
+{
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+
+	return (pcie_ports_native || host->native_aer);
+}
+
+static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
+{
+	struct aer_err_info *info = (struct aer_err_info *)data;
+	const struct pci_error_handlers *err_handler;
+
+	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
+		return 0;
+
+	device_lock(&dev->dev);
+
+	err_handler = dev->driver ? dev->driver->err_handler : NULL;
+	if (!err_handler)
+		goto out;
+
+	if (info->severity == AER_CORRECTABLE) {
+		if (err_handler->cor_error_detected)
+			err_handler->cor_error_detected(dev);
+	} else if (err_handler->error_detected) {
+		if (info->severity == AER_NONFATAL)
+			err_handler->error_detected(dev, pci_channel_io_normal);
+		else if (info->severity == AER_FATAL)
+			err_handler->error_detected(dev, pci_channel_io_frozen);
+	}
+out:
+	device_unlock(&dev->dev);
+	return 0;
+}
+
+void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
+{
+	/*
+	 * Internal errors of an RCEC indicate an AER error in an
+	 * RCH's downstream port. Check and handle them in the CXL.mem
+	 * device driver.
+	 */
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
+	    is_aer_internal_error(info))
+		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
+}
+
+static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
+{
+	bool *handles_cxl = data;
+
+	if (!*handles_cxl)
+		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
+
+	/* Non-zero terminates iteration */
+	return *handles_cxl;
+}
+
+static bool handles_cxl_errors(struct pci_dev *rcec)
+{
+	bool handles_cxl = false;
+
+	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
+	    pcie_aer_is_native(rcec))
+		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
+
+	return handles_cxl;
+}
+
+void cxl_rch_enable_rcec(struct pci_dev *rcec)
+{
+	if (!handles_cxl_errors(rcec))
+		return;
+
+	pci_aer_unmask_internal_errors(rcec);
+	pci_info(rcec, "CXL: Internal errors unmasked");
+}
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index e7a0a2cffea9..cc58bf2f2c84 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -126,10 +126,13 @@ struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
 
 struct aer_err_info;
 
-#ifdef CONFIG_PCIEAER_CXL
+#ifdef CONFIG_CXL_RAS
 bool is_aer_internal_error(struct aer_err_info *info);
+void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
+void cxl_rch_enable_rcec(struct pci_dev *rcec);
 #else
 static inline bool is_aer_internal_error(struct aer_err_info *info) { return false; }
-#endif /* CONFIG_PCIEAER_CXL */
-
+static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
+static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
+#endif /* CONFIG_CXL_RAS */
 #endif /* _PORTDRV_H_ */
-- 
2.34.1


