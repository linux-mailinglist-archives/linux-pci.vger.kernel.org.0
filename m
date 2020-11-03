Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4D42A50FB
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 21:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgKCUhD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 15:37:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:43072 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729585AbgKCUhC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 15:37:02 -0500
IronPort-SDR: 94Kk2mYrv18X6qDMOqRq2i2n5qi6U+pVocgGW8Je74GJrY/ooNaNOLX8kQijBJlj+xhgw9LW6Z
 GlVwKVooFYtw==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="168335730"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="168335730"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 12:37:01 -0800
IronPort-SDR: EHvYHLukS0D03UUpC/qD2N7PKwqkcpo49siycse5WSH9eerqoxyJ074+xbRnzMh3YCPEGRMeHJ
 Qj/ws4DxzFdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="320565288"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 Nov 2020 12:36:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1A46A89F; Tue,  3 Nov 2020 22:36:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5 6/7] PCI/ACPI: Replace open coded variant of resource_union()
Date:   Tue,  3 Nov 2020 22:36:54 +0200
Message-Id: <20201103203655.17701-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103203655.17701-1-andriy.shevchenko@linux.intel.com>
References: <20201103203655.17701-1-andriy.shevchenko@linux.intel.com>
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

