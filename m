Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10167575856
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 02:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbiGOADC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 20:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbiGOADC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 20:03:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375A972EEE;
        Thu, 14 Jul 2022 17:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657843381; x=1689379381;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MHmWXe/fj8s99H1gM2mKlKkxWW6tK1PQHi8PV+spXQI=;
  b=GzAtZ1C5f7n5LBy6Ntn36MUXExasR5dvGY2lbH5d6+CDdmp6YV+9Ri+e
   dgrEkKbY73s4ku2SG6KlH755DYWQi+IXVwXKVZYgNCMjkHLFVI/AvXrwv
   VUNNurzV5GQE7NhZNdf0L+vYLsJ291vroUC1UBc28w6h0Ly9sRq5dtttH
   Sp85mS7z16hFd9BQLtIyNXEaQBA1tD7YGr8VlO4mrkuFXHdF4+yUS4tNU
   A3NOPL/lvjvbRc9T8oIEopshVsSndB1vvNFPHhPupCoRe4mE4RUWorSeB
   NtKa1NLGVwD69N9xmW3gv2T3oe393jXemftgZT6T2aeHAq/WUA71NTsbP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="347339551"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="347339551"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:02:03 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="546461988"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:02:02 -0700
Subject: [PATCH v2 14/28] cxl/hdm: Add sysfs attributes for interleave ways
 + granularity
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <bwidawsk@kernel.org>, hch@lst.de,
        nvdimm@lists.linux.dev, linux-pci@vger.kernel.org
Date:   Thu, 14 Jul 2022 17:02:02 -0700
Message-ID: <165784332235.1758207.7185062713652694607.stgit@dwillia2-xfh.jf.intel.com>
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

From: Ben Widawsky <bwidawsk@kernel.org>

The region provisioning flow involves selecting interleave ways +
granularity settings for a region, and then programming the decoder
topology to meet those constraints, if possible. For example, root
decoders set the minimum interleave ways + granularity for any hosted
regions.

Given decoder programming is not atomic and collisions can occur between
multiple requesting regions userspace will be responsible for conflict
resolution and it needs these attributes to make those decisions.

Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
[djbw: reword changelog, make read-only, add sysfs ABI documentaion]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |   27 +++++++++++++++++++++++++++
 drivers/cxl/core/port.c                 |   23 +++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 9b6cc7cdc73b..0362ae98218e 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -230,3 +230,30 @@ Description:
 		allocations are enforced to occur in increasing 'decoderX.Y/id'
 		order and frees are enforced to occur in decreasing
 		'decoderX.Y/id' order.
+
+
+What:		/sys/bus/cxl/devices/decoderX.Y/interleave_ways
+Date:		May, 2022
+KernelVersion:	v5.20
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The number of targets across which this decoder's host
+		physical address (HPA) memory range is interleaved. The device
+		maps every Nth block of HPA (of size ==
+		'interleave_granularity') to consecutive DPA addresses. The
+		decoder's position in the interleave is determined by the
+		device's (endpoint or switch) switch ancestry. For root
+		decoders their interleave is specified by platform firmware and
+		they only specify a downstream target order for host bridges.
+
+
+What:		/sys/bus/cxl/devices/decoderX.Y/interleave_granularity
+Date:		May, 2022
+KernelVersion:	v5.20
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The number of consecutive bytes of host physical address
+		space this decoder claims at address N before the decode rotates
+		to the next target in the interleave at address N +
+		interleave_granularity (assuming N is aligned to
+		interleave_granularity).
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b2c44e7ef6a8..a43735f349d6 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -260,10 +260,33 @@ static ssize_t dpa_size_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(dpa_size);
 
+static ssize_t interleave_granularity_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+
+	return sysfs_emit(buf, "%d\n", cxld->interleave_granularity);
+}
+
+static DEVICE_ATTR_RO(interleave_granularity);
+
+static ssize_t interleave_ways_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+
+	return sysfs_emit(buf, "%d\n", cxld->interleave_ways);
+}
+
+static DEVICE_ATTR_RO(interleave_ways);
+
 static struct attribute *cxl_decoder_base_attrs[] = {
 	&dev_attr_start.attr,
 	&dev_attr_size.attr,
 	&dev_attr_locked.attr,
+	&dev_attr_interleave_granularity.attr,
+	&dev_attr_interleave_ways.attr,
 	NULL,
 };
 

