Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAD3558F8B
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 06:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiFXEUN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 00:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiFXEUL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 00:20:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292A44FC6A;
        Thu, 23 Jun 2022 21:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656044411; x=1687580411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HUsFMVeTjVGLdCwrcUoS1fkV2YbMF30CWyhsa214UuI=;
  b=HK1nvKK5EMTeGzdb72I6kVcmrTaQJu1M+XKeU+VVAehqrW+u8MxDbmo5
   ytn2Y32wkgrSHww9tAV+G8xAHUf6oBzF2R3wURJvP/3N1Fo3vX+eUTglJ
   9gsYkTkdjSTMV38c4z8AP6m0CDvPWt27JAarHUMqQHA8h7bVqgK5fBaK4
   ObgQ77vDA6GvvM7QJBTUbDORLDeORWTreSh2vkjgctW/RXhpXWS8gwizv
   4c53uqY/+24olRoW2vzfE7PmP35q3yQpUfrlbAT6zH0zNYVsru360Hr+b
   BPZ9wPgyib5HcWDU29Sp6Z2KTme3moTUQzyVTaNhZDamaXcEPHc0xtML/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="367237998"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="367237998"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:20:10 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="645092906"
Received: from daharell-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.intel.com) ([10.209.66.176])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:20:10 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, linux-pci@vger.kernel.org,
        patches@lists.linux.dev, hch@lst.de,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 29/46] cxl/port: Cache CXL host bridge data
Date:   Thu, 23 Jun 2022 21:19:33 -0700
Message-Id: <20220624041950.559155-4-dan.j.williams@intel.com>
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

Region creation has need for checking host-bridge connectivity when
adding endpoints to regions. Record, at port creation time, the
host-bridge to provide a useful shortcut from any location in the
topology to the most-significant ancestor.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c | 16 +++++++++++++++-
 drivers/cxl/cxl.h       |  2 ++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index d2f6898940fa..c48f217e689a 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -546,6 +546,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 	if (rc < 0)
 		goto err;
 	port->id = rc;
+	port->uport = uport;
 
 	/*
 	 * The top-level cxl_port "cxl_root" does not have a cxl_port as
@@ -556,14 +557,27 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 	dev = &port->dev;
 	if (parent_dport) {
 		struct cxl_port *parent_port = parent_dport->port;
+		struct cxl_port *iter;
 
 		port->depth = parent_port->depth + 1;
 		port->parent_dport = parent_dport;
 		dev->parent = &parent_port->dev;
+		/*
+		 * walk to the host bridge, or the first ancestor that knows
+		 * the host bridge
+		 */
+		iter = port;
+		while (!iter->host_bridge &&
+		       !is_cxl_root(to_cxl_port(iter->dev.parent)))
+			iter = to_cxl_port(iter->dev.parent);
+		if (iter->host_bridge)
+			port->host_bridge = iter->host_bridge;
+		else
+			port->host_bridge = iter->uport;
+		dev_dbg(uport, "host-bridge: %s\n", dev_name(port->host_bridge));
 	} else
 		dev->parent = uport;
 
-	port->uport = uport;
 	port->component_reg_phys = component_reg_phys;
 	ida_init(&port->decoder_ida);
 	port->dpa_end = -1;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 8e2c1b393552..0211cf0d3574 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -331,6 +331,7 @@ struct cxl_nvdimm {
  * @component_reg_phys: component register capability base address (optional)
  * @dead: last ep has been removed, force port re-creation
  * @depth: How deep this port is relative to the root. depth 0 is the root.
+ * @host_bridge: Shortcut to the platform attach point for this port
  */
 struct cxl_port {
 	struct device dev;
@@ -344,6 +345,7 @@ struct cxl_port {
 	resource_size_t component_reg_phys;
 	bool dead;
 	unsigned int depth;
+	struct device *host_bridge;
 };
 
 static inline struct cxl_dport *cxl_dport_load(struct cxl_port *port,
-- 
2.36.1

