Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A10A246CF4
	for <lists+linux-pci@lfdr.de>; Mon, 17 Aug 2020 18:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbgHQQhq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Aug 2020 12:37:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:2967 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388847AbgHQQhK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Aug 2020 12:37:10 -0400
IronPort-SDR: 6OlzOGFZnoAUst3CeAnpwVOal1v5Lqhsf+q/TQ0iKMHg97eoZ7xZ0GcVkqioozHxUjzl9+mwEh
 FJgnWuu4XZFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="172799206"
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="172799206"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 09:36:52 -0700
IronPort-SDR: ZSfQMmvkQMPsAOf5N3iev+gZGj4o7naOZRjW5QWMEF/1YIpOTmbdx1LIXiID4b7t3Gw4D1eCyt
 UrO7yJiY7V4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="334125505"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2020 09:36:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 01131456; Mon, 17 Aug 2020 19:36:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v2 7/8] PCI/ACPI: Fix description of @handle for acpi_is_root_bridge()
Date:   Mon, 17 Aug 2020 19:36:46 +0300
Message-Id: <20200817163647.48982-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817163647.48982-1-andriy.shevchenko@linux.intel.com>
References: <20200817163647.48982-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix description of handle parameter in documentation of acpi_is_root_bridge().
Otherwise we get the following warning:

  CHECK   drivers/acpi/pci_root.c
  drivers/acpi/pci_root.c:71: warning: Function parameter or member 'handle' not described in 'acpi_is_root_bridge'

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
v2: left in the series, but maintainers still may apply it separately
 drivers/acpi/pci_root.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 2a6a741896de..f723679954d7 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -62,7 +62,7 @@ static DEFINE_MUTEX(osc_lock);
 
 /**
  * acpi_is_root_bridge - determine whether an ACPI CA node is a PCI root bridge
- * @handle - the ACPI CA node in question.
+ * @handle: the ACPI CA node in question.
  *
  * Note: we could make this API take a struct acpi_device * instead, but
  * for now, it's more convenient to operate on an acpi_handle.
-- 
2.28.0

