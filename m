Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C249466952
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 18:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351777AbhLBRrS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 12:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347965AbhLBRrP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 12:47:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2648EC06174A;
        Thu,  2 Dec 2021 09:43:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8B6BB823FB;
        Thu,  2 Dec 2021 17:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421BFC00446;
        Thu,  2 Dec 2021 17:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638467030;
        bh=Wvqr4QMgbo28VZ42PO+nadxc4Mne7hS7quuoqz8hLQ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TJ/suPL5zvfVulaERMDm+NFvtd0ok8UV2/0Tfli6lNEkk+SqJOCqzbs6WSce1U9r4
         MWMtSUeLHsEmM3xyZKE9a58Rlb3r9YtEGXGMI4biKrOhmsscwh/tdOm4ZtOhpqoo1S
         fp3LcFtur0YEh9MmVe5MioLXStoB0kGrf13lom4GIYfaXQclLva9xKTJw/Ib5jYjU3
         +MfVND9jQcDxtefB7l+vdls/ikPzkq3YtcWRsdGttLlkAvpNpIS3QSmx2QbWs1dynB
         qiy/jYhGI6fnU0R2K0MA5H3a9LJBn1C6+SqDxXGu3qNNR7V2+Bw/Hlg/gQY0ZTmUkv
         qewE1tnAmWDBQ==
Date:   Thu, 2 Dec 2021 11:43:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@linux.ie>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/3] amd64-agp: convert to generic power management
Message-ID: <20211202174348.GA2899481@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201025419.2797624-2-helgaas@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[cc->to: Rafael: help :)]

On Tue, Nov 30, 2021 at 08:54:17PM -0600, Bjorn Helgaas wrote:
> From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> 
> Convert amd64-agp from legacy PCI power management to the generic power
> management framework.
> 
> Previously, amd64-agp used legacy PCI power management.
> agp_amd64_suspend() looked like this:
> 
>   agp_amd64_suspend
>     pci_save_state(pdev)
>     pci_set_power_state(pdev, pci_choose_state(pdev, state))
> 
> With generic power management, these are both done by the PCI core in
> pci_pm_runtime_suspend(), so drop agp_amd64_suspend() completely.

I think the *patch* is correct, but my explanation is wrong.  Would
appreciate any corrections!

Prior to this patch, agp_amd64_suspend() is a pci_driver.suspend()
method and is called in this path:

  pci_pm_suspend
    pci_legacy_suspend
      drv->suspend

After this patch, agp_amd64_suspend() is not implemented at all, and
we do the pci_save_state() and pci_set_power_state() in PCI generic
code.

But I think those actually happen in pci_pm_suspend_noirq(), not in
pci_pm_runtime_suspend(), i.e., in this path:

  suspend_devices_and_enter
    dpm_suspend_start(PMSG_SUSPEND)
      dpm_suspend(PMSG_SUSPEND)
        device_suspend
          __device_suspend
            callback = pm_op(dev->bus->pm, state)
            dpm_run_callback(callback)
              pci_pm_suspend                            # PCI bus method
                dev->driver->pm->suspend
                  agp_amd64_suspend                     # <-- no longer needed
    suspend_enter
      dpm_suspend_noirq(PMSG_SUSPEND)
        dpm_noirq_suspend_devices(PMSG_SUSPEND)
          device_suspend_noirq
            __device_suspend_noirq
              callback = pm_noirq_op(dev->bus->pm, state)
              dpm_run_callback(callback)
                pci_pm_suspend_noirq                    # PCI bus method
                  pci_save_state                        # <-- now done here
                  pci_prepare_to_sleep
                    pci_set_power_state                 # <-- and here
                  
I got confused because I couldn't find the call chain leading to
pci_pm_suspend_noirq().  pm_op() and dpm_run_callback() essentially
break the call chain, which makes it a little hard to follow.

> agp_amd64_resume() looked like this:
> 
>   agp_amd64_resume
>     pci_set_power_state(pdev, PCI_D0)
>     pci_restore_state(pdev)
>     ...
> 
> With generic power management, the PCI parts are done by
> pci_pm_runtime_resume(), so drop those from agp_amd64_resume().
> 
> [bhelgaas: commit log]
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/char/agp/amd64-agp.c | 24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
> index b40edae32817..dc78a4fb879e 100644
> --- a/drivers/char/agp/amd64-agp.c
> +++ b/drivers/char/agp/amd64-agp.c
> @@ -588,20 +588,11 @@ static void agp_amd64_remove(struct pci_dev *pdev)
>  	agp_bridges_found--;
>  }
>  
> -#ifdef CONFIG_PM
> +#define agp_amd64_suspend NULL
>  
> -static int agp_amd64_suspend(struct pci_dev *pdev, pm_message_t state)
> +static int __maybe_unused agp_amd64_resume(struct device *dev)
>  {
> -	pci_save_state(pdev);
> -	pci_set_power_state(pdev, pci_choose_state(pdev, state));
> -
> -	return 0;
> -}
> -
> -static int agp_amd64_resume(struct pci_dev *pdev)
> -{
> -	pci_set_power_state(pdev, PCI_D0);
> -	pci_restore_state(pdev);
> +	struct pci_dev *pdev = to_pci_dev(dev);
>  
>  	if (pdev->vendor == PCI_VENDOR_ID_NVIDIA)
>  		nforce3_agp_init(pdev);
> @@ -609,8 +600,6 @@ static int agp_amd64_resume(struct pci_dev *pdev)
>  	return amd_8151_configure();
>  }
>  
> -#endif /* CONFIG_PM */
> -
>  static const struct pci_device_id agp_amd64_pci_table[] = {
>  	{
>  	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
> @@ -738,15 +727,14 @@ static const struct pci_device_id agp_amd64_pci_promisc_table[] = {
>  	{ }
>  };
>  
> +static SIMPLE_DEV_PM_OPS(agp_amd64_pm_ops, agp_amd64_suspend, agp_amd64_resume);
> +
>  static struct pci_driver agp_amd64_pci_driver = {
>  	.name		= "agpgart-amd64",
>  	.id_table	= agp_amd64_pci_table,
>  	.probe		= agp_amd64_probe,
>  	.remove		= agp_amd64_remove,
> -#ifdef CONFIG_PM
> -	.suspend	= agp_amd64_suspend,
> -	.resume		= agp_amd64_resume,
> -#endif
> +	.driver.pm  = &agp_amd64_pm_ops,
>  };
>  
>  
> -- 
> 2.25.1
> 
