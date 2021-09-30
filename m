Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC21441E00F
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 19:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352539AbhI3RXY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 13:23:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51510 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352498AbhI3RXX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 13:23:23 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633022500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GA+E0IP9wAji4oISu6ACw4UTTLxZjlZyU/M+r1RXI64=;
        b=OocumTjfdzaeeXe2YA+xo/7eisqf9hhrMQrNELBYo4DoMtylhXK2VroKlyHU3f+sLL8DcC
        mrhoA97ju7OHSRlEQmoHnSfSboUw5SCKDEOnJqHvTPd7PTNNE/ewIkgfuOaVetUl611pQR
        0uphGDoRfXsL/vA8OKvNovBla6eTQ6d0r6TxCwt4vaxExX1P+evdfzuXNsbdjFW/FrVuZ2
        5v5XdeWSJW3Lau9VthhrhskdsC0ykl7r9oNe78Qil0vOhy4ww8J8j34szv9/SImVEhBQHH
        Sl2aRPgrrX0m3JICsNzY8fysZ5WY/PpT06dV2mtmqs4DdjW8C3nDLWRYWqRXXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633022500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GA+E0IP9wAji4oISu6ACw4UTTLxZjlZyU/M+r1RXI64=;
        b=KpC7FemuoCU3saAzexR+zyGtoKX5BgAflK7A4YyltKE2m3KAShvUyE7oCpPkEghC9tCght
        LRK2H2/B/J317TAg==
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        jose.souza@intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>, rudolph@fb.com,
        xapienz@fb.com, bmilton@fb.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Stable <stable@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Harry Pan <harry.pan@intel.com>
Subject: [PATCH RFT v2] x86/hpet: Use another crystalball to evaluate HPET
 usability
In-Reply-To: <87h7e26lh9.ffs@tglx>
References: <20210929160550.GA773748@bhelgaas> <87mtnu77mr.ffs@tglx>
 <87k0iy71rw.ffs@tglx>
 <CAJZ5v0hH_h9V0dACEMomqZbwpQUf6GB_8UK9+S1AGEdFQqvPLQ@mail.gmail.com>
 <87h7e26lh9.ffs@tglx>
Date:   Thu, 30 Sep 2021 19:21:39 +0200
Message-ID: <87czoq6kt8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On recent Intel systems the HPET stops working when the system reaches PC10
idle state.

The approach of adding PCI ids to the early quirks to disable HPET on
these systems is a whack a mole game which makes no sense.

Check for PC10 instead and force disable HPET if supported. The check is
overbroad as it does not take ACPI, intel_idle enablement and command
line parameters into account. That's fine as long as there is at least
PMTIMER available to calibrate the TSC frequency. The decision can be
overruled by adding "hpet=force" on the kernel command line.

Remove the related early PCI quirks for affected Ice Cake and Coffin Lake
systems as they are not longer required. That should also cover all
other systems, i.e. Tiger Rag and newer generations, which are most
likely affected by this as well.

Fixes: Yet another hardware trainwreck
Reported-by: Jakub Kicinski <kuba@kernel.org>
Not-yet-signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
Notes: Completely untested. Use at your own peril.

V2: Move the substate check into the helper function. Adjust function
    name accordingly.
---
 arch/x86/kernel/early-quirks.c |    6 ---
 arch/x86/kernel/hpet.c         |   81 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 6 deletions(-)

--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -714,12 +714,6 @@ static struct chipset early_qrk[] __init
 	 */
 	{ PCI_VENDOR_ID_INTEL, 0x0f00,
 		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
-	{ PCI_VENDOR_ID_INTEL, 0x3e20,
-		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
-	{ PCI_VENDOR_ID_INTEL, 0x3ec4,
-		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
-	{ PCI_VENDOR_ID_INTEL, 0x8a12,
-		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
 	{ PCI_VENDOR_ID_BROADCOM, 0x4331,
 	  PCI_CLASS_NETWORK_OTHER, PCI_ANY_ID, 0, apple_airport_reset},
 	{}
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -10,6 +10,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/hpet.h>
 #include <asm/time.h>
+#include <asm/mwait.h>
 
 #undef  pr_fmt
 #define pr_fmt(fmt) "hpet: " fmt
@@ -916,6 +917,83 @@ static bool __init hpet_counting(void)
 	return false;
 }
 
+static bool __init mwait_pc10_supported(void)
+{
+	unsigned int eax, ebx, ecx, mwait_substates;
+
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		return false;
+
+	if (!cpu_feature_enabled(X86_FEATURE_MWAIT))
+		return false;
+
+	if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
+		return false;
+
+	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &mwait_substates);
+
+	return (ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) &&
+	       (ecx & CPUID5_ECX_INTERRUPT_BREAK) &&
+	       (mwait_substates & (0xF << 28));
+}
+
+/*
+ * Check whether the system supports PC10. If so force disable HPET as that
+ * stops counting in PC10. This check is overbroad as it does not take any
+ * of the following into account:
+ *
+ *	- ACPI tables
+ *	- Enablement of intel_idle
+ *	- Command line arguments which limit intel_idle C-state support
+ *
+ * That's perfectly fine. HPET is a piece of hardware designed by committee
+ * and the only reasons why it is still in use on modern systems is the
+ * fact that it is impossible to reliably query TSC and CPU frequency via
+ * CPUID or firmware.
+ *
+ * If HPET is functional it is useful for calibrating TSC, but this can be
+ * done via PMTIMER as well which seems to be the last remaining timer on
+ * X86/INTEL platforms that has not been completely wreckaged by feature
+ * creep.
+ *
+ * In theory HPET support should be removed altogether, but there are older
+ * systems out there which depend on it because TSC and APIC timer are
+ * dysfunctional in deeper C-states.
+ *
+ * It's only 20 years now that hardware people have been asked to provide
+ * reliable and discoverable facilities which can be used for timekeeping
+ * and per CPU timer interrupts.
+ *
+ * The probability that this problem is going to be solved in the
+ * forseeable future is close to zero, so the kernel has to be cluttered
+ * with heuristics to keep up with the ever growing amount of hardware and
+ * firmware trainwrecks. Hopefully some day hardware people will understand
+ * that the approach of "This can be fixed in software" is not sustainable.
+ * Hope dies last...
+ */
+static bool __init hpet_is_pc10_damaged(void)
+{
+	unsigned long long pcfg;
+
+	/* Check whether PC10 substates are supported */
+	if (!mwait_pc10_supported())
+		return false;
+
+	/* Check whether PC10 is enabled in PKG C-state limit */
+	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, pcfg);
+	if ((pcfg & 0xF) < 8)
+		return false;
+
+	if (hpet_force_user) {
+		pr_warn("HPET force enabled via command line, but dysfunctional in PC10.\n");
+		return false;
+	}
+
+	pr_info("HPET dysfunctional in PC10. Force disabled.\n");
+	boot_hpet_disable = true;
+	return true;
+}
+
 /**
  * hpet_enable - Try to setup the HPET timer. Returns 1 on success.
  */
@@ -929,6 +1007,9 @@ int __init hpet_enable(void)
 	if (!is_hpet_capable())
 		return 0;
 
+	if (hpet_is_pc10_damaged())
+		return 0;
+
 	hpet_set_mapping();
 	if (!hpet_virt_address)
 		return 0;

