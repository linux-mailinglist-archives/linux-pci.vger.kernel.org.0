Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52B42320D7
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jul 2020 16:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgG2OnT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 10:43:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32161 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726847AbgG2OnS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2020 10:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596033796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8fCssoJ0CAlfROhDCOU7igjf0xT9ILRTmoPs/GspefE=;
        b=IRWA/Grj0f60nAx9zjr4jrTwh3KIoWDMhgKP4XIfFWBJ+UsjjH1X5YCfhkKIJYJG4E2sVl
        ORlQNvB469ZwIO+EP7eroFW/OTKmnqF1iLPjc8XbPYSR9LuwXXNkJglW4edLl7IPuzwTmG
        eREgDCKObGkdgPE5h/Vd9Zy8XfLi29s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-6ldOVxOPPIycixyvhgw3qw-1; Wed, 29 Jul 2020 10:43:13 -0400
X-MC-Unique: 6ldOVxOPPIycixyvhgw3qw-1
Received: by mail-wm1-f72.google.com with SMTP id b13so1083283wme.9
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2020 07:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8fCssoJ0CAlfROhDCOU7igjf0xT9ILRTmoPs/GspefE=;
        b=O6wNBsK9LywGqKiOupSshQw8Jw/Mnf5UCjKwn/7wgdMmlqaJTNkXZ01o1NFcCHobND
         KV0FzYOK/Oi1o7Rv28kRUiXJ1kGhJ1uT7LJ9RmFr2BJr2se1PhjCNTW74vIFd9LJqhjV
         rKUJ0+fmuPn8NbtF5jdmHZbi0LT67XDCRRSIFWQmyVCaahVSfzWOmMmfJsO2cAcZb1hH
         LpDiPz/jbR8lSCacwLGIu5JJz8v8zCDvVWsiPzDmdiF0KNWj9WPzBDm6z9SEzmA/pgw4
         q64meYzu1UxSW6BXV+rhgc6RyF7w6KRd1YPzGMYoNXwcIix3rcRtsJ2tjmTnyIN5qsxa
         3Vdg==
X-Gm-Message-State: AOAM531yChI6DfRxOTMafikUYezf1lGnLnBhADdcsrEdMyj7jRpb3o9e
        ZzUKfEy5MURtyJ9XoUN2CIevCPBF1GQv/FL4zeomMTtVhGOJXraPNfeFmHFKKX25xBrvmVftCl5
        97bRvtRWS0oYtz+zXhqrL
X-Received: by 2002:adf:bb07:: with SMTP id r7mr24257298wrg.102.1596033792187;
        Wed, 29 Jul 2020 07:43:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYXjCm41zHA5xm/lx0SlII2xk4YGjjpxRkb8AiBUjlMgTECEyydjR3gkD0C7MR9w7QpW4fzQ==
X-Received: by 2002:adf:bb07:: with SMTP id r7mr24257279wrg.102.1596033791914;
        Wed, 29 Jul 2020 07:43:11 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
        by smtp.gmail.com with ESMTPSA id z15sm5003496wrn.89.2020.07.29.07.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 07:43:11 -0700 (PDT)
Date:   Wed, 29 Jul 2020 10:43:07 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Julia Suvorova <jusual@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH] x86/PCI: Use MMCONFIG by default for KVM guests
Message-ID: <20200729102929-mutt-send-email-mst@kernel.org>
References: <20200722001513.298315-1-jusual@redhat.com>
 <20200722231929.GA1314067@bjorn-Precision-5520>
 <CAMDeoFUCanfvrxAmW4_QH=L9BExCAydCifE_tvRaW_XTd0OQXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMDeoFUCanfvrxAmW4_QH=L9BExCAydCifE_tvRaW_XTd0OQXw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jul 26, 2020 at 08:58:45PM +0200, Julia Suvorova wrote:
> On Thu, Jul 23, 2020 at 1:19 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Wed, Jul 22, 2020 at 02:15:13AM +0200, Julia Suvorova wrote:
> > > Scanning for PCI devices at boot takes a long time for KVM guests. It
> > > can be reduced if KVM will handle all configuration space accesses for
> > > non-existent devices without going to userspace [1]. But for this to
> > > work, all accesses must go through MMCONFIG.
> > > This change allows to use pci_mmcfg as raw_pci_ops for 64-bit KVM
> > > guests making MMCONFIG the default access method.
> >
> > The above *looks* like it's intended to be two paragraphs, which would
> > be easier to read with a blank line between.
> >
> > The last sentence should say what the patch actually *does*, e.g.,
> > "Use pci_mmcfg as raw_pci_ops ..."
> >
> > > [1] https://lkml.org/lkml/2020/5/14/936
> >
> > Please use a lore.kernel.org URL instead because it's more usable and
> > I'd rather depend on kernel.org than lkml.org.
> >
> > > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > > ---
> > >  arch/x86/pci/direct.c      | 5 +++++
> > >  arch/x86/pci/mmconfig_64.c | 3 +++
> > >  2 files changed, 8 insertions(+)
> > >
> > > diff --git a/arch/x86/pci/direct.c b/arch/x86/pci/direct.c
> > > index a51074c55982..8ff6b65d8f48 100644
> > > --- a/arch/x86/pci/direct.c
> > > +++ b/arch/x86/pci/direct.c
> > > @@ -6,6 +6,7 @@
> > >  #include <linux/pci.h>
> > >  #include <linux/init.h>
> > >  #include <linux/dmi.h>
> > > +#include <linux/kvm_para.h>
> > >  #include <asm/pci_x86.h>
> > >
> > >  /*
> > > @@ -264,6 +265,10 @@ void __init pci_direct_init(int type)
> > >  {
> > >       if (type == 0)
> > >               return;
> > > +
> > > +     if (raw_pci_ext_ops && kvm_para_available())
> > > +             return;
> > >       printk(KERN_INFO "PCI: Using configuration type %d for base access\n",
> > >                type);
> > >       if (type == 1) {
> > > diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
> > > index 0c7b6e66c644..9eb772821766 100644
> > > --- a/arch/x86/pci/mmconfig_64.c
> > > +++ b/arch/x86/pci/mmconfig_64.c
> > > @@ -10,6 +10,7 @@
> > >  #include <linux/init.h>
> > >  #include <linux/acpi.h>
> > >  #include <linux/bitmap.h>
> > > +#include <linux/kvm_para.h>
> > >  #include <linux/rcupdate.h>
> > >  #include <asm/e820/api.h>
> > >  #include <asm/pci_x86.h>
> > > @@ -122,6 +123,8 @@ int __init pci_mmcfg_arch_init(void)
> > >               }
> > >
> > >       raw_pci_ext_ops = &pci_mmcfg;
> > > +     if (kvm_para_available())
> > > +             raw_pci_ops = &pci_mmcfg;
> >
> > The idea of using MMCONFIG for *all* config space, not just extended
> > config space, makes sense to me, although the very long discussion at
> > https://lore.kernel.org/lkml/20071225032605.29147200@laptopd505.fenrus.org/
> > makes me wary.  Of course I realize you're talking specifically about
> > KVM, not doing this in general.
> >
> > But it doesn't seem right to make this specific to KVM, since it's not
> > obvious to me that there's a basis in PCI for making this distinction.
> 
> Bugs that were fixed (or more accurately, avoided) by a0ca99096094
> ("PCI x86: always use conf1 to access config space below 256 bytes")
> are still present. And to enable MMCONFIG for the entire config space,
> we need to re-introduce all these fixes or at least identify affected
> devices, which may be impossible.

What *is* about KVM here is that there's no real benefit
to this change if not running on x86 within a hypervisor.
And this should be better documented in a code comment and
commit log.



What is *not* about KVM here is that it's known to be
safe when running on QEMU and on the specific implementation.
Other implementations - even if they are using kvm -
might freeze if you disable memory of the pci host device,
or try to size BARs so they overlap the MMCONFIG.

So to proceed with your approach, I would say either we limit this to
just a known good QEMU device, or disable this when poking at unsafe
registers.

But I have another idea: isn't it true that we can get a large part of
the benefit simply by reading the device/vendor ID through MMCONFIG?
That is almost sure to be safe anyway, even though I would limit it to
just KVM simply because other systems do not benefit.

> 
> We can avoid KVM-specific changes in the generic PCI code by
> implementing x86_init.pci.arch_init inside KVM code, as Vitaly
> suggested. What do you think?
> 
> Best regards, Julia Suvorova.

Makes sense.

-- 
MST

