Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3309C61851C
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 17:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbiKCQrj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 12:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiKCQrL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 12:47:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB60119C1B;
        Thu,  3 Nov 2022 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667493996; x=1699029996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EaNuN468AX7oVVNzygbZKjeVdiuKUVO8jdpIxMpvwBE=;
  b=dkXSM4wHOuYtUhyvyq75B8MweJmqi5yuqRLxPmabh/asMdBZbjpgjd74
   rDihfdGNWTqbsKdh7uAlseHOg1bQWN1Zfz2H17z54thIuMJtzP4mYTXtL
   HR5bLP/DuYI+Uw9sZIR4BFATAslnskiGBXR1KlNTKQ476tVSVFFR68fO/
   31ALWtoTMVHIjfN9j7bOZ9J1KwTounrfbud+H4VbXHdtj6gJk3tt9FwPk
   ucJLTyaT68ARU2UOVO/XsgvWB3DKaf6Y2q9bSnEnYCPTCHAks7FAxX3MF
   OnVO7v+9K7t7R9DvrReoi2rKNS5qs4MeH168H6XvLB0NyB9F+A8+TqHxC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="297198933"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="297198933"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 09:46:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="809735378"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="809735378"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 03 Nov 2022 09:46:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B75E129D; Thu,  3 Nov 2022 18:46:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
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
Subject: [PATCH v2 3/4] EISA: Convert to use pci_bus_for_each_resource_p()
Date:   Thu,  3 Nov 2022 18:46:43 +0200
Message-Id: <20221103164644.70554-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221103164644.70554-1-andriy.shevchenko@linux.intel.com>
References: <20221103164644.70554-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

