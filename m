Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0EC590EB2
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 12:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237546AbiHLKH1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 06:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbiHLKH0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 06:07:26 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11883BD
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 03:07:24 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x19so695766lfq.7
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 03:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=pGicgmrkVGpAXVpWBOOwVqoHRpuAuKtD+Wqhn/gpirk=;
        b=MN1hOu0MvGFfVSNI3SZCMYZgGjhChvjodGSJYoVCvE2Vlkb/G85d1rwBzHEKFU7BoE
         HNrF5VHtjbtSbVBlPWmrHGCzPLPHjYt5HXG7uLbVxTyFZwP0AzOHLXjZFICp8YmJprtC
         gX30SbRsIPIu632N0gevqC3jhBV22xnq7p5vafKxI8sgjHiquWCcPgq61ao8BCM1ZRLy
         fvl11FVIenCL2nYausoYZ3BTaXnAxZX5ZEy3RgIbsRCcA6U2BI3JgqfEKFq/6OYBXH2P
         5IFQbe3/FiF9ph2qjFSK3Nc7prxcUEQrUR7BsYX/1ybOnFr7KYWEB/B3O4KvuP/4zQSt
         qtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=pGicgmrkVGpAXVpWBOOwVqoHRpuAuKtD+Wqhn/gpirk=;
        b=ojngP2LPGtViGJ3XO0wVgop0v0OfDU8iVxHKqcIxnQhDz7wUmzx/VutOIWn9XZ3UFy
         5SgzQ7sKS5o05RBGJykN/2udkl9QcrYEQOYa4QGJ3a44T7bXC6ch/9RFel6z0h+zH5nW
         Mj0NLoWogY7LC9QILDx1hGNbVadX71QTPfr/yeBDCX9n/NpfaxdZit0NN5ePYFnV2sim
         WmTKkRSOqt4l0vdmjP26yIKvrWvhgDoW75L76C50F6amOAce61iQBNJjl+Y/YOzby7bK
         D7AqCf8+5oL/EHBz8dlrz0+SppjxPKJYGF5yMQUIGK76jFfbgoYEnf4vuWtAeTNV+EAS
         prSQ==
X-Gm-Message-State: ACgBeo3JNv3h9gBK3iza3uvjybc6GmW9UqLkQF65JH24XvUi5KFjuqZz
        ldKjtmRDPAHGGIxsgaxU+Yrjqw==
X-Google-Smtp-Source: AA6agR7MhLzXhxFMHxvkBaYUjtFOzy1aQfTD91gtSyNkxDgILHvzPNc3FZ2NiCEPl+DJXfmXSUF4vg==
X-Received: by 2002:ac2:44bc:0:b0:48a:eb48:6b78 with SMTP id c28-20020ac244bc000000b0048aeb486b78mr1152514lfm.326.1660298842630;
        Fri, 12 Aug 2022 03:07:22 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id u28-20020ac251dc000000b0048a7c162bbesm155510lfm.279.2022.08.12.03.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 03:07:22 -0700 (PDT)
Message-ID: <a21c4d34-81b2-cdc5-133e-7c7d2c0657f6@linaro.org>
Date:   Fri, 12 Aug 2022 13:07:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/4] dt-bindings: PCI: microchip,pcie-host: fix incorrect
 child node name
Content-Language: en-US
To:     Conor.Dooley@microchip.com, mail@conchuod.ie,
        Daire.McNamara@microchip.com, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        paul.walmsley@sifive.com, greentime.hu@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20220811203306.179744-1-mail@conchuod.ie>
 <20220811203306.179744-4-mail@conchuod.ie>
 <721ccb76-c162-30ee-68cc-3316a2d62554@linaro.org>
 <272557c5-3e30-a873-40af-16a65c3043b2@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <272557c5-3e30-a873-40af-16a65c3043b2@microchip.com>
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

On 12/08/2022 10:55, Conor.Dooley@microchip.com wrote:
> On 12/08/2022 08:42, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 11/08/2022 23:33, Conor Dooley wrote:
>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> v2022.08 of dt-schema improved checking of unevaluatedProperties, and
>>> exposed a previously unseen warning for the PCIe controller's interrupt
>>> controller node name:
>>>
>>> arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dtb: pcie@2000000000: Unevaluated properties are not allowed ('clock-names', 'clocks', 'legacy-interrupt-controller', 'microchip,axi-m-atr0' were unexpected)
>>>          From schema: Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
>>>
>>> Make the property in the binding match the node name actually used in
>>> the dts.
>>>
>>> Fixes: dcd49679fb3a ("dt-bindings: PCI: Fix 'unevaluatedProperties' warnings")
>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>> ---
>>> This is another one Rob where I feel like I'm doing the wrong thing.
>>> The Linux driver gets the child node without using the name, but
>>> another OS etc could in theory (or reality), right?
>>
>> Yes and we had such cases when renaming device nodes caused regression.
>> My interpretation is that node name is not part of ABI, so anyone
>> depending on it made a mistake and they need to fix their stuff. I think
>> actually that is really poor coding and poor solution to parse device
>> node names and expect specific name.
>>
>> Other folks interpretation is that we never break the users of kernel,
>> regardless what is documented in the ABI... so it depends. :)
>>
>> Here however it is not a device node name, but a property name (although
>> still a node). Bindings require these to be specific, thus such name is
>> a part of ABI.
> 
> Yup, pretty much aligned to my thoughts on this.
> 
>> For your case, I wonder why it was called "legacy-interrupt-controller"
>> in the first place? Node names - also for properties - should be
>> generic, so generic name is just "interrupt-controller".
> 
> I don't know. It's what we had in our internal tree prior to upstreaming.
> "We" don't rely on the name for the Linux driver, so I am not really that
> bothered if we change the binding or the dts.

Then I propose to change the name in DTS.

Best regards,
Krzysztof
