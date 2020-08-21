Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26FE24CE6C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 09:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgHUHFY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 03:05:24 -0400
Received: from mx.socionext.com ([202.248.49.38]:41769 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgHUHFX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Aug 2020 03:05:23 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 21 Aug 2020 16:05:21 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id A700A60060;
        Fri, 21 Aug 2020 16:05:22 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 21 Aug 2020 16:05:22 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 5EB784036B;
        Fri, 21 Aug 2020 16:05:22 +0900 (JST)
Received: from [10.212.1.43] (unknown [10.212.1.43])
        by yuzu.css.socionext.com (Postfix) with ESMTP id BA90C120B93;
        Fri, 21 Aug 2020 16:05:21 +0900 (JST)
Subject: Re: [PATCH v6 6/6] PCI: uniphier: Add error message when failed to
 get phy
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
 <1596795922-705-7-git-send-email-hayashi.kunihiko@socionext.com>
 <CAL_JsqJhvpiAWfa7w4-85-GObkW+pq6PUpZUGg8Sc5p4+qsuQA@mail.gmail.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <aadb805d-e5fb-438a-d7e1-4e1ad31ddbac@socionext.com>
Date:   Fri, 21 Aug 2020 16:05:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJhvpiAWfa7w4-85-GObkW+pq6PUpZUGg8Sc5p4+qsuQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/08/18 1:39, Rob Herring wrote:
> On Fri, Aug 7, 2020 at 4:25 AM Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com> wrote:
>>
>> Even if phy driver doesn't probe, the error message can't be distinguished
>> from other errors. This displays error message caused by the phy driver
>> explicitly.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-uniphier.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
>> index 93ef608..7c8721e 100644
>> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
>> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
>> @@ -489,8 +489,12 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
>>                  return PTR_ERR(priv->rst);
>>
>>          priv->phy = devm_phy_optional_get(dev, "pcie-phy");
> 
> The point of the optional variant vs. devm_phy_get() is whether or not
> you get an error message. So shouldn't you switch to devm_phy_get
> instead?
> 
>> -       if (IS_ERR(priv->phy))
>> -               return PTR_ERR(priv->phy);
>> +       if (IS_ERR(priv->phy)) {
>> +               ret = PTR_ERR(priv->phy);
>> +               if (ret != -EPROBE_DEFER)
>> +                       dev_err(dev, "Failed to get phy (%d)\n", ret);
>> +               return ret;
>> +       }

The 'phys' property is optional, so if there isn't 'phys' in the PCIe node,
devm_phy_get() returns -ENODEV, and devm_phy_optional_get() returns NULL.

When devm_phy_optional_get() replaces devm_phy_get(),
condition for displaying an error message changes to:

    (ret != -EPROBE_DEFER && ret != -ENODEV)

This won't be simple, but should it be replaced?

Thank you,

---
Best Regards
Kunihiko Hayashi
