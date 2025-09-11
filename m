Return-Path: <linux-pci+bounces-35908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 898A3B5336D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 15:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D4A56869B
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 13:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AD631B129;
	Thu, 11 Sep 2025 13:18:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B847D2E401;
	Thu, 11 Sep 2025 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596708; cv=none; b=FaFYQ4RYxfgYjLb6bcFfNVuuLZFraOckR6HzYHj3NcSNzIZxJ14MJVbnya9324KG27ayMLaB2S4tEzP3lNm9y/XHs8f1oIoOouuqYPiOC8K8cbLT58OAphfoaGgxPEgO7/fVTtRkwLHnB96DfXJvXxCnmb7n9TDQGmPwldArW54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596708; c=relaxed/simple;
	bh=5UhE74WdbzLugadaIkZBsDKJhzSTo6uvVRhz+xIgPAM=;
	h=Message-ID:From:Date:Subject:To:Cc; b=seijvBoOnXa/xFncBxPEvCd7tiH9q8RT3eiIfc2XQvAMxFjzFI5RwekBpPgi+Rh54XSNSu5OYdyefm8q+RjMrwZ0weDmiTpA0GjEEb0QRh+sWFCv+f1l2NReGhNImKQFz3KS0kPaFF65aT9eb3J+RGNNC4bV1M9k0g7go8NA7kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout3.hostsharing.net (Postfix) with UTF8SMTPS id 05753300679A;
	Thu, 11 Sep 2025 15:11:45 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id A724060B09B2;
	Thu, 11 Sep 2025 15:11:44 +0200 (CEST)
X-Mailbox-Line: From 75e4ae507fa4faddd063a3a9e17d319ed84529b6 Mon Sep 17 00:00:00 2001
Message-ID: <75e4ae507fa4faddd063a3a9e17d319ed84529b6.1757562971.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Thu, 11 Sep 2025 15:11:46 +0200
Subject: [PATCH] PCI/PM: Move ASUS EHCI workaround out of generic code
To: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Mario Limonciello <superm1@kernel.org>,
    Oleksij Rempel <o.rempel@pengutronix.de>, Timo Jyrinki <timo.jyrinki@iki.fi>, Ernst Persson <ernstp@gmail.com>, Steven Harms <sjharms@gmail.com>, James Ettle <james@ettle.org.uk>, Nick Coghlan <ncoghlan@gmail.com>, Weng Xuetian <wengxt@gmail.com>, Andrey Rahmatullin <wrar@wrar.name>, Boris Barbour <boris.barbour@ens.fr>, Vlastimil Zima <vlastimil.zima@gmail.com>, David Banks <amoebae@gmail.com>, Michal Jaegermann <michal@harddata.com>, Chris Moeller <kode54@gmail.com>, Daniel Fraga <fragabr@gmail.com>, Javier Marcet <jmarcet@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

In 2012, commit dbf0e4c7257f ("PCI: EHCI: fix crash during suspend on ASUS
computers") amended pci_pm_suspend_noirq() to work around a BIOS issue by
clearing the Command register if the suspended device is a USB EHCI host
controller.

Commit 0b68c8e2c3af ("PCI: EHCI: Fix crash during hibernation on ASUS
computers") subsequently amended pci_pm_poweroff_noirq() to do the same.

Two years later, commit 7d2a01b87f16 ("PCI: Add pci_fixup_suspend_late
quirk pass") introduced the ability to execute arbitrary quirks
specifically in pci_pm_suspend_noirq() and pci_pm_poweroff_noirq().

This allows moving the ASUS workaround out of generic code and into a
proper quirk to improve maintainability and readability.  Constrain to x86
since the ASUS BIOS doesn't seem to have been used on other arches.

lspci output of affected EHCI host controllers reveals that the only bits
set in the Command register are Memory Space Enable and Bus Master Enable:
  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=658778

The latter is cleared by:
  hcd_pci_suspend()
    suspend_common()
      pci_disable_device()

pci_disable_device() does not clear I/O and Memory Space Enable, although
its name suggests otherwise.  The kernel has never disabled these bits
once they're enabled.  Doing so would avoid the need for the quirk, but it
is unclear what will break if this fundamental behavior is changed.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 arch/x86/pci/fixup.c     | 19 +++++++++++++++++++
 drivers/pci/pci-driver.c | 19 -------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index e7e71490bd25..c34ff72434f2 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -1041,3 +1041,22 @@ static void quirk_tuxeo_rp_d3(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_tuxeo_rp_d3);
 #endif /* CONFIG_SUSPEND */
+
+#ifdef CONFIG_PM_SLEEP
+/*
+ * Some BIOSes from ASUS have a bug: If a USB EHCI host controller's Command
+ * register is not 0 on suspend, the BIOS assumes that the controller has not
+ * been quiesced and tries to turn it off.  If the controller is already in D3,
+ * this can hang or cause memory corruption.
+ *
+ * Since the value of the Command register does not matter once the device has
+ * been suspended, it can safely be set to 0.
+ */
+static void quirk_clear_command_reg(struct pci_dev *pdev)
+{
+	pci_write_config_word(pdev, PCI_COMMAND, 0);
+}
+DECLARE_PCI_FIXUP_CLASS_SUSPEND_LATE(PCI_ANY_ID, PCI_ANY_ID,
+				     PCI_CLASS_SERIAL_USB_EHCI, 0,
+				     quirk_clear_command_reg);
+#endif /* CONFIG_PM_SLEEP */
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 63665240ae87..e1089dfeb419 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -914,18 +914,6 @@ static int pci_pm_suspend_noirq(struct device *dev)
 
 	pci_pm_set_unknown_state(pci_dev);
 
-	/*
-	 * Some BIOSes from ASUS have a bug: If a USB EHCI host controller's
-	 * PCI COMMAND register isn't 0, the BIOS assumes that the controller
-	 * hasn't been quiesced and tries to turn it off.  If the controller
-	 * is already in D3, this can hang or cause memory corruption.
-	 *
-	 * Since the value of the COMMAND register doesn't matter once the
-	 * device has been suspended, we can safely set it to 0 here.
-	 */
-	if (pci_dev->class == PCI_CLASS_SERIAL_USB_EHCI)
-		pci_write_config_word(pci_dev, PCI_COMMAND, 0);
-
 Fixup:
 	pci_fixup_device(pci_fixup_suspend_late, pci_dev);
 
@@ -1205,13 +1193,6 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 	if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
 		pci_prepare_to_sleep(pci_dev);
 
-	/*
-	 * The reason for doing this here is the same as for the analogous code
-	 * in pci_pm_suspend_noirq().
-	 */
-	if (pci_dev->class == PCI_CLASS_SERIAL_USB_EHCI)
-		pci_write_config_word(pci_dev, PCI_COMMAND, 0);
-
 	pci_fixup_device(pci_fixup_suspend_late, pci_dev);
 
 	return 0;
-- 
2.51.0


