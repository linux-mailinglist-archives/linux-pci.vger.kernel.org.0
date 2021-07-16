Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B89B3CB246
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 08:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbhGPGRl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 02:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhGPGRk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jul 2021 02:17:40 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5BFC06175F
        for <linux-pci@vger.kernel.org>; Thu, 15 Jul 2021 23:14:45 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so8893691otl.0
        for <linux-pci@vger.kernel.org>; Thu, 15 Jul 2021 23:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y7ZIMYiJrC3FVTlqT+659hkfizNOQoVm0+TlAQUpe2I=;
        b=SCS13yUTtvUdiiTf4ap1ENsP35kXy1OMRQty8DVOb/rl/9SyY5iMET+17uegADm7oK
         TH7sgAFwFTqhhI4RrPIdiEuWPpBJSrpzEhSsD0YHwVcFMEAn2yzLjpf3TZY1UHR9got/
         s27vZgK1JhJe6nzn01pKnRmN5oa7X96FRY2qFgTmPtnmSP+e+J7R7TMaJDGD289Qfdfr
         E8f7YZWMqMDi0yit2J4JnH7tLLiFFneihCxxqKYhfDu3VmyK+TMIrkU/rL1/s+LxpF4w
         gC0ATVeiDQ54ZNdYdNHwobrvlVXpSm8imy2bfUuyymvkVH6cpoeirpNK23EWmybZ790j
         woDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y7ZIMYiJrC3FVTlqT+659hkfizNOQoVm0+TlAQUpe2I=;
        b=Mah00LKrtBFH3ttSUNbLeJ2e/OhyNhWkruGW8HbT8szTRNFHtEn+kC6ICeOqTbf4sj
         BRlQhjGwywH8GsxFmV+gi33U5Zpl+s37fdkUVkopWZ/nluAUFYZp5DN9h9yCkgafqtUD
         4Yfig1sJ5tYexZ/ZzFiWn9CmRDxXfUGxLzcKVnKuFbNmq+JaNfTE2W1P8GlhHzkHQyCK
         QHmm3XA8odE7EhBglmez+l239EjNqOMDa5X7b/tlkoPaMcg/iLAMUMss3xiLumteWq6l
         Bto1SQJeJ5Nojfj9bteBa4WtLoNsL0Qqa2mXfnMJDb6HOapWfAFQzZ/FDMjcUq+lL3w3
         yPzw==
X-Gm-Message-State: AOAM532S0h3T0dFv0bsobXb9SE4MQ2EAGLJILRJ1E4qloVMacVkfuwdH
        Qm9L/h9P9s1H/pArECb53OX+1Ckg0UjSDdZnXmo=
X-Google-Smtp-Source: ABdhPJw1Wur4tRsGLic3wOVZAb1SIk3bWX+ThnO+/SS/m5PbaO9jT0G/H4CQw/lZzp7rMtCobBqyV7YA9FDak++zr60=
X-Received: by 2002:a05:6830:1df9:: with SMTP id b25mr2357734otj.293.1626416084814;
 Thu, 15 Jul 2021 23:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <CALdZjm6iDnCR7OWzfCuKOALAtN-FoVvTdxUB=XcAFqHg5Aumpw@mail.gmail.com>
 <20210715230506.GA2014923@bjorn-Precision-5520> <20210715170811.5f4f793a.alex.williamson@redhat.com>
In-Reply-To: <20210715170811.5f4f793a.alex.williamson@redhat.com>
From:   Ruben <rubenbryon@gmail.com>
Date:   Fri, 16 Jul 2021 09:14:33 +0300
Message-ID: <CALdZjm6BT6vjC47n9bGRak=6mGTb5Ay9XjM6diEYS=e6NQP-MQ@mail.gmail.com>
Subject: Re: [question]: BAR allocation failing
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

My lord, can't believe that was the answer, all GPUs are successfully
passed through now, thanks Alex!
In case it is of interest, here's the resulting dmesg:
https://drive.google.com/file/d/1b0f4bWPhJXifC8j9_NtB34R7GBA8Dky3/view

For the gal/chap finding this thread in 12 years trying to make an old
machine work:
In the qemu command I added "-cpu host", current kernel parameters
were "rcutree.rcu_idle_gp_delay=1 mem_encrypt=off iommu=off
amd_iommu=off pci=realloc=off,check_enable_amd_mmconf".

On to the next chapter of this machine, which is to enable MMIO
filtering by the hypervisor which is required to make VMs with less
than all resources/GPUs. Luckily NVidia provides 0 detailed
documentation on the matter.

Op vr 16 jul. 2021 om 02:08 schreef Alex Williamson
<alex.williamson@redhat.com>:
>
> On Thu, 15 Jul 2021 18:05:06 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> > On Thu, Jul 15, 2021 at 11:39:54PM +0300, Ruben wrote:
> > > Thanks for the response, here's a link to the entire dmesg log:
> > > https://drive.google.com/file/d/1Uau0cgd2ymYGDXNr1mA9X_UdLoMH_Azn/view
> > >
> > > Some entries that might be of interest:
> >
> > ACPI tells us the host bridge windows are:
> >
> >   acpi PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
> >   acpi PNP0A08:00: host bridge window [mem 0x80000000-0xafffffff window] (ignored)
> >   acpi PNP0A08:00: host bridge window [mem 0xc0000000-0xfebfffff window] (ignored)
> >   acpi PNP0A08:00: host bridge window [mem 0x800000000-0xfffffffff window] (ignored)
> >
> > The 0xc0000000 window is about 1GB and is below 4GB.
> > The 0x800000000 window looks like 32GB.
> >
> > But "pci=nocrs" means we ignore these windows ...
> >
> > > pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffffff]
> >
> > and instead use this 1TB of address space, from which DRAM is
> > excluded.  I think this is basically everything the CPU can address,
> > and I *think* it comes from this in setup_arch():
> >
> >   iomem_resource.end = (1ULL << boot_cpu_data.x86_phys_bits) - 1;
> >
> > But you have 8 GPUs, each of which needs 128GB + 32MB + 16MB, so you
> > need 1TB + 384MB to map them all, and the CPU can't address that much.
> >
> > Since you're running this on qemu, I assume x86_phys_bits is telling
> > us about the capabilities of the CPU qemu is emulating.  Maybe there's
> > a way to tell qemu to emulate a CPU with more address bits?
>
> "-cpu host" perhaps
>
