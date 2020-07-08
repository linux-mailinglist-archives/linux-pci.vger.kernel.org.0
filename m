Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85159218C7F
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 18:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbgGHQED (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jul 2020 12:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730067AbgGHQED (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jul 2020 12:04:03 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE42C061A0B;
        Wed,  8 Jul 2020 09:04:02 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d4so21879431pgk.4;
        Wed, 08 Jul 2020 09:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i4e593cpPp1JbK9mhrl0XOUScgdAL0u9hY9gCGAke4c=;
        b=VhfdobkYEy+3v5oUfDeNrYdjOFBIdoil78/kedVVOkv4y7daPXhnrT2deNHm1JeGZD
         6naq9YiGSPidHEMAj8MCzz13l3GfFI9uGsy4viYNB8NTcJUFymon9xlaAH+2EozXqM2q
         YzMzY2Ud56eJ51bBtEk98xE16g5a9ad3/kt8YbHYvZAFtbPO2fHIF6Q811Ikd2s3v6B2
         khPa5L7gTE7M/f9+X0zw/efTkelwcZvNX6y3WkiWWTZp9CGg2Hygb/lVEEk5uX4AADu/
         oFGAKebCaX43DRD+PMJiDfHCDlxjeEi8esB5bnQTV3AK6Uimxg2jsHwegjdX3lAY/qhG
         GVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i4e593cpPp1JbK9mhrl0XOUScgdAL0u9hY9gCGAke4c=;
        b=AlKe8qt4BVhYwspdvCKZXMiZkRkXO0wwCaTnkNWZXb0BmoPJ8BLHJdz5mQSeiEGXdY
         RTZoJcn+3dTK9ywYk7Wb131WztPlsfplhqY9GVT8gIcoG4U7va0C20KZ040lKMiq46Pd
         IjgIeSSC3o//vowsyCY+AafmlB1G8Rv/pRX0P3R9qWryHBXRp8ja+V2vKVWUNKL0Vcqe
         tsdINewx1vCcaCvikQTg42inXerT1jtSltG2kcipS0yD09fwTc3MqghyYEQkgmZv3vjP
         31tkWW7qwApm6nO9Q5a4MovvodkIZkSi+ProDYhDwVIeHyXAUHWbQnvxiRXVE3Nt/Y0V
         5i4Q==
X-Gm-Message-State: AOAM531tLbFgdn7lJ5F6JwF/a5omQ/cFx5YxdFOSm4Obx79Vo3niKP5K
        eHe/LnO5f24s/QTY1j+vaKg=
X-Google-Smtp-Source: ABdhPJwVSzJ0zp2pG2hU4YHZRfO5rMlGpBwp58/lM/qJVQQDmkFsMTArBdNzW4V/l95GZ+dSn4QxQQ==
X-Received: by 2002:a62:fcca:: with SMTP id e193mr45366563pfh.307.1594224242432;
        Wed, 08 Jul 2020 09:04:02 -0700 (PDT)
Received: from localhost ([89.208.244.139])
        by smtp.gmail.com with ESMTPSA id y20sm261065pfo.170.2020.07.08.09.04.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jul 2020 09:04:01 -0700 (PDT)
Date:   Thu, 9 Jul 2020 00:03:55 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     jingoohan1@gmail.com, robh@kernel.org, bhelgaas@google.com,
        kgene@kernel.org, thomas.petazzoni@bootlin.com,
        nsaenzjulienne@suse.de, f.fainelli@gmail.com,
        jquinlan@broadcom.com, krzk@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: controller: convert to
 devm_platform_ioremap_resource()
Message-ID: <20200708160355.GA382@nuc8i5>
References: <20200526160110.31898-1-zhengdejin5@gmail.com>
 <20200707133707.GA17163@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707133707.GA17163@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 07, 2020 at 02:37:07PM +0100, Lorenzo Pieralisi wrote:
> On Wed, May 27, 2020 at 12:01:10AM +0800, Dejin Zheng wrote:
> > use devm_platform_ioremap_resource() to simplify code, it
> > contains platform_get_resource() and devm_ioremap_resource().
> > 
> > Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pci-exynos.c | 4 +---
> >  drivers/pci/controller/pci-aardvark.c   | 5 ++---
> >  drivers/pci/controller/pci-ftpci100.c   | 4 +---
> >  drivers/pci/controller/pci-versatile.c  | 6 ++----
> >  drivers/pci/controller/pcie-brcmstb.c   | 4 +---
> >  5 files changed, 7 insertions(+), 16 deletions(-)
> 
> Can you rebase it please against:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/misc
> 
> I will apply it then (please carry over the review tags).
>
Hi Lorenzo:

I have sent the patch v2 for rebase it, Thank you very much!
The link is here: https://patchwork.ozlabs.org/project/linux-pci/patch/20200708155614.308-1-zhengdejin5@gmail.com/

BR,
Dejin
> Lorenzo
> 
> > diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
> > index c5043d951e80..5791039d6a54 100644
> > --- a/drivers/pci/controller/dwc/pci-exynos.c
> > +++ b/drivers/pci/controller/dwc/pci-exynos.c
> > @@ -84,14 +84,12 @@ static int exynos5440_pcie_get_mem_resources(struct platform_device *pdev,
> >  {
> >  	struct dw_pcie *pci = ep->pci;
> >  	struct device *dev = pci->dev;
> > -	struct resource *res;
> >  
> >  	ep->mem_res = devm_kzalloc(dev, sizeof(*ep->mem_res), GFP_KERNEL);
> >  	if (!ep->mem_res)
> >  		return -ENOMEM;
> >  
> > -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	ep->mem_res->elbi_base = devm_ioremap_resource(dev, res);
> > +	ep->mem_res->elbi_base = devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(ep->mem_res->elbi_base))
> >  		return PTR_ERR(ep->mem_res->elbi_base);
> >  
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index 90ff291c24f0..0d98f9b04daa 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -1105,7 +1105,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> >  	struct advk_pcie *pcie;
> > -	struct resource *res, *bus;
> > +	struct resource *bus;
> >  	struct pci_host_bridge *bridge;
> >  	int ret, irq;
> >  
> > @@ -1116,8 +1116,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
> >  	pcie = pci_host_bridge_priv(bridge);
> >  	pcie->pdev = pdev;
> >  
> > -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	pcie->base = devm_ioremap_resource(dev, res);
> > +	pcie->base = devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(pcie->base))
> >  		return PTR_ERR(pcie->base);
> >  
> > diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
> > index 1b67564de7af..221dfc9dc81b 100644
> > --- a/drivers/pci/controller/pci-ftpci100.c
> > +++ b/drivers/pci/controller/pci-ftpci100.c
> > @@ -422,7 +422,6 @@ static int faraday_pci_probe(struct platform_device *pdev)
> >  	struct device *dev = &pdev->dev;
> >  	const struct faraday_pci_variant *variant =
> >  		of_device_get_match_data(dev);
> > -	struct resource *regs;
> >  	struct resource_entry *win;
> >  	struct faraday_pci *p;
> >  	struct resource *io;
> > @@ -465,8 +464,7 @@ static int faraday_pci_probe(struct platform_device *pdev)
> >  		return ret;
> >  	}
> >  
> > -	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	p->base = devm_ioremap_resource(dev, regs);
> > +	p->base = devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(p->base))
> >  		return PTR_ERR(p->base);
> >  
> > diff --git a/drivers/pci/controller/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
> > index b911359b6d81..b34bbfe611e7 100644
> > --- a/drivers/pci/controller/pci-versatile.c
> > +++ b/drivers/pci/controller/pci-versatile.c
> > @@ -77,13 +77,11 @@ static int versatile_pci_probe(struct platform_device *pdev)
> >  	if (!bridge)
> >  		return -ENOMEM;
> >  
> > -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	versatile_pci_base = devm_ioremap_resource(dev, res);
> > +	versatile_pci_base = devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(versatile_pci_base))
> >  		return PTR_ERR(versatile_pci_base);
> >  
> > -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > -	versatile_cfg_base[0] = devm_ioremap_resource(dev, res);
> > +	versatile_cfg_base[0] = devm_platform_ioremap_resource(pdev, 1);
> >  	if (IS_ERR(versatile_cfg_base[0]))
> >  		return PTR_ERR(versatile_cfg_base[0]);
> >  
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > index 7730ea845ff2..04bbf9b40193 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -934,7 +934,6 @@ static int brcm_pcie_probe(struct platform_device *pdev)
> >  	struct device_node *fw_np;
> >  	struct brcm_pcie *pcie;
> >  	struct pci_bus *child;
> > -	struct resource *res;
> >  	int ret;
> >  
> >  	/*
> > @@ -959,8 +958,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
> >  	pcie->dev = &pdev->dev;
> >  	pcie->np = np;
> >  
> > -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	pcie->base = devm_ioremap_resource(&pdev->dev, res);
> > +	pcie->base = devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(pcie->base))
> >  		return PTR_ERR(pcie->base);
> >  
> > -- 
> > 2.25.0
> > 
