Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CE7310265
	for <lists+linux-pci@lfdr.de>; Fri,  5 Feb 2021 02:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhBEBtt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 20:49:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:60710 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232887AbhBEBtt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Feb 2021 20:49:49 -0500
IronPort-SDR: UKzmBXtJttkcL3JO81RMatDcUB+zHprIVpsC8GZmIctPcCqlDmCuUfFrmMn9V0OTU3NHwC0Njp
 biIXpQFNmFBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="242866295"
X-IronPort-AV: E=Sophos;i="5.81,154,1610438400"; 
   d="scan'208";a="242866295"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 17:48:03 -0800
IronPort-SDR: KVys015NXYzgilTJwGuAvItTw75dVH+9Y0hpsbBJj8s9iO4o00N7Bbr+UzZl9yO192ciDGfaoN
 jKcuOx6WT2zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,154,1610438400"; 
   d="scan'208";a="407461752"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 04 Feb 2021 17:48:00 -0800
Cc:     baolu.lu@linux.intel.com, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Nirmal Patel <nirmal.patel@intel.com>,
        Kapil Karkra <kapil.karkra@intel.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/2] iommu/vt-d: Use Real PCI DMA device for IRTE
To:     Jon Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20210204190906.38515-1-jonathan.derrick@intel.com>
 <20210204190906.38515-2-jonathan.derrick@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <cc0c35bc-a5f2-ada2-ec00-14a351649d8c@linux.intel.com>
Date:   Fri, 5 Feb 2021 09:39:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210204190906.38515-2-jonathan.derrick@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/5/21 3:09 AM, Jon Derrick wrote:
> VMD retransmits child device MSI/X with the VMD endpoint's requester-id.
> In order to support direct interrupt remapping of VMD child devices,
> ensure that the IRTE is programmed with the VMD endpoint's requester-id
> using pci_real_dma_dev().
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>   drivers/iommu/intel/irq_remapping.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
> index 685200a5cff0..1939e070eec8 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -1276,7 +1276,8 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
>   		break;
>   	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
>   	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
> -		set_msi_sid(irte, msi_desc_to_pci_dev(info->desc));
> +		set_msi_sid(irte,
> +			    pci_real_dma_dev(msi_desc_to_pci_dev(info->desc)));
>   		break;
>   	default:
>   		BUG_ON(1);
> 

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
