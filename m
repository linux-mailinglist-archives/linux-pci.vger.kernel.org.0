Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981E16BF103
	for <lists+linux-pci@lfdr.de>; Fri, 17 Mar 2023 19:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjCQSu0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Mar 2023 14:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCQSuZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Mar 2023 14:50:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA1D4FAAE;
        Fri, 17 Mar 2023 11:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679079024; x=1710615024;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R3e7PiMz2+SnjvVMla+MAuiDQChIJrKCsnrgvzzqEqU=;
  b=SnAZnbG7iAwp4lYIbPXYaCAR5zG902WxUTrJ5hhqSbmNjmfAzT0XN5M7
   bQ9qckNABeOoqQxqGRrtobwGBBF2j6PlVokdlf9Bl3kfyY8KeHOSUNYDt
   pUAXSkKpKvskL4alUHPErWknHxDeD+x0WXSHLK//gMC2YF69jhYHxxpTe
   Nl3PCYwut4fyZsJ3VgD2hXy4/vUrS2o7OXrklBXxwPci0Ws1m+fNvuQA1
   VMw2thyqyNxR9Oq9Ah/lpgCqN/lNkf+SU2YEtRdGwwJvql+f1bo9P43EA
   fWo1Um/uPpGKvM9RGlwzTr3j+juT9/Gz5/YzLZdkCGjazHfYPEBweJZ/1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="340694431"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="340694431"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 11:50:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="1009757420"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="1009757420"
Received: from ltd-ie-desk05.amr.corp.intel.com (HELO [10.209.31.165]) ([10.209.31.165])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 11:50:22 -0700
Message-ID: <bd48a3f0-138d-9c48-27d6-a5133f054c96@linux.intel.com>
Date:   Fri, 17 Mar 2023 11:50:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCHv2 pci-next 1/2] PCI/AER: correctable error message as
 KERN_INFO
Content-Language: en-US
To:     Grant Grundler <grundler@chromium.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O 'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajat Jain <rajatja@chromium.org>
References: <20230317175109.3859943-1-grundler@chromium.org>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230317175109.3859943-1-grundler@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/17/23 10:51 AM, Grant Grundler wrote:
> Since correctable errors have been corrected (and counted), the dmesg output
> should not be reported as a warning, but rather as "informational".
> 
> Otherwise, using a certain well known vendor's PCIe parts in a USB4 docking
> station, the dmesg buffer can be spammed with correctable errors, 717 bytes
> per instance, potentially many MB per day.

Why don't you investigate why you are getting so many correctable errors?
Isn't solving the problem preferable to hiding the logs?

> 
> Given the "WARN" priority, these messages have already confused the typical
> user that stumbles across them, support staff (triaging feedback reports),
> and more than a few linux kernel devs. Changing to INFO will hide these
> messages from most audiences.
> 
> Signed-off-by: Grant Grundler <grundler@chromium.org>
> ---
>  drivers/pci/pcie/aer.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f6c24ded134c..cb6b96233967 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -687,23 +687,29 @@ static void __aer_print_error(struct pci_dev *dev,
>  {
>  	const char **strings;
>  	unsigned long status = info->status & ~info->mask;
> -	const char *level, *errmsg;
>  	int i;
>  
>  	if (info->severity == AER_CORRECTABLE) {
>  		strings = aer_correctable_error_string;
> -		level = KERN_WARNING;
> +		pci_info(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n",
> +			info->status, info->mask);
>  	} else {
>  		strings = aer_uncorrectable_error_string;
> -		level = KERN_ERR;
> +		pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n",
> +			info->status, info->mask);
>  	}
>  
>  	for_each_set_bit(i, &status, 32) {
> -		errmsg = strings[i];
> +		const char *errmsg = strings[i];
> +
>  		if (!errmsg)
>  			errmsg = "Unknown Error Bit";
>  
> -		pci_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
> +		if (info->severity == AER_CORRECTABLE)
> +			pci_info(dev, "   [%2d] %-22s%s\n", i, errmsg,
> +				info->first_error == i ? " (First)" : "");
> +		else
> +			pci_err(dev, "   [%2d] %-22s%s\n", i, errmsg,
>  				info->first_error == i ? " (First)" : "");
>  	}
>  	pci_dev_aer_stats_incr(dev, info);
> @@ -724,7 +730,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
>  	agent = AER_GET_AGENT(info->severity, info->status);
>  
> -	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
> +	level = (info->severity == AER_CORRECTABLE) ? KERN_INFO : KERN_ERR;
>  
>  	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
>  		   aer_error_severity_string[info->severity],
> @@ -797,14 +803,17 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
>  	info.mask = mask;
>  	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
>  
> -	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
>  	__aer_print_error(dev, &info);
> -	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
> -		aer_error_layer[layer], aer_agent_string[agent]);
>  
> -	if (aer_severity != AER_CORRECTABLE)
> +	if (aer_severity == AER_CORRECTABLE) {
> +		pci_info(dev, "aer_layer=%s, aer_agent=%s\n",
> +			aer_error_layer[layer], aer_agent_string[agent]);
> +	} else {
> +		pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
> +			aer_error_layer[layer], aer_agent_string[agent]);
>  		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
>  			aer->uncor_severity);
> +	}
>  
>  	if (tlp_header_valid)
>  		__print_tlp_header(dev, &aer->header_log);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
