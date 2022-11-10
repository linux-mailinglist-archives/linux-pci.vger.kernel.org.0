Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74632624342
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 14:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiKJNbj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 08:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiKJNbg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 08:31:36 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA33D7654
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 05:31:34 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id r12so3274371lfp.1
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 05:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ketLUUnsoyWouN0UzoicqQ1D0NB9EarJManqsfm6JHs=;
        b=EjoWG9qGZdA+cmM8l/whsRkqiI78AsL7dXW9Xf/o7LX+FJdxLRPybfO0gVPCemmzkr
         T7tSYRP1qpfy0gXEF3zbqegSztbMZkJI3GFEqLDUUG6XyO6OpU1m/IN4BB1GzVCUGyMW
         0ZknYwKnEsBCIgNyHKpUozqwX1hkP5S1MLZqQSnJXQBZ+3XUw8p/23jeTCNDrJDAV9vX
         uRAd9gYF9CuwNmiK0jqqD/+jPYh7LrkU2jugQEitlXp0Bv+UHAD324Hlw+YKEgCUjGp8
         OJI9n2AqdWTmoiZ5g1SnNl+mZTOxjMZ7t1OTFgUhtvzRIi5Ath2VcJsdPNYZdJ7h9vLC
         esuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ketLUUnsoyWouN0UzoicqQ1D0NB9EarJManqsfm6JHs=;
        b=5xg1JC8wGTjC73gZ0TpOKqhNvgjTXbNf+FO/m6VWQPRE1v1TOmGW3Uu5CX7CfMeZ9R
         LxEyWizzvYNzspLoEDMG4rSZdY1lwqU0PUsjgT5z0OgvfvIGobQKP2IBCJlVxhx51yh0
         W8HJKwDIDLTsgcQWN0c4UVC7csc6HEqz2+qFRy1IIjRgik1o/B3kJjvAzYnNenZdZp4q
         21jkZpq1kxh5u+/VRmAmumO+Ws+OzmsUzewMN0brKnhXQwU6HQkJ7Ok9GFOTZCtsiCIX
         HHj3MJwhI5+LgfL+CP1niZ1TbAvxt54aKP7YTmzOU+uhEqyvUqEhTgL8w0i3nyfjLWnr
         DdfQ==
X-Gm-Message-State: ACrzQf2jjM1Tc6Hllc99Jm4tu3SyQ9bohouC7fjFvoglTJDCTb4PqIM1
        Hrg2fHuZEM8c5Z1aA38mXN/Fqg==
X-Google-Smtp-Source: AMsMyM7dOA2ttjDI/ntgk+yGw8ab+rV2SYqP0CO+1QoY+yr6MNKkHeIG5DVm5U7jcfrHOI0lFfjHyA==
X-Received: by 2002:a05:6512:1108:b0:4a2:504f:b3f with SMTP id l8-20020a056512110800b004a2504f0b3fmr21697510lfg.169.1668087093172;
        Thu, 10 Nov 2022 05:31:33 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a21-20020ac25e75000000b004991437990esm2752373lfr.11.2022.11.10.05.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 05:31:32 -0800 (PST)
Message-ID: <0f7afb71-dc60-59f4-0708-ab54a0f6f4af@linaro.org>
Date:   Thu, 10 Nov 2022 16:31:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 8/8] arm64: dts: qcom: sm8350-hdk: enable PCIe devices
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org
References: <20221110103345.729018-1-dmitry.baryshkov@linaro.org>
 <20221110103345.729018-9-dmitry.baryshkov@linaro.org>
 <Y2zXmv8d9PIkO2/7@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y2zXmv8d9PIkO2/7@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/11/2022 13:51, Johan Hovold wrote:
> On Thu, Nov 10, 2022 at 01:33:45PM +0300, Dmitry Baryshkov wrote:
>> Enable PCIe0 and PCIe1 hosts found on SM8350 HDK board.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
>> index 0fcf5bd88fc7..58a9dc7705a5 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
>> @@ -222,6 +222,22 @@ &mpss {
>>   	firmware-name = "qcom/sm8350/modem.mbn";
>>   };
>>   
>> +&pcie0 {
>> +	status = "okay";
>> +};
>> +
>> +&pcie0_phy {
>> +	status = "okay";
>> +};
> 
> Looks like the required regulators are missing from the PHY nodes.

Ack, nice catch!

> 
> Johan

-- 
With best wishes
Dmitry

