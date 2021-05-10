Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9E9378253
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 12:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhEJKeK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 06:34:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231286AbhEJKcN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 May 2021 06:32:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4894B61955;
        Mon, 10 May 2021 10:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642444;
        bh=XM8sbtItyCjg0/D7/5NtirZjDDciz/hU+kLW8TPxHc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gL3eKMzrzVR/wDexNcBfJcxblvFQ/5VDZwupqh4DQ3Lcyaf2T67Lb5CQXExS+oQOe
         +qUycOTiJWcKBHO3iYUtp6EY/fnIAhW7HHSVdgiIn2rS89+a7o8DjXXScckkatYddi
         szFP/P9qjR1p9vfgRrkALWrSFCE4V6glrbi+0HHV6v0q6YNAMZe1b5VCbpNfAWWHQt
         eDVRnUWjpmJh8uF9K2ZU0Ptfr4Ct98IBeyZx3KRSldHXeoGaec7gr3KhqPgd48JBzu
         L5l901djwb0Vb2+/P4xwico/AcC9zMofgnl2Ep/2iSQVZ1MJLuZA/7jIfuTyAYxBSp
         pXIpnmwsBVLRQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38E-000UR6-Ct; Mon, 10 May 2021 12:27:22 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 43/53] docs: PCI: acpi-info.rst: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:55 +0200
Message-Id: <94842f2c0062c71b53144e55c648ec18fdde8eca.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
So, replace the occurences of the following UTF-8 characters:

	- U+00a0 (' '): NO-BREAK SPACE
	- U+2013 ('–'): EN DASH
	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/PCI/acpi-info.rst | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/PCI/acpi-info.rst b/Documentation/PCI/acpi-info.rst
index 060217081c79..9b4b04039982 100644
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
@@ -140,8 +140,8 @@ address always corresponds to bus 0, even if the bus range below the bridge
     Extended Address Space Descriptor (.4)
       General Flags: Bit [0] Consumer/Producer:
 
-        * 1 – This device consumes this resource
-        * 0 – This device produces and consumes this resource
+        * 1 - This device consumes this resource
+        * 0 - This device produces and consumes this resource
 
 [5] ACPI 6.2, sec 19.6.43:
     ResourceUsage specifies whether the Memory range is consumed by
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

