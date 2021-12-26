Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6215C47F985
	for <lists+linux-pci@lfdr.de>; Mon, 27 Dec 2021 00:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbhLZXel (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Dec 2021 18:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbhLZXel (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Dec 2021 18:34:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB43C06173E
        for <linux-pci@vger.kernel.org>; Sun, 26 Dec 2021 15:34:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9E5960F29
        for <linux-pci@vger.kernel.org>; Sun, 26 Dec 2021 23:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08573C36AE8;
        Sun, 26 Dec 2021 23:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640561679;
        bh=hLjcgGFRvs09bxXwcnWgSTkTGl7dD76ofrhpDCJGbdo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=osMbC0TIMRvFnte2AY4Edt3A3Po3um9jKfV15muY8+Xe4y0t2WRFNTzKGq6GxfCtz
         tOfulJTub4K6lJ2eUIrimQ2YKjKy0TNkgYVuuq6YmQxnBTUIu8voFnmM7XWjsVyqpH
         eAtvcM54wJiW/tHGzBv2Tt1JggquFZgUVuTvtGjq/idYi6G8pBe3cgfZounBWCrHEN
         wwS0z54qQZROpe4Bx0NEffvS57OdkYV37/czPr4m81rztk+D/zgANPMl6+jwmzi4M6
         MWuaSKG0YZJlEVmd/kUADO7b/d8ahlNuuz13xaTAiuSucGK2oFSTzR+bLgPko2My/4
         /LKf0lF6FGqkw==
Received: by pali.im (Postfix)
        id 6246A9D0; Mon, 27 Dec 2021 00:34:36 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH v4 pciutils] lspci: Show Slot Power Limit values above EFh
Date:   Mon, 27 Dec 2021 00:34:08 +0100
Message-Id: <20211226233408.21204-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <mj+md-20211226.224245.85126.nikam@ucw.cz>
References: <mj+md-20211226.224245.85126.nikam@ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI Express Base Specification rev. 3.0 has the following definition for
the Slot Power Limit Value:

=======================================================================
When the Slot Power Limit Scale field equals 00b (1.0x) and Slot Power
Limit Value exceeds EFh, the following alternative encodings are used:
  F0h = 250 W Slot Power Limit
  F1h = 275 W Slot Power Limit
  F2h = 300 W Slot Power Limit
  F3h to FFh = Reserved for Slot Power Limit values above 300 W
=======================================================================

Replace function power_limit() by show_power_limit() which also prints
power limit value. Show reserved value as string ">300W".
---
v4: Fix coding style
---
 ls-caps.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/ls-caps.c b/ls-caps.c
index db56556971cb..495d73a92e29 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -656,10 +656,22 @@ static int exp_downstream_port(int type)
 	 type == PCI_EXP_TYPE_PCIE_BRIDGE;	/* PCI/PCI-X to PCIe Bridge */
 }
 
-static float power_limit(int value, int scale)
+static void show_power_limit(int value, int scale)
 {
   static const float scales[4] = { 1.0, 0.1, 0.01, 0.001 };
-  return value * scales[scale];
+  static const int scale0_values[3] = { 250, 275, 300 };
+
+  if (scale == 0 && value >= 0xF0)
+    {
+      /* F3h to FFh = Reserved for Slot Power Limit values above 300 W */
+      if (value >= 0xF3)
+        {
+          printf(">300W");
+          return;
+        }
+      value = scale0_values[value - 0xF0];
+    }
+  printf("%gW", value * scales[scale]);
 }
 
 static const char *latency_l0s(int value)
@@ -701,9 +713,10 @@ static void cap_express_dev(struct device *d, int where, int type)
 	FLAG(t, PCI_EXP_DEVCAP_FLRESET));
   if ((type == PCI_EXP_TYPE_ENDPOINT) || (type == PCI_EXP_TYPE_UPSTREAM) ||
       (type == PCI_EXP_TYPE_PCI_BRIDGE))
-    printf(" SlotPowerLimit %.3fW",
-	power_limit((t & PCI_EXP_DEVCAP_PWR_VAL) >> 18,
-		    (t & PCI_EXP_DEVCAP_PWR_SCL) >> 26));
+    {
+      printf(" SlotPowerLimit ");
+      show_power_limit((t & PCI_EXP_DEVCAP_PWR_VAL) >> 18, (t & PCI_EXP_DEVCAP_PWR_SCL) >> 26);
+    }
   printf("\n");
 
   w = get_conf_word(d, where + PCI_EXP_DEVCTL);
@@ -871,9 +884,10 @@ static void cap_express_slot(struct device *d, int where)
 	FLAG(t, PCI_EXP_SLTCAP_PWRI),
 	FLAG(t, PCI_EXP_SLTCAP_HPC),
 	FLAG(t, PCI_EXP_SLTCAP_HPS));
-  printf("\t\t\tSlot #%d, PowerLimit %.3fW; Interlock%c NoCompl%c\n",
-	(t & PCI_EXP_SLTCAP_PSN) >> 19,
-	power_limit((t & PCI_EXP_SLTCAP_PWR_VAL) >> 7, (t & PCI_EXP_SLTCAP_PWR_SCL) >> 15),
+  printf("\t\t\tSlot #%d, PowerLimit ",
+	(t & PCI_EXP_SLTCAP_PSN) >> 19);
+  show_power_limit((t & PCI_EXP_SLTCAP_PWR_VAL) >> 7, (t & PCI_EXP_SLTCAP_PWR_SCL) >> 15);
+  printf("; Interlock%c NoCompl%c\n",
 	FLAG(t, PCI_EXP_SLTCAP_INTERLOCK),
 	FLAG(t, PCI_EXP_SLTCAP_NOCMDCOMP));
 
-- 
2.20.1

