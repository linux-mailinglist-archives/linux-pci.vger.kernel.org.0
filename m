Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A7E1A8634
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 18:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391897AbgDNQzW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 12:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407501AbgDNQtI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:08 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBDDF21734;
        Tue, 14 Apr 2020 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882942;
        bh=0BnJSftuUBqhmdRzeJYG8vzypho0PIEfncwKqSh7oyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f90DO2kKSJSFPfSJklC/NQUf50ZmxxG5CyWXyV40uYwiEn0YMyRLl3o0vgrCiWFgS
         s0XIojPWf3zjpO+DoRZ9QEJ7RWqhVR5FHGFZoteImH6fw3ZUqzRO8y6MxyoaAFsTtO
         P/5UFvfKKfwgpGOm8bkqdhChlf5tsLWzI9Gv2ETE=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk8-0068ly-W6; Tue, 14 Apr 2020 18:49:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v2 14/33] docs: pci: boot-interrupts.rst: improve html output
Date:   Tue, 14 Apr 2020 18:48:40 +0200
Message-Id: <a6a9eb16eede10731bcce69a600ab12d92e6ba47.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are some warnings with this file:

    /Documentation/PCI/boot-interrupts.rst:42: WARNING: Unexpected indentation.
    /Documentation/PCI/boot-interrupts.rst:52: WARNING: Block quote ends without a blank line; unexpected unindent.
    /Documentation/PCI/boot-interrupts.rst:92: WARNING: Unexpected indentation.
    /Documentation/PCI/boot-interrupts.rst:98: WARNING: Unexpected indentation.
    /Documentation/PCI/boot-interrupts.rst:136: WARNING: Unexpected indentation.

It turns that this file conversion to ReST could be improved,
in order to remove the warnings and provide a better output.

So, fix the warnings by adjusting blank lines, add a table and
some list markups. Also, mark endnodes as such.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/PCI/boot-interrupts.rst | 34 +++++++++++++++------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/Documentation/PCI/boot-interrupts.rst b/Documentation/PCI/boot-interrupts.rst
index d078ef3eb192..2ec70121bfca 100644
--- a/Documentation/PCI/boot-interrupts.rst
+++ b/Documentation/PCI/boot-interrupts.rst
@@ -32,12 +32,13 @@ interrupt goes unhandled over time, they are tracked by the Linux kernel as
 Spurious Interrupts. The IRQ will be disabled by the Linux kernel after it
 reaches a specific count with the error "nobody cared". This disabled IRQ
 now prevents valid usage by an existing interrupt which may happen to share
-the IRQ line.
+the IRQ line::
 
   irq 19: nobody cared (try booting with the "irqpoll" option)
   CPU: 0 PID: 2988 Comm: irq/34-nipalk Tainted: 4.14.87-rt49-02410-g4a640ec-dirty #1
   Hardware name: National Instruments NI PXIe-8880/NI PXIe-8880, BIOS 2.1.5f1 01/09/2020
   Call Trace:
+
   <IRQ>
    ? dump_stack+0x46/0x5e
    ? __report_bad_irq+0x2e/0xb0
@@ -85,15 +86,18 @@ Mitigations
 The mitigations take the form of PCI quirks. The preference has been to
 first identify and make use of a means to disable the routing to the PCH.
 In such a case a quirk to disable boot interrupt generation can be
-added.[1]
+added. [1]_
 
-  Intel® 6300ESB I/O Controller Hub
+Intel® 6300ESB I/O Controller Hub
   Alternate Base Address Register:
    BIE: Boot Interrupt Enable
-	  0 = Boot interrupt is enabled.
-	  1 = Boot interrupt is disabled.
 
-  Intel® Sandy Bridge through Sky Lake based Xeon servers:
+	  ==  ===========================
+	  0   Boot interrupt is enabled.
+	  1   Boot interrupt is disabled.
+	  ==  ===========================
+
+Intel® Sandy Bridge through Sky Lake based Xeon servers:
   Coherent Interface Protocol Interrupt Control
    dis_intx_route2pch/dis_intx_route2ich/dis_intx_route2dmi2:
 	  When this bit is set. Local INTx messages received from the
@@ -109,12 +113,12 @@ line by default.  Therefore, on chipsets where this INTx routing cannot be
 disabled, the Linux kernel will reroute the valid interrupt to its legacy
 interrupt. This redirection of the handler will prevent the occurrence of
 the spurious interrupt detection which would ordinarily disable the IRQ
-line due to excessive unhandled counts.[2]
+line due to excessive unhandled counts. [2]_
 
 The config option X86_REROUTE_FOR_BROKEN_BOOT_IRQS exists to enable (or
 disable) the redirection of the interrupt handler to the PCH interrupt
 line. The option can be overridden by either pci=ioapicreroute or
-pci=noioapicreroute.[3]
+pci=noioapicreroute. [3]_
 
 
 More Documentation
@@ -127,19 +131,19 @@ into the evolution of its handling with chipsets.
 Example of disabling of the boot interrupt
 ------------------------------------------
 
-Intel® 6300ESB I/O Controller Hub (Document # 300641-004US)
+      - Intel® 6300ESB I/O Controller Hub (Document # 300641-004US)
 	5.7.3 Boot Interrupt
 	https://www.intel.com/content/dam/doc/datasheet/6300esb-io-controller-hub-datasheet.pdf
 
-Intel® Xeon® Processor E5-1600/2400/2600/4600 v3 Product Families
-Datasheet - Volume 2: Registers (Document # 330784-003)
+      - Intel® Xeon® Processor E5-1600/2400/2600/4600 v3 Product Families
+	Datasheet - Volume 2: Registers (Document # 330784-003)
 	6.6.41 cipintrc Coherent Interface Protocol Interrupt Control
 	https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-e5-v3-datasheet-vol-2.pdf
 
 Example of handler rerouting
 ----------------------------
 
-Intel® 6700PXH 64-bit PCI Hub (Document # 302628)
+      - Intel® 6700PXH 64-bit PCI Hub (Document # 302628)
 	2.15.2 PCI Express Legacy INTx Support and Boot Interrupt
 	https://www.intel.com/content/dam/doc/datasheet/6700pxh-64-bit-pci-hub-datasheet.pdf
 
@@ -150,6 +154,6 @@ Cheers,
     Sean V Kelley
     sean.v.kelley@linux.intel.com
 
-[1] https://lore.kernel.org/r/12131949181903-git-send-email-sassmann@suse.de/
-[2] https://lore.kernel.org/r/12131949182094-git-send-email-sassmann@suse.de/
-[3] https://lore.kernel.org/r/487C8EA7.6020205@suse.de/
+.. [1] https://lore.kernel.org/r/12131949181903-git-send-email-sassmann@suse.de/
+.. [2] https://lore.kernel.org/r/12131949182094-git-send-email-sassmann@suse.de/
+.. [3] https://lore.kernel.org/r/487C8EA7.6020205@suse.de/
-- 
2.25.2

