Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6027AF0DE
	for <lists+linux-pci@lfdr.de>; Tue, 26 Sep 2023 18:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbjIZQik (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Sep 2023 12:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbjIZQij (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Sep 2023 12:38:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F134124;
        Tue, 26 Sep 2023 09:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695746312; x=1727282312;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qxRetNThkLRt2VSTMX62YNW9UWmr4QSEEA0eYnn+ivk=;
  b=iNl4LX6pCLQX5kKZmzuureQnaa7gdgAwcPPDypXzJgx24F4tIUNRuL9D
   /lkGmbIoMim4OsBcpPZpqBe0n7Sd1dhELMcN+7513QEy1D+jXfOsnIpPz
   rHZnKjqfn2laZIQCnLJwcD1lH6HNNPuLCYSYq2Y6cWHUjUWM5YCdkKuhZ
   BHe38BXsS75D107ytm5AjWDqnA+84o22LXyxM7W0s2naZb6KvVvdXo74T
   ArHy2vj87Ezew5NBJK/GWMrVvIJIAAs7Lf18Hb4jE4Wr4vJWtGCTRF5ha
   JyINZCEfe+SD5gmCvHNg+Kfh3iuieoeEXPsmpT1ckZcoGKFzuYXO8UPSg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="445743874"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="445743874"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:38:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="922487397"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="922487397"
Received: from hhalmen-mobl.ger.corp.intel.com ([10.251.219.207])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:38:19 -0700
Date:   Tue, 26 Sep 2023 19:38:16 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
cc:     lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, vigneshr@ti.com,
        r-gunasekaran@ti.com, srk@ti.com
Subject: Re: [PATCH v2] PCI: keystone: Fix race condition when initializing
 PHYs
In-Reply-To: <20230926063638.1005124-1-s-vadapalli@ti.com>
Message-ID: <cb19cfd1-22ed-7880-9fe-8b31488b6bb1@linux.intel.com>
References: <20230926063638.1005124-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 26 Sep 2023, Siddharth Vadapalli wrote:

> The PCI driver invokes the PHY APIs using the ks_pcie_enable_phy()
> function. The PHY in this case is the Serdes. It is possible that the
> PCI instance is configured for 2 lane operation across two different
> Serdes instances, using 1 lane of each Serdes. In such a configuration,
> if the reference clock for one Serdes is provided by the other Serdes,
> it results in a race condition. After the Serdes providing the reference
> clock is initialized by the PCI driver by invoking its PHY APIs, it is
> not guaranteed that this Serdes remains powered on long enough for the
> PHY APIs based initialization of the dependent Serdes. In such cases,
> the PLL of the dependent Serdes fails to lock due to the absence of the
> reference clock from the former Serdes which has been powered off by the
> PM Core.
> 
> Fix this by obtaining reference to the PHYs before invoking the PHY
> initialization APIs and releasing reference after the initialization is
> complete.
> 
> Fixes: 49229238ab47 ("PCI: keystone: Cleanup PHY handling")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> NOTE: This patch is based on linux-next tagged next-20230925.
> 
> v1:
> https://lore.kernel.org/r/20230926054200.963803-1-s-vadapalli@ti.com/
> 
> Changes since v1:
> - Add code to release reference(s) to the phy(s) when
>   ks_pcie_enable_phy(ks_pcie) fails.
> 
> Regards,
> Siddharth.
> 
>  drivers/pci/controller/dwc/pci-keystone.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 49aea6ce3e87..e4d43306a7e3 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -1218,12 +1218,24 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  		goto err_link;
>  	}
>  
> +	/* Obtain reference(s) to the phy(s) */
> +	for (i = 0; i < num_lanes; i++)
> +		phy_pm_runtime_get_sync(ks_pcie->phy[i]);
> +
>  	ret = ks_pcie_enable_phy(ks_pcie);

You could do the put loop here before checking ret to avoid duplicating 
the put loop.

>  	if (ret) {
>  		dev_err(dev, "failed to enable phy\n");
> +		/* Release reference(s) to the phy(s) */
> +		for (i = 0; i < num_lanes; i++)
> +			phy_pm_runtime_put_sync(ks_pcie->phy[i]);
> +
>  		goto err_link;
>  	}
>  
> +	/* Release reference(s) to the phy(s) */
> +	for (i = 0; i < num_lanes; i++)
> +		phy_pm_runtime_put_sync(ks_pcie->phy[i]);
> +
>  	platform_set_drvdata(pdev, ks_pcie);
>  	pm_runtime_enable(dev);
>  	ret = pm_runtime_get_sync(dev);
> 

-- 
 i.


