Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873173DAEC8
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 00:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhG2WZr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 18:25:47 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:43547 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhG2WZq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 18:25:46 -0400
Received: by mail-il1-f169.google.com with SMTP id x7so4118132ilh.10;
        Thu, 29 Jul 2021 15:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/aC99Iu0Lbk5aCpNG1EP7BkY/PlQCFTDv6tZFmoT4to=;
        b=taflZroEbgqdCNt6u3acyu6z47k5u6MWJYOlmOxrbIly3JtJy3g5UUlHpiqJLl6W53
         bh8yYTLGg9Hncb3ny5Fko1jbLLv7z23q8AGtOI+K+cXdJ/UHOAkFUduVwTwu/ct2Vjy/
         8hhhPM7kT6faRNq3v8iARpZwkuyLgtWafFC+oD/J8032kqx5aYKcuBCoxjuz7Qh3M7AN
         i6j2wOs58vzeRXTLJO638xHgL0qhiyYuhD/KjURsXtaLetFFlFhTXLyV9g2U8EiML8BT
         +X6XG3Sv4iQat/LhcKG9MZz4ufEv9DYxGdHQqM5JZsYHzQVu4ESxlDUx7fo3hgurgtYg
         HgSQ==
X-Gm-Message-State: AOAM532vPdinbhOGTjujgquReyVMYDupPvy2RnU9bdKcC/zbpOGtjiOH
        t91D46zS+Y6w0GVdnXRSyw==
X-Google-Smtp-Source: ABdhPJygF+DGb0ov5OEhfhmd/o0r6FJ5+aiZ3DxlC6htdV2NzPesAASgz05K1tfkyG0Y7Y+lZrWTiw==
X-Received: by 2002:a05:6e02:190e:: with SMTP id w14mr5049395ilu.61.1627597542869;
        Thu, 29 Jul 2021 15:25:42 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id h24sm3240751ioj.32.2021.07.29.15.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:25:42 -0700 (PDT)
Received: (nullmailer pid 1013223 invoked by uid 1000);
        Thu, 29 Jul 2021 22:25:40 -0000
Date:   Thu, 29 Jul 2021 16:25:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: qcom: Introduce enable/disable resource ops
Message-ID: <YQMq5OsmskE64w0i@robh.at.kernel.org>
References: <20210725040038.3966348-1-bjorn.andersson@linaro.org>
 <20210725040038.3966348-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210725040038.3966348-2-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 24, 2021 at 09:00:36PM -0700, Bjorn Andersson wrote:
> The current model of doing resource enablement and controller
> initialization in a single "init" function invoked after
> dw_pcie_host_init() is invoked might result in clocks not being enabled
> at the time the "msi" interrupt fires.

This seems like working around DWC ops...

> One such case happens reliably on the SC8180x (8cx) Snapdragon laptops,
> where it's seems like the bootloader touches PCIe and leaves things in a
> state that the "msi" interrupt will fire before we have a change to

s/change/chance/

> enable the clocks, resulting in an access of unclocked hardware.

How does the MSI fire without the clocks or a link? Can't you quiesce 
things?

> Introduce a two new callbacks, allowing the individual resource handling
> functions to be split between enable/init and deinit/disable.
> 
> Helper functions for enable, disable and deinit are introduced to handle
> the fact that these functions may now be left without implementation.
> init is given a wrapper for symmetry.

I think you can simply flip the order the MSI init and host_init() in 
dw_pcie_host_init().

In general, I want to move some of the resource setup (clks, phys, 
perst#, etc.) into the DWC core and make the DWC ops more specific in 
what they do and touch. That should simplify at least the simple cases. 
For Qcom, maybe some of the ops can be moved to new DWC ops.

Rob


> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 42 +++++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 8a7a300163e5..8a64a126de2b 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -181,9 +181,11 @@ struct qcom_pcie;
>  
>  struct qcom_pcie_ops {
>  	int (*get_resources)(struct qcom_pcie *pcie);
> +	int (*enable_resources)(struct qcom_pcie *pcie);
>  	int (*init)(struct qcom_pcie *pcie);
>  	int (*post_init)(struct qcom_pcie *pcie);
>  	void (*deinit)(struct qcom_pcie *pcie);
> +	void (*disable_resources)(struct qcom_pcie *pcie);
>  	void (*post_deinit)(struct qcom_pcie *pcie);
>  	void (*ltssm_enable)(struct qcom_pcie *pcie);
>  	int (*config_sid)(struct qcom_pcie *pcie);
> @@ -1345,6 +1347,31 @@ static int qcom_pcie_config_sid_sm8250(struct qcom_pcie *pcie)
>  	return 0;
>  }
>  
> +static int qcom_pcie_enable_resources(struct qcom_pcie *pcie)
> +{
> +	if (pcie->ops->enable_resources)
> +		return pcie->ops->enable_resources(pcie);
> +
> +	return 0;
> +}
> +
> +static int qcom_pcie_init(struct qcom_pcie *pcie)
> +{
> +	return pcie->ops->init(pcie);
> +}
> +
> +static void qcom_pcie_deinit(struct qcom_pcie *pcie)
> +{
> +	if (pcie->ops->deinit)
> +		pcie->ops->deinit(pcie);
> +}
> +
> +static void qcom_pcie_disable_resources(struct qcom_pcie *pcie)
> +{
> +	if (pcie->ops->disable_resources)
> +		pcie->ops->disable_resources(pcie);
> +}
> +
>  static int qcom_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -1353,7 +1380,7 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>  
>  	qcom_ep_reset_assert(pcie);
>  
> -	ret = pcie->ops->init(pcie);
> +	ret = qcom_pcie_init(pcie);
>  	if (ret)
>  		return ret;
>  
> @@ -1384,7 +1411,7 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>  err_disable_phy:
>  	phy_power_off(pcie->phy);
>  err_deinit:
> -	pcie->ops->deinit(pcie);
> +	qcom_pcie_deinit(pcie);
>  
>  	return ret;
>  }
> @@ -1520,10 +1547,14 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  
>  	pp->ops = &qcom_pcie_dw_ops;
>  
> +	ret = qcom_pcie_enable_resources(pcie);
> +	if (ret)
> +		goto err_pm_runtime_put;
> +
>  	ret = phy_init(pcie->phy);
>  	if (ret) {
>  		pm_runtime_disable(&pdev->dev);
> -		goto err_pm_runtime_put;
> +		goto err_disable_resources;
>  	}
>  
>  	platform_set_drvdata(pdev, pcie);
> @@ -1532,11 +1563,14 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	if (ret) {
>  		dev_err(dev, "cannot initialize host\n");
>  		pm_runtime_disable(&pdev->dev);
> -		goto err_pm_runtime_put;
> +		goto err_disable_resources;
>  	}
>  
>  	return 0;
>  
> +err_disable_resources:
> +	qcom_pcie_disable_resources(pcie);
> +
>  err_pm_runtime_put:
>  	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
> -- 
> 2.29.2
> 
> 
