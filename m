Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D818E3A90FD
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 07:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhFPFMe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 01:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhFPFMd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jun 2021 01:12:33 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD5EC061574
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 22:10:27 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id q16so1353879qkm.9
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 22:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iLn8eUCvJy2CWcSIXe6ohsWZex4qVXD74p7z6FMJPUo=;
        b=jDOToH5ThQyIZ/Z8kPwh8R97YYJUPgyXIvwYI7ELfesGT1LRFmc0oQizSpW5Du/1jT
         n8n511S9H2jKWIPPzwbEGsCQVrh6jqMZwL99GOCEoFmIgU2xBUW+YvuQbG8TA+PazhFY
         uMdw/pNT41Ub0lKjlBja/JS0DV7IUisf06CVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iLn8eUCvJy2CWcSIXe6ohsWZex4qVXD74p7z6FMJPUo=;
        b=CyJ9BbSwAa7CpeBv1CuEUTiWWpTyTCNPdupphl/2ktHULw3K81mfyDFJnnbr4Sw2ZM
         9A+65jrquZk4hzf02PIdvWsirvlNcAUCaTGkae4+Xdyl5DgLsK+G+vxbz/syuzW66+1d
         5lYTeTiHDEo3BNYX/oDUyBuw9X/a0pbh4UraRmcZehGBjiWfOKxNjFyPuvU08O+vT7Lo
         UAGU6c09megWIVVzNh/hBLJlpvoMpIyaIg2C/D+6W0m0VwaDhRUApp+khTXs7Ira6nHG
         xN1i3qSUrPZ/YXBUmtO0WEPAHJUVPvROFyV26n08HPfSzNnazdiuQJS4k98gw8Kp/ydo
         xLcQ==
X-Gm-Message-State: AOAM531lAefUC+Gv2bqiIRQZLa3YgUJSAbLb+yX9DlBrsfiZVfzcxu1g
        y0zgK6nNrWeFIlwJhU+Tw7xMZfzo34Rs0w==
X-Google-Smtp-Source: ABdhPJxaVWgeh3hRsm3WEgrxx8czZqsMC0jAHCEwhFhodLDLDIpct0d2BT3ttodqXMIHA+cpV2Pn4A==
X-Received: by 2002:a05:620a:1003:: with SMTP id z3mr3446520qkj.490.1623820226752;
        Tue, 15 Jun 2021 22:10:26 -0700 (PDT)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com. [209.85.222.174])
        by smtp.gmail.com with ESMTPSA id x20sm586049qta.91.2021.06.15.22.10.24
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 22:10:25 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id k11so1412861qkk.1
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 22:10:24 -0700 (PDT)
X-Received: by 2002:a05:6638:151:: with SMTP id y17mr2452891jao.128.1623820213046;
 Tue, 15 Jun 2021 22:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210616035240.840463-1-tientzu@chromium.org> <20210616035240.840463-10-tientzu@chromium.org>
 <CALiNf28=3vqAs+8HsjyBGOiPNR2F3yT6OGnLpZH_AkWqgTqgOA@mail.gmail.com> <20210616045918.GA27537@lst.de>
In-Reply-To: <20210616045918.GA27537@lst.de>
From:   Claire Chang <tientzu@chromium.org>
Date:   Wed, 16 Jun 2021 13:10:02 +0800
X-Gmail-Original-Message-ID: <CALiNf2-+vL8rw5fi=DcR=V7d55Ls3-OXoxC87Pvrf1Kz14D_+A@mail.gmail.com>
Message-ID: <CALiNf2-+vL8rw5fi=DcR=V7d55Ls3-OXoxC87Pvrf1Kz14D_+A@mail.gmail.com>
Subject: Re: [PATCH v11 09/12] swiotlb: Add restricted DMA alloc/free support
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

On Wed, Jun 16, 2021 at 12:59 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Jun 16, 2021 at 12:04:16PM +0800, Claire Chang wrote:
> > Just noticed that after propagating swiotlb_force setting into
> > io_tlb_default_mem->force, the memory allocation behavior for
> > swiotlb_force will change (i.e. always skipping arch_dma_alloc and
> > dma_direct_alloc_from_pool).
>
> Yes, I think we need to split a "use_for_alloc" flag from the force flag.

How about splitting is_dev_swiotlb_force into is_swiotlb_force_bounce
(io_tlb_mem->force_bounce) and is_swiotlb_force_alloc
(io_tlb_mem->force_alloc)?
