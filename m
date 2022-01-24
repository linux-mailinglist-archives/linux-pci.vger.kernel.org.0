Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F14F49767E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbiAXA3T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:29:19 -0500
Received: from mga03.intel.com ([134.134.136.65]:62231 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240580AbiAXA3R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:29:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984157; x=1674520157;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PA+2QGHcneX1jiHMUqn/gOLHGsYgjTxnRt6rTKiCzzo=;
  b=GRFefcxud9ywM7yY2YYwsw7Iii+zsbCrLg4CpXccuaLfd/42pI5o0GdL
   3Y+xAmqbOCPSyUWUR6MTQ800P4JbkT827osKiWZKCshx9dOivkCxK5Ksa
   fyG9VjTD6JKoY8AgXXsNXblLBCC7/nDQd/5uhpC7gwfP347EFhLdJM4W/
   gsXy4uDqD2aUljNCOIBirAtDpYeBXzH7wzEUFkH6yLPa9NMLxBNv4i4sw
   JLO13iXcgr3lNs/Ql6QKmYN1RD40MBZiY1brhUC7AdjkNSp5tu4yXEihJ
   E7fnqqdQlSUDumedzDh4wcq3qNcLep/Kzlc/LKhxnZo1tTMUCcCpG9Ezo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245879144"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245879144"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:29:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="617061517"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:29:16 -0800
Subject: [PATCH v3 07/40] cxl: Introduce module_cxl_driver
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:29:15 -0800
Message-ID: <164298415591.3018233.13608495220547681412.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

Many CXL drivers simply want to register and unregister themselves.
module_driver already supported this. A simple wrapper around that
reduces a decent amount of boilerplate in upcoming patches.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxl.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6288a6c1fc5c..38779409a419 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -308,6 +308,9 @@ int __cxl_driver_register(struct cxl_driver *cxl_drv, struct module *owner,
 #define cxl_driver_register(x) __cxl_driver_register(x, THIS_MODULE, KBUILD_MODNAME)
 void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 
+#define module_cxl_driver(__cxl_driver) \
+	module_driver(__cxl_driver, cxl_driver_register, cxl_driver_unregister)
+
 #define CXL_DEVICE_NVDIMM_BRIDGE	1
 #define CXL_DEVICE_NVDIMM		2
 

