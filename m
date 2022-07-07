Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210A856AE49
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 00:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbiGGWWD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 18:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236962AbiGGWWC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 18:22:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DAC61D44;
        Thu,  7 Jul 2022 15:22:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA5F562521;
        Thu,  7 Jul 2022 22:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19B9C3411E;
        Thu,  7 Jul 2022 22:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657232520;
        bh=RAEL+R/urENMNl/CEbjM0bPxIFEkYHtPp3+5kN2+06Q=;
        h=Date:From:To:Cc:Subject:From;
        b=mpX7UL4PDqQ1mkvQxSvzSenRO194+SoKz+hkMStc03u1pNadclt/kKtgT2r1lJRy9
         0SC/4GTqwernZRtcSRjdcQ/knJ/1GgPCkotjqvY50B288gK1BGMJOLU0IsTre2drYs
         qkN7baz9axYOP+6PGX7XjOLxQWmLZ6DTkfrUceYL+puGb0WsayQPlzj7c11fdnU4wU
         0VpI8048u4oAcdtV5RDTKpm8s4KOj68MadgA+NYGxlMrfswFsustakdBXA0EsgQGEs
         aVHls1AbVcYSMViodsRXCCtDLYFE4U4nM8lJh61b2lMhjurjIV561ei3v2WZ72WVyV
         XwVDOahJmLz2g==
Date:   Thu, 7 Jul 2022 17:21:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     systemerror@guerrillamailblock.com,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [bugzilla-daemon@kernel.org: [Bug 216217] New: PCI e820 got screwed
 up, some systems completely fail to boot.]
Message-ID: <20220707222157.GA339399@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

----- Forwarded message from bugzilla-daemon@kernel.org -----

Date: Thu, 07 Jul 2022 21:10:55 +0000
From: bugzilla-daemon@kernel.org
To: bjorn@helgaas.com
Subject: [Bug 216217] New: PCI e820 got screwed up, some systems completely
	fail to boot.
Message-ID: <bug-216217-41252@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=216217

            Bug ID: 216217
           Summary: PCI e820 got screwed up, some systems completely fail
                    to boot.
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.19-rc4
          Hardware: AMD
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: systemerror@guerrillamailblock.com
        Regression: No

In last few recent mainline kernels something got completely screwed up in
regard of e820 vs PCI on one of computer systems.

Kernels up to 5.16 booting just fine on mentioned system. However, around
approx kernel 5.17 something changed in regard how PCI handles e820.
Unfortunately it completely broken mentioned system to extent it FAILS TO BOOT
with recent kernels.

It looks like if PCI woefully fails resources reservations or so, this in turn
results in failing to initialize numerous devices, ranging from GPU to
networking, so overall system gets stuck without graphics (!!!) and generally
stuck in the middle of boot.

Details:
Investigation shown commit around a2b36ffbf5b6ec301e61249c8b09e610bc80772f
hints there were some changes on how PCI vs e820 handled and some bool boot
parameter has been added to control PCI e820 behavior. Unfortunately with it
default state kernels BACKFIRE on mentioned system and COMPLETELY FAIL TO BOOT.
Which isn't anyhow acceptable state of things.

I had to use "pci=no_e820" kernel command line as hinted, this restores sane
PCI behavior so system could boot properly.

Boot log upon use of this override suggests I should report this condition so
future kernels suxx a bit less.

Just in case... 
[    0.000000] DMI: Gigabyte Technology Co., Ltd. GA-990FXA-UD5/GA-990FXA-UD5,
BIOS F5 08/29/2011

...

[    2.534896] ACPI: Interpreter enabled
[    2.534919] ACPI: PM: (supports S0 S3 S4 S5)
[    2.534921] ACPI: Using IOAPIC for interrupt routing
[    2.534960] PCI: Using host bridge windows from ACPI; if necessary, use
"pci=nocrs" and report a bug
[    2.534961] PCI: Ignoring E820 reservations for host bridge windows
[    2.534962] PCI: Please notify linux-pci@vger.kernel.org so future kernels
can this automatically
[    2.535123] ACPI: Enabled 9 GPEs in block 00 to 1F
[    2.539860] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    2.539867] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM
Segments MSI EDR HPX-Type3]
[    2.540155] PCI host bridge to bus 0000:00

I could collect other details if necessary.

-- 

Sorry for the breakage and thanks for the report.

For completeness, can you please collect the complete dmesg log and
attach it to the bugzilla?

If I understand correctly, v5.19-rc4 doesn't boot on this system.  If
you add the "pci=no_e820" parameter, it does boot.

We will need a quirk like the one below to make this work out of the
box.  Would you mind testing it?  If it doesn't work, can you please
collect the "dmidecode" output and attach it to the bugzilla also?


diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index a4f43054bc79..04396dbdd1c5 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -190,6 +190,18 @@ static const struct dmi_system_id pci_crs_quirks[] __initconst = {
 			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
 		},
 	},
+
+	/*
+	 * See https://bugzilla.kernel.org/show_bug.cgi?id=216217
+	 */
+	{
+		.callback = set_no_e820,
+		.ident = "Gigabyte GA-990FXA-UD5",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Gigabyte Technology Co., Ltd."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "GA-990FXA-UD5"),
+		},
+	},
 	{}
 };
 
@@ -246,7 +258,7 @@ void __init pci_acpi_crs_quirks(void)
 	printk(KERN_INFO "PCI: %s E820 reservations for host bridge windows\n",
 	       pci_use_e820 ? "Using" : "Ignoring");
 	if (pci_probe & (PCI_NO_E820 | PCI_USE_E820))
-		printk(KERN_INFO "PCI: Please notify linux-pci@vger.kernel.org so future kernels can this automatically\n");
+		printk(KERN_INFO "PCI: Please notify linux-pci@vger.kernel.org so future kernels can do this automatically\n");
 }
 
 #ifdef	CONFIG_PCI_MMCONFIG
