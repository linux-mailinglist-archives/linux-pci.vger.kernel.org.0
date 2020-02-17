Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1AA0160E32
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2020 10:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgBQJMd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Feb 2020 04:12:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40106 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbgBQJMc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Feb 2020 04:12:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id t3so18669199wru.7
        for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2020 01:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3xReXtDN4LyAJUffUOB2fEzxHj5w+bYneLaFyHrhb/I=;
        b=GI1HEZGX5Puf2LLrSwwBVyM71kCTbxTvC+JtBQ8Axtt2gtfpwmC28LBW78V5qH7fKP
         0xpuXMLzitdJtwKfCYZwhRb0OtE746KFP03x5+2sH58M+pBmfxlPqYyk1VaIdvyQ/rR4
         kbroefLW49Y8QNEw3NqlKuwdFljmv+N1NGnc7Ayhpv8IKMuHXPI+NXgaWMylU2QuVWX+
         lxyRkocrR+9DAN3hR5jjIm+248w3FcgUr3iBOSakgPGi6mBgKNkF5EZrUG4SQtiKaNuT
         j1OopcgprxWCGEXPMEo6JHTwWo9Tq0Q+nlzlRCr/nQZ98qGCo1ma5YhsXqZptzdJewW0
         G4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3xReXtDN4LyAJUffUOB2fEzxHj5w+bYneLaFyHrhb/I=;
        b=aepZUChsEu5nXdtnmKd31k8Szqkv/K1WDwPK6nGANUce9FIDRyewiHXRryYJUF5Vbl
         KRo46GcGXzLxuqohZbVlFX/M/Dg42+0fgIFkTCtD7HTm1IINdp3KZ/brx31G+nVscD0z
         /SAg2fIbSeKLkaHEjSqZ1aiOT1SPxnhHffYa3mWLBknbD7ZGDwB3QZ/oQfHT4VV/SsIU
         ZgvslAx1yX+vEqWddOItzC2x1n2/u9E+A8f/4P7eP8RuFIslmnpxiYQ5iCxqugr40x7P
         Ej6t8xt4ckJ1yRX+WR1FY8dvV1geXTvA5zhGY3HVeNtcDBSl6HJ4u9kkSJUAikkpEelO
         tyOQ==
X-Gm-Message-State: APjAAAWpbiLQPondhkJagrrMuGcT9BK6CGGR4YqGfN4gdPMQ8yD3kF2C
        WttfxGAZZViC3NL1l32+kBqSlQ==
X-Google-Smtp-Source: APXvYqy0+uCZz56gg9KY1CEZhOwTKCImzEBdQ7HaHkQZVJwABbD3oUbmhF4dXY4WjZGNxC5GhUv0GQ==
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr22612667wrw.60.1581930750507;
        Mon, 17 Feb 2020 01:12:30 -0800 (PST)
Received: from myrica ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id t10sm19040467wmi.40.2020.02.17.01.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 01:12:29 -0800 (PST)
Date:   Mon, 17 Feb 2020 10:12:22 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, kevin.tian@intel.com, mst@redhat.com,
        sebastien.boeuf@intel.com, jacob.jun.pan@intel.com,
        bhelgaas@google.com, jasowang@redhat.com
Subject: Re: [PATCH 2/3] PCI: Add DMA configuration for virtual platforms
Message-ID: <20200217091222.GB1650092@myrica>
References: <20200214160413.1475396-1-jean-philippe@linaro.org>
 <20200214160413.1475396-3-jean-philippe@linaro.org>
 <393cce27-dbed-f075-2a67-9882bed801e7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <393cce27-dbed-f075-2a67-9882bed801e7@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 14, 2020 at 05:03:16PM +0000, Robin Murphy wrote:
> On 14/02/2020 4:04 pm, Jean-Philippe Brucker wrote:
> > Hardware platforms usually describe the IOMMU topology using either
> > device-tree pointers or vendor-specific ACPI tables.  For virtual
> > platforms that don't provide a device-tree, the virtio-iommu device
> > contains a description of the endpoints it manages.  That information
> > allows us to probe endpoints after the IOMMU is probed (possibly as late
> > as userspace modprobe), provided it is discovered early enough.
> > 
> > Add a hook to pci_dma_configure(), which returns -EPROBE_DEFER if the
> > endpoint is managed by a vIOMMU that will be loaded later, or 0 in any
> > other case to avoid disturbing the normal DMA configuration methods.
> > When CONFIG_VIRTIO_IOMMU_TOPOLOGY isn't selected, the call to
> > virt_dma_configure() is compiled out.
> > 
> > As long as the information is consistent, platforms can provide both a
> > device-tree and a built-in topology, and the IOMMU infrastructure is
> > able to deal with multiple DMA configuration methods.
> 
> Urgh, it's already been established[1] that having IOMMU setup tied to DMA
> configuration at driver probe time is not just conceptually wrong but
> actually broken, so the concept here worries me a bit. In a world where
> of_iommu_configure() and friends are being called much earlier around
> iommu_probe_device() time, how badly will this fall apart?

If present the DT configuration should take precedence over this built-in
method, so the earlier it is called the better. virt_dma_configure()
currently gives up if the device already has iommu_ops (well, still calls
setup_dma_ops() which is safe enough, but I think I'll change that to have
virt_iommu_setup() return NULL if iommu_ops are present).

I don't have the full picture of the changes you intend for
{of,acpi}_iommu_configure(), do you think checking the validity of
dev->iommu_fwspec will remain sufficient to have both methods coexist?

Thanks,
Jean
