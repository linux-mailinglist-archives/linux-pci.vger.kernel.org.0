Return-Path: <linux-pci+bounces-35087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7554AB3B4B1
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 09:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14103A00101
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 07:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8027A285041;
	Fri, 29 Aug 2025 07:49:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5161C27B34D;
	Fri, 29 Aug 2025 07:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453777; cv=none; b=LSVnVXxK5NB7JZpl+hRqsc8RoGT0kUJIvRvdkPlEw8vDHCvJ6E5FNeAg860MpDRpAu+J2IiS12TTGiSdmA+LbYv8Kvfw57oZqDo90IHgClJ64Bxn7StFpwK9O7Z34f/Rx8u6Z/t4kMbliZHrBIcxChJZHROqjtdAhbWk9rBZdG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453777; c=relaxed/simple;
	bh=tNVfBmsOQ30Ro/5Snfj58l7dAXJOKTfbl7jqynCLuPI=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=Q0HFJaoKiv95WGpejQTqgmbLs1Z9OD/8dbXY4N7InPzPbLQYdfGS2VSUatFkf+wU7/zcm77Lcq0ajt3fuQ/uBUgKbIo4MtAvYAsXfWPmgFI6ytxYIqWL76DePBUIvbB8K3wSv3/DFo8/OvP8q285RnJ+F3gXLSla89Txle8l88w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout2.hostsharing.net (Postfix) with UTF8SMTPS id 714142C1DF42;
	Fri, 29 Aug 2025 09:41:15 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id 45E1D600AD9B;
	Fri, 29 Aug 2025 09:41:15 +0200 (CEST)
X-Mailbox-Line: From 42726e2fd197959d6228d25552504353ffb53545 Mon Sep 17 00:00:00 2001
Message-ID: <42726e2fd197959d6228d25552504353ffb53545.1756451884.git.lukas@wunner.de>
In-Reply-To: <cover.1756451884.git.lukas@wunner.de>
References: <cover.1756451884.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 29 Aug 2025 09:25:03 +0200
Subject: [PATCH 3/4] PCI/ERR: Amend documentation with DPC and AER specifics
To: Bjorn Helgaas <helgaas@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Terry Bowman <terry.bowman@amd.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Linas Vepstas <linasvepstas@gmail.com>, "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, "Oliver OHalloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, Brian Norris <briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Amend the documentation on PCI error recovery with specifics about
Downstream Port Containment and Advanced Error Reporting:

* Explain that with DPC, devices are inaccessible upon an error (similar
  to EEH on powerpc) and do not become accessible until the link is
  re-enabled.

* Explain that with AER, although devices may already be accessible in the
  ->error_detected() callback, accesses should be deferred to the
  ->mmio_enabled() callback for compatibility with EEH on powerpc.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 Documentation/PCI/pci-error-recovery.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
index d5c661baa87f..c88c304b2103 100644
--- a/Documentation/PCI/pci-error-recovery.rst
+++ b/Documentation/PCI/pci-error-recovery.rst
@@ -122,6 +122,10 @@ A PCI bus error is detected by the PCI hardware.  On powerpc, the slot
 is isolated, in that all I/O is blocked: all reads return 0xffffffff,
 all writes are ignored.
 
+Similarly, on platforms supporting Downstream Port Containment
+(PCIe r7.0 sec 6.2.11), the link to the sub-hierarchy with the
+faulting device is disabled. Any device in the sub-hierarchy
+becomes inaccessible.
 
 STEP 1: Notification
 --------------------
@@ -204,6 +208,23 @@ link reset was performed by the HW. If the platform can't just re-enable IOs
 without a slot reset or a link reset, it will not call this callback, and
 instead will have gone directly to STEP 3 (Link Reset) or STEP 4 (Slot Reset)
 
+.. note::
+
+   On platforms supporting Advanced Error Reporting (PCIe r7.0 sec 6.2),
+   the faulting device may already be accessible in STEP 1 (Notification).
+   Drivers should nevertheless defer accesses to STEP 2 (MMIO Enabled)
+   to be compatible with EEH on powerpc.
+
+   On platforms supporting Downstream Port Containment, the link to the
+   sub-hierarchy with the faulting device is re-enabled in STEP 3 (Link
+   Reset). Hence devices in the sub-hierarchy are inaccessible until
+   STEP 4 (Slot Reset).
+
+   For errors such as Surprise Down (PCIe r7.0 sec 6.2.7), the device
+   may not even be accessible in STEP 4 (Slot Reset). Drivers can detect
+   accessibility by checking whether reads from the device return all 1's
+   (PCI_POSSIBLE_ERROR()).
+
 .. note::
 
    The following is proposed; no platform implements this yet:
-- 
2.47.2


