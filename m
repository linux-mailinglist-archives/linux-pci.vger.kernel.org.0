Return-Path: <linux-pci+bounces-12894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E99D96F1D6
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 12:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED86A1F216C0
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 10:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6DA1C9DE5;
	Fri,  6 Sep 2024 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5r0Gg/A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8572E81745;
	Fri,  6 Sep 2024 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619570; cv=none; b=sG5/+pumciowtWwbmL3W0q/zDvMHUdaMy3nmSguW9lxH0tWh0Sdc9b5CJmpXA3yjRq4xMFLltfbjUwS8iaLOteuHFezUMGCkDYRvop6hCUZPd0EWrGzeI3OpnABfL5HK+UDvqmyfm9ZSYX0qRNZndDLFRsnkV2bO/VvD8SRP+RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619570; c=relaxed/simple;
	bh=iaE8y5YoYhfpFba1YseRGylErwoiRZhZF3rHOSka+6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HF5ZW17om0VgZ7MX5VwzGI6HisDZMSueW+i2ySCQs7upsMMQyu6CzWHQ8tFoyv1O2m1SeBr2htz+O6QYCPM4PZbhS8XWTVamX9IMm4ztN6kIjwz6ARArdNmV0cDz3g0Szx4V43gpqBPByJrGsh7mezZ4PxXiAZKH9jData0nMRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5r0Gg/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6C4C4CEC4;
	Fri,  6 Sep 2024 10:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725619570;
	bh=iaE8y5YoYhfpFba1YseRGylErwoiRZhZF3rHOSka+6g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M5r0Gg/AvwxzzI9pVcVFx26Bq6V+WfPe8iOiKpjWsOkB/nT68OzOssni2GmRNSqza
	 bt4nx05gvgg4SbsWrUEzW/zWgFD/Hcb3KYuOMEYIwQxReX64knEpdx9t0Z2IwM5nQD
	 xEjbB/qCOCpdzQqoaJ3BcD7bCdqHwLzrLG0p4Dffyewrg1LBy6AVWf2du/UKk0KgEt
	 sSNlIhe8hESwzoJuo2mxD46gEpSgcs85Mt2BVlV2ZsIuD7NJfUszhFldhVvoNVeyHb
	 0Br7QGda8V1bmjDRturSdv/ZF+QksB/dw8GFfhUbGsnvB8FM0JTyoqTfDfFKkWGbbz
	 pPsfyfNxHy9KQ==
Message-ID: <7ebc9676-d66c-4d82-902b-e824bcb2c921@kernel.org>
Date: Fri, 6 Sep 2024 12:46:03 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: PCI: xilinx-cpm: Add compatible string
 for CPM5 controller-1.
To: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
 "Simek, Michal" <michal.simek@amd.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
 <kw@linux.com>
References: <20240906093148.830452-1-thippesw@amd.com>
 <20240906093148.830452-2-thippesw@amd.com>
 <e985a9d4-b398-4290-a4b9-08999c6a9f71@kernel.org>
 <SN7PR12MB7201F82C9BC29ACEE7E209028B9E2@SN7PR12MB7201.namprd12.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <SN7PR12MB7201F82C9BC29ACEE7E209028B9E2@SN7PR12MB7201.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/09/2024 12:43, Havalige, Thippeswamy wrote:
> Hi Krzysztof
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: Friday, September 6, 2024 3:26 PM
>> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>;
>> manivannan.sadhasivam@linaro.org; robh@kernel.org; linux-
>> pci@vger.kernel.org; bhelgaas@google.com; linux-arm-
>> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>> krzk+dt@kernel.org; conor+dt@kernel.org; devicetree@vger.kernel.org
>> Cc: Gogada, Bharat Kumar <bharat.kumar.gogada@amd.com>; Simek,
>> Michal <michal.simek@amd.com>; lpieralisi@kernel.org; kw@linux.com
>> Subject: Re: [PATCH 1/2] dt-bindings: PCI: xilinx-cpm: Add compatible string
>> for CPM5 controller-1.
>>
>> On 06/09/2024 11:31, Thippeswamy Havalige wrote:
>>> The Xilinx Versal premium series has CPM5 block which supports two
>>> typeA Root Port controller functionality at Gen5 speed.
>>>
>>> Add compatible string to distinguish between two CPM5 rootport
>> controller1.
>>
>> Subjects NEVER end with full stops.
> Thanks, Update in the next patch series.
>>>
>>> Error interrupt register and bits for both the controllers are at
>>> different.
>>>
>>> Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
>>> ---
>>>  Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
>>> b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
>>> index 989fb0fa2577..b63a759ec2d7 100644
>>> --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
>>> @@ -17,6 +17,7 @@ properties:
>>>      enum:
>>>        - xlnx,versal-cpm-host-1.00
>>>        - xlnx,versal-cpm5-host
>>> +      - xlnx,versal-cpm5-host1
>>
>> That's poor naming. "-1.00" and now "1". Get your naming reasonable...
> Here 1.00 represents the IP versioning and host1 represents controller-1. 

I understand but you repeating the same is not helping. Make it better
and next time upstream "host1-1" compatible.

Number of ports, BTW, comes from ports, right? So no need for the
compatible.

Best regards,
Krzysztof


