Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F441A8868
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 20:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407746AbgDNSDg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 14:03:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:43163 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407740AbgDNSDd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Apr 2020 14:03:33 -0400
IronPort-SDR: x8rRgoPDPLAJKqR99Bj142EoFIexz0sjoFTYVBvp66/JYLLo7xztYppSojeXo5VqKtmREh6kqb
 qZhev8Zj9G0A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 11:03:32 -0700
IronPort-SDR: SFfWWKn9a+9EaRfpA/3Wbs/x3kQaNMzka6GrGJ2jeWBmbZqBLlTRxdEhB2Ad2MBBRdX9vd5tu9
 ICwTpVsFz5Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,383,1580803200"; 
   d="scan'208";a="271475675"
Received: from swwoldee-mobl1.amr.corp.intel.com (HELO [10.251.15.118]) ([10.251.15.118])
  by orsmga002.jf.intel.com with ESMTP; 14 Apr 2020 11:03:28 -0700
Subject: Re: [PATCH v5 23/25] PCI/ATS: Add PRI stubs
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-24-jean-philippe@linaro.org>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <b595b3a1-7444-eeac-412a-85d453c32095@linux.intel.com>
Date:   Tue, 14 Apr 2020 11:03:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414170252.714402-24-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 4/14/20 10:02 AM, Jean-Philippe Brucker wrote:
> The SMMUv3 driver, which can be built without CONFIG_PCI, will soon gain
> support for PRI.  Partially revert commit c6e9aefbf9db ("PCI/ATS: Remove
> unused PRI and PASID stubs") to re-introduce the PRI stubs, and avoid
> adding more #ifdefs to the SMMU driver.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   include/linux/pci-ats.h | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index f75c307f346de..e9e266df9b37c 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -28,6 +28,14 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
>   void pci_disable_pri(struct pci_dev *pdev);
>   int pci_reset_pri(struct pci_dev *pdev);
>   int pci_prg_resp_pasid_required(struct pci_dev *pdev);
> +#else /* CONFIG_PCI_PRI */
> +static inline int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
> +{ return -ENODEV; }
> +static inline void pci_disable_pri(struct pci_dev *pdev) { }
> +static inline int pci_reset_pri(struct pci_dev *pdev)
> +{ return -ENODEV; }
> +static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> +{ return 0; }
>   #endif /* CONFIG_PCI_PRI */
>   
>   #ifdef CONFIG_PCI_PASID
> 
