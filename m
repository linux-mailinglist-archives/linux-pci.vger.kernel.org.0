Return-Path: <linux-pci+bounces-23056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007C9A54A4B
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 13:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525F51887015
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 12:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0559520968E;
	Thu,  6 Mar 2025 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvQZaJNz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CC3201022;
	Thu,  6 Mar 2025 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741262783; cv=none; b=gelWi1849gt8q8xqalNvZT6Akq4kIVvY+g+2zYevN9RYgH2o1ige/K9XNA3ieq+NJHNbx/81eCxzIsVNxm6gGMtXWCYliP6niBnufrOa/cQFsjoa0AQL41hb8KZhDXB/LeOWI6ldH1B3+cKay0Zl90/kG51LD6xO1AoRTnvyOws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741262783; c=relaxed/simple;
	bh=6EeTt0mHg23uX/2+kk+snOHOVgGOdG3sudRhjrNIZGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RwMNQIpL24Xj3v3fhyoo1RknktIV/zWpQ4qyX2+pD8Fb2nTb6waSbx78tO4hftp+DvIC3g/wgY1Ewf2tcrpAWbk4Ivp9b+1/ET5DQGIeO9teC0dOY/KcFObd6MKnQSOf4g41md2hpPv1ISnODSmsZyYmGdyXICxJ6gyjWrwv2Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvQZaJNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2E4C4CEE0;
	Thu,  6 Mar 2025 12:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741262783;
	bh=6EeTt0mHg23uX/2+kk+snOHOVgGOdG3sudRhjrNIZGA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XvQZaJNzmbwnNSphxC1PVQVeGwKsNU4VQUsJLN3EoB+6lMr8a/GiQcA2xAgmyzDP0
	 ZFbH8hx93K5TrYJL80aI3mSbpoHss8NT5E2kWHUywVlX5OxBppgxX94956at0XeinR
	 CGLm2v6QaPkv+TFjaOBOZlyeKYryliNChSfhl3tm4ykg3v4FABIOA5gM2kKTR6dGXx
	 jf/HBG5eXxui39FdhUbHXBIuWZ3sYAjUSWh0MzWNQCM3aDj8w5kTEn3pJzXuX8ZOCr
	 6HofLEmsV7uxLHSUFY8BpC76N8fgj7pUsRlvF00PKrGRxoEheB7Y+WbhpyTSyizE0/
	 Yz+Nf4NrJ5GHQ==
Message-ID: <33bb1cb2-0c5e-402b-a5c6-9604b1dd8d99@kernel.org>
Date: Thu, 6 Mar 2025 13:06:13 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/7] dt-bindings: PCI: qcom: Use sdx55 reg description
 for ipq9574
To: Varadarajan Narayanan <quic_varada@quicinc.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
 kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
 p.zabel@pengutronix.de, quic_nsekar@quicinc.com,
 dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250220094251.230936-1-quic_varada@quicinc.com>
 <20250220094251.230936-4-quic_varada@quicinc.com>
 <41b400fe-5e08-42c0-9bc6-a238d25d155a@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <41b400fe-5e08-42c0-9bc6-a238d25d155a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/03/2025 12:52, Krzysztof Kozlowski wrote:
> On 20/02/2025 10:42, Varadarajan Narayanan wrote:
>> All DT entries except "reg" is similar between ipq5332 and ipq9574. ipq9574
>> has 5 registers while ipq5332 has 6. MHI is the additional (i.e. sixth
>> entry). Since this matches with the sdx55's "reg" definition which allows
>> for 5 or 6 registers, combine ipq9574 with sdx55.
>>
>> This change is to prepare ipq9574 to be used as ipq5332's fallback
>> compatible.
>>
>> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Unreviewed.
> 
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> ---
>> v8: Add 'Reviewed-by: Krzysztof Kozlowski'
>> ---
>>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> index 7235d6554cfb..4b4927178abc 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> @@ -169,7 +169,6 @@ allOf:
>>              enum:
>>                - qcom,pcie-ipq6018
>>                - qcom,pcie-ipq8074-gen3
>> -              - qcom,pcie-ipq9574
> 
> Why you did not explain that you are going to affect users of DTS?
> 
> NAK

I did not connect the dots, but I pointed out that you break users and
your DTS is wrong:
https://lore.kernel.org/all/f7551daa-cce5-47b3-873f-21b9c5026ed2@kernel.org/

so you should come back with questions to clarify what to do, not keep
pushing this incorrect patchset.

My bad, I should really have zero trust.

Best regards,
Krzysztof

