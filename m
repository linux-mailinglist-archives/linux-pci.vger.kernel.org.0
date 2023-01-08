Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE206618FE
	for <lists+linux-pci@lfdr.de>; Sun,  8 Jan 2023 21:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjAHUAM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Jan 2023 15:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjAHT7x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Jan 2023 14:59:53 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEB45DBA
        for <linux-pci@vger.kernel.org>; Sun,  8 Jan 2023 11:59:52 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id C996192009C; Sun,  8 Jan 2023 20:59:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id C290592009B;
        Sun,  8 Jan 2023 19:59:49 +0000 (GMT)
Date:   Sun, 8 Jan 2023 19:59:49 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND^3][PATCH v3] x86/PCI: Add support for the Intel 82378ZB/82379AB
 (SIO/SIO.A) PIRQ router
Message-ID: <alpine.DEB.2.21.2301081956290.65308@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
one of 0x3, 0x43, or 0x84, so the masking of the high nibble seems 
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
Hi,

 This patch was dropped from x86/irq due to a bug in a follow-up patch and 
when resent it was not re-picked up along with the other patches for some 
reason.  It applies unchanged to 6.2.0-rc3.

 Please apply.

  Maciej

Changes from v2:

- Regenerate for a merge conflict.

Changes from v1:

- Add [PATCH] annotation (umm...).

- Fix RID values listed to include 0x84 rather than 0x83 (braino).
---
 arch/x86/pci/irq.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

linux-x86-pirq-router-sio.diff
Index: linux-macro/arch/x86/pci/irq.c
===================================================================
--- linux-macro.orig/arch/x86/pci/irq.c
+++ linux-macro/arch/x86/pci/irq.c
@@ -974,11 +974,18 @@ static __init int intel_router_probe(str
 		return 0;
 
 	switch (device) {
+		u8 rid;
 	case PCI_DEVICE_ID_INTEL_82375:
 		r->name = "PCEB/ESC";
 		r->get = pirq_esc_get;
 		r->set = pirq_esc_set;
 		return 1;
+	case PCI_DEVICE_ID_INTEL_82378:
+		pci_read_config_byte(router, PCI_REVISION_ID, &rid);
+		/* Tell 82378IB (rev < 3) and 82378ZB/82379AB apart.  */
+		if ((rid & 0xfu) < 3)
+			break;
+		fallthrough;
 	case PCI_DEVICE_ID_INTEL_82371FB_0:
 	case PCI_DEVICE_ID_INTEL_82371SB_0:
 	case PCI_DEVICE_ID_INTEL_82371AB_0:
@@ -1020,7 +1027,7 @@ static __init int intel_router_probe(str
 	case PCI_DEVICE_ID_INTEL_ICH10_3:
 	case PCI_DEVICE_ID_INTEL_PATSBURG_LPC_0:
 	case PCI_DEVICE_ID_INTEL_PATSBURG_LPC_1:
-		r->name = "PIIX/ICH";
+		r->name = "SIO/PIIX/ICH";
 		r->get = pirq_piix_get;
 		r->set = pirq_piix_set;
 		return 1;
@@ -1039,7 +1046,7 @@ static __init int intel_router_probe(str
 	     device <= PCI_DEVICE_ID_INTEL_DH89XXCC_LPC_MAX)
 	||  (device >= PCI_DEVICE_ID_INTEL_PANTHERPOINT_LPC_MIN &&
 	     device <= PCI_DEVICE_ID_INTEL_PANTHERPOINT_LPC_MAX)) {
-		r->name = "PIIX/ICH";
+		r->name = "SIO/PIIX/ICH";
 		r->get = pirq_piix_get;
 		r->set = pirq_piix_set;
 		return 1;
