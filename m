Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB13B4DD2CE
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 03:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiCRCK7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 22:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiCRCK7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 22:10:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1427625F66B;
        Thu, 17 Mar 2022 19:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647569382; x=1679105382;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bcvdTm8vTC17tTtaKL6TbtagXdFa7r13SD1OdJ96w6M=;
  b=meuZUM6a2CSYrm7VW+WrI585lKBNNW8HcQWtf+aSOp5r8/EPf/fWMw1k
   5zOYKseYyod3t0SYFwiE18dbufEJPYJALTaN7LhMmdWqtHWLV75usxe6n
   p8sV2XtX0X/mohvU6sJroXmFkwkRYmtExQwX4WFxr+LU1FK74HkOU9vbA
   svEe/4kdFpdg2HgsRj0HFwS+WcbJCR3tVUc2Z1+lObdRYKfJjds85XmzT
   65S88g//vwRo81CAD62e7VN1jCCjNJuBQW0191rmUQSMDiM3cVPvHYZWX
   yhHAl44dMIVidBBeUTYfzD7tJeF13dPjSdOdPj8PFq9muYZQmXLgVokPi
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="239191312"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="239191312"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 19:09:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="691143655"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 17 Mar 2022 19:09:41 -0700
Received: from mzaid-MOBL1.amr.corp.intel.com (mzaid-MOBL1.amr.corp.intel.com [10.255.228.81])
        by linux.intel.com (Postfix) with ESMTP id F1664580A5D;
        Thu, 17 Mar 2022 19:09:40 -0700 (PDT)
Message-ID: <117f781f5bf8d1c3cee5f8580fb0c9bf8d049cc7.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/2] PCI/PM: refactor pci_pm_suspend_noirq()
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Rajvi Jingar <rajvi.jingar@intel.com>, rafael.j.wysocki@intel.com,
        bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Date:   Thu, 17 Mar 2022 19:09:40 -0700
In-Reply-To: <20220317233153.2617938-1-rajvi.jingar@intel.com>
References: <20220317233153.2617938-1-rajvi.jingar@intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rajvi,

On Thu, 2022-03-17 at 16:31 -0700, Rajvi Jingar wrote:
> The state of the device is saved during pci_pm_suspend_noirq(), if it
> has not already been saved, regardless of the skip_bus_pm flag value. So
> skip_bus_pm check is removed before saving the device state.
> 
> v2: add comments to the changes

...

> 
> Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
> Suggested-by: David E. Box <david.e.box@linux.intel.com>
> ---

Patch changelogs aren't kept in the commit message. Place them here after the
"---" line. In this location, it won't affect applying the patch.

David

>  drivers/pci/pci-driver.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 588588cfda48..ffe76f238d7e 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -834,20 +834,14 @@ static int pci_pm_suspend_noirq(struct device *dev)
>  		}
>  	}
>  
> -	if (pci_dev->skip_bus_pm) {
> +	if (!pci_dev->state_saved) {
> +		pci_save_state(pci_dev);
>  		/*
> -		 * Either the device is a bridge with a child in D0 below it, or
> -		 * the function is running for the second time in a row without
> -		 * going through full resume, which is possible only during
> -		 * suspend-to-idle in a spurious wakeup case.  The device should
> -		 * be in D0 at this point, but if it is a bridge, it may be
> -		 * necessary to save its state.
> +		 * If the device is a bridge with a child in D0 below it, it
> needs to
> +		 * stay in D0, so check skip_bus_pm to avoid putting it into a
> +		 * low-power state in that case.
>  		 */
> -		if (!pci_dev->state_saved)
> -			pci_save_state(pci_dev);
> -	} else if (!pci_dev->state_saved) {
> -		pci_save_state(pci_dev);
> -		if (pci_power_manageable(pci_dev))
> +		if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
>  			pci_prepare_to_sleep(pci_dev);
>  	}
>  

