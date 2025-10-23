Return-Path: <linux-pci+bounces-39073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC16BFF1C2
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 06:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE583A618A
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 04:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED48F42056;
	Thu, 23 Oct 2025 04:26:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B4C86340;
	Thu, 23 Oct 2025 04:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761193581; cv=none; b=eYmb2TxfKTiunP+S8H93qxOaZ6c/VAZHlF/9pfqdEjkoYHwZROkrvdAVpQKQT9j6+wjDZJAFl9zY1yLWAfH63nQGdGKUNEjBIwi9tGiMcUIYF+ngfmPxk7h8npgynTvwROJb+PuPCWzAvFrXZVeGBe+9neO3DMKvzdhE9bjS4vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761193581; c=relaxed/simple;
	bh=YOwc2PCw6wKdHYwC7a5zx8wB+WJuO72oi66YUEa6bZs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lJmhoDi45rlKxYP44v6FqOtn2Emt0jz3mss9VlLSTdQVttgGWrV7cYrAnpfrQN9nrYWUbNlBhyD6B9bwaApUNUCNfSpGK0t0En8yV9sl4Ta0WCiokvhGBNywlGIWLuVK6lLcyrbYPSjkSA0kCtO5EV1XQbnKeRbPWl013qJFvYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip3t1761193522tef428f52
X-QQ-Originating-IP: JPrRRTlHCfYPmJA50Mc6e8C2H74+nUxiiGHXdILT6fM=
Received: from [IPV6:240f:10b:7440:1:e4c5:315f ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Oct 2025 12:25:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 993648041000243258
Message-ID: <340D76D438E6105B+58e7f834-75f7-40c5-a46a-677cb279a02d@radxa.com>
Date: Thu, 23 Oct 2025 13:25:17 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: FUKAUMI Naoki <naoki@radxa.com>
Subject: [RESEND] Re: [PATCH] PCI/ASPM: Enable only L0s and L1 for devicetree
 platforms
To: Bjorn Helgaas <helgaas@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-rockchip@lists.infradead.org
References: <20251022191313.GA1265088@bhelgaas>
Content-Language: en-US
In-Reply-To: <20251022191313.GA1265088@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NjShqG0OhPJBxRrvSuwcy0uYO8Kz7VbxbJRPk3bnzqPq7l9zo3dydnMn
	t2XVAP79x/FtNsTFMHlw/c05WNOo1wIGshSWnadGd03jVj+DkrAC9rbwV+KWmwFOdrlh5UR
	fzuJOlVE68DkXM+UJyxAtFVX03z2UBAy4w8sl4H5rSK/PGJ4GYVmMjC48Kv2FUKbSGHnKPo
	Wj4QePlUfPAYIgDwxEGsa571b/Yq0dAZh2SPndm/8mXhfYPprmxwxjkYtNiaFbMk/fx04QW
	N60iOtXUom2H96PsEa85SsaUmTRk+y3OuyVztbdOFx6s77PhpNVDNaOBDbjruXWzlJwZhxg
	EhD9SKy/lYg9dHS3S+S0bbZxb3zxhOZT5u2cWGkUdtctEYB+IOkmFYSAPj3IRnr3ELofgEU
	w0uIqx412zhAZgCYA0l8i36BsFZCa5X1VXpCf+OdObS61aRd5M4HLRDINB/J9NxCZiLz0+9
	dzRiFP0f0Mvn9iPrgerOhvY4g/iNJGgNFZWr7Nf/XqYFQg2Ep/lyu7bHnntR2/T1Aip2OF5
	jdUBecMTCO1W6rFrQKjIhr7IcFXdUrH1XbkHbn5oOvAOEsTasT+b3qU8xm6udbNl5NgDmkS
	vpDcM9aP2RGRm6Z7HRlVbbK3gt3HuWhvB1jyi8c9VC8GU8EidJpIvq3XKKcrm9c+3kdSsiA
	+EpeBjY/toIvr8l+IyYeRsMQUWRjmSRAr8kDTMYUTEOPIz8BaXkaKR7KIWsODvyPUMxdvi0
	1JOP82avUD6dRl/iC+t4UTaFhU4dTAwKCAaRAkNSdGCM6cotLKMSmU/NwQGz35FR6cnh3lF
	h47yjeObTpF/7DmIJ2UesWqdHSP/mqCc4fCik/REi8Ug2ShGhoR291PqAoHsVTn4SAst74Y
	fUCzucAl7izi29g6xVN3XlbJZsdly6LwrdAkNlJO7zA4Q/jQl1eobnxsk1eBkkRR7tRpyjj
	aD9IFljHOzmWPW8w8cvBa8J8mqRMLJ06eNWfOUDcdvvQIrAle8ZFkZFqjlUe+nPhBiMciTG
	mTFYByB9n81umQrRMPbNq55xDfYRsLJb6n8kQuhg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

# Fixes the ML address for linux-rockchip
# Please resend the original patch to linux-rockchip@lists.infradead.org

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



