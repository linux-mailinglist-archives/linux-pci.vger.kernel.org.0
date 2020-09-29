Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839C927CF05
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 15:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgI2NXW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 09:23:22 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13115 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgI2NXW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 09:23:22 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7335390005>; Tue, 29 Sep 2020 06:23:05 -0700
Received: from [10.26.75.44] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 13:22:59 +0000
Subject: Re: [PATCH v2 0/5] PCI: dwc: improve msi handling
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        "Kevin Hilman" <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <linux-arm-kernel@axis.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>
References: <20200924190421.549cb8fc@xhacker.debian>
 <de4d9294-4f6d-c7d1-efc7-c8ef6570bd64@nvidia.com>
 <20200929184851.22682ff1@xhacker.debian>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <8e06a370-a37a-5f33-b43b-2830adb31b3e@nvidia.com>
Date:   Tue, 29 Sep 2020 14:22:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929184851.22682ff1@xhacker.debian>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601385785; bh=O1AmZKE8e7EeFMJXiJzyuvgvP7i5Nhyk8/759La3vkU=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=PEUGx/Oto2o82hJdlAk6/ts4WMeu88gqStSAIbht98Z/IG5S7VWh+vP98HENpPGWz
         dvi4P4CwF9nHeRHsl9AzVkrvmXIBrwVTKKBrg57TUdTtX6rbg2iu/yl/npKamfzDfN
         bde3+rbXPUm4osMwTFyxLBEvxx/+GgYRccoic8JmGxsvmJpOdJQ499JIrzTlkZbfGy
         uatLuKB6XhZi8NLNwtLMbP08tRGBLxw/s1yS6UBfhIRviBPwMOohoewPUOkIiYkNbc
         kQHmRyOIchEWyKHIRxQV7sPqqZB+NDjrJDEXtUGp+aaP6iFoCKud6BERbUL3KiIhZi
         LjHupkiehvUcg==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jisheng,

On 29/09/2020 11:48, Jisheng Zhang wrote:
> Hi Jon,
> 
> On Fri, 25 Sep 2020 09:53:45 +0100 Jon Hunter wrote:
> 
>>
>> On 24/09/2020 12:05, Jisheng Zhang wrote:
>>> Improve the msi code:
>>> 1. Add proper error handling.
>>> 2. Move dw_pcie_msi_init() from each users to designware host to solve
>>> msi page leakage in resume path.  
>>
>> Apologies if this is slightly off topic, but I have been meaning to ask
>> about MSIs and PCI. On Tegra194 which uses the DWC PCI driver, whenever we
>> hotplug CPUs we see the following warnings ...
>>
>>  [      79.068351] WARNING KERN IRQ70: set affinity failed(-22).
>>  [      79.068362] WARNING KERN IRQ71: set affinity failed(-22).
>>
> 
> I tried to reproduce this issue on Synaptics SoC, but can't reproduce it.
> Per my understanding of the code in kernel/irq/cpuhotplug.c, this warning
> happened when we migrate irqs away from the offline cpu, this implicitly
> implies that before this point the irq has bind to the offline cpu, but how
> could this happen given current dw_pci_msi_set_affinity() implementation
> always return -EINVAL

By default the smp_affinity should be set so that all CPUs can be
interrupted ...

$ cat /proc/irq/70/smp_affinity
0xff

In my case there are 8 CPUs and so 0xff implies that the interrupt can
be triggered on any of the 8 CPUs.

Do you see the set_affinity callback being called for the DWC irqchip in
migrate_one_irq()?

Cheers
Jon

-- 
nvpublic
