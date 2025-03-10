Return-Path: <linux-pci+bounces-23290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48060A58E7C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 09:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CACA188C7FC
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 08:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40225224238;
	Mon, 10 Mar 2025 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ghCMQS9F"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9C9224249;
	Mon, 10 Mar 2025 08:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596366; cv=fail; b=E5G2KNoYUZhpkDd3//pnfxsMmv8ceAtCk78SCPhImNpjlUy/R2o4pPqXwzkMmEeVRGIN+IonTgHpCF3axgwfiqb7He4IJiMuneVqTNaY0d5cc0xRDGCxCH4ua2V/iLyll0QIU50TPcrQ1exyig7oVolPTcQG318wjXIscdBBa50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596366; c=relaxed/simple;
	bh=cZORULxFg5E3GH0yyU86L2BBf7zwwnLt19ra8YH+8S0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lYw6r5i8xcEovNGIlVXCnq/pDlHuYEwKBaCon7VB32C4vaNhiiW+KcMs+skDWMDA77ogtlP/DFNEOwNGqBSL803LRdFnELVz9DQ+xl1PtoF1v6s50mxFRMErBa1PB1EodVKjCuMj0/sZ2GbFRwow/mzGTnmp9m0vwcoS2I7LAs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ghCMQS9F; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZiFbpcov5yiweF5AepgP5YQ7foier9jvMj6gT0qkPNLSNjxkXpPfQt5bEWxqLCmRkZx5t5SDp4JGrhbLDzE/UIhNAVk6YIZ/ty1Pd/9AXHpDY1u+6pvwHuDanaGLF99LlFghfr3tpgAX65ta2k5YyxzxA8qADTtJ7yo+pGOUwfKzTWqGxEe4Mft71g+Mgyeh4j/Q8eUb89f1nRwqlZycZKVYjAa+NwgEgvvCRWPJqm+/OSnExyyp63T/oQQ57hTB06gQk7Z48+x7wkZQbAsbpDVoXCy6uJQ9RHIYuE0Qa5xe5MiPvGc0PyTioE684fw7xyHp1w+sEjFXUBrmchBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWKq+Pjftdfd/Roo+vfGNAZpfXrqiOEm6p2npguQ5Lc=;
 b=viPOhYmOIoHu//t9xL45arw6CUYWKzpH6M2uP8wOzglgGlRPILxPdEZWWUAc9KC0gnl/+sCLlW0H94vaGwkpyUh8K7iy3GxK2EhM9NV7lDUpbTmNoxubFilKwXNAfO9R2I+mqOrW/u8V7bTblynB4/aKN8UU4QreClB5gqSPpypMlbM7Ptotvt9K3DzBDZ0u7ww/iSJNRoggURHT/Lz3JOTj7sRN8VFlrBPBdiGkiGs+uP2Q74ldXvXEz163ViePgnoITGOX+xt3xYl9/EW5aQqGBpghQa/eZls7ae1nbJW6R7HfLpzb0A34Qy7ccFYafKNUs+KBwtdPDuUZojLfYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWKq+Pjftdfd/Roo+vfGNAZpfXrqiOEm6p2npguQ5Lc=;
 b=ghCMQS9FnFnG02oc8UdWH3nvPpoioUtHkWcrDLrkzYPzlhazLEg4B3liqI8T2YBS+M8Z3QxYXutORtXSXvkw/JwNFXA3YEhIWOAtrDegyNZheQsla0VvFA66lnMJAX0NIXhlBzf5QjQtnzA0PL9KfO3QUGRdpGQGCoGa86QEwF60PxNjE+67K5mPp9xjl1W288DnPhtXYAbkmhMd1Vu/1XDtryEfHCmtXEswb4zZ3FhYkXkAujNPOLwGmxsVxjXtVuTYCufbhOrD0XZCESl1nC06hrs/BbgFcXrOOiT3ParXARf9TWrP0t6HPf2UBZK99BCRP5CPBzYd+CSPuW1tJA==
Received: from BN9PR03CA0718.namprd03.prod.outlook.com (2603:10b6:408:ef::33)
 by DS0PR12MB9321.namprd12.prod.outlook.com (2603:10b6:8:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 08:45:58 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:408:ef:cafe::42) by BN9PR03CA0718.outlook.office365.com
 (2603:10b6:408:ef::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 08:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 08:45:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Mar
 2025 01:45:41 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 01:45:39 -0700
From: Shay Drory <shayd@nvidia.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <leonro@nvidia.com>, <linux-kernel@vger.kernel.org>, Shay Drory
	<shayd@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2] PCI: Fix NULL dereference in SR-IOV VF creation error path
Date: Mon, 10 Mar 2025 10:45:24 +0200
Message-ID: <20250310084524.599225-1-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|DS0PR12MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: b428ec44-c224-4a0a-2e00-08dd5faffa58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+uAlMM09FD4vvEGKVaHK3AfkOZJ4V+LOK05EoTTSgQbCR5NMZ+B4m2e9TXIp?=
 =?us-ascii?Q?9B47RDVC1JMWxMnuIWeA/tToqFYaDbxaazlJWtpzCRuqSrHrE21bXlbIn2en?=
 =?us-ascii?Q?//QcxkdBHZKgLIioT6H5ZrLZWokKdtDKgcjRbIDCjY29nllKhkMjoCoterPD?=
 =?us-ascii?Q?RkgjarPWELPUVpLzhFCeT+XFg4mYOrcvegKMephLT+POQtddOAFkjfvbLkkJ?=
 =?us-ascii?Q?pVLemHzcre8Q8qdDpMmuvl+gW4vI1s6+vvIN3xFpVZ22fOlIzEDx81JNJWF4?=
 =?us-ascii?Q?fY5Av4kKNwsxBSBVG6r5Rl8F8+91vHgyLbHkk1e4Qb2k4R666qbV/lD4WVWu?=
 =?us-ascii?Q?mDt50AMT2vxEH2gzNh8Tic5jnuzdQiI5UVMh6s7Wlq51A8TXsXiOE0VqXMoK?=
 =?us-ascii?Q?UH43BdBvA7WezQRDTWcKArLzA7tn6yS2z/qlLmVasF2A4vv4AntvGkhfDMQ5?=
 =?us-ascii?Q?E1IAg06zFKm74ostHyxEkgiwGfkhvR8YZRJHghr//idlZAzn9I3lmweN84Hi?=
 =?us-ascii?Q?UPTPiXZX3xyzKA/AWuVsTRq4JBzvar+m33nzo7vgOLkOBgfO94jmes9uLiiR?=
 =?us-ascii?Q?JuKoHZCMLJCdLur9DfvzNIl+KjAB5592IvNx8QZKPjQcHaaEGb1Qu1n0ZT9g?=
 =?us-ascii?Q?WSSeL8ohE5N44NqjxcahlwpSC6/rI/+Dx17JJMd/78SV43EBouzf/5T6kjvC?=
 =?us-ascii?Q?7S2Z8/G8EIOgIGJe7SoE3JEx2YKGLHEzp9JwuNRu3DOOcGwnBUSSzkvxyvvY?=
 =?us-ascii?Q?e295I1G7yC7GBjUkBFkaXpnOG0Zp4ovLnCD5P0GtD9RUQR95zh2P9SamFFBZ?=
 =?us-ascii?Q?OMercJGXGnQOUHnnVizjiSVWYDcY9eaft43vu5WiJ+AVqzoUvzkid1rayULj?=
 =?us-ascii?Q?urvWkmZhmiidN5FzaRqAuEr8HF021FgERDVeweDg2Xbd+dbp1pm1qjm6c1v/?=
 =?us-ascii?Q?sDd7UQj530sxI0iCMbqg/eqUrz0ILTQx+h90g0IUpeV2hx8OWgqcW28/Tx5y?=
 =?us-ascii?Q?BfMiTHOJGOEwZ28oU0fy/Qm2L6htmEhYtQJEUE0Ve5Zvbt6tURE9fUDqlkB8?=
 =?us-ascii?Q?gE08b7IHZtD5P9c7XyWdKt/C2VRw1F8NSbr+tyM/JmTohP/Va6MREprTV/E1?=
 =?us-ascii?Q?iKpzq1YOYBuP2xP7+z6zn2udj13q9dD0/VwZiY771XWp48sOa8+ZSKhixmB1?=
 =?us-ascii?Q?ZkxErwJgNFmWtzFDBoQ7DR7JH0Q+OCB4WDL9zdk7tIE8Hk8DOmhoAZ1oXkfT?=
 =?us-ascii?Q?s7asamw2qLNFbPBFGMA/XG5rxRa09K9414dtvQC1YKkfkqnrIHWjyUPjDeJo?=
 =?us-ascii?Q?7yXWnvvuWzo15NDtAcs8ICie4xd4abI0mDaU/v84RFzlE1Pb+VoFEUQu7X66?=
 =?us-ascii?Q?xJarJPpllW7MImzzV0pWaXDkVZS/PrDPpnIvjwlkKT35QhsNW4cTeMtn4YFz?=
 =?us-ascii?Q?iO82Y80cR4vRLjx+NuUu08xO8zbqi+Luh3mzhMQUxXM1GRaZjlfvt7tgEZbe?=
 =?us-ascii?Q?fw6qgJh2v/ra55U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 08:45:57.8601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b428ec44-c224-4a0a-2e00-08dd5faffa58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9321

Add proper cleanup when virtfn setup fails to prevent NULL pointer
dereference during device removal. The kernel oops[1] occurred due to
Incorrect error handling flow when pci_setup_device() fails.

Fix it by introducing pci_iov_scan_device() which handle virtfn
allocation and setup properly, instead of invoking
pci_stop_and_remove_bus_device() whenever pci_setup_device is failed.
This prevents accessing partially initialized virtfn devices during
removal.

[1]
BUG: kernel NULL pointer dereference, address: 00000000000000d0
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP
CPU: 22 UID: 0 PID: 1151 Comm: bash Not tainted 6.13.0+ #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
RIP: 0010:device_del+0x3d/0x3d0
Call Trace:
 <TASK>
 ? __die+0x20/0x60
 ? page_fault_oops+0x150/0x3e0
 ? exc_page_fault+0x74/0x130
 ? asm_exc_page_fault+0x22/0x30
 ? device_del+0x3d/0x3d0
 pci_remove_bus_device+0x7c/0x100
 pci_iov_add_virtfn+0xfa/0x200
 sriov_enable+0x208/0x420
 mlx5_core_sriov_configure+0x6a/0x160 [mlx5_core]
 sriov_numvfs_store+0xae/0x1a0
 kernfs_fop_write_iter+0x109/0x1a0
 vfs_write+0x2c0/0x3e0
 ksys_write+0x62/0xd0
 do_syscall_64+0x4c/0x100
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: e3f30d563a38 ("PCI: Make pci_destroy_dev() concurrent safe")
CC: Keith Busch <kbusch@kernel.org>
Change-Id: I7cee1123c90ce184661470dcafab45cec919bc72
Signed-off-by: Shay Drory <shayd@nvidia.com>

---
changes from v1:
- add pci_iov_scan_device() helper (Bjorn)
---
 drivers/pci/iov.c | 47 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 9e4770cdd4d5..9f08df0e7208 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -285,23 +285,16 @@ const struct attribute_group sriov_vf_dev_attr_group = {
 	.is_visible = sriov_vf_attrs_are_visible,
 };
 
-int pci_iov_add_virtfn(struct pci_dev *dev, int id)
+static struct pci_dev *pci_iov_scan_device(struct pci_dev *dev, int id,
+					   struct pci_bus *bus)
 {
-	int i;
-	int rc = -ENOMEM;
-	u64 size;
-	struct pci_dev *virtfn;
-	struct resource *res;
 	struct pci_sriov *iov = dev->sriov;
-	struct pci_bus *bus;
-
-	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
-	if (!bus)
-		goto failed;
+	struct pci_dev *virtfn;
+	int rc = -ENOMEM;
 
 	virtfn = pci_alloc_dev(bus);
 	if (!virtfn)
-		goto failed0;
+		return ERR_PTR(rc);
 
 	virtfn->devfn = pci_iov_virtfn_devfn(dev, id);
 	virtfn->vendor = dev->vendor;
@@ -314,8 +307,34 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 		pci_read_vf_config_common(virtfn);
 
 	rc = pci_setup_device(virtfn);
-	if (rc)
-		goto failed1;
+	if (rc) {
+		pci_dev_put(dev);
+		pci_bus_put(virtfn->bus);
+		kfree(virtfn);
+		return ERR_PTR(rc);
+	}
+
+	return virtfn;
+}
+
+int pci_iov_add_virtfn(struct pci_dev *dev, int id)
+{
+	int i;
+	int rc = -ENOMEM;
+	u64 size;
+	struct pci_dev *virtfn;
+	struct resource *res;
+	struct pci_bus *bus;
+
+	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
+	if (!bus)
+		goto failed;
+
+	virtfn = pci_iov_scan_device(dev, id, bus);
+	if (IS_ERR(virtfn)) {
+		rc = PTR_ERR(virtfn);
+		goto failed0;
+	}
 
 	virtfn->dev.parent = dev->dev.parent;
 	virtfn->multifunction = 0;
-- 
2.38.1


