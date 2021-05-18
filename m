Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432993872A6
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 08:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346674AbhERGxg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 02:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238637AbhERGxf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 May 2021 02:53:35 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17240C061756
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 23:52:17 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id d11so8371067iod.5
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 23:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=okFGSzwxy3Xl1EDwrbsZ6bJWGdPaUEKxSezi4/SE71A=;
        b=KvboTWH6SCfdQ7LLxm6vH9xhTNNbPkylAhr3iqPQWH1QNODKOLIbMt/OYjboWMwVvr
         +KD/UQeQoUETk6OK7TCWS0Utmt5EvBfWbA4IzzRRuwJkDy5Qi3ICeWOTChp1Py6zaNQt
         fa1WHS9ymuIo1ivMcIga1N5vVpkmfX46UnGI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=okFGSzwxy3Xl1EDwrbsZ6bJWGdPaUEKxSezi4/SE71A=;
        b=KGiEtLt31OXgvu+kXrk4anARMY9X4DfkYzNipoeQvbBtIGEg8XdIZG4ny36C1y4JQH
         qhZYvEWxjsgMvthQy3QCAr/MnUeyHkT7Uw+uFO5uu5OKEWQdT0BkEFGfoFg5H0t8qSis
         ye4ZQnOZDoM8CmMM1bf/fbd7cXORO8IteCQKBv8zdvVoAgJq0PvSIDMxBDjSyTuFRU+z
         x+iagk3J2LESWDvnoNDnEJZHvDigYeE3+Eqgh+cToXvsMawB310BrjSgL9kfmt7QaKdG
         9PODouvPc80+l0T5NPG06VE1MRqPoBaipHtd2jv17GdiwiRT0GcO2w65bGbFF3v1G7cA
         8+EQ==
X-Gm-Message-State: AOAM530BIuMACmLPq3XKZmt07FxnaD0Il15TvBpVLLzqnPeK0fc1IaUI
        n7pukaJQtNP9v56X5aXHD+Ud8X1nb7cmEQ==
X-Google-Smtp-Source: ABdhPJy8odDD7Q/Gyp+M4m+ogpfUGf6XWzs2QDNQIQyH4DSWOG8C/fy2lQ27ZQOaqxYoMHex08z2TQ==
X-Received: by 2002:a02:3506:: with SMTP id k6mr3982354jaa.39.1621320736214;
        Mon, 17 May 2021 23:52:16 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id t2sm10388055ilo.73.2021.05.17.23.52.14
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 23:52:15 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id o10so7227725ilm.13
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 23:52:14 -0700 (PDT)
X-Received: by 2002:a05:6e02:1a4d:: with SMTP id u13mr3011800ilv.64.1621320723564;
 Mon, 17 May 2021 23:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210518064215.2856977-1-tientzu@chromium.org> <20210518064215.2856977-6-tientzu@chromium.org>
In-Reply-To: <20210518064215.2856977-6-tientzu@chromium.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Tue, 18 May 2021 14:51:52 +0800
X-Gmail-Original-Message-ID: <CALiNf28ke3c91Y7xaHUgvJePKXqYA7UmsYJV9yaeZc3-4Lzs8Q@mail.gmail.com>
Message-ID: <CALiNf28ke3c91Y7xaHUgvJePKXqYA7UmsYJV9yaeZc3-4Lzs8Q@mail.gmail.com>
Subject: Re: [PATCH v7 05/15] swiotlb: Add a new get_io_tlb_mem getter
To:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
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

Still keep this function because directly using dev->dma_io_tlb_mem
will cause issues for memory allocation for existing devices. The pool
can't support atomic coherent allocation so we need to distinguish the
per device pool and the default pool in swiotlb_alloc.
