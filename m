Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1672A1E87A5
	for <lists+linux-pci@lfdr.de>; Fri, 29 May 2020 21:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgE2TVr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 May 2020 15:21:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgE2TVq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 May 2020 15:21:46 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCA302075A;
        Fri, 29 May 2020 19:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590780106;
        bh=i3BPzWHpCcmAHjeIK7qW8FYQEeuSECqPgKAG3M94eG4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YSjbeDaLvyQQUSJMF4hUEvzPrmoOChWKJy28YdpTqJIjAUq6R7mr30X/gfabw4eCK
         5j9TH0zNBQLp+TpI9I4ZWgeS2vh6lhM6gNq8hTmnCHqxPWQz0rLGeNR73VHjZ3vYsX
         XoyxAPQvnQotmoCGavzeg9VeBaHjwcEKwZ/ayp3A=
Date:   Fri, 29 May 2020 14:21:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Lost PCIe PME after a914ff2d78ce ("PCI/ASPM: Don't select
 CONFIG_PCIEASPM by default")
Message-ID: <20200529192143.GA448525@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e66a6749-29a1-af23-6d07-6b3c4fd45220@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, linux-kernel]

On Fri, May 29, 2020 at 08:50:46PM +0200, Heiner Kallweit wrote:
> On 28.05.2020 23:44, Heiner Kallweit wrote:
> > For whatever reason with this change (and losing ASPM control) I also
> > loose the PCIe PME interrupts. This prevents my network card from
> > resuming from runtime-suspend.
> > Reverting the change brings back ASPM control and the PCIe PME irq's.
> > 
> > Affected system is a Zotac MiniPC with a N3450 CPU:
> > PCI bridge: Intel Corporation Celeron N3350/Pentium N4200/Atom E3900 Series PCI Express Port A #1 (rev fb)
> > 
> I checked a little bit further and w/o ASPM control the root ports
> don't have the PME service bit set in their capabilities.
> Not sure whether this is a chipset bug or whether there's a better
> explanation. However more chipsets may have such a behavior.

Hmm.  Is the difference simply changing the PCIEASPM config symbol, or
are you booting with command-line arguments like "pcie_aspm=off"?

What's the specific PME bit that changes in the root ports?  Can you
collect the "sudo lspci -vvxxxx" output with and without ASPM?

The capability bits are generally read-only as far as the PCI spec is
concerned, but devices have implementation-specific knobs that the
BIOS may use to change things.  Without CONFIG_PCIEASPM, Linux will
not request control of LTR, and that could cause the BIOS to change
something.  You should be able to see the LTR control difference in
the dmesg logging about _OSC.

> W/o the "default y" for ASPM control we also have the situation now
> that the config option description says "When in doubt, say Y."
> but it takes the EXPERT mode to enable it. This seems to be a little
> bit inconsistent.

We should probably remove the "if EXPERT" from the PCIEASPM kconfig.
But I would expect PME to work correctly regardless of PCIEASPM, so
removing "if EXPERT" doesn't solve the underlying problem.

Rafael, does this ring any bells for you?  I don't remember a
connection between PME and ASPM, but maybe there is one.

> To cut a long story short:
> At least on some systems this change has unwanted side effects.
