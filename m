Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A563AD771
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jun 2021 05:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhFSDqU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 23:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbhFSDqI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Jun 2021 23:46:08 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23B5C061767
        for <linux-pci@vger.kernel.org>; Fri, 18 Jun 2021 20:43:56 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id h3so10136353ilc.9
        for <linux-pci@vger.kernel.org>; Fri, 18 Jun 2021 20:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zO5LL7Owrsk50u85z5NQdq/+aN2FoxcpBADlxiwbwtc=;
        b=GoMVApQGRvRIO7blwwZSLVX7KnEaLUsgQiZnYGnQ8mp+79muo9lTEuES+H8kLhS8xC
         djxEq6nvfo+uAAf09DzdZIJgtSBquVbHx1Yy7Zj9ycZDtCn5PRIixQGHzFvC0S0QErMk
         dzuQb1UZyozHrgC7e811z9kAB0L/tg8WkvJDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zO5LL7Owrsk50u85z5NQdq/+aN2FoxcpBADlxiwbwtc=;
        b=GExAT39H9L13Wos/gQbLwuCVGJWiaWH2lzVJA+ieY/db60z2XJjJ7uMfMREUHG26t6
         szikWASSXaIrqTjH3vQAnrVH0HiGN/KPiOtYwYMu4Xnd2RjNivjnrvQrFIk9OYQESa07
         MqNXNwEGwgWU2dyKLWGCS29EbjuVBpet0at+FRShTEPV+YmsQ47Rwah+Mw9YQyVCAoBG
         pTj7Q30Ed+OxtZVk6RYHCOWjT2NrymBIrMCK/6A9ZZJPKSYk0A8cX5Uw0U3QBOWyStIk
         OYX4JNqu7JuLGQBLxgDdvaGQOHELrHGREku6muycN+QosPUS685oW9MYBeh1gWi7fM8g
         m/iA==
X-Gm-Message-State: AOAM532Fg/Ika5t8Hj2LPrgsC1Pok/HPqIid1iJQ1G+WoA/yoBrEVqj7
        9YgUFQ0mVDJUXfN3BgZQRa3aYWoSfpzcwg==
X-Google-Smtp-Source: ABdhPJz0DUunE/XXoGX7mRhEwm6JvqzMMoBLkV6tL+e0UFgE+3VtRczAUtwaFFhIsihf3nyJrHWHPQ==
X-Received: by 2002:a92:7a07:: with SMTP id v7mr108056ilc.224.1624074236005;
        Fri, 18 Jun 2021 20:43:56 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id y13sm5369138ioa.51.2021.06.18.20.43.54
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 20:43:55 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id k16so9196066ios.10
        for <linux-pci@vger.kernel.org>; Fri, 18 Jun 2021 20:43:54 -0700 (PDT)
X-Received: by 2002:a05:6602:50:: with SMTP id z16mr10626949ioz.155.1624074224014;
 Fri, 18 Jun 2021 20:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210617062635.1660944-1-tientzu@chromium.org> <CALiNf2_qF7OY0LHToNYx0E79BWMt2n7=nepPPLf+7YV3=KFEyw@mail.gmail.com>
In-Reply-To: <CALiNf2_qF7OY0LHToNYx0E79BWMt2n7=nepPPLf+7YV3=KFEyw@mail.gmail.com>
From:   Claire Chang <tientzu@chromium.org>
Date:   Sat, 19 Jun 2021 11:43:33 +0800
X-Gmail-Original-Message-ID: <CALiNf289bo1WzEWWapzeQ8xYiH8s1qgDkpHVgy=PgAmv6rvGnQ@mail.gmail.com>
Message-ID: <CALiNf289bo1WzEWWapzeQ8xYiH8s1qgDkpHVgy=PgAmv6rvGnQ@mail.gmail.com>
Subject: Re: [PATCH v13 00/12] Restricted DMA
To:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, grant.likely@arm.com,
        xypron.glpk@gmx.de, Thierry Reding <treding@nvidia.com>,
        mingo@kernel.org, bauerman@linux.ibm.com, peterz@infradead.org,
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

v14: https://lore.kernel.org/patchwork/cover/1448954/
