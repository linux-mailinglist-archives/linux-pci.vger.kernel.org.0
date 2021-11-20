Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D066A4579E7
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 01:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbhKTAGP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 19:06:15 -0500
Received: from mga12.intel.com ([192.55.52.136]:5726 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231585AbhKTAGK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 19:06:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="214542408"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="214542408"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:58 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="496088377"
Received: from jfaistl-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.139.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:58 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 12/23] cxl: Introduce endpoint decoders
Date:   Fri, 19 Nov 2021 16:02:39 -0800
Message-Id: <20211120000250.1663391-13-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211120000250.1663391-1-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Endpoints have decoders too. It is useful to share the same
infrastructure from cxl_core. Endpoints do not have dports (downstream
targets), only the underlying physical medium. As a result, some special
casing is needed.

There is no functional change introduced yet as endpoints don't actually
enumerate decoders yet.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core/bus.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 1ee12a60f3f4..16b15f54fb62 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -187,6 +187,12 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
 	NULL,
 };
 
+static const struct attribute_group *cxl_decoder_endpoint_attribute_groups[] = {
+	&cxl_decoder_base_attribute_group,
+	&cxl_base_attribute_group,
+	NULL,
+};
+
 static void cxl_decoder_release(struct device *dev)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
@@ -196,6 +202,12 @@ static void cxl_decoder_release(struct device *dev)
 	kfree(cxld);
 }
 
+static const struct device_type cxl_decoder_endpoint_type = {
+	.name = "cxl_decoder_endpoint",
+	.release = cxl_decoder_release,
+	.groups = cxl_decoder_endpoint_attribute_groups,
+};
+
 static const struct device_type cxl_decoder_switch_type = {
 	.name = "cxl_decoder_switch",
 	.release = cxl_decoder_release,
@@ -208,6 +220,11 @@ static const struct device_type cxl_decoder_root_type = {
 	.groups = cxl_decoder_root_attribute_groups,
 };
 
+static bool is_endpoint_decoder(struct device *dev)
+{
+	return dev->type == &cxl_decoder_endpoint_type;
+}
+
 bool is_root_decoder(struct device *dev)
 {
 	return dev->type == &cxl_decoder_root_type;
@@ -499,7 +516,9 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
  * cxl_decoder_alloc - Allocate a new CXL decoder
  * @port: owning port of this decoder
  * @nr_targets: downstream targets accessible by this decoder. All upstream
- *		ports and root ports must have at least 1 target.
+ *		ports and root ports must have at least 1 target. Endpoint
+ *		devices will have 0 targets. Callers wishing to register an
+ *		endpoint device should specify 0.
  *
  * A port should contain one or more decoders. Each of those decoders enable
  * some address space for CXL.mem utilization. A decoder is expected to be
@@ -516,7 +535,7 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 	struct device *dev;
 	int rc = 0;
 
-	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets == 0)
+	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
 		return ERR_PTR(-EINVAL);
 
 	cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
@@ -535,8 +554,11 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 	dev->parent = &port->dev;
 	dev->bus = &cxl_bus_type;
 
+	/* Endpoints don't have a target list */
+	if (nr_targets == 0)
+		dev->type = &cxl_decoder_endpoint_type;
 	/* root ports do not have a cxl_port_type parent */
-	if (port->dev.parent->type == &cxl_port_type)
+	else if (port->dev.parent->type == &cxl_port_type)
 		dev->type = &cxl_decoder_switch_type;
 	else
 		dev->type = &cxl_decoder_root_type;
@@ -579,12 +601,15 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 	if (cxld->interleave_ways < 1)
 		return -EINVAL;
 
-	port = to_cxl_port(cxld->dev.parent);
-	rc = decoder_populate_targets(cxld, port, target_map);
-	if (rc)
-		return rc;
-
 	dev = &cxld->dev;
+
+	port = to_cxl_port(cxld->dev.parent);
+	if (!is_endpoint_decoder(dev)) {
+		rc = decoder_populate_targets(cxld, port, target_map);
+		if (rc)
+			return rc;
+	}
+
 	rc = dev_set_name(dev, "decoder%d.%d", port->id, cxld->id);
 	if (rc)
 		return rc;
-- 
2.34.0

