Return-Path: <linux-pci+bounces-20787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D303EA2A261
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 08:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D4A97A1933
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 07:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1581FFC78;
	Thu,  6 Feb 2025 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5V6IIUt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C983B1A4;
	Thu,  6 Feb 2025 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738827464; cv=none; b=E6ZN3+Qi1lvx97EjHd7cBmkZdVrtOm+zn6gexj6fbaTHldbJOQsBQghH/91QpsGKKp7nr77yWerYFYycEV2XeqxmPaHzyp3191eaQQUmHpItDbuItkMIu4/S3ilnhuIh1pxsKqi86QJqLxUUMtOmSO2C0bwrjUy/jDEChsK6UzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738827464; c=relaxed/simple;
	bh=vizkre/zlajIFCa+RvDbtt8gdcuEqWwVHRzJdLIek9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izb1EUFE+O6A7PIdtgfPJVxgsgZ7jpeB4wexhVfXOLfVaeoWJUbLTfDdPZEhYzXTuGlpl2ZtUxT4wQVeFzF8j6ToTfxigcC3uNJwwqnQCBwvQZCLOUw0d/CQr/zigEy9YDNC9bHXEfzvaBRWvtvhhbymeMWIBJFJEmB9uM07nyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5V6IIUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931F4C4CEE0;
	Thu,  6 Feb 2025 07:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738827464;
	bh=vizkre/zlajIFCa+RvDbtt8gdcuEqWwVHRzJdLIek9c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L5V6IIUtxstXizci7m6Me4CY2b49KvUN4IWDYA2gQUgur/rZ5vPUQV5epwLpLKo4A
	 yuln0OxHwudYH5zfxmndw4+1If1J8JCuColU/P5ZppapLrxjr9yOZFoCt4I4mGVeLg
	 ejVEW0bZn9zEik9MVLvN3T6dyDfNbUgXFuWhB328KCQEdDSrZ+BJUEgWsfNWKceNfr
	 aouLh0u3ZUcORjO/mXU2f9j6mv3Yrb7qtUYQC9a3vGZrohIQu9jIjZVJpOvP1KJTPx
	 RKHhiNP2vy7omCmUlSS1RLWHbKRds1cdv3vLEb5H9+K8FKMKUCQ4s9QbU/HQOUFuH7
	 KGrdaVw2Cc1pw==
Message-ID: <81dfd162-84c1-4f34-b1f0-459ad88a62df@kernel.org>
Date: Thu, 6 Feb 2025 08:37:35 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/7] arm64: dts: qcom: ipq5332: Add PCIe related nodes
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, p.zabel@pengutronix.de,
 dmitry.baryshkov@linaro.org, quic_nsekar@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, Praveenkumar I <quic_ipkumar@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250128062708.573662-1-quic_varada@quicinc.com>
 <20250128062708.573662-7-quic_varada@quicinc.com>
 <cc1c34f0-0737-469d-a826-2df7f29f6cf3@kernel.org>
 <Z6NCSo98YRgG666Q@hu-varada-blr.qualcomm.com>
 <85f54baa-7d3d-43c3-9944-8f5f3c3006da@kernel.org>
 <Z6OFSr2vrmPJTp4u@hu-varada-blr.qualcomm.com>
 <d867f285-b639-4080-beeb-20b75ee3f4a2@kernel.org>
 <1d78b30c-f71a-4769-b665-7425f00eb5ec@kernel.org>
 <Z6RUX3ZbDbd3qvjs@hu-varada-blr.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Z6RUX3ZbDbd3qvjs@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2025 07:19, Varadarajan Narayanan wrote:
> On Wed, Feb 05, 2025 at 04:54:38PM +0100, Krzysztof Kozlowski wrote:
>> On 05/02/2025 16:53, Krzysztof Kozlowski wrote:
>>> On 05/02/2025 16:35, Varadarajan Narayanan wrote:
>>>> On Wed, Feb 05, 2025 at 02:47:13PM +0100, Krzysztof Kozlowski wrote:
>>>>> On 05/02/2025 11:49, Varadarajan Narayanan wrote:
>>>>>> On Mon, Feb 03, 2025 at 05:30:32PM +0100, Krzysztof Kozlowski wrote:
>>>>>>> On 28/01/2025 07:27, Varadarajan Narayanan wrote:
>>>>>>>>
>>>>>>>> @@ -479,6 +519,230 @@ frame@b128000 {
>>>>>>>>  				status = "disabled";
>>>>>>>>  			};
>>>>>>>>  		};
>>>>>>>> +
>>>>>>>> +		pcie1: pcie@18000000 {
>>>>>>>> +			compatible = "qcom,pcie-ipq5332", "qcom,pcie-ipq9574";
>>>>>>>> +			reg = <0x00088000 0x3000>,
>>>>>>>
>>>>>>> So as Konrad pointed out now, this was never tested. It's not we who
>>>>>>> should run tests for you. It's you.
>>>>>>
>>>>>> This was tested and it did not flag an error since it is having the order
>>>>>> specified in the bindings. qcom,pcie.yaml has 4 reg specifications. Two of
>>>>>
>>>>>
>>>>> Hm, then please paste results of dtbs_check W=1 testing. Here.
>>>>>
>>>>> I am 100% sure you have there warning and I don't understand your
>>>>> reluctance to run the tests even after pointing it out by two people.
>>>>
>>>> I ran the tests. Not sure which portions to paste. Have attached the full
>>>> output just in case you are interested in some other detail. Please take a
>>>> look.
>>>>
>>>> Thanks
>>>> Varada
>>>>
>>>> 	$ grep ipq.*dtb dtbs-check.log
>>>
>>> Where is the command you have used?
> 
> 	export ARCH=arm64
> 	export W=1
> 	export DT_CHECKER_FLAGS='-v -m'
> 	export DT_SCHEMA_FILES=qcom
> 	export CHECK_DTBS=y
> 
> 	make -j 16 dtbs_check &> dtbs-check.log
> 

No flags for DTC as I asked.

>> Although that might not matter - you skipped several warnings with your
>> grep. So maybe you need to fix your process, not sure.
> 
> export W=1 is the problem. Kernel Makefile differentiates between 'W' being
> set from environment and from command line with this check

So just don't export. Command is:
make W=1 -j8 dtbs_check

> 
> 	ifeq ("$(origin W)", "command line")
> 	  KBUILD_EXTRA_WARN := $(W)
> 	endif
> 
> I assumed similar to DT_SCHEMA_FILES and DT_CHECKER_FLAGS, W will also be
> taken. I was not aware of this differentiation, and the 'export W=1' never
> came into effect. I re-ran the command as below and see the warnings
> 
> 	$ make W=1 -j 16 dtbs_check &> dtbs-check2.log
> 
> 	$ grep Warning dtbs-check2.log | grep ipq.*dt
> 	arch/arm64/boot/dts/qcom/ipq5332.dtsi:523.24-625.5: Warning (simple_bus_reg): /soc@0/pcie@18000000: simple-bus unit address format error, expected "88000"
> 	arch/arm64/boot/dts/qcom/ipq5332.dtsi:627.24-729.5: Warning (simple_bus_reg): /soc@0/pcie@20000000: simple-bus unit address format error, expected "80000"

Oh look! What surprise, who could expect that...

Best regards,
Krzysztof

