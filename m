Return-Path: <linux-pci+bounces-9905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25C8929BE9
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 08:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974382817CF
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 06:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676E812E7F;
	Mon,  8 Jul 2024 06:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MuhUO2jW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF90182DF
	for <linux-pci@vger.kernel.org>; Mon,  8 Jul 2024 06:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720418885; cv=none; b=FZD0a0Ms8Rr+wnKPhkSX5O/n+rXWvL+NJrltLQh+7tHPQCGWl+THRuxWRHIcCVL6OXXVzTN189uK4YKJDWkb9E//l0+L77Jk4QVl6NRU1MbZTSOvhs+Oh7iDkDm6C0p0cnRZbaEzP/j/OBVy0KaAoRdANbr9pdwUAwPUL/mkv30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720418885; c=relaxed/simple;
	bh=CSWLEHrCoIzNa13zYakpql7wRRQ6acxJhWNxuzk3UeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYiomGHz9FfmdXImuqL8IsKYYEvxiswBDD1nfvXk/5d+D4UbBdZmCJ53k1eMp7MViIDFebd65oDgjbV7m0nQnPVpY2dWh0l5eDH3WR5LvwAoDIpYHGytFdaERNjLNnby2Z53Izhx2x2DiVBB6NtAnu3Lhl7QQgPVMzXnGLH3XWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MuhUO2jW; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52e9f863c46so3729584e87.1
        for <linux-pci@vger.kernel.org>; Sun, 07 Jul 2024 23:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720418881; x=1721023681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yF9h3aMnBs4w0EwI4NF6ZofLp2oNZvbzRR5gRprUOtg=;
        b=MuhUO2jWIjCgRT64zxEPpoj6MtpvXQjtdu705DskMqxT0WUChKF/uFS85VjpF1Gj79
         3O4nvAwzlU/BRNrV0DLAR1yHaI16KS0EX4s8fEeAYLjxgWFCsv3OR8qtxx7UcgqmZdyE
         2zreernmm3HDiUMbFy8hODvpfroE8/+5tu3Xk8/K+0xCbk13Czf08RNR5Q9Rc9/imx8r
         IES6HvTqMiJHDktqknlIn1JThjrLwB7vEZupS5l3z7VJadAF/ZvI633bmWaPMVj4W1Ts
         qd6xlVHyGZ0l4tVAWWdG/g6JZaZz8DaEeoSj+2AGxazbGHx4hpbEwNz6OOBzSnSJG9/B
         /rFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720418881; x=1721023681;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yF9h3aMnBs4w0EwI4NF6ZofLp2oNZvbzRR5gRprUOtg=;
        b=WCBoOEEn/aKHaz3JTJ7l+/8LL8V0AHDlKSOeS7UmM2/IhDb8mpwtQTmfOZtOxhgmyq
         hJSfXoKUeP+/tCqnb8LWRqoY2Gs8hK/5SwECWJ9SjqLWmSh2W8uiK5vs4uuZY4Pa0SJh
         MyQNxuQ9/TZ6OWWjSciCFFNYL0M0T6zxjK55YnBov2zovmX0ULyhs8hm03DFjLt1d1xL
         RQGgvObxEV1arjfMsm3VoH/QzthsHEzv3sochsRT0a8JF8Zb/KZIi8ZTZi67JgBPp6H+
         ScL1YhP8ZaVa5Q3Na/8AT2FM6ntSr+1lPQq8rY6VWNAJbEw0BRfAXkKZusbJhBL7SJbM
         2fLw==
X-Forwarded-Encrypted: i=1; AJvYcCVqvjraFl5QircWwcSQr1RdzAOZeQwx/v/58xjPJnXnJqxIlhGW9tf30dVO8I1+BL/46jF3DUbsY4fymNAZyZdkF6rJJ4FyGx/0
X-Gm-Message-State: AOJu0YxxvgaJ/tECZXwv9CyD8SX5b9c6atJUdyHMsmgZ3YBAZ02VefdR
	vcW2APlRN0Aa8pwUwrORG0OAlUCq3L3yVIzcX1+ofdZT7ORRRM/x19aVow0KF0Q=
X-Google-Smtp-Source: AGHT+IFoN/cWlR6BXWuja0//SDZxE8pDDT582ybc9/L5NsyVsJgSeB4EHViANbhzaOEbDfbWarVRfQ==
X-Received: by 2002:a19:6b0e:0:b0:52e:7f16:96be with SMTP id 2adb3069b0e04-52ea06ddde5mr6820176e87.65.1720418880803;
        Sun, 07 Jul 2024 23:08:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4265fe7130csm74789435e9.8.2024.07.07.23.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 23:08:00 -0700 (PDT)
Message-ID: <f8f3c4d4-bf24-4195-a7b0-eec95cd64b57@linaro.org>
Date: Mon, 8 Jul 2024 08:07:54 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/47] dt-bindings: arm: qcom: Document QCS9100 SoC and
 RIDE board
To: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Tengfei Fan
 <quic_tengfan@quicinc.com>, andersson@kernel.org, konrad.dybcio@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, djakov@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, jassisinghbrar@gmail.com,
 herbert@gondor.apana.org.au, davem@davemloft.net,
 manivannan.sadhasivam@linaro.org, will@kernel.org, joro@8bytes.org,
 conor@kernel.org, tglx@linutronix.de, amitk@kernel.org,
 thara.gopinath@gmail.com, linus.walleij@linaro.org, wim@linux-watchdog.org,
 linux@roeck-us.net, rafael@kernel.org, viresh.kumar@linaro.org,
 vkoul@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com
Cc: robimarko@gmail.com, bartosz.golaszewski@linaro.org, kishon@kernel.org,
 quic_wcheng@quicinc.com, alim.akhtar@samsung.com, avri.altman@wdc.com,
 bvanassche@acm.org, agross@kernel.org, gregkh@linuxfoundation.org,
 quic_tdas@quicinc.com, robin.murphy@arm.com, daniel.lezcano@linaro.org,
 rui.zhang@intel.com, lukasz.luba@arm.com, quic_rjendra@quicinc.com,
 ulf.hansson@linaro.org, quic_sibis@quicinc.com, otto.pflueger@abscue.de,
 luca@z3ntu.xyz, neil.armstrong@linaro.org, abel.vesa@linaro.org,
 bhupesh.sharma@linaro.org, alexandre.torgue@foss.st.com,
 peppe.cavallaro@st.com, joabreu@synopsys.com, netdev@vger.kernel.org,
 lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 ahalaney@redhat.com, u.kleine-koenig@pengutronix.de,
 dmitry.baryshkov@linaro.org, quic_cang@quicinc.com, danila@jiaxyga.com,
 quic_nitirawa@quicinc.com, mantas@8devices.com, athierry@redhat.com,
 quic_kbajaj@quicinc.com, quic_bjorande@quicinc.com,
 quic_msarkar@quicinc.com, quic_devipriy@quicinc.com, quic_tsoni@quicinc.com,
 quic_rgottimu@quicinc.com, quic_shashim@quicinc.com,
 quic_kaushalk@quicinc.com, quic_tingweiz@quicinc.com,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, kernel@quicinc.com
References: <20240703025850.2172008-1-quic_tengfan@quicinc.com>
 <20240703025850.2172008-2-quic_tengfan@quicinc.com>
 <665f6c8c-4f43-4d20-90e9-9e037a942066@kernel.org>
 <fbeb5969-0b3a-455e-88eb-b83734bf2c50@quicinc.com>
 <97c9484b-e257-4163-a104-3457d59bc69b@kernel.org>
 <63eb3f58-d4a4-4a27-b78c-f4cb83e62c63@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <63eb3f58-d4a4-4a27-b78c-f4cb83e62c63@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/07/2024 06:45, Aiqun Yu (Maria) wrote:
> 
> 
> On 7/3/2024 5:33 PM, Krzysztof Kozlowski wrote:
>> On 03/07/2024 11:21, Tengfei Fan wrote:
>>>>>         - items:
>>>>>             - enum:
>>>>> +              - qcom,qcs9100-ride
>>>>>                 - qcom,sa8775p-ride
>>>>> +          - const: qcom,qcs9100
>>>>
>>>> This changes existing compatible for sa8775p without any explanation in
>>>> commit msg.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>
>>> In the next verion patch series, I will provide relevant explanatory 
>>> information in this patch commit message.
>>
>> TBH, I cannot think of any reasonable explanation for this, especially
>> considering rest of the patchset which does not fix resulting dtbs_check
>> warning.
> 
> The existing compatible "sa8775p" warning can only be addressed When
> @Nikunj's "sa8775p" changes merged.
> 
> Let me know if you have other suggestions for this.

I don't have, because I don't understand why do you want/need to change
existing board compatible.

Best regards,
Krzysztof


