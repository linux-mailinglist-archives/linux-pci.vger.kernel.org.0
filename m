Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF493160338
	for <lists+linux-pci@lfdr.de>; Sun, 16 Feb 2020 10:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgBPJuk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 Feb 2020 04:50:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40398 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725951AbgBPJuk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Feb 2020 04:50:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581846639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ib1DnkGh+UyvdqCLLKTPNNeMXjObgOPxob5BC7ny2no=;
        b=VSwqVpZbl6QxFsbC+nukY38p/CLGSC06mtbePs1RPeQUfYwGwHOnEHq3uBT+kZMR4VTNuP
        IV7EUdkzSdjbG08IMZ+BM6BdACRHQoxOL/xiQ1EJzWzODwwotZ6FD/ZayzDv4x4Ax1yeix
        gNnMcAZLp6Z9PgPxLW9+tI3JEMbbVOU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-7qQLPa5iObW6tnOyGXSP2w-1; Sun, 16 Feb 2020 04:50:38 -0500
X-MC-Unique: 7qQLPa5iObW6tnOyGXSP2w-1
Received: by mail-wr1-f70.google.com with SMTP id o6so7037238wrp.8
        for <linux-pci@vger.kernel.org>; Sun, 16 Feb 2020 01:50:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ib1DnkGh+UyvdqCLLKTPNNeMXjObgOPxob5BC7ny2no=;
        b=cbwjNZeRE4jlcogbgYOYNCIa/26fhPYvQw3p56CMgOoEgdv/s0pqtLN7Pqj0n2wP14
         icK070xikoPdvaPsf2LwsvZfJEUsx4YKCWUyevdpW3dnfRitntdaJ3iv8NZRqwRVqyai
         O4PiY/gB8TafqlPjFrOKe9LXZYyAQTK3en0eztqjfUtzw8809kas4s5a1i957M7HJt59
         8bHBdRGEeNeM/ivAwIM/gthE6aZGgXM2hpK4nlf3PrAhnGffiKBxGI/r1K792NWBCiY3
         C3uMJEs3/zPvNTEcmpj34Iwb7btAo4lkOHGzR25fPtZV1bydMbBVRXv+UqSn9Yuiq/em
         91dw==
X-Gm-Message-State: APjAAAXi+MDpsjsSjDMAP+PtmACQt7Q9Qw1WPDSZuZDYZzx9xIf0asDM
        l0cTEkL/JFbAWB4qhVu5g6yRnkiHclJVLDQLz59m1cw8T/i1KNQ/ELx/tYB0lETxHtUwG5pmH8v
        F/r3tfcZAcPKRFlzuwDcZ
X-Received: by 2002:a05:600c:248:: with SMTP id 8mr15618230wmj.1.1581846636763;
        Sun, 16 Feb 2020 01:50:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqyNMrFQHqv71dSXZ95RCgwdZYNzMl1jbONDS4h2qzyUzW0mleNi/Wo/HmWAmrPfI1kdiDOM+g==
X-Received: by 2002:a05:600c:248:: with SMTP id 8mr15618205wmj.1.1581846636526;
        Sun, 16 Feb 2020 01:50:36 -0800 (PST)
Received: from redhat.com (bzq-79-176-28-95.red.bezeqint.net. [79.176.28.95])
        by smtp.gmail.com with ESMTPSA id 21sm15813973wmo.8.2020.02.16.01.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 01:50:35 -0800 (PST)
Date:   Sun, 16 Feb 2020 04:50:33 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, jacob.jun.pan@intel.com,
        bhelgaas@google.com, jasowang@redhat.com
Subject: Re: [PATCH 3/3] iommu/virtio: Enable x86 support
Message-ID: <20200216045006-mutt-send-email-mst@kernel.org>
References: <20200214160413.1475396-1-jean-philippe@linaro.org>
 <20200214160413.1475396-4-jean-philippe@linaro.org>
 <311a1885-c619-3c8d-29dd-14fbfbf74898@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <311a1885-c619-3c8d-29dd-14fbfbf74898@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 14, 2020 at 04:57:11PM +0000, Robin Murphy wrote:
> On 14/02/2020 4:04 pm, Jean-Philippe Brucker wrote:
> > With the built-in topology description in place, x86 platforms can now
> > use the virtio-iommu.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >   drivers/iommu/Kconfig | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 068d4e0e3541..adcbda44d473 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -508,8 +508,9 @@ config HYPERV_IOMMU
> >   config VIRTIO_IOMMU
> >   	bool "Virtio IOMMU driver"
> >   	depends on VIRTIO=y
> > -	depends on ARM64
> > +	depends on (ARM64 || X86)
> >   	select IOMMU_API
> > +	select IOMMU_DMA
> 
> Can that have an "if X86" for clarity? AIUI it's not necessary for
> virtio-iommu itself (and really shouldn't be), but is merely to satisfy the
> x86 arch code's expectation that IOMMU drivers bring their own DMA ops,
> right?
> 
> Robin.

In fact does not this work on any platform now?

> >   	select INTERVAL_TREE
> >   	help
> >   	  Para-virtualised IOMMU driver with virtio.
> > 

