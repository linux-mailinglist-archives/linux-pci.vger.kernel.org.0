Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D292166432
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2020 18:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgBTRTM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Feb 2020 12:19:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38332 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbgBTRTM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2020 12:19:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id e8so5532445wrm.5
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2020 09:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=boCKpekBoONnu2x2vJLKUmcg4VOjDu6Z9N8Skkewyns=;
        b=Q13xE83+LcPqrhNEh6NHQ1au8Z2/JdUbzmH/YLYPtNTl7+yBHFo+N44wCR6BcWL64h
         qDDU/nED0VcmMpdOrIIWijZATAFcEesI6K53ZBUyGnTA257zjvpBTObdSBEoIVMFW084
         w3bofiy4YocKcnWyPfO/IjtVY5KJO7gD9ldqZDn/YKapVyXablODffPaZnXim8QAXyod
         JEiGZse4W9m+DuLYCD94g+KYCWiSlC4xLHlwyceulK0sYwmKqDrsQW36S072RVSWko4w
         +A4VFlEdGAzmsR+9xGGvJZM1NjF2F0Rgqp5FcIiEW/YL8oE4/eBhgmdeSIBZ0UBUOOVW
         +3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=boCKpekBoONnu2x2vJLKUmcg4VOjDu6Z9N8Skkewyns=;
        b=FV90EA9nPE0O5uJSRkJH3R45OOjpv/bMQxIVzX6bWHcl0jWBEuaxtcDqTqYSbZPlji
         0iyeBCxaLjiBFvfFlXkz+CPnJ+ehHd0o44YSRMa5nhmuSiJboiLMCGOd9+f/MSldylzc
         QAJpyg7euQB86EGwI/17z7WQ37ZhL+6EwbGCXLXUoX8OJ2YbagfnIycZm4L+fQt1+2DF
         RTBNc2dnDrUP/8WRZWOq7s7kwMyf2aeeL73udsFqrFXS8pjxUBPMeCZpqkQF1Oeb+e24
         VqcSnfbUvmVY3AYmazPWG0KYvlcQxxF0Imd+AUjwDLz4gJXYZmnJVidxTvu5cXD51O3i
         +CrA==
X-Gm-Message-State: APjAAAW1Tp9XBng9JNNtSVXqqTqK16ZiCJmlHAg3QRJTp1L6sGpU/25u
        NeE41r4ioFgXWY/Cu3d56l0OwQ==
X-Google-Smtp-Source: APXvYqwHG2Hc/+mR7YXbYt7FoyW6wjBkMtpEc3eYy6RMHqggBSxh2ZgyVipp8ipV9eepl//YQQFw3g==
X-Received: by 2002:adf:dfce:: with SMTP id q14mr44306523wrn.324.1582219149052;
        Thu, 20 Feb 2020 09:19:09 -0800 (PST)
Received: from big-machine ([2a00:23c5:dd80:8400:98d8:49e6:cdcc:25df])
        by smtp.gmail.com with ESMTPSA id q1sm264777wrw.5.2020.02.20.09.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 09:19:08 -0800 (PST)
Date:   Thu, 20 Feb 2020 17:19:06 +0000
From:   Andrew Murray <amurray@thegoodpenguin.co.uk>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, andrew.murray@arm.com,
        arnd@arndb.de, mark.rutland@arm.com, l.subrahmanya@mobiveil.co.in,
        shawnguo@kernel.org, m.karthikeyan@mobiveil.co.in,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, Mingkai.Hu@nxp.com,
        Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com
Subject: Re: [PATCHv10 02/13] PCI: mobiveil: Move the host initialization
 into a function
Message-ID: <20200220171906.GE19388@big-machine>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
 <20200213040644.45858-3-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213040644.45858-3-Zhiqiang.Hou@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 13, 2020 at 12:06:33PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Move the host initialization related operations into a new
> routine such that it can be reused by other incoming platform's
> PCIe host driver, in which the Mobiveil GPEX is integrated.
> 
> Change the subject and change log slightly.
> Change the function mobiveil_pcie_host_probe to static.
> Add back the comments that was lost in v9.

Are these three lines above supposed to be in the history below the
--- ?

Perhaps Lorenzo can change that when he applies it.

Reviewed-by: Andrew Murray <amurray@thegoodpenguin.co.uk>

> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V10:
>  - Refined the subject and change log.
>  - Changed the mobiveil_pcie_host_probe() to a static function.
>  - Added back the lost comments.
> 
>  drivers/pci/controller/pcie-mobiveil.c | 39 +++++++++++++++-----------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index d4de560cd711..01df04ea5b48 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -873,27 +873,15 @@ static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
>  	return 0;
>  }
>  
> -static int mobiveil_pcie_probe(struct platform_device *pdev)
> +static int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
>  {
> -	struct mobiveil_pcie *pcie;
> +	struct mobiveil_root_port *rp = &pcie->rp;
> +	struct pci_host_bridge *bridge = rp->bridge;
> +	struct device *dev = &pcie->pdev->dev;
>  	struct pci_bus *bus;
>  	struct pci_bus *child;
> -	struct pci_host_bridge *bridge;
> -	struct device *dev = &pdev->dev;
> -	struct mobiveil_root_port *rp;
>  	int ret;
>  
> -	/* allocate the PCIe port */
> -	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
> -	if (!bridge)
> -		return -ENOMEM;
> -
> -	pcie = pci_host_bridge_priv(bridge);
> -	rp = &pcie->rp;
> -	rp->bridge = bridge;
> -
> -	pcie->pdev = pdev;
> -
>  	ret = mobiveil_pcie_parse_dt(pcie);
>  	if (ret) {
>  		dev_err(dev, "Parsing DT failed, ret: %x\n", ret);
> @@ -956,6 +944,25 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int mobiveil_pcie_probe(struct platform_device *pdev)
> +{
> +	struct mobiveil_pcie *pcie;
> +	struct pci_host_bridge *bridge;
> +	struct device *dev = &pdev->dev;
> +
> +	/* allocate the PCIe port */
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
> +	if (!bridge)
> +		return -ENOMEM;
> +
> +	pcie = pci_host_bridge_priv(bridge);
> +	pcie->rp.bridge = bridge;
> +
> +	pcie->pdev = pdev;
> +
> +	return mobiveil_pcie_host_probe(pcie);
> +}
> +
>  static const struct of_device_id mobiveil_pcie_of_match[] = {
>  	{.compatible = "mbvl,gpex40-pcie",},
>  	{},
> -- 
> 2.17.1
> 
