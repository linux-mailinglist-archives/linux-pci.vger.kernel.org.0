Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BA6340AD9
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 18:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhCRRDC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 13:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231924AbhCRRC4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Mar 2021 13:02:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF6E564DD8;
        Thu, 18 Mar 2021 17:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616086976;
        bh=+z5jr/UHM8gKUEtO0rCYBJ5e2tChijd60hU4bvnv5cw=;
        h=From:To:Cc:Subject:Date:From;
        b=tCUIHcy192w5oGjBIWxDVBKEvc3UTY0rSW9XR1RwJvicOvyI+qZKjPsBTpbeeB3FM
         hdIeNs3t7aYi/jMb0ic3GTQr6MP2fPQcbJIIy9ftY7Qj8xeC5CroEyp/X5T09Vh7q6
         rnvCPItnhHB0GVrhqgyR9vDqJMPdRzc5MFXE1OwQFpc0a40u9D4FOgkLWTa99weVQf
         r/kdZ2KOf2kXF+pP9Un4L4kcHtwjUDBbTDp/rMcLuoVYta9mwbwBmjEk/us+cWEqcG
         TrqeWUvvR8ZxEFYH4CG0x+I9EVEz3UsSHxEG3winM8QT4l33Aa5oCshzOtNrc8j1Ap
         FSS5ClU4cyHsw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Martin Mares <mj@ucw.cz>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] lspci: Don't report PCIe link downgrades for downstream ports
Date:   Thu, 18 Mar 2021 12:02:44 -0500
Message-Id: <20210318170244.151240-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

After b47b5bd408e1 ("lspci: Report if the PCIe link speed/width is full or
downgraded"), we report "downgraded" or "ok" for PCIe links operating at
lower speed or width than they're capable of:

  LnkCap: Port #1, Speed 8GT/s, Width x1, ASPM L1, Exit Latency L1 <16us
  LnkSta: Speed 5GT/s (downgraded), Width x1 (ok)

Previously we did this for both ends of the link, but I don't think it's
very useful for Downstream Ports (the upstream end of the link) because we
claim the link is downgraded even if (1) there's no device on the other end
or (2) the other device doesn't support anything faster/wider.

Drop the "downgraded" reporting for Downstream Ports.  If there is a device
below, we'll still complain at that end if it supports a faster/wider link
than is available.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 ls-caps.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/ls-caps.c b/ls-caps.c
index db56556..dd17c6b 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -758,13 +758,16 @@ static char *link_speed(int speed)
     }
 }
 
-static char *link_compare(int sta, int cap)
+static char *link_compare(int type, int sta, int cap)
 {
+  if ((type == PCI_EXP_TYPE_ROOT_PORT) || (type == PCI_EXP_TYPE_DOWNSTREAM) ||
+      (type == PCI_EXP_TYPE_PCIE_BRIDGE))
+    return "";
   if (sta < cap)
-    return "downgraded";
+    return " (downgraded)";
   if (sta > cap)
-    return "strange";
-  return "ok";
+    return " (strange)";
+  return " (ok)";
 }
 
 static char *aspm_support(int code)
@@ -837,11 +840,11 @@ static void cap_express_link(struct device *d, int where, int type)
   w = get_conf_word(d, where + PCI_EXP_LNKSTA);
   sta_speed = w & PCI_EXP_LNKSTA_SPEED;
   sta_width = (w & PCI_EXP_LNKSTA_WIDTH) >> 4;
-  printf("\t\tLnkSta:\tSpeed %s (%s), Width x%d (%s)\n",
+  printf("\t\tLnkSta:\tSpeed %s%s, Width x%d%s\n",
 	link_speed(sta_speed),
-	link_compare(sta_speed, cap_speed),
+	link_compare(type, sta_speed, cap_speed),
 	sta_width,
-	link_compare(sta_width, cap_width));
+	link_compare(type, sta_width, cap_width));
   printf("\t\t\tTrErr%c Train%c SlotClk%c DLActive%c BWMgmt%c ABWMgmt%c\n",
 	FLAG(w, PCI_EXP_LNKSTA_TR_ERR),
 	FLAG(w, PCI_EXP_LNKSTA_TRAIN),
-- 
2.25.1

