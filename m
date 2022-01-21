Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC565496066
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 15:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348550AbiAUOFM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 09:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350899AbiAUOFK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 09:05:10 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9F8C061746
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 06:05:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 84460CE2380
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 14:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D084CC340E8;
        Fri, 21 Jan 2022 14:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642773907;
        bh=sAKY1TpYTFaQfEDL5XqTWgX7eWD/m7B5OgJyKzXNW+E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kofe4ZqiOE1pyd1jK67tb07oJimg+6Oi5Y73Bm5Kb4/kMekEAnpCKQ2hLsRvm4ZmX
         c7KvAXDeJ0awILfXboazRp9CSQdFxtOcXAKOfQxT2zPG1Iq2+xzCHdaXFf5yMNoB/T
         aQDuD5whUa+S3VYC3FbrRwB5/4WHABGye+33PKRddFUou8XXBcQNX2I0CTjUw1Ipig
         KCr4VkpoxQzUEHQ8B9KF0xMkngU9Mcs1GSqoXqV2k4KMQ7VX+y6N4/WxpZOuzs87HD
         6Fj1rZMEOFYXVjC9hbdKa0KzN4NixSBmJtOEKLzxakxNY8rQcjqPSuj7WX4VWbhyMJ
         i638Q66U+Llqg==
Received: by pali.im (Postfix)
        id 8AA0A857; Fri, 21 Jan 2022 15:05:06 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH pciutils 3/4] libpci: sysfs: Implement support for PCI_FILL_DRIVER
Date:   Fri, 21 Jan 2022 15:03:50 +0100
Message-Id: <20220121140351.27382-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220121140351.27382-1-pali@kernel.org>
References: <20220121140351.27382-1-pali@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In sysfs is driver name stored as symlink path of "driver" node.
---
 lib/sysfs.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/sysfs.c b/lib/sysfs.c
index 7714607f66a0..0dbd127ff53b 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -445,6 +445,19 @@ sysfs_fill_info(struct pci_dev *d, unsigned int flags)
       done |= PCI_FILL_DT_NODE;
     }
 
+  if (flags & PCI_FILL_DRIVER)
+    {
+      char *driver_path = sysfs_deref_link(d, "driver");
+      if (driver_path)
+        {
+          char *driver = strrchr(driver_path, '/');
+          driver = driver ? driver+1 : driver_path;
+          pci_set_property(d, PCI_FILL_DRIVER, driver);
+          free(driver_path);
+        }
+      done |= PCI_FILL_DRIVER;
+    }
+
   return done | pci_generic_fill_info(d, flags & ~done);
 }
 
-- 
2.20.1

