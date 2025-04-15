Return-Path: <linux-pci+bounces-25903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 881A7A8936D
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 07:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77751783A0
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 05:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33C327466B;
	Tue, 15 Apr 2025 05:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsdjjogM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BB319992D;
	Tue, 15 Apr 2025 05:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744695270; cv=none; b=Kw1MDudVqGay3i6HdU0KXz+wvA6hTZO7aBYqdB57qylfa482ObB0kEzOMtFigO3oau4fWP6X2pTPOcEMfUgLQyid+g0+3MQ3fYuv4UNm0h3oO6NzunP6h155VyyIyO0kJLyahn5fggFL4koMBEu+jFA83U8k5+msp/gI6iAZ63g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744695270; c=relaxed/simple;
	bh=45o6nO1ZdabDZRp2mosO2ayRd8wFBJ7ZpP9Jr4qOmK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WahbjdBTo+9U936yautCBrFWV1RLinzbA7hZurPQnR5aKT2/d7panB3MgtwOyXpl135/syu50O9DI/t0rCrRHVPcSqO3ErBpcU36kjTseGK7GeZmL1aZvhWmbUmfYUM9dnz6z5QBZppOFPHAz8KqQCHLk8CNsjn7PFPux0Moxws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsdjjogM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98203C4CEDD;
	Tue, 15 Apr 2025 05:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744695270;
	bh=45o6nO1ZdabDZRp2mosO2ayRd8wFBJ7ZpP9Jr4qOmK0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KsdjjogMSU35get7rJpSvvMy+VkhJhyymfpDK8TmQz4J351HR9pBWxdxfB0c8SYRg
	 yNKWwIwAqH96h642SSEh4QVPZ12p54L78O74Z+6CQGzWl7dRly9L/yyi9wWKUxReH/
	 6d9uokbC/D95wk460z2A3wlNtGXvggrypCsyFqX2V8oqmeorWpx9rhnpdIPnXLAsG/
	 iIwtTv6+bmv1aDGpfcwoa/oWLmE7p28W5smy97fLA9lsbix6nzPSrgsJWt27YzUqSH
	 H6H1IjW7zosBrHbNoG62r7+QaloK/AQQ2vpvYCi49nW1fv3zjeBLfKOco488CmD/q7
	 /jM6Hg676nIWg==
Message-ID: <4b741da1-6540-4e5c-aa32-098420cab3c2@kernel.org>
Date: Tue, 15 Apr 2025 07:34:22 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 1/2] dt-bindings: PCI: xilinx-cpm: Add `cpm_crx`
 and `cpm5nc_fw_attr` properties
To: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
 <kw@linux.com>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "cassel@kernel.org" <cassel@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Simek, Michal" <michal.simek@amd.com>,
 "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
 "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
References: <20250414032304.862779-1-sai.krishna.musham@amd.com>
 <20250414032304.862779-2-sai.krishna.musham@amd.com>
 <20250414-naughty-simple-rattlesnake-bb75bb@shite>
 <IA1PR12MB6140D67181ED0003799228DACDB32@IA1PR12MB6140.namprd12.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <IA1PR12MB6140D67181ED0003799228DACDB32@IA1PR12MB6140.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/04/2025 14:23, Musham, Sai Krishna wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Krzysztof,
> 
> Thanks for the review.
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: Monday, April 14, 2025 12:32 PM
>> To: Musham, Sai Krishna <sai.krishna.musham@amd.com>
>> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
>> manivannan.sadhasivam@linaro.org; robh@kernel.org; krzk+dt@kernel.org;
>> conor+dt@kernel.org; cassel@kernel.org; linux-pci@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Simek, Michal
>> <michal.simek@amd.com>; Gogada, Bharat Kumar
>> <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
>> <thippeswamy.havalige@amd.com>
>> Subject: Re: [RESEND PATCH v7 1/2] dt-bindings: PCI: xilinx-cpm: Add `cpm_crx`
>> and `cpm5nc_fw_attr` properties
>>
>> Caution: This message originated from an External Source. Use proper caution
>> when opening attachments, clicking links, or responding.
>>
>>
>> On Mon, Apr 14, 2025 at 08:53:03AM GMT, Sai Krishna Musham wrote:
>>> Add the `cpm_crx` property to manage the PCIe IP reset, and
>>> `cpm5nc_fw_attr` property to clear firewall after link reset, while
>>> maintaining backward compatibility with existing device trees.
>>>
>>> Also, incorporate `reset-gpios` in example for GPIO-based handling of
>>> the PCIe Root Port (RP) PERST# signal for enabling assert and deassert
>>> control.
>>>
>>> The `reset-gpios` and `cpm_crx` properties must be provided for CPM,
>>> CPM5 and CPM5_HOST1. For CPM5NC, all three properties - `reset-gpios`,
>>> `cpm_crx` and `cpm5nc_fw_attr` must be explicitly defined to ensure
>>
>> This we see from the diff, but why they must be defined?
>>
>>> proper functionality.
>>
>> What functionality?
>>
> 
> For our controller, if cpm_crx is not provided lane errors will be observed.
> Specifically for CPM5NC, if cpm5nc_fw_attr property is not provided, the firewall
> is not cleared after reset and further PCIe transactions will not be allowed.
> Therefore, these properties must be defined.

This must be in the commit msg.

> 
>>>
>>> Include an example DTS node and complete the binding documentation for
>>> CPM5NC. Also, fix the bridge register address size in the example for
>>> CPM5.
>>>
>>> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
>>> ---
>>> Changes for v7:
>>> - Update CPM5NC device tree binding.
>>> - Add CPM5NC device tree example node.
>>> - Update commit message.
>>>
>>> Changes for v6:
>>> - Resolve ABI break.
>>> - Update commit message.
>>>
>>
>> ...
>>
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - xlnx,versal-cpm5nc-host
>>> +    then:
>>> +      properties:
>>> +        reg:
>>> +          items:
>>> +            - description: CPM system level control and status registers.
>>> +            - description: Configuration space region and bridge registers.
>>> +            - description: CPM clock and reset control registers.
>>> +            - description: CPM5NC Firewall attribute register.
>>> +          minItems: 2
>>> +        reg-names:
>>> +          items:
>>> +            - const: cpm_slcr
>>> +            - const: cfg
>>> +            - const: cpm_crx
>>> +            - const: cpm5nc_fw_attr
>>> +          minItems: 2
>>
>> Why interrupts are not required for this variant? Why isn't this an
>> interrupt controller?
>>
> 
> MSI and MSI-X interrupts are handled via GIC, so msi-map property is
> required for interrupt handling.
> Legacy interrupt support is not available, and Error interrupt support will be
> added in future, once it is added corresponding DT changes will be added.

I don't think commit msg explained this.

> 



Best regards,
Krzysztof

