Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37FA243E8C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Aug 2020 19:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgHMR5d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Aug 2020 13:57:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:7942 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgHMR5d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Aug 2020 13:57:33 -0400
IronPort-SDR: Gn10vtem+ZBKbevB+5atryy2lLyXmMU//VMJRNMzPZ2drNYKy4GPmAnZc4/Uw+6uXLspsivCu6
 altjr5uca3xQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="133815478"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="133815478"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 10:57:33 -0700
IronPort-SDR: pPx9TCv2xPXd7OwMhhvVfxONdW5+WmygyhEDRtlXZWG0JysxxEE42r9zLf319XgPEq7ksoqXIQ
 Fmc76sc0NFwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="495474439"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 13 Aug 2020 10:57:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 606E4348; Thu, 13 Aug 2020 20:57:30 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v1 3/7] resource: Introduce resource_union() for overlapping resources
Date:   Thu, 13 Aug 2020 20:57:25 +0300
Message-Id: <20200813175729.15088-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com>
References: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some already present users may utilize resource_union() helper.
Provide it for them and for wider use in the future.

Deliberately avoid min()/max() macro as they are still parts of
kernel.h which is quite a burden to be included here in order
to avoid circular dependencies.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 include/linux/ioport.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 0193987b9968..c98df0ec7422 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -232,6 +232,16 @@ static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
        return (r1->start <= r2->end && r1->end >= r2->start);
 }
 
+static inline bool
+resource_union(struct resource *r1, struct resource *r2, struct resource *r)
+{
+	if (!resource_overlaps(r1, r2))
+		return false;
+	r->start = r2->start < r1->start ? r2->start : r1->start;
+	r->end = r2->end > r1->end ? r2->end : r1->end;
+	return true;
+}
+
 /* Convenience shorthand with allocation */
 #define request_region(start,n,name)		__request_region(&ioport_resource, (start), (n), (name), 0)
 #define request_muxed_region(start,n,name)	__request_region(&ioport_resource, (start), (n), (name), IORESOURCE_MUXED)
-- 
2.28.0

