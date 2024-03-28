Return-Path: <linux-pci+bounces-5307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D19DB88F83B
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 07:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015681C23F92
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 06:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4262E50A7E;
	Thu, 28 Mar 2024 06:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oILaf8Yu"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625C250A63;
	Thu, 28 Mar 2024 06:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711609039; cv=fail; b=vD4Wm4E/jOgRYCs+X3TtWmE7A7cCjC5Vy+J0PG6QvsCFgTbijI4JNhgQq10t64ckl1xJ3E9O8i2FkyYIXH3Rv1kT5FyYcLuYFBykTVCoijuusXpLO5rnnILYaFMvqrKZcBlTGr+1UY2Qip5/ExSUb4KbftoMPXMWOFGpkZVD3fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711609039; c=relaxed/simple;
	bh=Z2sh5yRNzT0oVcnLvEFS3WssTNn4p5ui1YorjkBExgA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBVZLmHSPVFb08oTVPb2PPdP/wlGt8pQhH4l2tjqINxL2IYzv866EFQa++aTwpcd2qVUeiKrc6GoZzvdYSJtBsrhEvuuHj0RpqiISjQWPFtdHqw1V6ErFpsyyfO8j6N12wH3l+cL2QWNsrPXtulJjwlnLKB9oVBJtxnHXUh1wgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oILaf8Yu; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZqJEF12YSGNPhPTdtsktEbcn0fCGumDIYf8qWCsFbk2lVZBoKG6P5Iq/sDs/S6auukivH0me0hSGjNOfFET+VRvIgAfQLNkYNIfRdAcKNGsjLDIeq2n+00Lkc/WfZVqJM9L6+RfFBvIXpllZVkGO78NIXPY5Qk7RYCDM6JFqF6G5nRWSVFaAKPoHts0Ol0bu/KXz4RlD4bdPoY8Tmfm+lGKqPZk3tAncdT0Xj4hj39oIpMd6RcoQ5rU+N/sg+kJrozSId5XxLqVGzSF1qGOrnST9o3KObmqrN3lIiwSsYoz5yBii//vZjDmUMCFosjxcxrpl64cqSFNYVFKb2eXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fH+U2QOk6dVHLf7A7/6oScHHVZmq0WKT97i+j9mEzp4=;
 b=g4Yjko2Rei0ICo9pfrE6x2i8Xg9hRyDnbbAImO4bKfMq8jogKkACRYvBdrj5Kho0on26QEypar3wEpOaru6FdtPJJMp3WnmUi5uBfzw254pnjrgeGj8FyvqHN/Fr9K+RZ+Jl/IY5iPN8pcFt6UlryTSrtkqH5VGw+9HbXGQQhOS7IZFAudh8ArH8/VgPc/nW2X1KANPFSy1BWu3Gm/Jv7Rn9UfK35jUbD6/egKHpjBSEWw0Mxc7mQxiX39T/bw8TNuT/7MCcvBCp7gidvvD8TmYrBGrAEn7dUfhhL4RZzW3lKwipzWomsq3PjuEIEeCjRDpWRnxumlDx5p1rRk04gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fH+U2QOk6dVHLf7A7/6oScHHVZmq0WKT97i+j9mEzp4=;
 b=oILaf8YuJo+OBHLhRTY8c+P6HLOaVF+jMcuvcv8Jh47++VGLwOSBZRaDkKUSOd1GCaoBJxBjvi6WSw8ZRAwNEstorSbw04bLeZoYaFCVG7M9pFkNhtjbeAtvgtyKWGwcM21TmvMvmQSLLVM2MvRLeVkuC7HUW/dHMwmjNKCkkHE=
Received: from BN7PR02CA0029.namprd02.prod.outlook.com (2603:10b6:408:20::42)
 by DM4PR12MB7669.namprd12.prod.outlook.com (2603:10b6:8:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 06:57:15 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:20:cafe::d0) by BN7PR02CA0029.outlook.office365.com
 (2603:10b6:408:20::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 06:57:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 06:57:14 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 01:57:10 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J
 . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
CC: <xen-devel@lists.xenproject.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>, "Stewart
 Hildebrand" <Stewart.Hildebrand@amd.com>, Huang Rui <Ray.Huang@amd.com>,
	Jiqian Chen <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [KERNEL PATCH v5 1/3] xen/pci: Add xen_reset_device_state function
Date: Thu, 28 Mar 2024 14:56:44 +0800
Message-ID: <20240328065646.354782-2-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328065646.354782-1-Jiqian.Chen@amd.com>
References: <20240328065646.354782-1-Jiqian.Chen@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|DM4PR12MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a12641-e429-4b26-b4ad-08dc4ef44cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kAynio0RnoN8y9TM1dNjbKS/YUPUAbJ5U1knNQq2Xc4qU50I2YKZQGIcC1fnzRDE+kNE4cJnW/27+K+iCyk8un8vS7VyWJ6BLLwlYIHTpr6W4AAU8nJJZmxqqPUOVFPi6V0M6WXljVulmlzfkU7tNElgUuiYN3a+fwchHdpf/Uz6UTVIe5ZqzUfu46qwXTFUSONkGgYlaYd1VkIWprLpdKNT9iRDDn4qXMW+kMLsnClNiQmmh601Dr195gCMN3ib8ZzNbE8bu0VVxjFpnZ86iwNnJR35p+3nR5bJfUgy+o8wM9W9poPRotAw7Iv0RNH6vVLhnPVdyTlwCPt+0WLJmy7CEMns+Bndtva37Jp+NC13d0rvVNBhPg35XW8AZOr8DSNVq1k7I++9DuK166lMIlKAYcq1JZBSdUl3aNyz6d8MrlzJwRiX77eDn3vXHnnOMLm7b6+8d1HbAftA4xs28dEQ7sWdxXvsPsBdifGG+Y1od5uXX/bQV/ZnWz3064UBXgh3y0yVqQnxWgFQEhc+HXHygp3naYUpWmG4KuNQdJauDLXYKrh7KIK2yu6ilYJMSoypPUXNAjYtBOsfOW7QFI1/Jb6HNKA9YyvLOkwhUFPUrd/dUymZ9qKnNwVWO+o93+J4kkM/5lhiKn/T0mRi2QUVKq3gzHY8aynTwrBkGu/Lgw+o/S9aiSBywxGjRKh4vH0V45bFbbUEj5MEkZ6mUGfdIC2b+QwpjWMeyS1W9khTKVpPhQZxiLGQ6yrmfRKW
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 06:57:14.9482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a12641-e429-4b26-b4ad-08dc4ef44cf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7669

When device on dom0 side has been reset, the vpci on Xen side
won't get notification, so that the cached state in vpci is
all out of date with the real device state.
To solve that problem, add a new function to clear all vpci
device state when device is reset on dom0 side.

And call that function in pcistub_init_device. Because when
using "pci-assignable-add" to assign a passthrough device in
Xen, it will reset passthrough device and the vpci state will
out of date, and then device will fail to restore bar state.

Co-developed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 drivers/xen/pci.c                  | 12 ++++++++++++
 drivers/xen/xen-pciback/pci_stub.c | 18 +++++++++++++++---
 include/xen/interface/physdev.h    |  7 +++++++
 include/xen/pci.h                  |  6 ++++++
 4 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
index 72d4e3f193af..e9b30bc09139 100644
--- a/drivers/xen/pci.c
+++ b/drivers/xen/pci.c
@@ -177,6 +177,18 @@ static int xen_remove_device(struct device *dev)
 	return r;
 }
 
+int xen_reset_device_state(const struct pci_dev *dev)
+{
+	struct physdev_pci_device device = {
+		.seg = pci_domain_nr(dev->bus),
+		.bus = dev->bus->number,
+		.devfn = dev->devfn
+	};
+
+	return HYPERVISOR_physdev_op(PHYSDEVOP_pci_device_state_reset, &device);
+}
+EXPORT_SYMBOL_GPL(xen_reset_device_state);
+
 static int xen_pci_notifier(struct notifier_block *nb,
 			    unsigned long action, void *data)
 {
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index e34b623e4b41..46c40ec8a18e 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -89,6 +89,16 @@ static struct pcistub_device *pcistub_device_alloc(struct pci_dev *dev)
 	return psdev;
 }
 
+static int pcistub_reset_device_state(struct pci_dev *dev)
+{
+	__pci_reset_function_locked(dev);
+
+	if (!xen_pv_domain())
+		return xen_reset_device_state(dev);
+	else
+		return 0;
+}
+
 /* Don't call this directly as it's called by pcistub_device_put */
 static void pcistub_device_release(struct kref *kref)
 {
@@ -107,7 +117,7 @@ static void pcistub_device_release(struct kref *kref)
 	/* Call the reset function which does not take lock as this
 	 * is called from "unbind" which takes a device_lock mutex.
 	 */
-	__pci_reset_function_locked(dev);
+	pcistub_reset_device_state(dev);
 	if (dev_data &&
 	    pci_load_and_free_saved_state(dev, &dev_data->pci_saved_state))
 		dev_info(&dev->dev, "Could not reload PCI state\n");
@@ -284,7 +294,7 @@ void pcistub_put_pci_dev(struct pci_dev *dev)
 	 * (so it's ready for the next domain)
 	 */
 	device_lock_assert(&dev->dev);
-	__pci_reset_function_locked(dev);
+	pcistub_reset_device_state(dev);
 
 	dev_data = pci_get_drvdata(dev);
 	ret = pci_load_saved_state(dev, dev_data->pci_saved_state);
@@ -420,7 +430,9 @@ static int pcistub_init_device(struct pci_dev *dev)
 		dev_err(&dev->dev, "Could not store PCI conf saved state!\n");
 	else {
 		dev_dbg(&dev->dev, "resetting (FLR, D3, etc) the device\n");
-		__pci_reset_function_locked(dev);
+		err = pcistub_reset_device_state(dev);
+		if (err)
+			goto config_release;
 		pci_restore_state(dev);
 	}
 	/* Now disable the device (this also ensures some private device
diff --git a/include/xen/interface/physdev.h b/include/xen/interface/physdev.h
index a237af867873..8609770e28f5 100644
--- a/include/xen/interface/physdev.h
+++ b/include/xen/interface/physdev.h
@@ -256,6 +256,13 @@ struct physdev_pci_device_add {
  */
 #define PHYSDEVOP_prepare_msix          30
 #define PHYSDEVOP_release_msix          31
+/*
+ * Notify the hypervisor that a PCI device has been reset, so that any
+ * internally cached state is regenerated.  Should be called after any
+ * device reset performed by the hardware domain.
+ */
+#define PHYSDEVOP_pci_device_state_reset     32
+
 struct physdev_pci_device {
     /* IN */
     uint16_t seg;
diff --git a/include/xen/pci.h b/include/xen/pci.h
index b8337cf85fd1..b2e2e856efd6 100644
--- a/include/xen/pci.h
+++ b/include/xen/pci.h
@@ -4,10 +4,16 @@
 #define __XEN_PCI_H__
 
 #if defined(CONFIG_XEN_DOM0)
+int xen_reset_device_state(const struct pci_dev *dev);
 int xen_find_device_domain_owner(struct pci_dev *dev);
 int xen_register_device_domain_owner(struct pci_dev *dev, uint16_t domain);
 int xen_unregister_device_domain_owner(struct pci_dev *dev);
 #else
+static inline int xen_reset_device_state(const struct pci_dev *dev)
+{
+	return -1;
+}
+
 static inline int xen_find_device_domain_owner(struct pci_dev *dev)
 {
 	return -1;
-- 
2.34.1


