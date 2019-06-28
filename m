Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF4F159CA8
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2019 15:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfF1NMW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jun 2019 09:12:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:39309 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbfF1NMW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Jun 2019 09:12:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 06:12:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,427,1557212400"; 
   d="scan'208";a="167753239"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 28 Jun 2019 06:12:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2399B177; Fri, 28 Jun 2019 16:12:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-pci@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v1 2/2] tools: PCI: Fix a typo in usage messages
Date:   Fri, 28 Jun 2019 16:12:18 +0300
Message-Id: <20190628131218.10244-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628131218.10244-1-andriy.shevchenko@linux.intel.com>
References: <20190628131218.10244-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the commit fbca0b284bd0 ("tools: PCI: Add 'h' in optstring of getopt()")
introduced a fix to support -h command line option, it, at the same time,
brought a regression to the code which produces a compile-time warning:

pcitest.c:203:4: warning: too many arguments for format [-Wformat-extra-args]
    "usage: %s [options]\n"
    ^~~~~~~~~~~~~~~~~~~~~~~

Remove trailing comma to make it correct.

Fixes: fbca0b284bd0 ("tools: PCI: Add 'h' in optstring of getopt()")
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 tools/pci/pcitest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 81b89260e80f..c495e5b5fd7f 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -212,7 +212,7 @@ int main(int argc, char **argv)
 			"\t-r			Read buffer test\n"
 			"\t-w			Write buffer test\n"
 			"\t-c			Copy buffer test\n"
-			"\t-s <size>		Size of buffer {default: 100KB}\n",
+			"\t-s <size>		Size of buffer {default: 100KB}\n"
 			"\t-h			Print this help message\n",
 			argv[0]);
 		return -EINVAL;
-- 
2.20.1

