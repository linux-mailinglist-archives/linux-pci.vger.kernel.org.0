Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 929B0F08B9
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 22:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfKEVvc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 16:51:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:45562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729698AbfKEVvb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Nov 2019 16:51:31 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A98002087E;
        Tue,  5 Nov 2019 21:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572990690;
        bh=0uPoeY7f8Xl2TSYG/j1gfM+nKOLQlwKRV48yW9UgR20=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VAnRBPHjLKMzEhv5+42ap2Fntzf+XRJthXm3kxA7Yj+mc7WwIcuKPJIUN8g8YpbTO
         6SiUV7u+NJYQ+Fm/v5yvF/6nD/RCBYaWyuHH6CdPEIN6oENxaG9n0ICdRhiUU5M0DY
         VXV5S+o0KhhUwC0kTW8aUGhEoOl19M7n4UWfCRNc=
Date:   Tue, 5 Nov 2019 15:51:29 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        KarimAllah Ahmed <karahmed@amazon.de>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/6] xen-platform: Convert to generic power management
Message-ID: <20191105215129.GA36983@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104152330.GA104689@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 04, 2019 at 09:23:30AM -0600, Bjorn Helgaas wrote:
> On Fri, Nov 01, 2019 at 03:45:56PM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Convert xen-platform from the legacy PCI power management callbacks to the
> > generic operations.  This is one step towards removing support for the
> > legacy PCI callbacks.
> > 
> > The generic .resume_noirq() operation is called by pci_pm_resume_noirq() at
> > the same point the legacy PCI .resume_early() callback was, so this patch
> > should not change the xen-platform behavior.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> I made the tweak below to fix the compile error.  I could swear I
> built this, but I must have been mistaken.
> 
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: KarimAllah Ahmed <karahmed@amazon.de>

I applied this to pci/pm for v5.5 as part of the larger series:
https://lore.kernel.org/r/20191101204558.210235-1-helgaas@kernel.org

> > ---
> >  drivers/xen/platform-pci.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/xen/platform-pci.c b/drivers/xen/platform-pci.c
> > index 5e30602fdbad..e06e8769eb84 100644
> > --- a/drivers/xen/platform-pci.c
> > +++ b/drivers/xen/platform-pci.c
> > @@ -168,13 +168,17 @@ static const struct pci_device_id platform_pci_tbl[] = {
> >  	{0,}
> >  };
> >  
> > +static struct dev_pm_ops platform_pm_ops = {
> > +	.resume_noirq =   platform_pci_resume,
> > +};
> > +
> >  static struct pci_driver platform_driver = {
> >  	.name =           DRV_NAME,
> >  	.probe =          platform_pci_probe,
> >  	.id_table =       platform_pci_tbl,
> > -#ifdef CONFIG_PM
> > -	.resume_early =   platform_pci_resume,
> > -#endif
> > +	.driver = {
> > +		.pm =     &platform_pm_ops,
> > +	},
> >  };
> >  
> >  builtin_pci_driver(platform_driver);
> > -- 
> > 2.24.0.rc1.363.gb1bccd3e3d-goog
> 
> diff --git a/drivers/xen/platform-pci.c b/drivers/xen/platform-pci.c
> index e06e8769eb84..59e85e408c23 100644
> --- a/drivers/xen/platform-pci.c
> +++ b/drivers/xen/platform-pci.c
> @@ -74,7 +74,7 @@ static int xen_allocate_irq(struct pci_dev *pdev)
>  			"xen-platform-pci", pdev);
>  }
>  
> -static int platform_pci_resume(struct pci_dev *pdev)
> +static int platform_pci_resume(struct device *dev)
>  {
>  	int err;
>  
> @@ -83,7 +83,7 @@ static int platform_pci_resume(struct pci_dev *pdev)
>  
>  	err = xen_set_callback_via(callback_via);
>  	if (err) {
> -		dev_err(&pdev->dev, "platform_pci_resume failure!\n");
> +		dev_err(dev, "platform_pci_resume failure!\n");
>  		return err;
>  	}
>  	return 0;
