Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDF538F87B
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 05:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhEYDJ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 May 2021 23:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhEYDJ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 May 2021 23:09:57 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911ACC061574
        for <linux-pci@vger.kernel.org>; Mon, 24 May 2021 20:08:27 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e10so25253536ilu.11
        for <linux-pci@vger.kernel.org>; Mon, 24 May 2021 20:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VHDFyefEfXv2T1h/kXDPOn5vVw8tSm/6FW05x+E2j40=;
        b=merHIeKNi5Uu6C9TAUujDNIN9FxrI34YUx7aW4WyFELIyYppIt99C4UwGvzWaArcmu
         9EaYZFbnrmtDjrMZ7c8349ke6DKJjWiZDCUD5epOu2PqMIr5kYM1CoXZ0XNE1vQ3QFiu
         bvf2bDyHaIMES3MNNrHcengJbyjgwpDl3VY20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHDFyefEfXv2T1h/kXDPOn5vVw8tSm/6FW05x+E2j40=;
        b=IwkcWzfV7t2nD0+DmsXmBxoLqUgtG0md55EfYVf41lahMtNXwMI61qZ3cqL+ocX9QW
         LpUELr0IsP2ovlQA7r2+y3bavb1SIVy66N7y076bIUt/Ss9iIjyxpLBHcgzlgAdA/k6o
         C9G08MsVYWz8RuWPCmhZ8lUkroQBYbbkECMkx7Sp0OVwNwnSYd37gmjm9kDzznJXH+Fw
         Y6hOd1wxNf67aD49i0KtOfz5pfWE7HXKtaoBVNFUW6aSh7t0lEbrEntDlSZgeIrciIAF
         u6XhP5mnPfsA7XZABevIoyqBYUQef7UzJ/tagAFMVMAAg4qxaHxGmqFCgxRjZa/1uA7Z
         8g6g==
X-Gm-Message-State: AOAM533MQZuaXjKaYTDUxE6g4NxwX3qQTq13cTrgTNygzrS5MYQeoTYq
        tQ7nKjQ1VXJIcgFqco19PpwY15jFLGPWAw==
X-Google-Smtp-Source: ABdhPJymLNBa0bZuNCjQL/l63QEI51+vTlTPYOKmXaHUMj8m2tXO+rc/qsscj8CeKN76n6jKMIrHuw==
X-Received: by 2002:a05:6e02:d:: with SMTP id h13mr17418888ilr.112.1621912106353;
        Mon, 24 May 2021 20:08:26 -0700 (PDT)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com. [209.85.166.182])
        by smtp.gmail.com with ESMTPSA id j4sm12381230iom.28.2021.05.24.20.08.25
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 20:08:25 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id h11so26847526ili.9
        for <linux-pci@vger.kernel.org>; Mon, 24 May 2021 20:08:25 -0700 (PDT)
X-Received: by 2002:a6b:7b08:: with SMTP id l8mr16990516iop.50.1621912094090;
 Mon, 24 May 2021 20:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-2-tientzu@chromium.org> <170a54f2-be20-ec29-1d7f-3388e5f928c6@gmail.com>
 <CALiNf2-9fRbH3Xs=fA+N1iRztFxeC0iTsyOSZFe=F42uwXS0Sg@mail.gmail.com> <YKvL865kutnHqkVc@0xbeefdead.lan>
In-Reply-To: <YKvL865kutnHqkVc@0xbeefdead.lan>
From:   Claire Chang <tientzu@chromium.org>
Date:   Tue, 25 May 2021 11:08:03 +0800
X-Gmail-Original-Message-ID: <CALiNf2_iq3OS+95as4fj+AOMDVYgGL71A1811QLaZ=5T7TRjww@mail.gmail.com>
Message-ID: <CALiNf2_iq3OS+95as4fj+AOMDVYgGL71A1811QLaZ=5T7TRjww@mail.gmail.com>
Subject: Re: [PATCH v7 01/15] swiotlb: Refactor swiotlb init functions
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
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

On Mon, May 24, 2021 at 11:53 PM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> > > do the set_memory_decrypted()+memset(). Is this okay or should
> > > swiotlb_init_io_tlb_mem() add an additional argument to do this
> > > conditionally?
> >
> > I'm actually not sure if this it okay. If not, will add an additional
> > argument for it.
>
> Any observations discovered? (Want to make sure my memory-cache has the
> correct semantics for set_memory_decrypted in mind).

It works fine on my arm64 device.

> >
> > > --
> > > Florian
