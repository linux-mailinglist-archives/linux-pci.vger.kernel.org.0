Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5754238F880
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 05:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhEYDK1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 May 2021 23:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhEYDK0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 May 2021 23:10:26 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A557C061574
        for <linux-pci@vger.kernel.org>; Mon, 24 May 2021 20:08:57 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q6so16001240pjj.2
        for <linux-pci@vger.kernel.org>; Mon, 24 May 2021 20:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ibLnJElvlxlVpclpJPUNJ2cC/oiUOQSOujwiFR/Tp+s=;
        b=UieisilkjhqvCv5TM4Uhta7TWRN2Fo+qizEnyHuJxA4va8bXfSD+rLVykfuHhWprMs
         LshPVy4dFsoXIkmd56qov4ggYtlL759ArIJ4nJdiIlOu+d8oU3Tdh/1w/BJ1fDxfpbcA
         V3s9TTUmNV6cOGqUjcXpB0nmY9PGjsUH8vbqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ibLnJElvlxlVpclpJPUNJ2cC/oiUOQSOujwiFR/Tp+s=;
        b=Hp7E5+5HRlp+JLp2KRSqEvz7cx3J8+rvBt/bzJjS2hZ0jzLTCdEFcDo8qc5vyuvMdb
         h65G+pfGB3fY0bS2dTS0DkZ318aBUEjh9QSTZ1wio+/z7Ne6ZvE3q4VfDp3VTAG7o5hh
         KtbpTkoNijqxnllssm9qmYBs6Yp5gAGTSb+ijuX4ln87E4xI5HGRD5QB75utAAJXP8d7
         MUTAwjW/0MnUMxSuJ22hOvZESeRmi23a7SomqMZSKlNUq+qQjF6TQ0f/Z6xbRAbT2mvZ
         mct2oi/BvuUtapT2x1vLbUmAQM65/oGLLjlMh8aLvIBoCK8EdOmmRoWvXISgbl3lJ67T
         PgVg==
X-Gm-Message-State: AOAM530ZiuzCGipoNvrwfipgAqT1jy0K2WWrzNukJMMC5okXyQmC5C+2
        rFqsY8TBhbvXwRpBJUqZ6eycXP5Rgw6Viw==
X-Google-Smtp-Source: ABdhPJzACSWc/Zx0xnn4t5kfAguUnMO+Q0wcPmejp8njqRFeR6MXci8F5meC0vtbq/45J3U8Z0w2Jw==
X-Received: by 2002:a17:902:b20a:b029:f4:8b9a:5bf8 with SMTP id t10-20020a170902b20ab02900f48b9a5bf8mr28266522plr.37.1621912136401;
        Mon, 24 May 2021 20:08:56 -0700 (PDT)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com. [209.85.210.169])
        by smtp.gmail.com with ESMTPSA id u1sm12715687pfc.63.2021.05.24.20.08.55
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 20:08:55 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id e17so11876795pfl.5
        for <linux-pci@vger.kernel.org>; Mon, 24 May 2021 20:08:55 -0700 (PDT)
X-Received: by 2002:a05:6e02:b:: with SMTP id h11mr18955732ilr.18.1621912124990;
 Mon, 24 May 2021 20:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-6-tientzu@chromium.org> <CALiNf28ke3c91Y7xaHUgvJePKXqYA7UmsYJV9yaeZc3-4Lzs8Q@mail.gmail.com>
 <YKvLc9onyqdsINP7@0xbeefdead.lan>
In-Reply-To: <YKvLc9onyqdsINP7@0xbeefdead.lan>
From:   Claire Chang <tientzu@chromium.org>
Date:   Tue, 25 May 2021 11:08:34 +0800
X-Gmail-Original-Message-ID: <CALiNf28=fn5r_O8ET0TNM6cS7WO0mwXiMzR5z=eJXmNKFWKdzA@mail.gmail.com>
Message-ID: <CALiNf28=fn5r_O8ET0TNM6cS7WO0mwXiMzR5z=eJXmNKFWKdzA@mail.gmail.com>
Subject: Re: [PATCH v7 05/15] swiotlb: Add a new get_io_tlb_mem getter
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
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

On Mon, May 24, 2021 at 11:51 PM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> On Tue, May 18, 2021 at 02:51:52PM +0800, Claire Chang wrote:
> > Still keep this function because directly using dev->dma_io_tlb_mem
> > will cause issues for memory allocation for existing devices. The pool
> > can't support atomic coherent allocation so we need to distinguish the
> > per device pool and the default pool in swiotlb_alloc.
>
> This above should really be rolled in the commit. You can prefix it by
> "The reason it was done this way was because directly using .."
>

Will add it.
