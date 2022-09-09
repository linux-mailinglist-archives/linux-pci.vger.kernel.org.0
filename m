Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827805B432B
	for <lists+linux-pci@lfdr.de>; Sat, 10 Sep 2022 01:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiIIXpd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 19:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIIXpc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 19:45:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153F1DEF6;
        Fri,  9 Sep 2022 16:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662767131; x=1694303131;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=asEcKDlIKNqv3ONAC7H8uaLv5u+H4FMYR0OyeOLyz94=;
  b=DI7zlLi5Kx/ues9mIf2SyeiXPSAAgMhHEAN8xSCXLromPWU+IU5VQ5Cr
   NmAVmwR6VBpvTxIpeWD0n3PXJoHyPDJVkisymQNZzyrValgiwfwi4OMqF
   OIw26H4JI05hEHq6s2FYpsU4HYtqPQhZb/IsgfdwyHjuanhfzruUGanbB
   N8WJziDvOUcghRaA+xkSUV0S7+alfalUX6YWioTbRCm+eDDVYTbeIZV6n
   J+Dw8UTNZrZ7mgP9VKN/ED8XoIHxfLy6rxELGyBs82MdgNzQbkwf7v+KY
   QhPa5sheD2ptP+tyulgdiMKSxKWpHNJd0JQbwTJZ3mfrhPapFsr6wdM80
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="277984856"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="277984856"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:45:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="677365475"
Received: from gtpedreg-mobl.amr.corp.intel.com (HELO [10.209.57.19]) ([10.209.57.19])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:45:30 -0700
Message-ID: <5440c1b9-6b46-32b8-e3c7-41c5285525c4@linux.intel.com>
Date:   Fri, 9 Sep 2022 16:45:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v4 5/9] PCI/PTM: Move pci_ptm_info() body into its only
 caller
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20220909202505.314195-1-helgaas@kernel.org>
 <20220909202505.314195-6-helgaas@kernel.org>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220909202505.314195-6-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/9/22 1:25 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> pci_ptm_info() is simple and is only called by pci_enable_ptm().  Move the
> entire body there.  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/pci/pcie/ptm.c | 38 +++++++++++++++++---------------------
>  1 file changed, 17 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index 70a28b74e721..fc296b352fe2 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -9,26 +9,6 @@
>  #include <linux/pci.h>
>  #include "../pci.h"
>  
> -static void pci_ptm_info(struct pci_dev *dev)
> -{
> -	char clock_desc[8];
> -
> -	switch (dev->ptm_granularity) {
> -	case 0:
> -		snprintf(clock_desc, sizeof(clock_desc), "unknown");
> -		break;
> -	case 255:
> -		snprintf(clock_desc, sizeof(clock_desc), ">254ns");
> -		break;
> -	default:
> -		snprintf(clock_desc, sizeof(clock_desc), "%uns",
> -			 dev->ptm_granularity);
> -		break;
> -	}
> -	pci_info(dev, "PTM enabled%s, %s granularity\n",
> -		 dev->ptm_root ? " (root)" : "", clock_desc);
> -}
> -
>  static void __pci_disable_ptm(struct pci_dev *dev)
>  {
>  	u16 ptm = dev->ptm_cap;
> @@ -213,16 +193,32 @@ static int __pci_enable_ptm(struct pci_dev *dev)
>  int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
>  {
>  	int rc;
> +	char clock_desc[8];
>  
>  	rc = __pci_enable_ptm(dev);
>  	if (rc)
>  		return rc;
>  
>  	dev->ptm_enabled = 1;
> -	pci_ptm_info(dev);
>  
>  	if (granularity)
>  		*granularity = dev->ptm_granularity;
> +
> +	switch (dev->ptm_granularity) {
> +	case 0:
> +		snprintf(clock_desc, sizeof(clock_desc), "unknown");
> +		break;
> +	case 255:
> +		snprintf(clock_desc, sizeof(clock_desc), ">254ns");
> +		break;
> +	default:
> +		snprintf(clock_desc, sizeof(clock_desc), "%uns",
> +			 dev->ptm_granularity);
> +		break;
> +	}
> +	pci_info(dev, "PTM enabled%s, %s granularity\n",
> +		 dev->ptm_root ? " (root)" : "", clock_desc);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(pci_enable_ptm);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
