Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D328399690
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 02:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhFCADM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 20:03:12 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:38590 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCADL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jun 2021 20:03:11 -0400
Received: by mail-wr1-f48.google.com with SMTP id j14so3959328wrq.5
        for <linux-pci@vger.kernel.org>; Wed, 02 Jun 2021 17:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A09UlryTOPln3fFpkVuLZasYFxq4vmeL4FwV8LQspjg=;
        b=RZNc40I3cBRoubmyEF09YgNLsGffxaaFD9mnT5zy0Pobk2niVObkAw7iHpR+qEo7Fc
         Iu6fMS/+raSHbYb7aCuMcA3u4s0bVybZGLHK4p6I3mUAOnDQM8LQf7msYhyWh3u8sKsA
         +OQRbYj5RpD8o+6S14OYkJTPngUctNhcoBZFNKbwTLlCb6tYVuNcV8RM3+UO0I8eRRhY
         Y7q5l8/8EBUPe9hIfbQMLM2i7WTyXz7HKAdde9cIYIj4CNnrTJxFlMeR675ILwqrEkm9
         ekyqLQtfYoQueZulWaSsR6Na+l625MP4ShPclOZ288gBYUVFTCUOtdKyzlCrK2BefeP4
         uypQ==
X-Gm-Message-State: AOAM531vzgrYxZn6Q/zhlnpp1I1jQOPV+LlvDLg0D3ET2iWu9A1M1CGw
        n7wR1OiwZWSGpTXPqI79dmk=
X-Google-Smtp-Source: ABdhPJyROB2OD1tiRHFGSZtmqaM1nZj0PPf6b85h+VYpNIo4jz3QngaSenK9g12iVr/rIM4PWHUFMg==
X-Received: by 2002:a5d:4304:: with SMTP id h4mr36606412wrq.210.1622678476888;
        Wed, 02 Jun 2021 17:01:16 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id c7sm1424669wrs.23.2021.06.02.17.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 17:01:16 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Joe Perches <joe@perches.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v6 1/6] PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Thu,  3 Jun 2021 00:01:07 +0000
Message-Id: <20210603000112.703037-2-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603000112.703037-1-kw@linux.com>
References: <20210603000112.703037-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The sysfs_emit() and sysfs_emit_at() functions were introduced to make
it less ambiguous which function is preferred when writing to the output
buffer in a device attribute's "show" callback [1].

Convert the PCI sysfs object "show" functions from sprintf(), snprintf()
and scnprintf() to sysfs_emit() and sysfs_emit_at() accordingly, as the
latter is aware of the PAGE_SIZE buffer and correctly returns the number
of bytes written into the buffer.

No functional change intended.

[1] Documentation/filesystems/sysfs.rst

Related to:
  commit ad025f8e46f3 ("PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions")

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/hotplug/pci_hotplug_core.c |  8 +++---
 drivers/pci/hotplug/rpadlpar_sysfs.c   |  4 +--
 drivers/pci/hotplug/shpchp_sysfs.c     | 38 ++++++++++++++------------
 drivers/pci/iov.c                      | 12 ++++----
 drivers/pci/msi.c                      |  8 +++---
 drivers/pci/p2pdma.c                   |  7 ++---
 drivers/pci/pci-label.c                |  6 ++--
 drivers/pci/pci.c                      |  2 +-
 drivers/pci/pcie/aer.c                 | 20 ++++++++------
 drivers/pci/pcie/aspm.c                |  4 +--
 drivers/pci/slot.c                     | 18 ++++++------
 drivers/pci/switch/switchtec.c         | 18 ++++++------
 12 files changed, 75 insertions(+), 70 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index 5ac31f683b85..058d5937d8a9 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -73,7 +73,7 @@ static ssize_t power_read_file(struct pci_slot *pci_slot, char *buf)
 	if (retval)
 		return retval;
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t power_write_file(struct pci_slot *pci_slot, const char *buf,
@@ -130,7 +130,7 @@ static ssize_t attention_read_file(struct pci_slot *pci_slot, char *buf)
 	if (retval)
 		return retval;
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t attention_write_file(struct pci_slot *pci_slot, const char *buf,
@@ -175,7 +175,7 @@ static ssize_t latch_read_file(struct pci_slot *pci_slot, char *buf)
 	if (retval)
 		return retval;
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static struct pci_slot_attribute hotplug_slot_attr_latch = {
@@ -192,7 +192,7 @@ static ssize_t presence_read_file(struct pci_slot *pci_slot, char *buf)
 	if (retval)
 		return retval;
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static struct pci_slot_attribute hotplug_slot_attr_presence = {
diff --git a/drivers/pci/hotplug/rpadlpar_sysfs.c b/drivers/pci/hotplug/rpadlpar_sysfs.c
index dbfa0b55d31a..068b7810a574 100644
--- a/drivers/pci/hotplug/rpadlpar_sysfs.c
+++ b/drivers/pci/hotplug/rpadlpar_sysfs.c
@@ -50,7 +50,7 @@ static ssize_t add_slot_store(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t add_slot_show(struct kobject *kobj,
 			     struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "0\n");
+	return sysfs_emit(buf, "0\n");
 }
 
 static ssize_t remove_slot_store(struct kobject *kobj,
@@ -80,7 +80,7 @@ static ssize_t remove_slot_store(struct kobject *kobj,
 static ssize_t remove_slot_show(struct kobject *kobj,
 				struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "0\n");
+	return sysfs_emit(buf, "0\n");
 }
 
 static struct kobj_attribute add_slot_attr =
diff --git a/drivers/pci/hotplug/shpchp_sysfs.c b/drivers/pci/hotplug/shpchp_sysfs.c
index 45658bb5c554..64beed7a26be 100644
--- a/drivers/pci/hotplug/shpchp_sysfs.c
+++ b/drivers/pci/hotplug/shpchp_sysfs.c
@@ -24,50 +24,54 @@
 static ssize_t show_ctrl(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev;
-	char *out = buf;
 	int index, busnr;
 	struct resource *res;
 	struct pci_bus *bus;
+	size_t len = 0;
 
 	pdev = to_pci_dev(dev);
 	bus = pdev->subordinate;
 
-	out += sprintf(buf, "Free resources: memory\n");
+	len += sysfs_emit_at(buf, len, "Free resources: memory\n");
 	pci_bus_for_each_resource(bus, res, index) {
 		if (res && (res->flags & IORESOURCE_MEM) &&
 				!(res->flags & IORESOURCE_PREFETCH)) {
-			out += sprintf(out, "start = %8.8llx, length = %8.8llx\n",
-				       (unsigned long long)res->start,
-				       (unsigned long long)resource_size(res));
+			len += sysfs_emit_at(buf, len,
+					     "start = %8.8llx, length = %8.8llx\n",
+					     (unsigned long long)res->start,
+					     (unsigned long long)resource_size(res));
 		}
 	}
-	out += sprintf(out, "Free resources: prefetchable memory\n");
+	len += sysfs_emit_at(buf, len, "Free resources: prefetchable memory\n");
 	pci_bus_for_each_resource(bus, res, index) {
 		if (res && (res->flags & IORESOURCE_MEM) &&
 			       (res->flags & IORESOURCE_PREFETCH)) {
-			out += sprintf(out, "start = %8.8llx, length = %8.8llx\n",
-				       (unsigned long long)res->start,
-				       (unsigned long long)resource_size(res));
+			len += sysfs_emit_at(buf, len,
+					     "start = %8.8llx, length = %8.8llx\n",
+					     (unsigned long long)res->start,
+					     (unsigned long long)resource_size(res));
 		}
 	}
-	out += sprintf(out, "Free resources: IO\n");
+	len += sysfs_emit_at(buf, len, "Free resources: IO\n");
 	pci_bus_for_each_resource(bus, res, index) {
 		if (res && (res->flags & IORESOURCE_IO)) {
-			out += sprintf(out, "start = %8.8llx, length = %8.8llx\n",
-				       (unsigned long long)res->start,
-				       (unsigned long long)resource_size(res));
+			len += sysfs_emit_at(buf, len,
+					     "start = %8.8llx, length = %8.8llx\n",
+					     (unsigned long long)res->start,
+					     (unsigned long long)resource_size(res));
 		}
 	}
-	out += sprintf(out, "Free resources: bus numbers\n");
+	len += sysfs_emit_at(buf, len, "Free resources: bus numbers\n");
 	for (busnr = bus->busn_res.start; busnr <= bus->busn_res.end; busnr++) {
 		if (!pci_find_bus(pci_domain_nr(bus), busnr))
 			break;
 	}
 	if (busnr < bus->busn_res.end)
-		out += sprintf(out, "start = %8.8x, length = %8.8x\n",
-				busnr, (int)(bus->busn_res.end - busnr));
+		len += sysfs_emit_at(buf, len,
+				     "start = %8.8x, length = %8.8x\n",
+				     busnr, (int)(bus->busn_res.end - busnr));
 
-	return out - buf;
+	return len;
 }
 static DEVICE_ATTR(ctrl, S_IRUGO, show_ctrl, NULL);
 
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index afc06e6ce115..a71258347323 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -346,7 +346,7 @@ static ssize_t sriov_totalvfs_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%u\n", pci_sriov_get_totalvfs(pdev));
+	return sysfs_emit(buf, "%u\n", pci_sriov_get_totalvfs(pdev));
 }
 
 static ssize_t sriov_numvfs_show(struct device *dev,
@@ -361,7 +361,7 @@ static ssize_t sriov_numvfs_show(struct device *dev,
 	num_vfs = pdev->sriov->num_VFs;
 	device_unlock(&pdev->dev);
 
-	return sprintf(buf, "%u\n", num_vfs);
+	return sysfs_emit(buf, "%u\n", num_vfs);
 }
 
 /*
@@ -435,7 +435,7 @@ static ssize_t sriov_offset_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%u\n", pdev->sriov->offset);
+	return sysfs_emit(buf, "%u\n", pdev->sriov->offset);
 }
 
 static ssize_t sriov_stride_show(struct device *dev,
@@ -444,7 +444,7 @@ static ssize_t sriov_stride_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%u\n", pdev->sriov->stride);
+	return sysfs_emit(buf, "%u\n", pdev->sriov->stride);
 }
 
 static ssize_t sriov_vf_device_show(struct device *dev,
@@ -453,7 +453,7 @@ static ssize_t sriov_vf_device_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%x\n", pdev->sriov->vf_device);
+	return sysfs_emit(buf, "%x\n", pdev->sriov->vf_device);
 }
 
 static ssize_t sriov_drivers_autoprobe_show(struct device *dev,
@@ -462,7 +462,7 @@ static ssize_t sriov_drivers_autoprobe_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%u\n", pdev->sriov->drivers_autoprobe);
+	return sysfs_emit(buf, "%u\n", pdev->sriov->drivers_autoprobe);
 }
 
 static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 217dc9f0231f..9232255c8515 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -464,11 +464,11 @@ static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
 		return retval;
 
 	entry = irq_get_msi_desc(irq);
-	if (entry)
-		return sprintf(buf, "%s\n",
-				entry->msi_attrib.is_msix ? "msix" : "msi");
+	if (!entry)
+		return -ENODEV;
 
-	return -ENODEV;
+	return sysfs_emit(buf, "%s\n",
+			  entry->msi_attrib.is_msix ? "msix" : "msi");
 }
 
 static int populate_msi_sysfs(struct pci_dev *pdev)
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 196382630363..a1351b3e2c4c 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -53,7 +53,7 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 	if (pdev->p2pdma->pool)
 		size = gen_pool_size(pdev->p2pdma->pool);
 
-	return scnprintf(buf, PAGE_SIZE, "%zd\n", size);
+	return sysfs_emit(buf, "%zd\n", size);
 }
 static DEVICE_ATTR_RO(size);
 
@@ -66,7 +66,7 @@ static ssize_t available_show(struct device *dev, struct device_attribute *attr,
 	if (pdev->p2pdma->pool)
 		avail = gen_pool_avail(pdev->p2pdma->pool);
 
-	return scnprintf(buf, PAGE_SIZE, "%zd\n", avail);
+	return sysfs_emit(buf, "%zd\n", avail);
 }
 static DEVICE_ATTR_RO(available);
 
@@ -75,8 +75,7 @@ static ssize_t published_show(struct device *dev, struct device_attribute *attr,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n",
-			 pdev->p2pdma->p2pmem_published);
+	return sysfs_emit(buf, "%d\n", pdev->p2pdma->p2pmem_published);
 }
 static DEVICE_ATTR_RO(published);
 
diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index c32f3b7540e8..311dd48e2881 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -175,11 +175,11 @@ static int dsm_get_label(struct device *dev, char *buf,
 		 * this entry must return a null string.
 		 */
 		if (attr == ACPI_ATTR_INDEX_SHOW) {
-			scnprintf(buf, PAGE_SIZE, "%llu\n", tmp->integer.value);
+			sysfs_emit(buf, "%llu\n", tmp->integer.value);
 		} else if (attr == ACPI_ATTR_LABEL_SHOW) {
 			if (tmp[1].type == ACPI_TYPE_STRING)
-				scnprintf(buf, PAGE_SIZE, "%s\n",
-					  tmp[1].string.pointer);
+				sysfs_emit(buf, "%s\n",
+					   tmp[1].string.pointer);
 			else if (tmp[1].type == ACPI_TYPE_BUFFER)
 				dsm_label_utf16s_to_utf8s(tmp + 1, buf);
 		}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b717680377a9..5ed316ea5831 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6439,7 +6439,7 @@ static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
 
 	spin_lock(&resource_alignment_lock);
 	if (resource_alignment_param)
-		count = scnprintf(buf, PAGE_SIZE, "%s", resource_alignment_param);
+		count = sysfs_emit(buf, "%s", resource_alignment_param);
 	spin_unlock(&resource_alignment_lock);
 
 	/*
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ec943cee5ecc..40ef7bed7a77 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -529,21 +529,23 @@ static const char *aer_agent_string[] = {
 		     char *buf)						\
 {									\
 	unsigned int i;							\
-	char *str = buf;						\
 	struct pci_dev *pdev = to_pci_dev(dev);				\
 	u64 *stats = pdev->aer_stats->stats_array;			\
+	size_t len = 0;							\
 									\
 	for (i = 0; i < ARRAY_SIZE(strings_array); i++) {		\
 		if (strings_array[i])					\
-			str += sprintf(str, "%s %llu\n",		\
-				       strings_array[i], stats[i]);	\
+			len += sysfs_emit_at(buf, len, "%s %llu\n",	\
+					     strings_array[i],		\
+					     stats[i]);			\
 		else if (stats[i])					\
-			str += sprintf(str, #stats_array "_bit[%d] %llu\n",\
-				       i, stats[i]);			\
+			len += sysfs_emit_at(buf, len,			\
+					     #stats_array "_bit[%d] %llu\n",\
+					     i, stats[i]);		\
 	}								\
-	str += sprintf(str, "TOTAL_%s %llu\n", total_string,		\
-		       pdev->aer_stats->total_field);			\
-	return str-buf;							\
+	len += sysfs_emit_at(buf, len, "TOTAL_%s %llu\n", total_string,	\
+			     pdev->aer_stats->total_field);		\
+	return len;							\
 }									\
 static DEVICE_ATTR_RO(name)
 
@@ -563,7 +565,7 @@ aer_stats_dev_attr(aer_dev_nonfatal, dev_nonfatal_errs,
 		     char *buf)						\
 {									\
 	struct pci_dev *pdev = to_pci_dev(dev);				\
-	return sprintf(buf, "%llu\n", pdev->aer_stats->field);		\
+	return sysfs_emit(buf, "%llu\n", pdev->aer_stats->field);	\
 }									\
 static DEVICE_ATTR_RO(name)
 
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index ac0557a305af..013a47f587ce 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1208,7 +1208,7 @@ static ssize_t aspm_attr_show_common(struct device *dev,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 
-	return sprintf(buf, "%d\n", (link->aspm_enabled & state) ? 1 : 0);
+	return sysfs_emit(buf, "%d\n", (link->aspm_enabled & state) ? 1 : 0);
 }
 
 static ssize_t aspm_attr_store_common(struct device *dev,
@@ -1265,7 +1265,7 @@ static ssize_t clkpm_show(struct device *dev,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 
-	return sprintf(buf, "%d\n", link->clkpm_enabled);
+	return sysfs_emit(buf, "%d\n", link->clkpm_enabled);
 }
 
 static ssize_t clkpm_store(struct device *dev,
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index d627dd9179b4..751a26668e3a 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -39,19 +39,19 @@ static const struct sysfs_ops pci_slot_sysfs_ops = {
 static ssize_t address_read_file(struct pci_slot *slot, char *buf)
 {
 	if (slot->number == 0xff)
-		return sprintf(buf, "%04x:%02x\n",
-				pci_domain_nr(slot->bus),
-				slot->bus->number);
-	else
-		return sprintf(buf, "%04x:%02x:%02x\n",
-				pci_domain_nr(slot->bus),
-				slot->bus->number,
-				slot->number);
+		return sysfs_emit(buf, "%04x:%02x\n",
+				  pci_domain_nr(slot->bus),
+				  slot->bus->number);
+
+	return sysfs_emit(buf, "%04x:%02x:%02x\n",
+			  pci_domain_nr(slot->bus),
+			  slot->bus->number,
+			  slot->number);
 }
 
 static ssize_t bus_speed_read(enum pci_bus_speed speed, char *buf)
 {
-	return sprintf(buf, "%s\n", pci_speed_string(speed));
+	return sysfs_emit(buf, "%s\n", pci_speed_string(speed));
 }
 
 static ssize_t max_speed_read_file(struct pci_slot *slot, char *buf)
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index ba52459928f7..0b301f8be9ed 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -280,7 +280,7 @@ static ssize_t device_version_show(struct device *dev,
 
 	ver = ioread32(&stdev->mmio_sys_info->device_version);
 
-	return sprintf(buf, "%x\n", ver);
+	return sysfs_emit(buf, "%x\n", ver);
 }
 static DEVICE_ATTR_RO(device_version);
 
@@ -292,7 +292,7 @@ static ssize_t fw_version_show(struct device *dev,
 
 	ver = ioread32(&stdev->mmio_sys_info->firmware_version);
 
-	return sprintf(buf, "%08x\n", ver);
+	return sysfs_emit(buf, "%08x\n", ver);
 }
 static DEVICE_ATTR_RO(fw_version);
 
@@ -344,7 +344,7 @@ static ssize_t component_vendor_show(struct device *dev,
 
 	/* component_vendor field not supported after gen3 */
 	if (stdev->gen != SWITCHTEC_GEN3)
-		return sprintf(buf, "none\n");
+		return sysfs_emit(buf, "none\n");
 
 	return io_string_show(buf, &si->gen3.component_vendor,
 			      sizeof(si->gen3.component_vendor));
@@ -359,9 +359,9 @@ static ssize_t component_id_show(struct device *dev,
 
 	/* component_id field not supported after gen3 */
 	if (stdev->gen != SWITCHTEC_GEN3)
-		return sprintf(buf, "none\n");
+		return sysfs_emit(buf, "none\n");
 
-	return sprintf(buf, "PM%04X\n", id);
+	return sysfs_emit(buf, "PM%04X\n", id);
 }
 static DEVICE_ATTR_RO(component_id);
 
@@ -373,9 +373,9 @@ static ssize_t component_revision_show(struct device *dev,
 
 	/* component_revision field not supported after gen3 */
 	if (stdev->gen != SWITCHTEC_GEN3)
-		return sprintf(buf, "255\n");
+		return sysfs_emit(buf, "255\n");
 
-	return sprintf(buf, "%d\n", rev);
+	return sysfs_emit(buf, "%d\n", rev);
 }
 static DEVICE_ATTR_RO(component_revision);
 
@@ -384,7 +384,7 @@ static ssize_t partition_show(struct device *dev,
 {
 	struct switchtec_dev *stdev = to_stdev(dev);
 
-	return sprintf(buf, "%d\n", stdev->partition);
+	return sysfs_emit(buf, "%d\n", stdev->partition);
 }
 static DEVICE_ATTR_RO(partition);
 
@@ -393,7 +393,7 @@ static ssize_t partition_count_show(struct device *dev,
 {
 	struct switchtec_dev *stdev = to_stdev(dev);
 
-	return sprintf(buf, "%d\n", stdev->partition_count);
+	return sysfs_emit(buf, "%d\n", stdev->partition_count);
 }
 static DEVICE_ATTR_RO(partition_count);
 
-- 
2.31.1

