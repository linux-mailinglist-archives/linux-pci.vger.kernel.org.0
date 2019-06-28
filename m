Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 175E859CF7
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2019 15:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfF1Ndb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jun 2019 09:33:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:40369 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbfF1Ndb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Jun 2019 09:33:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 06:33:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,427,1557212400"; 
   d="scan'208";a="162974304"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jun 2019 06:33:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ABD0914A; Fri, 28 Jun 2019 16:33:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-pci@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jean-Jacques Hiblot <jjhiblot@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v1] tools: PCI: Fix installation when `make tools/pci_install`
Date:   Fri, 28 Jun 2019 16:33:26 +0300
Message-Id: <20190628133326.18203-1-andriy.shevchenko@linux.intel.com>
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
---
 tools/pci/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/pci/Makefile b/tools/pci/Makefile
index 6876ee4bd78c..cc4a161ee2cc 100644
--- a/tools/pci/Makefile
+++ b/tools/pci/Makefile
@@ -47,10 +47,10 @@ clean:
 
 install: $(ALL_PROGRAMS)
 	install -d -m 755 $(DESTDIR)$(bindir);		\
-	for program in $(ALL_PROGRAMS) pcitest.sh; do	\
+	for program in $(ALL_PROGRAMS); do		\
 		install $$program $(DESTDIR)$(bindir);	\
 	done;						\
-	for script in $(ALL_SCRIPTS); do		\
+	for script in pcitest.sh; do			\
 		install $$script $(DESTDIR)$(bindir);	\
 	done
 
-- 
2.20.1

