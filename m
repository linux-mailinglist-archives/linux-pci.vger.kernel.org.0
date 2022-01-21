Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F08049602E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 14:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350790AbiAUN6R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 08:58:17 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48358 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350794AbiAUN6Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 08:58:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1970661774
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 13:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB0DC340E4;
        Fri, 21 Jan 2022 13:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642773495;
        bh=ZGC6gqtt42W9gw5ryIcyecAu6nsWPJd2lgiaehTcKHM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=A1NmU4mWjTGKQoOFY/evGRivOnRh+F7D4MNhqPxZR7Hu64NzD0TfGlRjXl8kt+97O
         N8EQdljiL/Y/KqNfn5k9faAh/Vvi8GFA5YoiSQy1cFOWl52FcvRkJd3J/O9ADGN3vU
         wRzMB2Y2eYSwEGeeZY0UQUwaPfghuwaMBjZE4nuvVlZNmxviuDlWeyXq7KO0daZlKd
         EaB5+pkDWLg9CFoYbKq32uLCbcOQd0TmMICOBw5QZicaMhtYzR/9Y6J07g5myhdCHq
         TqAZmygFXzLMRV1qVDhL3PvndlueoNU/1QN8amnkuLMYyZcDSERF5HV0DFfIhAOPNZ
         vWSUOuUe39Hmg==
Received: by pali.im (Postfix)
        id 16A30857; Fri, 21 Jan 2022 14:58:15 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH pciutils 4/5] libpci: sysfs: Implement PROGIF, REVID and SUBSYS support
Date:   Fri, 21 Jan 2022 14:57:17 +0100
Message-Id: <20220121135718.27172-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220121135718.27172-1-pali@kernel.org>
References: <20220121135718.27172-1-pali@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In sysfs there are optional nodes with this information.
---
 lib/sysfs.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/lib/sysfs.c b/lib/sysfs.c
index 7c157a2688ad..7714607f66a0 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -329,6 +329,7 @@ static unsigned int
 sysfs_fill_info(struct pci_dev *d, unsigned int flags)
 {
   unsigned int done = 0;
+  int value;
 
   if (!d->access->buscentric)
     {
@@ -343,10 +344,42 @@ sysfs_fill_info(struct pci_dev *d, unsigned int flags)
 	  d->device_id = sysfs_get_value(d, "device", 1);
 	  done |= PCI_FILL_IDENT;
 	}
-      if (flags & PCI_FILL_CLASS)
+      if (flags & (PCI_FILL_CLASS | PCI_FILL_PROGIF))
 	{
-	  d->device_class = sysfs_get_value(d, "class", 1) >> 8;
-	  done |= PCI_FILL_CLASS;
+	  value = sysfs_get_value(d, "class", 1);
+	  if (flags & PCI_FILL_CLASS)
+	    {
+	      d->device_class = value >> 8;
+	      done |= PCI_FILL_CLASS;
+	    }
+	  if (flags & PCI_FILL_PROGIF)
+	    {
+	      d->prog_if = value & 0xff;
+	      done |= PCI_FILL_PROGIF;
+	    }
+	}
+      if (flags & PCI_FILL_REVID)
+	{
+	  value = sysfs_get_value(d, "revision", 0);
+	  if (value >= 0)
+	    {
+	      d->rev_id = value;
+	      done |= PCI_FILL_REVID;
+	    }
+        }
+      if (flags & PCI_FILL_SUBSYS)
+	{
+	  value = sysfs_get_value(d, "subsystem_vendor", 0);
+	  if (value >= 0)
+	    {
+	      d->subsys_vendor_id = value;
+	      value = sysfs_get_value(d, "subsystem_device", 0);
+	      if (value >= 0)
+	        {
+	          d->subsys_id = value;
+	          done |= PCI_FILL_SUBSYS;
+	        }
+	    }
 	}
       if (flags & PCI_FILL_IRQ)
 	{
-- 
2.20.1

