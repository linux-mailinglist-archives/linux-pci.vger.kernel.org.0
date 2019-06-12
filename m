Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9F0B41AA3
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 05:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406935AbfFLDQQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jun 2019 23:16:16 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40169 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406820AbfFLDQQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jun 2019 23:16:16 -0400
Received: by mail-qt1-f196.google.com with SMTP id a15so17120836qtn.7
        for <linux-pci@vger.kernel.org>; Tue, 11 Jun 2019 20:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7pM/bJ8KVHIUPR4+RA4bCYP1FwUKSdfzbtnXNI7jYUg=;
        b=AN4Q6Kmp8qKhgA1WRegP49/La57Ux8OAjzI10r2kwBu/crcdda9bIGZE+Frfy87AVU
         DhDPbB5ejAguNYneffd7FEJ7jsdnz5xT5hXHEKvgetBomLy6l7t0HqT96Xul7oH7vYfY
         SkSH5fk4QbNYfPUSlMIBP8ANAKQFZS6cKtISwP0aUiNbTalL4XkdIZhj5kCV99qUpKzE
         EzlEu/42R1djipxopMbrWSrhCMkCV50h8LQkYgtiyMG/NoCL+JE+jUakWs/gA0hymUvL
         acI/7AcOFqFKnZTeHBhmjY4+0ejhjI0mOke+f5hZYHK/BhcsKxOc3ktSR68EnD821kZd
         prow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7pM/bJ8KVHIUPR4+RA4bCYP1FwUKSdfzbtnXNI7jYUg=;
        b=GVmqvv/ewkTm9Nk/W2UxZKLcNWVS4+Abj3xWyHRXRFjLt5nVFimF247jjP3aUDhcdF
         UUyAU7LANvwn9xCqQl31+ZL7vZIJdeNWIHNg8U+Zo10Z/Nfa7Y+EClpci0riBj78/8vs
         A1Mgq9TxYHVlbH2rPzH/T5CSXeSI1eMDsmtDU5W8vktbmdpQa3xuCRnF2rymY3JGlOnr
         asY5q6cbL8eb1c/lgNiLg3BBsgk51/5y0+rPxwdiTRA9qsQVKAG0tnZ13HJWaDzUPRzi
         N6wLx1C6bWUejP8WEReNZdXY7Eszm/YZVFAaJOWYXeoTYX5x5X4hcoPkA/u6tTjMQPjK
         J7Ew==
X-Gm-Message-State: APjAAAXCiMTqfKqtNeFIV5x5Z4hQrqIvgkF8R8U/zJSxPWf5Uqu4q0Lv
        6jbw4UeUUsKbiS76Ft3lCXihR0+HdfKGHuPmZXtYZQ==
X-Google-Smtp-Source: APXvYqxNwHBEMHH9cCduwKgR9m3i5D0ADQL7TX14Y8L3K33O5OiTAB5vsp3Puu4YHxV+8R7MXC9A9pZE25E4gpIpJ6I=
X-Received: by 2002:ac8:4982:: with SMTP id f2mr61652403qtq.213.1560309374677;
 Tue, 11 Jun 2019 20:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190610074456.2761-1-drake@endlessm.com> <20190610211628.GA68572@google.com>
 <CAD8Lp47BmOtEgFUDCMyLrDpoPZSxcWmbrXEbh4PXS0FSG8ukLA@mail.gmail.com> <20190611195254.GB768@google.com>
In-Reply-To: <20190611195254.GB768@google.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Wed, 12 Jun 2019 11:16:03 +0800
Message-ID: <CAD8Lp479mY=dAhFvGT2ZiJP12KXszhWev=QpCcgfgoew0TxgWg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add Intel remapped NVMe device support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-ide@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        mjg59@srcf.ucam.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 12, 2019 at 3:52 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> It also said (three years ago) that there was some hope of opening the
> specs.  But I guess that hasn't happened.

I think the brief spec I already linked to may have been published as
a result of the discussion there:
https://marc.info/?l=linux-ide&m=147734288604783&w=2

Either way I'm not aware of any more detailed information having been
published since then.

> > 2. The RAID controller presented by intel-nvme-remap on a new bus,
> > with the cfg space tweaked in a way that it gets probed & accepted by
> > the ahci driver:
> >
> > 10000:00:00.0 SATA controller: Intel Corporation 82801 Mobile SATA
> > Controller [RAID mode] (rev 30) (prog-if 01 [AHCI 1.0])
> >     Memory at b4390000 (32-bit, non-prefetchable) [size=32K]
>
> Exposing the same device in two different places (0000:00:17.0 and
> 10000:00:00.0) is definitely an architectural issue.  Logically we're
> saying that accesses to b4390000 are claimed by two different devices.

I guess intel-nvme-remap could tweak the 0000:00:17.0 device to remove
those BARs so that they ultimately only appear under 10000:00:00.0.
But that doesn't sound particularly nice either.

If we continue down this road, another possibility is to leave the
0000:00:17.0 device untouched, claimed and driven by the ahci driver
as it is now, and rather than have intel-nvme-remap be a separate
driver that claims the PCI device, just have it as a kind of library
that gets called into from ahci. intel-nvme-remap would then create
the "fake" PCI bus but only expose the NVMe devs there (not the AHCI
one). This would deviate a little from the original suggestion of
"expose a fake PCIe root port that both the AHCI and NVMe driver bind
to.".

> > 3. The (previously inaccessible) NVMe device as presented on the new
> > bus by intel-nvme-remap, probed by the nvme driver
> >
> > 10000:00:01.0 Non-Volatile memory controller: Intel Corporation Device
> > 0000 (prog-if 02 [NVM Express])
> >     Memory at b430c000 (64-bit, non-prefetchable) [size=16K]
>
> From a hardware point of view, I think it *was* previously accessible.
> Maybe not in a convenient, driver-bindable way, but I don't think your
> patch flips any PCI_COMMAND or similar register enable bits.
> Everything should have been accessible before if you knew where to
> look.

Pretty much, but in addition to fishing out the NVMe memory address
from the AHCI BAR,  you also have to know to share the interrupt with
AHCI, and also the PCI_COMMAND_MEMORY and PCI_COMMAND_MASTER bits must
be set on the AHCI device in order for the NVMe devices to work.

> Why do you need these to be PCI devices?

I don't have a particular preference, but was trying to explore the
suggestions from the last round of review:

https://marc.info/?l=linux-ide&m=147923593001525&w=2
"implementing a bridge driver like VMD"
http://lists.infradead.org/pipermail/linux-nvme/2017-October/013325.html
"The right way to do this would be to expose a fake PCIe root port
that both the AHCI and NVMe driver bind to."

> It looks like the main thing
> you get is a hook to bind the driver to.  Could you accomplish
> something similar by doing some coordination between the ahci and nvme
> drivers directly, without involving PCI?

That's basically what Dan Williams originally proposed, and Christoph
Hellwig was not particularly excited by it...

Can you take a quick at the original patches and see what you think?
https://marc.info/?l=linux-ide&m=147709611121482&w=2
https://marc.info/?l=linux-ide&m=147709611621483&w=2
https://marc.info/?l=linux-ide&m=147709612221484&w=2
https://marc.info/?l=linux-ide&m=147709612721485&w=2
https://marc.info/?l=linux-ide&m=147709613221487&w=2

> I assume that whatever magic Intel is doing with this "RST Optane"
> mode, the resulting platform topology is at least compliant with the
> PCI spec, so all the standard things in the spec like AER, DPC, power
> management, etc, still work.

That would also be my expectation - those standard things you
configure on the AHCI device would also affect the mode of operation
of the hidden NVMe devices, in the same way that the
PCI_COMMAND_MASTER AHCI bit affects NVMe device access.

> This all sounds urgent, but without details of what this "RST Optane"
> mode means actually means, I don't know what to do with it.  I want to
> avoid the voodoo programming of "we don't know *why* we're doing this,
> but it seems to work."

From the user perspective, we're doing it so that they get access to
their storage device.

But I guess you meant more from the technical architecture
perspective. My understanding comes from
https://mjg59.dreamwidth.org/44694.html : this is a game of Windows
driver politics.
Intel doesn't want the standard Windows NVMe driver to bind to the
NVMe devices, because that driver is power hungry and makes Intel
platforms look bad. So they came up with this scheme to hide the NVMe
devices from view, and then only the power-eficient Intel Windows
driver knows how to find them.

The implementation follows patches, emails and the VS_CAP spec, all
authored by Intel. I'm not confident that we'll get any more than
that. The 2016 patches only appeared 5 months after numerous Lenovo
customers had reported their inability to access their disk on Linux
(they didn't even have a BIOS configuration option at that point).
While some information was then shared in patches and emails, as you
have seen Intel wasn't very forthcoming in providing a decent spec.
Intel's last comment in the 2016 thread wasn't exactly positive:
https://marc.info/?l=linux-ide&m=147953592417285&w=2
and there was no reponse from Intel to my 2017 thread:
http://lists.infradead.org/pipermail/linux-nvme/2017-October/013323.html

So at this point I'd advocate for just piecing together the pieces of
the puzzle that we do have (I'll work to reference the details better
in the next patch revision), accepting that we're working with an
architecture that doesn't seem well thought out, and then figure out
the least painful way to support it.

Thanks,
Daniel
