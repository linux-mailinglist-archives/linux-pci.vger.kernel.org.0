Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E1622E204
	for <lists+linux-pci@lfdr.de>; Sun, 26 Jul 2020 20:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgGZSgH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Jul 2020 14:36:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22346 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgGZSgH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Jul 2020 14:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595788566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CCd534kbcEa29GKpOVkxv14/VG61uCp+SScamUpw60w=;
        b=V1ryFrV5ZYVT9PlszZv2hN5BWSdAjdkwTfuik8vtM1Kw+QaY2e5o8KKrchYBknLLXJu/yp
        oG08n90LY0L0EDPV8CedN+TOcEYl4S0tGPB8o7nhJ8UO5oeqn2k2u4GxCL4k+6vqMiJhyR
        mwkNCRwO5PiIW5ftsK5drpbivFX86EA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-Sxhcr976P2qhuYZbtRtr1w-1; Sun, 26 Jul 2020 14:36:00 -0400
X-MC-Unique: Sxhcr976P2qhuYZbtRtr1w-1
Received: by mail-lf1-f72.google.com with SMTP id o201so3659734lfa.9
        for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2020 11:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CCd534kbcEa29GKpOVkxv14/VG61uCp+SScamUpw60w=;
        b=GN4vCUj7kCQp6Gn2sMgfEoHmLdEEcXtePuAlRUKwZX2J3ak6VCx7Og1Jp7fmyJNnvC
         u1HPu9Avzox4foQKDf+ja8oaLgRoglo2oRHDxNNhEgaEOMlN5z9r9+MICVRJAm/Z3MaC
         NMetPdjLiV4XfDrsziLrONGqb/I0okV65gIIFRvpZH7ET6QFyFBJnJAubZNPVGQNkl1w
         V2k8ZhwbLOv/SzMSTkj74JB5oMopRNvGWFrGu4IHpuWqe3Rl9QUtD1+06Xw3bQ6IaSjT
         ueqf98H3dMLtgX7et4vSoKRAhDwGCv8+n5ZoiJYqtJLSjwbKilH6iXMEeeX/5XGQk8cP
         twkg==
X-Gm-Message-State: AOAM530tNQhE1j4q1vxKSUlIbQ/3+lXVEiUOc91MAMela33uO/jEY4lV
        zxhNZaPr1YGgDn3WE4fJWp+2YKlLYRhjz4v6mIeLHtkDBDWz8v6mgoydnZKx557IY9Clpl2jvUF
        HrVdlF9c7fCb3LC3AuSnp1taZJOI7v6Un7xFY
X-Received: by 2002:a2e:9b92:: with SMTP id z18mr9314065lji.364.1595788559305;
        Sun, 26 Jul 2020 11:35:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1lHoPJwvL5EM6n1PDeRsl+1rX1UoAqAxy4vd1au5G+5bbJterCXOdiLnTTIPwJ6s0wGjsAu/UhtjZxJXB7f8=
X-Received: by 2002:a2e:9b92:: with SMTP id z18mr9314053lji.364.1595788559035;
 Sun, 26 Jul 2020 11:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200722001513.298315-1-jusual@redhat.com> <87d04nq40h.fsf@vitty.brq.redhat.com>
In-Reply-To: <87d04nq40h.fsf@vitty.brq.redhat.com>
From:   Julia Suvorova <jusual@redhat.com>
Date:   Sun, 26 Jul 2020 20:35:47 +0200
Message-ID: <CAMDeoFX0oF3TSfzY8Yifd+9hBhdpKL40t8KFseBj2TsQYRYS8w@mail.gmail.com>
Subject: Re: [PATCH] x86/PCI: Use MMCONFIG by default for KVM guests
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 22, 2020 at 11:43 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Julia Suvorova <jusual@redhat.com> writes:
>
> > Scanning for PCI devices at boot takes a long time for KVM guests. It
> > can be reduced if KVM will handle all configuration space accesses for
> > non-existent devices without going to userspace [1]. But for this to
> > work, all accesses must go through MMCONFIG.
> > This change allows to use pci_mmcfg as raw_pci_ops for 64-bit KVM
> > guests making MMCONFIG the default access method.
> >
> > [1] https://lkml.org/lkml/2020/5/14/936
> >
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
> > +
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
> >
> >       return 1;
> >  }
>
> This implies mmconfig access method is always functional (when present)
> for all KVM guests, regardless of hypervisor version/which KVM userspace
> is is use/... In case the assumption is true the patch looks good (to
> me) but in case it isn't or if we think that more control over this
> is needed we may want to introduce a PV feature bit for KVM.

Ok, I'll introduce a feature bit and turn it on in QEMU.

> Also, I'm thinking about moving this to arch/x86/kernel/kvm.c: we can
> override x86_init.pci.arch_init and reassign raw_pci_ops after doing
> pci_arch_init().

This might be a good idea.

Best regards, Julia Suvorova.

