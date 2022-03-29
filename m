Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE0D4EABAD
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 12:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbiC2K4f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 06:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbiC2K4e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 06:56:34 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B55917A82;
        Tue, 29 Mar 2022 03:54:51 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 29 Mar 2022 19:54:50 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 68EE12058443;
        Tue, 29 Mar 2022 19:54:50 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 29 Mar 2022 19:54:50 +0900
Received: from [10.212.183.172] (unknown [10.212.183.172])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id A66BFB62B7;
        Tue, 29 Mar 2022 19:54:49 +0900 (JST)
Subject: Re: [PATCH] dt-bindings: PCI: uniphier: Convert uniphier-pcie.txt to
 json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1648433498-23450-1-git-send-email-hayashi.kunihiko@socionext.com>
 <YkHg0UeS9kPOW6Kf@robh.at.kernel.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <00796c28-7485-8710-b76b-ac94e3358387@socionext.com>
Date:   Tue, 29 Mar 2022 19:54:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YkHg0UeS9kPOW6Kf@robh.at.kernel.org>
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

Thank you for reviewing.

On 2022/03/29 1:22, Rob Herring wrote:
> On Mon, Mar 28, 2022 at 11:11:38AM +0900, Kunihiko Hayashi wrote:
>> Convert the file into a JSON description at the yaml format.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../bindings/pci/socionext,uniphier-pcie.yaml | 100 ++++++++++++++++++
>>   .../devicetree/bindings/pci/uniphier-pcie.txt |  82 --------------
>>   MAINTAINERS                                   |   2 +-
>>   3 files changed, 101 insertions(+), 83 deletions(-)
>>   create mode 100644
> Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.
> txt

[snip]

>> +properties:
>> +  compatible:
>> +    enum:
>> +      - socionext,uniphier-pcie
>> +
>> +  reg:
>> +    minItems: 3
>> +    maxItems: 4
>> +
>> +  reg-names:
>> +    oneOf:
>> +      - items:
>> +          - const: dbi
>> +          - const: link
>> +          - const: config
>> +      - items:
>> +          - const: dbi
>> +          - const: link
>> +          - const: config
>> +          - const: atu
> 
> You can have just the 2nd list plus 'minItems: 3' to do the same thing.

I see. I'll rewrite it that way.

Thank you,

---
Best Regards
Kunihiko Hayashi
