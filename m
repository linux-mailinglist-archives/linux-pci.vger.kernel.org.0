Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF5422F424
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 17:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgG0P4D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 11:56:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37640 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726879AbgG0P4D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2020 11:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595865361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TDBVj7bHt6Fay5LTDY6rfY9vuNNASLukydt89FqrzTY=;
        b=FyyQuaCNsdE/RiOMS182A8+8gpLFjwuOWtbOuz5FxvGB2qgYJjFLopH8ludxyeH70boVhJ
        yY4cjhu0XKZd6/qztwVHvZVctX+U/ZlOpb+PkpEDFmaUyuq64N+0byNwsV91+3WDNlgTmZ
        /H/vlDcqhSIuhR5zD41ilIHX0KT+SEM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-pzIAASKbP-GiX3PT9icEWQ-1; Mon, 27 Jul 2020 11:55:58 -0400
X-MC-Unique: pzIAASKbP-GiX3PT9icEWQ-1
Received: by mail-ed1-f71.google.com with SMTP id z12so5779399edk.4
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2020 08:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=TDBVj7bHt6Fay5LTDY6rfY9vuNNASLukydt89FqrzTY=;
        b=J5lYdWHjnW/L2ezzTcqOJ+KT2Mn+AsAYrv1NWeh/nKbdQWfbCaeQg7dJyadThwHBJM
         Lw3NksUe1dJxubqmy7Gbu+0zqD6sliBcWeixBXAHOmWQNjw8qYGQiiw+eMXpfQZx5vxm
         0QwKqVQi0VoB5DmLvMvANj8N+UPsCLidxASioToApElJBTmidFomBetVSzHd/Mh5IkAI
         0eHDz3QuEtH61y+iRtxrra4zaP95rBENN+nmxcvUz0Wh40ORz+Zf8r5B8hdoergV1lAW
         BfG+m3e4/SL3IQsO2EYXXu3z4F1qMJCxX8J57woTnCHWRFQCp3ekjPkGpQ/9x86+UR8h
         RInA==
X-Gm-Message-State: AOAM530hE8XBLFpP3lPVeOgiuaTHI4EVWTqcCIjdOyoFl2NTUvPqxcoY
        7CbTQ5xSghCkuNTOrzgdy4sGpkj7CtGWQtKT9aucDQugQCZP3RJ0Vhe3C+x66so7wlUCsIFYxwH
        HXmcnJCZhepaSOxqrnOnh
X-Received: by 2002:a17:906:8316:: with SMTP id j22mr2275457ejx.20.1595865356851;
        Mon, 27 Jul 2020 08:55:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYP4hsrj5jhbksZ3bHS+m22n8MBnPkqWri7tfe/lVqT8nyCOh1YNkb5qxrkUlGB6A+j62Chg==
X-Received: by 2002:a17:906:8316:: with SMTP id j22mr2275433ejx.20.1595865356545;
        Mon, 27 Jul 2020 08:55:56 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a1sm7311678ejk.125.2020.07.27.08.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 08:55:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Julia Suvorova <jusual@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "open list\:VFIO DRIVER" <kvm@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] x86/PCI: Use MMCONFIG by default for KVM guests
In-Reply-To: <CAHp75VfLjYvFUVw+uHbMJCeoNfs6nb4Qh1OoQraA5bTkR9SeRg@mail.gmail.com>
References: <20200722001513.298315-1-jusual@redhat.com> <87d04nq40h.fsf@vitty.brq.redhat.com> <CAHp75VfLjYvFUVw+uHbMJCeoNfs6nb4Qh1OoQraA5bTkR9SeRg@mail.gmail.com>
Date:   Mon, 27 Jul 2020 17:55:55 +0200
Message-ID: <87lfj5lzp0.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Wed, Jul 22, 2020 at 12:47 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> Julia Suvorova <jusual@redhat.com> writes:
>
>> > Scanning for PCI devices at boot takes a long time for KVM guests. It
>> > can be reduced if KVM will handle all configuration space accesses for
>> > non-existent devices without going to userspace [1]. But for this to
>> > work, all accesses must go through MMCONFIG.
>> > This change allows to use pci_mmcfg as raw_pci_ops for 64-bit KVM
>> > guests making MMCONFIG the default access method.
>
> I'm not sure it won't break anything.

It likely will as it's really hard to check all possible KVM
configurations in existence and that's why we are converging on adding a
feature bit which KVM userspace (e.g. QEMU) will set when the
configuration is known to be good.

>
>> > [1] https://lkml.org/lkml/2020/5/14/936
>
> use Link: tag and better to use lore.kernel.org.
>
>> This implies mmconfig access method is always functional (when present)
>> for all KVM guests, regardless of hypervisor version/which KVM userspace
>> is is use/... In case the assumption is true the patch looks good (to
>> me) but in case it isn't or if we think that more control over this
>> is needed we may want to introduce a PV feature bit for KVM.
>>
>> Also, I'm thinking about moving this to arch/x86/kernel/kvm.c: we can
>> override x86_init.pci.arch_init and reassign raw_pci_ops after doing
>> pci_arch_init().
>
> % git grep -n -w x86_init.pci.arch_init -- arch/x86/
> arch/x86/hyperv/hv_init.c:400:  x86_init.pci.arch_init = hv_pci_init;
> arch/x86/kernel/apic/apic_numachip.c:203:       x86_init.pci.arch_init
> = pci_numachip_init;
> arch/x86/kernel/jailhouse.c:207:        x86_init.pci.arch_init
>  = jailhouse_pci_arch_init;
> arch/x86/pci/init.c:20: if (x86_init.pci.arch_init && !x86_init.pci.arch_init())
> arch/x86/platform/intel-mid/intel-mid.c:172:    x86_init.pci.arch_init
> = intel_mid_pci_init;
> arch/x86/platform/olpc/olpc.c:309:              x86_init.pci.arch_init
> = pci_olpc_init;
> arch/x86/xen/enlighten_pv.c:1411:
> x86_init.pci.arch_init = pci_xen_init;
>
> Are you going to update all these? Or how this is supposed to work (I
> may be missing something)?

My suggestion was to do exactly the same for KVM guests instead of
switching ops in pci_mmcfg_arch_init() depending on kvm_para_available()
output. Basically, keep all KVM-related tunings in one place
(arch/x86/kernel/kvm.c).

-- 
Vitaly

