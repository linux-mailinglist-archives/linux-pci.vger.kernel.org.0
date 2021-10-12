Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7A9429B93
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 04:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhJLCmE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 22:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbhJLCmE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 22:42:04 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCA8C061570;
        Mon, 11 Oct 2021 19:40:02 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y12so62145033eda.4;
        Mon, 11 Oct 2021 19:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I8QG1CNS71eJXPXNXyUa1Uy7gCcWD1xLBUuknUfK22Y=;
        b=kgnsXSCYkqVxFo5v6rL8M9P69Zym/oKOA3LkridsxumPS7/+o3te83XYdTnT//jpEe
         4yuJJ1bntWFhloyqRBGJ9HUhjgQVUJmR1F6vN6IgpKyCZZ5uciVvB9N4n1AQTF/OtskB
         axnoAdicsIXgfWNulotfQTWowHqUz6OnqvvbjANSS1I6S+kRBnejsKd1znazKpLSvnhA
         2+vu8QVQX+S5gMLIvMb0tv04RN1kWvSS8Nh02pb0IGrQf2bzph+FcDzUafPc6pcltHO5
         QEbKFLXhF7rULy9hHoELnHrdzM1Xu2ZrfrSRrrzaQjbC3lRUczSd5GYF96/QXYnHaEAs
         CkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I8QG1CNS71eJXPXNXyUa1Uy7gCcWD1xLBUuknUfK22Y=;
        b=pvYnUV/l7PxBO+Qk/ODrk1+tq66T8VzpN+1QAPl2Dp1iF1QPRHVC2gGATc0WcRxSXD
         4R9rS+1eFZyFS+7g4vvcAUdP0ik/Jr3RL9Rkgf7DPCIXFjCe1fVpU43ripv4d89ABZgT
         4NjWXH3SFKZaw5/Sn8ohpJOhR1lCmxVQakZ+32MGi3vS64oMukqgma2ibNaWEhpQPODk
         PbP24qFarPbcSqS6aBClUYwQJzTN2n1apfK+rAhMSEOMyhGvw564iSTuTYXbwRFSOQif
         0bnQopGCVixgioWGzu8bnOg1idumW8FO78RCAjCssXd7FfP3xxtvFx3ASLHsOKUvOKWz
         71fQ==
X-Gm-Message-State: AOAM531XrwBmP3JpJ7ELXwsaRfgqGNeM0cFoibOGqdAhaSxiwoH5aeHE
        RcoDrhjmAZwZL7ML8MMRobXM4z5P+g6gEQK/ACSpCAy6HkM=
X-Google-Smtp-Source: ABdhPJwicVFGX/9VMtEVWUOF6rt0etMGEq+/5g1y29WsPR5EQ4a/UQa1hYt+ux3VGKQmQydcch0Nn+OqAPRBUBjHNxU=
X-Received: by 2002:a17:906:94da:: with SMTP id d26mr1182294ejy.213.1634006397070;
 Mon, 11 Oct 2021 19:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211012020959.GA1708781@bhelgaas> <a6b772d6-edf6-c0a7-078d-0fdbdb9f4f2a@huawei.com>
In-Reply-To: <a6b772d6-edf6-c0a7-078d-0fdbdb9f4f2a@huawei.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 12 Oct 2021 15:39:45 +1300
Message-ID: <CAGsJ_4xx1NVd2m8iBLOG6sf1k_9-254Ro=C-Vb=3LLvZdW9wMA@mail.gmail.com>
Subject: Re: [PATCH] PCI/MSI: fix page fault when msi_populate_sysfs() failed
To:     "wanghai (M)" <wanghai38@huawei.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 12, 2021 at 3:25 PM wanghai (M) <wanghai38@huawei.com> wrote:
>
>
> =E5=9C=A8 2021/10/12 10:09, Bjorn Helgaas =E5=86=99=E9=81=93:
> > On Tue, Oct 12, 2021 at 09:59:40AM +0800, wanghai (M) wrote:
> >> =E5=9C=A8 2021/10/12 1:11, Bjorn Helgaas =E5=86=99=E9=81=93:
> >>> For v2, please note "git log --oneline drivers/pci/msi.c" and make
> >>> your patch follow the style, including capitalization.
> >>>
> >>> On Mon, Oct 11, 2021 at 05:15:28PM +0800, wanghai (M) wrote:
> >>>> =E5=9C=A8 2021/10/11 16:52, Barry Song =E5=86=99=E9=81=93:
> >>>>> On Mon, Oct 11, 2021 at 9:24 PM Wang Hai <wanghai38@huawei.com> wro=
te:
> >>>>>> I got a page fault report when doing fault injection test:
> >>> When you send v2, can you include information about how you injected
> >>> the fault?  If it's easy, others can reproduce the failure that way.
> >> Sorry, the reproduction needs to be based on the fault injection frame=
work
> >> provided by Hulk Robot. I don't know how the framework is implemented.
> >>
> >> The way to reproduce this is to do a fault injection to make
> >> 'msi_attrs =3D kcalloc() in msi_populate_sysfs()' fail when insmod
> >> 9pnet_virtio.ko.
> >>
> >> I sent v2 yesterday, can you help review it?
> >> https://lore.kernel.org/linux-pci/20211011130837.766323-1-wanghai38@hu=
awei.com/
> >>>>>> BUG: unable to handle page fault for address: fffffffffffffff4
> >>>>>> ...
> >>>>>> RIP: 0010:sysfs_remove_groups+0x25/0x60
> >>>>>> ...
> >>>>>> Call Trace:
> >>>>>>     msi_destroy_sysfs+0x30/0xa0
> >>>>>>     free_msi_irqs+0x11d/0x1b0
> >>>>>>     __pci_enable_msix_range+0x67f/0x760
> >>>>>>     pci_alloc_irq_vectors_affinity+0xe7/0x170
> >>>>>>     vp_find_vqs_msix+0x129/0x560
> >>>>>>     vp_find_vqs+0x52/0x230
> >>>>>>     vp_modern_find_vqs+0x47/0xb0
> >>>>>>     p9_virtio_probe+0xa1/0x460 [9pnet_virtio]
> >>>>>>     virtio_dev_probe+0x1ed/0x2e0
> >>>>>>     really_probe+0x1c7/0x400
> >>>>>>     __driver_probe_device+0xa4/0x120
> >>>>>>     driver_probe_device+0x32/0xe0
> >>>>>>     __driver_attach+0xbf/0x130
> >>>>>>     bus_for_each_dev+0xbb/0x110
> >>>>>>     driver_attach+0x27/0x30
> >>>>>>     bus_add_driver+0x1d9/0x270
> >>>>>>     driver_register+0xa9/0x180
> >>>>>>     register_virtio_driver+0x31/0x50
> >>>>>>     p9_virtio_init+0x3c/0x1000 [9pnet_virtio]
> >>>>>>     do_one_initcall+0x7b/0x380
> >>>>>>     do_init_module+0x5f/0x21e
> >>>>>>     load_module+0x265c/0x2c60
> >>>>>>     __do_sys_finit_module+0xb0/0xf0
> >>>>>>     __x64_sys_finit_module+0x1a/0x20
> >>>>>>     do_syscall_64+0x34/0xb0
> >>>>>>     entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>>>>>
> >>>>>> When populating msi_irqs sysfs failed in msi_capability_init() or
> >>>>>> msix_capability_init(), dev->msi_irq_groups will point to ERR_PTR(=
...).
> >>>>>> This will cause a page fault when destroying the wrong
> >>>>>> dev->msi_irq_groups in free_msi_irqs().
> >>>>>>
> >>>>>> Fix this by setting dev->msi_irq_groups to NULL when msi_populate_=
sysfs()
> >>>>>> failed.
> >>>>>>
> >>>>>> Fixes: 2f170814bdd2 ("genirq/msi: Move MSI sysfs handling from PCI=
 to MSI core")
> >>>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
> >>> What exactly was reported by the Hulk Robot?  Did it really do the
> >>> fault injection and report the page fault?
> >> Yes, it reported the error and provided a way to reproduce it
> > Great, can you include a link to that report then?
> > .
> Currently hulk robot is still in the process of continuous improvement an=
d
> is not open to the public for the time being, so you can not access our
> links at the moment. We will open it in the future when it is perfected.

hi hai, would you like to put some information in the commit log like
if  'msi_attrs =3D kcalloc() in msi_populate_sysfs()' fails, blah, blah, bl=
ah...

It seems this can make things a bit clearer to me. Anyway, it doesn't matte=
r
too much. The fix is correct.

>
> --
> Wang Hai
>
Thanks
barry
