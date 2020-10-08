Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1F1286E20
	for <lists+linux-pci@lfdr.de>; Thu,  8 Oct 2020 07:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgJHFdW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Oct 2020 01:33:22 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12999 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgJHFdW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2020 01:33:22 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7ea4670000>; Wed, 07 Oct 2020 22:32:23 -0700
Received: from [10.25.74.27] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Oct
 2020 05:32:58 +0000
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
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Kunihiko Hayashi" <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20200924190421.549cb8fc@xhacker.debian>
 <b977d9b4-cc98-e817-0d51-8f2c6ba1445d@nvidia.com>
 <20201006143647.3f989340@xhacker.debian>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <435c8cf8-8f4a-c491-4aca-3ec5b7abe49a@nvidia.com>
Date:   Thu, 8 Oct 2020 11:02:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20201006143647.3f989340@xhacker.debian>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602135143; bh=J4CEG7z41t4fftMpaxkaa5Era9zth5z8jjZg7k+ZCts=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=gGiVTnDKnvH3IW3q8erfoIHhPlDmnbH2thdoY4rptWoPCwmwQxfo0RIcd6vK7za+a
         qgXLjiuv+uk3BJx5tDpmSQbDqUWKoQT3pRifw4gmZgEkA3RCj+BkqAEyGD6U4bOMRW
         7YyxCLCtjO6qbXeESHYlP9z93kG3O82AA69UQ3ntIr7k056NtyNn++sDetOOUG9on9
         TLtrQofmOFFUqspaxJYSK34woIeLsROw+yztJ5/3W8Z0lg/zdHFQ7f3LuLDNI6K7bW
         8eHbfb3P1ff5T55KfN3H8s00wH7Fd2T5ZOlcWCQii/0bU80nfxDTNlQkTNzGgPp5vF
         Rmin14uLeUy0A==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/6/2020 12:06 PM, Jisheng Zhang wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, 6 Oct 2020 11:56:34 +0530 Vidya Sagar wrote:
> 
>>
>>
>> Hi,
> 
> Hi,
> 
>> I would like to verify this series along with the other series "PCI:
>> dwc: fix two MSI issues" on Tegra194. I tried to apply these series on
>> both linux-next and Lorenzo's pci/dwc branches but there seem to be non
>> trivial conflicts. Could you please tell me which branch I can use and
>> apply these series cleanly?
> 
> This is a fix, so I thought the series would be picked up in v5.9, so the
> series is patched against v5.9-rcN
> 
> could you please try v5 https://lkml.org/lkml/2020/9/29/2511 on v5.9-rc7?
I tried this series on top of v5.9-rc7 and it worked as expected on 
Tegra194 platform. Also, I couldn't cleanly apply the other series 'PCI: 
dwc: fix two MSI issues' on top. Could you please rebase them?

Thanks,
Vidya Sagar
> 
> 
> Thanks
> 
>> FWIW, I acknowledge that the existing code does leak MSI target page
>> every time system goes through suspend-resume sequence on Tegra194.
>>
>> Thanks,
>> Vidya Sagar
>>
>> On 9/24/2020 4:35 PM, Jisheng Zhang wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Improve the msi code:
>>> 1. Add proper error handling.
>>> 2. Move dw_pcie_msi_init() from each users to designware host to solve
>>> msi page leakage in resume path.
>>>
>>> Since v1:
>>>     - add proper error handling patches.
>>>     - solve the msi page leakage by moving dw_pcie_msi_init() from each
>>>       users to designware host
>>>
>>>
>>> Jisheng Zhang (5):
>>>     PCI: dwc: Call dma_unmap_page() before freeing the msi page
>>>     PCI: dwc: Check alloc_page() return value
>>>     PCI: dwc: Rename dw_pcie_free_msi to dw_pcie_msi_deinit
>>>     PCI: dwc: Skip PCIE_MSI_INTR0* programming if MSI is disabled
>>>     PCI: dwc: Move dw_pcie_msi_init() from each users to designware host
>>>
>>>    drivers/pci/controller/dwc/pci-dra7xx.c       |  1 +
>>>    drivers/pci/controller/dwc/pci-exynos.c       |  2 -
>>>    drivers/pci/controller/dwc/pci-imx6.c         |  3 --
>>>    drivers/pci/controller/dwc/pci-meson.c        |  8 ----
>>>    drivers/pci/controller/dwc/pcie-artpec6.c     | 10 -----
>>>    .../pci/controller/dwc/pcie-designware-host.c | 43 +++++++++++++------
>>>    .../pci/controller/dwc/pcie-designware-plat.c |  3 --
>>>    drivers/pci/controller/dwc/pcie-designware.h  |  9 +++-
>>>    drivers/pci/controller/dwc/pcie-histb.c       |  3 --
>>>    drivers/pci/controller/dwc/pcie-kirin.c       |  3 --
>>>    drivers/pci/controller/dwc/pcie-qcom.c        |  3 --
>>>    drivers/pci/controller/dwc/pcie-spear13xx.c   |  1 -
>>>    drivers/pci/controller/dwc/pcie-tegra194.c    |  2 -
>>>    drivers/pci/controller/dwc/pcie-uniphier.c    |  9 +---
>>>    14 files changed, 38 insertions(+), 62 deletions(-)
>>>
>>> --
>>> 2.28.0
>>>
> 
