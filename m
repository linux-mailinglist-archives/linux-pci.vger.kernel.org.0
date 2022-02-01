Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64EC4A57A7
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 08:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbiBAHUF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 02:20:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:44741 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234716AbiBAHUB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 02:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643700001; x=1675236001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XkBzUE7wRB8BvLDUWN8ktt6Q3qJQD+uH14xC0LXKPlc=;
  b=H5SaaaODto/EKFEThMGXl8U39sQiyMRRtskSUjtaF3D4p16h3oV0h16c
   eunejxiThZltjwtj+ovK6KHqV/vf481SCrB3hCvoKLInEyiFwED6cURAe
   TgEulaYuZZSY8hPwzWxQOxyzgy2DZVQQNhtNYLq66GFHCz351AU8Jms7H
   9WBMf/TmUnLfEMS+mlTSRRIB0W5+3XSWMvrrw6X6PMplwfpQFKX5i79qH
   d7sYqJK+5QfZXj7bR0AmZZ2BlZ9aLpYeVNyKpt/bexjHsCowfxAeAjWDC
   mvfdjux44cnfMhxBT70EMscxJP1yzBQa3X2yB8Hr6+Vchx+wTiLCQ+c8x
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="235028379"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="235028379"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 23:20:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="676000468"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 23:19:59 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V6 09/10] cxl/mem: Retry reading CDAT on failure
Date:   Mon, 31 Jan 2022 23:19:51 -0800
Message-Id: <20220201071952.900068-10-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220201071952.900068-1-ira.weiny@intel.com>
References: <20220201071952.900068-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The CDAT read may fail for a number of reasons but mainly it is possible
to get different parts of a valid state.  The checksum in the CDAT table
protects against this.

Now that the checksum is validated issue a retry if the CDAT read fails.
For now 2 retries are implemented.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
NOTE: Is 2 enough?  Should this just be delayed until the time when the
data is actually needed and not there?

Changes from V5:
	New patch -- easy to push off or drop.
---
 drivers/cxl/core/memdev.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index a01068e98333..11d721c56f08 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -356,7 +356,8 @@ static const struct file_operations cxl_memdev_fops = {
 	.llseek = noop_llseek,
 };
 
-static int read_cdat_data(struct cxl_memdev *cxlmd, struct cxl_dev_state *cxlds)
+static int __read_cdat_data(struct cxl_memdev *cxlmd,
+			    struct cxl_dev_state *cxlds)
 {
 	struct device *dev = &cxlmd->dev;
 	size_t cdat_length;
@@ -371,6 +372,20 @@ static int read_cdat_data(struct cxl_memdev *cxlmd, struct cxl_dev_state *cxlds)
 	return cxl_mem_cdat_read_table(cxlds, &cxlmd->cdat);
 }
 
+static int read_cdat_data(struct cxl_memdev *cxlmd,
+			  struct cxl_dev_state *cxlds)
+{
+	int retries = 2;
+	int rc;
+
+	while (--retries) {
+		rc = __read_cdat_data(cxlmd, cxlds);
+		if (!rc)
+			break;
+	}
+	return rc;
+}
+
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 {
 	struct cxl_memdev *cxlmd;
-- 
2.31.1

