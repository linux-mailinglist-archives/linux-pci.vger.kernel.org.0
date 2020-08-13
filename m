Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74635243E93
	for <lists+linux-pci@lfdr.de>; Thu, 13 Aug 2020 19:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgHMR5g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Aug 2020 13:57:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:7942 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgHMR5g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Aug 2020 13:57:36 -0400
IronPort-SDR: IKw9amXSVK1TY88beb681QuQYTAupXZNu22wAzbEiNHoGq9AHlkHX1eFK5C7swQ809JmwqfJ38
 NbvbUx6+qEUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="133815485"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="133815485"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 10:57:35 -0700
IronPort-SDR: ew+UmUcrayRNRf8ID5PJEfj+r4LN1cw6DfXmBL8ZLM/Hr5MkPXuPLJXSmjyWiJRrlL9Q8hJeMW
 gmMZ7JmTA1BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="470308899"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 13 Aug 2020 10:57:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7ECA53A3; Thu, 13 Aug 2020 20:57:30 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v1 6/7] PCI/ACPI: Fix description of @handle for acpi_is_root_bridge()
Date:   Thu, 13 Aug 2020 20:57:28 +0300
Message-Id: <20200813175729.15088-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com>
References: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com>
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

