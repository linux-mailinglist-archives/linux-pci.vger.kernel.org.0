Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6910B558F90
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 06:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiFXEUO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 00:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiFXEUM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 00:20:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D41841339;
        Thu, 23 Jun 2022 21:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656044411; x=1687580411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E/VCq1+NrudHLCuO/gBPcz0LttvmxZzeLm4RT/jWrkY=;
  b=SqtlDKe1up0KFgISoY74rj/y61IaOxTV2trdCrrHu2WBFCWOKqMSWcxV
   bMNVCh+5FFcJ5rtDKplDZxa/5oGQ2exV8KZ52CmayFRy5sJhy1yK5kOx0
   QIQMiUIVhPChAc+vFC2RyJVpZSh8n9875GtBIinUqAgJTsFusvx2O22HE
   1t2FO97bUdh4GIxd61IL+q6RPFPFYjqHM1WHyqwff/CUC0hF0YHpIxnyV
   JJtltu9MeUJ5GePr3cgx0AtWrsk4vXjkDHXUX1Q01AXLSF9T0xiXkfOy7
   kpK9bwnzIxDfdjg5PnMhfZKJjSgmnuF+vqTf80d/dhRnGzY3IzgRn/Cr1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="367238002"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="367238002"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:20:10 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="645092910"
Received: from daharell-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.intel.com) ([10.209.66.176])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:20:10 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, linux-pci@vger.kernel.org,
        patches@lists.linux.dev, hch@lst.de,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 30/46] cxl/hdm: Add sysfs attributes for interleave ways + granularity
Date:   Thu, 23 Jun 2022 21:19:34 -0700
Message-Id: <20220624041950.559155-5-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
multiple requesting regions userpace will be resonsible for conflict
resolution and it needs these attributes to make those decisions.

Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
[djbw: reword changelog, make read-only, add sysfs ABI documentaion]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 23 +++++++++++++++++++++++
 drivers/cxl/core/port.c                 | 23 +++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 85844f9bc00b..2a4e4163879f 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -215,3 +215,26 @@ Description:
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
+		device's (endpoint or switch) switch ancestry.
+
+
+What:		/sys/bus/cxl/devices/decoderX.Y/interleave_granularity
+Date:		May, 2022
+KernelVersion:	v5.20
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The number of consecutive bytes of host physical address
+		space this decoder claims at address N before awaint the next
+		address (N + interleave_granularity * intereleave_ways).
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index c48f217e689a..08a380d20cf1 100644
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
 
-- 
2.36.1

