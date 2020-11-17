Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EBB2B712A
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 23:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgKQWBC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 17:01:02 -0500
Received: from mga14.intel.com ([192.55.52.115]:61259 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgKQWBB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Nov 2020 17:01:01 -0500
IronPort-SDR: dCgte3pvOPdtmM6pzsEICc+k2YwMihmUB5i8gq98WNv3hBrGCRU72MTg3LbeW5Ldg4nS0EeF1o
 WBZVM7oDA1Dg==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="170238893"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="170238893"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 14:00:59 -0800
IronPort-SDR: OS97W7zIxXgebRJ4qGlwW4dETSzIhTftuSahs2Isaygs5I8bQDIZPrsGzh9YFe5vM5snu0Th6Z
 65aIpYjI7rAA==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="544225340"
Received: from chimtrax-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.101.222])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 14:00:58 -0800
Subject: Re: [PATCH v11 09/16] PCI/ERR: Avoid negated conditional for clarity
To:     Sean V Kelley <sean.v.kelley@intel.com>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, xerces.zhao@gmail.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201117191954.1322844-1-sean.v.kelley@intel.com>
 <20201117191954.1322844-10-sean.v.kelley@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <c430ba69-3e2c-a6fc-fc41-a27567f88b06@linux.intel.com>
Date:   Tue, 17 Nov 2020 14:00:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201117191954.1322844-10-sean.v.kelley@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/17/20 11:19 AM, Sean V Kelley wrote:
> Reverse the sense of the Root Port/Downstream Port conditional for clarity.
> No functional change intended.
> 
> [bhelgaas: split to separate patch]
> Link: https://lore.kernel.org/r/20201002184735.1229220-6-seanvk.dev@oregontracks.org
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   drivers/pci/pcie/err.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 46a5b84f8842..931e75f2549d 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -159,11 +159,11 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   	 * Error recovery runs on all subordinates of the bridge.  If the
>   	 * bridge detected the error, it is cleared at the end.
>   	 */
> -	if (!(type == PCI_EXP_TYPE_ROOT_PORT ||
> -	      type == PCI_EXP_TYPE_DOWNSTREAM))
> -		bridge = pci_upstream_bridge(dev);
> -	else
> +	if (type == PCI_EXP_TYPE_ROOT_PORT ||
> +	    type == PCI_EXP_TYPE_DOWNSTREAM)
>   		bridge = dev;
> +	else
> +		bridge = pci_upstream_bridge(dev);
>   
>   	bus = bridge->subordinate;
>   	pci_dbg(bridge, "broadcast error_detected message\n");
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
