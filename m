Return-Path: <linux-pci+bounces-9910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63D9929D15
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 09:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3951C20E87
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 07:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D14210E4;
	Mon,  8 Jul 2024 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2NDqntp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFCB1946F;
	Mon,  8 Jul 2024 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720423902; cv=none; b=L4lvWAw5sqTc/S9ODSgfysCd738Egw+czvME2sfF7cK7vBGiGYPO0bvA4KmBkevvFTKRoVdwpCD0Iw40nfurmGU3DLI3TG8bguxfwYzcxI3R9FwpUjckKLoMSc4QgpFg+DP47ppYvLh8Lwc4bPRcJGT4/DJn9X3uhavTfIWgmCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720423902; c=relaxed/simple;
	bh=b686QiTKvy8ZMExM84K9kzUt3iG3OHu8RvGNrJ3LUPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gVlq2AqxV9YhN/gjIr8zpsE2coYr7ahNKSzBiFQM8nKD2elY2DwOL+wRvmucqfd0AUjcBlU7XW33M4LInnuv0GihRKzCo9jFsQ9yqBMDkvo2/u0Ihtc9Il+r4BP/cKDZwOieZ8eN5qNdKeuNKNYDL52rESSLHcfdQgwtV/dbNDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2NDqntp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3BBC116B1;
	Mon,  8 Jul 2024 07:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720423901;
	bh=b686QiTKvy8ZMExM84K9kzUt3iG3OHu8RvGNrJ3LUPU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W2NDqntp1Ulgp8VAPtW9t6MUVRBg2m24WUTXj6PfM3FSPT6WnvnROZIOHULWUqOgT
	 aWqsNEhpd+JKiouZTJGp7zJZg+KEggH+2wFwNf9Jvcbyr/tjpShaShqhdXl2lVlj49
	 qjscpyLwq1KwbCmSwqT+Jqat5Y2n7bIV8a/ZPwwr4+gFyY0o1Cs3AUeHCYUskKypQI
	 Jis8m+kGIeU9LqBdsmcbTFufx5GqCPgZXGDZPzEh5McNcju/zyfQSj/Xf2sKw+pDti
	 hHmWLNmFSVBozoY7HjZbCxHNC2jlqlgeXUMur4A392g6iSujvhXKe4jHoSKmcPYE0x
	 RD+heg8f8EMGQ==
Message-ID: <f8d17f99-cb76-427a-a23c-6777ab8f4370@kernel.org>
Date: Mon, 8 Jul 2024 09:31:11 +0200
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, djakov@kernel.org, mturquette@baylibre.com,
 sboyd@kernel.org, jassisinghbrar@gmail.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, manivannan.sadhasivam@linaro.org, will@kernel.org,
 joro@8bytes.org, conor@kernel.org, tglx@linutronix.de, amitk@kernel.org,
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
 <f8f3c4d4-bf24-4195-a7b0-eec95cd64b57@linaro.org>
 <c9822569-896c-4d5f-b917-2826bf414e67@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <c9822569-896c-4d5f-b917-2826bf414e67@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/07/2024 09:13, Aiqun Yu (Maria) wrote:
> 
> 
> On 7/8/2024 2:07 PM, Krzysztof Kozlowski wrote:
>> On 08/07/2024 06:45, Aiqun Yu (Maria) wrote:
>>>
>>>
>>> On 7/3/2024 5:33 PM, Krzysztof Kozlowski wrote:
>>>> On 03/07/2024 11:21, Tengfei Fan wrote:
>>>>>>>         - items:
>>>>>>>             - enum:
>>>>>>> +              - qcom,qcs9100-ride
>>>>>>>                 - qcom,sa8775p-ride
>>>>>>> +          - const: qcom,qcs9100
>>>>>>
>>>>>> This changes existing compatible for sa8775p without any explanation in
>>>>>> commit msg.
>>>>>>
>>>>>> Best regards,
>>>>>> Krzysztof
>>>>>>
>>>>>
>>>>> In the next verion patch series, I will provide relevant explanatory 
>>>>> information in this patch commit message.
>>>>
>>>> TBH, I cannot think of any reasonable explanation for this, especially
>>>> considering rest of the patchset which does not fix resulting dtbs_check
>>>> warning.
>>>
>>> The existing compatible "sa8775p" warning can only be addressed When
>>> @Nikunj's "sa8775p" changes merged.
>>>
>>> Let me know if you have other suggestions for this.
>>
>> I don't have, because I don't understand why do you want/need to change
>> existing board compatible.
> 
> We can left the current existing sa8775p board compatible as it is. And
> have a brand new qcs9100 and qcs9100-board item for current non-scmi
> resources compatible.
> 
> Will that be more reasonable from your end?

Yes, this is what I would expect. If you choose any other way - just
like I wrote - you need to explain why you are doing this.

Best regards,
Krzysztof


