Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F39E243E92
	for <lists+linux-pci@lfdr.de>; Thu, 13 Aug 2020 19:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgHMR5g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Aug 2020 13:57:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:1402 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgHMR5g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Aug 2020 13:57:36 -0400
IronPort-SDR: qiK9AznEIyJbFTHmf2Wr7tauM96GUGkevC/20QaLtykLUr0MntlCgCC+YJiV5u4/Nw5W2/dwyt
 Mj0ItwOiuhrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="218626203"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="218626203"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 10:57:33 -0700
IronPort-SDR: zVhLbiZLkjhAVad+77Sb2uU6sXPPgozGcXziqIxeesSRpm+feFgpTH3fbiixC0Tiaell1MOLK8
 O+O5C9X4v2wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="295510386"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 13 Aug 2020 10:57:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 74D633D7; Thu, 13 Aug 2020 20:57:30 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v1 5/7] PCI/ACPI: Replace open coded variant of resource_union()
Date:   Thu, 13 Aug 2020 20:57:27 +0300
Message-Id: <20200813175729.15088-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com>
References: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since we have resource_union() helper, let's utilize it here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/acpi/pci_root.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index f90e841c59f5..2a6a741896de 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -724,9 +724,7 @@ static void acpi_pci_root_validate_resources(struct device *dev,
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

