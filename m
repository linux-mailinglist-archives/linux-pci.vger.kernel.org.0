Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91666308A4
	for <lists+linux-pci@lfdr.de>; Sat, 19 Nov 2022 02:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbiKSBqB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 20:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiKSBpb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 20:45:31 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CB77462B;
        Fri, 18 Nov 2022 17:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668820094; x=1700356094;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rEawY7cJADWJ+am5PyrwXoA8ocs/czhPX4H1n8+3f/E=;
  b=VeTC2ZgtTruZXc8VY7qX6Ad2uvtkmj1tNUNiCZXv3vOZ1VEh5PIkQ56j
   EVoJM3aQ+3q3oz/URTCcb/5c5dwQ835hnLxMSxnJcBhQAdZZdOaNNJE5g
   Pl3BOzy/ItpjRLHtt3FaNw6lxmsc+Dih+sPCocXAGTrnf6PovQxkqjaN6
   pPHh8M7q5DFdSRM+2BMH+WkBDiPMqJomZodYRi5ROmtILD4GsK+/33CB3
   Yr3xAOuHLFcgQx3lwp/bTfXoQxV+gjaU2W5tGO1X8wMNczhZVc+7YqOrS
   4nfAtJ7t5HcW+rxMTY3dz2L7zMBHEyngworfW0Od6JnRjUD/J3av+zGta
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="296634763"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="296634763"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 17:08:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="815118336"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="815118336"
Received: from alsoller-mobl1.amr.corp.intel.com (HELO [10.212.166.83]) ([10.212.166.83])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 17:08:13 -0800
Message-ID: <0eeb70d7-8f97-bd72-6db2-266fc2b0ba1b@linux.intel.com>
Date:   Fri, 18 Nov 2022 17:08:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v3 10/11] PCI/AER: Add optional logging callback for
 correctable error
Content-Language: en-US
To:     Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rostedt@goodmis.org,
        terry.bowman@amd.com, bhelgaas@google.com
References: <166879123216.674819.3578187187954311721.stgit@djiang5-desk3.ch.intel.com>
 <166879134199.674819.15564186577122699358.stgit@djiang5-desk3.ch.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <166879134199.674819.15564186577122699358.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 11/18/22 9:09 AM, Dave Jiang wrote:
> Some new devices such as CXL devices may want to record additional error
> information on a corrected error. Add a callback to allow the PCI device
> driver to do additional logging and/or error handling.

Change looks good. But I am not sure whether this needs to be documented
in Documentation/PCI/pci-error-recovery.rst with usage example. I will let
Bjorn make a call on it.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/pci/pcie/aer.c |    8 +++++++-
>  include/linux/pci.h    |    3 +++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e2d8a74f83c3..af1b5eecbb11 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -961,8 +961,14 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>  		if (aer)
>  			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
>  					info->status);
> -		if (pcie_aer_is_native(dev))
> +		if (pcie_aer_is_native(dev)) {
> +			struct pci_driver *pdrv = dev->driver;
> +
> +			if (pdrv && pdrv->err_handler &&
> +			    pdrv->err_handler->cor_error_log)
> +				pdrv->err_handler->cor_error_log(dev);
>  			pcie_clear_device_status(dev);
> +		}
>  	} else if (info->severity == AER_NONFATAL)
>  		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
>  	else if (info->severity == AER_FATAL)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 575849a100a3..54939b3426a9 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -844,6 +844,9 @@ struct pci_error_handlers {
>  
>  	/* Device driver may resume normal operations */
>  	void (*resume)(struct pci_dev *dev);
> +
> +	/* Allow device driver to record more details of a correctable error */
> +	void (*cor_error_log)(struct pci_dev *dev);
>  };
>  
>  
> 
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
