Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0706D0B0F
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 18:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjC3Q2f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 12:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjC3Q2a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 12:28:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80618D31C;
        Thu, 30 Mar 2023 09:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680193709; x=1711729709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yhhBl9vHYjEoa/C6LYyaGmzTAsrwMbBX/9yhSQi3PhY=;
  b=eB5C1OzY1asxXvzkN6NmOx8NmWLcSDi1o6o0vQzAnDcqz+xslbgfzhEb
   XDNw9hfx/jy6ngofMgRUUDTQDC/ykqkPphM0MtQSCzE7yEkvqDUUZ7kAB
   kgga3g2haWi2Pe9FSnlANvBKaXXCRSShLQ/jUGSfj3iySTmFjiBL4y9qs
   k+Ma/q7Coj/tcNo2fcYvKVGBDo+BgyBg6CN+PzAQTuwUtDQj1nTFq77JU
   /gBT03edahvVi7DzVJsAjUUV/2OGav8FyMQ2oKQwjoZb0GG+HwmUJCVBs
   t/UIm3NuwgQwGlhKNuK/gOFlx/nyEfzQGRH8pZPQ3hmaG24BmSTtI5kaf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="427495957"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="427495957"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 09:28:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="858971546"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="858971546"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 30 Mar 2023 09:28:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DCBBF1D9; Thu, 30 Mar 2023 19:24:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Juergen Gross <jgross@suse.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Anatolij Gustschin <agust@denx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: [PATCH v8 2/7] PCI: Introduce pci_resource_n()
Date:   Thu, 30 Mar 2023 19:24:29 +0300
Message-Id: <20230330162434.35055-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230330162434.35055-1-andriy.shevchenko@linux.intel.com>
References: <20230330162434.35055-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce pci_resource_n() and replace open-coded implementations of it
in pci.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/linux/pci.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index b50e5c79f7e3..aeaa95455d4c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1995,14 +1995,13 @@ int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma);
  * These helpers provide future and backwards compatibility
  * for accessing popular PCI BAR info
  */
-#define pci_resource_start(dev, bar)	((dev)->resource[(bar)].start)
-#define pci_resource_end(dev, bar)	((dev)->resource[(bar)].end)
-#define pci_resource_flags(dev, bar)	((dev)->resource[(bar)].flags)
-#define pci_resource_len(dev,bar) \
-	((pci_resource_end((dev), (bar)) == 0) ? 0 :	\
-							\
-	 (pci_resource_end((dev), (bar)) -		\
-	  pci_resource_start((dev), (bar)) + 1))
+#define pci_resource_n(dev, bar)	(&(dev)->resource[(bar)])
+#define pci_resource_start(dev, bar)	(pci_resource_n(dev, bar)->start)
+#define pci_resource_end(dev, bar)	(pci_resource_n(dev, bar)->end)
+#define pci_resource_flags(dev, bar)	(pci_resource_n(dev, bar)->flags)
+#define pci_resource_len(dev,bar)					\
+	(pci_resource_end((dev), (bar)) ? 				\
+	 resource_size(pci_resource_n((dev), (bar))) : 0)
 
 /*
  * Similar to the helpers above, these manipulate per-pci_dev
-- 
2.40.0.1.gaa8946217a0b

