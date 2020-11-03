Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997362A58C5
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 22:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbgKCUpQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 15:45:16 -0500
Received: from mga04.intel.com ([192.55.52.120]:64306 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729526AbgKCUpP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 15:45:15 -0500
IronPort-SDR: 3ethA9sKcBGJle9YGp+LHHSiAskLnDV5E/aluIsP6RQM+wwD1QmDS0wrd+gYvBGa4coh1Gyqsn
 JtKE6Xe50pJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="166533696"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="166533696"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 12:45:14 -0800
IronPort-SDR: b69rWVjsxgo2VNSr1Z4/iNcQEUKXMHJi2M/QmTfHYHlMC9GbUCMP8Wpphta2KErWfyN4Btvy/A
 n8CVD7dnzPBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="527317823"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 03 Nov 2020 12:45:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DB75D1C5; Tue,  3 Nov 2020 22:45:10 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v6 3/7] resource: Introduce resource_union() for overlapping resources
Date:   Tue,  3 Nov 2020 22:45:06 +0200
Message-Id: <20201103204510.19154-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103204510.19154-1-andriy.shevchenko@linux.intel.com>
References: <20201103204510.19154-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some already present users may utilize resource_union() helper.
Provide it for them and for wider use in the future.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Tested-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 include/linux/ioport.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index df4581107536..40320eb5bc0e 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -10,9 +10,10 @@
 #define _LINUX_IOPORT_H
 
 #ifndef __ASSEMBLY__
+#include <linux/bits.h>
 #include <linux/compiler.h>
+#include <linux/minmax.h>
 #include <linux/types.h>
-#include <linux/bits.h>
 /*
  * Resources are tree-like, allowing
  * nesting etc..
@@ -235,6 +236,16 @@ static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
        return r1->start <= r2->end && r1->end >= r2->start;
 }
 
+static inline bool
+resource_union(struct resource *r1, struct resource *r2, struct resource *r)
+{
+	if (!resource_overlaps(r1, r2))
+		return false;
+	r->start = min(r1->start, r2->start);
+	r->end = max(r1->end, r2->end);
+	return true;
+}
+
 /* Convenience shorthand with allocation */
 #define request_region(start,n,name)		__request_region(&ioport_resource, (start), (n), (name), 0)
 #define request_muxed_region(start,n,name)	__request_region(&ioport_resource, (start), (n), (name), IORESOURCE_MUXED)
-- 
2.28.0

