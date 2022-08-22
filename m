Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7507B59B717
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 02:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiHVAwo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Aug 2022 20:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiHVAwn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Aug 2022 20:52:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5DE201A8;
        Sun, 21 Aug 2022 17:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661129561; x=1692665561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KRMFK8euqKd0hKEpWRu0McaFqhVEfZNscDKSRuU3Zb4=;
  b=ildmUuhC21HNS58ecfiucA/1l71PRDR1RIWUwTAhGaDsOY9rlgFydw8w
   3M/EvSQjsPeE0aOs19D4I0bs6UHrj7SKgGnOutWCMG00hNf/T+FA3xqem
   HnuqkB625mqJ45PjCzScq7CccXNC0Ig32MvOcVcNCaYLt5pR/lEe+4e0x
   lwDtcvW3b4PSpzOl19E6U2XUQmOGfwd+4SvQldcgwXpVfLG7Yrjt/qVO8
   Fy+MdMM3lUzKW4ahKRUJpGhozXZeRwLEI2juDK6IuyMU54Rx9fKJrUvdz
   uZEppp1AD/FbKwDgbaO9YIKLdlev0g/MqcY8KDkC4KsA6xgWndP0Wkh0R
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="319325790"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="319325790"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 17:52:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="854306711"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.163.128])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 17:52:39 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 1/2] PCI: Allow drivers to request exclusive config regions
Date:   Sun, 21 Aug 2022 20:52:36 -0400
Message-Id: <20220822005237.540039-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220822005237.540039-1-ira.weiny@intel.com>
References: <20220822005237.540039-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

PCI config space access from user space has traditionally been
unrestricted with writes being an understood risk for device operation.

Unfortunately, device breakage or odd behavior from config writes lacks
indicators that can leave driver writers confused when evaluating
failures.  This is especially true with the new PCIe Data Object
Exchange (DOE) mailbox protocol where backdoor shenanigans from user
space through things such as vendor defined protocols may affect device
operation without complete breakage.

A prior proposal restricted read and writes completely.[1]  Greg and
Bjorn pointed out that proposal is flawed for a couple of reasons.
First, lspci should always be allowed and should not interfere with any
device operation.  Second, setpci is a valuable tool that is sometimes
necessary and it should not be completely restricted.[2]  Finally
methods exist for full lock of device access if required.

Even though access should not be restricted it would be nice for driver
writers to be able to flag critical parts of the config space such that
interference from user space can be detected.

Introduce pci_request_config_region_exclusive() to mark exclusive config
regions.  Such regions trigger a warning and kernel taint if accessed
via user space.

[1] https://lore.kernel.org/all/161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com/
[2] https://lore.kernel.org/all/YF8NGeGv9vYcMfTV@kroah.com/

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from[1]:
	Change name to pci_request_config_region_exclusive()
	Don't flag reads at all.
	Allow writes with a warn and taint of the kernel.
	Update commit message
	Forward port to latest tree.
---
 drivers/pci/pci-sysfs.c |  6 ++++++
 drivers/pci/probe.c     |  6 ++++++
 include/linux/ioport.h  |  2 ++
 include/linux/pci.h     | 16 ++++++++++++++++
 kernel/resource.c       | 13 ++++++++-----
 5 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index fc804e08e3cb..de41d761bdf5 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -755,6 +755,12 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
 	if (ret)
 		return ret;
 
+	if (resource_is_exclusive(&dev->config_resource, off,
+				  count)) {
+		pci_warn(dev, "Write to restricted range %llx detected", off);
+		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+	}
+
 	if (off > dev->cfg_size)
 		return 0;
 	if (off + count > dev->cfg_size) {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6280e780a48c..d81d7457058b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2303,6 +2303,12 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 	INIT_LIST_HEAD(&dev->bus_list);
 	dev->dev.type = &pci_dev_type;
 	dev->bus = pci_bus_get(bus);
+	dev->config_resource = (struct resource) {
+		.name = "PCI Config",
+		.start = 0,
+		.end = -1,
+	};
+
 #ifdef CONFIG_PCI_MSI
 	raw_spin_lock_init(&dev->msi_lock);
 #endif
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 616b683563a9..cf1de55d14da 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -312,6 +312,8 @@ extern void __devm_release_region(struct device *dev, struct resource *parent,
 				  resource_size_t start, resource_size_t n);
 extern int iomem_map_sanity_check(resource_size_t addr, unsigned long size);
 extern bool iomem_is_exclusive(u64 addr);
+extern bool resource_is_exclusive(struct resource *resource, u64 addr,
+				  resource_size_t size);
 
 extern int
 walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 81a57b498f22..dde37bfa0ca5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -409,6 +409,7 @@ struct pci_dev {
 	 */
 	unsigned int	irq;
 	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
+	struct resource config_resource;		 /* driver exclusive config ranges */
 
 	bool		match_driver;		/* Skip attaching driver */
 
@@ -1406,6 +1407,21 @@ int pci_request_selected_regions(struct pci_dev *, int, const char *);
 int pci_request_selected_regions_exclusive(struct pci_dev *, int, const char *);
 void pci_release_selected_regions(struct pci_dev *, int);
 
+static inline __must_check struct resource *
+pci_request_config_region_exclusive(struct pci_dev *pdev, unsigned int offset,
+				    unsigned int len, const char *name)
+{
+	return __request_region(&pdev->config_resource, offset, len, name,
+				IORESOURCE_EXCLUSIVE);
+}
+
+static inline void pci_release_config_region(struct pci_dev *pdev,
+					     unsigned int offset,
+					     unsigned int len)
+{
+	__release_region(&pdev->config_resource, offset, len);
+}
+
 /* drivers/pci/bus.c */
 void pci_add_resource(struct list_head *resources, struct resource *res);
 void pci_add_resource_offset(struct list_head *resources, struct resource *res,
diff --git a/kernel/resource.c b/kernel/resource.c
index 4c5e80b92f2f..82ed54cd1f0d 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1707,18 +1707,15 @@ static int strict_iomem_checks;
  *
  * Returns true if exclusive to the kernel, otherwise returns false.
  */
-bool iomem_is_exclusive(u64 addr)
+bool resource_is_exclusive(struct resource *root, u64 addr, resource_size_t size)
 {
 	const unsigned int exclusive_system_ram = IORESOURCE_SYSTEM_RAM |
 						  IORESOURCE_EXCLUSIVE;
 	bool skip_children = false, err = false;
-	int size = PAGE_SIZE;
 	struct resource *p;
 
-	addr = addr & PAGE_MASK;
-
 	read_lock(&resource_lock);
-	for_each_resource(&iomem_resource, p, skip_children) {
+	for_each_resource(root, p, skip_children) {
 		if (p->start >= addr + size)
 			break;
 		if (p->end < addr) {
@@ -1757,6 +1754,12 @@ bool iomem_is_exclusive(u64 addr)
 	return err;
 }
 
+bool iomem_is_exclusive(u64 addr)
+{
+	return resource_is_exclusive(&iomem_resource, addr & PAGE_MASK,
+				     PAGE_SIZE);
+}
+
 struct resource_entry *resource_list_create_entry(struct resource *res,
 						  size_t extra_size)
 {
-- 
2.37.2

