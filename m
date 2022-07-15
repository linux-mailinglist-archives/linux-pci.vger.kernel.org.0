Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CA2575844
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 02:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241029AbiGOABb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 20:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241025AbiGOAB3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 20:01:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBD771BC8;
        Thu, 14 Jul 2022 17:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657843288; x=1689379288;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zbeC4suVaifJOdnAyRi2cfH0scr2EdvKoYXquZzpLB0=;
  b=UJxC5bFZXB39CqBt0TA+D3gLt7Mr63dgbiU6BjPAbIFlQLSnSGMXa+Xo
   GJJx9eqcDCGPNlk6SCPiM86N6YwN3gXdzkEvInXGTUyNyMpf2norVZfvB
   NXSv+j/BWAYGGs8HWxOSXmN/j3k4CNve8lJImpJxfoYVk4riLpRMlkyHI
   zFmDzzVZQeumJ79aVFUIKRqn9Y4KrOOAow7tZ5ZoLDb9y+i1ph5GRhIe4
   gzNhgAJUX86O5nJJXiSe0gRBJYfntAg5DOYmrvOLVDQFcJiNfgJ6IIaaV
   Y3GTjHGmWuLeLmrucBfrGBOkrqIB21YuOwo5N6TPKKp9TMT15g+7xl1uR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="286799573"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="286799573"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:01:23 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="571302165"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:01:23 -0700
Subject: [PATCH v2 07/28] cxl/hdm: Add 'mode' attribute to decoder objects
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>, hch@lst.de,
        nvdimm@lists.linux.dev, linux-pci@vger.kernel.org
Date:   Thu, 14 Jul 2022 17:01:22 -0700
Message-ID: <165784328277.1758207.16889065926766678946.stgit@dwillia2-xfh.jf.intel.com>
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

Recall that the Device Physical Address (DPA) space of a CXL Memory
Expander is potentially partitioned into a volatile and persistent
portion. A decoder maps a Host Physical Address (HPA) range to a DPA
range and that translation depends on the value of all previous (lower
instance number) decoders before the current one.

In preparation for allowing dynamic provisioning of regions, decoders
need an ABI to indicate which DPA partition a decoder targets. This ABI
needs to be prepared for the possibility that some other agent committed
and locked a decoder that spans the partition boundary.

Add 'decoderX.Y/mode' to endpoint decoders that indicates which
partition 'ram' / 'pmem' the decoder targets, or 'mixed' if the decoder
currently spans the partition boundary.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://lore.kernel.org/r/165603881967.551046.6007594190951596439.stgit@dwillia2-xfh
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |   16 ++++++++++++++++
 drivers/cxl/core/hdm.c                  |   10 ++++++++++
 drivers/cxl/core/port.c                 |   20 ++++++++++++++++++++
 drivers/cxl/cxl.h                       |    9 +++++++++
 4 files changed, 55 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 16d9ffa94bbd..b8ef8aedaf39 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -179,3 +179,19 @@ Description:
 		expander memory (type-3). The 'target_type' attribute indicates
 		the current setting which may dynamically change based on what
 		memory regions are activated in this decode hierarchy.
+
+
+What:		/sys/bus/cxl/devices/decoderX.Y/mode
+Date:		May, 2022
+KernelVersion:	v5.20
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
+		translates from a host physical address range, to a device local
+		address range. Device-local address ranges are further split
+		into a 'ram' (volatile memory) range and 'pmem' (persistent
+		memory) range. The 'mode' attribute emits one of 'ram', 'pmem',
+		'mixed', or 'none'. The 'mixed' indication is for error cases
+		when a decoder straddles the volatile/persistent partition
+		boundary, and 'none' indicates the decoder is not actively
+		decoding, or no DPA allocation policy has been set.
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d4c17325001b..acd46b0d69c6 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -224,6 +224,16 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	cxled->dpa_res = res;
 	cxled->skip = skipped;
 
+	if (resource_contains(&cxlds->pmem_res, res))
+		cxled->mode = CXL_DECODER_PMEM;
+	else if (resource_contains(&cxlds->ram_res, res))
+		cxled->mode = CXL_DECODER_RAM;
+	else {
+		dev_dbg(dev, "decoder%d.%d: %pr mixed\n", port->id,
+			cxled->cxld.id, cxled->dpa_res);
+		cxled->mode = CXL_DECODER_MIXED;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index ca4f23204e5c..0ac5dcd612e0 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -172,6 +172,25 @@ static ssize_t target_list_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(target_list);
 
+static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
+
+	switch (cxled->mode) {
+	case CXL_DECODER_RAM:
+		return sysfs_emit(buf, "ram\n");
+	case CXL_DECODER_PMEM:
+		return sysfs_emit(buf, "pmem\n");
+	case CXL_DECODER_NONE:
+		return sysfs_emit(buf, "none\n");
+	case CXL_DECODER_MIXED:
+	default:
+		return sysfs_emit(buf, "mixed\n");
+	}
+}
+static DEVICE_ATTR_RO(mode);
+
 static struct attribute *cxl_decoder_base_attrs[] = {
 	&dev_attr_start.attr,
 	&dev_attr_size.attr,
@@ -222,6 +241,7 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
 
 static struct attribute *cxl_decoder_endpoint_attrs[] = {
 	&dev_attr_target_type.attr,
+	&dev_attr_mode.attr,
 	NULL,
 };
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index d5e4cfac35ea..3e7363dde80f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -241,16 +241,25 @@ struct cxl_decoder {
 	unsigned long flags;
 };
 
+enum cxl_decoder_mode {
+	CXL_DECODER_NONE,
+	CXL_DECODER_RAM,
+	CXL_DECODER_PMEM,
+	CXL_DECODER_MIXED,
+};
+
 /**
  * struct cxl_endpoint_decoder - Endpoint  / SPA to DPA decoder
  * @cxld: base cxl_decoder_object
  * @dpa_res: actively claimed DPA span of this decoder
  * @skip: offset into @dpa_res where @cxld.hpa_range maps
+ * @mode: which memory type / access-mode-partition this decoder targets
  */
 struct cxl_endpoint_decoder {
 	struct cxl_decoder cxld;
 	struct resource *dpa_res;
 	resource_size_t skip;
+	enum cxl_decoder_mode mode;
 };
 
 /**

