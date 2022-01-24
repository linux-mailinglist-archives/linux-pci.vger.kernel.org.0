Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD23497682
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240580AbiAXA3a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:29:30 -0500
Received: from mga09.intel.com ([134.134.136.24]:10290 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240573AbiAXA31 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984167; x=1674520167;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hlxljobEWfnUs4WLOJfsFeacPUUg9sjXKYFx885zO5k=;
  b=Q3VvlJ1N7p5li+j/pPf/irYE3K2jRjqjOV5lzwSbYLh/h4djQk1WW+B2
   zDV95PyB5WHEeTQvBNc/zpg88Zk5kOTiItNJhM7ERi3AW6H/WCBaDkwBU
   6OntrjYML6qj/rPiunJbSZIth19n48+iBlIYHqB01aCQgVc5MhgR17R74
   kfaz1soKz4DcQazuzSJceiVTfxGuLn3EoK0xi9Tw/6688rnLBv6IitfG+
   VYRYc3Cbekc1uu/Iwv8RWRL/9SQNi0kut1foPF2GRUEFs+t1K6yoZFQxs
   Wgr4eHPBsaBskNmews0BuysKDWRzqODpSq0BxDk5eofZEsi7DYJ3YkIIa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245715214"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245715214"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:29:27 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="623902590"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:29:26 -0800
Subject: [PATCH v3 09/40] cxl/decoder: Hide physical address information
 from non-root
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:29:26 -0800
Message-ID: <164298416650.3018233.450720006145238709.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Just like /proc/iomem, CXL physical address information is reserved for
root only.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 3f9b98ecd18b..c5e74c6f04e8 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -49,7 +49,7 @@ static ssize_t start_show(struct device *dev, struct device_attribute *attr,
 
 	return sysfs_emit(buf, "%#llx\n", cxld->range.start);
 }
-static DEVICE_ATTR_RO(start);
+static DEVICE_ATTR_ADMIN_RO(start);
 
 static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 			char *buf)

