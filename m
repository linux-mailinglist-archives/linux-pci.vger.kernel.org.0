Return-Path: <linux-pci+bounces-36459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB93B87DFC
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 06:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C2E463075
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 04:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B256D26529A;
	Fri, 19 Sep 2025 04:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y29jnlP0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FC734BA5A;
	Fri, 19 Sep 2025 04:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758256900; cv=none; b=eiqGQKVAMW3uV/ijJS8fGdpKjBhCzxNED7GOVIEx8KCdmlxL5uPeejANMyNLkbkgWGDy5R0K4blt76A/YF286JsdBhiUrv4hQNf7/JJ5nyuEucLFczE5oTKQKoOrU2CV8490tTDfFGdMkd/ohrgEvK3JCFAMjwfzbhVjDDfa7wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758256900; c=relaxed/simple;
	bh=ugy88brg8y4iybp2YryKe8P5fZS3f1QoeQUirxpOajc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbBZU/MglMNhquvVJRpSC84dZNqzEnA5uySXS0bGlREB14w6S9w1own748tx8sSMKAxu7fkKONXCj/b+Ku13rui7DG4PkUmnglmXXEbd143Jyw4piSZGkwQBPb/ZA7Gen1QGsYSxJIDFgoxf9mJSc7+vS3IpR7v+PMsSsDNset0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y29jnlP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB12C4CEF0;
	Fri, 19 Sep 2025 04:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758256900;
	bh=ugy88brg8y4iybp2YryKe8P5fZS3f1QoeQUirxpOajc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y29jnlP09r1ppq3KtzAIA5I8vjQCz8GOlnqT4S8Etnk2gD2abLfupYfqTQ3CsqJsP
	 JowUMI0Ns1Bkv+T36rCi8txmPn1wBNBNSfM1Pn0M6iwHNVwoc7r6oWRjZTmCDO84CA
	 vGJJDy++T8vtuomF3dGwS2WTm5MkodGrlQqWhS46G8wSwjX1U1HHONliZmAZtH68yP
	 hiOKTKTeSv/tC5THm332VuB0snOe6XvhaaU/OkYem1t0bcWLrTlUEEDrJlWZUx5/vk
	 jd11IZ8o0LET2FEUfBfLctQCjqHcxAF3cR8OiP44sQXXz0KFaDTUUWdOx01ZXpdHC0
	 NJ28hyk9M9+lg==
Message-ID: <1ec41f26-8418-4f96-b7e2-9b851c926fa7@kernel.org>
Date: Fri, 19 Sep 2025 13:41:33 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: eic7700: Add Eswin eic7700 PCIe
 host controller
To: zhangsenchuan <zhangsenchuan@eswincomputing.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
 johan+linaro@kernel.org, quic_schintav@quicinc.com, shradha.t@samsung.com,
 cassel@kernel.org, thippeswamy.havalige@amd.com,
 mayank.rana@oss.qualcomm.com, inochiama@gmail.com,
 ningyu@eswincomputing.com, linmin@eswincomputing.com,
 pinkesh.vaghela@einfochips.com
References: <20250829082021.49-1-zhangsenchuan@eswincomputing.com>
 <20250829082237.1064-1-zhangsenchuan@eswincomputing.com>
 <20250901-congenial-weightless-parakeet-42d2de@kuoka>
 <43535323.1499.1995ad1dce3.Coremail.zhangsenchuan@eswincomputing.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <43535323.1499.1995ad1dce3.Coremail.zhangsenchuan@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/09/2025 12:15, zhangsenchuan wrote:
>>> +  num-lanes:
>>> +    const: 4
>>
>> If that's const, you do not need it. It's implied by the compatible.
>> I see some other bindings do similarly and I think that's not the
>> correct choice.
>>
>> Well, maybe @Rob knows if PCI is different here anyhow?
> 
> Dear Krzysztof
> 
> Thank you very much for your review.
> You're right，If that's const,  I don't think it's necessary either.
> After investigation, the description of the "num-lanes" attribute here 
> is incorrect. The correct one should be the following description:
>     num-lanes:
>       maximum: 4

If 1, 2 or 4 lanes are correct, for this compatible, then yes.

> If so, the num-lanes attribute should need to be described here.
> What do you think?
> 


...

>>> +            reset-names = "cfg", "powerup", "pwren";
>>> +            interrupts = <220>, <179>, <180>, <181>, <182>, <183>, <184>, <185>, <186>;
>>> +            interrupt-names = "msi", "inta", "intb", "intc", "intd",
>>> +                              "inte", "intf", "intg", "inth";
>>> +            interrupt-parent = <&plic>;
>>> +            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
>>> +            interrupt-map = <0x0 0x0 0x0 0x1 &plic 179>,
>>> +                            <0x0 0x0 0x0 0x2 &plic 180>,
>>> +                            <0x0 0x0 0x0 0x3 &plic 181>,
>>> +                            <0x0 0x0 0x0 0x4 &plic 182>;
>>> +            device_type = "pci";
>>> +            num-lanes = <0x4>;
>>
>> That's not a hex number, but decimal.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Manivannan and Bjorn have provided me with some excellent suggestions for my yaml. 
> My yaml will be refactored in the next patch, and I might need you to review it 
> again for me in the next patch. I'm a little wondering if I need to add
> "Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>" in next patch.


If you are changing it significantly, then drop/ignore my tag and write
in the changelog reasons why the tag was dropped. Usually adding new
properties is a significant change. Changing some clock name from A to B
is not a significant change. Other cases vary. More important is to
explain the differences and reason of dropping tag.


Best regards,
Krzysztof

