Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE9563918
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2019 18:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfGIQOF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jul 2019 12:14:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:64490 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfGIQOF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jul 2019 12:14:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 09:14:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,470,1557212400"; 
   d="scan'208";a="249193042"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 09 Jul 2019 09:14:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 51297F1; Tue,  9 Jul 2019 19:14:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-pci@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jean-Jacques Hiblot <jjhiblot@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2] tools: PCI: Fix installation when `make tools/pci_install`
Date:   Tue,  9 Jul 2019 19:13:59 +0300
Message-Id: <20190709161359.15874-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The commit c9a707875053 ("tools pci: Do not delete pcitest.sh in 'make clean'")
fixed a `make tools clean` issue and simultaneously brought a regression
to the installation process:

  for script in .../tools/pci/pcitest.sh; do	\
	install $script .../usr/usr/bin;	\
  done
  install: cannot stat '.../tools/pci/pcitest.sh': No such file or directory

Here is the missed part of the fix.

Cc: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
- addressed Kishon's comment
- appended his Ack
 tools/pci/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/pci/Makefile b/tools/pci/Makefile
index 6876ee4bd78c..4b95a5176355 100644
--- a/tools/pci/Makefile
+++ b/tools/pci/Makefile
@@ -18,7 +18,6 @@ ALL_TARGETS := pcitest
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
 
 SCRIPTS := pcitest.sh
-ALL_SCRIPTS := $(patsubst %,$(OUTPUT)%,$(SCRIPTS))
 
 all: $(ALL_PROGRAMS)
 
@@ -47,10 +46,10 @@ clean:
 
 install: $(ALL_PROGRAMS)
 	install -d -m 755 $(DESTDIR)$(bindir);		\
-	for program in $(ALL_PROGRAMS) pcitest.sh; do	\
+	for program in $(ALL_PROGRAMS); do		\
 		install $$program $(DESTDIR)$(bindir);	\
 	done;						\
-	for script in $(ALL_SCRIPTS); do		\
+	for script in $(SCRIPTS); do			\
 		install $$script $(DESTDIR)$(bindir);	\
 	done
 
-- 
2.20.1

