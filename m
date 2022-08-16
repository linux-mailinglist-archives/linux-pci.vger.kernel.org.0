Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948C65955EF
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 11:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiHPJJk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 05:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiHPJIg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 05:08:36 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A467F273
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 00:25:30 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id e15so13702168lfs.0
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 00:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ooE16zehdw/Qev5T+ZmUnjytAB9yy5ywmdc6ijRB7DU=;
        b=vsbEHpL2RqIY2QslVwDqFfp3XtMgHpHexPeU7C7kkWJq9Vq0XI2sRGSqgt5nWsO1hm
         +T5H7I3m0VVO7Yygf/ziEdb826My+optK01l52i8aQPhSGBi+y4MkCZ2dLgcR1et5mGa
         N9m32uGyTjvej0rn9DPJiXTvSL4HY4BlnKWuP+YkgjAYdqUuvC3cB1YIF4vX7rQQ4kf5
         JWH7/zpvE4X1qvrDhyPss0d3EBSVe46JZkl5u145kQLkNV+KKV8J9E3p+uIvAcBNng/2
         Cn2LYpunvdGkkOwInxwuCuHNobZOTstauY/+ZLjaJBZb+IKB1BisMwJKdL00sRrOkDyr
         0Ivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ooE16zehdw/Qev5T+ZmUnjytAB9yy5ywmdc6ijRB7DU=;
        b=33uczTVi0/iG0eGQHhnJiUg1LghF9QqgHsA5qi87wymbqZPouJWtTvuYkUBGhfVW9A
         00p8p7HyxtzF/bIc8lxNMpPMxXoamRc3lS7UFkm/r8/AiyFQqaBfkgGowCYoHC6ZHqwd
         VSgx6M+8tzLXWhmDYxt4NH1RC33FuDtcfPQC503kbx1h6ny5BIaZIKCM92fl+iZmlFUt
         cK7R1JqPtUelvaJcj5A/MGD9kqH1pyLODiQWFhVnDNBX0CAIb5yi63FUPWjq8c8e9jt3
         vcuzLIIfzge5Mxz8fsMZpR9vMHWyJNPK53aNGffL97RWDipJ9QcHf+2UjEevrPgNwNuk
         7ZJw==
X-Gm-Message-State: ACgBeo1B+tnD4eCnH/ZPGz5+d+PiOsBmMwCPLON+pcjn7PjiohK+s2B7
        a/3NfoeidGxq/Qu+Lpt7kzCr6A==
X-Google-Smtp-Source: AA6agR4AvhM4cDhXvQ1UTG+En6e9pMhUjfadNQTORfvzlu9ebxyZUTSlog8Wr6qGvgUaMN87z3ocDA==
X-Received: by 2002:a19:d611:0:b0:492:8e15:ba18 with SMTP id n17-20020a19d611000000b004928e15ba18mr2268836lfg.524.1660634728747;
        Tue, 16 Aug 2022 00:25:28 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id bd18-20020a05651c169200b0025e5b5474a4sm1706639ljb.85.2022.08.16.00.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 00:25:28 -0700 (PDT)
Message-ID: <febf654a-66ad-48e2-072c-7e1f4b521964@linaro.org>
Date:   Tue, 16 Aug 2022 10:25:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/4] dt-bindings: PCI: microchip,pcie-host: fix missing
 clocks properties
Content-Language: en-US
To:     Conor.Dooley@microchip.com, mail@conchuod.ie,
        Daire.McNamara@microchip.com, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        paul.walmsley@sifive.com, greentime.hu@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20220811203306.179744-1-mail@conchuod.ie>
 <20220811203306.179744-3-mail@conchuod.ie>
 <99b5bddb-4a09-a3ac-e01b-d0ae624ad2f8@linaro.org>
 <d25f8901-b9d7-ae8e-0061-2a033af16693@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d25f8901-b9d7-ae8e-0061-2a033af16693@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/08/2022 16:47, Conor.Dooley@microchip.com wrote:
> On 12/08/2022 08:35, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 11/08/2022 23:33, Conor Dooley wrote:
>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> Upgrading dt-schema to v2022.08 reveals unevaluatedProperties issues
>>> that were not previously visible, such as the missing clocks and
>>> clock-names properties for PolarFire SoC's PCI controller:
>>> arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dtb: pcie@2000000000: Unevaluated properties are not allowed ('clock-names', 'clocks', 'legacy-interrupt-controller', 'microchip,axi-m-atr0' were unexpected)
>>>         From schema: Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
>>>
>>> The clocks are required to enable interfaces between the FPGA fabric
>>> and the core complex, so add them to the binding.
>>>
>>> Fixes: 6ee6c89aac35 ("dt-bindings: PCI: microchip: Add Microchip PolarFire host binding")
>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>> ---
>>>  .../bindings/pci/microchip,pcie-host.yaml     | 25 +++++++++++++++++++
>>>  1 file changed, 25 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
>>> index edb4f81253c8..2a2166f09e2c 100644
>>> --- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
>>> @@ -25,6 +25,31 @@ properties:
>>>        - const: cfg
>>>        - const: apb
>>>
>>> +  clocks:
>>> +    description:
>>> +      Fabric Interface Controllers, FICs, are the interface between the FPGA
>>> +      fabric and the core complex on PolarFire SoC. The FICs require two clocks,
>>> +      one from each side of the interface. The "FIC clocks" described by this
>>> +      property are on the core complex side & communication through a FIC is not
>>> +      possible unless it's corresponding clock is enabled. A clock must be
>>> +      enabled for each of the interfaces the root port is connected through.
>>> +    minItems: 1
>>> +    items:
>>> +      - description: FIC0's clock
>>> +      - description: FIC1's clock
>>> +      - description: FIC2's clock
>>> +      - description: FIC3's clock
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      enum:
>>> +        - fic0
>>> +        - fic1
>>> +        - fic2
>>> +        - fic3
>>> +    minItems: 1
>>> +    maxItems: 4
>>
>> No need for maxItems.
> 
> I brought this up on IRC, but transferring it here since it's been
> an (understandable!!) few days & just didn't want things to get lost
> if my net died. Cutting out the back & forth, in summary:
> "
> I'm trying to remove the maxItems from the clock-names array you
> didn't like - but I can't figure out what to do instead that doesn't
> trigger errors. All 4 clocks are optional, the only requirement is
> that any one of them is present. Either I seem to get complaints that
> my property is not an array (simply removing the maxItems) or complaints
> that because I have clock0,1,3 and not 2 that clock3 is unexpected.

Eh, I misread the code and thought that you list the items, but you just
enumerate the schema for each item. My advice was wrong, you need maxItems.

> The root port is physically on the opposite side of the FPGA to the cpus
> & the AXI connection is through the FPGA fabric. There are 4 AXI
> interconnects to the fabric  which the PCI controller could in theory be
> connected to all 4, but it only needs to be connected to one.. I had
> done done minItems and maxItems a la:
> devicetree/bindings/watchdog/st,stm32-iwdg.yaml
> b/c that seems to have two clocks that it doesnt care about the order of
> "
> 
> Rob then suggested:
> "
> I would remove the 'items' list in 'clocks' and make the description
> clear that any of clocks is possible. It's not ideal, but it's a case of
> that's what is already there.
> "
> 
> I'd then have something along the lines of:
>   clocks:
>     description:
>       Fabric Interface Controllers, FICs, are the interface between the FPGA
>       fabric and the core complex on PolarFire SoC. The FICs require two clocks,
>       one from each side of the interface. The "FIC clocks" described by this
>       property are on the core complex side & communication through a FIC is not
>       possible unless it's corresponding clock is enabled. A clock must be
>       enabled for each of the interfaces the root port is connected through.
>       This could in theory be all 4 interfaces, one interface or any combination
>       in between.
>     minItems: 1
>     maxItems: 4
> 
>   clock-names:
>     items:
>       enum:
>         - fic0
>         - fic1
>         - fic2
>         - fic3
>     minItems: 1
>     maxItems: 4
> 
> Does that seem reasonable to you?


Yes.

Best regards,
Krzysztof
