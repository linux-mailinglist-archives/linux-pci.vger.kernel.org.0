Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E757C7761F2
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 16:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjHIOCX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 10:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjHIOCW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 10:02:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D672B98;
        Wed,  9 Aug 2023 07:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691589741; x=1723125741;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=L9ygc58fdo1aeBLyS1//aI+mgtgoc2TWGD5CcSP3gyg=;
  b=ZaUcfMY7Zbt1gTdMRil6MbB9zNkLdBhLVT+z0MSB1+BdyVqGrRYEFns9
   6QRJmpYow8bxReUNf/ymIg4Dqa0wJl98TmebjD2959mzbOSAPcBPBXm13
   9u8H1sajCUuDQ2tbtO6CZy/wOqsQAOEPm9DFAq8pneHBA2EI9cbcmQGya
   t8Tq7E58FnH7vV25xzQoMaOHQbBJSzXHQ2uz6n+TVSdM3LiFJCzpnySIf
   pGQvY81yq4jg29cBn1lH1ssRiwDzvVS7pO6cy48cgWDJxDo/Uuv5qzRDa
   c/9n3Y3MmjNUpMLwY6ijGsNni789gLzuf5Im6gG9xA4fJHhO82jTKVY/p
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437491819"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="437491819"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 07:01:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="855550674"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="855550674"
Received: from cvogler-mobl1.ger.corp.intel.com ([10.252.40.229])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 07:01:46 -0700
Date:   Wed, 9 Aug 2023 17:01:44 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sui Jingfeng <sui.jingfeng@linux.dev>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: Re: [PATCH v2 02/11] PCI: Add the pci_get_class_masked() helper
In-Reply-To: <20230808223412.1743176-3-sui.jingfeng@linux.dev>
Message-ID: <19dc4b81-5b72-247c-d459-3ea9d1cddff0@linux.intel.com>
References: <20230808223412.1743176-1-sui.jingfeng@linux.dev> <20230808223412.1743176-3-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 9 Aug 2023, Sui Jingfeng wrote:

> From: Sui Jingfeng <suijingfeng@loongson.cn>
> 
> Because there is no good way to get the mask member used to searching for
> devices that conform to a specific PCI class code, an application needs to
> process all PCI display devices can achieve its goal as follows:

This is mixing old and new way in a single sentence (which is confusing)?
 
> pdev = NULL;
> do {
> 	pdev = pci_get_class_masked(PCI_BASE_CLASS_DISPLAY << 16, 0xFF0000, pdev);
> 	if (pdev)
> 		do_something_for_pci_display_device(pdev);
> } while (pdev);
> 
> While previously, we just can not ignore Sub-Class code and the Programming

cannot

> Interface byte when do the searching.

doing the search.

> 
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/pci/search.c | 30 ++++++++++++++++++++++++++++++
>  include/linux/pci.h  |  7 +++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index b4c138a6ec02..f1c15aea868b 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -334,6 +334,36 @@ struct pci_dev *pci_get_device(unsigned int vendor, unsigned int device,
>  }
>  EXPORT_SYMBOL(pci_get_device);
>  
> +/**
> + * pci_get_class_masked - begin or continue searching for a PCI device by class and mask
> + * @class: search for a PCI device with this class designation
> + * @from: Previous PCI device found in search, or %NULL for new search.
> + *
> + * Iterates through the list of known PCI devices.  If a PCI device is

No double spaces in kernel comments. Perhaps your editor might be adding 
them on reflow (might be configurable to not do that).

> + * found with a matching @class, the reference count to the device is
> + * incremented and a pointer to its device structure is returned.
> + * Otherwise, %NULL is returned.
> + * A new search is initiated by passing %NULL as the @from argument.
> + * Otherwise if @from is not %NULL, searches continue from next device
> + * on the global list.  The reference count for @from is always decremented
> + * if it is not %NULL.

Use kerneldoc's Return: section for describing return value.

> + */
> +struct pci_dev *pci_get_class_masked(unsigned int class, unsigned int mask,
> +				     struct pci_dev *from)
> +{
> +	struct pci_device_id id = {
> +		.vendor = PCI_ANY_ID,
> +		.device = PCI_ANY_ID,
> +		.subvendor = PCI_ANY_ID,
> +		.subdevice = PCI_ANY_ID,
> +		.class_mask = mask,
> +		.class = class,
> +	};
> +
> +	return pci_get_dev_by_id(&id, from);
> +}
> +EXPORT_SYMBOL(pci_get_class_masked);
> +
>  /**
>   * pci_get_class - begin or continue searching for a PCI device by class
>   * @class: search for a PCI device with this class designation
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 0ff7500772e6..b20e7ba844bf 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1180,6 +1180,9 @@ struct pci_dev *pci_get_slot(struct pci_bus *bus, unsigned int devfn);
>  struct pci_dev *pci_get_domain_bus_and_slot(int domain, unsigned int bus,
>  					    unsigned int devfn);
>  struct pci_dev *pci_get_class(unsigned int class, struct pci_dev *from);
> +struct pci_dev *pci_get_class_masked(unsigned int class, unsigned int mask,
> +				     struct pci_dev *from);
> +
>  int pci_dev_present(const struct pci_device_id *ids);
>  
>  int pci_bus_read_config_byte(struct pci_bus *bus, unsigned int devfn,
> @@ -1895,6 +1898,10 @@ static inline struct pci_dev *pci_get_class(unsigned int class,
>  					    struct pci_dev *from)
>  { return NULL; }
>  
> +static inline struct pci_dev *pci_get_class_masked(unsigned int class,
> +						   unsigned int mask,
> +						   struct pci_dev *from)
> +{ return NULL; }
>  
>  static inline int pci_dev_present(const struct pci_device_id *ids)
>  { return 0; }
> 

-- 
 i.

