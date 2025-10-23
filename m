Return-Path: <linux-pci+bounces-39072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FC0BFF1A0
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 06:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A22E3A979E
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 04:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32A71547F2;
	Thu, 23 Oct 2025 04:18:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC7AD515;
	Thu, 23 Oct 2025 04:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761193135; cv=none; b=I85FNrlh+JMZ6XRBeoy0F9/5NT5fc96glTGSVxiWPB1dJ3pHkQdK55HQ6xMCmC+GxMhffauj/isI3E9y0hTcdBhOFxtgC0SurNr3poX65FuhfN2A3j+133JOi7AI+fY49ZaiPbJhQq0837jAUxK2db00Acjdq7n6bCF4uoxJQ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761193135; c=relaxed/simple;
	bh=5PlYfvWue8wrQ0HBq8FrPBtbXXrcTWm+68baTyfeAwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PopULCRL/b+kxwvtSfdtQKBX33RRRjUGIEKLSXcEuGUoKSTwP5qzIAiCVULKh6r+790O0U+PsYPSTYJFqmY7IwWvsVNRJeJ8fji694zGuddyyLqFZ/ULR7Rr+iFn2acB68z44L/YnsHJ5UxAD7aIWYUPqFs5mQVES8DbjLcGlGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip3t1761193099t60baf72f
X-QQ-Originating-IP: GCzqp74BjwXRcZSUfMy4Sx/Rx0qnce6x/ev10AZZ/UA=
Received: from [IPV6:240f:10b:7440:1:e4c5:315f ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Oct 2025 12:18:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4133063992032992874
Message-ID: <FB49B2F64A16962F+d1dca436-509a-4edc-a93b-ffd297ef8a80@radxa.com>
Date: Thu, 23 Oct 2025 13:18:13 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/ASPM: Enable only L0s and L1 for devicetree platforms
To: Bjorn Helgaas <helgaas@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
 linux-rockchip@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20251022191313.GA1265088@bhelgaas>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20251022191313.GA1265088@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MjqaYNLY8QZG1tZzDhvx287W+4c6EfdSGBwmOxr9FxwYeNCVD3oqhX1f
	l9h3kN3pIMG+ZQndCsdj0GzkRc1PC9I96k9R4X7B6zMawJ33ngcP602d25FnSKPiGbC6XNF
	Na5Up5X7hAkM2A+orhEapSIl2omvOP1Ieh2aErTarEMurIw7Glv4rskzBWQEyjR7ycSXyl5
	S25Z/NhanApG0EgP7ysGlcegv6rf60phplpfBnyIt4tU7ldM7IV3+fZ/+i1YzStho2+tIc/
	XL0l4R1fcn52YNJ/ebqbw+Fmp1LsTHj28KlW/eH5wI1cMxRA90JsVXPoaX4uiRYUNwyQmhQ
	ovl5o0htzmkqzrKdiyt6WelXvTT3ZuHz5Fi5RENxiZ9BQ4cLOPtEgeituccNVer4o6KCb4J
	J3wlv4jQwXG/V0qU8uQftl6S2rmwvS0WNXyVWf108KY855kfjV5ri6/fjw6g7glaW3Q95tl
	Sqe6zdSxSch40IsvFo5jMBOj8fIX5bDmvxK8iLPVy5/+S5IV/Q8vvk+PgriEYkz3nFzLD8o
	m3vME8TSaGHeJn/JKFu7AFf2LHLzFkqLaMKHj4BaujlQoA8r8y4L9vWbMj88sGn+hcH7H+m
	6nuEUpkPwXmVEKIg4RBJvWlOCSUM903jbWR8D+RvSBOj2NZhBHPBY6JsI+H1Os8hM37dAn3
	r+xCC4yvfV6wR3iqg8pcxwS/GMFwLna8pkPk2sZ8uCyAkIj/HGDCmGwF6LdO+79jcGqaohm
	B5pY4ttu1LoO3upo+BPT2sgn43mEFhetgorOXNwq+UUOu/8nQot6XWvBXbtQ2DckRjrBwRV
	7mIeDm482awGT+fGrz5vhVQ191duYUxm5cu0c9WfW+fURIqvtJSZkcrqA10TAAAW1P9ABVB
	jOkl0GaqMTeQ8yMeBEYv8ThjV5UQQQebfLoS+JPz1bIF3Wj/soMFpPri3NDBgaiTvJe+7Fv
	VHkmkZNgYcWxOj6MFSwkQkUE9xk4XK8ZdaO64XYOobQe5GNyuea6lCKlB
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Hi Bjorn,

On 10/23/25 04:13, Bjorn Helgaas wrote:
> Christian, Naoki, any chance you could test this patch on top of
> v6.18-rc1 to see whether it resolves the problem you reported?
> 
> I'd like to verify that it works before merging it.

I'll be testing now. May I test on v6.18-rc2 without the following patch?

  "PCI: dw-rockchip: Prevent advertising L1 Substates support"

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> On Mon, Oct 20, 2025 at 05:12:07PM -0500, Bjorn Helgaas wrote:
>> From: Bjorn Helgaas <bhelgaas@google.com>
>>
>> f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree
>> platforms") enabled Clock Power Management and L1 Substates, but that
>> caused regressions because these features depend on CLKREQ#, and not all
>> devices and form factors support it.
>>
>> Enable only ASPM L0s and L1, and only when both ends of the link advertise
>> support for them.
>>
>> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
>> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>> Link: https://lore.kernel.org/r/db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de/
>> Reported-by: FUKAUMI Naoki <naoki@radxa.com>
>> Link: https://lore.kernel.org/r/22594781424C5C98+22cb5d61-19b1-4353-9818-3bb2b311da0b@radxa.com/
>> ---
>>
>> Mani, not sure what you think we should do here.  Here's a stab at it as a
>> strawman and in case anybody can test it.
>>
>> Not sure about the message log message.  Maybe OK for testing, but might be
>> overly verbose ultimately.
>>
>> ---
>>   drivers/pci/pcie/aspm.c | 34 +++++++++-------------------------
>>   1 file changed, 9 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 7cc8281e7011..dbc74cc85bcb 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -243,8 +243,7 @@ struct pcie_link_state {
>>   	/* Clock PM state */
>>   	u32 clkpm_capable:1;		/* Clock PM capable? */
>>   	u32 clkpm_enabled:1;		/* Current Clock PM state */
>> -	u32 clkpm_default:1;		/* Default Clock PM state by BIOS or
>> -					   override */
>> +	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
>>   	u32 clkpm_disable:1;		/* Clock PM disabled */
>>   };
>>   
>> @@ -376,18 +375,6 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
>>   	pcie_set_clkpm_nocheck(link, enable);
>>   }
>>   
>> -static void pcie_clkpm_override_default_link_state(struct pcie_link_state *link,
>> -						   int enabled)
>> -{
>> -	struct pci_dev *pdev = link->downstream;
>> -
>> -	/* For devicetree platforms, enable ClockPM by default */
>> -	if (of_have_populated_dt() && !enabled) {
>> -		link->clkpm_default = 1;
>> -		pci_info(pdev, "ASPM: DT platform, enabling ClockPM\n");
>> -	}
>> -}
>> -
>>   static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>>   {
>>   	int capable = 1, enabled = 1;
>> @@ -410,7 +397,6 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>>   	}
>>   	link->clkpm_enabled = enabled;
>>   	link->clkpm_default = enabled;
>> -	pcie_clkpm_override_default_link_state(link, enabled);
>>   	link->clkpm_capable = capable;
>>   	link->clkpm_disable = blacklist ? 1 : 0;
>>   }
>> @@ -811,19 +797,17 @@ static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
>>   	struct pci_dev *pdev = link->downstream;
>>   	u32 override;
>>   
>> -	/* For devicetree platforms, enable all ASPM states by default */
>> +	/* For devicetree platforms, enable L0s and L1 by default */
>>   	if (of_have_populated_dt()) {
>> -		link->aspm_default = PCIE_LINK_STATE_ASPM_ALL;
>> +		if (link->aspm_support & PCIE_LINK_STATE_L0S)
>> +			link->aspm_default |= PCIE_LINK_STATE_L0S;
>> +		if (link->aspm_support & PCIE_LINK_STATE_L1)
>> +			link->aspm_default |= PCIE_LINK_STATE_L1;
>>   		override = link->aspm_default & ~link->aspm_enabled;
>>   		if (override)
>> -			pci_info(pdev, "ASPM: DT platform, enabling%s%s%s%s%s%s%s\n",
>> -				 FLAG(override, L0S_UP, " L0s-up"),
>> -				 FLAG(override, L0S_DW, " L0s-dw"),
>> -				 FLAG(override, L1, " L1"),
>> -				 FLAG(override, L1_1, " ASPM-L1.1"),
>> -				 FLAG(override, L1_2, " ASPM-L1.2"),
>> -				 FLAG(override, L1_1_PCIPM, " PCI-PM-L1.1"),
>> -				 FLAG(override, L1_2_PCIPM, " PCI-PM-L1.2"));
>> +			pci_info(pdev, "ASPM: DT platform, enabling%s%s\n",
>> +				 FLAG(override, L0S, " L0s"),
>> +				 FLAG(override, L1, " L1"));
>>   	}
>>   }
>>   
>> -- 
>> 2.43.0
>>
> 



