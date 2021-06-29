Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409293B7961
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jun 2021 22:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbhF2UbU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Jun 2021 16:31:20 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:60160 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbhF2UbU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jun 2021 16:31:20 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 5CE6792009C; Tue, 29 Jun 2021 22:28:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 56D5692009B;
        Tue, 29 Jun 2021 22:28:50 +0200 (CEST)
Date:   Tue, 29 Jun 2021 22:28:50 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: x86/PCI: Add support for the Intel 82378ZB/82379AB (SIO/SIO.A) PIRQ
 router
Message-ID: <alpine.DEB.2.21.2106272338180.37803@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Intel 82378ZB System I/O (SIO) and 82379AB System I/O APIC (SIO.A) 
ISA bridges implement PCI interrupt steering with a PIRQ router[1][2] 
that is exactly the same as that of the PIIX and ICH southbridges (or 
actually the other way round, given that the SIO ASIC was there first).

An earlier version of the SIO, the 82378IB[3][4], does not implement PCI 
interrupt steering however, so we need to exclude it by checking the low 
nibble of the PCI Revision Identification Register[5][6] for being at 
least 3.

There is a note in the 82379AB specification update[7] saying that the 
device ID for that chip is 0x7, rather than 0x484 as stated in the 
datasheet[8].  It looks like a red herring however, for no report has 
been ever seen with that value quoted and it matches the documented 
default value of the PCI Command Register, which comes next after the 
PCI Device Identification Register, so it looks like a copy-&-paste 
editorial mistake.

NB the 82378ZB has been commonly used with smaller DEC Alpha systems 
with the contents of the Revision Identification Register reported as 
one of 0x3, 0x43, or 0x83, so the masking of the high nibble seems 
indeed right by empirical observation.  The value in the high nibble 
might be either random, or depend on the batch, or correspond to some 
other state such as reset straps.

References:

[1] "82378 System I/O (SIO)", Intel Corporation, Order Number: 
    290473-004, December 1994, Section 4.1.26 "PIRQ[3:0]#--PIRQ Route 
    Control Registers"

[2] "82378ZB System I/O (SIO) and 82379AB System I/O APIC (SIO.A)",
    Intel Corporation, Order Number: 290571-001, March 1996, Section 
    3.1.25. "PIRQ[3:0]#--PIRQ Route Control Registers", p. 48

[3] "82378IB System I/O (SIO)", Intel Corporation, Order Number:
    290473-002, April 1993, Section 5.8.7.7 "Edge and Level Triggered
    Modes"

[4] "82378IB to 82378ZB Errata Fix and Feature Enhancement Conversion
    FOL933002-01",
    <https://web.archive.org/web/19990421045433/http://support.intel.com/support/chipsets/420/8511.htm>

[5] "82378 System I/O (SIO)", Intel Corporation, Order Number: 
    290473-004, December 1994, Section 4.1.5. "RID--Revision 
    Identification Register"

[6] "82378ZB System I/O (SIO) and 82379AB System I/O APIC (SIO.A)",
    Intel Corporation, Order Number: 290571-001, March 1996, Section 
    3.1.5. "RID--Revision Identification Register", p. 34

[7] "Intel 82379AB (SIO.A) System I/O Component Specification Update", 
    Intel Corporation, Order Number: 297734-001, May, 1996, "Component 
    Identification via Programming Interface", p. 5

[8] "82378ZB System I/O (SIO) and 82379AB System I/O APIC (SIO.A)",
    Intel Corporation, Order Number: 290571-001, March 1996, Section 
    3.1.2. "DID--Device Identification Register", p. 33

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 arch/x86/pci/irq.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

linux-x86-pirq-router-sio.diff
Index: linux-macro-ide/arch/x86/pci/irq.c
===================================================================
--- linux-macro-ide.orig/arch/x86/pci/irq.c
+++ linux-macro-ide/arch/x86/pci/irq.c
@@ -627,6 +627,13 @@ static __init int intel_router_probe(str
 		return 0;
 
 	switch (device) {
+		u8 rid;
+	case PCI_DEVICE_ID_INTEL_82378:
+		pci_read_config_byte(router, PCI_REVISION_ID, &rid);
+		/* Tell 82378IB (rev < 3) and 82378ZB/82379AB apart.  */
+		if ((rid & 0xfu) < 3)
+			break;
+		fallthrough;
 	case PCI_DEVICE_ID_INTEL_82371FB_0:
 	case PCI_DEVICE_ID_INTEL_82371SB_0:
 	case PCI_DEVICE_ID_INTEL_82371AB_0:
@@ -668,7 +675,7 @@ static __init int intel_router_probe(str
 	case PCI_DEVICE_ID_INTEL_ICH10_3:
 	case PCI_DEVICE_ID_INTEL_PATSBURG_LPC_0:
 	case PCI_DEVICE_ID_INTEL_PATSBURG_LPC_1:
-		r->name = "PIIX/ICH";
+		r->name = "SIO/PIIX/ICH";
 		r->get = pirq_piix_get;
 		r->set = pirq_piix_set;
 		return 1;
@@ -682,7 +689,7 @@ static __init int intel_router_probe(str
 	     device <= PCI_DEVICE_ID_INTEL_DH89XXCC_LPC_MAX)
 	||  (device >= PCI_DEVICE_ID_INTEL_PANTHERPOINT_LPC_MIN &&
 	     device <= PCI_DEVICE_ID_INTEL_PANTHERPOINT_LPC_MAX)) {
-		r->name = "PIIX/ICH";
+		r->name = "SIO/PIIX/ICH";
 		r->get = pirq_piix_get;
 		r->set = pirq_piix_set;
 		return 1;
