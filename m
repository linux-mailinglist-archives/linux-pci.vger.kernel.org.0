Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6691B4579F0
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 01:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbhKTAGV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 19:06:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:5726 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236328AbhKTAGN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 19:06:13 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="214542422"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="214542422"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:03:01 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="496088419"
Received: from jfaistl-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.139.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:03:01 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 23/23] cxl/mem: Disable switch hierarchies for now
Date:   Fri, 19 Nov 2021 16:02:50 -0800
Message-Id: <20211120000250.1663391-24-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211120000250.1663391-1-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Switches aren't supported by the region driver yet. If a device finds
itself under a switch it will not bind a driver so that it cannot be
used later for region creation/configuration.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index e954144af4b8..997898e78d63 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -155,6 +155,11 @@ static int cxl_mem_probe(struct device *dev)
 		goto out;
 	}
 
+	/* FIXME: Add true switch support */
+	dev_err(dev, "Devices behind switches are currently unsupported\n");
+	rc = -ENODEV;
+	goto err_out;
+
 	/* Walk down from the root port and add all switches */
 	cxl_scan_ports(ctx.root_port);
 
-- 
2.34.0

