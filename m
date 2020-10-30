Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1C92A0C60
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 18:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgJ3R0J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Oct 2020 13:26:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:49683 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgJ3R0I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Oct 2020 13:26:08 -0400
IronPort-SDR: XQx3ZIvQeCEAf9UqSLXoAkCNERzdkjRmhtdgXuO/V3wYjON6pUxItuob7YDR6oFn16K4SOnmcA
 65oZAw8aBXuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="148495157"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="148495157"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 10:26:08 -0700
IronPort-SDR: /apKCsT+9wpagEK7jwAuqEGV/TBMTTXX+fbzyMLO5PvbKvq/XujP2y12yWTIxhg3GH1VJykpU4
 Z2jfmUCO383w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="356654239"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 30 Oct 2020 10:26:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9092E62E; Fri, 30 Oct 2020 19:26:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 5/6] PCI/ACPI: Replace open coded variant of resource_union()
Date:   Fri, 30 Oct 2020 19:25:55 +0200
Message-Id: <20201030172556.21686-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030172556.21686-1-andriy.shevchenko@linux.intel.com>
References: <20201030172556.21686-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since we have resource_union() helper, let's utilize it here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/pci_root.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index c12b5fb3e8fb..0bf072cef6cf 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -722,9 +722,7 @@ static void acpi_pci_root_validate_resources(struct device *dev,
 			 * our resources no longer match the ACPI _CRS, but
 			 * the kernel resource tree doesn't allow overlaps.
 			 */
-			if (resource_overlaps(res1, res2)) {
-				res2->start = min(res1->start, res2->start);
-				res2->end = max(res1->end, res2->end);
+			if (resource_union(res1, res2, res2)) {
 				dev_info(dev, "host bridge window expanded to %pR; %pR ignored\n",
 					 res2, res1);
 				free = true;
-- 
2.28.0

