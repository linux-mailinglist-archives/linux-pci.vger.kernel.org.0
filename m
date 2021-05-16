Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D226381DDD
	for <lists+linux-pci@lfdr.de>; Sun, 16 May 2021 12:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhEPKTz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 May 2021 06:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230306AbhEPKTw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 16 May 2021 06:19:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67143611AD;
        Sun, 16 May 2021 10:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621160317;
        bh=SHZV8r4pjkW40YyRuQWZWEnGPljHHQ0H17rp3banAMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kEVCLFtDrc2jFijAFjMXQV3jVpiUHzeA8WMKzpAEjLqZQ/SbySRJhPYN8+8H9Wblc
         ECNqQXkeDSUW4ZgwhZkAyArFOnnsrxYSQ4Vk/guPkWSafmSZV3bR24DR6WzgNkruJN
         9cUlA6jubKsaLGEjd6wr7EMy8OKdhOxWG7P3vXqISC/zZABoZYO8uIIy3ZnqDNhxSQ
         RkIgDQK2CwXZpa/hDUfVp/gK8PgPICBhfW6imJVcipRMmQQFPGRHPe3VMYBzzzT8Rz
         DDll9Z6++RZHmbnDs2Dj7b1dQYdK1WJ49P5w1SnOE3HBXhMBYn893VetI/qgOAh7av
         b1nmsYBnWQCSA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1liDr1-003o8u-Kn; Sun, 16 May 2021 12:18:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v3 12/16] docs: PCI: acpi-info.rst: replace some characters
Date:   Sun, 16 May 2021 12:18:29 +0200
Message-Id: <320bafda201827dd63208af55b528ae63bcf8217.1621159997.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621159997.git.mchehab+huawei@kernel.org>
References: <cover.1621159997.git.mchehab+huawei@kernel.org>
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

