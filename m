Return-Path: <linux-pci+bounces-41891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35244C7B187
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 18:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D816E35B25D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 17:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A856C2F1FCB;
	Fri, 21 Nov 2025 17:36:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9B22DE6FE;
	Fri, 21 Nov 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763746606; cv=none; b=kP2/W1seM1BkMippoPkYwpJAL2x7D3IiJElCI7Oi9x1N+2GXmWSepVcaBGnok7y3/EUubBmOdmGK1GYwZMqzNg19y3gEZSjArZszuzBS6px9bUAGlUpPZ43XUglcBnHeePj0+LLPWNGYfCHfU9XipcHakCAXLd8DCRFYzTdIwnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763746606; c=relaxed/simple;
	bh=Sw4hPU3d8g90Q+gWpdnx+Rt25y2lnoQT5ZwnH2Nt+FQ=;
	h=Message-Id:From:Date:Subject:To:Cc; b=ab6ROfi97pFaR2674rAldcfg31VVE0QiPlFGfhflH2YTjDz0N/9zL3A/67LQOSnPt5rcIG/ePmHtSG1hU3TvvuWKVtq/gT1kYsjCISQgV2dtM7HV4bJ/aq5DKdIcAWNHKEEnrVCspt5byImitKyWwKgyO4qBRl3fXZRb4jsHP5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id E711E2C06AB8;
	Fri, 21 Nov 2025 18:31:16 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E0DFE1BE8B; Fri, 21 Nov 2025 18:31:16 +0100 (CET)
Message-Id: <077596ba70202be0e43fdad3bb9b93d356cbe4ec.1763746079.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 21 Nov 2025 18:31:17 +0100
Subject: [PATCH] Documentation: PCI: Amend error recovery doc with
 pci_save_state() rules
To: Bjorn Helgaas <helgaas@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Farhan Ali <alifm@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, Linas Vepstas <linasvepstas@gmail.com>, linux-doc@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

After recovering from a PCI error through reset, affected devices are in
D0_uninitialized state and need to be brought into D0_active state by
re-initializing their Config Space registers (PCIe r7.0 sec 5.3.1.1).

To facilitate that, the PCI core provides pci_restore_state() and
pci_save_state() helpers.  Document rules governing their usage.

As Bjorn notes, so far no file in "Documentation/ includes anything about
the idea of a driver using pci_save_state() to capture the state it wants
to restore after an error", even though it is a common pattern in drivers.
So that's obviously a gap that should be closed.

Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Closes: https://lore.kernel.org/r/20251113161556.GA2284238@bhelgaas/
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 Documentation/PCI/pci-error-recovery.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
index 5df481a..43bc4e3 100644
--- a/Documentation/PCI/pci-error-recovery.rst
+++ b/Documentation/PCI/pci-error-recovery.rst
@@ -326,6 +326,21 @@ be recovered, there is nothing more that can be done;  the platform
 will typically report a "permanent failure" in such a case.  The
 device will be considered "dead" in this case.
 
+Drivers typically need to call pci_restore_state() after reset to
+re-initialize the device's config space registers and thereby
+bring it from D0\ :sub:`uninitialized` into D0\ :sub:`active` state
+(PCIe r7.0 sec 5.3.1.1).  The PCI core invokes pci_save_state()
+on enumeration after initializing config space to ensure that a
+saved state is available for subsequent error recovery.
+Drivers which modify config space on probe may need to invoke
+pci_save_state() afterwards to record those changes for later
+error recovery.  When going into system suspend, pci_save_state()
+is called for every PCI device and that state will be restored
+not only on resume, but also on any subsequent error recovery.
+In the unlikely event that the saved state recorded on suspend
+is unsuitable for error recovery, drivers should call
+pci_save_state() on resume.
+
 Drivers for multi-function cards will need to coordinate among
 themselves as to which driver instance will perform any "one-shot"
 or global device initialization. For example, the Symbios sym53cxx2
-- 
2.51.0


