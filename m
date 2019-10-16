Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA402D9EEC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 00:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406829AbfJPWDh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 18:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406826AbfJPWDg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Oct 2019 18:03:36 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA193218DE;
        Wed, 16 Oct 2019 22:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263415;
        bh=O0G17YN2tPEZ7i3JnTYzZCDAa/F7uCFuiSjmZ3wvrfA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BiWb/svlRwEwax+APMGEapJwph2a8ugfWL3JZwsnqQTfPQWA4SLexSE+F2cnVPgRU
         2qJGp2NUMGqKYOWdToD89u2zQk8Y+dHmcIMFsy8yShVFJYscHruIHQrj9VnRNp7mlu
         i5f8AtdnKEMXdw3+v/a8iBP1vkESb0pk/b5c38S4=
Date:   Wed, 16 Oct 2019 17:03:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        Mika Westerberg <mika.westerberg@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Linux ACPI Mailing List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
Message-ID: <20191016220333.GA88523@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACO55tuXck7vqGVLmMBGFg6A2pr3h8koRuvvWHLNDH8XvBVxew@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 16, 2019 at 11:48:22PM +0200, Karol Herbst wrote:
> On Wed, Oct 16, 2019 at 11:37 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Oct 16, 2019 at 09:18:32PM +0200, Karol Herbst wrote:
> > > but setting the PCI_DEV_FLAGS_NO_D3 flag does prevent using the
> > > platform means of putting the device into D3cold, right? That's
> > > actually what should still happen, just the D3hot step should be
> > > skipped.
> >
> > If I understand correctly, when we put a device in D3cold on an ACPI
> > system, we do something like this:
> >
> >   pci_set_power_state(D3cold)
> >     if (PCI_DEV_FLAGS_NO_D3)
> >       return 0                                   <-- nothing at all if quirked
> >     pci_raw_set_power_state
> >       pci_write_config_word(PCI_PM_CTRL, D3hot)  <-- set to D3hot
> >     __pci_complete_power_transition(D3cold)
> >       pci_platform_power_transition(D3cold)
> >         platform_pci_set_power_state(D3cold)
> >           acpi_pci_set_power_state(D3cold)
> >             acpi_device_set_power(ACPI_STATE_D3_COLD)
> >               ...
> >                 acpi_evaluate_object("_OFF")     <-- set to D3cold
> >
> > I did not understand the connection with platform (ACPI) power
> > management from your patch.  It sounds like you want this entire path
> > except that you want to skip the PCI_PM_CTRL write?
> >
> 
> exactly. I am running with this workaround for a while now and never
> had any fails with it anymore. The GPU gets turned off correctly and I
> see the same power savings, just that the GPU can be powered on again.
> 
> > That seems like something Rafael should weigh in on.  I don't know
> > why we set the device to D3hot with PCI_PM_CTRL before using the ACPI
> > methods, and I don't know what the effect of skipping that is.  It
> > seems a little messy to slice out this tiny piece from the middle, but
> > maybe it makes sense.
> >
> 
> afaik when I was talking with others in the past about it, Windows is
> doing that before using ACPI calls, but maybe they have some similar
> workarounds for certain intel bridges as well? I am sure it affects
> more than the one I am blacklisting here, but I rather want to check
> each device before blacklisting all kabylake and sky lake bridges (as
> those are the ones were this issue can be observed).

From a quick look at the ACPI spec, I didn't see conditions like "OSPM
must put PCI devices in D3hot before executing _OFF".  But obviously
there's *some* reason and I probably just missed it.

> Sadly we had no luck getting any information about such workaround out
> of Nvidia or Intel.

I'm not surprised; it doesn't seem like we really have the details
needed to get to a root cause yet.  I think what we really need is a
PCIe analyzer trace to see what happens when the device "falls off the
bus".

Bjorn
