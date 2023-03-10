Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3CB6B4E41
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 18:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjCJROk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 12:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCJROg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 12:14:36 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E755B433;
        Fri, 10 Mar 2023 09:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678468454; x=1710004454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=At9xdYTQNTpkoGAW78tZWvzRJ4xj1ehsEwPouDTGZjw=;
  b=QwWp+pwDv1RWiI26KOBED6yl76ciM7XDOxbZiU62AjSjPVfd4jfRbawz
   Fq8v+KRI0/R2NGzn6Lg3VCGJ7+0UyU1kUocLzktlr4ZZlCp243slwLUIb
   SDxXN4GlRwyeq5qqK/eLVO2mm0VCL2JWtfbGf6KVebL5TtOWsDIW4qQEn
   ZOzdK2uzYhO0IHfmkgWflmHjwej0C2+Ixfd9xY7f42CkJOe5F3XrvG5fR
   ZpTAxcRQc/DZvD8ZCj064wa6uj1djT9s0yTfp8BE8JyxIED4uHYCAmq++
   7SRx98cD3ddEfQKz5GbBxTX43jbYi8bUMxdhpDtZ89olxzpaJgmwCGGE/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="325132287"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="325132287"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 09:13:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="655250064"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="655250064"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 10 Mar 2023 09:13:37 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 867E0367; Fri, 10 Mar 2023 19:14:21 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
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
Subject: [PATCH v4 4/4] pcmcia: Convert to use pci_bus_for_each_resource_p()
Date:   Fri, 10 Mar 2023 19:14:16 +0200
Message-Id: <20230310171416.23356-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230310171416.23356-1-andriy.shevchenko@linux.intel.com>
References: <20230310171416.23356-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_bus_for_each_resource_p() hides the iterator loop since
it may be not used otherwise. With this, we may drop that iterator
variable definition.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/pcmcia/rsrc_nonstatic.c | 9 +++------
 drivers/pcmcia/yenta_socket.c   | 3 +--
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index ad1141fddb4c..9d92d4bb6239 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -934,7 +934,7 @@ static int adjust_io(struct pcmcia_socket *s, unsigned int action, unsigned long
 static int nonstatic_autoadd_resources(struct pcmcia_socket *s)
 {
 	struct resource *res;
-	int i, done = 0;
+	int done = 0;
 
 	if (!s->cb_dev || !s->cb_dev->bus)
 		return -ENODEV;
@@ -960,12 +960,9 @@ static int nonstatic_autoadd_resources(struct pcmcia_socket *s)
 	 */
 	if (s->cb_dev->bus->number == 0)
 		return -EINVAL;
-
-	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
-		res = s->cb_dev->bus->resource[i];
-#else
-	pci_bus_for_each_resource(s->cb_dev->bus, res, i) {
 #endif
+
+	pci_bus_for_each_resource_p(s->cb_dev->bus, res) {
 		if (!res)
 			continue;
 
diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index 1365eaa20ff4..2e5bdf3db0ba 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -673,9 +673,8 @@ static int yenta_search_res(struct yenta_socket *socket, struct resource *res,
 			    u32 min)
 {
 	struct resource *root;
-	int i;
 
-	pci_bus_for_each_resource(socket->dev->bus, root, i) {
+	pci_bus_for_each_resource_p(socket->dev->bus, root) {
 		if (!root)
 			continue;
 
-- 
2.39.1

