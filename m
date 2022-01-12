Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A87B48CF3C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 00:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbiALXsF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 18:48:05 -0500
Received: from mga04.intel.com ([192.55.52.120]:13986 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235590AbiALXsE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jan 2022 18:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642031284; x=1673567284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lydRZibB7lXUc9cAyuJ2WBnEQS8JedlHiEcNOeW5sRk=;
  b=WngAqWZaEvHcuWf7wj/yn/rSHPBKnVmgQ4KmEML00L9+c982SsEN3v5c
   qApRUEuEas2naUBV34nQ9L8Xe1yIFWhUhxjz6U3yq2NOQIr32HTpPZHnj
   HxcDy69aJ11dZHyqJbXwapcsTvAgUk4n7+foOAQ9xK8uJn1jmLTJX5D1e
   mwxNFZCeDQM4iVRJmvOaWfNZlBNaI2CNs7Ai8m4OxLTHoXS58nKM1ML5k
   czWkbaOViwuNVX4XqvQ97U02ojILne6UHwOMsdWkC9hJEOzicjW8seqWy
   jBtBzpxhyPpuZ0Lw+5xzORqYUfkCUflujAujT5ngafDDoX0Q6Pz2yRB6b
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="242695324"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="242695324"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:48:03 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="670324169"
Received: from jmaclean-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.252.136.131])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:48:02 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-pci@vger.kernel.org
Cc:     patches@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 01/15] cxl/core: Rename find_cxl_port
Date:   Wed, 12 Jan 2022 15:47:35 -0800
Message-Id: <20220112234749.1965960-2-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112234749.1965960-1-ben.widawsky@intel.com>
References: <20220112234749.1965960-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Needed for other things.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core/port.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 29b0722dc6eb..5a1ffadd5d0d 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -666,7 +666,7 @@ static int match_port_by_dport(struct device *dev, const void *data)
 	return cxl_find_dport_by_dev(port, data) != NULL;
 }
 
-static struct cxl_port *find_cxl_port(struct device *dport_dev)
+static struct cxl_port *dport_find_cxl_port(struct device *dport_dev)
 {
 	struct device *port_dev;
 
@@ -699,7 +699,7 @@ struct cxl_port *find_cxl_root(struct cxl_memdev *cxlmd)
 		if (!dport_dev)
 			break;
 
-		port = find_cxl_port(dport_dev);
+		port = dport_find_cxl_port(dport_dev);
 		if (!port)
 			continue;
 
@@ -728,7 +728,7 @@ static void cxl_remove_ep(void *data)
 		if (!dport_dev)
 			break;
 
-		port = find_cxl_port(dport_dev);
+		port = dport_find_cxl_port(dport_dev);
 		if (!port || is_cxl_root(port))
 			continue;
 
@@ -787,7 +787,7 @@ static int add_port_register_ep(struct cxl_memdev *cxlmd,
 	resource_size_t component_reg_phys;
 	int rc;
 
-	parent_port = find_cxl_port(grandparent(dport_dev));
+	parent_port = dport_find_cxl_port(grandparent(dport_dev));
 	if (!parent_port) {
 		/*
 		 * The root CXL port is added by the CXL platform driver, fail
@@ -811,7 +811,7 @@ static int add_port_register_ep(struct cxl_memdev *cxlmd,
 		goto out;
 	}
 
-	port = find_cxl_port(dport_dev);
+	port = dport_find_cxl_port(dport_dev);
 	if (!port) {
 		component_reg_phys = find_component_registers(uport_dev);
 		port = devm_cxl_add_port(&parent_port->dev, uport_dev,
@@ -876,7 +876,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 			break;
 		}
 
-		port = find_cxl_port(dport_dev);
+		port = dport_find_cxl_port(dport_dev);
 		if (port) {
 			dev_dbg(&cxlmd->dev,
 				"found already registered port %s:%s\n",
@@ -922,7 +922,7 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, CXL);
 
 struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd)
 {
-	return find_cxl_port(grandparent(&cxlmd->dev));
+	return dport_find_cxl_port(grandparent(&cxlmd->dev));
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, CXL);
 
-- 
2.34.1

