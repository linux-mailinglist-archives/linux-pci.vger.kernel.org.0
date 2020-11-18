Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E732B761B
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 07:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgKRGC0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 01:02:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:26297 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgKRGC0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 01:02:26 -0500
IronPort-SDR: VL1lM0bZz2IuzS6WxQbxoCrq0dONGGpC6QyWdMpA+po17uZVMsIAfhCz/jEWmaGNhK6z9IQBC9
 SQTxl0DZMlCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="158102714"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="158102714"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 22:02:25 -0800
IronPort-SDR: XZBDrmYaDQXFJwHvsYT3k6uj/fOvi8EI4RU6qJzc91tGTVvXTwGVmXPWq+jRRc3ZfyIxgsGhRD
 rPk5iWVT9A0w==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="544356971"
Received: from chimtrax-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.101.222])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 22:02:24 -0800
Subject: Re: [PATCH v11 16/16] PCI/AER: Add RCEC AER error injection support
To:     Sean V Kelley <sean.v.kelley@intel.com>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, xerces.zhao@gmail.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201117191954.1322844-1-sean.v.kelley@intel.com>
 <20201117191954.1322844-17-sean.v.kelley@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <723cf380-fa03-c6ca-ec9c-a8ee562d23b8@linux.intel.com>
Date:   Tue, 17 Nov 2020 22:02:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201117191954.1322844-17-sean.v.kelley@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/17/20 11:19 AM, Sean V Kelley wrote:
> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> Root Complex Event Collectors (RCEC) appear as peers to Root Ports and may
> also have the AER capability.
> 
> Add RCEC support to the AER error injection driver.
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
> Link: https://lore.kernel.org/r/20201002184735.1229220-15-seanvk.dev@oregontracks.org
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/pci/pcie/aer_inject.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
> index c2cbf425afc5..767f8859b99b 100644
> --- a/drivers/pci/pcie/aer_inject.c
> +++ b/drivers/pci/pcie/aer_inject.c
> @@ -333,8 +333,11 @@ static int aer_inject(struct aer_error_inj *einj)
>   	if (!dev)
>   		return -ENODEV;
>   	rpdev = pcie_find_root_port(dev);
> +	/* If Root Port not found, try to find an RCEC */
> +	if (!rpdev)
> +		rpdev = dev->rcec;
>   	if (!rpdev) {
> -		pci_err(dev, "Root port not found\n");
> +		pci_err(dev, "Neither Root Port nor RCEC found\n");
>   		ret = -ENODEV;
>   		goto out_put;
>   	}
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
