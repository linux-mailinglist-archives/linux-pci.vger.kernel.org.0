Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926E5496063
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 15:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380888AbiAUOFK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 09:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381015AbiAUOFI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 09:05:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADFCC061574
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 06:05:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 373CF6177B
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 14:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D9EC340E3;
        Fri, 21 Jan 2022 14:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642773907;
        bh=nDCynboh8mnhqqPXz4Xcod8SOBX3JS9uy/dozeoYPyg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jPLOL2rZvVsKo8LskeN/RwOnt1nWx5FWlGKqwoM6UTtdmDEJwOHR4kvSm3DDZmxOA
         qBWfTA4vILNi2syi+o9oLP1YMolbMFxL9v+qiSBBw7SAkZa2Xd1kzoSgZ/MfX5MeGx
         uymnjwgTnrgycOTy0mTmaX+4/i4WJ4ZS0hNDTOKiVn7hWpTs4S9YToTmsVxOlM2h5/
         Kvd7esRfVgYHDxJYMH1AY7Y3rQAOhDyC2Z8eQIQm99XQZuh6WK7qNiwlSjeudq637z
         4MdN9uMS0l5cygSjbWcuYKmjcaSW9/J+7hnRasjpS5uTXdIJ0L00t/dde3jrMwt53L
         H+z7X5MGhvVUg==
Received: by pali.im (Postfix)
        id 498AAC83; Fri, 21 Jan 2022 15:05:05 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH pciutils 2/4] libpci: proc: Implement support for PCI_FILL_DRIVER
Date:   Fri, 21 Jan 2022 15:03:49 +0100
Message-Id: <20220121140351.27382-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220121140351.27382-1-pali@kernel.org>
References: <20220121140351.27382-1-pali@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

File /proc/bus/pci/devices contains optional driver name in the last 18th field.
---
 lib/proc.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/lib/proc.c b/lib/proc.c
index cb9d08d17768..9b33863e69e6 100644
--- a/lib/proc.c
+++ b/lib/proc.c
@@ -11,6 +11,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
+#include <ctype.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <sys/types.h>
@@ -69,9 +70,11 @@ proc_scan(struct pci_access *a)
     {
       struct pci_dev *d = pci_alloc_dev(a);
       unsigned int dfn, vend, cnt, known;
+      char *driver;
+      int offset;
 
 #define F " " PCIADDR_T_FMT
-      cnt = sscanf(buf, "%x %x %x" F F F F F F F F F F F F F F,
+      cnt = sscanf(buf, "%x %x %x" F F F F F F F F F F F F F F "%n",
 	     &dfn,
 	     &vend,
 	     &d->irq,
@@ -88,7 +91,8 @@ proc_scan(struct pci_access *a)
 	     &d->size[3],
 	     &d->size[4],
 	     &d->size[5],
-	     &d->rom_size);
+	     &d->rom_size,
+	     &offset);
 #undef F
       if (cnt != 9 && cnt != 10 && cnt != 17)
 	a->error("proc: parse error (read only %d items)", cnt);
@@ -106,6 +110,20 @@ proc_scan(struct pci_access *a)
 	  if (cnt >= 17)
 	    known |= PCI_FILL_SIZES;
 	}
+      if (cnt >= 17)
+        {
+          while (buf[offset] && isspace(buf[offset]))
+            ++offset;
+          driver = &buf[offset];
+          while (buf[offset] && !isspace(buf[offset]))
+            ++offset;
+          buf[offset] = '\0';
+          if (driver[0])
+            {
+              pci_set_property(d, PCI_FILL_DRIVER, driver);
+              known |= PCI_FILL_DRIVER;
+            }
+        }
       d->known_fields = known;
       pci_link_dev(a, d);
     }
-- 
2.20.1

