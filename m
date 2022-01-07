Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9929D486EF1
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 01:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344016AbiAGAiK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 19:38:10 -0500
Received: from mga18.intel.com ([134.134.136.126]:59426 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343915AbiAGAiK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Jan 2022 19:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641515890; x=1673051890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lydRZibB7lXUc9cAyuJ2WBnEQS8JedlHiEcNOeW5sRk=;
  b=aFCDUUKSTdNrXnBZlsQTJtrG4pnt33ROxCLidNr+sYM134XKeuDBnWeI
   +7G4GHyMNfIN4MPXnxVN+bpUmz7nkKeuIphHJz8H1THp0xFeCCYBT8DQZ
   x2s88lurAufqNsixsRevmOK0KG+hFAPK/TKkBI/glb7ks9BU+XeO9Ob4M
   PdJLUU8UmN9cD5Q/Y5sl4NeCjgE/HLi5KQajs+vig057z94+SxRuCBGEF
   jcCRWWf0Y6vkdQ1GbmEgyx/zHEtNEY03vFPetnwIGH4NS3pB8uUxrgGkO
   2P0I/B3Z892qBwHUdWlLXdTA83M/6cxCNHEVwphU5J/cOLkOCV4EChIvP
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229582014"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="229582014"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:38:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="471123177"
Received: from elenawei-mobl2.amr.corp.intel.com (HELO localhost.localdomain) ([10.252.138.104])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:38:09 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org
Cc:     patches@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 01/13] cxl/core: Rename find_cxl_port
Date:   Thu,  6 Jan 2022 16:37:44 -0800
Message-Id: <20220107003756.806582-2-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107003756.806582-1-ben.widawsky@intel.com>
References: <20220107003756.806582-1-ben.widawsky@intel.com>
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

