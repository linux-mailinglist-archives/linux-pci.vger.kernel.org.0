Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8176D3A7593
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 06:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhFOEIl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 00:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhFOEIg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jun 2021 00:08:36 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796EDC061574
        for <linux-pci@vger.kernel.org>; Mon, 14 Jun 2021 21:06:31 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c138so27856923qkg.5
        for <linux-pci@vger.kernel.org>; Mon, 14 Jun 2021 21:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YDA/6rYFbIzGwN3DJJ3v30Ilg60B464lccTuq9RZZyA=;
        b=fMG07OU4hKhOT0Ejr3qOHcrU08EN3G1+RpniZ8liKpsJESj8tYmvpPMQZbf905Arqa
         jTNjk7/cw8NTc05aXCrTOb4W4H63TAdnEqedfWvkUqde8aQCNzpKVfF+WTvNV5ptv2qS
         TsIum45Bdbkm1pBXJPvJDobZEXMxEtOKj24Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDA/6rYFbIzGwN3DJJ3v30Ilg60B464lccTuq9RZZyA=;
        b=GyYheQ7VUA4Adv3fzpi1B1qhcKMNgZdbH92zJBxsNbwZH1oGiHzyx++eij4kwrvuiP
         86KOLm4tKUZSoWo4fXGditScxWAzVSkeutAYnLeVmOgDpkSLRZpPyxJj9N1DZjxy8SJ0
         M5XgiEBUGnZUbFF6yX9YT+oR+LefHXNjUbStcgbwnYqJnwOFuRylPKfPBJqhBG6lr31d
         K8QDB2le7OCM6RbR+zWX3RdWDGC1MHl9AvOdRQR9nBPxU/606ba96StQ1NxsKQHLrvlp
         lGmXMiT5hdrGj+zvzkq1icmU6UB4mqO2Va2u5SkDuLnpX3VoKZNbE4OQe47IKmmO+IkC
         uGqA==
X-Gm-Message-State: AOAM532urzPG0sIM8BHDWNrVJ5GXmioxQq7nqIiQZUd57moUEMlhAwwU
        /RWEIlHR+JginEQI04aC4jw0YdxdB4+Tdg==
X-Google-Smtp-Source: ABdhPJyg5AxLj+sJTNB4hLKXwq6cC81YM7IeStMkaeqy5jiKvwUszFV5LbVGfwx15tVWWP/7ka3w3g==
X-Received: by 2002:a37:6609:: with SMTP id a9mr20039762qkc.459.1623729990511;
        Mon, 14 Jun 2021 21:06:30 -0700 (PDT)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com. [209.85.222.174])
        by smtp.gmail.com with ESMTPSA id k124sm11348500qkc.132.2021.06.14.21.06.28
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 21:06:29 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id g19so7936377qkk.2
        for <linux-pci@vger.kernel.org>; Mon, 14 Jun 2021 21:06:28 -0700 (PDT)
X-Received: by 2002:a02:384b:: with SMTP id v11mr19686288jae.90.1623729977741;
 Mon, 14 Jun 2021 21:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210611152659.2142983-1-tientzu@chromium.org>
 <20210611152659.2142983-2-tientzu@chromium.org> <20210614061644.GA28343@lst.de>
In-Reply-To: <20210614061644.GA28343@lst.de>
From:   Claire Chang <tientzu@chromium.org>
Date:   Tue, 15 Jun 2021 12:06:06 +0800
X-Gmail-Original-Message-ID: <CALiNf29cE-T7xf+nUZF2pjT8osaXj+wb4MibtdSkAU_K13wuMw@mail.gmail.com>
Message-ID: <CALiNf29cE-T7xf+nUZF2pjT8osaXj+wb4MibtdSkAU_K13wuMw@mail.gmail.com>
Subject: Re: [PATCH v9 01/14] swiotlb: Refactor swiotlb init functions
To:     Christoph Hellwig <hch@lst.de>
Cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
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

On Mon, Jun 14, 2021 at 2:16 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jun 11, 2021 at 11:26:46PM +0800, Claire Chang wrote:
> > +     spin_lock_init(&mem->lock);
> > +     for (i = 0; i < mem->nslabs; i++) {
> > +             mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
> > +             mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
> > +             mem->slots[i].alloc_size = 0;
> > +     }
> > +
> > +     if (memory_decrypted)
> > +             set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
> > +     memset(vaddr, 0, bytes);
>
> We don't really need to do this call before the memset.  Which means we
> can just move it to the callers that care instead of having a bool
> argument.
>
> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks for the review. Will wait more days for other reviews and send
v10 to address the comments in this and other patches.
