Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DFA4EABB1
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 12:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbiC2K5J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 06:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbiC2K5I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 06:57:08 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 785051B78B;
        Tue, 29 Mar 2022 03:55:25 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 29 Mar 2022 19:55:24 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id D73092058B50;
        Tue, 29 Mar 2022 19:55:24 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 29 Mar 2022 19:55:24 +0900
Received: from [10.212.183.172] (unknown [10.212.183.172])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id E9630B62B7;
        Tue, 29 Mar 2022 19:55:23 +0900 (JST)
Subject: Re: [PATCH] dt-bindings: PCI: uniphier: Convert uniphier-pcie.txt to
 json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1648433498-23450-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1648471865.799906.2153573.nullmailer@robh.at.kernel.org>
 <YkHhF7dF9SYS2qTx@robh.at.kernel.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <0c71c397-c48f-46e4-1813-2d7fbb029be7@socionext.com>
Date:   Tue, 29 Mar 2022 19:55:23 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YkHhF7dF9SYS2qTx@robh.at.kernel.org>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 2022/03/29 1:23, Rob Herring wrote:
> On Mon, Mar 28, 2022 at 07:51:05AM -0500, Rob Herring wrote:
>> On Mon, 28 Mar 2022 11:11:38 +0900, Kunihiko Hayashi wrote:
>>> Convert the file into a JSON description at the yaml format.
>>>
>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>> ---
>>>   .../bindings/pci/socionext,uniphier-pcie.yaml | 100
> ++++++++++++++++++
>>>   .../devicetree/bindings/pci/uniphier-pcie.txt |  82 --------------
>>>   MAINTAINERS                                   |   2 +-
>>>   3 files changed, 101 insertions(+), 83 deletions(-)
>>>   create mode 100644
> Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
>>>   delete mode 100644
> Documentation/devicetree/bindings/pci/uniphier-pcie.txt
>>>
>>
>> Running 'make dtbs_check' with the schema in this patch gives the
>> following warnings. Consider if they are expected or the schema is
>> incorrect. These may not be new warnings.
>>
>> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
>> This will change in the future.
>>
>> Full log is available here: https://patchwork.ozlabs.org/patch/1609988
>>
>>
>> pcie@66000000: compatible: ['socionext,uniphier-pcie', 'snps,dw-pcie']
> is too long
>> 	arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dt.yaml
>> 	arch/arm64/boot/dts/socionext/uniphier-ld20-global.dt.yaml
>> 	arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dt.yaml
>> 	arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dt.yaml
> 
> Ignore this if your intent is to fix these by dropping 'snps,dw-pcie'. I
> think that is the right thing to do. 'snps,dw-pcie' is not too
> meaningful.

I see. I should remove "snps,dw-pcie" from the existing devicetree, so
I'll fix it as a devicetree patch.

Thank you,

---
Best Regards
Kunihiko Hayashi
