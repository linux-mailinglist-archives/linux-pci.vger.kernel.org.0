Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1A3501FD9
	for <lists+linux-pci@lfdr.de>; Fri, 15 Apr 2022 02:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348249AbiDOA6N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 20:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239622AbiDOA6L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 20:58:11 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88353B9191;
        Thu, 14 Apr 2022 17:55:43 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 15 Apr 2022 09:55:41 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 9EBCA2058443;
        Fri, 15 Apr 2022 09:55:41 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 15 Apr 2022 09:55:41 +0900
Received: from [10.212.183.90] (unknown [10.212.183.90])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id CC679B62B7;
        Fri, 15 Apr 2022 09:55:40 +0900 (JST)
Subject: Re: [PATCH v2 2/3] dt-bindings: PCI: uniphier-ep: Clean up reg,
 clocks, resets, and their names using compatible string
To:     Rob Herring <robh@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1649294553-17310-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1649294553-17310-3-git-send-email-hayashi.kunihiko@socionext.com>
 <YlX3uxZzmnb1nM/R@robh.at.kernel.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <d4eb8a3e-ca20-77be-0ae1-84d520f46aa5@socionext.com>
Date:   Fri, 15 Apr 2022 09:55:40 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YlX3uxZzmnb1nM/R@robh.at.kernel.org>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 2022/04/13 7:05, Rob Herring wrote:
> On Thu, Apr 07, 2022 at 10:22:32AM +0900, Kunihiko Hayashi wrote:
>> Instead of "oneOf:" choices, use "allOf:" and "if:" to define reg,
> clocks,
>> resets, and their names that can be taken by the compatible string.
>>
>> The order of their names doesn't change here.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../pci/socionext,uniphier-pcie-ep.yaml       | 84 ++++++++++++-------
>>   1 file changed, 56 insertions(+), 28 deletions(-)
>>
>> diff --git
> a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
> b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
>> index 437e61618d06..49a5b2ca266c 100644
>> ---
> a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
>> +++
> b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
>> @@ -15,9 +15,6 @@ description: |
>>   maintainers:
>>     - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>   
>> -allOf:
>> -  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
>> -
>>   properties:
>>     compatible:
>>       enum:
>> @@ -28,41 +25,19 @@ properties:
>>       minItems: 4
>>       maxItems: 5
>>   
>> -  reg-names:
>> -    oneOf:
>> -      - items:
>> -          - const: dbi
>> -          - const: dbi2
>> -          - const: link
>> -          - const: addr_space
>> -      - items:
>> -          - const: dbi
>> -          - const: dbi2
>> -          - const: link
>> -          - const: addr_space
>> -          - const: atu
> 
> This could be just:
> 
>        minItems: 4
>        items:
>          - const: dbi
>          - const: dbi2
>          - const: link
>          - const: addr_space
>          - const: atu
> 
> Then the if/then can have just 'minItems: 5' or 'maxItems: 4' for each
> case. I prefer the if/then schemas to be minimal.

I've got it. It means writing a common description, and writing
only the constraints in if/then. I'll rewrite it next.

Thank you,

---
Best Regards
Kunihiko Hayashi
