Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27BFD4515D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 03:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfFNBxT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 21:53:19 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19727 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfFNBxT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 21:53:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d02fe0e0005>; Thu, 13 Jun 2019 18:53:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 13 Jun 2019 18:53:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 13 Jun 2019 18:53:18 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun
 2019 01:53:15 +0000
Subject: Re: [Nouveau] [PATCH 22/22] mm: don't select MIGRATE_VMA_HELPER from
 HMM_MIRROR
To:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
CC:     <linux-nvdimm@lists.01.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-23-hch@lst.de>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <7f6c6837-93cd-3b89-63fb-7a60d906c70c@nvidia.com>
Date:   Thu, 13 Jun 2019 18:53:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613094326.24093-23-hch@lst.de>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560477199; bh=wfrTohx7F8pzBumLpEjaUQ9N1cFt17QeYAZ9KiQw55o=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=M5oN6C8eycwH3ddNUoY7Cl0CYJ9M/JxsSi8COG6+zA3vleXm4hLAieJyd+Rnz+XkO
         InXDP5bP6dg2R5z3V6QmIUAmqLRdfEEPnoHe11DQdqPOWEHe/dXotRaVsozwyC2/UP
         xDBwMimCe618+axfU5Zd0Qi9Sdyc7jV9iEEzHuNuDhCf0KA4IYYIilK0/UogG1t7ci
         H9FdBc2bPm+OVbr206w3w8msAwL3yKIwNn9F7Tj/HK8hN79yf7fVDe++57Ay62brrv
         OTzs1WriOqHqdV4jj8ahLriHk1fr8Yt+cbZgV9a0zp+uG1qklpiRLsN8+Vm//XjXMt
         Z2NZgCNIR4PKQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/13/19 2:43 AM, Christoph Hellwig wrote:
> The migrate_vma helper is only used by noveau to migrate device private
> pages around.  Other HMM_MIRROR users like amdgpu or infiniband don't
> need it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/nouveau/Kconfig | 1 +
>  mm/Kconfig                      | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
> index 66c839d8e9d1..96b9814e6d06 100644
> --- a/drivers/gpu/drm/nouveau/Kconfig
> +++ b/drivers/gpu/drm/nouveau/Kconfig
> @@ -88,6 +88,7 @@ config DRM_NOUVEAU_SVM
>  	depends on DRM_NOUVEAU
>  	depends on HMM_MIRROR
>  	depends on STAGING
> +	select MIGRATE_VMA_HELPER
>  	default n
>  	help
>  	  Say Y here if you want to enable experimental support for
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 73676cb4693f..eca88679b624 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -679,7 +679,6 @@ config HMM_MIRROR
>  	bool "HMM mirror CPU page table into a device page table"
>  	depends on MMU
>  	select MMU_NOTIFIER
> -	select MIGRATE_VMA_HELPER
>  	help
>  	  Select HMM_MIRROR if you want to mirror range of the CPU page table of a
>  	  process into a device page table. Here, mirror means "keep synchronized".
> 

For those who have out of tree drivers that need migrate_vma(), but are not
Nouveau, could we pretty please allow a way to select that independently?

It's not a big deal, as I expect the Nouveau option will normally be selected, 
but it would be nice. Because there is a valid configuration that involves 
Nouveau not being selected, but our driver still wanting to run.

Maybe we can add something like this on top of what you have?

diff --git a/mm/Kconfig b/mm/Kconfig
index eca88679b624..330996632513 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -670,7 +670,10 @@ config ZONE_DEVICE
          If FS_DAX is enabled, then say Y.
 
 config MIGRATE_VMA_HELPER
-       bool
+       bool "migrate_vma() helper routine"
+       help
+         Provides a migrate_vma() routine that GPUs and other
+         device drivers may need.
 
 config DEV_PAGEMAP_OPS
        bool



thanks,
-- 
John Hubbard
NVIDIA
