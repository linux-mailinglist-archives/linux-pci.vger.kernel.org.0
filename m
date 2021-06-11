Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68843A458D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 17:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhFKPiY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Jun 2021 11:38:24 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:43002 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbhFKPiU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jun 2021 11:38:20 -0400
Received: by mail-qk1-f176.google.com with SMTP id q16so5383415qkm.9
        for <linux-pci@vger.kernel.org>; Fri, 11 Jun 2021 08:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AzuwWZVb0hvYDmhYzyjXOdcnRd7gmJwLqOExosCeDwM=;
        b=IRqkW7akj902Qmh2dpTJs35MbbbyYdNh845FqGa90ZgwGlX/fY4AEM0E2Tq/OkUGrx
         VVpf/9sUsDrF+Qmi4N27tWzf7jckOIK7UvGuS34GnQEYg0G4BU1Idcj7Q7ryrjHTdpBh
         ql1llzJVDf1YUXhBMlreUDeIOuUDsqa6G9X1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AzuwWZVb0hvYDmhYzyjXOdcnRd7gmJwLqOExosCeDwM=;
        b=YZ8ReT39U6PPUbRSZCh7OzeZo7aYk2aWyhDkQdHsvS/PKM4draqSAiySxf14JoDujz
         DQXjgRH2SXYlniIeNwiYk+j1auk9xsSdMtJExs3NLzSOPeOswk3RxOq7KQ8ObXlANWEa
         aPA5znwzBBvJrgNnG3PfFeHLYXscatEXApsVAx4s0YVxaeKmI6bERa6H1FjIszRKsVFd
         KlIvkx6cxBrwibr+3xiiEGpfi1tuQxLT0eU30cpie3icvH4D7PZ1olhPjCCs/UpY5cbE
         1/zKm+1eb6pimY+TXP6xy+VTJbCUbbl29l3ceNVxlhuRtqr2Ih1gO5clArC2ilI+OWEa
         62fw==
X-Gm-Message-State: AOAM530EmzfDqN6qq18PAdsSYSU/ebkmHscc9ti4Az0yxJR9+o658Nuv
        PzgAyC6/iMJMn//oburqYEJkeFjiW2taqg==
X-Google-Smtp-Source: ABdhPJz9wIBZnIt49Zavj8bdtfhXZqfyumAd//W26qVoeCDJFWF9owtipHi7lz9Np9SkkU1py91k5A==
X-Received: by 2002:a05:620a:2942:: with SMTP id n2mr4418991qkp.412.1623425722180;
        Fri, 11 Jun 2021 08:35:22 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id e127sm4800915qkf.62.2021.06.11.08.35.21
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 08:35:21 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id g12so2895240qtb.2
        for <linux-pci@vger.kernel.org>; Fri, 11 Jun 2021 08:35:21 -0700 (PDT)
X-Received: by 2002:a05:6638:e81:: with SMTP id p1mr4464281jas.84.1623425710461;
 Fri, 11 Jun 2021 08:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210611152659.2142983-1-tientzu@chromium.org> <20210611152659.2142983-7-tientzu@chromium.org>
In-Reply-To: <20210611152659.2142983-7-tientzu@chromium.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Fri, 11 Jun 2021 23:34:59 +0800
X-Gmail-Original-Message-ID: <CALiNf28OT2L1qcH4dKK8mb0=uCyaKDHW7r=LrC9MTJw0PSzSbw@mail.gmail.com>
Message-ID: <CALiNf28OT2L1qcH4dKK8mb0=uCyaKDHW7r=LrC9MTJw0PSzSbw@mail.gmail.com>
Subject: Re: [PATCH v9 06/14] swiotlb: Update is_swiotlb_active to add a
 struct device argument
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

I don't have the HW to verify the change. Hopefully I use the right
device struct for is_swiotlb_active.
