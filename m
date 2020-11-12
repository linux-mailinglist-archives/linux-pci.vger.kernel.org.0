Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3432B0B51
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 18:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgKLRdD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 12:33:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:55662 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgKLRc7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Nov 2020 12:32:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B8430AEA3;
        Thu, 12 Nov 2020 17:32:57 +0000 (UTC)
Message-ID: <b7ece4470edf211a398ad47fb97d059421d8d95b.camel@suse.de>
Subject: Re: [PATCH] PCI: brcmstb: Restore initial fundamental reset
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Phil Elwell <phil@raspberrypi.com>, Rob Herring <robh@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>
Date:   Thu, 12 Nov 2020 18:32:56 +0100
In-Reply-To: <CA+-6iNxc9UiEqFXj4jMJRXW1XAS7aB4hANa7mHRsK8++t2A18A@mail.gmail.com>
References: <20201112131400.3775119-1-phil@raspberrypi.com>
         <883066bd-2a0c-f0d8-c556-7df0e73f0503@gmail.com>
         <CA+-6iNxc9UiEqFXj4jMJRXW1XAS7aB4hANa7mHRsK8++t2A18A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jim,

On Thu, 2020-11-12 at 11:28 -0500, Jim Quinlan wrote:
> On Thu, Nov 12, 2020 at 10:44 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > +JimQ,
> > 
> > On 11/12/2020 5:14 AM, Phil Elwell wrote:
> > > Commit 04356ac30771 ("PCI: brcmstb: Add bcm7278 PERST# support")
> > > replaced a single reset function with a pointer to one of two
> > > implementations, but also removed the call asserting the reset
> > > at the start of brcm_pcie_setup. Doing so breaks Raspberry Pis with
> > > VL805 XHCI controllers lacking dedicated SPI EEPROMs, which have been
> > > used for USB booting but then need to be reset so that the kernel
> > > can reconfigure them. The lack of a reset causes the firmware's loading
> > > of the EEPROM image to RAM to fail, breaking USB for the kernel.
> > > 
> > > Fixes: commit 04356ac30771 ("PCI: brcmstb: Add bcm7278 PERST# support")
> > > 
> > > Signed-off-by: Phil Elwell <phil@raspberrypi.com>
> > 
> > This does indeed seem to have been lost during that commit, I will let
> > JimQ comment on whether this was intentional or not. Please make sure
> > you copy him, always, he wrote the driver after all.
> Hello,
> 
> This wasn't accidentally lost; I intentionally removed it.  I was
> remiss in not mentioning this in comments, sorry.
> 
> The reason I took it out is because (a) it breaks certain STB SOCs and
> (b) I considered it superfluous (see reason below).  At any rate, if
> you must restore this line please add the following guard so
> everyone's board will work :-)
> 
>         if (pcie->type != BCM7278)
>                 brcm_pcie_perst_set(pcie, 1);

This seems reasonable to me.

> As for me considering that  this line is superfluous -- which
> apparently it is not : AFAIK PERST# is always asserted from cold start
> on all Brcm STB SOCs, and I expected the same on the RPi.  Asserting
> PERST# at this point in time should be a no-op.  Is this not the case?

I introduced this with 22e21e51ce7 ("PCI: brcmstb: Assert fundamental reset on
initialization"). IIRC The story is the following:

- RPI's XHCI chip, which is connected to pcie-brcmstb, depends on a firmware
  blob. The blob is copied into memory, then the chip can access it anytime
  through PCIe inbound transfers.

- At any boot stage the pcie-brcmstb might be reconfigured with different
  inbound windows. This could be in RPi's custom bootloader, U-boot or Linux
  (or anything else).

- The only way we have to reset the XHCI chip so as for it to catch the new
  firmware blob addresses is through this PERST# line. Hence the need to toggle
  it every time the controller has been reconfigured.

Hope it makes some sense. :)

Regards,
Nicolas


