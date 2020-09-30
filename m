Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4638027E008
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 07:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgI3FQ2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 01:16:28 -0400
Received: from mx.socionext.com ([202.248.49.38]:56888 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgI3FQ1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 01:16:27 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 30 Sep 2020 14:16:10 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 11E5E180BE3;
        Wed, 30 Sep 2020 14:16:10 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 30 Sep 2020 14:16:10 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 76736402FD;
        Wed, 30 Sep 2020 14:16:09 +0900 (JST)
Received: from [10.212.0.250] (unknown [10.212.0.250])
        by yuzu.css.socionext.com (Postfix) with ESMTP id D69F8120447;
        Wed, 30 Sep 2020 14:16:08 +0900 (JST)
Subject: Re: [PATCH v2 2/4] dt-bindings: PCI: uniphier-ep: Add iATU register
 description
To:     Rob Herring <robh@kernel.org>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
References: <1601255133-17715-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1601255133-17715-3-git-send-email-hayashi.kunihiko@socionext.com>
 <20200928180932.GA3006259@bogus>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <e7c5c7b5-2311-f4bb-8356-a21866a2f729@socionext.com>
Date:   Wed, 30 Sep 2020 14:16:08 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200928180932.GA3006259@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/09/29 3:09, Rob Herring wrote:
> On Mon, 28 Sep 2020 10:05:31 +0900, Kunihiko Hayashi wrote:
>> In the dt-bindings, "atu" reg-names is required to get the register space
>> for iATU in Synopsis DWC version 4.80 or later.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.example.dt.yaml: pcie-ep@66000000: reg: [[1711276032, 4096], [1711280128, 4096], [1711341568, 65536], [1728053248, 4194304]] is too short
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.example.dt.yaml: pcie-ep@66000000: reg-names: ['dbi', 'dbi2', 'link', 'addr_space'] is too short
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml

I found this binding update was wrong.
I'll fix and resend it.

> 
> 
> See https://patchwork.ozlabs.org/patch/1372225
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
> 
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> 
> Please check and re-submit.

Thank you,

---
Best Regards
Kunihiko Hayashi
