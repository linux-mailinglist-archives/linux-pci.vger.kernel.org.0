Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB5CD3429
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2019 01:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfJJXJ0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Oct 2019 19:09:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:45304 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfJJXJ0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Oct 2019 19:09:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 16:09:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,281,1566889200"; 
   d="scan'208";a="197403278"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 10 Oct 2019 16:09:23 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id C3F7D5802B9;
        Thu, 10 Oct 2019 16:09:23 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH 1/3] PCI/ATS: Remove unused PRI and PASID stubs
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20191009225354.181018-1-helgaas@kernel.org>
 <20191009225354.181018-2-helgaas@kernel.org>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <2f3804d1-ad85-b54f-9fd3-788f35121fac@linux.intel.com>
Date:   Thu, 10 Oct 2019 16:07:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009225354.181018-2-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/9/19 3:53 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> The following functions are only used by amd_iommu.c and intel-iommu.c
> (when CONFIG_INTEL_IOMMU_SVM is enabled).  CONFIG_PCI_PRI and
> CONFIG_PCI_PASID are always defined in those cases, so there's no need for
> the stubs.
>
>    pci_enable_pri()
>    pci_disable_pri()
>    pci_reset_pri()
>    pci_prg_resp_pasid_required()
>    pci_enable_pasid()
>    pci_disable_pasid()
>
> Remove the unused stubs.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   include/linux/pci-ats.h | 10 ----------
>   1 file changed, 10 deletions(-)
>
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index 67de3a9499bb..963c11f7c56b 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -27,14 +27,7 @@ void pci_restore_pri_state(struct pci_dev *pdev);
>   int pci_reset_pri(struct pci_dev *pdev);
>   int pci_prg_resp_pasid_required(struct pci_dev *pdev);
>   #else /* CONFIG_PCI_PRI */
> -static inline int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
> -{ return -ENODEV; }
> -static inline void pci_disable_pri(struct pci_dev *pdev) { }
>   static inline void pci_restore_pri_state(struct pci_dev *pdev) { }
> -static inline int pci_reset_pri(struct pci_dev *pdev)
> -{ return -ENODEV; }
> -static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> -{ return 0; }
>   #endif /* CONFIG_PCI_PRI */
>   
>   #ifdef CONFIG_PCI_PASID
> @@ -44,9 +37,6 @@ void pci_restore_pasid_state(struct pci_dev *pdev);
>   int pci_pasid_features(struct pci_dev *pdev);
>   int pci_max_pasids(struct pci_dev *pdev);
>   #else /* CONFIG_PCI_PASID */
> -static inline int pci_enable_pasid(struct pci_dev *pdev, int features)
> -{ return -EINVAL; }
> -static inline void pci_disable_pasid(struct pci_dev *pdev) { }
>   static inline void pci_restore_pasid_state(struct pci_dev *pdev) { }
>   static inline int pci_pasid_features(struct pci_dev *pdev)
>   { return -EINVAL; }

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

