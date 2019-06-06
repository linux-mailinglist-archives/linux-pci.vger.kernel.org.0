Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D176F37CB6
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2019 20:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbfFFSwO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jun 2019 14:52:14 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42981 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbfFFSwO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2019 14:52:14 -0400
Received: by mail-lf1-f67.google.com with SMTP id y13so916428lfh.9;
        Thu, 06 Jun 2019 11:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z8PImz1JnXXd1v4BcQs+3ZR23KtQ/hYSfKKCTbjF08k=;
        b=Gi1S5xuA9UKUXrvG2FT1MwkkKaTR0i1eD3WmDI6wbKZZsVDt7wMDxd72zaTkdnKcTG
         Bn/cGIABocmR+X5UgVfWdv+hxjxhU6/ByO7aUMXfVhxQ5oiwn8yvDq7kUF65GyvIUmq4
         g8m9xV6nI9EbXIu8r3KfRA7pOMED3btCKcnFZlYLSATI3AZ45udPRmRfC8IfKEckjw4C
         F7xE/RkDaHHINLTxsvgMMSAJMXVXxW/6SeLs0nqSF5G4OVt9/j7GGEe4C80aQNaq6WQY
         01PdG8TyUKhW2xBEAWrDBQGjFkgULhEa/Q0W27hd3NS30uxsFqlXZBZ7PgtzgQNxyarY
         nIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z8PImz1JnXXd1v4BcQs+3ZR23KtQ/hYSfKKCTbjF08k=;
        b=OK6+lsgCX9VCZuwCVjG3wFnwh7Jkl5d3/zTwnPp+bbwieleaTE5f0xiv6TCjtQLvYk
         Ms53MSZyV6dvPuVWrQQOAcTt2Op/7qfIA07Rz2GsPKN07eT1Sm8mpuo2XIkaoK4rMeUV
         HVRMwG3IhZ+oOPIRAubVzEbBoZ5qPqkAznz/gTXx/qTHbVPYFeNZfy7r+ig9C7ixwOUv
         4hRXeqCdZo0mrfFqratATbOnXFvQ6Mi1iLrykRC4LWNMhCzpNLCh+IxdqhPPtqGbEY/f
         AQvd3N4I2Jv4ZTUxR83GSVMLuUwWFhEoOC3wqNs/bRItzbOoWxSVIebPAoLt/8/GmRj5
         V+jg==
X-Gm-Message-State: APjAAAVR5QrIUa5MSQzPH+Y10p9UFKAqiX1lA1nZClv5JBpud8fDGVvs
        ErMDMBDa/fnroKkFvj+o55s=
X-Google-Smtp-Source: APXvYqzLnK2RafyIHBSWtv6ZOXHpj5VhTRezZqTHfceHH/SQk4Rswzzj0YbDWDlkp0qD8FdDqgDPJQ==
X-Received: by 2002:a19:e05c:: with SMTP id g28mr10039317lfj.167.1559847131867;
        Thu, 06 Jun 2019 11:52:11 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.35.141])
        by smtp.googlemail.com with ESMTPSA id p27sm413726lfh.8.2019.06.06.11.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 11:52:10 -0700 (PDT)
Subject: Re: [PATCH V8 14/15] PCI: tegra: Add Tegra194 PCIe support
From:   Dmitry Osipenko <digetx@gmail.com>
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
 <f30e7fc6-3f64-d321-c32c-5e273115a869@gmail.com>
Message-ID: <cbdac43f-32f7-c992-832b-ed40bef2375b@gmail.com>
Date:   Thu, 6 Jun 2019 21:52:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f30e7fc6-3f64-d321-c32c-5e273115a869@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

06.06.2019 19:35, Dmitry Osipenko пишет:
> 26.05.2019 7:37, Vidya Sagar пишет:
>> Add support for Synopsys DesignWare core IP based PCIe host controller
>> present in Tegra194 SoC.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> Changes since [v7]:
>> * Addressed review comments from Thierry
>>
>> Changes since [v6]:
>> * Removed code around "nvidia,disable-aspm-states" DT property
>> * Refactored code to remove code duplication
>>
>> Changes since [v5]:
>> * Addressed review comments from Thierry
>>
>> Changes since [v4]:
>> * None
>>
>> Changes since [v3]:
>> * None
>>
>> Changes since [v2]:
>> * Changed 'nvidia,init-speed' to 'nvidia,init-link-speed'
>> * Changed 'nvidia,pex-wake' to 'nvidia,wake-gpios'
>> * Removed .runtime_suspend() & .runtime_resume() implementations
>>
>> Changes since [v1]:
>> * Made CONFIG_PCIE_TEGRA194 as 'm' by default from its previous 'y' state
>> * Modified code as per changes made to DT documentation
>> * Refactored code to address Bjorn & Thierry's review comments
>> * Added goto to avoid recursion in tegra_pcie_dw_host_init() API
>> * Merged .scan_bus() of dw_pcie_host_ops implementation to tegra_pcie_dw_host_init() API
>>
>>  drivers/pci/controller/dwc/Kconfig         |   10 +
>>  drivers/pci/controller/dwc/Makefile        |    1 +
>>  drivers/pci/controller/dwc/pcie-tegra194.c | 1621 ++++++++++++++++++++
>>  3 files changed, 1632 insertions(+)
>>  create mode 100644 drivers/pci/controller/dwc/pcie-tegra194.c
>>
>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>> index a6ce1ee51b4c..884112afc11b 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -220,6 +220,16 @@ config PCI_MESON
>>  	  and therefore the driver re-uses the DesignWare core functions to
>>  	  implement the driver.
>>  
>> +config PCIE_TEGRA194
>> +	tristate "NVIDIA Tegra194 (and later) PCIe controller"
>> +	depends on (TEGRA_BPMP && ARCH_TEGRA) || COMPILE_TEST
> 
> TEGRA_BPMP will be enough here as it depends on other relevant options.
> 
> Hence I mean:
> 
> 	depends on TEGRA_BPMP || COMPILE_TEST

Maybe it's worth to even change TEGRA_BPMP to ARCH_TEGRA_194_SOC.
Although then you'll have to extend it with other platforms later on,
but probably that's fine.

> 
>> +	depends on PCI_MSI_IRQ_DOMAIN
> 
> You probably want to s/depends on/select/ PCI_MSI_IRQ_DOMAIN, don't you?
> 

I actually looked up the PCI_MSI_IRQ_DOMAIN and it is correct in your
case, my bad.
