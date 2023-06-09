Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241CD729871
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 13:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbjFILtI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 07:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjFILtH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 07:49:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7323595;
        Fri,  9 Jun 2023 04:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686311346; x=1717847346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/70ZyUQoDKt1Vqap5Dv3N/zlV9MR5BTiq0qKtGBfq6s=;
  b=booTEdKXSxBLTAstEmumVZL6Epj5BdDiRrvzPTfdou5CPQewEDFTQzlT
   vbrU+a2xrq1MToVXbB37di58mV7nCjd1GnKYBj1TwwZZyEaZksD5+TJPX
   Qe6nxao+DI2POLZNaeYEHNjk9BWpN+6eb3G9X+SrLKHVMXOmwxlVAde+d
   8zB11YH6N9jEvQb5uN1r2HxjPCMC+8iWLcESJgiw2ALXeoXTWT6WbL5re
   iwVQNIHj47BTx2S0HrDy+Y0UeoLB8NSQmOwIEp1mo0ploshFou/1wBNp+
   oMZc7t5T0AI+70VT5rkCU/2zRx7vQ1YTIMZlPeZdx2g4KO+ijWL+BHvxm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="360064201"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="360064201"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 04:49:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="800193527"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="800193527"
Received: from lmirabel-mobl1.ger.corp.intel.com (HELO intel.com) ([10.251.211.108])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 04:49:01 -0700
Date:   Fri, 9 Jun 2023 13:48:53 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 1/4] PCI/VGA: Use unsigned type for the io_state
 variable
Message-ID: <ZIMRpbUHcW5qGFBU@ashyti-mobl2.lan>
References: <20230609112417.632313-1-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609112417.632313-1-suijingfeng@loongson.cn>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sui,

On Fri, Jun 09, 2023 at 07:24:14PM +0800, Sui Jingfeng wrote:
> The io_state variable in the vga_arb_write() function is declared with
> unsigned int type, while the vga_str_to_iostate() function takes int *
> type. To keep them consistent, replace the third argument of
> vga_str_to_iostate() function with the unsigned int * type.
> 
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com> 

Andi

> ---
>  drivers/pci/vgaarb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 5a696078b382..c1bc6c983932 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -77,7 +77,7 @@ static const char *vga_iostate_to_str(unsigned int iostate)
>  	return "none";
>  }
>  
> -static int vga_str_to_iostate(char *buf, int str_size, int *io_state)
> +static int vga_str_to_iostate(char *buf, int str_size, unsigned int *io_state)
>  {
>  	/* we could in theory hand out locks on IO and mem
>  	 * separately to userspace but it can cause deadlocks */
> -- 
> 2.25.1
