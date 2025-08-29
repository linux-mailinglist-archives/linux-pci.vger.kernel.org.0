Return-Path: <linux-pci+bounces-35088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5799BB3B4B9
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 09:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5221C84D76
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 07:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFB126158C;
	Fri, 29 Aug 2025 07:51:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56EF10F2;
	Fri, 29 Aug 2025 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453863; cv=none; b=bF5TIxBF8ZYUFEtjfchkNPRtLC6sjhGkXdf6wySlAWcrrjlZOLC/EQxYWkwJiDT99eJp7G7Awurplih6X0wR79R5/XU5m7yFCK8/K3BPho6gPLn5W+s+YnGBEgbAkWoCjTwGyHWi5SsMekGVxw1c0bkfMoIT6bARUvcOf5QYKPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453863; c=relaxed/simple;
	bh=MadAWZ3EmTpt4X17hWUBy43zI9NrdvHbyfp/Xrizb/o=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=Mmhlx9GCvzgxV2U+WlnwWL9XiD3PziPmaLIh7c9MKcMZPk49Cy5FE5v0jlVerHc8mfjdcHiekmHsUXnAM0BRrTmU68yp93AD2hSoYPJu5IwcMtnZQk/70AwV3xepamVhJqFyjqZ42LBq6Y0DaT5cIT8xmq7rYAVudSGGQOLKFbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout2.hostsharing.net (Postfix) with UTF8SMTPS id E76592C1E673;
	Fri, 29 Aug 2025 09:50:59 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id BB388600AD9B;
	Fri, 29 Aug 2025 09:50:59 +0200 (CEST)
X-Mailbox-Line: From 3d6f5aa8634bd4d13f28b7ec6b1b8d8d474e3c69 Mon Sep 17 00:00:00 2001
Message-ID: <3d6f5aa8634bd4d13f28b7ec6b1b8d8d474e3c69.1756451884.git.lukas@wunner.de>
In-Reply-To: <cover.1756451884.git.lukas@wunner.de>
References: <cover.1756451884.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 29 Aug 2025 09:25:04 +0200
Subject: [PATCH 4/4] PCI/ERR: Tidy documentation's PCIe nomenclature
To: Bjorn Helgaas <helgaas@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Terry Bowman <terry.bowman@amd.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Linas Vepstas <linasvepstas@gmail.com>, "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, "Oliver OHalloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, Brian Norris <briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Commit 11502feab423 ("Documentation: PCI: Tidy AER documentation")
replaced the terms "PCI-E", "PCI-Express" and "PCI Express" with "PCIe"
in the AER documentation.

Do the same in the documentation on PCI error recovery.  While at it,
add a missing period and a missing blank.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 Documentation/PCI/pci-error-recovery.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
index c88c304b2103..500d4e9b2143 100644
--- a/Documentation/PCI/pci-error-recovery.rst
+++ b/Documentation/PCI/pci-error-recovery.rst
@@ -13,7 +13,7 @@ PCI Error Recovery
 Many PCI bus controllers are able to detect a variety of hardware
 PCI errors on the bus, such as parity errors on the data and address
 buses, as well as SERR and PERR errors.  Some of the more advanced
-chipsets are able to deal with these errors; these include PCI-E chipsets,
+chipsets are able to deal with these errors; these include PCIe chipsets,
 and the PCI-host bridges found on IBM Power4, Power5 and Power6-based
 pSeries boxes. A typical action taken is to disconnect the affected device,
 halting all I/O to it.  The goal of a disconnection is to avoid system
@@ -206,7 +206,7 @@ reset or some such, but not restart operations. This callback is made if
 all drivers on a segment agree that they can try to recover and if no automatic
 link reset was performed by the HW. If the platform can't just re-enable IOs
 without a slot reset or a link reset, it will not call this callback, and
-instead will have gone directly to STEP 3 (Link Reset) or STEP 4 (Slot Reset)
+instead will have gone directly to STEP 3 (Link Reset) or STEP 4 (Slot Reset).
 
 .. note::
 
@@ -258,14 +258,14 @@ The driver should return one of the following result codes:
 
 The next step taken depends on the results returned by the drivers.
 If all drivers returned PCI_ERS_RESULT_RECOVERED, then the platform
-proceeds to either STEP3 (Link Reset) or to STEP 5 (Resume Operations).
+proceeds to either STEP 3 (Link Reset) or to STEP 5 (Resume Operations).
 
 If any driver returned PCI_ERS_RESULT_NEED_RESET, then the platform
 proceeds to STEP 4 (Slot Reset)
 
 STEP 3: Link Reset
 ------------------
-The platform resets the link.  This is a PCI-Express specific step
+The platform resets the link.  This is a PCIe specific step
 and is done whenever a fatal error has been detected that can be
 "solved" by resetting the link.
 
@@ -287,13 +287,13 @@ that is equivalent to what it would be after a fresh system
 power-on followed by power-on BIOS/system firmware initialization.
 Soft reset is also known as hot-reset.
 
-Powerpc fundamental reset is supported by PCI Express cards only
+Powerpc fundamental reset is supported by PCIe cards only
 and results in device's state machines, hardware logic, port states and
 configuration registers to initialize to their default conditions.
 
 For most PCI devices, a soft reset will be sufficient for recovery.
 Optional fundamental reset is provided to support a limited number
-of PCI Express devices for which a soft reset is not sufficient
+of PCIe devices for which a soft reset is not sufficient
 for recovery.
 
 If the platform supports PCI hotplug, then the reset might be
@@ -337,7 +337,7 @@ Result codes:
 	- PCI_ERS_RESULT_DISCONNECT
 	  Same as above.
 
-Drivers for PCI Express cards that require a fundamental reset must
+Drivers for PCIe cards that require a fundamental reset must
 set the needs_freset bit in the pci_dev structure in their probe function.
 For example, the QLogic qla2xxx driver sets the needs_freset bit for certain
 PCI card types::
-- 
2.47.2


