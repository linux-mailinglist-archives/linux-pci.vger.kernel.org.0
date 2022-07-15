Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEFF575850
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 02:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241025AbiGOACV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 20:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241013AbiGOACU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 20:02:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E64872EDD;
        Thu, 14 Jul 2022 17:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657843338; x=1689379338;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JJqrcVjP4sirdUNzSuDkZbpLNqXGBwqEDLX3wI6q8lA=;
  b=MWY8byjKgDT6SyCpilW9JO6VcuUEN25IkqiDeUnuCoQhqg1YWBjrGoa7
   Sv2JRzyx2hc//2QDN4SH3mRvrrSag02uMQZA8xUKlhSIIMukUzruC3cDh
   UxMxm93MEs3d8xNmq/EDBQuTxb9FLX2BlyThhqWtJLM14AzY3FQqUOcqI
   3ikgl1eizEk2HubGuaQCxSc8zAYd2hgu4pRbSx+ZbzWI4XSn05PLaSGSp
   wmVuO4vm0wxgbTT741/UPh4XCvH5JVkofQXvGOg+AFjXY9QbiVAdIJCkZ
   AwUK5tv4CmQ9xB3OHq5CgfuyMMFldsFipbaEfeghw+cpjsIYI+oDG8VEr
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="347339249"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="347339249"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:01:34 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="628896664"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:01:34 -0700
Subject: [PATCH v2 09/28] cxl/hdm: Add support for allocating DPA to an
 endpoint decoder
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     hch@lst.de, nvdimm@lists.linux.dev, linux-pci@vger.kernel.org
Date:   Thu, 14 Jul 2022 17:01:34 -0700
Message-ID: <165784329399.1758207.16732038126938632700.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
References: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The region provisioning flow will roughly follow a sequence of:

1/ Allocate DPA to a set of decoders

2/ Allocate HPA to a region

3/ Associate decoders with a region and validate that the DPA allocations
   and topologies match the parameters of the region.

For now, this change (step 1) arranges for DPA capacity to be allocated
and deleted from non-committed decoders based on the decoder's mode /
partition selection. Capacity is allocated from the lowest DPA in the
partition and any 'pmem' allocation blocks out all remaining ram
capacity in its 'skip' setting. DPA allocations are enforced in decoder
instance order. I.e. decoder N + 1 always starts at a higher DPA than
instance N, and deleting allocations must proceed from the
highest-instance allocated decoder to the lowest.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |   37 ++++++
 drivers/cxl/core/core.h                 |    7 +
 drivers/cxl/core/hdm.c                  |  180 +++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c                 |   73 ++++++++++++-
 4 files changed, 295 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index b8ef8aedaf39..9b6cc7cdc73b 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -186,7 +186,7 @@ Date:		May, 2022
 KernelVersion:	v5.20
 Contact:	linux-cxl@vger.kernel.org
 Description:
-		(RO) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
+		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
 		translates from a host physical address range, to a device local
 		address range. Device-local address ranges are further split
 		into a 'ram' (volatile memory) range and 'pmem' (persistent
@@ -195,3 +195,38 @@ Description:
 		when a decoder straddles the volatile/persistent partition
 		boundary, and 'none' indicates the decoder is not actively
 		decoding, or no DPA allocation policy has been set.
+
+		'mode' can be written, when the decoder is in the 'disabled'
+		state, with either 'ram' or 'pmem' to set the boundaries for the
+		next allocation.
+
+
+What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
+Date:		May, 2022
+KernelVersion:	v5.20
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) When a CXL decoder is of devtype "cxl_decoder_endpoint",
+		and its 'dpa_size' attribute is non-zero, this attribute
+		indicates the device physical address (DPA) base address of the
+		allocation.
+
+
+What:		/sys/bus/cxl/devices/decoderX.Y/dpa_size
+Date:		May, 2022
+KernelVersion:	v5.20
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
+		translates from a host physical address range, to a device local
+		address range. The range, base address plus length in bytes, of
+		DPA allocated to this decoder is conveyed in these 2 attributes.
+		Allocations can be mutated as long as the decoder is in the
+		disabled state. A write to 'dpa_size' releases the previous DPA
+		allocation and then attempts to allocate from the free capacity
+		in the device partition referred to by 'decoderX.Y/mode'.
+		Allocate and free requests can only be performed on the highest
+		instance number disabled decoder with non-zero size. I.e.
+		allocations are enforced to occur in increasing 'decoderX.Y/id'
+		order and frees are enforced to occur in decreasing
+		'decoderX.Y/id' order.
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index a0808cdaffba..5551b82b2da0 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -18,6 +18,13 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 				   resource_size_t length);
 
 struct dentry *cxl_debugfs_create_dir(const char *dir);
+int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
+		     enum cxl_decoder_mode mode);
+int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size);
+int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
+resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
+resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled);
+
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 582f48141767..596b57fb60df 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -182,6 +182,19 @@ static void cxl_dpa_release(void *cxled)
 	up_write(&cxl_dpa_rwsem);
 }
 
+/*
+ * Must be called from context that will not race port device
+ * unregistration, like decoder sysfs attribute methods
+ */
+static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_port *port = cxled_to_port(cxled);
+
+	lockdep_assert_held_write(&cxl_dpa_rwsem);
+	devm_remove_action(&port->dev, cxl_dpa_release, cxled);
+	__cxl_dpa_release(cxled);
+}
+
 static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			     resource_size_t base, resource_size_t len,
 			     resource_size_t skipped)
@@ -269,6 +282,173 @@ static int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
+resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
+{
+	resource_size_t size = 0;
+
+	down_read(&cxl_dpa_rwsem);
+	if (cxled->dpa_res)
+		size = resource_size(cxled->dpa_res);
+	up_read(&cxl_dpa_rwsem);
+
+	return size;
+}
+
+resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
+{
+	resource_size_t base = -1;
+
+	down_read(&cxl_dpa_rwsem);
+	if (cxled->dpa_res)
+		base = cxled->dpa_res->start;
+	up_read(&cxl_dpa_rwsem);
+
+	return base;
+}
+
+int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_port *port = cxled_to_port(cxled);
+	struct device *dev = &cxled->cxld.dev;
+	int rc;
+
+	down_write(&cxl_dpa_rwsem);
+	if (!cxled->dpa_res) {
+		rc = 0;
+		goto out;
+	}
+	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
+		dev_dbg(dev, "decoder enabled\n");
+		rc = -EBUSY;
+		goto out;
+	}
+	if (cxled->cxld.id != port->hdm_end) {
+		dev_dbg(dev, "expected decoder%d.%d\n", port->id,
+			port->hdm_end);
+		rc = -EBUSY;
+		goto out;
+	}
+	devm_cxl_dpa_release(cxled);
+	rc = 0;
+out:
+	up_write(&cxl_dpa_rwsem);
+	return rc;
+}
+
+int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
+		     enum cxl_decoder_mode mode)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct device *dev = &cxled->cxld.dev;
+	int rc;
+
+	switch (mode) {
+	case CXL_DECODER_RAM:
+	case CXL_DECODER_PMEM:
+		break;
+	default:
+		dev_dbg(dev, "unsupported mode: %d\n", mode);
+		return -EINVAL;
+	}
+
+	down_write(&cxl_dpa_rwsem);
+	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
+		rc = -EBUSY;
+		goto out;
+	}
+
+	/*
+	 * Only allow modes that are supported by the current partition
+	 * configuration
+	 */
+	if (mode == CXL_DECODER_PMEM && !resource_size(&cxlds->pmem_res)) {
+		dev_dbg(dev, "no available pmem capacity\n");
+		rc = -ENXIO;
+		goto out;
+	}
+	if (mode == CXL_DECODER_RAM && !resource_size(&cxlds->ram_res)) {
+		dev_dbg(dev, "no available ram capacity\n");
+		rc = -ENXIO;
+		goto out;
+	}
+
+	cxled->mode = mode;
+	rc = 0;
+out:
+	up_write(&cxl_dpa_rwsem);
+
+	return rc;
+}
+
+int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	resource_size_t free_ram_start, free_pmem_start;
+	struct cxl_port *port = cxled_to_port(cxled);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct device *dev = &cxled->cxld.dev;
+	resource_size_t start, avail, skip;
+	struct resource *p, *last;
+	int rc;
+
+	down_write(&cxl_dpa_rwsem);
+	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
+		dev_dbg(dev, "decoder enabled\n");
+		rc = -EBUSY;
+		goto out;
+	}
+
+	for (p = cxlds->ram_res.child, last = NULL; p; p = p->sibling)
+		last = p;
+	if (last)
+		free_ram_start = last->end + 1;
+	else
+		free_ram_start = cxlds->ram_res.start;
+
+	for (p = cxlds->pmem_res.child, last = NULL; p; p = p->sibling)
+		last = p;
+	if (last)
+		free_pmem_start = last->end + 1;
+	else
+		free_pmem_start = cxlds->pmem_res.start;
+
+	if (cxled->mode == CXL_DECODER_RAM) {
+		start = free_ram_start;
+		avail = cxlds->ram_res.end - start + 1;
+		skip = 0;
+	} else if (cxled->mode == CXL_DECODER_PMEM) {
+		resource_size_t skip_start, skip_end;
+
+		start = free_pmem_start;
+		avail = cxlds->pmem_res.end - start + 1;
+		skip_start = free_ram_start;
+		skip_end = start - 1;
+		skip = skip_end - skip_start + 1;
+	} else {
+		dev_dbg(dev, "mode not set\n");
+		rc = -EINVAL;
+		goto out;
+	}
+
+	if (size > avail) {
+		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
+			cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
+			&avail);
+		rc = -ENOSPC;
+		goto out;
+	}
+
+	rc = __cxl_dpa_reserve(cxled, start, size, skip);
+out:
+	up_write(&cxl_dpa_rwsem);
+
+	if (rc)
+		return rc;
+
+	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
+}
+
 static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			    int *target_map, void __iomem *hdm, int which,
 			    u64 *dpa_base)
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 109611318760..fdc1be7db917 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -189,7 +189,76 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
 		return sysfs_emit(buf, "mixed\n");
 	}
 }
-static DEVICE_ATTR_RO(mode);
+
+static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
+	enum cxl_decoder_mode mode;
+	ssize_t rc;
+
+	if (sysfs_streq(buf, "pmem"))
+		mode = CXL_DECODER_PMEM;
+	else if (sysfs_streq(buf, "ram"))
+		mode = CXL_DECODER_RAM;
+	else
+		return -EINVAL;
+
+	rc = cxl_dpa_set_mode(cxled, mode);
+	if (rc)
+		return rc;
+
+	return len;
+}
+static DEVICE_ATTR_RW(mode);
+
+static ssize_t dpa_resource_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
+	u64 base = cxl_dpa_resource_start(cxled);
+
+	return sysfs_emit(buf, "%#llx\n", base);
+}
+static DEVICE_ATTR_RO(dpa_resource);
+
+static ssize_t dpa_size_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
+	resource_size_t size = cxl_dpa_size(cxled);
+
+	return sysfs_emit(buf, "%pa\n", &size);
+}
+
+static ssize_t dpa_size_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t len)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
+	unsigned long long size;
+	ssize_t rc;
+
+	rc = kstrtoull(buf, 0, &size);
+	if (rc)
+		return rc;
+
+	if (!IS_ALIGNED(size, SZ_256M))
+		return -EINVAL;
+
+	rc = cxl_dpa_free(cxled);
+	if (rc)
+		return rc;
+
+	if (size == 0)
+		return len;
+
+	rc = cxl_dpa_alloc(cxled, size);
+	if (rc)
+		return rc;
+
+	return len;
+}
+static DEVICE_ATTR_RW(dpa_size);
 
 static struct attribute *cxl_decoder_base_attrs[] = {
 	&dev_attr_start.attr,
@@ -242,6 +311,8 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
 static struct attribute *cxl_decoder_endpoint_attrs[] = {
 	&dev_attr_target_type.attr,
 	&dev_attr_mode.attr,
+	&dev_attr_dpa_size.attr,
+	&dev_attr_dpa_resource.attr,
 	NULL,
 };
 

