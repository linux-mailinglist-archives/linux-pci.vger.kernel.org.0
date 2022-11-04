Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D862619132
	for <lists+linux-pci@lfdr.de>; Fri,  4 Nov 2022 07:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiKDGmS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Nov 2022 02:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiKDGmR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Nov 2022 02:42:17 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02024DF70;
        Thu,  3 Nov 2022 23:42:14 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.77])
        by gateway (Coremail) with SMTP id _____8DxPLdEtGRjmWwEAA--.3449S3;
        Fri, 04 Nov 2022 14:42:12 +0800 (CST)
Received: from [10.20.42.77] (unknown [10.20.42.77])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxDuJEtGRjxEwNAA--.37544S3;
        Fri, 04 Nov 2022 14:42:12 +0800 (CST)
Subject: Re: [PATCH 2/2] dt-bindings: PCI: loongson: Add skip-scan property
 for child node
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     chenhuacai@loongson.cn, lvjianmin@loongson.cn,
        zhuyinbo@loongson.cn, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221103090040.836-1-liupeibao@loongson.cn>
 <20221103090040.836-2-liupeibao@loongson.cn>
 <01e8e789-68a8-626e-1a47-814d182807e7@linaro.org>
From:   Liu Peibao <liupeibao@loongson.cn>
Message-ID: <b3479058-34f5-1084-d1a4-5c6e2ad16959@loongson.cn>
Date:   Fri, 4 Nov 2022 14:42:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <01e8e789-68a8-626e-1a47-814d182807e7@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8AxDuJEtGRjxEwNAA--.37544S3
X-CM-SenderInfo: xolx1vpled0qxorr0wxvrqhubq/1tbiAQATCmNjr2MLBQAEse
X-Coremail-Antispam: 1Uk129KBjvJXoW7tw47Gr1UGF47Cw4kXr4kXrb_yoW8Xr4kpr
        Z7C3W2qFWIqr1xuwn2q34xKr13XrykCFWxtF43Wr9rKayUuw1Sg34akrn0qFykZr4vvFW2
        vFW0gay5JFW7ArJanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz5lbUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/4/22 5:53 AM, Krzysztof Kozlowski wrote:
> On 03/11/2022 05:00, Liu Peibao wrote:
>> Add the newly added "skip-scan" property for child node.
> 
> This we can see from the patch log. You need to say answer here to "Why".
> 

I will take care of this when I submit new patches.

>>
>> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
>> ---
>>  Documentation/devicetree/bindings/pci/loongson.yaml | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/loongson.yaml b/Documentation/devicetree/bindings/pci/loongson.yaml
>> index a8324a9bd002..5c2fe9bf2c78 100644
>> --- a/Documentation/devicetree/bindings/pci/loongson.yaml
>> +++ b/Documentation/devicetree/bindings/pci/loongson.yaml
>> @@ -32,6 +32,13 @@ properties:
>>      minItems: 1
>>      maxItems: 3
>>  
>> +  child-node:
> 
> What is "child-node"?
> 
>> +    type: object
>> +    properties:
>> +      skip-scan:
>> +        description: avoid scanning this device.
>> +        type: boolean
> 
> Why? Isn't status for that?
> 
> You also need additionalProperties: false/true, depending on what this
> child-node is...
> 
> ...and add the case illustrating it in the example.
> 
> 

I think I did add some vague description.

Since the opinion of Jiaxun in the [PATCH 1/2] is really more elegant
than what I did. I decide follow this opinion and as the `status = "disabled"`
property is existing, I will don't modify this yaml.

Thanks for your detailed review!

BR,
Peibao

