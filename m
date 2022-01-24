Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C254976B5
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbiAXAbx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:31:53 -0500
Received: from mga07.intel.com ([134.134.136.100]:5351 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231417AbiAXAbx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984312; x=1674520312;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UOt1RmkH36sMFykRBR92PUgZMphO1zeepPOf4BuhQR4=;
  b=lw5Z9hV/DR753uobBjxFesoZl+xCaVF6ppgETRJ4tjtCQftbKtDXeBeo
   LrUVgxgxd9nHDc0MabramxDW4YffXVvwJ5lFCLbPzP1L783tiCFKVfFWZ
   sBQBEYrzrI/ILiuagA9m9oI45j6gJ/g9o1/WvIsRL99+M5ZntIReleup3
   ItXfELNA5juOQGYvQHu5qlH/YiulUU1CTndVzIzluVnE6VngwKUkETmDG
   mdee7Tht1xdzCbdIZXarRvqqGRu8nh4ZUDNchlrxmywLDNzCaHg0/V/6C
   uBUJap3+w7GvTVEwMk5cTXxMfcnLF4207DPKv7ei8R83foYZqcTVRr7nO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="309256081"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="309256081"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:31:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="478862961"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:31:51 -0800
Subject: [PATCH v3 36/40] tools/testing/cxl: Mock dvsec_ranges()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:31:51 -0800
Message-ID: <164298431119.3018233.17175518196764977542.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For test purposes, pretend that that CXL DVSEC ranges are not in active
use and the device is ready CXL.mem operation.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/cxl/test/mem.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 36ef337c775c..b6b726eff3e2 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -248,6 +248,14 @@ static void label_area_release(void *lsa)
 	vfree(lsa);
 }
 
+static void mock_validate_dvsec_ranges(struct cxl_dev_state *cxlds)
+{
+	struct cxl_endpoint_dvsec_info *info;
+
+	info = &cxlds->info;
+	info->mem_enabled = true;
+}
+
 static int cxl_mock_mem_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -285,6 +293,8 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	mock_validate_dvsec_ranges(cxlds);
+
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);

