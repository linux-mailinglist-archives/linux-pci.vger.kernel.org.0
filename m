Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2458025FE35
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 18:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgIGQJw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 12:09:52 -0400
Received: from mx.socionext.com ([202.248.49.38]:4579 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730295AbgIGQJ1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 12:09:27 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 08 Sep 2020 01:09:24 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 84AF060060;
        Tue,  8 Sep 2020 01:09:24 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 8 Sep 2020 01:09:24 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id EA8C01A0509;
        Tue,  8 Sep 2020 01:09:23 +0900 (JST)
Received: from [10.212.1.10] (unknown [10.212.1.10])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 299A91205FF;
        Tue,  8 Sep 2020 01:09:23 +0900 (JST)
Subject: Re: [PATCH v6 5/6] PCI: uniphier: Add iATU register support
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Marc Zyngier <maz@kernel.org>, PCI <linux-pci@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1596795922-705-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1596795922-705-6-git-send-email-hayashi.kunihiko@socionext.com>
 <CAL_Jsq+nGtrBpzNKU9+1cHYkuQ3KBHpgwZRQfDKKUMJVSx_b1A@mail.gmail.com>
 <ab0f7338-045c-8565-134b-757769c9235f@socionext.com>
 <CAL_Jsq+HnaosmJgekrS-DynGvNR742m00vLN1yCiZ4YBf3T2-Q@mail.gmail.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <7b6ae470-23c1-735c-08ca-67dd644d7f23@socionext.com>
Date:   Tue, 8 Sep 2020 01:09:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+HnaosmJgekrS-DynGvNR742m00vLN1yCiZ4YBf3T2-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 2020/09/04 7:12, Rob Herring wrote:
> On Fri, Aug 21, 2020 at 1:05 AM Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com> wrote:
>>
>> On 2020/08/18 1:48, Rob Herring wrote:
>>> On Fri, Aug 7, 2020 at 4:25 AM Kunihiko Hayashi
>>> <hayashi.kunihiko@socionext.com> wrote:
>>>>
>>>> This gets iATU register area from reg property. In Synopsys DWC version
>>>> 4.80 or later, since iATU register area is separated from core register
>>>> area, this area is necessary to get from DT independently.
>>>>
>>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>>> ---
>>>>    drivers/pci/controller/dwc/pcie-uniphier.c | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
>>>> index 55a7166..93ef608 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
>>>> @@ -471,6 +471,11 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
>>>>           if (IS_ERR(priv->pci.dbi_base))
>>>>                   return PTR_ERR(priv->pci.dbi_base);
>>>>
>>>> +       priv->pci.atu_base =
>>>> +               devm_platform_ioremap_resource_byname(pdev, "atu");
>>>> +       if (IS_ERR(priv->pci.atu_base))
>>>> +               priv->pci.atu_base = NULL;
>>>
>>> Keystone has the same 'atu' resource setup. Please move its code to
>>> the DW core and use that.
>>
>> There are some platforms that pci.atu_base is set by other way.
>> The 'atu' code shouldn't be conflicted with the following existing code.
> 
> No, it's not a conflict but needless duplication.

I see.

>>     drivers/pci/controller/dwc/pci-keystone.c:              atu_base = devm_platform_ioremap_resource_byname(pdev, "atu");
>>     drivers/pci/controller/dwc/pci-keystone.c:              pci->atu_base = atu_base;
>>     drivers/pci/controller/dwc/pcie-designware.c:                   pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
>>     drivers/pci/controller/dwc/pcie-intel-gw.c:     pci->atu_base = pci->dbi_base + data->pcie_atu_offset;
> 
> This one should have had an 'atu' region in DT.
> 
>>     drivers/pci/controller/dwc/pcie-tegra194.c:     pci->atu_base = devm_ioremap_resource(dev, atu_dma_res);
> 
> Unfortunately, a different name was used. That is the mess which is
> the DW PCI controller.

Okay, this has already set atu_base, so ignore it for this patch.
  
>>
>> So I'm not sure where to move the code in the DW core.
>> Is there any idea?
> 
> You just need this and then remove the keystone code:
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> b/drivers/pci/controller/dwc/pcie-designware.c
> index b723e0cc41fb..680084467447 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -556,6 +556,8 @@ void dw_pcie_setup(struct dw_pcie *pci)
>                                         dw_pcie_iatu_unroll_enabled(pci))) {
>                  pci->iatu_unroll_enabled = true;
>                  if (!pci->atu_base)
> +                       pci->atu_base =
> devm_platform_ioremap_resource_byname(pdev, "atu");
> +               if (IS_ERR(pci->atu_base))
>                          pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
>          }
>          dev_dbg(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
> 

I've got it. I think I need to add a bit of code to this though,
I'll try to apply this and remove the duplicate code.

I'll separate this from other PER/AER patches and send new series.

Thank you,

---
Best Regards
Kunihiko Hayashi
