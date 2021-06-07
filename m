Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B13739D37A
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 05:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhFGDbu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Jun 2021 23:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhFGDbt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Jun 2021 23:31:49 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72227C061787
        for <linux-pci@vger.kernel.org>; Sun,  6 Jun 2021 20:29:20 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id k15so12059179pfp.6
        for <linux-pci@vger.kernel.org>; Sun, 06 Jun 2021 20:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zXJrYShxgIyQHo1wYCS3F9rVjXIqXzIl9+OOmY4aJuc=;
        b=lXhSyF7uZrXQiHjN4kEdhtrYYO4eYXTtv+MmIVlkaYfrDj3gFF3i6zdq9V6t5fEQPA
         Q41l6xsOf6kbnxwhiHTDBcVDInxTuXTZ4PeJVzQkTroJzwWh+Feq2JO3lXBrruik9rJE
         v5bJs9UlwmvhYXAJ0FNY04iCN48TAqVGzZPFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXJrYShxgIyQHo1wYCS3F9rVjXIqXzIl9+OOmY4aJuc=;
        b=WiXzoYeXdfcCJ6wVb39j1wWa8R5a4GFC09woBa8cS+Zl5L2Jij7QIG8exUGyPi4zEw
         u7487QiChfYBRtHH8gBelf5xZCAhdwn7UpG+oRBcvV53dnWKr1mKzRHtyTMYJzc7cZu/
         A6cbFkHHrKdTACPGTrhlsICCoiy1cLOn58SUoL19Ox/s6Iq+ZLH/IbE8SLu40yf7cCCN
         lq/R7RNELTrO5Xzfs+l5mI4PsP26RnIxGAwJxLRPr5jcvtrdEl0DHvcOCgNYWZFmOCMa
         AZImB7zAsdtI70AWJnqkYfGJFrgAakP9dtLGHmzluU6CznGra7dvUeBJdRHvYxyjrBcW
         BHdA==
X-Gm-Message-State: AOAM531Wq8GscIP5d/8TntCG+VrLYQ3II2U3eTqLEF7QtSuIgtkO7PGl
        RMmZ1Zzxbxd9W0DeIAHsuYD4HmjJNSQvmw==
X-Google-Smtp-Source: ABdhPJzFl123RnVTnku/iTe5evvWJ1asWuy334m/DBleGNBvcJZdydxcWYYmTw7T4oy8ozKkxTcwWQ==
X-Received: by 2002:a65:6256:: with SMTP id q22mr16077523pgv.391.1623036557645;
        Sun, 06 Jun 2021 20:29:17 -0700 (PDT)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com. [209.85.210.179])
        by smtp.gmail.com with ESMTPSA id t17sm370694pfg.1.2021.06.06.20.29.15
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 20:29:16 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id z26so12054665pfj.5
        for <linux-pci@vger.kernel.org>; Sun, 06 Jun 2021 20:29:15 -0700 (PDT)
X-Received: by 2002:a05:6e02:1a44:: with SMTP id u4mr1746214ilv.64.1623036543940;
 Sun, 06 Jun 2021 20:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210527125845.1852284-1-tientzu@chromium.org> <20210604174818.GC3703@willie-the-truck>
In-Reply-To: <20210604174818.GC3703@willie-the-truck>
From:   Claire Chang <tientzu@chromium.org>
Date:   Mon, 7 Jun 2021 11:28:53 +0800
X-Gmail-Original-Message-ID: <CALiNf29=z2uBM1ZA_GTu04iFS2dJwH0npdGvid1PL5KQM_HrxA@mail.gmail.com>
Message-ID: <CALiNf29=z2uBM1ZA_GTu04iFS2dJwH0npdGvid1PL5KQM_HrxA@mail.gmail.com>
Subject: Re: [PATCH v8 00/15] Restricted DMA
To:     Will Deacon <will@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
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

On Sat, Jun 5, 2021 at 1:48 AM Will Deacon <will@kernel.org> wrote:
>
> Hi Claire,
>
> On Thu, May 27, 2021 at 08:58:30PM +0800, Claire Chang wrote:
> > This series implements mitigations for lack of DMA access control on
> > systems without an IOMMU, which could result in the DMA accessing the
> > system memory at unexpected times and/or unexpected addresses, possibly
> > leading to data leakage or corruption.
> >
> > For example, we plan to use the PCI-e bus for Wi-Fi and that PCI-e bus is
> > not behind an IOMMU. As PCI-e, by design, gives the device full access to
> > system memory, a vulnerability in the Wi-Fi firmware could easily escalate
> > to a full system exploit (remote wifi exploits: [1a], [1b] that shows a
> > full chain of exploits; [2], [3]).
> >
> > To mitigate the security concerns, we introduce restricted DMA. Restricted
> > DMA utilizes the existing swiotlb to bounce streaming DMA in and out of a
> > specially allocated region and does memory allocation from the same region.
> > The feature on its own provides a basic level of protection against the DMA
> > overwriting buffer contents at unexpected times. However, to protect
> > against general data leakage and system memory corruption, the system needs
> > to provide a way to restrict the DMA to a predefined memory region (this is
> > usually done at firmware level, e.g. MPU in ATF on some ARM platforms [4]).
> >
> > [1a] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_4.html
> > [1b] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_11.html
> > [2] https://blade.tencent.com/en/advisories/qualpwn/
> > [3] https://www.bleepingcomputer.com/news/security/vulnerabilities-found-in-highly-popular-firmware-for-wifi-chips/
> > [4] https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/mediatek/mt8183/drivers/emi_mpu/emi_mpu.c#L132
> >
> > v8:
> > - Fix reserved-memory.txt and add the reg property in example.
> > - Fix sizeof for of_property_count_elems_of_size in
> >   drivers/of/address.c#of_dma_set_restricted_buffer.
> > - Apply Will's suggestion to try the OF node having DMA configuration in
> >   drivers/of/address.c#of_dma_set_restricted_buffer.
> > - Fix typo in the comment of drivers/of/address.c#of_dma_set_restricted_buffer.
> > - Add error message for PageHighMem in
> >   kernel/dma/swiotlb.c#rmem_swiotlb_device_init and move it to
> >   rmem_swiotlb_setup.
> > - Fix the message string in rmem_swiotlb_setup.
>
> Thanks for the v8. It works for me out of the box on arm64 under KVM, so:
>
> Tested-by: Will Deacon <will@kernel.org>
>
> Note that something seems to have gone wrong with the mail threading, so
> the last 5 patches ended up as a separate thread for me. Probably worth
> posting again with all the patches in one place, if you can.

Thanks for testing.

Christoph also added some comments in v7, so I'll prepare v9.

>
> Cheers,
>
> Will
