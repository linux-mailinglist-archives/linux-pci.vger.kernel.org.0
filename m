Return-Path: <linux-pci+bounces-42187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5C2C8D217
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 08:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDAB33AA5A6
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 07:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5B9315D25;
	Thu, 27 Nov 2025 07:35:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DC42D948A;
	Thu, 27 Nov 2025 07:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764228938; cv=none; b=i2MzZJ5eNu7RwXIKWnlM83ElEze7kaVldn0v2lxCcmRj+ZTfShl8BMAldupMAWQumVraj5Q4ZjxrzN+9GgyEeb2gKHjJFbYX8jpOT19bTxE9VdhgAJCW5ofIU8Bm+t0LfsZ1VJuNPd2HdJ+LaYyeWY9RfnoSqrpaGlSBWmaN7Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764228938; c=relaxed/simple;
	bh=QWzDWy+SQXxfM94LKZR/okFJz6M5Z+riyTWN+UKqjt8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WdaOGrVVQ2uQSLjtbhH02vXYXWhuPxrs8pm3cgfYvH7B9NkRbFslJMR0lsbvjTmcbuQqqhDWurU3FjC5vhfPC5ormrm8OwyoFt/rOm4MuyhybCnPc9Zo8xuFHnNvK0SD2hUoQNTCmvMAUOfW8mwQ+SO4fU3cgpsZS4R3RN0HFtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1764228896tea6b6582
X-QQ-Originating-IP: m2NFOC1l7CtxMECnINXb88RBau0mbZAl118Ji8E0/s0=
Received: from [IPV6:240f:10b:7440:1:c95a:801a ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Nov 2025 15:34:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4363788777336798568
Message-ID: <F11F0D13437B012D+0c15c5ca-f64f-49f1-9ff5-26b88d59ff59@radxa.com>
Date: Thu, 27 Nov 2025 16:34:53 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] PCI: dwc: Revert Link Up IRQ support
From: FUKAUMI Naoki <naoki@radxa.com>
To: Niklas Cassel <cassel@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>,
 Krishna chaitanya chundru <quic_krichai@quicinc.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20251111105100.869997-8-cassel@kernel.org>
 <mt7miqkipr4dvxemftq6octxqzauueln252ncrcwy6i2t7wfhi@jtwokeilhwsi>
 <aSRli_Mb6qoQ9TZO@ryzen>
 <7667E818D7D31A4E+cf7c83d4-b99c-469d-8d46-588fc95b843f@radxa.com>
Content-Language: en-US
In-Reply-To: <7667E818D7D31A4E+cf7c83d4-b99c-469d-8d46-588fc95b843f@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: M8eXz3YJtIUHVeCj2S4KR1MZmmoX2rpgqITCRKAByPTmRvDFqhCMxd9n
	fNsp4rjiFxs2pmH9ymwz9fBj11QjGjwfkT4el0ZZ6vPUpiCbAr01EBvtAXghxjxOFGdpRZ1
	BhqzamevYG3sA7sEeeouEtU4Sd7zeFRC2Ftta9hZsJGZFVhQ1srNKcdfBWuGSjI7HZBTJOt
	CgvQe6zMaeKvp+OryiLX9bZGLwMxvBFMkK5qwfxbjIumDlBDiKovdhnBXKO4UOHOhoeTqdY
	p6RhrWqh3wP/y1Pai/k1HvqkFQJ+dEIkLqHluT7b5WbxxWdLJHDkI2Wtek/J9KKqOoVeLm+
	/E+ujymEQlD1ZG0xqYV05z4sRcCOAS98kn1VDeJsnNZVeOXCUi1hwGefH67EZgo1rqXLE5k
	OqtKbSD8Laz77TYqD0ZCTBryrLVFqdmWQzX3iMqudOGszbKQZhK9atNQ97rrwdS9xxshz5K
	/fanU15gi5cK+cgvb52kr28bPEl3jsCz7/Ex6hQT7i+kvYQuWc4fNwEPQUvTEZt7ozHHFni
	LCvEJuYnIJkjb+8gaRJQd4lZYqPkUJUeoR2qZeW3McbpKU7TBd/qXJ9lIt7LaVHiu6LX/XJ
	3Gv057ENBY2itXgM2mXhv5sGXkfjrxJLVf+00/ZkjZlK2CJ9OKB+JeBYL2c8mACk0LvS0K2
	L4qyzB6lJkVNZB94iyqIYwEvjCNjIjuAKv6UKtFHFnqWFaigyFCe4COxiyJhIz1/E47DS7j
	p5nIa3RdtHGsfwASEfXYUsNxIBrWm23LScRCGyHKyiFRDlaLC3nCn6KCc+cJvcmJ8pKkhjS
	rrASjkG12MZa/2ZLfMnDJAFvLPa3uuHBP38VS+3036P66v5mVPUev2WHSoYTIAwrT1tm4+B
	9VCvJK23m7GzZDdO29ss+Y9f47W/o5cLMvy66PrnGufFpt6vVbFt73K2+LCTYkG1dwzXY6v
	jh/O6bmqMTDgOiHzNiHIQ/Qpm78kIjvKhyGtjtCA5iE8/0Jh9uAJ3YjBfzFGA7g1AwqhO+Z
	ancZMogA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Hi all,

I'm very sorry, but my ROCK 5C appears to be unreliable. (It worked fine 
with vanilla v6.13, so I thought it was fine.)

I replaced it with another 5C (Lite), and now every method (Niklas's 
patch, Shawn's patch, and applying patch 1 and 2) seems to work.

Testing with the 5C Lite is still not enough, further testing is 
required, but I will probably need to revise my test results.

(Those seem to work on ROCK 5A/5B, but they also need further testing.)

I truly apologize for my unreliable testing.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

On 11/26/25 22:30, FUKAUMI Naoki wrote:
> Hi Niklas,
> 
> I apologize for the delayed response.
> 
> On 11/24/25 23:02, Niklas Cassel wrote:
>> On Mon, Nov 24, 2025 at 06:07:44PM +0530, Manivannan Sadhasivam wrote:
>>> While I suggested to revert the link up IRQ patch for rockchip 
>>> earlier, I didn't
>>> expect to drop the support for Qcom. The reason is, on Qcom SoCs, we 
>>> have not
>>> seen a case where people connect a random PCIe switch and saw 
>>> failures. Most of
>>> the Qcom usecases were around the M.2 and other proprietary 
>>> connectors. There is
>>> only one in-house PCIe switch that is being actively used in our 
>>> products, but
>>> so far, none of the bootloaders have turned them ON before kernel 
>>> booting. So
>>> kernel relies on the newly merged pwrctrl driver to do the job. Even 
>>> though it
>>> also suffers from the same resource allocation issue, this series 
>>> won't help in
>>> any way as pwrctrl core performs rescan after the switch power ON, 
>>> and by that
>>> time, it will be very late anyway.
>>>
>>> So I'm happy to take the rockhip patches from this series as they fix 
>>> the real
>>> issue that people have reported. But once the pwrctrl rework series 
>>> gets merged,
>>> and the rockchip drivers support them, we can bring back the reverted 
>>> changes.
>>
>> FUKAUMI Naoki, just to confirm:
>>
>> Neither my suggested approach:
>> https://lore.kernel.org/linux-pci/aRHdeVCY3rRmxe80@ryzen/
>>
>> nor Shawn's suggested approach:
>> https://lore.kernel.org/linux-pci/dc932773-af5b-4af7- 
>> a0d0-8cc72dfbd3c7@rock-chips.com/
>>
>> worked for you?
> 
> Yes, I re-tested the two methods mentioned above, separately, on v6.18- 
> rc7, but neither of them resolved the issue in my environment (ROCK 5C + 
> ASM2806).
> 
>> If so, I don't see many alternative but for Mani to apply patch 1 and
>> patch 2 from this series.
> 
> I believe applying patch 1 and patch 2 should be sufficient.
> 
> ----
> 
> Incidentally, (probably) while applying patch 1 and patch 2, I have 
> encountered the following issue several times:
> 
> [    1.709614] pcieport 0004:41:00.0: of_irq_parse_pci: failed with rc=134
> [    1.710208] pcieport 0004:41:00.0: Unable to change power state from 
> D3cold to D0, device inaccessible
> 
> I am still investigating this matter, and the conditions under which it 
> occurs are currently unknown.
> 
> Best regards,
> 
> -- 
> FUKAUMI Naoki
> Radxa Computer (Shenzhen) Co., Ltd.
> 
>> Kind regards,
>> Niklas
>>
> 


