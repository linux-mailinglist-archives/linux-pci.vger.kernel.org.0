Return-Path: <linux-pci+bounces-24485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1E3A6D4E3
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 08:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FEAE7A500E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 07:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E843E192D97;
	Mon, 24 Mar 2025 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8m2jUFN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D6718D65E;
	Mon, 24 Mar 2025 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800793; cv=none; b=t+2SgEsmWSWg+8wGsAFxt2qpu+PhCk5kg2xyQU0KEhg9NsYlYQ2xu6D9PkwWgx66o4Ff3gx6JD9NWpW7GGwoPkKZXF2Jwu5zolTCpPgi4QbNo0M8tt+1F5A2puw5+KmIXDHqv8r+crc+5KthpzgDoBxl1eMpPFxbGBiKtg23HXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800793; c=relaxed/simple;
	bh=2GetM2IGOY5ME8RVRd+C5jKk3BERunSkKsBZ1Wyayyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSGJ6FAREWZe9UP6MCQe66e6Iwo+m5yJzIsjpletV4aw0vqEDmo89qZ6BzxXOL0fuIvHgi8L8WWf2/wu3bzKkJbHrIbKQ1rFBmG7ve1xfBIcOS7ivP2FE3jdXj8sEQs+v2jGeh+OTsK60bo/YDstswzA15Z//W8Xs5v+MjGuZgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8m2jUFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CD2C4CEDD;
	Mon, 24 Mar 2025 07:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742800793;
	bh=2GetM2IGOY5ME8RVRd+C5jKk3BERunSkKsBZ1Wyayyg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C8m2jUFNIoWNw0jTghEyNrcEpqjIt+gCemltQi50mMX3D7tmAThDLas4Lc1ARBhEh
	 CRfBvNS+bFMYxuQ3z7lBQ/NqcUJV/BZkC2u9F+p2Rj7O6LERb4YluABNZHPkb/hppG
	 G3iX6GaDufIbU6rlt4SXBMBpSbuH/IHf9tO6ztSrnCwU/TVegX992QMevCL2SvD52z
	 uZ0KB4s0vWohbmPPS+Vj/CSxcwwfo24sSqiV9784PKJl2AZtL07OFJN5fPF2y8ryMP
	 kmmPjzmWD/MN6wGR3OgJajhca3TrITTrgr4CzBzdcYZmwtSa9hc0XqgFz+tXfPvkiL
	 7bYvLUzEYflRA==
Message-ID: <39968d11-1b7d-4453-8350-26ed31dae02f@kernel.org>
Date: Mon, 24 Mar 2025 08:19:45 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: PCI: xilinx-cpm: Add reset-gpios for
 PCIe RP PERST#
To: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
 <kw@linux.com>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "cassel@kernel.org" <cassel@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Simek, Michal" <michal.simek@amd.com>,
 "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
 "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
References: <20250318092648.2298280-1-sai.krishna.musham@amd.com>
 <20250318092648.2298280-2-sai.krishna.musham@amd.com>
 <afe7947b-ed71-40d0-aa2e-b16549fc6b7d@kernel.org>
 <DM4PR12MB6158F761C80CA82B59FC0634CDDB2@DM4PR12MB6158.namprd12.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <DM4PR12MB6158F761C80CA82B59FC0634CDDB2@DM4PR12MB6158.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2025 10:42, Musham, Sai Krishna wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Krzysztof,
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: Tuesday, March 18, 2025 3:23 PM
>> To: Musham, Sai Krishna <sai.krishna.musham@amd.com>;
>> bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
>> manivannan.sadhasivam@linaro.org; robh@kernel.org; krzk+dt@kernel.org;
>> conor+dt@kernel.org; cassel@kernel.org
>> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>; Gogada, Bharat
>> Kumar <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
>> <thippeswamy.havalige@amd.com>
>> Subject: Re: [PATCH v4 1/2] dt-bindings: PCI: xilinx-cpm: Add reset-gpios for PCIe
>> RP PERST#
>>
>> Caution: This message originated from an External Source. Use proper caution
>> when opening attachments, clicking links, or responding.
>>
>>
>> On 18/03/2025 10:26, Sai Krishna Musham wrote:
>>> Changes for v2:
>>> - Add define from include/dt-bindings/gpio/gpio.h for PERST# polarity
>>> - Update commit message
>>> ---
>>>  .../bindings/pci/xilinx-versal-cpm.yaml       | 21 ++++++++++++++-----
>>>  1 file changed, 16 insertions(+), 5 deletions(-)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
>>> b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
>>> index d674a24c8ccc..904594138af2 100644
>>> --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
>>> @@ -24,15 +24,20 @@ properties:
>>>      items:
>>>        - description: CPM system level control and status registers.
>>>        - description: Configuration space region and bridge registers.
>>> +      - description: CPM clock and reset control registers.
>>>        - description: CPM5 control and status registers.
>>
>> You cannot add items to the middle, that's an ABI break. Adding required properties
>> is also an ABI break. Why you cannot add it to the end of the list?
>>
>> Or at least explain ABI break impact in commit msg?
>>
> When I add property at the end, I'm observing failure during dt_binding_check.
> $ make DT_CHECKER_FLAGS=-m dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> Documentation/devicetree/bindings/pci/xilinx-versal-cpm.example.dtb: pcie@fca10000: reg-names:2: 'cpm_csr' was expected
>         from schema $id: http://devicetree.org/schemas/pci/xilinx-versal-cpm.yaml#
Maybe for a good reason.

Best regards,
Krzysztof

