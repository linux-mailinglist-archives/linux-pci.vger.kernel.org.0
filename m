Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D13ABD1C4B
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 00:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbfJIW5I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 18:57:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:7217 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731134AbfJIW5I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Oct 2019 18:57:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 15:57:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,277,1566889200"; 
   d="scan'208";a="193017895"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 09 Oct 2019 15:57:06 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id D516B5803E4;
        Wed,  9 Oct 2019 15:57:06 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH 2/2] PCI/ATS: Move pci_prg_resp_pasid_required() to
 CONFIG_PCI_PRI
To:     Bjorn Helgaas <helgaas@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20191009224551.179497-1-helgaas@kernel.org>
 <20191009224551.179497-3-helgaas@kernel.org>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <67a573e9-3e04-5fca-6b8b-018b7bc75df8@linux.intel.com>
Date:   Wed, 9 Oct 2019 15:55:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009224551.179497-3-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/9/19 3:45 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> pci_prg_resp_pasid_required() returns the value of the "PRG Response PASID
> Required" bit from the PRI capability, but the interface was previously
> defined under #ifdef CONFIG_PCI_PASID.
>
> Move it from CONFIG_PCI_PASID to CONFIG_PCI_PRI so it's with the other
> PRI-related things.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   drivers/pci/ats.c       | 55 +++++++++++++++++++----------------------
>   include/linux/pci-ats.h | 11 ++++-----
>   2 files changed, 30 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index e18499243f84..0d06177252c7 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -280,6 +280,31 @@ int pci_reset_pri(struct pci_dev *pdev)
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(pci_reset_pri);
> +
> +/**
> + * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
> + *				 status.
> + * @pdev: PCI device structure
> + *
> + * Returns 1 if PASID is required in PRG Response Message, 0 otherwise.
> + */
> +int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> +{
> +	u16 status;
> +	int pos;
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> +	if (!pos)
> +		return 0;
> +
> +	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
> +
> +	if (status & PCI_PRI_STATUS_PASID)
> +		return 1;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
>   #endif /* CONFIG_PCI_PRI */
>   
>   #ifdef CONFIG_PCI_PASID
> @@ -395,36 +420,6 @@ int pci_pasid_features(struct pci_dev *pdev)
>   }
>   EXPORT_SYMBOL_GPL(pci_pasid_features);
>   
> -/**
> - * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
> - *				 status.
> - * @pdev: PCI device structure
> - *
> - * Returns 1 if PASID is required in PRG Response Message, 0 otherwise.
> - *
> - * Even though the PRG response PASID status is read from PRI Status
> - * Register, since this API will mainly be used by PASID users, this
> - * function is defined within #ifdef CONFIG_PCI_PASID instead of
> - * CONFIG_PCI_PRI.
> - */
> -int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> -{
> -	u16 status;
> -	int pos;
> -
> -	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> -	if (!pos)
> -		return 0;
> -
> -	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
> -
> -	if (status & PCI_PRI_STATUS_PASID)
> -		return 1;
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
> -
>   #define PASID_NUMBER_SHIFT	8
>   #define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
>   /**
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index 1ebb88e7c184..a7a2b3d94fcc 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -10,6 +10,7 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
>   void pci_disable_pri(struct pci_dev *pdev);
>   void pci_restore_pri_state(struct pci_dev *pdev);
>   int pci_reset_pri(struct pci_dev *pdev);
> +int pci_prg_resp_pasid_required(struct pci_dev *pdev);
>   
>   #else /* CONFIG_PCI_PRI */
>   
> @@ -31,6 +32,10 @@ static inline int pci_reset_pri(struct pci_dev *pdev)
>   	return -ENODEV;
>   }
>   
> +static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> +{
> +	return 0;
> +}
>   #endif /* CONFIG_PCI_PRI */
>   
>   #ifdef CONFIG_PCI_PASID
> @@ -40,7 +45,6 @@ void pci_disable_pasid(struct pci_dev *pdev);
>   void pci_restore_pasid_state(struct pci_dev *pdev);
>   int pci_pasid_features(struct pci_dev *pdev);
>   int pci_max_pasids(struct pci_dev *pdev);
> -int pci_prg_resp_pasid_required(struct pci_dev *pdev);
>   
>   #else  /* CONFIG_PCI_PASID */
>   
> @@ -66,11 +70,6 @@ static inline int pci_max_pasids(struct pci_dev *pdev)
>   {
>   	return -EINVAL;
>   }
> -
> -static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> -{
> -	return 0;
> -}
>   #endif /* CONFIG_PCI_PASID */
>   
>   

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

