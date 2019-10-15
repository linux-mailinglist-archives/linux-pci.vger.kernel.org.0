Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08B68D7979
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 17:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733031AbfJOPMD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 11:12:03 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:1607 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJOPMD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 11:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1571152321; x=1602688321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jtSXYBhyv4nmyFyb0tgwDuxFJ1zsS6M7RSJPje+SWX8=;
  b=pbG51Dmx8DQXZbZJEpg/WX3iiaEzWy40eYVeOTsdQdYefig/ZE7XNg1M
   7J5Ey2o2bmsbOsXEbzmhUWPdE9zXzDIMqXvhbxhF0fYp2lOy/R3R2rsBf
   TpZaykLKvBU99c/xFRkfIPWk2qi43vPR6Ima/+2uncXzJCq3cbRdPZXnB
   E=;
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="793097360"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-397e131e.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 15 Oct 2019 15:12:00 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-397e131e.us-west-2.amazon.com (Postfix) with ESMTPS id 5F1E1A205B;
        Tue, 15 Oct 2019 15:11:59 +0000 (UTC)
Received: from EX13D13EUA004.ant.amazon.com (10.43.165.22) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 15 Oct 2019 15:11:58 +0000
Received: from localhost (10.43.161.223) by EX13D13EUA004.ant.amazon.com
 (10.43.165.22) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 15 Oct
 2019 15:11:57 +0000
From:   Yuri Volchkov <volchkov@amazon.de>
To:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     <joro@8bytes.org>, <bhelgaas@google.com>, <dwmw2@infradead.org>,
        <neugebar@amazon.co.uk>, Yuri Volchkov <volchkov@amazon.de>
Subject: [PATCH 1/2] iommu/dmar: collect fault statistics
Date:   Tue, 15 Oct 2019 17:11:11 +0200
Message-ID: <20191015151112.17225-2-volchkov@amazon.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015151112.17225-1-volchkov@amazon.de>
References: <20191015151112.17225-1-volchkov@amazon.de>
MIME-Version: 1.0
X-Originating-IP: [10.43.161.223]
X-ClientProxiedBy: EX13D10UWA003.ant.amazon.com (10.43.160.248) To
 EX13D13EUA004.ant.amazon.com (10.43.165.22)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently dmar_fault handler only prints a message in the dmesg. This
commit introduces counters - how many faults have happened, and
exposes them via sysfs. Each pci device will have an entry
'dmar_faults' reading from which will give user 3 lines
  remap: xxx
  read: xxx
  write: xxx

This functionality is targeted for health monitoring daemons.

Signed-off-by: Yuri Volchkov <volchkov@amazon.de>
---
 drivers/iommu/dmar.c        | 133 +++++++++++++++++++++++++++++++-----
 drivers/pci/pci-sysfs.c     |  20 ++++++
 include/linux/intel-iommu.h |   3 +
 include/linux/pci.h         |  11 +++
 4 files changed, 150 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index eecd6a421667..0749873e3e41 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1107,6 +1107,7 @@ static void free_iommu(struct intel_iommu *iommu)
 	}
 
 	if (iommu->irq) {
+		destroy_workqueue(iommu->fault_wq);
 		if (iommu->pr_irq) {
 			free_irq(iommu->pr_irq, iommu);
 			dmar_free_hwirq(iommu->pr_irq);
@@ -1672,9 +1673,46 @@ void dmar_msi_read(int irq, struct msi_msg *msg)
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 }
 
-static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
-		u8 fault_reason, int pasid, u16 source_id,
-		unsigned long long addr)
+struct dmar_fault_info {
+	struct work_struct work;
+	struct intel_iommu *iommu;
+	int type;
+	int pasid;
+	u16 source_id;
+	unsigned long long addr;
+	u8 fault_reason;
+};
+
+static struct kmem_cache *dmar_fault_info_cache;
+int __init dmar_fault_info_cache_init(void)
+{
+	int ret = 0;
+
+	dmar_fault_info_cache =
+		kmem_cache_create("dmar_fault_info",
+				  sizeof(struct dmar_fault_info), 0,
+				  SLAB_HWCACHE_ALIGN, NULL);
+	if (!dmar_fault_info_cache) {
+		pr_err("Couldn't create dmar_fault_info cache\n");
+		ret = -ENOMEM;
+	}
+
+	return ret;
+}
+
+static inline void *alloc_dmar_fault_info(void)
+{
+	return kmem_cache_alloc(dmar_fault_info_cache, GFP_ATOMIC);
+}
+
+static inline void free_dmar_fault_info(void *vaddr)
+{
+	kmem_cache_free(dmar_fault_info_cache, vaddr);
+}
+
+static int dmar_fault_dump_one(struct intel_iommu *iommu, int type,
+			       u8 fault_reason, int pasid, u16 source_id,
+			       unsigned long long addr)
 {
 	const char *reason;
 	int fault_type;
@@ -1695,6 +1733,57 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 	return 0;
 }
 
+static int dmar_fault_handle_one(struct dmar_fault_info *info)
+{
+	struct pci_dev *pdev;
+	u8 devfn;
+	atomic_t *pcnt;
+
+	devfn = PCI_DEVFN(PCI_SLOT(info->source_id), PCI_FUNC(info->source_id));
+	pdev = pci_get_domain_bus_and_slot(info->iommu->segment,
+					   PCI_BUS_NUM(info->source_id), devfn);
+
+	if (!pdev)
+		return -ENXIO;
+
+	if (info->fault_reason == INTR_REMAP)
+		pcnt = &pdev->faults_cnt.remap;
+	else if (info->type)
+		pcnt = &pdev->faults_cnt.read;
+	else
+		pcnt = &pdev->faults_cnt.write;
+
+	atomic_inc(pcnt);
+	return 0;
+}
+
+static void dmar_fault_handle_work(struct work_struct *work)
+{
+	struct dmar_fault_info *info;
+
+	info = container_of(work, struct dmar_fault_info, work);
+
+	dmar_fault_handle_one(info);
+	free_dmar_fault_info(info);
+}
+
+static int dmar_fault_schedule_one(struct intel_iommu *iommu, int type,
+				   u8 fault_reason, int pasid, u16 source_id,
+				   unsigned long long addr)
+{
+	struct dmar_fault_info *info = alloc_dmar_fault_info();
+
+	INIT_WORK(&info->work, dmar_fault_handle_work);
+	info->iommu = iommu;
+	info->type = type;
+	info->fault_reason = fault_reason;
+	info->pasid = pasid;
+	info->source_id = source_id;
+	info->addr = addr;
+
+	return queue_work(iommu->fault_wq, &info->work);
+}
+
 #define PRIMARY_FAULT_REG_LEN (16)
 irqreturn_t dmar_fault(int irq, void *dev_id)
 {
@@ -1733,20 +1822,18 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 		if (!(data & DMA_FRCD_F))
 			break;
 
-		if (!ratelimited) {
-			fault_reason = dma_frcd_fault_reason(data);
-			type = dma_frcd_type(data);
+		fault_reason = dma_frcd_fault_reason(data);
+		type = dma_frcd_type(data);
 
-			pasid = dma_frcd_pasid_value(data);
-			data = readl(iommu->reg + reg +
-				     fault_index * PRIMARY_FAULT_REG_LEN + 8);
-			source_id = dma_frcd_source_id(data);
+		pasid = dma_frcd_pasid_value(data);
+		data = readl(iommu->reg + reg +
+			     fault_index * PRIMARY_FAULT_REG_LEN + 8);
+		source_id = dma_frcd_source_id(data);
 
-			pasid_present = dma_frcd_pasid_present(data);
-			guest_addr = dmar_readq(iommu->reg + reg +
+		pasid_present = dma_frcd_pasid_present(data);
+		guest_addr = dmar_readq(iommu->reg + reg +
 					fault_index * PRIMARY_FAULT_REG_LEN);
-			guest_addr = dma_frcd_page_addr(guest_addr);
-		}
+		guest_addr = dma_frcd_page_addr(guest_addr);
 
 		/* clear the fault */
 		writel(DMA_FRCD_F, iommu->reg + reg +
@@ -1756,9 +1843,13 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 
 		if (!ratelimited)
 			/* Using pasid -1 if pasid is not present */
-			dmar_fault_do_one(iommu, type, fault_reason,
-					  pasid_present ? pasid : -1,
-					  source_id, guest_addr);
+			dmar_fault_dump_one(iommu, type, fault_reason,
+					    pasid_present ? pasid : -1,
+					    source_id, guest_addr);
+		if (irq != -1)
+			dmar_fault_schedule_one(iommu, type, fault_reason,
+						pasid_present ? pasid : -1,
+						source_id, guest_addr);
 
 		fault_index++;
 		if (fault_index >= cap_num_fault_regs(iommu->cap))
@@ -1784,6 +1875,10 @@ int dmar_set_interrupt(struct intel_iommu *iommu)
 	if (iommu->irq)
 		return 0;
 
+	iommu->fault_wq = alloc_ordered_workqueue("fault_%s", 0, iommu->name);
+	if (!iommu->fault_wq)
+		return -ENOMEM;
+
 	irq = dmar_alloc_hwirq(iommu->seq_id, iommu->node, iommu);
 	if (irq > 0) {
 		iommu->irq = irq;
@@ -1803,6 +1898,9 @@ int __init enable_drhd_fault_handling(void)
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
 
+	if (dmar_fault_info_cache_init())
+		return -1;
+
 	/*
 	 * Enable fault control interrupt.
 	 */
@@ -1813,6 +1911,7 @@ int __init enable_drhd_fault_handling(void)
 		if (ret) {
 			pr_err("DRHD %Lx: failed to enable fault, interrupt, ret %d\n",
 			       (unsigned long long)drhd->reg_base_addr, ret);
+			kmem_cache_destroy(dmar_fault_info_cache);
 			return -1;
 		}
 
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 07bd84c50238..d01514fca6d1 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -263,6 +263,23 @@ static ssize_t ari_enabled_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(ari_enabled);
 
+#ifdef CONFIG_DMAR_TABLE
+static ssize_t dmar_faults_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int remap, read, write;
+
+	remap = atomic_xchg(&pdev->faults_cnt.remap, 0);
+	read = atomic_xchg(&pdev->faults_cnt.read, 0);
+	write = atomic_xchg(&pdev->faults_cnt.write, 0);
+
+	return sprintf(buf, "remap: %d\nread: %d\nwrite: %d\n", remap, read,
+		       write);
+}
+static DEVICE_ATTR_RO(dmar_faults);
+#endif
+
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -623,6 +640,9 @@ static struct attribute *pci_dev_attrs[] = {
 #endif
 	&dev_attr_driver_override.attr,
 	&dev_attr_ari_enabled.attr,
+#ifdef CONFIG_DMAR_TABLE
+	&dev_attr_dmar_faults.attr,
+#endif
 	NULL,
 };
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index ed11ef594378..f8963c833fb0 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -552,6 +552,9 @@ struct intel_iommu {
 	struct iommu_device iommu;  /* IOMMU core code handle */
 	int		node;
 	u32		flags;      /* Software defined flags */
+#ifdef CONFIG_DMAR_TABLE
+	struct workqueue_struct *fault_wq; /* Fault handler */
+#endif
 };
 
 /* PCI domain-device relationship */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 14efa2586a8c..d9cc94fbf0ee 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -286,6 +286,14 @@ struct pci_vpd;
 struct pci_sriov;
 struct pci_p2pdma;
 
+#ifdef CONFIG_DMAR_TABLE
+struct pci_dmar_faults_cnt {
+	atomic_t read; /* How many read faults occurred */
+	atomic_t write; /* How many write faults occurred */
+	atomic_t remap; /* How many remap faults occurred */
+};
+#endif
+
 /* The pci_dev structure describes PCI devices */
 struct pci_dev {
 	struct list_head bus_list;	/* Node in per-bus list */
@@ -468,6 +476,9 @@ struct pci_dev {
 	char		*driver_override; /* Driver name to force a match */
 
 	unsigned long	priv_flags;	/* Private flags for the PCI driver */
+#ifdef CONFIG_DMAR_TABLE
+	struct pci_dmar_faults_cnt faults_cnt; /* Dmar fault statistics */
+#endif
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
-- 
2.23.0




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Ralf Herbrich
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



