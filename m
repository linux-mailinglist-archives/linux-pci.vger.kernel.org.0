Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6F348CF41
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 00:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbiALXsI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 18:48:08 -0500
Received: from mga04.intel.com ([192.55.52.120]:13987 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235655AbiALXsG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jan 2022 18:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642031286; x=1673567286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zCiUUcytCexUYYZvqVtEwyDzVzKLZ5yWtPaDBTJE3k0=;
  b=FkfeeCdPugjPW0FMS+jX2+/fnEELfh+/sXpKRUxi8MpZF1atjNuSAkNE
   2WS952etK6g0ltpRlu9ONdGZciMNYZLNlri/njF6QZwSiAA5elOqPOMOi
   UkbRsCm40D6ZCUeurunh4MLTqz1AOvyXJlosJbN8nNfj9qqeuP//F3nC5
   e4xPNfzRjyfIVI38xGFG0sVp79NEYsJitgz1fCZDHJyb7vIYbjJn39+1y
   e6nfo0sW69XDI2ZfjMwdUsC4WnC432K2/KnFt9nLXCYDY8R+tk4orSUk6
   cYicnY0AyVSR9zzRslU0803jX/yrbmM3dWOCyPxIKF7lU0HTGlKz97GEk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="242695332"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="242695332"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:48:06 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="670324183"
Received: from jmaclean-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.252.136.131])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:48:05 -0800
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
Subject: [PATCH v2 05/15] cxl/mem: Cache port created by the mem dev
Date:   Wed, 12 Jan 2022 15:47:39 -0800
Message-Id: <20220112234749.1965960-6-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112234749.1965960-1-ben.widawsky@intel.com>
References: <20220112234749.1965960-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since region programming sees all components in the topology as a port,
it's required that endpoints are treated equally. The easiest way to go
from endpoint to port is to simply cache it at creation time.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/cxlmem.h |  2 ++
 drivers/cxl/mem.c    | 16 ++++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 4ea0686e5f84..38d6129499c8 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -36,12 +36,14 @@
  * @cxlds: The device state backing this device
  * @id: id number of this memdev instance.
  * @component_reg_phys: register base of component registers
+ * @port: The port created by this device
  */
 struct cxl_memdev {
 	struct device dev;
 	struct cdev cdev;
 	struct cxl_dev_state *cxlds;
 	int id;
+	struct cxl_port *port;
 };
 
 static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 9e6e98e5ea06..2ed7554155d2 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -45,8 +45,8 @@ static int wait_for_media(struct cxl_memdev *cxlmd)
 	return 0;
 }
 
-static int create_endpoint(struct cxl_memdev *cxlmd,
-			   struct cxl_port *parent_port)
+static struct cxl_port *create_endpoint(struct cxl_memdev *cxlmd,
+					struct cxl_port *parent_port)
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_port *endpoint;
@@ -54,10 +54,10 @@ static int create_endpoint(struct cxl_memdev *cxlmd,
 	endpoint = devm_cxl_add_port(&parent_port->dev, &cxlmd->dev,
 				     cxlds->component_reg_phys, parent_port);
 	if (IS_ERR(endpoint))
-		return PTR_ERR(endpoint);
+		return endpoint;
 
 	dev_dbg(&cxlmd->dev, "add: %s\n", dev_name(&endpoint->dev));
-	return 0;
+	return endpoint;
 }
 
 /**
@@ -123,7 +123,7 @@ static int cxl_mem_probe(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct cxl_port *parent_port;
+	struct cxl_port *parent_port, *ep_port;
 	int rc;
 
 	rc = wait_for_media(cxlmd);
@@ -182,7 +182,11 @@ static int cxl_mem_probe(struct device *dev)
 		goto out;
 	}
 
-	rc = create_endpoint(cxlmd, parent_port);
+	ep_port = create_endpoint(cxlmd, parent_port);
+	if (IS_ERR(ep_port))
+		rc = PTR_ERR(ep_port);
+	else
+		cxlmd->port = ep_port;
 out:
 	device_unlock(&parent_port->dev);
 	put_device(&parent_port->dev);
-- 
2.34.1

