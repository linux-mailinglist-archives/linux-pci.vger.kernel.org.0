Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0113E0A55
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 00:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhHDW2w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 18:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhHDW2v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Aug 2021 18:28:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9099BC0613D5;
        Wed,  4 Aug 2021 15:28:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso4889025wmg.4;
        Wed, 04 Aug 2021 15:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=phT9CckMWNSerBPK6PdSivSlXanyd8PFiHPwYIyp3rs=;
        b=khaE0DAn9Hbzb8VYmijEVyqODSHEMqdtacNmYbYow03tZ/AbYcnykHvN5blba0NE3O
         C9Qw/zREVHIwlDXmEgiQ1G1ZXRv+Rg4bkyNGy7JdYw7MrUMtFpF1I0ilqmJxi4LMP5G3
         KNntTDIoEtzSElboMTDjuzLJ+bIR9BZ3lPxQgy8NRe9XmgNZlyNkYy88Th6jee3X3xnV
         gG33j6LTbL+4308oiBY13zlWDCK0JWHhQ06oY0e3uFfk9Ac5exHirQzHCjb+wkJJSnTV
         jrnSQWZqyRn/gHAlzwuTUaNfNn6zWesI2faJkB7nJUCKU1iQTFcKJIvl0AHYdayrcKOH
         T2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=phT9CckMWNSerBPK6PdSivSlXanyd8PFiHPwYIyp3rs=;
        b=Lki6fY6NuSh2pk6zA0PPg1UBQCMcbL9FQh0BEVfDgNQa3cQVZ9nLzqzt55cod1Hngc
         PyKjlsw4sKwfjMSEVvVfaEOHyt+sJM2znRN1BxBtdNzcY+9xlDLJE76ikpwjXLMCniuR
         V+bEWw1Z7ghvGLRZLrU8Vwxd41y/J5JPNPZftlMu1x4UaueZObxn4DHBqC86TXu/hJSz
         bVZ2rnh52JvbYE5W3z73daw3GlGTkbuJLBJAJD/eWmWvI+x2VpmXH235crmpL8xirqQE
         5keL3U0qT4lG2CoXORZJPfLEBY6XkAFrh5v2M/LO6EJJ2azjiVeI2cZj+pzCxS8cIkFj
         gVvw==
X-Gm-Message-State: AOAM533WBm1evgajpijO4hU1aPgtqCCUsj8a9XXAGANcCYjyDZCK0YxW
        35nS44+87Gyb9UBR5Oj16COPYYH1aQi9kw==
X-Google-Smtp-Source: ABdhPJwWFX/MJbC7wDiLE10o4q2UrTVKJx1quMfNkc/bHauoSWxjkAwBe2FhmzGPUqik42eL4663pg==
X-Received: by 2002:a1c:f414:: with SMTP id z20mr12040588wma.94.1628116115943;
        Wed, 04 Aug 2021 15:28:35 -0700 (PDT)
Received: from icebear.localdomain ([170.253.11.129])
        by smtp.gmail.com with ESMTPSA id h15sm3918691wrq.88.2021.08.04.15.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 15:28:35 -0700 (PDT)
From:   "=?UTF-8?q?Sergio=20Migu=C3=A9ns=20Iglesias?=" <lonyelon@gmail.com>
X-Google-Original-From: =?UTF-8?q?Sergio=20Migu=C3=A9ns=20Iglesias?= <sergio@lony.xyz>
To:     bhelgaas@google.com
Cc:     rjw@rjwysocki.net, lenb@kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, konrad.wilk@oracle.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org,
        =?UTF-8?q?Sergio=20Migu=C3=A9ns=20Iglesias?= <sergio@lony.xyz>
Subject: [PATCH] PCI: Fix general code style
Date:   Thu,  5 Aug 2021 00:28:32 +0200
Message-Id: <20210804222832.1023161-1-sergio@lony.xyz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The code style for most files was fixed. This means that blank lines
were added when needed (normally after variable declarations), spaces
before tabs were removed, some code alignment issues were solved, block
comment style was fixed, every instance of "unsigned var" was replaced
with "unsigned int var"... Etc.

This commit does not change the logic of the code, it just fixes
aesthetic problems.

Signed-off-by: Sergio Miguéns Iglesias <sergio@lony.xyz>
---
 drivers/pci/access.c       | 22 +++++++++++++---------
 drivers/pci/bus.c          |  3 ++-
 drivers/pci/msi.c          | 12 +++++++-----
 drivers/pci/pci-acpi.c     |  3 ++-
 drivers/pci/pci-driver.c   | 19 +++++++++++++------
 drivers/pci/pci-sysfs.c    | 14 ++++++++++++--
 drivers/pci/pci.c          | 16 ++++++++++++----
 drivers/pci/proc.c         | 15 +++++++++++++++
 drivers/pci/quirks.c       | 35 ++++++++++++++++++++++++-----------
 drivers/pci/remove.c       |  1 +
 drivers/pci/rom.c          |  2 +-
 drivers/pci/setup-bus.c    |  5 ++++-
 drivers/pci/setup-irq.c    | 12 +++++++-----
 drivers/pci/setup-res.c    |  2 +-
 drivers/pci/slot.c         |  5 ++++-
 drivers/pci/syscall.c      |  5 +++--
 drivers/pci/xen-pcifront.c | 20 ++++++++++++--------
 17 files changed, 133 insertions(+), 58 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 46935695cfb9..4f8d04a0ac1d 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -33,13 +33,15 @@ DEFINE_RAW_SPINLOCK(pci_lock);
 #endif
 
 #define PCI_OP_READ(size, type, len) \
-int noinline pci_bus_read_config_##size \
+noinline int pci_bus_read_config_##size \
 	(struct pci_bus *bus, unsigned int devfn, int pos, type *value)	\
 {									\
 	int res;							\
 	unsigned long flags;						\
+									\
 	u32 data = 0;							\
-	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
+	if (PCI_##size##_BAD)						\
+		return PCIBIOS_BAD_REGISTER_NUMBER;			\
 	pci_lock_config(flags);						\
 	res = bus->ops->read(bus, devfn, pos, len, &data);		\
 	*value = (type)data;						\
@@ -48,12 +50,14 @@ int noinline pci_bus_read_config_##size \
 }
 
 #define PCI_OP_WRITE(size, type, len) \
-int noinline pci_bus_write_config_##size \
+noinline int pci_bus_write_config_##size \
 	(struct pci_bus *bus, unsigned int devfn, int pos, type value)	\
 {									\
 	int res;							\
 	unsigned long flags;						\
-	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
+									\
+	if (PCI_##size##_BAD)						\
+		return PCIBIOS_BAD_REGISTER_NUMBER;			\
 	pci_lock_config(flags);						\
 	res = bus->ops->write(bus, devfn, pos, len, value);		\
 	pci_unlock_config(flags);					\
@@ -214,7 +218,7 @@ static noinline void pci_wait_cfg(struct pci_dev *dev)
 }
 
 /* Returns 0 on success, negative values indicate error. */
-#define PCI_USER_READ_CONFIG(size, type)					\
+#define PCI_USER_READ_CONFIG(size, type)				\
 int pci_user_read_config_##size						\
 	(struct pci_dev *dev, int pos, type *val)			\
 {									\
@@ -222,12 +226,12 @@ int pci_user_read_config_##size						\
 	u32 data = -1;							\
 	if (PCI_##size##_BAD)						\
 		return -EINVAL;						\
-	raw_spin_lock_irq(&pci_lock);				\
+	raw_spin_lock_irq(&pci_lock);					\
 	if (unlikely(dev->block_cfg_access))				\
 		pci_wait_cfg(dev);					\
 	ret = dev->bus->ops->read(dev->bus, dev->devfn,			\
 					pos, sizeof(type), &data);	\
-	raw_spin_unlock_irq(&pci_lock);				\
+	raw_spin_unlock_irq(&pci_lock);					\
 	*val = (type)data;						\
 	return pcibios_err_to_errno(ret);				\
 }									\
@@ -241,12 +245,12 @@ int pci_user_write_config_##size					\
 	int ret = PCIBIOS_SUCCESSFUL;					\
 	if (PCI_##size##_BAD)						\
 		return -EINVAL;						\
-	raw_spin_lock_irq(&pci_lock);				\
+	raw_spin_lock_irq(&pci_lock);					\
 	if (unlikely(dev->block_cfg_access))				\
 		pci_wait_cfg(dev);					\
 	ret = dev->bus->ops->write(dev->bus, dev->devfn,		\
 					pos, sizeof(type), val);	\
-	raw_spin_unlock_irq(&pci_lock);				\
+	raw_spin_unlock_irq(&pci_lock);					\
 	return pcibios_err_to_errno(ret);				\
 }									\
 EXPORT_SYMBOL_GPL(pci_user_write_config_##size);
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 3cef835b375f..c6cad291c7ac 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -178,7 +178,8 @@ static int pci_bus_alloc_from_region(struct pci_bus *bus, struct resource *res,
 			continue;
 
 		/* We cannot allocate a non-prefetching resource
-		   from a pre-fetching area */
+		 * from a pre-fetching area
+		 */
 		if ((r->flags & IORESOURCE_PREFETCH) &&
 		    !(res->flags & IORESOURCE_PREFETCH))
 			continue;
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 9232255c8515..bd62dfe9e361 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -129,7 +129,7 @@ void __weak arch_restore_msi_irqs(struct pci_dev *dev)
 	return default_restore_msi_irqs(dev);
 }
 
-static inline __attribute_const__ u32 msi_mask(unsigned x)
+static inline __attribute_const__ u32 msi_mask(unsigned int x)
 {
 	/* Don't shift by >= width of type */
 	if (x >= 5)
@@ -213,7 +213,8 @@ static void msi_set_mask_bit(struct irq_data *data, u32 flag)
 		msix_mask_irq(desc, flag);
 		readl(desc->mask_base);		/* Flush write to device */
 	} else {
-		unsigned offset = data->irq - desc->irq;
+		unsigned int offset = data->irq - desc->irq;
+
 		msi_mask_irq(desc, 1 << offset, flag << offset);
 	}
 }
@@ -619,7 +620,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 {
 	struct msi_desc *entry;
 	int ret;
-	unsigned mask;
+	unsigned int mask;
 
 	pci_msi_set_enable(dev, 0);	/* Disable MSI during set up */
 
@@ -665,7 +666,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	return 0;
 }
 
-static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
+static void __iomem *msix_map_region(struct pci_dev *dev, unsigned int nr_entries)
 {
 	resource_size_t phys_addr;
 	u32 table_offset;
@@ -1108,6 +1109,7 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 int pci_enable_msi(struct pci_dev *dev)
 {
 	int rc = __pci_enable_msi_range(dev, 1, 1, NULL);
+
 	if (rc < 0)
 		return rc;
 	return 0;
@@ -1367,7 +1369,7 @@ static inline bool pci_msi_desc_is_multi_msi(struct msi_desc *desc)
 
 /**
  * pci_msi_domain_check_cap - Verify that @domain supports the capabilities
- * 			      for @dev
+ *			      for @dev
  * @domain:	The interrupt domain to check
  * @info:	The domain info for verification
  * @dev:	The device to check
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 36bc23e21759..22d6ea1af809 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -985,6 +985,7 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 static bool acpi_pci_power_manageable(struct pci_dev *dev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
+
 	return adev ? acpi_device_power_manageable(adev) : false;
 }
 
@@ -1021,7 +1022,7 @@ static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 
 	if (!error)
 		pci_dbg(dev, "power state changed by ACPI to %s\n",
-		        acpi_power_state_string(adev->power.state));
+			acpi_power_state_string(adev->power.state));
 
 	return error;
 }
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 3a72352aa5cf..4642fe870f5a 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -189,6 +189,7 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
 
 	if (fields != 7) {
 		struct pci_dev *pdev = kzalloc(sizeof(*pdev), GFP_KERNEL);
+
 		if (!pdev)
 			return -ENOMEM;
 
@@ -208,7 +209,8 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
 	}
 
 	/* Only accept driver_data values that match an existing id_table
-	   entry */
+	 * entry
+	 */
 	if (ids) {
 		retval = -EINVAL;
 		while (ids->vendor || ids->subvendor || ids->class_mask) {
@@ -257,6 +259,7 @@ static ssize_t remove_id_store(struct device_driver *driver, const char *buf,
 	spin_lock(&pdrv->dynids.lock);
 	list_for_each_entry_safe(dynid, n, &pdrv->dynids.list, node) {
 		struct pci_device_id *id = &dynid->id;
+
 		if ((id->vendor == vendor) &&
 		    (id->device == device) &&
 		    (subvendor == PCI_ANY_ID || id->subvendor == subvendor) &&
@@ -514,6 +517,7 @@ static int pci_restore_standard_config(struct pci_dev *pci_dev)
 
 	if (pci_dev->current_state != PCI_D0) {
 		int error = pci_set_power_state(pci_dev, PCI_D0);
+
 		if (error)
 			return error;
 	}
@@ -661,6 +665,7 @@ static int pci_pm_prepare(struct device *dev)
 
 	if (pm && pm->prepare) {
 		int error = pm->prepare(dev);
+
 		if (error < 0)
 			return error;
 
@@ -1425,14 +1430,16 @@ static struct pci_driver pci_compat_driver = {
  */
 struct pci_driver *pci_dev_driver(const struct pci_dev *dev)
 {
+	int i;
+
 	if (dev->driver)
 		return dev->driver;
-	else {
-		int i;
-		for (i = 0; i <= PCI_ROM_RESOURCE; i++)
-			if (dev->resource[i].flags & IORESOURCE_BUSY)
-				return &pci_compat_driver;
+
+	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
+		if (dev->resource[i].flags & IORESOURCE_BUSY)
+			return &pci_compat_driver;
 	}
+
 	return NULL;
 }
 EXPORT_SYMBOL(pci_dev_driver);
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5d63df7c1820..79d82696ce28 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -56,6 +56,7 @@ static ssize_t broken_parity_status_show(struct device *dev,
 					 char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+
 	return sysfs_emit(buf, "%u\n", pdev->broken_parity_status);
 }
 
@@ -150,6 +151,7 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
 
 	for (i = 0; i < max; i++) {
 		struct resource *res =  &pci_dev->resource[i];
+
 		pci_resource_to_user(pci_dev, i, res, &start, &end);
 		len += sysfs_emit_at(buf, len, "0x%016llx 0x%016llx 0x%016llx\n",
 				     (unsigned long long)start,
@@ -523,6 +525,7 @@ static ssize_t d3cold_allowed_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+
 	return sysfs_emit(buf, "%u\n", pdev->d3cold_allowed);
 }
 static DEVICE_ATTR_RW(d3cold_allowed);
@@ -686,14 +689,14 @@ static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
 	if (off + count > size) {
 		size -= off;
 		count = size;
-	} else {
+	} else
 		size = count;
-	}
 
 	pci_config_pm_runtime_get(dev);
 
 	if ((off & 1) && size) {
 		u8 val;
+
 		pci_user_read_config_byte(dev, off, &val);
 		data[off - init_off] = val;
 		off++;
@@ -702,6 +705,7 @@ static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
 
 	if ((off & 3) && size > 2) {
 		u16 val;
+
 		pci_user_read_config_word(dev, off, &val);
 		data[off - init_off] = val & 0xff;
 		data[off - init_off + 1] = (val >> 8) & 0xff;
@@ -711,6 +715,7 @@ static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
 
 	while (size > 3) {
 		u32 val;
+
 		pci_user_read_config_dword(dev, off, &val);
 		data[off - init_off] = val & 0xff;
 		data[off - init_off + 1] = (val >> 8) & 0xff;
@@ -723,6 +728,7 @@ static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
 
 	if (size >= 2) {
 		u16 val;
+
 		pci_user_read_config_word(dev, off, &val);
 		data[off - init_off] = val & 0xff;
 		data[off - init_off + 1] = (val >> 8) & 0xff;
@@ -732,6 +738,7 @@ static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
 
 	if (size > 0) {
 		u8 val;
+
 		pci_user_read_config_byte(dev, off, &val);
 		data[off - init_off] = val;
 		off++;
@@ -774,6 +781,7 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
 
 	if ((off & 3) && size > 2) {
 		u16 val = data[off - init_off];
+
 		val |= (u16) data[off - init_off + 1] << 8;
 		pci_user_write_config_word(dev, off, val);
 		off += 2;
@@ -782,6 +790,7 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
 
 	while (size > 3) {
 		u32 val = data[off - init_off];
+
 		val |= (u32) data[off - init_off + 1] << 8;
 		val |= (u32) data[off - init_off + 2] << 16;
 		val |= (u32) data[off - init_off + 3] << 24;
@@ -792,6 +801,7 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
 
 	if (size >= 2) {
 		u16 val = data[off - init_off];
+
 		val |= (u16) data[off - init_off + 1] << 8;
 		pci_user_write_config_word(dev, off, val);
 		off += 2;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index aacf575c15cf..0510f5b6f26f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -805,6 +805,7 @@ int pci_wait_for_pending(struct pci_dev *dev, int pos, u16 mask)
 	/* Wait for Transaction Pending bit clean */
 	for (i = 0; i < 4; i++) {
 		u16 status;
+
 		if (i)
 			msleep((1 << (i - 1)) * 100);
 
@@ -1757,6 +1758,7 @@ struct pci_saved_state *pci_store_saved_state(struct pci_dev *dev)
 	cap = state->cap;
 	hlist_for_each_entry(tmp, &dev->saved_cap_space, next) {
 		size_t len = sizeof(struct pci_cap_saved_data) + tmp->cap.size;
+
 		memcpy(cap, &tmp->cap, len);
 		cap = (struct pci_cap_saved_data *)((u8 *)cap + len);
 	}
@@ -1812,6 +1814,7 @@ int pci_load_and_free_saved_state(struct pci_dev *dev,
 				  struct pci_saved_state **state)
 {
 	int ret = pci_load_saved_state(dev, *state);
+
 	kfree(*state);
 	*state = NULL;
 	return ret;
@@ -1908,6 +1911,7 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
 	 */
 	if (dev->pm_cap) {
 		u16 pmcsr;
+
 		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 		dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
 	}
@@ -2417,6 +2421,7 @@ void pci_pme_active(struct pci_dev *dev, bool enable)
 
 	if (dev->pme_poll) {
 		struct pci_pme_device *pme_dev;
+
 		if (enable) {
 			pme_dev = kmalloc(sizeof(struct pci_pme_device),
 					  GFP_KERNEL);
@@ -4322,7 +4327,7 @@ void __weak pcibios_set_master(struct pci_dev *dev)
 
 	pci_read_config_byte(dev, PCI_LATENCY_TIMER, &lat);
 	if (lat < 16)
-		lat = (64 <= pcibios_max_latency) ? 64 : pcibios_max_latency;
+		lat = (pcibios_max_latency >= 64) ? 64 : pcibios_max_latency;
 	else if (lat > pcibios_max_latency)
 		lat = pcibios_max_latency;
 	else
@@ -4373,7 +4378,8 @@ int pci_set_cacheline_size(struct pci_dev *dev)
 		return -EINVAL;
 
 	/* Validate current setting: the PCI_CACHE_LINE_SIZE must be
-	   equal to or multiple of the right value. */
+	 * equal to or multiple of the right value.
+	 */
 	pci_read_config_byte(dev, PCI_CACHE_LINE_SIZE, &cacheline_size);
 	if (cacheline_size >= pci_cache_line_size &&
 	    (cacheline_size % pci_cache_line_size) == 0)
@@ -6059,6 +6065,7 @@ EXPORT_SYMBOL(pcie_print_link_status);
 int pci_select_bars(struct pci_dev *dev, unsigned long flags)
 {
 	int i, bars = 0;
+
 	for (i = 0; i < PCI_NUM_RESOURCES; i++)
 		if (pci_resource_flags(dev, i) & flags)
 			bars |= (1 << i);
@@ -6174,11 +6181,11 @@ EXPORT_SYMBOL_GPL(pci_pr3_present);
  * cannot be left as a userspace activity).  DMA aliases should therefore
  * be configured via quirks, such as the PCI fixup header quirk.
  */
-void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned nr_devfns)
+void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned int nr_devfns)
 {
 	int devfn_to;
 
-	nr_devfns = min(nr_devfns, (unsigned) MAX_NR_DEVFNS - devfn_from);
+	nr_devfns = min(nr_devfns, (unsigned int) MAX_NR_DEVFNS - devfn_from);
 	devfn_to = devfn_from + nr_devfns - 1;
 
 	if (!dev->dma_alias_mask)
@@ -6593,6 +6600,7 @@ static int __init pci_setup(char *str)
 {
 	while (str) {
 		char *k = strchr(str, ',');
+
 		if (k)
 			*k++ = 0;
 		if (*str && (str = pcibios_setup(str)) && *str) {
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index d32fbfc93ea9..57b61d9f13c1 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -22,6 +22,7 @@ static int proc_initialized;	/* = 0 */
 static loff_t proc_bus_pci_lseek(struct file *file, loff_t off, int whence)
 {
 	struct pci_dev *dev = PDE_DATA(file_inode(file));
+
 	return fixed_size_llseek(file, off, whence, dev->cfg_size);
 }
 
@@ -60,6 +61,7 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 
 	if ((pos & 1) && cnt) {
 		unsigned char val;
+
 		pci_user_read_config_byte(dev, pos, &val);
 		__put_user(val, buf);
 		buf++;
@@ -69,6 +71,7 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 
 	if ((pos & 3) && cnt > 2) {
 		unsigned short val;
+
 		pci_user_read_config_word(dev, pos, &val);
 		__put_user(cpu_to_le16(val), (__le16 __user *) buf);
 		buf += 2;
@@ -78,6 +81,7 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 
 	while (cnt >= 4) {
 		unsigned int val;
+
 		pci_user_read_config_dword(dev, pos, &val);
 		__put_user(cpu_to_le32(val), (__le32 __user *) buf);
 		buf += 4;
@@ -87,6 +91,7 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 
 	if (cnt >= 2) {
 		unsigned short val;
+
 		pci_user_read_config_word(dev, pos, &val);
 		__put_user(cpu_to_le16(val), (__le16 __user *) buf);
 		buf += 2;
@@ -96,6 +101,7 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 
 	if (cnt) {
 		unsigned char val;
+
 		pci_user_read_config_byte(dev, pos, &val);
 		__put_user(val, buf);
 		buf++;
@@ -137,6 +143,7 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 
 	if ((pos & 1) && cnt) {
 		unsigned char val;
+
 		__get_user(val, buf);
 		pci_user_write_config_byte(dev, pos, val);
 		buf++;
@@ -146,6 +153,7 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 
 	if ((pos & 3) && cnt > 2) {
 		__le16 val;
+
 		__get_user(val, (__le16 __user *) buf);
 		pci_user_write_config_word(dev, pos, le16_to_cpu(val));
 		buf += 2;
@@ -155,6 +163,7 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 
 	while (cnt >= 4) {
 		__le32 val;
+
 		__get_user(val, (__le32 __user *) buf);
 		pci_user_write_config_dword(dev, pos, le32_to_cpu(val));
 		buf += 4;
@@ -164,6 +173,7 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 
 	if (cnt >= 2) {
 		__le16 val;
+
 		__get_user(val, (__le16 __user *) buf);
 		pci_user_write_config_word(dev, pos, le16_to_cpu(val));
 		buf += 2;
@@ -173,6 +183,7 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 
 	if (cnt) {
 		unsigned char val;
+
 		__get_user(val, buf);
 		pci_user_write_config_byte(dev, pos, val);
 		buf++;
@@ -356,6 +367,7 @@ static void pci_seq_stop(struct seq_file *m, void *v)
 {
 	if (v) {
 		struct pci_dev *dev = v;
+
 		pci_dev_put(dev);
 	}
 }
@@ -380,6 +392,7 @@ static int show_device(struct seq_file *m, void *v)
 	/* only print standard and ROM resources to preserve compatibility */
 	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
 		resource_size_t start, end;
+
 		pci_resource_to_user(dev, i, &dev->resource[i], &start, &end);
 		seq_printf(m, "\t%16llx",
 			(unsigned long long)(start |
@@ -387,6 +400,7 @@ static int show_device(struct seq_file *m, void *v)
 	}
 	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
 		resource_size_t start, end;
+
 		pci_resource_to_user(dev, i, &dev->resource[i], &start, &end);
 		seq_printf(m, "\t%16llx",
 			dev->resource[i].start < dev->resource[i].end ?
@@ -456,6 +470,7 @@ int pci_proc_detach_bus(struct pci_bus *bus)
 static int __init pci_proc_init(void)
 {
 	struct pci_dev *dev = NULL;
+
 	proc_bus_pci_dir = proc_mkdir("bus/pci", NULL);
 	proc_create_seq("devices", 0, proc_bus_pci_dir,
 		    &proc_bus_pci_devices_op);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6d74386eadc2..e4c607d860c4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -177,7 +177,7 @@ static int __init pci_apply_final_quirks(void)
 				continue;
 
 			pci_info(dev, "CLS mismatch (%u != %u), using %u bytes\n",
-			         cls << 2, tmp << 2,
+				 cls << 2, tmp << 2,
 				 pci_dfl_cache_line_size << 2);
 			pci_cache_line_size = pci_dfl_cache_line_size;
 		}
@@ -299,6 +299,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_496,		quirk_nopcipci)
 static void quirk_nopciamd(struct pci_dev *dev)
 {
 	u8 rev;
+
 	pci_read_config_byte(dev, 0x08, &rev);
 	if (rev == 0x13) {
 		/* Erratum 24 */
@@ -501,7 +502,7 @@ static void quirk_s3_64M(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_868,		quirk_s3_64M);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_968,		quirk_s3_64M);
 
-static void quirk_io(struct pci_dev *dev, int pos, unsigned size,
+static void quirk_io(struct pci_dev *dev, int pos, unsigned int size,
 		     const char *name)
 {
 	u32 region;
@@ -552,7 +553,7 @@ static void quirk_cs5536_vsa(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA, quirk_cs5536_vsa);
 
 static void quirk_io_region(struct pci_dev *dev, int port,
-				unsigned size, int nr, const char *name)
+				unsigned int size, int nr, const char *name)
 {
 	u16 region;
 	struct pci_bus_region bus_region;
@@ -666,7 +667,8 @@ static void piix4_io_quirk(struct pci_dev *dev, const char *name, unsigned int p
 	base = devres & 0xffff;
 	size = 16;
 	for (;;) {
-		unsigned bit = size >> 1;
+		unsigned int bit = size >> 1;
+
 		if ((bit & mask) == bit)
 			break;
 		size = bit;
@@ -692,7 +694,8 @@ static void piix4_mem_quirk(struct pci_dev *dev, const char *name, unsigned int
 	mask = (devres & 0x3f) << 16;
 	size = 128 << 16;
 	for (;;) {
-		unsigned bit = size >> 1;
+		unsigned int bit = size >> 1;
+
 		if ((bit & mask) == bit)
 			break;
 		size = bit;
@@ -806,7 +809,7 @@ static void ich6_lpc_acpi_gpio(struct pci_dev *dev)
 				"ICH6 GPIO");
 }
 
-static void ich6_lpc_generic_decode(struct pci_dev *dev, unsigned reg,
+static void ich6_lpc_generic_decode(struct pci_dev *dev, unsigned int reg,
 				    const char *name, int dynsize)
 {
 	u32 val;
@@ -850,7 +853,7 @@ static void quirk_ich6_lpc(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_0, quirk_ich6_lpc);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1, quirk_ich6_lpc);
 
-static void ich7_lpc_generic_decode(struct pci_dev *dev, unsigned reg,
+static void ich7_lpc_generic_decode(struct pci_dev *dev, unsigned int reg,
 				    const char *name)
 {
 	u32 val;
@@ -1194,6 +1197,7 @@ DECLARE_PCI_FIXUP_CLASS_RESUME_EARLY(PCI_ANY_ID, PCI_ANY_ID,
 static void quirk_amd_ordering(struct pci_dev *dev)
 {
 	u32 pcic;
+
 	pci_read_config_dword(dev, 0x4C, &pcic);
 	if ((pcic & 6) != 6) {
 		pcic |= 6;
@@ -1308,6 +1312,7 @@ DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AMD, 0x7900, quirk_amd_ide_mode);
 static void quirk_svwks_csb5ide(struct pci_dev *pdev)
 {
 	u8 prog;
+
 	pci_read_config_byte(pdev, PCI_CLASS_PROG, &prog);
 	if (prog & 5) {
 		prog &= ~5;
@@ -1348,7 +1353,8 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID,
 				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
 /* VIA comes back fine but we need to keep it alive or ACPI GTM failures
-   occur when mode detecting */
+ * occur when mode detecting
+ */
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
 				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
 
@@ -1482,7 +1488,8 @@ static void asus_hides_smbus_hostbridge(struct pci_dev *dev)
 			case 0xB16C: /* Compaq Deskpro EP 401963-001 (PCA# 010174) */
 				/* Motherboard doesn't have Host bridge
 				 * subvendor/subdevice IDs, therefore checking
-				 * its on-board VGA controller */
+				 * its on-board VGA controller
+				 */
 				asus_hides_smbus = 1;
 			}
 		else if (dev->device == PCI_DEVICE_ID_INTEL_82801DB_2)
@@ -1494,7 +1501,8 @@ static void asus_hides_smbus_hostbridge(struct pci_dev *dev)
 				 * subvendor/subdevice IDs and on-board VGA
 				 * controller is disabled if an AGP card is
 				 * inserted, therefore checking USB UHCI
-				 * Controller #1 */
+				 * Controller #1
+				 */
 				asus_hides_smbus = 1;
 			}
 		else if (dev->device == PCI_DEVICE_ID_INTEL_82815_CGC)
@@ -1502,7 +1510,8 @@ static void asus_hides_smbus_hostbridge(struct pci_dev *dev)
 			case 0x001A: /* Compaq Deskpro EN SSF P667 815E */
 				/* Motherboard doesn't have host bridge
 				 * subvendor/subdevice IDs, therefore checking
-				 * its on-board VGA controller */
+				 * its on-board VGA controller
+				 */
 				asus_hides_smbus = 1;
 			}
 	}
@@ -1611,6 +1620,7 @@ DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,
 static void quirk_sis_96x_smbus(struct pci_dev *dev)
 {
 	u8 val = 0;
+
 	pci_read_config_byte(dev, 0x77, &val);
 	if (val & 0x10) {
 		pci_info(dev, "Enabling SiS 96x SMBus\n");
@@ -2178,6 +2188,7 @@ static void quirk_plx_pci9050(struct pci_dev *dev)
 		if (pci_resource_len(dev, bar) == 0x80 &&
 		    (pci_resource_start(dev, bar) & 0x80)) {
 			struct resource *r = &dev->resource[bar];
+
 			pci_info(dev, "Re-allocating PLX PCI 9050 BAR %u to length 256 to avoid bit 7 bug\n",
 				 bar);
 			r->flags |= IORESOURCE_UNSET;
@@ -2469,6 +2480,7 @@ static void quirk_brcm_5719_limit_mrrs(struct pci_dev *dev)
 	/* Only CAP the MRRS if the device is a 5719 A0 */
 	if (rev == 0x05719000) {
 		int readrq = pcie_get_readrq(dev);
+
 		if (readrq > 2048)
 			pcie_set_readrq(dev, 2048);
 	}
@@ -3351,6 +3363,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0e0d, quirk_intel_ntb);
 static void disable_igfx_irq(struct pci_dev *dev)
 {
 	void __iomem *regs = pci_iomap(dev, 0, 0);
+
 	if (regs == NULL) {
 		pci_warn(dev, "igfx quirk: Can't iomap PCI device\n");
 		return;
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index dd12c2fcc7dc..e93241b2ca6e 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -9,6 +9,7 @@ static void pci_free_resources(struct pci_dev *dev)
 
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		struct resource *res = dev->resource + i;
+
 		if (res->parent)
 			release_resource(res);
 	}
diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index 8fc9a4e911e3..e18d3a4383ba 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -85,7 +85,7 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
 {
 	void __iomem *image;
 	int last_image;
-	unsigned length;
+	unsigned int length;
 
 	image = rom;
 	do {
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 2ce636937c6e..15c7b560a62b 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -186,6 +186,7 @@ static void __dev_sort_resources(struct pci_dev *dev, struct list_head *head)
 	/* Don't touch IOAPIC devices already enabled by firmware */
 	if (class == PCI_CLASS_SYSTEM_PIC) {
 		u16 command;
+
 		pci_read_config_word(dev, PCI_COMMAND, &command);
 		if (command & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY))
 			return;
@@ -1212,6 +1213,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct pci_bus *b = dev->subordinate;
+
 		if (!b)
 			continue;
 
@@ -1525,7 +1527,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 {
 	struct pci_dev *dev = bus->self;
 	struct resource *r;
-	unsigned old_flags = 0;
+	unsigned int old_flags = 0;
 	struct resource *b_res;
 	int idx = 1;
 
@@ -1597,6 +1599,7 @@ static void pci_bus_release_bridge_resources(struct pci_bus *bus,
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct pci_bus *b = dev->subordinate;
+
 		if (!b)
 			continue;
 
diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
index 7129494754dd..e9cd25069390 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -29,10 +29,11 @@ void pci_assign_irq(struct pci_dev *dev)
 	}
 
 	/* If this device is not on the primary bus, we need to figure out
-	   which interrupt pin it will come in on.   We know which slot it
-	   will come in on 'cos that slot is where the bridge is.   Each
-	   time the interrupt line passes through a PCI-PCI bridge we must
-	   apply the swizzle function.  */
+	 * which interrupt pin it will come in on.   We know which slot it
+	 *  will come in on 'cos that slot is where the bridge is.   Each
+	 * time the interrupt line passes through a PCI-PCI bridge we must
+	 * apply the swizzle function.
+	 */
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	/* Cope with illegal. */
@@ -57,6 +58,7 @@ void pci_assign_irq(struct pci_dev *dev)
 	pci_dbg(dev, "assign IRQ: got %d\n", dev->irq);
 
 	/* Always tell the device, so the driver knows what is
-	   the real IRQ to use; the device does not use it. */
+	 * the real IRQ to use; the device does not use it.
+	 */
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 }
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 7f1acb3918d0..1b969b8a57f6 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -240,7 +240,7 @@ resource_size_t __weak pcibios_align_resource(void *data,
 					      resource_size_t size,
 					      resource_size_t align)
 {
-       return res->start;
+	return res->start;
 }
 
 static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 751a26668e3a..3ce066fef724 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -20,6 +20,7 @@ static ssize_t pci_slot_attr_show(struct kobject *kobj,
 {
 	struct pci_slot *slot = to_pci_slot(kobj);
 	struct pci_slot_attribute *attribute = to_pci_slot_attr(attr);
+
 	return attribute->show ? attribute->show(slot, buf) : -EIO;
 }
 
@@ -28,6 +29,7 @@ static ssize_t pci_slot_attr_store(struct kobject *kobj,
 {
 	struct pci_slot *slot = to_pci_slot(kobj);
 	struct pci_slot_attribute *attribute = to_pci_slot_attr(attr);
+
 	return attribute->store ? attribute->store(slot, buf, len) : -EIO;
 }
 
@@ -123,6 +125,7 @@ static char *make_slot_name(const char *name)
 
 	for (;;) {
 		struct kobject *dup_slot;
+
 		dup_slot = kset_find_obj(pci_slots_kset, new_name);
 		if (!dup_slot)
 			break;
@@ -350,7 +353,7 @@ EXPORT_SYMBOL_GPL(pci_hp_create_module_link);
 
 /**
  * pci_hp_remove_module_link - remove symbolic link to the hotplug driver
- * 	module.
+ * module.
  * @pci_slot: struct pci_slot
  *
  * Helper function for pci_hotplug_core.c to remove symbolic link to
diff --git a/drivers/pci/syscall.c b/drivers/pci/syscall.c
index 8b003c890b87..985db1e59a9c 100644
--- a/drivers/pci/syscall.c
+++ b/drivers/pci/syscall.c
@@ -65,8 +65,9 @@ SYSCALL_DEFINE5(pciconfig_read, unsigned long, bus, unsigned long, dfn,
 
 error:
 	/* ??? XFree86 doesn't even check the return value.  They
-	   just look for 0xffffffff in the output, since that's what
-	   they get instead of a machine check on x86.  */
+	 * just look for 0xffffffff in the output, since that's what
+	 * they get instead of a machine check on x86.
+	 */
 	switch (len) {
 	case 1:
 		put_user(-1, (unsigned char __user *)buf);
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index b7a8f3a1921f..8b51393890a2 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -115,7 +115,7 @@ static int do_pci_op(struct pcifront_device *pdev, struct xen_pci_op *op)
 	struct xen_pci_op *active_op = &pdev->sh_info->op;
 	unsigned long irq_flags;
 	evtchn_port_t port = pdev->evtchn;
-	unsigned irq = pdev->irq;
+	unsigned int irq = pdev->irq;
 	s64 ns, ns_timeout;
 
 	spin_lock_irqsave(&pdev->sh_info_lock, irq_flags);
@@ -153,10 +153,9 @@ static int do_pci_op(struct pcifront_device *pdev, struct xen_pci_op *op)
 	}
 
 	/*
-	* We might lose backend service request since we
-	* reuse same evtchn with pci_conf backend response. So re-schedule
-	* aer pcifront service.
-	*/
+	 * We might lose backend service request since we reuse same evtchn with
+	 * pci_conf backend response. So re-schedule aer pcifront service.
+	 */
 	if (test_bit(_XEN_PCIB_active,
 			(unsigned long *)&pdev->sh_info->flags)) {
 		dev_err(&pdev->xdev->dev,
@@ -493,7 +492,8 @@ static int pcifront_scan_root(struct pcifront_device *pdev,
 	list_add(&bus_entry->list, &pdev->root_buses);
 
 	/* pci_scan_root_bus skips devices which do not have a
-	* devfn==0. The pcifront_scan_bus enumerates all devfn. */
+	 * devfn==0. The pcifront_scan_bus enumerates all devfn.
+	 */
 	err = pcifront_scan_bus(pdev, domain, bus, b);
 
 	/* Claim resources before going "live" with our devices */
@@ -651,8 +651,9 @@ static void pcifront_do_aer(struct work_struct *data)
 	pci_channel_state_t state =
 		(pci_channel_state_t)pdev->sh_info->aer_op.err;
 
-	/*If a pci_conf op is in progress,
-		we have to wait until it is done before service aer op*/
+	/* If a pci_conf op is in progress,
+	 * we have to wait until it is done before service aer op.
+	 */
 	dev_dbg(&pdev->xdev->dev,
 		"pcifront service aer bus %x devfn %x\n",
 		pdev->sh_info->aer_op.bus, pdev->sh_info->aer_op.devfn);
@@ -676,6 +677,7 @@ static void pcifront_do_aer(struct work_struct *data)
 static irqreturn_t pcifront_handler_aer(int irq, void *dev)
 {
 	struct pcifront_device *pdev = dev;
+
 	schedule_pcifront_aer_op(pdev);
 	return IRQ_HANDLED;
 }
@@ -1027,6 +1029,7 @@ static int pcifront_detach_devices(struct pcifront_device *pdev)
 	/* Find devices being detached and remove them. */
 	for (i = 0; i < num_devs; i++) {
 		int l, state;
+
 		l = snprintf(str, sizeof(str), "state-%d", i);
 		if (unlikely(l >= (sizeof(str) - 1))) {
 			err = -ENOMEM;
@@ -1137,6 +1140,7 @@ static int pcifront_xenbus_probe(struct xenbus_device *xdev,
 static int pcifront_xenbus_remove(struct xenbus_device *xdev)
 {
 	struct pcifront_device *pdev = dev_get_drvdata(&xdev->dev);
+
 	if (pdev)
 		free_pdev(pdev);
 
-- 
2.32.0

