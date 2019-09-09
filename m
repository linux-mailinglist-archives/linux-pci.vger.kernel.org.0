Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E642BADAA5
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2019 16:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbfIIOCn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Sep 2019 10:02:43 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33705 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730928AbfIIOCm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Sep 2019 10:02:42 -0400
Received: by mail-io1-f65.google.com with SMTP id m11so28943203ioo.0
        for <linux-pci@vger.kernel.org>; Mon, 09 Sep 2019 07:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8i5dkStrabNHsl7KV3zOIJ5RJgzj90AK9sxoEEJihIo=;
        b=eeHn9BXhrxmfX9aye2EW2AnRlwbqWsP/9UGyIoyui1PwsLNVui38+z8yNFWGuXNTqu
         5DlQJlAfRtR0zTYXc+rsc4XI6CfPNhE9/z7AUsVOQNcRVNG8hPcI+Dma0zWlEef0Kda5
         YmZY1EnK9sf10kNt5oWN1BKtN3GZs3eyExgE3MFlb3ZZUJIklI76U4vYu8upWGzb84cx
         ErpoYjOaD6//OdfwiefUwm5NTEWEi1GRCjyDIELHtp1VGYtZZV/US5AxH68IWdwBPYn2
         7JhSBdpIlpO7vsaPsH0l45+XaG7HyGzH6yYDOU7fUx5bNM1tkUN6StJQcJNtlubK1EM4
         6eKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8i5dkStrabNHsl7KV3zOIJ5RJgzj90AK9sxoEEJihIo=;
        b=gF7Gt9btXF6J2V6NA33HmRZiyz+yxGKaO4qA6GXQBUVLgUhYlLqIMw0OQC3LZEv0Hi
         qakGWAEhbS307HiS2xNkX+SjbXKcIXIL/dTwVgIjhBfdW5YL6i9gIPK6BolRlezrGe2y
         C1XmeIUDVwgdyhD6g0y3SKKJln5x8LHBxqUbSt0QOebffdK8Fu1rOohO5s6g+aivHJTe
         j2ZPvVWwJF4f79WZipLJltkePx9ZkW8k5sjmN333HDMTqrn1XRKaDHYbR86uuXnkdHBQ
         CLxowAlyg1DLRwGXVJm4XzsxZCO0oIDjQ55qPSOrhUvxEmEpjJ1H02/epA7CH52S/MM8
         JnyA==
X-Gm-Message-State: APjAAAWyxrPV6nNTZ3BOdonWLYncqTvvcKoysyQfOtL8fhBuMugF1w8X
        LQwgteIA2GoJ/tS8kB/at7xjOPsWoCKhRnXiCeg=
X-Google-Smtp-Source: APXvYqyL386XCzrPyKA6S2bjdTj5LdfIJF3K+CS7kEa0ci3Yw2WTxtOi9ty8C8PnCPAwjUejB3RRqqLbCMNixIljCqU=
X-Received: by 2002:a6b:bb86:: with SMTP id l128mr18026803iof.18.1568037761702;
 Mon, 09 Sep 2019 07:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190816165101.911-1-s.miroshnichenko@yadro.com>
 <20190816165101.911-19-s.miroshnichenko@yadro.com> <026a6bfbfd8268c5158bc48fb43907cc13442561.camel@gmail.com>
 <7af3d4cd-b786-19b1-1ddf-b93f9875976d@yadro.com>
In-Reply-To: <7af3d4cd-b786-19b1-1ddf-b93f9875976d@yadro.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Tue, 10 Sep 2019 00:02:30 +1000
Message-ID: <CAOSf1CG-oaKazKzZCULUjntc+3-dztiQ3U=6tcWu+OGer_77Ag@mail.gmail.com>
Subject: Re: [PATCH v5 18/23] powerpc/pci: Handle BAR movement
To:     Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux@yadro.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 7, 2019 at 2:25 AM Sergey Miroshnichenko
<s.miroshnichenko@yadro.com> wrote:
>
> Hi Oliver,
>
> On 9/4/19 8:37 AM, Oliver O'Halloran wrote:
> > On Fri, 2019-08-16 at 19:50 +0300, Sergey Miroshnichenko wrote:
> >> Add pcibios_rescan_prepare()/_done() hooks for the powerpc platform. Now if
> >> the device's driver supports movable BARs, pcibios_rescan_prepare() will be
> >> called after the device is stopped, and pcibios_rescan_done() - before it
> >> resumes. There are no memory requests to this device between the hooks, so
> >> it it safe to rebuild the EEH address cache during that.
> >>
> >> CC: Oliver O'Halloran <oohall@gmail.com>
> >> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> >> ---
> >>  arch/powerpc/kernel/pci-hotplug.c | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
> >> index 0b0cf8168b47..18cf13bba228 100644
> >> --- a/arch/powerpc/kernel/pci-hotplug.c
> >> +++ b/arch/powerpc/kernel/pci-hotplug.c
> >> @@ -144,3 +144,13 @@ void pci_hp_add_devices(struct pci_bus *bus)
> >>      pcibios_finish_adding_to_bus(bus);
> >>  }
> >>  EXPORT_SYMBOL_GPL(pci_hp_add_devices);
> >> +
> >> +void pcibios_rescan_prepare(struct pci_dev *pdev)
> >> +{
> >> +    eeh_addr_cache_rmv_dev(pdev);
> >> +}
> >> +
> >> +void pcibios_rescan_done(struct pci_dev *pdev)
> >> +{
> >> +    eeh_addr_cache_insert_dev(pdev);
> >> +}
> >
> > Is this actually sufficent? The PE number for a device is largely
> > determined by the location of the MMIO BARs. If you move a BAR far
> > enough the PE number stored in the eeh_pe would need to be updated as
> > well.
> >
>
> Thanks for the hint! I've checked on our PowerNV: for bridges with MEM
> only it allocates PE numbers starting from 0xff down, and when there
> are MEM64 - starting from 0 up, one PE number per 4GiB.
>
> PEs are allocated during call to pnv_pci_setup_bridge(), and the I've
> added invocation of pci_setup_bridge() after a hotplug event in the
> "Recalculate all bridge windows during rescan" patch of this series.

Sort of.

On PHB3 both the 32bit and the 64bit MMIO windows are split into 256
segments each of which is mapped to a PE number. For the 32bit space
there's a remapping table in hardware that allows arbitrary mapping of
segments to PE numbers, but in the 64bit space the mapping is fixed
with the first segment being PE0, etc. If there's a 64 bit BAR under a
bridge the PE is really "allocated" during the BAR assignment process,
and the setup_bridge() step sets up the EEH state based on that.

It's worth pointing out that this is why the 64bit window is usually
4GB. Bridge windows need to be aligned to a segment boundary to ensure
the devices under them are placed into a unique PE.

> Currently, if a bus already has a PE, pnv_ioda_setup_bus_PE() takes it
> and returns. I can see two ways to change it, both are not difficult to
> implement:
>
>  a.1) check if MEM64 BARs appeared below the bus - allocate and assign
>       a new master PE with required number of slave PEs;
>
>  a.2) if the bus now has more MEM64 than before - check if more slave
>       PEs must be reserved;
>
>  b) release all the PEs before a PCI rescan and allocate+assign them
>     again after - with this approach the "Hook up the writes to
>     PCI_SECONDARY_BUS register" patch may be eliminated.
>
> Do you find any of these suitable?

I'm not sure a) would work, but even if it does b) is preferable.
There's a lot of strangeness in the powerpc PCI code as-is without
adding extra code paths to deal with. Keeping what happens at hotplug
consistent with what happens at boot will help keep things sane.

FYI in the next few days I'm going to post a series that rips out the
use of pci_dn in powernv and the generic parts of EEH (pseries still
uses it). Assuming Bjorn isn't picking this up for 5.4 you might want
to wait for that before getting too deep into this.

Oliver
