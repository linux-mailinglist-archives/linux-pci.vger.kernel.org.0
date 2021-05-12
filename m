Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A67F37BD29
	for <lists+linux-pci@lfdr.de>; Wed, 12 May 2021 14:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhELMxW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 May 2021 08:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231656AbhELMxD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 May 2021 08:53:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 341C7616E9;
        Wed, 12 May 2021 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823903;
        bh=mv6LmDTZqB4qEwkep20CW6JiwxGthmk9rWUgZqXguUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Opzo/UinbtsUDqpCoqHHa/hUCkxHRYzGhLgk5+vbTCrlxx5DhB3lzwTkOCVO4KE0a
         RXJrtIXVRHvGOhRgPqUpH0vSpAm2NfJ7wnmH+FDSayB6Woa7459CZNOJS2P8r4574Y
         YIaoXMgFw6J5GdBqzh4wETPmsFq8yWll/uYXkiDkykXCjsNp3kjHj0HCaQglU8S82e
         P7TPBXi6Y3aTGFvAP3CvzJXEE7pCWNgBZhv1rnm2r5pO9Qgt0+cE5Ft4dIBgK1gydR
         ZPqxa29MonxKpPXf2bMq5yUTkzY35+gLUrkOovy10J4swuw8m4S5ROIMYm0rNeshgH
         iUx6YiQwRb4Pw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoKz-0018io-CU; Wed, 12 May 2021 14:51:41 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH v2 31/40] docs: PCI: acpi-info.rst: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:35 +0200
Message-Id: <7fd9d4360a3d0f761b169b95d9997f4f5d06319c.1620823573.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620823573.git.mchehab+huawei@kernel.org>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The conversion tools used during DocBook/LaTeX/Markdown->ReST conversion
and some automatic rules which exists on certain text editors like
LibreOffice turned ASCII characters into some UTF-8 alternatives that
are better displayed on html and PDF.

While it is OK to use UTF-8 characters in Linux, it is better to
use the ASCII subset instead of using an UTF-8 equivalent character
as it makes life easier for tools like grep, and are easier to edit
with the some commonly used text/source code editors.

Also, Sphinx already do such conversion automatically outside literal blocks:
   https://docutils.sourceforge.io/docs/user/smartquotes.html

So, replace the occurences of the following UTF-8 characters:

	- U+00a0 (' '): NO-BREAK SPACE
	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/PCI/acpi-info.rst | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/PCI/acpi-info.rst b/Documentation/PCI/acpi-info.rst
index 060217081c79..30d0fc85dd8e 100644
--- a/Documentation/PCI/acpi-info.rst
+++ b/Documentation/PCI/acpi-info.rst
@@ -22,9 +22,9 @@ or if the device has INTx interrupts connected by platform interrupt
 controllers and a _PRT is needed to describe those connections.
 
 ACPI resource description is done via _CRS objects of devices in the ACPI
-namespace [2].   The _CRS is like a generalized PCI BAR: the OS can read
+namespace [2].   The _CRS is like a generalized PCI BAR: the OS can read
 _CRS and figure out what resource is being consumed even if it doesn't have
-a driver for the device [3].  That's important because it means an old OS
+a driver for the device [3].  That's important because it means an old OS
 can work correctly even on a system with new devices unknown to the OS.
 The new devices might not do anything, but the OS can at least make sure no
 resources conflict with them.
@@ -41,15 +41,15 @@ ACPI, that device will have a specific _HID/_CID that tells the OS what
 driver to bind to it, and the _CRS tells the OS and the driver where the
 device's registers are.
 
-PCI host bridges are PNP0A03 or PNP0A08 devices.  Their _CRS should
-describe all the address space they consume.  This includes all the windows
+PCI host bridges are PNP0A03 or PNP0A08 devices.  Their _CRS should
+describe all the address space they consume.  This includes all the windows
 they forward down to the PCI bus, as well as registers of the host bridge
-itself that are not forwarded to PCI.  The host bridge registers include
+itself that are not forwarded to PCI.  The host bridge registers include
 things like secondary/subordinate bus registers that determine the bus
 range below the bridge, window registers that describe the apertures, etc.
 These are all device-specific, non-architected things, so the only way a
 PNP0A03/PNP0A08 driver can manage them is via _PRS/_CRS/_SRS, which contain
-the device-specific details.  The host bridge registers also include ECAM
+the device-specific details.  The host bridge registers also include ECAM
 space, since it is consumed by the host bridge.
 
 ACPI defines a Consumer/Producer bit to distinguish the bridge registers
@@ -66,7 +66,7 @@ the PNP0A03/PNP0A08 device itself.  The workaround was to describe the
 bridge registers (including ECAM space) in PNP0C02 catch-all devices [6].
 With the exception of ECAM, the bridge register space is device-specific
 anyway, so the generic PNP0A03/PNP0A08 driver (pci_root.c) has no need to
-know about it.  
+know about it.  
 
 New architectures should be able to use "Consumer" Extended Address Space
 descriptors in the PNP0A03 device for bridge registers, including ECAM,
@@ -75,9 +75,9 @@ ia64 kernels assume all address space descriptors, including "Consumer"
 Extended Address Space ones, are windows, so it would not be safe to
 describe bridge registers this way on those architectures.
 
-PNP0C02 "motherboard" devices are basically a catch-all.  There's no
+PNP0C02 "motherboard" devices are basically a catch-all.  There's no
 programming model for them other than "don't use these resources for
-anything else."  So a PNP0C02 _CRS should claim any address space that is
+anything else."  So a PNP0C02 _CRS should claim any address space that is
 (1) not claimed by _CRS under any other device object in the ACPI namespace
 and (2) should not be assigned by the OS to something else.
 
@@ -125,7 +125,7 @@ address always corresponds to bus 0, even if the bus range below the bridge
     requirements of the device.  It may also call _CRS to find the current
     resource settings for the device.  Using this information, the Plug and
     Play system determines what resources the device should consume and
-    sets those resources by calling the device’s _SRS control method.
+    sets those resources by calling the device's _SRS control method.
 
     In ACPI, devices can consume resources (for example, legacy keyboards),
     provide resources (for example, a proprietary PCI bridge), or do both.
@@ -156,7 +156,7 @@ address always corresponds to bus 0, even if the bus range below the bridge
     4.1.3) must be reserved by declaring a motherboard resource.  For most
     systems, the motherboard resource would appear at the root of the ACPI
     namespace (under \_SB) in a node with a _HID of EISAID (PNP0C02), and
-    the resources in this case should not be claimed in the root PCI bus’s
+    the resources in this case should not be claimed in the root PCI bus's
     _CRS.  The resources can optionally be returned in Int15 E820 or
     EFIGetMemoryMap as reserved memory but must always be reported through
     ACPI as a motherboard resource.
-- 
2.30.2

