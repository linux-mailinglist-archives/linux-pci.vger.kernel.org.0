Return-Path: <linux-pci+bounces-23292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6CAA58E88
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 09:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DF1A7A4AB8
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 08:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198C1221F13;
	Mon, 10 Mar 2025 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rTzrc7IX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3A211CBA;
	Mon, 10 Mar 2025 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596483; cv=fail; b=J/GXq7HZQkQmuQ02hBkBSmcc4J3wqR+Rzj2B8isN577qF/6jMIsUCmZcoXWKcPfC5jnlKkCHlsh4Sm4iCS6mv0P7LsZ3IlixElQ0StnRlIgMnYwhx0yZLda8Ppa+oYGWsI2HGr5T6Mz1LA6qStVNPW3WIDUev9UtrTH7wiX3PCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596483; c=relaxed/simple;
	bh=mwuR5hn1KMTwQQ03UN61tY4Vi8wmLn/Ia2DeZXycr3w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tW5pnhYh8Pmk8nGkmYZuRYRwlEnsfuA7hEMBKJlfKx9fVjTIQX831P5J/dewn0ANEwmxpAWIavLRHq6gbqH93iDOSzG/VatoBGgp8kdCdBcxvIQWUyynuF5j+i+HtWjjAvZuNtl3+GrGI+WOILb/hDlmfVGB7iXTVfF0ICR4sQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rTzrc7IX; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKyqXGkABovIcDDPuLII5oZgVTcG4vMsQxYhPEu9cT/8DBogwFeQ191snzb1QQ0XiacfhmjLIJUGNxzleSQxtR17s4Y5qmF9tBuMxxXBkzlhHyHx5y0/ScwJ9eA1iQZzDAo0P/eWHPF7ZpyvTGAKt9ujHYI6xqD0x8MSJsOPeRDon2rxHfR4ZV7R9O79603YzY4YDBEGmnrOjhA4FN7z35dtOMLAivVR8r0dVJBntiyebGN75eUQm5xTyZ6TPTIfmKa4drbAfh7mzJ26Dz+JeRrDMOc9EgMLRBC2ybIFGJY39Udq6kt844YaqIKJ7CKo+bXuoWK6Ia2/EQox8xiSSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMunXoIWe21UABGiqHKsLDXBvK7Al+5X1pSH6xVkrNg=;
 b=jtCHHeEz+77T15eA3vwsIkSxuR7ec+iCjnzzXkpwQV45XMj1+4Yc1M1s6Z+r1gclw/q5u0kzXfZbmS/6IdppRtdSprcGlfISQfRHOyynD0gGW2DeP7wvF7g/1P16tWBlPqOwNJ/ph7yY++tBwV62bpVvSsYSb6sga2pZ6dy7tH4NZBVi+80ZYLbnXAHcmLNw9Pm6bojqaxZo0BYNtDvr167Xid13cDficfb9gzschl3Zi5ETv2OSq3zkfF8k6lddjoLv9CDLmX8obMPl6reo9x9AbeC4DWGx2pkwMTDnQGy/hmmkvYetBcSWxcS0BciIG7BX2L1k4L71ipjiYsu27g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMunXoIWe21UABGiqHKsLDXBvK7Al+5X1pSH6xVkrNg=;
 b=rTzrc7IXb9Jkw+MfAFluz7/b2Pth0dviPKvuOrS+cWcyRvjh6ujgF7Y+Y1z5osU4OhXHp/zBS3GGAjUIqhfbxCi7QOWD79CQlyWMgIN1pcKr1odPUADSnp1p9rPXBlDl2RSkcwzVuulvZqoOqjZY441PYNw0yjgq5YKwoXKVzBpb/WIX4x0DT2EkoAFiz94u9PVo67J52/HZ0JxPOgdKk+E8Av9d0TdyKphHgkNC+q/PSt3vR3PkmQqllzPnk7hpvHqDHrwrDPIetRunHAKnx5fJyXqoI5KPFGoNU5qDPu5+cuEHsKhp8vjHUy3a68sredSzw68x2YSwiyAledibig==
Received: from BL0PR02CA0011.namprd02.prod.outlook.com (2603:10b6:207:3c::24)
 by MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 08:47:57 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::cd) by BL0PR02CA0011.outlook.office365.com
 (2603:10b6:207:3c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 08:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 08:47:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Mar
 2025 01:47:43 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 01:47:41 -0700
From: Shay Drory <shayd@nvidia.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <leonro@nvidia.com>, <linux-kernel@vger.kernel.org>, Shay Drory
	<shayd@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2 resend] PCI: Fix NULL dereference in SR-IOV VF creation error path
Date: Mon, 10 Mar 2025 10:47:29 +0200
Message-ID: <20250310084729.599292-1-shayd@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|MW3PR12MB4473:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c4a5b86-743f-4bb2-3665-08dd5fb040eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XmGLIc8dA6CSLCdWEr24701ax0aES9zRFrX1eL+gPVJdl/dQ3mgvlpBuhi2t?=
 =?us-ascii?Q?6d6Ar9XkBjunxLjy5zg/YUMklxgyzodF+eU3jcdDkWd1BrcAa3HbFxx/07r4?=
 =?us-ascii?Q?/UXbAmGqAGSS1IDR67ubWl0PgWu7Yk4+zfsXtFA3koEpThaLUGOMx+mnCZqq?=
 =?us-ascii?Q?gsvg3EYu/TT8Wzjc7fqKOfGf98/5f91EpHgr+kg9IR9Y8cQfkUXR7/IbtY7m?=
 =?us-ascii?Q?BJhP8AIzjvrUK0TEJqyRAlpsA4kWrKUYTV7QBLt34FElBDOwLbnwxYm0DkZH?=
 =?us-ascii?Q?7K//M6xFV/DCwuUzZ1sNYJOosGwh/InVJsDcQl0HUdakUwfQ6vyHwCGs4R+I?=
 =?us-ascii?Q?NK3Rah4jePb7extZoJ9AjwzKCQtLbupeqlGj1UZbBUagyLeBGsWi/jA5qLrD?=
 =?us-ascii?Q?EoK49+EguvTQFgq1w/aY2P7clnH1MpxqclLEvEx1kRS1PuLu2CUME1Erq6Ta?=
 =?us-ascii?Q?jQrCPZAja035hfbYcs3Mg/yZiu7P1V4IVhx6y7a1sjgZdeWx4R93luPTSKP4?=
 =?us-ascii?Q?5eEIth41Collkz390aaDm/2zuzq4WJuQpYYQX+x7R1lemNCfI+0pxHsqFjwN?=
 =?us-ascii?Q?gS+QgrQtXWmr2EAb+LTWP19+WB2CgE2MGvaYwiq6KXIpQY5eNxVMf8D2rQwm?=
 =?us-ascii?Q?I48TtEsvxnpcS9AywIvvw5UcR80sO573gfvvGP0O+YMKjQ4El6o/VqBaCaF9?=
 =?us-ascii?Q?KjTdKK3AXywMH/+kZStSnXbH0emEdxgHhYwgujGrY3abOjIAA2/rNVEw00fu?=
 =?us-ascii?Q?oUUuMkyNVOXiHlBA+72k1ViDnZThfHioGt4Nx8UPOAhbQ64xhQ7MrFstBWq9?=
 =?us-ascii?Q?LneoD11m7ym6uzlL2JawwySJNs80vwKDvjhcIDN1P7WVssTpjDKuWxhMe2Z0?=
 =?us-ascii?Q?jgsgPx7cbnYXDOPFM3KCXgIvdqi+x3fbErJE8DRY1p9ye59RWx7Aw+TExIvt?=
 =?us-ascii?Q?0Zo+0ysD1+2bXiyz20951pKPZ4/BGlTYtpY7j/MIU1HfQUFL3TYD4oMhIzyw?=
 =?us-ascii?Q?zGGiU8V7B46GGpuD/yQRzvmFHRQ5HlT/GtswElyK2IKpS40U829M0GI2kB29?=
 =?us-ascii?Q?tx8e0tZaT6F95BVVsNPgFsq1Tv0mWsJR1MZg0fcvQ2dRpmH2MOZNLqphpSLf?=
 =?us-ascii?Q?dzZ1/QWv2EmbQG+6OeR/9l6ls01sc+Cz6+61JJnB1MRg7+go0dLdnuBu3MQQ?=
 =?us-ascii?Q?X/jZG1JJJ66T4FgeckgpyNG+ByzsNsB1acfhkm5KEc/DPB2gU3kLtMQPYEt0?=
 =?us-ascii?Q?ZhAN/WtN6sxOS1lUVh/P/Jbx6sM8sGQw8qmRWEqll8Jx1BrFq8s+U72kYGNO?=
 =?us-ascii?Q?uspZuQ4xxzooj59wP3LLV+waos8shhfO14A31LydyTuLGjK944iHg04Pc/5J?=
 =?us-ascii?Q?3UiqW0ieLsW4h45lyHLU8MclK5wrEmGSyOufxtzKx0IUWPJW0ILONn1Yl25u?=
 =?us-ascii?Q?eqlYmT/Y9G+g0KaGCPD7SpMUGAgU/bIF5HGvBKtdF5nGB+hRMq7dJtMdt3tm?=
 =?us-ascii?Q?k5qw65PUetu06kQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 08:47:56.2486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4a5b86-743f-4bb2-3665-08dd5fb040eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473

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


