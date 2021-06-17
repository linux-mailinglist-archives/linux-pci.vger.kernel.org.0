Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE1A3AA7E1
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 02:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbhFQALk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 20:11:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230481AbhFQALj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 20:11:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70EFE61351;
        Thu, 17 Jun 2021 00:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623888572;
        bh=mN2okVVdTICmc/8v91DABSXp7kK2mc41VelpLLMzraM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ZYuvhN96769HVBf9HwXfEMrx5h2joXFESxJj/lRenrF7yXWLZjtrg1PWIka+vT/Q0
         oFtXyOpOZ9yR7QPt6WZ9qiVwYGYEJ72zE5pEW7HiR62r0bK1cPffUlPeluSwwsGV++
         8riMe4sA8jh8H05UnuJF58KJLPG9dNHhkmEpW63Symhvau9C6X5CTpmeRZXg03FBNA
         YdmM71is91QiA8p/farR5qTSk/+kZjwaUjrHEt7/cAUyCA79A0OF17vUa8D0c+gd+H
         nwIEeujLTdx4sfeAu0ptJEutsq4BmObXoP4A9/HlakW6ogsicBITdzMemlH7LIUWJw
         GZfH7kl1LZ6XQ==
Date:   Wed, 16 Jun 2021 17:09:29 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Claire Chang <tientzu@chromium.org>
cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH v12 11/12] dt-bindings: of: Add restricted DMA pool
In-Reply-To: <20210616062157.953777-12-tientzu@chromium.org>
Message-ID: <alpine.DEB.2.21.2106161651290.24906@sstabellini-ThinkPad-T480s>
References: <20210616062157.953777-1-tientzu@chromium.org> <20210616062157.953777-12-tientzu@chromium.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 16 Jun 2021, Claire Chang wrote:
> Introduce the new compatible string, restricted-dma-pool, for restricted
> DMA. One can specify the address and length of the restricted DMA memory
> region by restricted-dma-pool in the reserved-memory node.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>  .../reserved-memory/reserved-memory.txt       | 36 +++++++++++++++++--
>  1 file changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> index e8d3096d922c..46804f24df05 100644
> --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> @@ -51,6 +51,23 @@ compatible (optional) - standard definition
>            used as a shared pool of DMA buffers for a set of devices. It can
>            be used by an operating system to instantiate the necessary pool
>            management subsystem if necessary.
> +        - restricted-dma-pool: This indicates a region of memory meant to be
> +          used as a pool of restricted DMA buffers for a set of devices. The
> +          memory region would be the only region accessible to those devices.
> +          When using this, the no-map and reusable properties must not be set,
> +          so the operating system can create a virtual mapping that will be used
> +          for synchronization. The main purpose for restricted DMA is to
> +          mitigate the lack of DMA access control on systems without an IOMMU,
> +          which could result in the DMA accessing the system memory at
> +          unexpected times and/or unexpected addresses, possibly leading to data
> +          leakage or corruption. The feature on its own provides a basic level
> +          of protection against the DMA overwriting buffer contents at
> +          unexpected times. However, to protect against general data leakage and
> +          system memory corruption, the system needs to provide way to lock down
> +          the memory access, e.g., MPU. Note that since coherent allocation
> +          needs remapping, one must set up another device coherent pool by
> +          shared-dma-pool and use dma_alloc_from_dev_coherent instead for atomic
> +          coherent allocation.
>          - vendor specific string in the form <vendor>,[<device>-]<usage>
>  no-map (optional) - empty property
>      - Indicates the operating system must not create a virtual mapping
> @@ -85,10 +102,11 @@ memory-region-names (optional) - a list of names, one for each corresponding
>  
>  Example
>  -------
> -This example defines 3 contiguous regions are defined for Linux kernel:
> +This example defines 4 contiguous regions for Linux kernel:
>  one default of all device drivers (named linux,cma@72000000 and 64MiB in size),
> -one dedicated to the framebuffer device (named framebuffer@78000000, 8MiB), and
> -one for multimedia processing (named multimedia-memory@77000000, 64MiB).
> +one dedicated to the framebuffer device (named framebuffer@78000000, 8MiB),
> +one for multimedia processing (named multimedia-memory@77000000, 64MiB), and
> +one for restricted dma pool (named restricted_dma_reserved@0x50000000, 64MiB).
>  
>  / {
>  	#address-cells = <1>;
> @@ -120,6 +138,11 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
>  			compatible = "acme,multimedia-memory";
>  			reg = <0x77000000 0x4000000>;
>  		};
> +
> +		restricted_dma_reserved: restricted_dma_reserved {
> +			compatible = "restricted-dma-pool";
> +			reg = <0x50000000 0x4000000>;
> +		};
>  	};
>  
>  	/* ... */
> @@ -138,4 +161,11 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
>  		memory-region = <&multimedia_reserved>;
>  		/* ... */
>  	};
> +
> +	pcie_device: pcie_device@0,0 {
> +		reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
> +		       0x83010000 0x0 0x00100000 0x0 0x00100000>;
> +		memory-region = <&restricted_dma_mem_reserved>;

Shouldn't it be &restricted_dma_reserved ?

