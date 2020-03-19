Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCFDF18BD68
	for <lists+linux-pci@lfdr.de>; Thu, 19 Mar 2020 18:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgCSREX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Mar 2020 13:04:23 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12239 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgCSREX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Mar 2020 13:04:23 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e73a5e40000>; Thu, 19 Mar 2020 10:03:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 19 Mar 2020 10:04:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 19 Mar 2020 10:04:22 -0700
Received: from [10.25.77.145] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Mar
 2020 17:04:20 +0000
Subject: Re: [PATCH] PCI: tegra: Print -EPROBE_DEFER error message at debug
 level
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Jon Hunter <jonathanh@nvidia.com>, <linux-pci@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
References: <20200319131230.3216305-1-thierry.reding@gmail.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <2e763237-fe19-68b3-d584-a3ad28689b87@nvidia.com>
Date:   Thu, 19 Mar 2020 22:34:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319131230.3216305-1-thierry.reding@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1584637412; bh=zdrELNFlowK5Bnf69vjtR/5Mu0YDFJ2bVpzEmz0lv94=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qZ7MJRNZPlxa8nRRIfchayZxwMnmPRXvvz552jgYZju8RheSZmT3WfBa5RDGrwD1o
         egnIvjK9eZCUeFm5696SVSXe9xfE4ZxPnSKlJ8wRg+Fu2GAE1C4lLWxIOW8moVlSea
         ZDQb8E6aYPXFPKUh6ioR4x3T5xk6r3S8vezgSvgHdAkxOYBUuks5HROkffGy2oAfSi
         BBvUf8gZ/aZ1uKp5Ap3IJdG4uREM7MvMpQIavBEpCxHoWbtk3atka9lPsf7gDRC4Us
         bK27GFSeNJFviB0AOzFoWwbKeTTVxleyt5ABlaWxrwvZ1EFIjOjwKciKwNT1fy5HqE
         7xbg0WeEwSizA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/19/2020 6:42 PM, Thierry Reding wrote:
> External email: Use caution opening links or attachments
> 
> 
> From: Thierry Reding <treding@nvidia.com>
> 
> Probe deferral is an expected error condition that will usually be
> recovered from. Print such error messages at debug level to make them
> available for diagnostic purposes when building with debugging enabled
> and hide them otherwise to not spam the kernel log with them.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>   drivers/pci/controller/dwc/pcie-tegra194.c | 42 ++++++++++++++++++----
>   1 file changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 97d3f3db1020..e4870fa6ce9c 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1159,17 +1159,31 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
>          /* Endpoint mode specific DT entries */
>          pcie->pex_rst_gpiod = devm_gpiod_get(pcie->dev, "reset", GPIOD_IN);
>          if (IS_ERR(pcie->pex_rst_gpiod)) {
> -               dev_err(pcie->dev, "Failed to get PERST GPIO: %ld\n",
> -                       PTR_ERR(pcie->pex_rst_gpiod));
> -               return PTR_ERR(pcie->pex_rst_gpiod);
> +               int err = PTR_ERR(pcie->pex_rst_gpiod);
> +               const char *level = KERN_ERR;
> +
> +               if (err == -EPROBE_DEFER)
> +                       level = KERN_DEBUG;
> +
> +               dev_printk(level, pcie->dev,
> +                          dev_fmt("Failed to get PERST GPIO: %d\n"),
> +                          err);
> +               return err;
>          }
> 
>          pcie->pex_refclk_sel_gpiod = devm_gpiod_get(pcie->dev,
>                                                      "nvidia,refclk-select",
>                                                      GPIOD_OUT_HIGH);
>          if (IS_ERR(pcie->pex_refclk_sel_gpiod)) {
> -               dev_info(pcie->dev, "Failed to get REFCLK select GPIOs: %ld\n",
> -                        PTR_ERR(pcie->pex_refclk_sel_gpiod));
> +               int err = PTR_ERR(pcie->pex_refclk_sel_gpiod);
> +               const char *level = KERN_ERR;
> +
> +               if (err == -EPROBE_DEFER)
> +                       level = KERN_DEBUG;
> +
> +               dev_printk(level, pcie->dev,
> +                          dev_fmt("Failed to get REFCLK select GPIOs: %d\n"),
> +                          err);
>                  pcie->pex_refclk_sel_gpiod = NULL;
>          }
> 
> @@ -2058,13 +2072,27 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
> 
>          ret = tegra_pcie_dw_parse_dt(pcie);
>          if (ret < 0) {
> -               dev_err(dev, "Failed to parse device tree: %d\n", ret);
> +               const char *level = KERN_ERR;
> +
> +               if (ret == -EPROBE_DEFER)
> +                       level = KERN_DEBUG;
> +
> +               dev_printk(level, dev,
> +                          dev_fmt("Failed to parse device tree: %d\n"),
> +                          ret);
>                  return ret;
>          }
> 
>          ret = tegra_pcie_get_slot_regulators(pcie);
>          if (ret < 0) {
> -               dev_err(dev, "Failed to get slot regulators: %d\n", ret);
> +               const char *level = KERN_ERR;
> +
> +               if (ret == -EPROBE_DEFER)
> +                       level = KERN_DEBUG;
> +
> +               dev_printk(level, dev,
> +                          dev_fmt("Failed to get slot regulators: %d\n"),
> +                          ret);
>                  return ret;
>          }
> 
> --
> 2.24.1
> 

Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
Tested-by: Vidya Sagar <vidyas@nvidia.com>
