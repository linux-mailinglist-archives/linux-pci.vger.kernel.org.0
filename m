Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23A0415E80C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2020 17:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394373AbgBNQ50 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Feb 2020 11:57:26 -0500
Received: from foss.arm.com ([217.140.110.172]:40356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394360AbgBNQ5V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Feb 2020 11:57:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BC18328;
        Fri, 14 Feb 2020 08:57:21 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF5F53F68E;
        Fri, 14 Feb 2020 08:57:16 -0800 (PST)
Subject: Re: [PATCH 3/3] iommu/virtio: Enable x86 support
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org
Cc:     kevin.tian@intel.com, mst@redhat.com, sebastien.boeuf@intel.com,
        jacob.jun.pan@intel.com, bhelgaas@google.com, jasowang@redhat.com
References: <20200214160413.1475396-1-jean-philippe@linaro.org>
 <20200214160413.1475396-4-jean-philippe@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <311a1885-c619-3c8d-29dd-14fbfbf74898@arm.com>
Date:   Fri, 14 Feb 2020 16:57:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200214160413.1475396-4-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/02/2020 4:04 pm, Jean-Philippe Brucker wrote:
> With the built-in topology description in place, x86 platforms can now
> use the virtio-iommu.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   drivers/iommu/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 068d4e0e3541..adcbda44d473 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -508,8 +508,9 @@ config HYPERV_IOMMU
>   config VIRTIO_IOMMU
>   	bool "Virtio IOMMU driver"
>   	depends on VIRTIO=y
> -	depends on ARM64
> +	depends on (ARM64 || X86)
>   	select IOMMU_API
> +	select IOMMU_DMA

Can that have an "if X86" for clarity? AIUI it's not necessary for 
virtio-iommu itself (and really shouldn't be), but is merely to satisfy 
the x86 arch code's expectation that IOMMU drivers bring their own DMA 
ops, right?

Robin.

>   	select INTERVAL_TREE
>   	help
>   	  Para-virtualised IOMMU driver with virtio.
> 
