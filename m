Return-Path: <linux-pci+bounces-33927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7F5B2402A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 07:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26F268409D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 05:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE322BE63B;
	Wed, 13 Aug 2025 05:25:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF262BE644
	for <linux-pci@vger.kernel.org>; Wed, 13 Aug 2025 05:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755062714; cv=none; b=d7tP0Z4MiqyboEwxYgByUH5Nyoj6+78OoOos5gda+FG35V638jQVmibio5k1IwedlfsX1Rfj3Qugs1QZFeGi2QtSj5Y55jbBUOaklYA78OErjM4K17HUs4y5ejg9RqG+d4r59eahnrilUe02+eRTInMi/P02TlYuF/XPLUQzp8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755062714; c=relaxed/simple;
	bh=2p599Iw9QfL6af6Ak6ChC4xtgYVGCF2Kk6xpU4hZpF0=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=KJvIQ9ja8d3JAraupwAWrLPOJzFy0r4OcTs+FH8TYTC+KBleXL69Y172Pgv7IHiqR9Vwmh1ePioSDvOW8fYHPn+lYLhEskIpczDZlOrHaFdNh1QmyTxTBakXiyDaIP9aQ0pfAeog5TEWm+/Q6GQBmiPp/wsLf8jYFDonaO9Plvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with UTF8SMTPS id D07FC18C4A;
	Wed, 13 Aug 2025 07:25:09 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id A23F36000EA5;
	Wed, 13 Aug 2025 07:25:09 +0200 (CEST)
X-Mailbox-Line: From 28fd805043bb57af390168d05abb30898cf4fc58 Mon Sep 17 00:00:00 2001
Message-ID: <28fd805043bb57af390168d05abb30898cf4fc58.1755008151.git.lukas@wunner.de>
In-Reply-To: <cover.1755008151.git.lukas@wunner.de>
References: <cover.1755008151.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 13 Aug 2025 07:11:01 +0200
Subject: [PATCH 1/5] PCI/AER: Allow drivers to opt in to Bus Reset on
 Non-Fatal Errors
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Riana Tauro <riana.tauro@intel.com>, Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>, "Sean C. Dardis" <sean.c.dardis@intel.com>, Terry Bowman <terry.bowman@amd.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Linas Vepstas <linasvepstas@gmail.com>, "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, "Oliver OHalloran" <oohall@gmail.com>, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

When Advanced Error Reporting was introduced in September 2006 by commit
6c2b374d7485 ("PCI-Express AER implemetation: AER core and aerdriver"), it
sought to adhere to the recovery flow and callbacks specified in
Documentation/PCI/pci-error-recovery.rst.

That document had been added in January 2006, when Enhanced Error Handling
(EEH) was introduced for PowerPC with commit 065c6359071c ("[PATCH] PCI
Error Recovery: documentation").

However the AER driver deviates from the document in that it never
performs a Secondary Bus Reset on Non-Fatal Errors, but always on Fatal
Errors.  By contrast, EEH allows drivers to opt in or out of a Bus Reset
regardless of error severity, by returning PCI_ERS_RESULT_NEED_RESET or
PCI_ERS_RESULT_CAN_RECOVER from their ->error_detected() callback.  If all
drivers agree that they can recover without a Bus Reset, EEH skips it.
Should one of them request a Bus Reset, it overrides all other drivers.

This inconsistency between EEH and AER seems problematic because drivers
need to be aware of and cope with it.

The file Documentation/PCI/pcieaer-howto.rst hints at a rationale for
always performing a Bus Reset on Fatal Errors:  "Fatal errors [...] cause
the link to be unreliable.  [...] This [reset_link] callback is used to
reset the PCIe physical link when a fatal error happens.  If an error
message indicates a fatal error, [...] performing link reset at upstream
is necessary."

There's no such rationale provided for never performing a Bus Reset on
Non-Fatal Errors.

The "xe" driver has a need to attempt a reset of local units on graphics
cards upon a Non-Fatal Error.  If that is insufficient for recovery, the
driver wants to opt in to a Bus Reset.

Accommodate such use cases and align AER more closely with EEH by
performing a Bus Reset in pcie_do_recovery() if drivers request it and the
faulting device's channel_state is pci_channel_io_normal.  The AER driver
sets this channel_state for Non-Fatal Errors.  For Fatal Errors, it uses
pci_channel_io_frozen.

This limits the deviation from Documentation/PCI/pci-error-recovery.rst
and EEH to the unconditional Bus Reset on Fatal Errors.

pcie_do_recovery() is also invoked by the Downstream Port Containment and
Error Disconnect Recover drivers.  They both set the channel_state to
pci_channel_io_frozen, hence pcie_do_recovery() continues to always invoke
the ->reset_subordinates() callback in their case.  That is necessary
because the callback brings the link back up at the containing Downstream
Port.

There are two behavioral changes resulting from this commit:

First, if channel_state is pci_channel_io_normal and one of the affected
drivers returns PCI_ERS_RESULT_NEED_RESET from its ->error_detected()
callback, a Bus Reset will now be performed.  There are drivers doing this
and although it would be possible to avoid a behavioral change by letting
them return PCI_ERS_RESULT_CAN_RECOVER instead, the impression I got from
examination of all drivers is that they actually expect or want a Bus
Reset (cxl_error_detected() is a case in point).  In any case, if they can
cope with a Bus Reset on Fatal Errors, they shouldn't have issues with a
Bus Reset on Non-Fatal Errors.

Second, if channel_state is pci_channel_io_frozen and all affected drivers
return PCI_ERS_RESULT_CAN_RECOVER from ->error_detected(), their
->mmio_enabled() callback is now invoked prior to performing a Bus Reset,
instead of afterwards.  This actually makes sense:  For example,
drivers/scsi/sym53c8xx_2/sym_glue.c dumps debug registers in its
->mmio_enabled() callback.  Doing so after reset right now captures the
post-reset state instead of the faulting state, which is useless.

There is only one other driver which implements ->mmio_enabled() and
returns PCI_ERS_RESULT_CAN_RECOVER from ->error_detected() for
channel_state pci_channel_io_frozen, drivers/scsi/ipr.c (IBM Power RAID).
It appears to only be used on EEH platforms.  So the second behavioral
change is limited to these two drivers.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pcie/err.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index de6381c690f5..e795e5ae6b03 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -217,15 +217,10 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL);
 
 	pci_dbg(bridge, "broadcast error_detected message\n");
-	if (state == pci_channel_io_frozen) {
+	if (state == pci_channel_io_frozen)
 		pci_walk_bridge(bridge, report_frozen_detected, &status);
-		if (reset_subordinates(bridge) != PCI_ERS_RESULT_RECOVERED) {
-			pci_warn(bridge, "subordinate device reset failed\n");
-			goto failed;
-		}
-	} else {
+	else
 		pci_walk_bridge(bridge, report_normal_detected, &status);
-	}
 
 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
 		status = PCI_ERS_RESULT_RECOVERED;
@@ -233,6 +228,14 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pci_walk_bridge(bridge, report_mmio_enabled, &status);
 	}
 
+	if (status == PCI_ERS_RESULT_NEED_RESET ||
+	    state == pci_channel_io_frozen) {
+		if (reset_subordinates(bridge) != PCI_ERS_RESULT_RECOVERED) {
+			pci_warn(bridge, "subordinate device reset failed\n");
+			goto failed;
+		}
+	}
+
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
 		/*
 		 * TODO: Should call platform-specific
-- 
2.47.2


