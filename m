Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20BAF573AF
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 23:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfFZVgW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 17:36:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:33988 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfFZVgV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Jun 2019 17:36:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 14:36:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,421,1557212400"; 
   d="scan'208";a="360890792"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jun 2019 14:36:21 -0700
Date:   Wed, 26 Jun 2019 14:36:21 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/25] mm: sort out the DEVICE_PRIVATE Kconfig mess
Message-ID: <20190626213620.GA8399@iweiny-DESK2.sc.intel.com>
References: <20190626122724.13313-1-hch@lst.de>
 <20190626122724.13313-24-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626122724.13313-24-hch@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 26, 2019 at 02:27:22PM +0200, Christoph Hellwig wrote:
> The ZONE_DEVICE support doesn't depend on anything HMM related, just on
> various bits of arch support as indicated by the architecture.  Also
> don't select the option from nouveau as it isn't present in many setups,
> and depend on it instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/gpu/drm/nouveau/Kconfig | 2 +-
>  mm/Kconfig                      | 5 ++---
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
> index dba2613f7180..6303d203ab1d 100644
> --- a/drivers/gpu/drm/nouveau/Kconfig
> +++ b/drivers/gpu/drm/nouveau/Kconfig
> @@ -85,10 +85,10 @@ config DRM_NOUVEAU_BACKLIGHT
>  config DRM_NOUVEAU_SVM
>  	bool "(EXPERIMENTAL) Enable SVM (Shared Virtual Memory) support"
>  	depends on ARCH_HAS_HMM
> +	depends on DEVICE_PRIVATE
>  	depends on DRM_NOUVEAU
>  	depends on STAGING
>  	select HMM_MIRROR
> -	select DEVICE_PRIVATE
>  	default n
>  	help
>  	  Say Y here if you want to enable experimental support for
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 6f35b85b3052..eecf037a54b3 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -677,13 +677,13 @@ config ARCH_HAS_HMM_MIRROR
>  
>  config ARCH_HAS_HMM
>  	bool
> -	default y
>  	depends on (X86_64 || PPC64)
>  	depends on ZONE_DEVICE
>  	depends on MMU && 64BIT
>  	depends on MEMORY_HOTPLUG
>  	depends on MEMORY_HOTREMOVE
>  	depends on SPARSEMEM_VMEMMAP
> +	default y
>  
>  config MIGRATE_VMA_HELPER
>  	bool
> @@ -709,8 +709,7 @@ config HMM_MIRROR
>  
>  config DEVICE_PRIVATE
>  	bool "Unaddressable device memory (GPU memory, ...)"
> -	depends on ARCH_HAS_HMM
> -	select HMM
> +	depends on ZONE_DEVICE
>  	select DEV_PAGEMAP_OPS
>  
>  	help
> -- 
> 2.20.1
> 
