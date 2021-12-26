Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A3147F96A
	for <lists+linux-pci@lfdr.de>; Sun, 26 Dec 2021 23:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhLZWmF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Dec 2021 17:42:05 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39888 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbhLZWmF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Dec 2021 17:42:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8C0660F15
        for <linux-pci@vger.kernel.org>; Sun, 26 Dec 2021 22:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309EAC36AE9;
        Sun, 26 Dec 2021 22:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640558524;
        bh=PHZOGwl+r2JjFC+g0qIlEzMLPudTsuiQyDxyxoMnVXc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iHBljENcXitYeMWXuL1e8GEiZ4IU/ycmKHC+KuMWm9vXpd85dSZgxRRp7j/db03hI
         V/VY3F/EalkT4r7Ztj5aGhGxjpjDK3RM938cbgrgWdLqCm5M2XdJOuYYj+OPnW/MHI
         Q7e0UPir4gL3zBvou0ZJ23ppSYr9WQp7Ka21005n5GLsWweZG4CjxZnCqtpXa9Xtoh
         gjekyz/aq2tGZHxuBbWS8ZegVScpY9JOACfrMrZI5GVkZ37teo0aj74XoiKKd4Yb3L
         Yq1RLuFC1ATcj9+N3MkLpapYnDYK/+pL/84IlH9E7ufwTfhz1/wXTwLS+Sp/Z25WP0
         j3LmrbzO1JWYQ==
Received: by pali.im (Postfix)
        id 93B7B9D0; Sun, 26 Dec 2021 23:42:01 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH v3 pciutils] lspci: Show Slot Power Limit values above EFh
Date:   Sun, 26 Dec 2021 23:41:47 +0100
Message-Id: <20211226224147.19960-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <mj+md-20211226.220617.62062.albireo@ucw.cz>
References: <20210403114857.n3h2wr3e3bpdsgnl@pali> <20211101144740.14256-1-pali@kernel.org> <YYABw84admN1+8Ly@casper.infradead.org> <20211124124611.wi6u77pnparg2563@pali> <mj+md-20211226.220617.62062.albireo@ucw.cz>
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
v3: Use floating point and %g printf format to avoid trailing zeros.
---
 ls-caps.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/ls-caps.c b/ls-caps.c
index db56556971cb..6f5613794790 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -656,10 +656,20 @@ static int exp_downstream_port(int type)
 	 type == PCI_EXP_TYPE_PCIE_BRIDGE;	/* PCI/PCI-X to PCIe Bridge */
 }
 
-static float power_limit(int value, int scale)
+static void show_power_limit(int value, int scale)
 {
   static const float scales[4] = { 1.0, 0.1, 0.01, 0.001 };
-  return value * scales[scale];
+  static const int scale0_values[3] = { 250, 275, 300 };
+
+  if (scale == 0 && value >= 0xF0) {
+    /* F3h to FFh = Reserved for Slot Power Limit values above 300 W */
+    if (value >= 0xF3) {
+      printf(">300W");
+      return;
+    }
+    value = scale0_values[value - 0xF0];
+  }
+  printf("%gW", value * scales[scale]);
 }
 
 static const char *latency_l0s(int value)
@@ -700,10 +710,10 @@ static void cap_express_dev(struct device *d, int where, int type)
     printf(" FLReset%c",
 	FLAG(t, PCI_EXP_DEVCAP_FLRESET));
   if ((type == PCI_EXP_TYPE_ENDPOINT) || (type == PCI_EXP_TYPE_UPSTREAM) ||
-      (type == PCI_EXP_TYPE_PCI_BRIDGE))
-    printf(" SlotPowerLimit %.3fW",
-	power_limit((t & PCI_EXP_DEVCAP_PWR_VAL) >> 18,
-		    (t & PCI_EXP_DEVCAP_PWR_SCL) >> 26));
+      (type == PCI_EXP_TYPE_PCI_BRIDGE)) {
+    printf(" SlotPowerLimit ");
+    show_power_limit((t & PCI_EXP_DEVCAP_PWR_VAL) >> 18, (t & PCI_EXP_DEVCAP_PWR_SCL) >> 26);
+  }
   printf("\n");
 
   w = get_conf_word(d, where + PCI_EXP_DEVCTL);
@@ -871,9 +881,10 @@ static void cap_express_slot(struct device *d, int where)
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

