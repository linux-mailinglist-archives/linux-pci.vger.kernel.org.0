Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096D64F9D4D
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 20:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbiDHSyR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 14:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiDHSyR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 14:54:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88FD2DF67C;
        Fri,  8 Apr 2022 11:52:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7128060E0A;
        Fri,  8 Apr 2022 18:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9787C385A3;
        Fri,  8 Apr 2022 18:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649443931;
        bh=rK22gO2CZuph9kE+09bxScvaDcjvBm/GHuYiaQ2hvV4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gklRPiMC62SixPPM1Ji7waJs7s0Jyp0ZnEbnS4/ArCXf1pAOMOnq3FIfQfre0/hzo
         DIF+sNB6uDg1oYlWgQ0Q6LplwQMUBxxnEDV9eltMd9J0nJTvDqnwLIavcznszTy8/n
         8mklVQsyWN27VAfgzmgZ7i1lovMyTAVAg0LyeZ06D1IA40ozOs8SubGr0fSb+BbHYz
         jDpJaeSwoyJ9wQLgWHcjncudVjIB4HeTqcm44m/0WrBr5ljutjI3bEn0Z8ybDVO/yK
         AVWar4piCXTxgmRUQy1Q2abkcVuuR+aeG11neHkvdtplE7ONpWHbA0q3dL6hajmN93
         JNygfGroLy30A==
Date:   Fri, 8 Apr 2022 13:52:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: PM: Power up all devices during runtime resume
Message-ID: <20220408185210.GA339319@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2652115.mvXUDI8C0e@kreacher>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 08, 2022 at 08:29:01PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] PCI: PM: Power up all devices during runtime resume
> 
> Currently, endpoint devices may not be powered up entirely during
> runtime resume that follows a D3hot -> D0 transition of the parent
> bridge.
> 
> Namely, even if the power state of an endpoint device, as indicated
> by its PCI_PM_CTRL register, is D0 after powering up its parent
> bridge, it may be still necessary to bring its ACPI companion into
> D0 and that should be done before accessing it.  However, the current
> code assumes that reading the PCI_PM_CTRL register is sufficient to
> establish the endpoint device's power state, which may lead to
> problems.
> 
> Address that by forcing a power-up of all PCI devices, including the
> platform firmware part of it, during runtime resume.
> 
> Link: https://lore.kernel.org/linux-pm/11967527.O9o76ZdvQC@kreacher
> Fixes: 5775b843a619 ("PCI: Restore config space on runtime resume despite being unbound")
> Reported-by: Abhishek Sahu <abhsahu@nvidia.com>
> Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I replaced the v1 patch with this one on pci/pm, thanks!

> ---
> 
> v1 -> v2:
>    * Move pci_pm_default_resume_early() away from #ifdef CONFIG_PM_SLEEP.
>    * Add R-by from Mika.
> 
> ---
>  drivers/pci/pci-driver.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-driver.c
> +++ linux-pm/drivers/pci/pci-driver.c
> @@ -551,10 +551,6 @@ static void pci_pm_default_resume(struct
>  	pci_enable_wake(pci_dev, PCI_D0, false);
>  }
>  
> -#endif
> -
> -#ifdef CONFIG_PM_SLEEP
> -
>  static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
>  {
>  	pci_power_up(pci_dev);
> @@ -563,6 +559,10 @@ static void pci_pm_default_resume_early(
>  	pci_pme_restore(pci_dev);
>  }
>  
> +#endif
> +
> +#ifdef CONFIG_PM_SLEEP
> +
>  /*
>   * Default "suspend" method for devices that have no driver provided suspend,
>   * or not even a driver at all (second part).
> @@ -1312,7 +1312,7 @@ static int pci_pm_runtime_resume(struct
>  	 * to a driver because although we left it in D0, it may have gone to
>  	 * D3cold when the bridge above it runtime suspended.
>  	 */
> -	pci_restore_standard_config(pci_dev);
> +	pci_pm_default_resume_early(pci_dev);
>  
>  	if (!pci_dev->driver)
>  		return 0;
> 
> 
> 
