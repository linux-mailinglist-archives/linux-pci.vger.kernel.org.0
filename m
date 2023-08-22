Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CB27841F4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 15:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjHVNYn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 09:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjHVNYn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 09:24:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA99618B;
        Tue, 22 Aug 2023 06:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692710679; x=1724246679;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Oyh1DVtXWTFJxIjmbrfImZE0rxDAK+zFpWsXtCZGakM=;
  b=PnWckcIb2oCT+5fv6GE4B/p7RhiC9mcdoMXL9d7zk94rQSmrY8bMOO9Q
   92AI53Jf+NmnTR1zxYwlyR02IyaFfo6nab7Mh1hEVCm9+BJpRTwwJE52v
   RcyypPoaq3WbLI0bH4jS92lw2brIT7NivH4+ydWMuUXKYdAmVCoABorFU
   hbmtSlw/m5O1dT7D6ItZz1f/ggQgFU47D1whc6kISJkVLpNEq/eQ6VDNU
   Gju29grh/VYfGFcA3PTtTA3mpZLtpD0U67smUyjySBnvx9zSMAm5wiXtk
   kofnt/8egXzrXtCRWCCF9S2zOU2IDp1OrigzqJMzU5f47yuoeqrd0AkTX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="376613689"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="376613689"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 06:24:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="859920517"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="859920517"
Received: from refaase-mobl.ger.corp.intel.com ([10.252.53.244])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 06:24:33 -0700
Date:   Tue, 22 Aug 2023 16:24:31 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Feiyang Chen <chenfeiyang@loongson.cn>
cc:     bhelgaas@google.com, rafael.j.wysocki@intel.com,
        mika.westerberg@linux.intel.com, helgaas@kernel.org,
        anders.roxell@linaro.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, guyinggang@loongson.cn,
        siyanteng@loongson.cn, chenhuacai@loongson.cn,
        loongson-kernel@lists.loongnix.cn, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v2] PCI/PM: Only read PCI_PM_CTRL register when
 available
In-Reply-To: <20230822115514.999111-1-chenfeiyang@loongson.cn>
Message-ID: <c8beef70-1639-c11e-ae38-d8a07279720@linux.intel.com>
References: <20230822115514.999111-1-chenfeiyang@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 22 Aug 2023, Feiyang Chen wrote:

> When the current state is already PCI_D0, pci_power_up() will return
> 0 even though dev->pm_cap is not set. In that case, we should not
> read the PCI_PM_CTRL register in pci_set_full_power_state().

IMHO, this is a bit misleading because after this patch, pci_power_up() 
returns always an error if dev->pm_cap is not set.

-- 
 i.


> Fixes: e200904b275c ("PCI/PM: Split pci_power_up()")
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> ---
>  drivers/pci/pci.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 60230da957e0..7e90ab7b47a1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1242,9 +1242,6 @@ int pci_power_up(struct pci_dev *dev)
>  		else
>  			dev->current_state = state;
>  
> -		if (state == PCI_D0)
> -			return 0;
> -
>  		return -EIO;
>  	}
>  
> @@ -1302,8 +1299,12 @@ static int pci_set_full_power_state(struct pci_dev *dev)
>  	int ret;
>  
>  	ret = pci_power_up(dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		if (dev->current_state == PCI_D0)
> +			return 0;
> +
>  		return ret;
> +	}
>  
>  	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>  	dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;
> 
