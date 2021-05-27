Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A9A392EC5
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 15:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbhE0NCL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 09:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbhE0NCF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 09:02:05 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0776C061574
        for <linux-pci@vger.kernel.org>; Thu, 27 May 2021 06:00:31 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id h20so461792qko.11
        for <linux-pci@vger.kernel.org>; Thu, 27 May 2021 06:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tgPMjyY5jAkXYAxU2M6Xs7JOfdHxgDuWupSEgAOvuBU=;
        b=HyAvfwEBrieOghAofexhSawgJJukm2YnQ2fAt2CFdEKEbDS1O9qhSu7HLdewyRfCVz
         gEA6t08wyk35Bk0UPING6Rrv8blJD9d3z2B2GuwI2wJTrYZe4msm0UUHcQ98yGMgAfAw
         jsaa2ecYO9Gel1C3uwINW+EKRzQM0HGE52Gr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tgPMjyY5jAkXYAxU2M6Xs7JOfdHxgDuWupSEgAOvuBU=;
        b=B8fmJTJ1Dnqpm19xQ7Xix8fuDc+1an0pK7qUliDzodUr48JMHBmxsoxHG+pQlwlOCc
         Fe7NFMdpeVMcQBFs1R1PrvqzlgsgWqQ4ma9c8LnF3faN6Lj8qT51Ky/8idZhPIWll8L5
         B5PsY2AkzLjDnvsJKcBRTdiyTYgJOmfeBuu3puz38nwWr9xOdjcVn59qwCtfhL2muFJx
         f5iGnOBn8+KPeuOnj/GztOVvNW64fVNJRoKg/a8/0etYm7vqBl9fCumDXFhzNBQn0wlE
         zR358gpLxJkBTRFYp8jAEncbDPOGZZe4t3XjNWNJXSgweavTAjM6qw3aSl1zyCiU4dlG
         C1Gw==
X-Gm-Message-State: AOAM531l1k3jD1LyXmt9kv679Vqs0ceuC5V+WYOVRYsI2rAx7UX3PmUn
        h4n6cDY6pYz/2CMLOy1b+iudT1RihC+F3Q==
X-Google-Smtp-Source: ABdhPJzQBS5KWTSXXuvyluY4GcwDpn5Ryc/nCywLxFho05XaRVumy1MwBFksD/THxXvaEPGMDMbqNQ==
X-Received: by 2002:a37:9d81:: with SMTP id g123mr3272564qke.280.1622120430943;
        Thu, 27 May 2021 06:00:30 -0700 (PDT)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com. [209.85.222.171])
        by smtp.gmail.com with ESMTPSA id u2sm1293945qkk.75.2021.05.27.06.00.30
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 06:00:30 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id k4so518746qkd.0
        for <linux-pci@vger.kernel.org>; Thu, 27 May 2021 06:00:30 -0700 (PDT)
X-Received: by 2002:a02:a505:: with SMTP id e5mr3414377jam.10.1622120419476;
 Thu, 27 May 2021 06:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210518064215.2856977-1-tientzu@chromium.org>
In-Reply-To: <20210518064215.2856977-1-tientzu@chromium.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Thu, 27 May 2021 21:00:07 +0800
X-Gmail-Original-Message-ID: <CALiNf2-dUFSCOz4=jmEm8ZcX+zQXKzo6yPg31iLLLG3FAr+g1w@mail.gmail.com>
Message-ID: <CALiNf2-dUFSCOz4=jmEm8ZcX+zQXKzo6yPg31iLLLG3FAr+g1w@mail.gmail.com>
Subject: Re: [PATCH v7 00/15] Restricted DMA
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

v8 here: https://lore.kernel.org/patchwork/cover/1437112/
