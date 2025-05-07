Return-Path: <linux-pci+bounces-27359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DED09AADA1B
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 10:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9F777B4185
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 08:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84686221D88;
	Wed,  7 May 2025 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLQCKWOE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E74221714;
	Wed,  7 May 2025 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746606360; cv=none; b=GI2/CaLm0HwTPQYObv5QDJD+F1hlQtTaj+YARiG/Uube3RY2fPM8cPTMVcMU8BzrALpeBJ5GO1aJfa6mlg0xrwJi3zzqqDMH4w86WKHezXYpXqnTJFrwKkenQciDXk6j3EgLPe3Tw4k3rkiB92mVEBjGYOp68xdzkPUE8y+JFz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746606360; c=relaxed/simple;
	bh=NNekwt0jL97gDY8/IkIMxdxKqceQcOvhTDJ6jjqvosg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1dSFGYy9Qpy82WamysIHjZphXuenS5Z3yRn09sTB7kVs/XjYt+Nw/DQ4UOKQFj84Ovxr0zac3I+DnpsC/LHNopfCohKCC32d3IT4pPCeQhX75tV3PrsNlPh1UbnbEv/Ikawsgc2axIWD8S8y1YT+yXzLY5ekSr3elrLFGwh4gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLQCKWOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B76BC4CEEE;
	Wed,  7 May 2025 08:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746606359;
	bh=NNekwt0jL97gDY8/IkIMxdxKqceQcOvhTDJ6jjqvosg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sLQCKWOEo0ZeQ4hHPMlBuyHB0tQKY47E4cbgbUPw8UARjsJjNrHY+9bb/tx5NT2E7
	 2gb4x/v1fTTh+b5o3aPmmaO/OAsOmdgDE7SbN4uxcoLgvgu+5GAZVF7uqsJWE97Ml6
	 hZx0mPX0IVzTRlXRLJIiMVG6KsyDJbg/rb39A5h5LefUpgazYNCUIb9jlNCIYeQTH4
	 52InMMguMXKb1pm6/kokONhZdYIb3382X87AZfKDP1UAOK0OLygJRvwwjU/EHsgyyk
	 BDpUr/e08MhAJsbp43oVzC48eZMcQrZEFb4IVn/Lcgh1Zj+i4uplSWxAPPolb+SnJF
	 BHCi58C0XLtfA==
Message-ID: <01b06e36-823c-4f28-8db5-dc0ee0b4c063@kernel.org>
Date: Wed, 7 May 2025 10:25:52 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] dt-bindings: PCI: qcom,pcie-sa8775p: document
 qcs8300
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dmitry.baryshkov@linaro.org, neil.armstrong@linaro.org,
 abel.vesa@linaro.org, manivannan.sadhasivam@linaro.org,
 lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 andersson@kernel.org, konradybcio@kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 quic_qianyu@quicinc.com, quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
References: <20250507031019.4080541-1-quic_ziyuzhan@quicinc.com>
 <20250507031019.4080541-3-quic_ziyuzhan@quicinc.com>
 <20250507-quixotic-handsome-wallaby-4560e3@kuoka>
 <8fef4573-0527-44d8-a481-f3271d9ffa33@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <8fef4573-0527-44d8-a481-f3271d9ffa33@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/05/2025 10:19, Ziyue Zhang wrote:
> 
> On 5/7/2025 1:10 PM, Krzysztof Kozlowski wrote:
>> On Wed, May 07, 2025 at 11:10:15AM GMT, Ziyue Zhang wrote:
>>> Add compatible for qcs8300 platform, with sa8775p as the fallback.
>>>
>>> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
>>> ---
>>>   .../bindings/pci/qcom,pcie-sa8775p.yaml       | 26 ++++++++++++++-----
>>>   1 file changed, 19 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
>>> index efde49d1bef8..154bb60be402 100644
>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
>>> @@ -16,7 +16,12 @@ description:
>>>   
>>>   properties:
>>>     compatible:
>>> -    const: qcom,pcie-sa8775p
>>> +    oneOf:
>>> +      - const: qcom,pcie-sa8775p
>>> +      - items:
>>> +          - enum:
>>> +              - qcom,pcie-qcs8300
>>> +          - const: qcom,pcie-sa8775p
>>>   
>>>     reg:
>>>       minItems: 6
>>> @@ -45,7 +50,7 @@ properties:
>>>   
>>>     interrupts:
>>>       minItems: 8
>>> -    maxItems: 8
>>> +    maxItems: 9
>> I don't understand why this is flexible for sa8775p. I assume this
>> wasn't tested or finished, just like your previous patch suggested.
>>
>> Please send complete bindings once you finish them or explain what
>> exactly changed in the meantime.
>>
>> Best regards,
>> Krzysztof
> 
> Hi Krzysztof
> Global interrupt is optional in the PCIe driver. It is not present in 
> the SA8775p PCIe device tree node, but it is required for the QCS8300

And hardware?

> I did the DTBs and yaml checks before pushing this patch. This is how
> I became aware that `maxItem` needed to be changed to 9.
If it is required for QCS8300, then you are supposed to make it required
in the binding for this device. Look at other bindings.

Best regards,
Krzysztof

