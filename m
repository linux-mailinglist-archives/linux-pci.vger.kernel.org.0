Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF20038CF2
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2019 16:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfFGO0h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jun 2019 10:26:37 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44219 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbfFGO0g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jun 2019 10:26:36 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so1904359ljc.11;
        Fri, 07 Jun 2019 07:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=72tWwa0dcIt8Xo0+smV7Jx5Ec2g3rCWEBlAObPTLz0U=;
        b=Quyw9qOD7tAC7+vKO/Ti/b8U2aQSuAwV62sUcW/dxj8F1IM/XPq4mdt6iLlo66b0uZ
         xJAzrC7jTHmIFyk1FjpnwfvVEmArng0fsymszNKfJmiZM6asd2NtB1/StM59cv20Zqk7
         cT1CC7BaCq9aZ3puiuC0oMBVVOg/3ti81TnYMIN8+jawBMsv4yw3oStaUpddRvlojaP+
         U/Rhh6E+N6PgKoV2lPwAzS5N3fPrkMaGoHLjplrfTsZTCfBeSMo7sblg/A6ip3R5fre+
         u1jEc9kwEWwm0xPBCQ1wM1+Y0p+HkUV5W7hL5SF/GVk9EOvI/kr2BVtRCNaKrQW2nfb0
         3Jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=72tWwa0dcIt8Xo0+smV7Jx5Ec2g3rCWEBlAObPTLz0U=;
        b=Tr5wP5U2vNoNtpNAGZ0wiuWcHylbHB4XwbmoxvTszWhkwPGix8spq7qmx8IVpJvdCK
         AMRU4r33y3rZKBY/HEMC1fTsk1iAS/G1v6AWi4CvSo6WGrWN0IEDV1z3jxgRio75ggdD
         7pRWq3VXIj4g4W+/85J3Quy8HAmCMzf3ryGBBitgpA0tQ1ld+LGdRssvyXAFf1HzFVxS
         8ukjJGVyvGmerRJvBfMleDHKdT1Irfs5p43GwH6V4v8EsUrkKj1Wl7VGnipGmm/xk9vZ
         wIFDeYcsL7WDosUioWrBQFfw2IhpTTb50CwPDN9Vt+6HjI8N8s3PY+039jMd40rSjcN+
         PbaQ==
X-Gm-Message-State: APjAAAWx14wzT6FtPi0jq27mU5fKVKvRh/aeg4KkdRRU0dKlNVCmO2Tf
        ffMGApqcgM0WqgVJh5tEHK0=
X-Google-Smtp-Source: APXvYqw/4TOOoHDJgr7Ck0jOuvFeItX6JbVqu4ZEiItCsTrasrIybscN26Wy76qCrzC8ZZgwwAmqSw==
X-Received: by 2002:a2e:864e:: with SMTP id i14mr28055127ljj.141.1559917594310;
        Fri, 07 Jun 2019 07:26:34 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-76-170-54.pppoe.mtu-net.ru. [91.76.170.54])
        by smtp.googlemail.com with ESMTPSA id u13sm434946lfl.61.2019.06.07.07.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 07:26:33 -0700 (PDT)
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
 <f30e7fc6-3f64-d321-c32c-5e273115a869@gmail.com>
 <cbdac43f-32f7-c992-832b-ed40bef2375b@gmail.com>
 <06f2f74e-d618-8688-14ae-beb4920bcbf6@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2a51622f-7bd8-2c6c-b3c5-8b87c2b5be0c@gmail.com>
Date:   Fri, 7 Jun 2019 17:26:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <06f2f74e-d618-8688-14ae-beb4920bcbf6@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

07.06.2019 17:10, Vidya Sagar пишет:
> On 6/7/2019 12:22 AM, Dmitry Osipenko wrote:
>> 06.06.2019 19:35, Dmitry Osipenko пишет:
>>> 26.05.2019 7:37, Vidya Sagar пишет:
>>>> Add support for Synopsys DesignWare core IP based PCIe host controller
>>>> present in Tegra194 SoC.
>>>>
>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>> ---
>>>> Changes since [v7]:
>>>> * Addressed review comments from Thierry
>>>>
>>>> Changes since [v6]:
>>>> * Removed code around "nvidia,disable-aspm-states" DT property
>>>> * Refactored code to remove code duplication
>>>>
>>>> Changes since [v5]:
>>>> * Addressed review comments from Thierry
>>>>
>>>> Changes since [v4]:
>>>> * None
>>>>
>>>> Changes since [v3]:
>>>> * None
>>>>
>>>> Changes since [v2]:
>>>> * Changed 'nvidia,init-speed' to 'nvidia,init-link-speed'
>>>> * Changed 'nvidia,pex-wake' to 'nvidia,wake-gpios'
>>>> * Removed .runtime_suspend() & .runtime_resume() implementations
>>>>
>>>> Changes since [v1]:
>>>> * Made CONFIG_PCIE_TEGRA194 as 'm' by default from its previous 'y'
>>>> state
>>>> * Modified code as per changes made to DT documentation
>>>> * Refactored code to address Bjorn & Thierry's review comments
>>>> * Added goto to avoid recursion in tegra_pcie_dw_host_init() API
>>>> * Merged .scan_bus() of dw_pcie_host_ops implementation to
>>>> tegra_pcie_dw_host_init() API
>>>>
>>>>   drivers/pci/controller/dwc/Kconfig         |   10 +
>>>>   drivers/pci/controller/dwc/Makefile        |    1 +
>>>>   drivers/pci/controller/dwc/pcie-tegra194.c | 1621
>>>> ++++++++++++++++++++
>>>>   3 files changed, 1632 insertions(+)
>>>>   create mode 100644 drivers/pci/controller/dwc/pcie-tegra194.c
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/Kconfig
>>>> b/drivers/pci/controller/dwc/Kconfig
>>>> index a6ce1ee51b4c..884112afc11b 100644
>>>> --- a/drivers/pci/controller/dwc/Kconfig
>>>> +++ b/drivers/pci/controller/dwc/Kconfig
>>>> @@ -220,6 +220,16 @@ config PCI_MESON
>>>>         and therefore the driver re-uses the DesignWare core
>>>> functions to
>>>>         implement the driver.
>>>>   +config PCIE_TEGRA194
>>>> +    tristate "NVIDIA Tegra194 (and later) PCIe controller"
>>>> +    depends on (TEGRA_BPMP && ARCH_TEGRA) || COMPILE_TEST
>>>
>>> TEGRA_BPMP will be enough here as it depends on other relevant options.
>>>
>>> Hence I mean:
>>>
>>>     depends on TEGRA_BPMP || COMPILE_TEST
>>
>> Maybe it's worth to even change TEGRA_BPMP to ARCH_TEGRA_194_SOC.
>> Although then you'll have to extend it with other platforms later on,
>> but probably that's fine.
> I received an explicit comment previously to make this dependent on
> TEGRA_BPMP
> as the driver is using APIs to get certain jobs done by BPMP-FW. But, since
> we can't boot kernel in the first place without having BPMP-FW in place,
> I think
> it should be fine to make it dependent on ARCH_TEGRA_194_SOC directly.

ARCH_TEGRA_194_SOC selects BPMP by itself (see
drivers/soc/tegra/Kconfig), so it's indeed absolutely fine.
