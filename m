Return-Path: <linux-pci+bounces-5308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B82E88F842
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 07:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216412954B1
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 06:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39CB5026A;
	Thu, 28 Mar 2024 06:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JSEKJaWx"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D400852F8B;
	Thu, 28 Mar 2024 06:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711609045; cv=fail; b=oAtWVR8+Ms292qWFoCA0A/uMiFo99B64WzcENMb+1y03a44st/ly8KJM0R0WsbCorZrN0TqDZL/GlEGG9ickq2SH9Yzi3HETcMYuVpRkroMpmleJ0ZmNdJeHZS/pF9BwJsKK2y+yiFLe8hK0xepgOawg1fiOvi+Od5jH5D81YzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711609045; c=relaxed/simple;
	bh=PbbByKsZgDgsiB3NTWRsPctwYTb9FCCTOCazrgdoKIU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pFj7mEUGv06xp5AMTTb6rvGz3/WDHQRVkxgdD7W5Cf7Fkfx3OmtCqwZHy9kGvlkjCUN3HjonI6jzBF5j00yBwl7seigdgatbIj/CuCfQ/vS4TB6ZnDFT7yJioLJTakNQVnH1riJxNoQSdHNUl0aXiq1rD9DLBCwGahW+r8ZlpbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JSEKJaWx; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ax6Xo9lg4zxOhudV7/wVGW/5h34WRwlgwn2YuGYMWphY5aANHKAB2QUvVbuqdzPFat4fLqRjfa+32grrHZCu9MhLgD45wmQfVwsTY9V2jMNxr1GPLiJse1n3KqUvOga8ex5CEeHyanEKDdS0KBIxYfRBX5s7PJv0JkbPI4MMTeAbA1UsQSiibasyRd4KqqUarde5bD/uxUdJH0GK4cKATebIFFtSF//a+fiXBwLdKwYnW8Kpp4V85mVshQIVJJXUDQYIbdQ4B6wVhN4NDohTQemAxbwHqaNBxtzrERVDWBole5CudMhjDNZ9PSqKTrM1h0OC0gNBVYJVHxBID3PG/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aI6059EuBtnjnSbkyQUjuatDap0hc10owbqletZh68g=;
 b=ChUkXexTLQh27/sgEPpxPj24o2LDRQGXq7qlhKUgzVTmmgf4wyxKGHRjiIJNqaFkwKrEfBnmVo5UGj6Y2YB8qw4BnmF+2bKVIKON2+ve683FVKF36Ls2OHQlsMFP9H0D8/mV53PuBuzTB3xiwWg+umRelb57YhSvaz2OClQYfV1LMzyOXqrVPEgoIrTMJU5ozz0iG+mNM33oFUdL560WEjCkAswqcpkN9pn3pVp9HiadMG3vAcTmqEKBADq6qHMjMyJsaGpgsRbbAUmYGkkt4SYVSQcezWwZqLDNnVN3qT0BxyDSAS454k9PcTtHItqpTLi/d3mYX3TenxMPBbBVBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aI6059EuBtnjnSbkyQUjuatDap0hc10owbqletZh68g=;
 b=JSEKJaWxOrkJCQPMQIKTjVJWA813vQSkA3t4p6+Z6cJUuqCzPCi3HAkmFhobAQS744WoVWpQqQatsX8bI1WEwuwvzAMI/Bm3XsOxdENbSvHzup7/WbKY3uLihRMGz8INz8rReur9ZHy6Oy8Y8/dw+E+MKWIoO1JSQM1cqwIjUZ8=
Received: from BN0PR04CA0205.namprd04.prod.outlook.com (2603:10b6:408:e9::30)
 by MN0PR12MB6247.namprd12.prod.outlook.com (2603:10b6:208:3c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 06:57:19 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::b1) by BN0PR04CA0205.outlook.office365.com
 (2603:10b6:408:e9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 06:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 06:57:19 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 01:57:14 -0500
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
Subject: [RFC KERNEL PATCH v5 2/3] xen/pvh: Setup gsi for passthrough device
Date: Thu, 28 Mar 2024 14:56:45 +0800
Message-ID: <20240328065646.354782-3-Jiqian.Chen@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|MN0PR12MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: c639cee9-d75b-4499-1224-08dc4ef44f98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	adLYiY1ODi5YdjheWVf9BtXB1KUrMl3MOdMqHMgvCJImGi+5/vyJb4i3cqxn43mrabUdruT41nJ9sTSGkt8tykHUfGM/T2ob7s4hlfZcO+2tgYQHe7b9MAqED+P2rAsiAs9tFuFcdI0gP+mhawVksqCrQDxPCF061WXD/eJ5xykNvNAz2rVMCtxo6gwA2JGiF0ELk2Nuk8tINOdbikQJ7zK4GXWlxJkYO7euyEUWh+0ZY2C05jdgKZ4wuZde+9Sy8Wnbxi64rWgUjq1mXLnWTS5uuiiK9eXOLK6qNzf8CuuwYOFlMvGkzWm5ymsBh+sk8MpAZdymsL4KnDhm5Rc0QftT/kBD2rUtnzuPtj8EMJ4ErAi8zXZrJ7auSrRkEBb5hqoRE5NqLHsibAOhrsa+m1cZ07ZHCPVII7OjlV8kVU6p2eBo7EZ7jpxSB+yV49rBBQZjbyEuvaeE0X5yNNFvJkplvJAgIt8jPxLfNgdBb3I+a7l2eQXGvzdCxjXKB99qkXEGGFdbX0Xw1j01D3jkzu9ObTtgTcCrgE7FIzfHoh9adVN1yIinOB3xEC27gQVlZkfwsNcx4KjIX2jQb0pClI8kSxa+JzYtHe1Jz7uHAPZYzNvrbCzL5Hr4aOXSkhUyol5M9gT5MfKZ+p31wmSQA9HzuMSZb5SkGAjhodukNE8okLKeEeMJLXoMJDWY8taBBl1xZBHRM3aGVu/DE9VyyGMKzDUZG09vBp6lh2nc30HNqImiLqkp3MekvHvUeF36
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 06:57:19.3808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c639cee9-d75b-4499-1224-08dc4ef44f98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6247

In PVH dom0, the gsis don't get registered, but the gsi of
a passthrough device must be configured for it to be able to be
mapped into a domU.

When assign a device to passthrough, proactively setup the gsi
of the device during that process.

Co-developed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
RFC: This patch change function acpi_pci_irq_lookup from a static function to non-static, need ACPI Maintainer to give some comments.

---
 arch/x86/xen/enlighten_pvh.c       | 92 ++++++++++++++++++++++++++++++
 drivers/acpi/pci_irq.c             |  2 +-
 drivers/xen/xen-pciback/pci_stub.c |  8 +++
 include/linux/acpi.h               |  1 +
 include/xen/acpi.h                 |  6 ++
 5 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index c28f073c1df5..12be665b27d8 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -2,6 +2,7 @@
 #include <linux/acpi.h>
 #include <linux/export.h>
 #include <linux/mm.h>
+#include <linux/pci.h>
 
 #include <xen/hvc-console.h>
 
@@ -26,6 +27,97 @@
 bool __ro_after_init xen_pvh;
 EXPORT_SYMBOL_GPL(xen_pvh);
 
+typedef struct gsi_info {
+	int gsi;
+	int trigger;
+	int polarity;
+} gsi_info_t;
+
+struct acpi_prt_entry {
+	struct acpi_pci_id	id;
+	u8			pin;
+	acpi_handle		link;
+	u32			index;		/* GSI, or link _CRS index */
+};
+
+static int xen_pvh_get_gsi_info(struct pci_dev *dev,
+								gsi_info_t *gsi_info)
+{
+	int gsi;
+	u8 pin;
+	struct acpi_prt_entry *entry;
+	int trigger = ACPI_LEVEL_SENSITIVE;
+	int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ?
+				      ACPI_ACTIVE_HIGH : ACPI_ACTIVE_LOW;
+
+	if (!dev || !gsi_info)
+		return -EINVAL;
+
+	pin = dev->pin;
+	if (!pin)
+		return -EINVAL;
+
+	entry = acpi_pci_irq_lookup(dev, pin);
+	if (entry) {
+		if (entry->link)
+			gsi = acpi_pci_link_allocate_irq(entry->link,
+							 entry->index,
+							 &trigger, &polarity,
+							 NULL);
+		else
+			gsi = entry->index;
+	} else
+		gsi = -1;
+
+	if (gsi < 0)
+		return -EINVAL;
+
+	gsi_info->gsi = gsi;
+	gsi_info->trigger = trigger;
+	gsi_info->polarity = polarity;
+
+	return 0;
+}
+
+static int xen_pvh_setup_gsi(gsi_info_t *gsi_info)
+{
+	struct physdev_setup_gsi setup_gsi;
+
+	if (!gsi_info)
+		return -EINVAL;
+
+	setup_gsi.gsi = gsi_info->gsi;
+	setup_gsi.triggering = (gsi_info->trigger == ACPI_EDGE_SENSITIVE ? 0 : 1);
+	setup_gsi.polarity = (gsi_info->polarity == ACPI_ACTIVE_HIGH ? 0 : 1);
+
+	return HYPERVISOR_physdev_op(PHYSDEVOP_setup_gsi, &setup_gsi);
+}
+
+int xen_pvh_passthrough_gsi(struct pci_dev *dev)
+{
+	int ret;
+	gsi_info_t gsi_info;
+
+	if (!dev)
+		return -EINVAL;
+
+	ret = xen_pvh_get_gsi_info(dev, &gsi_info);
+	if (ret) {
+		xen_raw_printk("Fail to get gsi info!\n");
+		return ret;
+	}
+
+	ret = xen_pvh_setup_gsi(&gsi_info);
+	if (ret == -EEXIST) {
+		xen_raw_printk("Already setup the GSI :%d\n", gsi_info.gsi);
+		ret = 0;
+	} else if (ret)
+		xen_raw_printk("Fail to setup GSI (%d)!\n", gsi_info.gsi);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xen_pvh_passthrough_gsi);
+
 void __init xen_pvh_init(struct boot_params *boot_params)
 {
 	u32 msr;
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index ff30ceca2203..630fe0a34bc6 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -288,7 +288,7 @@ static int acpi_reroute_boot_interrupt(struct pci_dev *dev,
 }
 #endif /* CONFIG_X86_IO_APIC */
 
-static struct acpi_prt_entry *acpi_pci_irq_lookup(struct pci_dev *dev, int pin)
+struct acpi_prt_entry *acpi_pci_irq_lookup(struct pci_dev *dev, int pin)
 {
 	struct acpi_prt_entry *entry = NULL;
 	struct pci_dev *bridge;
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 46c40ec8a18e..22d4380d2b04 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -20,6 +20,7 @@
 #include <linux/atomic.h>
 #include <xen/events.h>
 #include <xen/pci.h>
+#include <xen/acpi.h>
 #include <xen/xen.h>
 #include <asm/xen/hypervisor.h>
 #include <xen/interface/physdev.h>
@@ -435,6 +436,13 @@ static int pcistub_init_device(struct pci_dev *dev)
 			goto config_release;
 		pci_restore_state(dev);
 	}
+
+	if (xen_initial_domain() && xen_pvh_domain()) {
+		err = xen_pvh_passthrough_gsi(dev);
+		if (err)
+			goto config_release;
+	}
+
 	/* Now disable the device (this also ensures some private device
 	 * data is setup before we export)
 	 */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index b7165e52b3c6..08f1e316bf27 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -361,6 +361,7 @@ void acpi_unregister_gsi (u32 gsi);
 
 struct pci_dev;
 
+struct acpi_prt_entry *acpi_pci_irq_lookup(struct pci_dev *dev, int pin);
 int acpi_pci_irq_enable (struct pci_dev *dev);
 void acpi_penalize_isa_irq(int irq, int active);
 bool acpi_isa_irq_available(int irq);
diff --git a/include/xen/acpi.h b/include/xen/acpi.h
index b1e11863144d..17c4d37f1e60 100644
--- a/include/xen/acpi.h
+++ b/include/xen/acpi.h
@@ -67,10 +67,16 @@ static inline void xen_acpi_sleep_register(void)
 		acpi_suspend_lowlevel = xen_acpi_suspend_lowlevel;
 	}
 }
+int xen_pvh_passthrough_gsi(struct pci_dev *dev);
 #else
 static inline void xen_acpi_sleep_register(void)
 {
 }
+
+static inline int xen_pvh_passthrough_gsi(struct pci_dev *dev)
+{
+	return -1;
+}
 #endif
 
 #endif	/* _XEN_ACPI_H */
-- 
2.34.1


