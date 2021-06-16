Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A943A934D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 08:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhFPG50 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 02:57:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231620AbhFPG5Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 02:57:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42F47613E9;
        Wed, 16 Jun 2021 06:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623826518;
        bh=97U96sWHfpw5buBpfC2VHMECZ3YW56BbYE8wINfNMTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fJnphnkWoFyzhlV7/4xjXR9kAyXdXWghQKAqnwIV/NEAKYrW8w387L/nbOOj3Rbjx
         ohWXd1avPhrhkkfEUL075Y7+wRuMqp4+QZ/05vqbgV68wEnAwr4HcBio7jJTc779xz
         fE5koBtP+QuGs2l5XZKzeTba0bFJyCdYTD8REC2zDMJEqGl9/+5MhTiTpi6zpDlPFm
         WFu43nPfmBedqU2MZahpi6HNnOaurP66wqL2HMd5a+VrdLTLCZZa5/9R6gM+VS1njt
         fUh5AK0ybc8HtTVJk/L+qmfB4/Wszh/awfxaPAKbXd/Aaa2b7oTJORm9mUl0D/QBps
         i/9NxLCSm7syw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltPSG-004lCj-JY; Wed, 16 Jun 2021 08:55:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 8/8] docs: PCI: Replace non-breaking spaces to avoid PDF issues
Date:   Wed, 16 Jun 2021 08:55:14 +0200
Message-Id: <8036126a59adb720dbc9233341ad5a08531cf73f.1623826294.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623826294.git.mchehab+huawei@kernel.org>
References: <cover.1623826294.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The conversion tools used during DocBook/LaTeX/html/Markdown->ReST
conversion and some cut-and-pasted text contain some characters that
aren't easily reachable on standard keyboards and/or could cause
troubles when parsed by the documentation build system.

Replace the occurences of the following characters:

	- U+00a0 (' '): NO-BREAK SPACE
	  as it can cause lines being truncated on PDF output

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/PCI/acpi-info.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/PCI/acpi-info.rst b/Documentation/PCI/acpi-info.rst
index 060217081c79..34c64a5a66ec 100644
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
 
-- 
2.31.1

