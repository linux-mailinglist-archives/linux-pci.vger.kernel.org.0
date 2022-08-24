Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9BE5A0493
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 01:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiHXXY5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Aug 2022 19:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiHXXY4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2022 19:24:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A7BF37;
        Wed, 24 Aug 2022 16:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661383494; x=1692919494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zv9bGHhnrZNLlbDbs0IRI1KIR0axaO1zAKAyf/Xn1yI=;
  b=QNZbOk0Xw2fPDz8qOPKdvqAwGakvIX+MVpWNW0vrHuSdCPWiwKHtZk+n
   OGhLA0Syps5MewthfqybGHjghAVRuPattHep1gepu/Gn+h+N5B1jQdu/1
   kTuu5YbGJmwtSX736eztrbDaAHNxH7Iqmcxw0g/BlnwRAhShAfP25H6Dt
   2mCufx8DhjGfD9BigxgNiQMraaXzhjsELiMJyyts82gcmy/jVjRCASCuX
   MA6qDk6FEKZMyQPko5h7Yzs5hpNY0qZ2yP1AfsZR75H5O634gBckalNMu
   HQFMWRRZYlVZPyHB9+Jqzspw/gmexnay575mDEKDAc4RCY2/810sPAKQK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="274488913"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="274488913"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 16:24:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="560795019"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.42.187])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 16:24:53 -0700
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
Subject: [PATCH V2 1/2] PCI: Allow drivers to request exclusive config regions
Date:   Wed, 24 Aug 2022 16:24:49 -0700
Message-Id: <20220824232450.723179-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220824232450.723179-1-ira.weiny@intel.com>
References: <20220824232450.723179-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Create pci_warn_once() to restrict the user from spamming the log.

[1] https://lore.kernel.org/all/161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com/
[2] https://lore.kernel.org/all/YF8NGeGv9vYcMfTV@kroah.com/

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V1:
	Greg and Dan:
		Create and use pci_warn_once() to keep the user from spamming
	Dan:
		Clarify the warn message

Changes from[1]:
	Change name to pci_request_config_region_exclusive()
	Don't flag reads at all.
	Allow writes with a warn and taint of the kernel.
	Update commit message
	Forward port to latest tree.
---
 drivers/pci/pci-sysfs.c |  7 +++++++
 drivers/pci/probe.c     |  6 ++++++
 include/linux/ioport.h  |  2 ++
 include/linux/pci.h     | 33 +++++++++++++++++++++++++--------
 kernel/resource.c       | 13 ++++++++-----
 5 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index fc804e08e3cb..4145981c1a4e 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -755,6 +755,13 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
 	if (ret)
 		return ret;
 
+	if (resource_is_exclusive(&dev->config_resource, off,
+				  count)) {
+		pci_warn_once(dev, "%s: Unexpected write to kernel-exclusive config offset %llx",
+			      current->comm, off);
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
index 81a57b498f22..80dfb2a7e9f0 100644
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
@@ -2486,14 +2502,15 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #define pci_printk(level, pdev, fmt, arg...) \
 	dev_printk(level, &(pdev)->dev, fmt, ##arg)
 
-#define pci_emerg(pdev, fmt, arg...)	dev_emerg(&(pdev)->dev, fmt, ##arg)
-#define pci_alert(pdev, fmt, arg...)	dev_alert(&(pdev)->dev, fmt, ##arg)
-#define pci_crit(pdev, fmt, arg...)	dev_crit(&(pdev)->dev, fmt, ##arg)
-#define pci_err(pdev, fmt, arg...)	dev_err(&(pdev)->dev, fmt, ##arg)
-#define pci_warn(pdev, fmt, arg...)	dev_warn(&(pdev)->dev, fmt, ##arg)
-#define pci_notice(pdev, fmt, arg...)	dev_notice(&(pdev)->dev, fmt, ##arg)
-#define pci_info(pdev, fmt, arg...)	dev_info(&(pdev)->dev, fmt, ##arg)
-#define pci_dbg(pdev, fmt, arg...)	dev_dbg(&(pdev)->dev, fmt, ##arg)
+#define pci_emerg(pdev, fmt, arg...)	 dev_emerg(&(pdev)->dev, fmt, ##arg)
+#define pci_alert(pdev, fmt, arg...)	 dev_alert(&(pdev)->dev, fmt, ##arg)
+#define pci_crit(pdev, fmt, arg...)	 dev_crit(&(pdev)->dev, fmt, ##arg)
+#define pci_err(pdev, fmt, arg...)	 dev_err(&(pdev)->dev, fmt, ##arg)
+#define pci_warn(pdev, fmt, arg...)	 dev_warn(&(pdev)->dev, fmt, ##arg)
+#define pci_warn_once(pdev, fmt, arg...) dev_warn_once(&(pdev)->dev, fmt, ##arg)
+#define pci_notice(pdev, fmt, arg...)	 dev_notice(&(pdev)->dev, fmt, ##arg)
+#define pci_info(pdev, fmt, arg...)	 dev_info(&(pdev)->dev, fmt, ##arg)
+#define pci_dbg(pdev, fmt, arg...)	 dev_dbg(&(pdev)->dev, fmt, ##arg)
 
 #define pci_notice_ratelimited(pdev, fmt, arg...) \
 	dev_notice_ratelimited(&(pdev)->dev, fmt, ##arg)
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

