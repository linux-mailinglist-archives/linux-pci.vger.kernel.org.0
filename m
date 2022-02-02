Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0441C4A7B37
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 23:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347640AbiBBWmo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 17:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346480AbiBBWmo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 17:42:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D647AC061714;
        Wed,  2 Feb 2022 14:42:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30074B832C2;
        Wed,  2 Feb 2022 22:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53FFC004E1;
        Wed,  2 Feb 2022 22:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643841761;
        bh=QeCtUyyg5QpqeRsRwiIlz7kYnbtIa8ywWz4Etso8L20=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LBGjOSXjDuuJ7M5RDIoJ3+pHs+Oa3L9pfUIViyioOv7zKEIPhwLNzgjXxcefIJW5x
         pIiH7G03PrVfSrS2bhtZSFjD9jwiLDIjx7jJxMmcrcAirMlwNB/hS8hcc9H8CyqDfQ
         AdAeB8AgAAHAQkj0D0vl24SzGv6S7xS2/NWO//EB2AOH+dv6svC4UIId0LtsOFN3bf
         pD2D33gqySYPMnSMUu3CYgKuMt0B0sHSw8O6Cy0NFTnaBrmpgUL7R/VElf7BzlISZe
         n9vzjI4bZt06vo2FHXAmpzzcSEHRyAvKhGOXR7CvvEEcKSE5RCUS6bgmtI/GeYmXnZ
         y+HyPpq8ZGPSQ==
Date:   Wed, 2 Feb 2022 16:42:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Brent Spillner <spillner@acm.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/PCI: Improve log message when IRQ cannot be
 identified
Message-ID: <20220202224239.GA49678@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGwJgaMDJH-rhsc9+_vj1vjj6XLigvqVYLdu-6TgrDNxGpTubA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 02, 2022 at 10:13:31PM +0000, Brent Spillner wrote:
> On Wed, Feb 2, 2022 at 6:13 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > IIUC pirq_enable_irq() is only used for non-ACPI, non-DT, non-Xen,
> > non-Intel MID systems, so this is a real legacy path.
> >
> > I don't think it's really worth cluttering an error case in a path
> > that should be rarely used in the first place.
> 
> I figured if people are getting this message, then they either have
> broken hardware or are debugging something, and if the message is
> trying to be useful then it can't hurt to mention other things that
> might help. If the pirq path has become buggy or unsupportable in
> modern kernels then it probably ought to be removed altogether; if it
> still works, however rarely it might be needed these days, then it's
> perhaps worth mentioning to those who might occasionally have a use
> for it.
> 
> > Are you seeing a problem where you're getting the wrong error message
> > today?  Can we just fix that problem instead so no kernel parameter is
> > needed in the first place?
> 
> I was trying to isolate intermittent ACPI errors and tried booting
> with acpi=noirq, as seemingly the closest modern equivalent to the
> acpi=ht that had solved, or at least half-split, similar issues for me
> in the past. With noirq, a different PCIe device stopped working (MPT
> Fusion driver not picking up any responses to doorbell interrupts),

If your system has ACPI, I think "pci=biosirq" and "acpi=noirq" are at
best distractions from finding the real problem.

> and while reviewing dmesg I noticed that the PCI error messages were
> suggesting a kernel option that wasn't appropriate for my x86_64
> architecture. In an ideal world with no hardware or driver problems
> these log messages should never even happen, but in the real world of
> troubleshooting and debugging I think they can be useful, and if
> they're going to be reported they might as well be correct.
> 
> Obviously, this is a very minor bug, affecting only logs rather than
> behavior, and I'm sure there are more pressing things to worry about.
> On the other hand, it also seems like a very easy and low-risk fix
> that leaves the kernel in a slightly better state for future users and
> developers. At any rate, the current state of the PCI code (a)
> generates a message that recommends specific kernel parameters, (b)
> does so even on builds for which those parameters are inappropriate,
> (c) doesn't say anything to encourage bug reports, and (d) doesn't
> warn about the risks of noirq, which could cause other problems to be
> misattributed. So even though the alternate messages I drafted may not
> be perfect, and might need to be tuned in the future based on patterns
> in whatever bug reports come in, I'm still confident that they're an
> improvement (and I'm open to further suggestions).

This path has to do with ancient x86 and BIOS history, which I know
very little about.  If I were going to do something about these
messages, here's what I would do.  Maybe it's too aggressive; I dunno.

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 97b63e35e152..553c9f00c0e0 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -1473,8 +1473,6 @@ static int pirq_enable_irq(struct pci_dev *dev)
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (pin && !pcibios_lookup_irq(dev, 1)) {
-		char *msg = "";
-
 		if (!io_apic_assign_pci_irqs && dev->irq)
 			return 0;
 
@@ -1516,13 +1514,9 @@ static int pirq_enable_irq(struct pci_dev *dev)
 				dev_info(&dev->dev, "PCI->APIC IRQ transform: "
 					 "INT %c -> IRQ %d\n", 'A' + pin - 1, irq);
 				return 0;
-			} else
-				msg = "; probably buggy MP table";
+			}
 #endif
-		} else if (pci_probe & PCI_BIOS_IRQ_SCAN)
-			msg = "";
-		else
-			msg = "; please try using pci=biosirq";
+		}
 
 		/*
 		 * With IDE legacy devices the IRQ lookup failure is not
@@ -1532,8 +1526,8 @@ static int pirq_enable_irq(struct pci_dev *dev)
 				!(dev->class & 0x5))
 			return 0;
 
-		dev_warn(&dev->dev, "can't find IRQ for PCI INT %c%s\n",
-			 'A' + pin - 1, msg);
+		dev_warn(&dev->dev, "can't find IRQ for PCI INT %c\n",
+			 'A' + pin - 1);
 	}
 	return 0;
 }
