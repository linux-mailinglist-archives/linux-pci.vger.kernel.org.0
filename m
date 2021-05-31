Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDBC396576
	for <lists+linux-pci@lfdr.de>; Mon, 31 May 2021 18:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbhEaQhW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 12:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbhEaQfZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 May 2021 12:35:25 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC74C07E5F8
        for <linux-pci@vger.kernel.org>; Mon, 31 May 2021 08:00:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso71490pjx.1
        for <linux-pci@vger.kernel.org>; Mon, 31 May 2021 08:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wYKtm4IVSfVTnhnKghH2jNnLIsKH6Y+eNOaILu7ARSY=;
        b=AqMEgYi53g30HYY0imJtzNViu05fOgAo/xQtrrm9XrM3n3KYgdCy6sM36TaTmgv0v6
         XvIYBkRFfNiS9tcDp32kkkQRj9L5R+h86b+EJM1hUjC5ImiLdtusiOsddmyVTjrm3mI6
         HVyluqo0OJwH1PN9FVBpuFPsEkrQe6YRuMK7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wYKtm4IVSfVTnhnKghH2jNnLIsKH6Y+eNOaILu7ARSY=;
        b=f+EmJrER4sCfxzTMu9z+W5pwMkWiAl55xlMYp/lamkjM31iucTfdWSbqTk/pvBW0C/
         VEt6C/G+IGc1r6y4H06T3srpBcso4seRsP8dWs0/dRuPOYMVFxlDYK9aEqsaEeVnC6gf
         fp7lUEXl0fAsUvH7znA3jFm8juPKqaa7C2QT0xmkj/svXnXZafXeZvDc/UYemCibTUV+
         /yZb0O2t6svBbl1MVdjku2yBlBaIrvCWFK8wZIkiGxq+OpdqIAGet8EwMEzseX99m4Yp
         uIRlsBwoQX5xGtSdDZ+mpxAJ4y/XnhWmOFBGwSpmT70UNx5EOZjvodUK9FuRo6GOfhIr
         UUbA==
X-Gm-Message-State: AOAM533xkdzY5S28/2fzwpuqIy2YUn8R9MLijWkh5bsg1HkKu6YyG5Ci
        p8P33TGatR87Lle0yXrTo3CQeANfyo5Fyw==
X-Google-Smtp-Source: ABdhPJynqma72wsqRCuTSS1dU1oirneaa3z5bvL1sCKjfGP1q4dYs3cJN44mka7ONEACR6FlID/XAg==
X-Received: by 2002:a17:902:b70f:b029:f4:5445:cd9f with SMTP id d15-20020a170902b70fb02900f45445cd9fmr21494512pls.32.1622473249644;
        Mon, 31 May 2021 08:00:49 -0700 (PDT)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com. [209.85.215.172])
        by smtp.gmail.com with ESMTPSA id p1sm10896484pfp.137.2021.05.31.08.00.48
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 08:00:49 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id t9so4779457pgn.4
        for <linux-pci@vger.kernel.org>; Mon, 31 May 2021 08:00:48 -0700 (PDT)
X-Received: by 2002:a6b:690c:: with SMTP id e12mr17489820ioc.69.1622473237437;
 Mon, 31 May 2021 08:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-2-tientzu@chromium.org> <170a54f2-be20-ec29-1d7f-3388e5f928c6@gmail.com>
 <20210527130211.GA24344@lst.de> <bab261b4-f801-05af-8fd9-c440ed219591@amd.com>
 <e59d4799-a6ff-6d13-0fed-087fc3482587@amd.com>
In-Reply-To: <e59d4799-a6ff-6d13-0fed-087fc3482587@amd.com>
From:   Claire Chang <tientzu@chromium.org>
Date:   Mon, 31 May 2021 23:00:26 +0800
X-Gmail-Original-Message-ID: <CALiNf29=suiQbDL28tBUXt6-E+-JJC_76X9Uxcdk2s+MSXrp2g@mail.gmail.com>
Message-ID: <CALiNf29=suiQbDL28tBUXt6-E+-JJC_76X9Uxcdk2s+MSXrp2g@mail.gmail.com>
Subject: Re: [PATCH v7 01/15] swiotlb: Refactor swiotlb init functions
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Tomasz Figa <tfiga@chromium.org>, bskeggs@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>, chris@chris-wilson.co.uk,
        Daniel Vetter <daniel@ffwll.ch>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, Jianxiong Gao <jxgao@google.com>,
        joonas.lahtinen@linux.intel.com, linux-pci@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
        rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 28, 2021 at 12:32 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 5/27/21 9:41 AM, Tom Lendacky wrote:
> > On 5/27/21 8:02 AM, Christoph Hellwig wrote:
> >> On Wed, May 19, 2021 at 11:50:07AM -0700, Florian Fainelli wrote:
> >>> You convert this call site with swiotlb_init_io_tlb_mem() which did not
> >>> do the set_memory_decrypted()+memset(). Is this okay or should
> >>> swiotlb_init_io_tlb_mem() add an additional argument to do this
> >>> conditionally?
> >>
> >> The zeroing is useful and was missing before.  I think having a clean
> >> state here is the right thing.
> >>
> >> Not sure about the set_memory_decrypted, swiotlb_update_mem_attributes
> >> kinda suggests it is too early to set the memory decrupted.
> >>
> >> Adding Tom who should now about all this.
> >
> > The reason for adding swiotlb_update_mem_attributes() was because having
> > the call to set_memory_decrypted() in swiotlb_init_with_tbl() triggered a
> > BUG_ON() related to interrupts not being enabled yet during boot. So that
> > call had to be delayed until interrupts were enabled.
>
> I pulled down and tested the patch set and booted with SME enabled. The
> following was seen during the boot:
>
> [    0.134184] BUG: Bad page state in process swapper  pfn:108002
> [    0.134196] page:(____ptrval____) refcount:0 mapcount:-128 mapping:0000000000000000 index:0x0 pfn:0x108002
> [    0.134201] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
> [    0.134208] raw: 0017ffffc0000000 ffff88847f355e28 ffff88847f355e28 0000000000000000
> [    0.134210] raw: 0000000000000000 0000000000000001 00000000ffffff7f 0000000000000000
> [    0.134212] page dumped because: nonzero mapcount
> [    0.134213] Modules linked in:
> [    0.134218] CPU: 0 PID: 0 Comm: swapper Not tainted 5.13.0-rc2-sos-custom #3
> [    0.134221] Hardware name: ...
> [    0.134224] Call Trace:
> [    0.134233]  dump_stack+0x76/0x94
> [    0.134244]  bad_page+0xa6/0xf0
> [    0.134252]  __free_pages_ok+0x331/0x360
> [    0.134256]  memblock_free_all+0x158/0x1c1
> [    0.134267]  mem_init+0x1f/0x14c
> [    0.134273]  start_kernel+0x290/0x574
> [    0.134279]  secondary_startup_64_no_verify+0xb0/0xbb
>
> I see this about 40 times during the boot, each with a different PFN. The
> system boots (which seemed odd), but I don't know if there will be side
> effects to this (I didn't stress the system).
>
> I modified the code to add a flag to not do the set_memory_decrypted(), as
> suggested by Florian, when invoked from swiotlb_init_with_tbl(), and that
> eliminated the bad page state BUG.

Thanks. Will add a flag to skip set_memory_decrypted() in v9.

>
> Thanks,
> Tom
>
> >
> > Thanks,
> > Tom
> >
> >>
