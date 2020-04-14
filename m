Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182F71A8871
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 20:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407762AbgDNSER (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 14:04:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:9161 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407752AbgDNSEQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Apr 2020 14:04:16 -0400
IronPort-SDR: V/hHqa+peyL4bTZc45NQhjbr6gGMksO6eNz28b27YX2iCiuNFInewo18dRDHfGvRFwnvCJTIH8
 Wfk1b0x+5muQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 11:03:58 -0700
IronPort-SDR: 01kgUQrqKZQX1pAj3dnDWz48ASk0atmd8PCFOSz4yl9e/0shzKXSFQ+E09Y5tSz5FmZPaOePWa
 U02OmUb4f5Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,383,1580803200"; 
   d="scan'208";a="271475817"
Received: from swwoldee-mobl1.amr.corp.intel.com (HELO [10.251.15.118]) ([10.251.15.118])
  by orsmga002.jf.intel.com with ESMTP; 14 Apr 2020 11:03:53 -0700
Subject: Re: [PATCH v5 24/25] PCI/ATS: Export PRI functions
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     kevin.tian@intel.com, catalin.marinas@arm.com,
        robin.murphy@arm.com, jgg@ziepe.ca,
        Bjorn Helgaas <bhelgaas@google.com>, zhangfei.gao@linaro.org,
        will@kernel.org, christian.koenig@amd.com
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-25-jean-philippe@linaro.org>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <5365fba9-093a-1948-e521-7cc931f06ff0@linux.intel.com>
Date:   Tue, 14 Apr 2020 11:03:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414170252.714402-25-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi,
On 4/14/20 10:02 AM, Jean-Philippe Brucker wrote:
> The SMMUv3 driver uses pci_{enable,disable}_pri() and related
> functions. Export those functions to allow the driver to be built as a
> module.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   drivers/pci/ats.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index bbfd0d42b8b97..fc8fc6fc8bd55 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -197,6 +197,7 @@ void pci_pri_init(struct pci_dev *pdev)
>   	if (status & PCI_PRI_STATUS_PASID)
>   		pdev->pasid_required = 1;
>   }
> +EXPORT_SYMBOL_GPL(pci_pri_init);
>   
>   /**
>    * pci_enable_pri - Enable PRI capability
> @@ -243,6 +244,7 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
>   
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(pci_enable_pri);
>   
>   /**
>    * pci_disable_pri - Disable PRI capability
> @@ -322,6 +324,7 @@ int pci_reset_pri(struct pci_dev *pdev)
>   
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(pci_reset_pri);
>   
>   /**
>    * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
> @@ -337,6 +340,7 @@ int pci_prg_resp_pasid_required(struct pci_dev *pdev)
>   
>   	return pdev->pasid_required;
>   }
> +EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
>   #endif /* CONFIG_PCI_PRI */
>   
>   #ifdef CONFIG_PCI_PASID
> 
