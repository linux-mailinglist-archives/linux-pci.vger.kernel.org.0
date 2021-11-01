Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67807441CD4
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 15:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhKAOus (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 10:50:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhKAOur (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Nov 2021 10:50:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E5D561078;
        Mon,  1 Nov 2021 14:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635778094;
        bh=NibGGvDGAqD2fZAjLPw3BB356t2ySCdywicO6xAXFuk=;
        h=From:To:Subject:Date:From;
        b=gCkJsRYPhVFRKjMQaUC698IQH6+5Uc0auRM3Bq30nCbCiThaPcevSUu//dWPEv4i9
         JYsQB+HnkSRtcSi5JjWUk7sKznbKrNvMqNniryyWM+JWqF1KP/tPeaQWBpAECUhNHv
         mXhUb67VF17SwPI6lN/6MW057MWv1pIEqcf7MVMv5WsAZJPZMJC7E5o+PJBcPvvy8K
         LTySghKxEV37UXZS0CuX9Jmi6EbjkwXVJXak4UZOhF0Cimiry+jNL3U6ETp0LR613h
         SpkM4KXxYGpJKCAABngkMn9jZLnmoDlANLMS+ok4w0sDdybSFcMK2xdVahLRGKv7mE
         HzyDbkzxxlVHA==
Received: by pali.im (Postfix)
        id B27157E4; Mon,  1 Nov 2021 15:48:11 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH v2] lspci: Show Slot Power Limit values above EFh
Date:   Mon,  1 Nov 2021 15:47:40 +0100
Message-Id: <20211101144740.14256-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
power limit value. Show reserved value as string ">300W" and omit usage of
floating point variables as it is not needed.
---
 ls-caps.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/ls-caps.c b/ls-caps.c
index db56556971cb..7fa6c1da45bd 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -656,10 +656,27 @@ static int exp_downstream_port(int type)
 	 type == PCI_EXP_TYPE_PCIE_BRIDGE;	/* PCI/PCI-X to PCIe Bridge */
 }
 
-static float power_limit(int value, int scale)
+static void show_power_limit(int value, int scale)
 {
-  static const float scales[4] = { 1.0, 0.1, 0.01, 0.001 };
-  return value * scales[scale];
+  static const int scales[4] = { 1000, 100, 10, 1 };
+  static const int scale0_values[3] = { 250, 275, 300 };
+  if (scale == 0 && value >= 0xF0) {
+    /* F3h to FFh = Reserved for Slot Power Limit values above 300 W */
+    if (value >= 0xF3) {
+      printf(">300W");
+      return;
+    }
+    value = scale0_values[value - 0xF0];
+  }
+  value *= scales[scale];
+  printf("%d", value / 1000);
+  if (value % 10)
+    printf(".%03d", value % 1000);
+  else if (value % 100)
+    printf(".%02d", (value / 10) % 100);
+  else if (value % 1000)
+    printf(".%d", (value / 100) % 10);
+  printf("W");
 }
 
 static const char *latency_l0s(int value)
@@ -700,10 +717,10 @@ static void cap_express_dev(struct device *d, int where, int type)
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
@@ -871,9 +888,10 @@ static void cap_express_slot(struct device *d, int where)
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

