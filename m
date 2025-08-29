Return-Path: <linux-pci+bounces-35085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2F0B3B473
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 09:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58685170A1C
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 07:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEF6265614;
	Fri, 29 Aug 2025 07:36:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2897E22068F;
	Fri, 29 Aug 2025 07:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756452998; cv=none; b=PMZdKQPB7rbJBjW7FzjV6Xo6jwDvnEek7frXoq2Dq9Ubeps12M6uU87ycHGDveICRNEJROaKeMbyYEHec6DBPuFsvQileUrcEZWKqDhe8yapEYkJHphGKZYlPCSenR/QTfpNNVIqLroikdtk7DCqSrqF6B+gXTB+4ythrUp9+Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756452998; c=relaxed/simple;
	bh=DYDR6j8uACMdBx8KtIxqvLEUNgMk3O77fBQnP3MbhSM=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=icf8qmqO/r0uSTXXiPvfCmvWj+/TkYb1+u7iwy5IiHXS+avNdY/Q/8YJKqpT49l4ajdnxLOgmuFnbw2TWut3uV1UZi5DaJI28bqWRc6XJpOrqZH/hPCHbzykppSD08DsINN3nlwi1ztnEa7kk8WDwl8HkSv3SiC/jrC8NgyeCCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with UTF8SMTPS id 34ED318C54;
	Fri, 29 Aug 2025 09:36:34 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id 15276600AD9B;
	Fri, 29 Aug 2025 09:36:34 +0200 (CEST)
X-Mailbox-Line: From e18c1152facddc659e107353d67529d5a82a4133 Mon Sep 17 00:00:00 2001
Message-ID: <e18c1152facddc659e107353d67529d5a82a4133.1756451884.git.lukas@wunner.de>
In-Reply-To: <cover.1756451884.git.lukas@wunner.de>
References: <cover.1756451884.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 29 Aug 2025 09:25:02 +0200
Subject: [PATCH 2/4] PCI/ERR: Sync documentation with code
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Bjorn Helgaas <helgaas@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Terry Bowman <terry.bowman@amd.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Linas Vepstas <linasvepstas@gmail.com>, "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, "Oliver OHalloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, Brian Norris <briannorris@chromium.org>

Amend the documentation on PCI error recovery to fix minor inaccuracies
vis-à-vis the actual code:

* The documentation claims that a missing ->resume() or ->mmio_enabled()
  callback always leads to recovery through reset.  But none of the
  implementations do this (pcie_do_recovery(), eeh_handle_normal_event(),
  zpci_event_do_error_state_clear()).

  Drop the claim to align the documentation with the code.

* The documentation does not list PCI_ERS_RESULT_RECOVERED as a valid
  return value from ->error_detected().  But none of the implementations
  forbid this and some drivers are returning it, e.g.:
  drivers/bus/mhi/host/pci_generic.c
  drivers/infiniband/hw/hfi1/pcie.c

  Further down in the documentation it is implied that the return value is
  in fact allowed:
  "The platform will call the resume() callback on all affected device
  drivers if all drivers on the segment have returned
  PCI_ERS_RESULT_RECOVERED from one of the 3 previous callbacks."

  The "3 previous callbacks" being ->error_detected(), ->mmio_enabled()
  and ->slot_reset().

  Add it to the valid return values for consistency.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 Documentation/PCI/pci-error-recovery.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
index 42e1e78353f3..d5c661baa87f 100644
--- a/Documentation/PCI/pci-error-recovery.rst
+++ b/Documentation/PCI/pci-error-recovery.rst
@@ -108,8 +108,8 @@ A driver does not have to implement all of these callbacks; however,
 if it implements any, it must implement error_detected(). If a callback
 is not implemented, the corresponding feature is considered unsupported.
 For example, if mmio_enabled() and resume() aren't there, then it
-is assumed that the driver is not doing any direct recovery and requires
-a slot reset.  Typically a driver will want to know about
+is assumed that the driver does not need these callbacks
+for recovery.  Typically a driver will want to know about
 a slot_reset().
 
 The actual steps taken by a platform to recover from a PCI error
@@ -141,6 +141,9 @@ shouldn't do any new IOs. Called in task context. This is sort of a
 All drivers participating in this system must implement this call.
 The driver must return one of the following result codes:
 
+  - PCI_ERS_RESULT_RECOVERED
+      Driver returns this if it thinks the device is usable despite
+      the error and does not need further intervention.
   - PCI_ERS_RESULT_CAN_RECOVER
       Driver returns this if it thinks it might be able to recover
       the HW by just banging IOs or if it wants to be given
-- 
2.47.2


