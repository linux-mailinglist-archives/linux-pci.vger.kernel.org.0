Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E166379CE
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2019 18:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfFFQfy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jun 2019 12:35:54 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51100 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfFFQfy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2019 12:35:54 -0400
Received: by mail-it1-f196.google.com with SMTP id a186so996480itg.0;
        Thu, 06 Jun 2019 09:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kZVofKIX8cuevQT7Eo8t89U9uZvINfNqGUyEDzkiDB8=;
        b=ndP56wM7bylQINUrjIQ9Ij5CE71JfnJe0DB5gosPulnzn3aE4r5QN3rTOy7WFQK6jn
         C/Z0LF8GPKjaraty0LCA8Vxhoy4a5Z3JtA+ElqmXPo8GeU+M3OeJTe3JmDeStEw91rYS
         eviNeXiUJqwQ+zFFkygjdmWjxO942+BEbSdBYYBxxm5YzSeaRFj/Tl/n470l4anL1T8S
         R66T726U1G37tThzShIXtRsSjo52297Hf5sy0IgMcwg5VExLcdAPsgT1R6tqwSSEjc31
         O0qFBDdoExVgT18QuUyD6XNjF3Izh0tS+D/oWH5ZJtMVuvwpPqc+qZbl61m5joLHB5CO
         yRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kZVofKIX8cuevQT7Eo8t89U9uZvINfNqGUyEDzkiDB8=;
        b=DDWTd/howMjRri98+VZUnckQCs2DQYgzJINm1f1zunZLxKcoiTzsH2d9vJC/sm4pIA
         hhRmO0RsbWjQLs4pgtR6V3MxaXrq3v1oR3iB3XnmY7NMsK5YCSzxbf3AWI/6yiYvfVwl
         leB+ofrXlZvD6cWjU0Zj75+CfWeO65s6uO5FYM8hporE0pN/2NFNuAIzyWjcYr/6jkwD
         DCkNBYbIMB5zE+Rw1EokeG++SmCXm3vf+qUVCse5SoEKCjeqLTUuRJ6kPZEe993DGDP0
         PYGlQLXHHQaechtCNqQ1EvTzcpuIwyXBGdC8U1MZnuY40JeMkNz4d/qNScJNrZjrIPUy
         KWxQ==
X-Gm-Message-State: APjAAAXOcfycX2uOsre4hSjjpfPzkvtgqIXshVpKckde46pnDnpbc2PD
        VuQlvgb6OlmSGbk19uf/zFY=
X-Google-Smtp-Source: APXvYqy5UJ1Ew/Rn199zv3Jda6+BDkgik9cm4AqeLCU1a8gIDZAzg15i4BGv0jZa74ArwP9AjTV/LA==
X-Received: by 2002:a02:1a86:: with SMTP id 128mr32154721jai.95.1559838953406;
        Thu, 06 Jun 2019 09:35:53 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.35.141])
        by smtp.googlemail.com with ESMTPSA id 20sm798893iog.62.2019.06.06.09.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 09:35:53 -0700 (PDT)
Subject: Re: [PATCH V8 14/15] PCI: tegra: Add Tegra194 PCIe support
To:     Vidya Sagar <vidyas@nvidia.com>, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com
Cc:     mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20190526043751.12729-1-vidyas@nvidia.com>
 <20190526043751.12729-15-vidyas@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f30e7fc6-3f64-d321-c32c-5e273115a869@gmail.com>
Date:   Thu, 6 Jun 2019 19:35:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190526043751.12729-15-vidyas@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

26.05.2019 7:37, Vidya Sagar пишет:
> Add support for Synopsys DesignWare core IP based PCIe host controller
> present in Tegra194 SoC.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v7]:
> * Addressed review comments from Thierry
> 
> Changes since [v6]:
> * Removed code around "nvidia,disable-aspm-states" DT property
> * Refactored code to remove code duplication
> 
> Changes since [v5]:
> * Addressed review comments from Thierry
> 
> Changes since [v4]:
> * None
> 
> Changes since [v3]:
> * None
> 
> Changes since [v2]:
> * Changed 'nvidia,init-speed' to 'nvidia,init-link-speed'
> * Changed 'nvidia,pex-wake' to 'nvidia,wake-gpios'
> * Removed .runtime_suspend() & .runtime_resume() implementations
> 
> Changes since [v1]:
> * Made CONFIG_PCIE_TEGRA194 as 'm' by default from its previous 'y' state
> * Modified code as per changes made to DT documentation
> * Refactored code to address Bjorn & Thierry's review comments
> * Added goto to avoid recursion in tegra_pcie_dw_host_init() API
> * Merged .scan_bus() of dw_pcie_host_ops implementation to tegra_pcie_dw_host_init() API
> 
>  drivers/pci/controller/dwc/Kconfig         |   10 +
>  drivers/pci/controller/dwc/Makefile        |    1 +
>  drivers/pci/controller/dwc/pcie-tegra194.c | 1621 ++++++++++++++++++++
>  3 files changed, 1632 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-tegra194.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index a6ce1ee51b4c..884112afc11b 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -220,6 +220,16 @@ config PCI_MESON
>  	  and therefore the driver re-uses the DesignWare core functions to
>  	  implement the driver.
>  
> +config PCIE_TEGRA194
> +	tristate "NVIDIA Tegra194 (and later) PCIe controller"
> +	depends on (TEGRA_BPMP && ARCH_TEGRA) || COMPILE_TEST

TEGRA_BPMP will be enough here as it depends on other relevant options.

Hence I mean:

	depends on TEGRA_BPMP || COMPILE_TEST


> +	depends on PCI_MSI_IRQ_DOMAIN

You probably want to s/depends on/select/ PCI_MSI_IRQ_DOMAIN, don't you?

-- 
Dmitry
