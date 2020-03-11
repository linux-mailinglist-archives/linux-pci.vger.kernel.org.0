Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9C1118171A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 12:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgCKLvW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 07:51:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729016AbgCKLvV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Mar 2020 07:51:21 -0400
Received: from mail.kernel.org (unknown [217.110.198.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20836222C3;
        Wed, 11 Mar 2020 11:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583927481;
        bh=/FOyvmNBnujqpNX84UndvEnp71c/WQtnHnB1YZYQJ4Y=;
        h=From:To:Cc:Subject:Date:From;
        b=jBpNtkmRWksNHu554ovB/V3vQ/F5EcK+ltQj27D79NFA7ZCB+NV9R8UuaOmgq5X5E
         0aQwlyVqb323B0kP0MuThyY3EPbgo7t+CmoIMDLaX+i1zdR9xavv6gsCNnew6y7Axu
         Vumwf6l1Tmx7aZC9QiO9xW/hkNZwXOf6A+JrqriI=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jBztP-0001Lo-4l; Wed, 11 Mar 2020 12:51:19 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Guan Xuetao <gxt@pku.edu.cn>, Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pragat Pandya <pragat.pandya@gmail.com>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] docs: fix pointers to io-mapping.rst and io_ordering.rst files
Date:   Wed, 11 Mar 2020 12:51:17 +0100
Message-Id: <c0205119db4fef536272cb0a183b6c14c2c8bf4c.1583927470.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Those files got moved, but cross-references still point to the
wrong places.

Fixes: fcd680727157 ("Documentation: Add io-mapping.rst to driver-api manual")
Fixes: d1ce350015d8 ("Documentation: Add io_ordering.rst to driver-api manual")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/PCI/pci.rst                        | 2 +-
 Documentation/translations/zh_CN/io_ordering.txt | 4 ++--
 arch/unicore32/include/asm/io.h                  | 2 +-
 include/linux/io-mapping.h                       | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
index 6864f9a70f5f..8c016d8c9862 100644
--- a/Documentation/PCI/pci.rst
+++ b/Documentation/PCI/pci.rst
@@ -239,7 +239,7 @@ from the PCI device config space. Use the values in the pci_dev structure
 as the PCI "bus address" might have been remapped to a "host physical"
 address by the arch/chip-set specific kernel support.
 
-See Documentation/io-mapping.txt for how to access device registers
+See Documentation/driver-api/io-mapping.rst for how to access device registers
 or device memory.
 
 The device driver needs to call pci_request_region() to verify
diff --git a/Documentation/translations/zh_CN/io_ordering.txt b/Documentation/translations/zh_CN/io_ordering.txt
index 1f8127bdd415..7bb3086227ae 100644
--- a/Documentation/translations/zh_CN/io_ordering.txt
+++ b/Documentation/translations/zh_CN/io_ordering.txt
@@ -1,4 +1,4 @@
-Chinese translated version of Documentation/io_ordering.txt
+Chinese translated version of Documentation/driver-api/io_ordering.rst
 
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have a problem
@@ -8,7 +8,7 @@ or if there is a problem with the translation.
 
 Chinese maintainer: Lin Yongting <linyongting@gmail.com>
 ---------------------------------------------------------------------
-Documentation/io_ordering.txt 的中文翻译
+Documentation/driver-api/io_ordering.rst 的中文翻译
 
 如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
 交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
diff --git a/arch/unicore32/include/asm/io.h b/arch/unicore32/include/asm/io.h
index 3ca74e1cde7d..bd4e7c332f85 100644
--- a/arch/unicore32/include/asm/io.h
+++ b/arch/unicore32/include/asm/io.h
@@ -27,7 +27,7 @@ extern void __uc32_iounmap(volatile void __iomem *addr);
  * ioremap and friends.
  *
  * ioremap takes a PCI memory address, as specified in
- * Documentation/io-mapping.txt.
+ * Documentation/driver-api/io-mapping.rst.
  *
  */
 #define ioremap(cookie, size)		__uc32_ioremap(cookie, size)
diff --git a/include/linux/io-mapping.h b/include/linux/io-mapping.h
index 837058bc1c9f..b336622612f3 100644
--- a/include/linux/io-mapping.h
+++ b/include/linux/io-mapping.h
@@ -16,7 +16,7 @@
  * The io_mapping mechanism provides an abstraction for mapping
  * individual pages from an io device to the CPU in an efficient fashion.
  *
- * See Documentation/io-mapping.txt
+ * See Documentation/driver-api/io-mapping.rst
  */
 
 struct io_mapping {
-- 
2.24.1

