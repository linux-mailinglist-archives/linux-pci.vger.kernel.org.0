Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA5265538A
	for <lists+linux-pci@lfdr.de>; Fri, 23 Dec 2022 19:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiLWSPk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Dec 2022 13:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiLWSPj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Dec 2022 13:15:39 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237641E3F4
        for <linux-pci@vger.kernel.org>; Fri, 23 Dec 2022 10:15:37 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id p36so7950199lfa.12
        for <linux-pci@vger.kernel.org>; Fri, 23 Dec 2022 10:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMkaNS6uOrb3D/0kArTYvqSqllKQ1UyONAfya7XClCA=;
        b=cee0DxFYkfwQEw34e2mDPCBPHQiakE8mCBUi8vVzvNg9TSRfwPL5y4nI2U3jPBr7W6
         aQqjVPyNM80fqCRVpCJZhcftBq207Rg5spm3CiAbRZrGUYnnAJ8kJ/w75ymQmuH1Bhmp
         fyYroAmrSMoCaA57pK6Ti0sFrnL7g2TUKVkX9j5rtQ/BjzDL0a+qHYNQZeCdQxJfnWxO
         axs4SrU3W1rQUbqUIlbk7yQIQx54fKJG3S74Pc/HKI6T4h86v53pM2ZJVUOuRpqsHBCf
         FxDhrnlD/EddETcA8n+FrCE5JspFBauFqwOZ5P2/gbkzvY/WMfPlspo7dUYvky0nnzl2
         +RnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMkaNS6uOrb3D/0kArTYvqSqllKQ1UyONAfya7XClCA=;
        b=JJXZ6NQNpnqy/ShUFHi3vz3SlrnAaj3DmbyDK6m+FpdM401vo5bolckrPC+ZDI7dLR
         GPNAMiPL2GdRpGL6YGM1cjnHCJIpPodu14QwhVeETiojjytTpBgzB89Dx5mwIeGYpC69
         2mfE3rRrcNOvF1IC7Aqnyxkw1YwwgZQcCgsRWY5mkECJybXJ5/VfTlidWOOiigvu88Zg
         myKVmNTuuJvMaw5rDPPKYJ5t3lUGW2Ugp6NILE92p2HrDF9++IGuTW6vD0ivnAt3iIo1
         1xwFlZ2z6FcLNvLfEkXTYEN59n69S9CHvD3nZ98/GB4kpmeYsoKXHPFJtgSxi/RcHqoV
         sLhw==
X-Gm-Message-State: AFqh2krzMjZZ1qpSTIU1wMiPbICGozgKEoIfVqgpQYGw2i2XjMVO8dCy
        90lNv8ksIFug3vs0ttsUKGBAfQ==
X-Google-Smtp-Source: AMrXdXuSe9oHqaAYvBlNeeWbuqVFOSg5lsAHJITWWPA7bEZcLVtnTx9oVng0bWGOZczwtVtCBkVgXw==
X-Received: by 2002:a05:6512:1383:b0:4b6:ed8b:4f11 with SMTP id p3-20020a056512138300b004b6ed8b4f11mr3488771lfa.53.1671819335407;
        Fri, 23 Dec 2022 10:15:35 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id u9-20020ac258c9000000b004bb8a796a6bsm609785lfo.66.2022.12.23.10.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 10:15:34 -0800 (PST)
Message-ID: <9c7cb68c-6516-6087-92ad-e707d8b122ed@linaro.org>
Date:   Fri, 23 Dec 2022 20:15:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sm8450: Use GIC-ITS for PCIe0
 and PCIe1
Content-Language: en-GB
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bhelgaas@google.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221222133123.50676-1-manivannan.sadhasivam@linaro.org>
 <20221222133123.50676-4-manivannan.sadhasivam@linaro.org>
 <e756516a-a5e2-a6ac-fd7f-71726766fa81@linaro.org>
 <20221223174555.GE4587@thinkpad>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221223174555.GE4587@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23/12/2022 19:45, Manivannan Sadhasivam wrote:
> On Fri, Dec 23, 2022 at 07:18:32PM +0200, Dmitry Baryshkov wrote:
>> On 22/12/2022 15:31, Manivannan Sadhasivam wrote:
>>> Both PCIe0 and PCIe1 controllers are capable of receiving MSIs from
>>> endpoint devices using GIC-ITS MSI controller. Add support for it.
>>>
>>> Currently, BDF (0:0.0) and BDF (1:0.0) are enabled and with the
>>> msi-map-mask of 0xff00, all the 32 devices under these two busses can
>>> share the same Device ID.
>>>
>>> The GIC-ITS MSI implementation provides an advantage over internal MSI
>>> implementation using Locality-specific Peripheral Interrupts (LPI) that
>>> would allow MSIs to be targeted for each CPU core.
>>>
>>> It should be noted that the MSIs for BDF (1:0.0) only works with Device
>>> ID of 0x5980 and 0x5a00. Hence, the IDs are swapped.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>    arch/arm64/boot/dts/qcom/sm8450.dtsi | 20 ++++++++++++++------
>>>    1 file changed, 14 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>> index 570475040d95..c4dd5838fac6 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>> @@ -1733,9 +1733,13 @@ pcie0: pci@1c00000 {
>>>    			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
>>>    				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
>>> -			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
>>> -			interrupt-names = "msi";
>>> -			#interrupt-cells = <1>;
>>> +			/*
>>> +			 * MSIs for BDF (1:0.0) only works with Device ID 0x5980.
>>> +			 * Hence, the IDs are swapped.
>>> +			 */
>>> +			msi-map = <0x0 &gic_its 0x5981 0x1>,
>>> +				  <0x100 &gic_its 0x5980 0x1>;
>>
>> This definitely doesn't match what has been used in the downstream.
>>
> 
> Yes, I do not know why the downstream Device ID doesn't work. I tried finding
> the answer within Qcom but didn't get any answer so far :/ So I just went with
> the value that works on multiple boards.

Ugh :-(

> 
>> Also if I understand correctly this change would prevent us from using
>> multiple MSI interrupts for the connected device, as the last value of the
>> 0x100 mapping is 0x1, while the vendor kernel uses <0x100 &its 0x5981 0x20>.
>>
> 
> Not true. The controller can still support multiple MSIs for the endpoint
> devices but the only difference is, it would use the same Device ID for all.

I see, please excuse me then. But don't we have to define multiple MSI 
vectors here too?

> 
> The Qcom GIC-ITS implementation could only support 32 Device IDs. By specifying
> the size of 0x20, a separate Device ID would be used for each devices of bus 1.
> But if a PCIe switch is connected and the bus count becomes > 1, then the MSI
> allocation would fail because Device IDs are exhausted.
> 
> The downstream implementation just assumes that there will be only bus 1 and I
> do not want to follow that assumption.
> 
> That's why I used "msi-map-mask" property of value "0xff00" here, as that will
> allow all the devices under the bus 1 to share the same Device ID. For now I
> only mapped bus 1, but extending that in the future for other busses is simple.
> 
> Thanks,
> Mani
> 
>> Do you know by chance, why do we differ from the vendor dtsi?
>>
>>> +			msi-map-mask = <0xff00>;
>>>    			interrupt-map-mask = <0 0 0 0x7>;
>>>    			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>>>    					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
>>> @@ -1842,9 +1846,13 @@ pcie1: pci@1c08000 {
>>>    			ranges = <0x01000000 0x0 0x40200000 0 0x40200000 0x0 0x100000>,
>>>    				 <0x02000000 0x0 0x40300000 0 0x40300000 0x0 0x1fd00000>;
>>> -			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
>>> -			interrupt-names = "msi";
>>> -			#interrupt-cells = <1>;
>>> +			/*
>>> +			 * MSIs for BDF (1:0.0) only works with Device ID 0x5a00.
>>> +			 * Hence, the IDs are swapped.
>>> +			 */
>>> +			msi-map = <0x0 &gic_its 0x5a01 0x1>,
>>> +				  <0x100 &gic_its 0x5a00 0x1>;
>>> +			msi-map-mask = <0xff00>;
>>>    			interrupt-map-mask = <0 0 0 0x7>;
>>>    			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>>>    					<0 0 0 2 &intc 0 0 0 435 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
>>
>> -- 
>> With best wishes
>> Dmitry
>>
> 

-- 
With best wishes
Dmitry

