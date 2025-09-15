Return-Path: <linux-pci+bounces-36163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B19F1B57E97
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 16:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E7764E2133
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 14:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D35632779E;
	Mon, 15 Sep 2025 14:15:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD3231E0FD;
	Mon, 15 Sep 2025 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757945706; cv=none; b=Wttm8MNb4khAmiYzG/pPOnO62lQAQZ/u+QZ6AxFrdi3Nhbz3wI5670sVsvelDqgSsUdpGghUh9OyOZt7dNK7BHudDeW/8VO/XL4vR730g5UAhpYFCA+tw/lM2/I672AlXas1DjXpA3pblR5xE6CbXBX6z2VYuNQD/gct2tHjYYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757945706; c=relaxed/simple;
	bh=sPlgb5C0dRuGY2lOrGS8QC8NM42rTxF7AHxr9i8RJIo=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=KVUSPPx+7ahFsmsZgwIRR0oVLXoPIVwHm55+f0mpAp0A/O5M6sAY8b19+1h9aziNKRbL7awgZM4NOZd18g6R/BSbf+MI0PBwbbowNNRfnFW+X4vlE2dWXSW+Qak0D3sooXZpOoOZQ0lE07+iXVVbL38E9cPOaB5zNP/QCkK44/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout2.hostsharing.net (Postfix) with UTF8SMTPS id 314CF2C1E4C1;
	Mon, 15 Sep 2025 16:15:02 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id 12834600B5BC;
	Mon, 15 Sep 2025 16:15:02 +0200 (CEST)
X-Mailbox-Line: From 61d8eeadb20ee71c3a852f44c863bfe0209c454d Mon Sep 17 00:00:00 2001
Message-ID: <61d8eeadb20ee71c3a852f44c863bfe0209c454d.1757942121.git.lukas@wunner.de>
In-Reply-To: <cover.1757942121.git.lukas@wunner.de>
References: <cover.1757942121.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 15 Sep 2025 15:50:03 +0200
Subject: [PATCH v2 3/4] Documentation: PCI: Amend error recovery doc with
 DPC/AER specifics
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
  ->mmio_enabled() callback for compatibility with EEH on powerpc and with
  s390.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Brian Norris <briannorris@chromium.org>
---
 Documentation/PCI/pci-error-recovery.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
index d5c661baa87f..9e1e2f2a13fa 100644
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
@@ -204,6 +208,24 @@ link reset was performed by the HW. If the platform can't just re-enable IOs
 without a slot reset or a link reset, it will not call this callback, and
 instead will have gone directly to STEP 3 (Link Reset) or STEP 4 (Slot Reset)
 
+.. note::
+
+   On platforms supporting Advanced Error Reporting (PCIe r7.0 sec 6.2),
+   the faulting device may already be accessible in STEP 1 (Notification).
+   Drivers should nevertheless defer accesses to STEP 2 (MMIO Enabled)
+   to be compatible with EEH on powerpc and with s390 (where devices are
+   inaccessible until STEP 2).
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
2.51.0


