Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DAC3AAC9D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 08:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhFQGn3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Jun 2021 02:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhFQGn3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jun 2021 02:43:29 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BD8C061574
        for <linux-pci@vger.kernel.org>; Wed, 16 Jun 2021 23:41:22 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id g22so4147201pgk.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Jun 2021 23:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IqsCA/yjikDS1aCYzllqiH9HoLVcQQhYIn5qSeonABE=;
        b=GiFPgetacPTJVsGZ3MFWgSvQPnCdoTJhc4FxcdhnTR1mIKLWNYkC5qsclOh1Nu4T0t
         2JBHLcEHEvZiTaAAwPJzRshEva/oe1afpxIyCNXuS6Yc5SEiWBAid4ULBNFnG08bi+4b
         5Y3w62S7YQM/biDmcuEcWF0r86zBUuRahetbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IqsCA/yjikDS1aCYzllqiH9HoLVcQQhYIn5qSeonABE=;
        b=toFc2FQTr6o9Zd52yYCyJieW28gbNkHLhGBkzurhRs0EpNqZeiYUu9y3HC1SO2O1ey
         JN9X5YqybDCWVH3HdNS0RrGhuj3HJWu6cKID1ymjCjqXqj2w/H+A1SmVKAeBMqBqywTr
         XpVo2yzxkZJZn+Zpnitr8ESBPW8Mivy3zS2cMQkmEscHFutxryhozpN8pOa9JjX5Ke/B
         aD2vtClem+NCD1rJ0o0sm6uk3Hp/DOzli22cSMSEVGh4LgjA4s0TNXJu4kZufhT2P868
         As88yi5KJT2yRpXRsUy9PzK6YZClHnmYlZaCKWjEf6qBjL/3K/xPNxbOkSmnoXNlOSX5
         fYFA==
X-Gm-Message-State: AOAM532wKGz24H9rUZkYEzUFbd2hEjn3yiGMTtRIfqZFTkgR3fFlYhNY
        A9RmdbAaUmYAV5blg37T/81yrZV4UTFnoA==
X-Google-Smtp-Source: ABdhPJxCPtWBefJS9Js69dBGrLAZ4+DEkqA97Q8w6uC8XweLo/VAOuiUlNCpz3C0BnUP2bXyg49EWw==
X-Received: by 2002:a62:2942:0:b029:2f4:e012:fb23 with SMTP id p63-20020a6229420000b02902f4e012fb23mr3842455pfp.55.1623912081322;
        Wed, 16 Jun 2021 23:41:21 -0700 (PDT)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com. [209.85.210.181])
        by smtp.gmail.com with ESMTPSA id v4sm4380048pgr.65.2021.06.16.23.41.20
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 23:41:20 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id p13so4251869pfw.0
        for <linux-pci@vger.kernel.org>; Wed, 16 Jun 2021 23:41:20 -0700 (PDT)
X-Received: by 2002:a05:6602:2344:: with SMTP id r4mr2559955iot.69.1623912068770;
 Wed, 16 Jun 2021 23:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210616062157.953777-1-tientzu@chromium.org> <20210616120837.GA22783@willie-the-truck>
In-Reply-To: <20210616120837.GA22783@willie-the-truck>
From:   Claire Chang <tientzu@chromium.org>
Date:   Thu, 17 Jun 2021 14:40:57 +0800
X-Gmail-Original-Message-ID: <CALiNf28SSxhs_+9Oq=pyOc7OWWDyWrtZLUqXKQKin6dRyXwo=w@mail.gmail.com>
Message-ID: <CALiNf28SSxhs_+9Oq=pyOc7OWWDyWrtZLUqXKQKin6dRyXwo=w@mail.gmail.com>
Subject: Re: [PATCH v12 00/12] Restricted DMA
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

v13: https://lore.kernel.org/patchwork/cover/1448001/
