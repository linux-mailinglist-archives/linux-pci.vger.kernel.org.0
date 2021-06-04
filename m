Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482E339BF0E
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 19:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFDRuR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 13:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhFDRuQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 13:50:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1B72611CE;
        Fri,  4 Jun 2021 17:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622828909;
        bh=itHLj7KgFnb/FecADbuq7I4biuZGdUj1du28UW6T8SI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iqm0inp9VgNpzeAFuP421rSsgCv0Qhkv5QnQPUkLUJFiTIxp7TFY3QR4OyPttmT96
         63UJ1NvLjEWUu6sIeGlZQM4Ted9nVFpDXdWeD/OOk+ONJBJL5Ar0gZ0w9EXx03CeNz
         9hxeLBPU+4Vs1Iu13rVy6icMo7fyuPwvCQ+cWk5bEidGKBw04BNS3wfiw4K6ZGCyPX
         6cUjTh3kCX/N4K95NY0l8Alu5nPdSl//4dOSMljRD2azPbGNPTGPvDRtwrHFnkFOCZ
         c64/aftHtK6fT63h1C50fed28UcM2UZbSHegeAkgG/khU8kRyqVyIs14SrPvQtO8GW
         fslW9h7sjgBEQ==
Date:   Fri, 4 Jun 2021 18:48:18 +0100
From:   Will Deacon <will@kernel.org>
To:     Claire Chang <tientzu@chromium.org>
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
        Jim Quinlan <james.quinlan@broadcom.com>, tfiga@chromium.org,
        bskeggs@redhat.com, bhelgaas@google.com, chris@chris-wilson.co.uk,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        jxgao@google.com, joonas.lahtinen@linux.intel.com,
        linux-pci@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        matthew.auld@intel.com, rodrigo.vivi@intel.com,
        thomas.hellstrom@linux.intel.com
Subject: Re: [PATCH v8 00/15] Restricted DMA
Message-ID: <20210604174818.GC3703@willie-the-truck>
References: <20210527125845.1852284-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527125845.1852284-1-tientzu@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Claire,

On Thu, May 27, 2021 at 08:58:30PM +0800, Claire Chang wrote:
> This series implements mitigations for lack of DMA access control on
> systems without an IOMMU, which could result in the DMA accessing the
> system memory at unexpected times and/or unexpected addresses, possibly
> leading to data leakage or corruption.
> 
> For example, we plan to use the PCI-e bus for Wi-Fi and that PCI-e bus is
> not behind an IOMMU. As PCI-e, by design, gives the device full access to
> system memory, a vulnerability in the Wi-Fi firmware could easily escalate
> to a full system exploit (remote wifi exploits: [1a], [1b] that shows a
> full chain of exploits; [2], [3]).
> 
> To mitigate the security concerns, we introduce restricted DMA. Restricted
> DMA utilizes the existing swiotlb to bounce streaming DMA in and out of a
> specially allocated region and does memory allocation from the same region.
> The feature on its own provides a basic level of protection against the DMA
> overwriting buffer contents at unexpected times. However, to protect
> against general data leakage and system memory corruption, the system needs
> to provide a way to restrict the DMA to a predefined memory region (this is
> usually done at firmware level, e.g. MPU in ATF on some ARM platforms [4]).
> 
> [1a] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_4.html
> [1b] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_11.html
> [2] https://blade.tencent.com/en/advisories/qualpwn/
> [3] https://www.bleepingcomputer.com/news/security/vulnerabilities-found-in-highly-popular-firmware-for-wifi-chips/
> [4] https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/mediatek/mt8183/drivers/emi_mpu/emi_mpu.c#L132
> 
> v8:
> - Fix reserved-memory.txt and add the reg property in example.
> - Fix sizeof for of_property_count_elems_of_size in
>   drivers/of/address.c#of_dma_set_restricted_buffer.
> - Apply Will's suggestion to try the OF node having DMA configuration in
>   drivers/of/address.c#of_dma_set_restricted_buffer.
> - Fix typo in the comment of drivers/of/address.c#of_dma_set_restricted_buffer.
> - Add error message for PageHighMem in
>   kernel/dma/swiotlb.c#rmem_swiotlb_device_init and move it to
>   rmem_swiotlb_setup.
> - Fix the message string in rmem_swiotlb_setup.

Thanks for the v8. It works for me out of the box on arm64 under KVM, so:

Tested-by: Will Deacon <will@kernel.org>

Note that something seems to have gone wrong with the mail threading, so
the last 5 patches ended up as a separate thread for me. Probably worth
posting again with all the patches in one place, if you can.

Cheers,

Will
