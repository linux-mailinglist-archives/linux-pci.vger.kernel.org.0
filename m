Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C00722E219
	for <lists+linux-pci@lfdr.de>; Sun, 26 Jul 2020 20:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgGZS7D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Jul 2020 14:59:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53846 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726081AbgGZS7D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Jul 2020 14:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595789941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MnkAVzbcQmzJaGdzKxUV0o/LhPkQD/MG1aQW4yPzWQI=;
        b=igQyJlBz+T5lpGltY3NhPTdxb2mEwYOYwJb0RqA6a8dcSbnzophQ3+FBI9JVn31V26ByyM
        vEd1ySEacE2zAknIOg9+nWCWcBjRzg3vNQAChiAk7wSCcPYz8K07qHUrlan0pRU2qBWIdz
        xsyfsy3LuqHeoZqp1pVW9Fmz+az6gLc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-ohneoBNYP56ANAVjDvcmKQ-1; Sun, 26 Jul 2020 14:58:57 -0400
X-MC-Unique: ohneoBNYP56ANAVjDvcmKQ-1
Received: by mail-lf1-f69.google.com with SMTP id x13so3668424lfq.3
        for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2020 11:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MnkAVzbcQmzJaGdzKxUV0o/LhPkQD/MG1aQW4yPzWQI=;
        b=r/HeuroYsUgjJ5lD9DNTlONJaw3oyGDN+AVgr8r2n6toTfTzYBjfNCxfiPUbqnoXvn
         tU2OYh8pqgLB8bDTNkwXbdXqYkhLySOLxqEmBWyoUYwVIqn2taE8LvQPoE52a3E9+Lj0
         jd2VbkOvntDH62HHteyJOpHecQAHeq3Ot7nt0ADL3AOBi7K2AcEIGxz6gp8nAGH+xASY
         Z+yGbtvNlc1LWgmYHQ4wB4sGtPnoZ9Ca3E1yRHUCsxLEDSizACD3llwXALVHFZ4VOih3
         z6ijAywP/g0w0x0z6wji4682OKOLLhFR6ZXKijUp/DCn7RRoxDlA0RzAMAz9MWAR5Bz2
         smzg==
X-Gm-Message-State: AOAM532LQFubZhV5CvT8hNGqTk+SBIx5qfI78sTPAZKVGX5xz9KjbMpo
        2j7ABGv5UohuUYZBwn3NveBVAE+/NoXHJ8IWEy++RgQ1xS2tK/tMACtJTY2u4C1aEjMvMnyP/tZ
        /JJ5CZcheWaAeJyATSSVEyLkrQbQAnAWDeMdK
X-Received: by 2002:a19:cc9:: with SMTP id 192mr10065161lfm.61.1595789936241;
        Sun, 26 Jul 2020 11:58:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoAU0F4Ib7Y/A1tK4UvEwFvUVRP7nlxAUZAt9rZgjV7Xt99Rt0nAxaSItJ8sR8FbQvjEju4c0GJyrk4aOUV4M=
X-Received: by 2002:a19:cc9:: with SMTP id 192mr10065155lfm.61.1595789936004;
 Sun, 26 Jul 2020 11:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200722001513.298315-1-jusual@redhat.com> <20200722231929.GA1314067@bjorn-Precision-5520>
In-Reply-To: <20200722231929.GA1314067@bjorn-Precision-5520>
From:   Julia Suvorova <jusual@redhat.com>
Date:   Sun, 26 Jul 2020 20:58:45 +0200
Message-ID: <CAMDeoFUCanfvrxAmW4_QH=L9BExCAydCifE_tvRaW_XTd0OQXw@mail.gmail.com>
Subject: Re: [PATCH] x86/PCI: Use MMCONFIG by default for KVM guests
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 23, 2020 at 1:19 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Jul 22, 2020 at 02:15:13AM +0200, Julia Suvorova wrote:
> > Scanning for PCI devices at boot takes a long time for KVM guests. It
> > can be reduced if KVM will handle all configuration space accesses for
> > non-existent devices without going to userspace [1]. But for this to
> > work, all accesses must go through MMCONFIG.
> > This change allows to use pci_mmcfg as raw_pci_ops for 64-bit KVM
> > guests making MMCONFIG the default access method.
>
> The above *looks* like it's intended to be two paragraphs, which would
> be easier to read with a blank line between.
>
> The last sentence should say what the patch actually *does*, e.g.,
> "Use pci_mmcfg as raw_pci_ops ..."
>
> > [1] https://lkml.org/lkml/2020/5/14/936
>
> Please use a lore.kernel.org URL instead because it's more usable and
> I'd rather depend on kernel.org than lkml.org.
>
> > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > ---
> >  arch/x86/pci/direct.c      | 5 +++++
> >  arch/x86/pci/mmconfig_64.c | 3 +++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/arch/x86/pci/direct.c b/arch/x86/pci/direct.c
> > index a51074c55982..8ff6b65d8f48 100644
> > --- a/arch/x86/pci/direct.c
> > +++ b/arch/x86/pci/direct.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/pci.h>
> >  #include <linux/init.h>
> >  #include <linux/dmi.h>
> > +#include <linux/kvm_para.h>
> >  #include <asm/pci_x86.h>
> >
> >  /*
> > @@ -264,6 +265,10 @@ void __init pci_direct_init(int type)
> >  {
> >       if (type == 0)
> >               return;
> > +
> > +     if (raw_pci_ext_ops && kvm_para_available())
> > +             return;
> >       printk(KERN_INFO "PCI: Using configuration type %d for base access\n",
> >                type);
> >       if (type == 1) {
> > diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
> > index 0c7b6e66c644..9eb772821766 100644
> > --- a/arch/x86/pci/mmconfig_64.c
> > +++ b/arch/x86/pci/mmconfig_64.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/init.h>
> >  #include <linux/acpi.h>
> >  #include <linux/bitmap.h>
> > +#include <linux/kvm_para.h>
> >  #include <linux/rcupdate.h>
> >  #include <asm/e820/api.h>
> >  #include <asm/pci_x86.h>
> > @@ -122,6 +123,8 @@ int __init pci_mmcfg_arch_init(void)
> >               }
> >
> >       raw_pci_ext_ops = &pci_mmcfg;
> > +     if (kvm_para_available())
> > +             raw_pci_ops = &pci_mmcfg;
>
> The idea of using MMCONFIG for *all* config space, not just extended
> config space, makes sense to me, although the very long discussion at
> https://lore.kernel.org/lkml/20071225032605.29147200@laptopd505.fenrus.org/
> makes me wary.  Of course I realize you're talking specifically about
> KVM, not doing this in general.
>
> But it doesn't seem right to make this specific to KVM, since it's not
> obvious to me that there's a basis in PCI for making this distinction.

Bugs that were fixed (or more accurately, avoided) by a0ca99096094
("PCI x86: always use conf1 to access config space below 256 bytes")
are still present. And to enable MMCONFIG for the entire config space,
we need to re-introduce all these fixes or at least identify affected
devices, which may be impossible.

We can avoid KVM-specific changes in the generic PCI code by
implementing x86_init.pci.arch_init inside KVM code, as Vitaly
suggested. What do you think?

Best regards, Julia Suvorova.

