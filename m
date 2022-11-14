Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FD66288AF
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 19:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbiKNS6P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 13:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKNS6K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 13:58:10 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9971CFD1;
        Mon, 14 Nov 2022 10:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668452288; x=1699988288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EaNuN468AX7oVVNzygbZKjeVdiuKUVO8jdpIxMpvwBE=;
  b=GlUNU2HwIQvRlT1qXEhiDcwxNbPnZR4MonvxxZT7Xc0wBuUPib2XJH6/
   a6TTFGUvE5vGmxXKbgiiDWuJiEvp7W94ecNolPwFN3tldFSP0iclExoAN
   QEYJIQf9cd/A4IJ7qraUHIl9qGKK//fuihWWwihU1Gd8jm5+kE9VUrVSh
   a0BhaG0YXmskoyz8YurHpbvi6+bpnkUoegi8a/pnmSylqZnbvE5C7z3n0
   Wix7ZkDzWMxklQMENkLTdQ4KVoPz12w4VlRApJvQ3jYqpJqa5HzMtrej3
   Z/2fohoofWjvo3e0UUL+c0XGK5jigXbAaniu4i+H6yTrkras/2bVXL+Lx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="338843396"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="338843396"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 10:58:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="638607277"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="638607277"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 14 Nov 2022 10:58:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E1657346; Mon, 14 Nov 2022 20:58:24 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: [PATCH v3 3/4] EISA: Convert to use pci_bus_for_each_resource_p()
Date:   Mon, 14 Nov 2022 20:58:21 +0200
Message-Id: <20221114185822.65038-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221114185822.65038-1-andriy.shevchenko@linux.intel.com>
References: <20221114185822.65038-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_bus_for_each_resource_p() hides the iterator loop since
it may be not used otherwise. With this, we may drop that iterator
variable definition.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/eisa/pci_eisa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/eisa/pci_eisa.c b/drivers/eisa/pci_eisa.c
index 930c2332c3c4..907b86384396 100644
--- a/drivers/eisa/pci_eisa.c
+++ b/drivers/eisa/pci_eisa.c
@@ -20,8 +20,8 @@ static struct eisa_root_device pci_eisa_root;
 
 static int __init pci_eisa_init(struct pci_dev *pdev)
 {
-	int rc, i;
 	struct resource *res, *bus_res = NULL;
+	int rc;
 
 	if ((rc = pci_enable_device (pdev))) {
 		dev_err(&pdev->dev, "Could not enable device\n");
@@ -38,7 +38,7 @@ static int __init pci_eisa_init(struct pci_dev *pdev)
 	 * eisa_root_register() can only deal with a single io port resource,
 	*  so we use the first valid io port resource.
 	 */
-	pci_bus_for_each_resource(pdev->bus, res, i)
+	pci_bus_for_each_resource_p(pdev->bus, res)
 		if (res && (res->flags & IORESOURCE_IO)) {
 			bus_res = res;
 			break;
-- 
2.35.1

