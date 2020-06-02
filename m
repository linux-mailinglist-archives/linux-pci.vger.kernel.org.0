Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DAB1EB7ED
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 11:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgFBJIC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 05:08:02 -0400
Received: from mx.socionext.com ([202.248.49.38]:5677 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgFBJIB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jun 2020 05:08:01 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 02 Jun 2020 18:07:59 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id D462A60057;
        Tue,  2 Jun 2020 18:07:59 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 2 Jun 2020 18:07:59 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 6A9B24036A;
        Tue,  2 Jun 2020 18:07:59 +0900 (JST)
Received: from [10.213.31.100] (unknown [10.213.31.100])
        by yuzu.css.socionext.com (Postfix) with ESMTP id D4B10120136;
        Tue,  2 Jun 2020 18:07:58 +0900 (JST)
Subject: Re: [PATCH v2 5/5] PCI: uniphier: Add error message when failed to
 get phy
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1589536743-6684-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1589536743-6684-6-git-send-email-hayashi.kunihiko@socionext.com>
 <20200601214302.GA1538223@bogus>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <410530a4-b4fa-b39e-4187-5e87315ef6c9@socionext.com>
Date:   Tue, 2 Jun 2020 18:07:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200601214302.GA1538223@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 2020/06/02 6:43, Rob Herring wrote:
> On Fri, May 15, 2020 at 06:59:03PM +0900, Kunihiko Hayashi wrote:
>> Even if phy driver doesn't probe, the error message can't be distinguished
>> from other errors. This displays error message caused by the phy driver
>> explicitly.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-uniphier.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
>> index 493f105..7ae9688 100644
>> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
>> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
>> @@ -468,8 +468,11 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
>>   		return PTR_ERR(priv->rst);
>>   
>>   	priv->phy = devm_phy_optional_get(dev, "pcie-phy");
>> -	if (IS_ERR(priv->phy))
>> -		return PTR_ERR(priv->phy);
>> +	if (IS_ERR(priv->phy)) {
>> +		ret = PTR_ERR(priv->phy);
>> +		dev_err(dev, "Failed to get phy (%d)\n", ret);
> 
> This will print an error on EPROBE_DEFERRED which isn't an error.

Thanks for pointing out.
Surely this message should be suppressed when returning EPROBE_DEFERRED.

Thank you,
  
---
Best Regards
Kunihiko Hayashi
