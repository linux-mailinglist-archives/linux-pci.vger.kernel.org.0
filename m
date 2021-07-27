Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D5E3D7210
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jul 2021 11:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbhG0Jcr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 05:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235978AbhG0Jcr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jul 2021 05:32:47 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDB1C061757
        for <linux-pci@vger.kernel.org>; Tue, 27 Jul 2021 02:32:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id e25-20020a05600c4b99b0290253418ba0fbso1861500wmp.1
        for <linux-pci@vger.kernel.org>; Tue, 27 Jul 2021 02:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7V1+oT8Gnfx8nQS+XIebppNw7U7+KNMB6DIEoXLsFSc=;
        b=HNkifKAimGeeuW8h4B8qIDheTCDpoh7lH3CzG2PXYzqjBzqixlZ1nAFlvGIxhLPt+/
         dcES1eEmo3ScGVT8qnSaWeK8ZixeUqpeRvnX55lbVHIypQG5Pbj3IOrUPKQJSOcU52Yg
         1bwbT2HEkmm/HhcXeh5FwHpIdFX6K5ZmnA3uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7V1+oT8Gnfx8nQS+XIebppNw7U7+KNMB6DIEoXLsFSc=;
        b=QbDSo5fVfBfU/Nqq1TGHXIIJHZ3TBjOX2YMMfTwNLYmxf+rCU5BqxfPwTXwegiili1
         sfc3XlXEFrFCR4i//dD2EMMNU2sZwSH5OiFfuPYed7+GRPoIJMyjIDn3S7ddJJOB68Bs
         9vqjZjaMMdXq6LmwRlXRhfWSTl9J4MHYYjv0bxB0WALUoAYSNesfvlZWnEZf+Mc6Pvmp
         JUTe4LHGRk0oQonFLLXzsMUkCG/+uDb8762B7HU/zrdndU8vpmUfS+pIjHPr/DGdaA0F
         ZJ0rWf/tG6A4pBLrq0vWQ5xM5wRnqnWGkx6bnOpBnYjD0z4wybOtNNap/ghK9NAPJo97
         3a3Q==
X-Gm-Message-State: AOAM532babuJWsqUsYjsHGmpspWZx3XYXkINYkGq2ANhfkuj0x+KNuBh
        xFQhJpB4J46PkjuFuiqpDnkAxQ==
X-Google-Smtp-Source: ABdhPJyg+MHd7+8t3ROjosQmL6/+KEXfTM+SXpVk39LMkdOMlevMi36n0sxQDh7p4O1o9tLS3hHhvg==
X-Received: by 2002:a05:600c:3b9b:: with SMTP id n27mr3152796wms.188.1627378366177;
        Tue, 27 Jul 2021 02:32:46 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c16sm2533347wru.82.2021.07.27.02.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 02:32:45 -0700 (PDT)
Date:   Tue, 27 Jul 2021 11:32:43 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Christoph Hellwig <hch@infradead.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        David Airlie <airlied@linux.ie>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/9] PCI/VGA: Rework default VGA device selection
Message-ID: <YP/SuzIY9VRReufC@phenom.ffwll.local>
References: <YPp9XCa+1kS/s3wK@phenom.ffwll.local>
 <20210723224335.GA446523@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723224335.GA446523@bjorn-Precision-5520>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 23, 2021 at 05:43:35PM -0500, Bjorn Helgaas wrote:
> On Fri, Jul 23, 2021 at 10:27:08AM +0200, Daniel Vetter wrote:
> > On Fri, Jul 23, 2021 at 06:51:59AM +0100, Christoph Hellwig wrote:
> > > On Thu, Jul 22, 2021 at 04:29:11PM -0500, Bjorn Helgaas wrote:
> > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > 
> > > > This is a little bit of rework and extension of Huacai's nice work at [1].
> > > > 
> > > > It moves the VGA arbiter to the PCI subsystem, fixes a few nits, and breaks
> > > > a few pieces off Huacai's patch to make the main patch a little smaller.
> > > > 
> > > > That last patch is still not very small, and it needs a commit log, as I
> > > > mentioned at [2].
> > > 
> > > FYI, I have a bunch of changes to this code that the drm maintainers
> > > picked up.  They should show up in the next linux-next I think.
> > 
> > Yeah I think for merging I think there'll be two options:
> > 
> > - We also merge this series through drm-misc-next to avoid conflicts, but
> >   anything after that will (i.e. from 5.16-rc1 onwards) will go in through
> >   the pci tree.

I meant 5.15-rc1 here ofc. Living a bit too much in the future :-)

> > - You also merge Christoph's series, and we tell Linus to ignore the
> >   vgaarb changes that also come in through drm-next pull.
> > 
> > It's a non-rebasing tree so taking them out isn't an option, and reverting
> > feels silly. Either of the above is fine with me.
> 
> Seems easiest/cleanest if I just fix this up so it applies on top of
> drm-misc-next, e.g., on top of this:
> 
>   474596fc749c ("dt-bindings: display: simple-bridge: Add corpro,gm7123 compatible")
> 
> I'll post a v3 after that rebase and working on the commit log from
> Huacai.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
