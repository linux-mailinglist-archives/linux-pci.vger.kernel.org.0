Return-Path: <linux-pci+bounces-12897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BB296F424
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 14:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B247B1F24C82
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 12:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA171CC179;
	Fri,  6 Sep 2024 12:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZE+5Lhbt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11A113AA38;
	Fri,  6 Sep 2024 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725625168; cv=none; b=i0LjxT3PDCCKlAYzzcrzbpSA8eYMVY24RAdYK6m6ZxhO/FATG5jiQNlUVUo7TB2DaPKUjpjbCAxAwdu4GBNEqEerQpNBZ7QBvdd8DF/nTNiq5p2Ln41n/It5ea0rW9p2zMFmpsL62M3ItiHOABDEOFW/wDj1Xlb8Ib3Rs9eFtvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725625168; c=relaxed/simple;
	bh=ONhmdxT2raMlQ/0JmCNJK7yka2owPt7Lfw0uw4wEsvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6voob+JCJ9IKwa7xNE3iyR9QagF/a+e2RlYp95Cvb2u7GdZ2Iq2vCBjTiEov1e8z1/RETfH84RsvJg5D2yijVTec72kxYb+3H86Mhgd/MoQLKM1P8x0veMOyTkxnqJxplfq2kTGEvJ+ESIs2S+LrddHRG/dGhut+Bn7xn0p088=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZE+5Lhbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB55C4CEC4;
	Fri,  6 Sep 2024 12:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725625167;
	bh=ONhmdxT2raMlQ/0JmCNJK7yka2owPt7Lfw0uw4wEsvQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZE+5LhbtNwwiZOcCHnJY6R2kxNDAnIXEJeeW7FqDAwL3+L0zSOtopdsEyDFoxO3xz
	 /gWiJhlke0/Z0QVfmvwVFSDe7jDZ2BaxB5yZ6kUQ5cdxcCrfgBLMOqFRG4OetqDEmj
	 laZnKMZutd9AAAcBcnVGEVgED0pY9XL8HDaxtiaibGLuXNw4a+PfU6P4HLeUr+GEwD
	 pRmOlJrMnF4I5GTg+/S1w90UFIMhPVJ1h0yQyUvxOnVSlKMTUCUZuNqYxWOotjwz7E
	 m3x4/LltrLaUr5l7NIcOAVBKFVFS4wsDx0iIMJlBzG8HS6GciOtb3pfVRfVaZl46fw
	 B6TgH5xndGTog==
Message-ID: <958c52de-e77d-451c-93e9-e87373f4ae50@kernel.org>
Date: Fri, 6 Sep 2024 14:19:20 +0200
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
 <7ebc9676-d66c-4d82-902b-e824bcb2c921@kernel.org>
 <SN7PR12MB7201E4EB5370AFFE8FCAB56A8B9E2@SN7PR12MB7201.namprd12.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <SN7PR12MB7201E4EB5370AFFE8FCAB56A8B9E2@SN7PR12MB7201.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/09/2024 12:50, Havalige, Thippeswamy wrote:
> Hi Krzysztof,
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: Friday, September 6, 2024 4:16 PM
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
>> On 06/09/2024 12:43, Havalige, Thippeswamy wrote:
>>> Hi Krzysztof
>>>
>>>> -----Original Message-----
>>>> From: Krzysztof Kozlowski <krzk@kernel.org>
>>>> Sent: Friday, September 6, 2024 3:26 PM
>>>> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>;
>>>> manivannan.sadhasivam@linaro.org; robh@kernel.org; linux-
>>>> pci@vger.kernel.org; bhelgaas@google.com; linux-arm-
>>>> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>>>> krzk+dt@kernel.org; conor+dt@kernel.org; devicetree@vger.kernel.org
>>>> Cc: Gogada, Bharat Kumar <bharat.kumar.gogada@amd.com>; Simek,
>> Michal
>>>> <michal.simek@amd.com>; lpieralisi@kernel.org; kw@linux.com
>>>> Subject: Re: [PATCH 1/2] dt-bindings: PCI: xilinx-cpm: Add compatible
>>>> string for CPM5 controller-1.
>>>>
>>>> On 06/09/2024 11:31, Thippeswamy Havalige wrote:
>>>>> The Xilinx Versal premium series has CPM5 block which supports two
>>>>> typeA Root Port controller functionality at Gen5 speed.
>>>>>
>>>>> Add compatible string to distinguish between two CPM5 rootport
>>>> controller1.
>>>>
>>>> Subjects NEVER end with full stops.
>>> Thanks, Update in the next patch series.
>>>>>
>>>>> Error interrupt register and bits for both the controllers are at
>>>>> different.
>>>>>
>>>>> Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
>>>>> b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
>>>>> index 989fb0fa2577..b63a759ec2d7 100644
>>>>> --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
>>>>> +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
>>>>> @@ -17,6 +17,7 @@ properties:
>>>>>      enum:
>>>>>        - xlnx,versal-cpm-host-1.00
>>>>>        - xlnx,versal-cpm5-host
>>>>> +      - xlnx,versal-cpm5-host1
>>>>
>>>> That's poor naming. "-1.00" and now "1". Get your naming reasonable...
>>> Here 1.00 represents the IP versioning and host1 represents controller-1.
>>
>> I understand but you repeating the same is not helping. Make it better and
>> next time upstream "host1-1" compatible.
>>
>> Number of ports, BTW, comes from ports, right? So no need for the
>> compatible.
> 
> To differentiate between the registers for Controller-0 and Controller-1, I am utilizing a compatible string in the driver. This approach enables the driver to identify and manage the registers associated with each controller based on the specified compatible string.
> 

Please don't state the obvious... I know how Linux kernel works. But
maybe I wasn't clear - do you have ports property there? I guess not, as
it is PCI.

What I claim here, is that you have exactly the same hardware. Same
hardware, same compatible.

Best regards,
Krzysztof


