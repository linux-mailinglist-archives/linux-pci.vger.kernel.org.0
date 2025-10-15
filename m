Return-Path: <linux-pci+bounces-38128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B38BBDCD84
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 09:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5100C189E378
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 07:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF602E2DFE;
	Wed, 15 Oct 2025 07:14:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990A8280014;
	Wed, 15 Oct 2025 07:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.54.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512491; cv=none; b=UHVSOnAEbEm43lUhiXpFWQC6NhrrNor+XuUNOc6JJNb2gfuky7/Rlxa/Luq3PszhbG0ZF0tboGHFxVaYNROLBCjR+ruHXrX7E58ChEXyFvVyzJkrRyUtigfNEXubNO+TaEPeOiPFW1Q1YTLWL3pKy16E2mRn1Li6dJLvJK+kdM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512491; c=relaxed/simple;
	bh=klgC8zSc+l0Q/w9Rpn/ccXvkKdPxh+GGaj8qhQbaa44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfx4Pfb0pWPedMteWaczepOLQzqGRCdlN9U03XWCWj3FV4KfUNoRQXEX3qBNLcKZkXWLG/aKFE1N8pWmTLsOFBFwCCJYzMy2Gwe0UwO3JwYxXCUH9QqvYdyuSsCgEakDEq0y/vuExUMcHTB5ch9YeP8vYR6oYWFLrUIiOLWKpOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=43.154.54.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1760512426t711b209d
X-QQ-Originating-IP: 6nwnINKAFYIGvRML+7yx9lB3aMBjuHz5zLBDY+C1Tbg=
Received: from [IPV6:240f:10b:7440:1:f559:f5f: ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Oct 2025 15:13:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17869260487172494319
Message-ID: <823262AB21C8D981+8c1b9d50-5897-432b-972e-b7bb25746ba5@radxa.com>
Date: Wed, 15 Oct 2025 16:13:41 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
To: Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 "David E. Box" <david.e.box@linux.intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Chia-Lin Kao <acelan.kao@canonical.com>, Dragan Simic <dsimic@manjaro.org>,
 linux-rockchip@lists.infradead.org, regressions@lists.linux.dev
References: <22594781424C5C98+22cb5d61-19b1-4353-9818-3bb2b311da0b@radxa.com>
 <20251014184905.GA896847@bhelgaas>
 <5ivvb3wctn65obgqvnajpxzifhndza65rsoiqgracfxl7iiimt@oym345d723o2>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <5ivvb3wctn65obgqvnajpxzifhndza65rsoiqgracfxl7iiimt@oym345d723o2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MP1WLfctJNZWA8tQkYiXqhIzj2GBzGRUHl9BM2DvVl8moKnsJiBaEncf
	5ktTniLtmCQQsOQzmiXRihjSaFjNoImXxA9TVnW0gA7nYlm7Im9RYBHTWsHNUr5PkTjhXhD
	TW1y33+L4666aABFL6O14StJ+16/03wjQg9y+lQX5J054SoLGwRRv81zzBueuW9HtBhvgkX
	opdMM7uTIO2TyZs00DjPjiOMALC+KuxA/qoALxC6PvuIOPRSyzaEkh824T3apZLoplKcf4O
	XYnFD+FWdXooQ7wVSLVQnHzRwvo6t6wImnkwwIIz1TvCTE0/NGXkBCv0aa5RP4dmBu20vhM
	1VKZhs0ygdmb7e7u4zUeB89yGMnHik0eOIE8/9yx6gUL8QAuStm5cNtLv1RN2ASq25bNQXu
	+oaOG0S6mwZixJpUD++79YxPjhCgwpLQ29VJI7FGdcxh7Wwolq/HPWIiim+Ead7NNI0tad2
	4useyMQyjxj6AG8VG0GISu8vp6ngCqKU1UXGWG7FkF6TvfH98qG91QXob+/h+Ik5R13+FS7
	p3JLYzYIs8mcaX3EMpPbsLnQeHxPPTOYdxPYRsdYNRlUz/d5MkMBOANdC9jP7LbZnCswKBS
	jvNi10FhEWLPT8GqDpf6bOQ0oelMwnINgsvpHAQRt8i1/9papDthVnB9q/DQ9jcfAzifVeY
	USgD/a9+SeSd5xYuUrBoSBYq9anS8TuzghPfjz9mHeXDRfTO7611tlvYznXcoYsNP0yfu6h
	FasrJIm6Z3fNRqK6cwA7YJgLMX+EVmL2AlCy3IEHTI7NYeG38ZNp7yNQGPqZ+ZXh7PffBgD
	0riePYqlJqtdpiNmYb1ztE2UEoYrOVj3onZKFJF6xJDdEptHdWrGzhvGDY/qGe5MPZu0yYg
	w4J/a2+pJcH5zLCIQE3dPSwv5t0FO/wMdMgWcJ8oaRrhz2iE0qmQlzwgLukHo6qtE0AH37s
	77G1IfTE+Esuotu2lcBb+o3Gop1az9wkxFooStEoTtpTtdD8vQPsud/09rTaCTwCD5y7bcU
	6eAqPSMxrATOIlIVA3
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-SPAM: true
X-QQ-RECHKSPAM: 3

Hi,

On 10/15/25 15:26, Manivannan Sadhasivam wrote:
> On Tue, Oct 14, 2025 at 01:49:05PM -0500, Bjorn Helgaas wrote:
>> [+cc regressions]
>>
>> On Wed, Oct 15, 2025 at 01:30:16AM +0900, FUKAUMI Naoki wrote:
>>> Hi Manivannan Sadhasivam,
>>>
>>> I've noticed an issue on Radxa ROCK 5A/5B boards, which are based on the
>>> Rockchip RK3588(S) SoC.
>>>
>>> When running Linux v6.18-rc1 or linux-next since 20250924, the kernel either
>>> freezes or fails to probe M.2 Wi-Fi modules. This happens with several
>>> different modules I've tested, including the Realtek RTL8852BE, MediaTek
>>> MT7921E, and Intel AX210.
>>>
>>> I've found that reverting the following commit (i.e., the patch I'm replying
>>> to) resolves the problem:
>>> commit f3ac2ff14834a0aa056ee3ae0e4b8c641c579961
>>
>> Thanks for the report, and sorry for the regression.
>>
>> Since this affects several devices from different manufacturers and (I
>> assume) different drivers, it seems likely that there's some issue
>> with the Rockchip end, since ASPM probably works on these devices in
>> other systems.  So we should figure out if there's something wrong
>> with the way we configure ASPM, which we could potentially fix, or if
>> there's a hardware issue and we need some king of quirk to prevent
>> usage of ASPM on the affected platforms.
>>
> 
> I believe it is the latter. The Root Port is having trouble with ASPM.
> 
> FUKAUMI Naoki, could you please share the 'sudo lspci -vv' output so that we
> know what kind of Root Port we are dealing with? You can revert the offending
> patch and share the output.

Here is dmesg/lspci output on ROCK 5A(RK3588S):
  https://gist.github.com/RadxaNaoki/1355a0b4278b6e51a61d89df7a535a5d

----

I've (likely) noticed another PCIe issue on the ROCK 5B (RK3588).

Reverting commit f3ac2ff14834a0aa056ee3ae0e4b8c641c579961 on top of 
commit 331b2acbe6123dbbcb5c34698692959abbf5748b definitely gets the M.2 
Wi-Fi working. However, reverting commit 
f3ac2ff14834a0aa056ee3ae0e4b8c641c579961 on v6.18-rc1/next-20251014 does 
not work. (It does work on the ROCK 5A.)

Commit 331b2acbe6123dbbcb5c34698692959abbf5748b landed between 
next-20250923 and next-20250924. I'm currently in the process of bisecting.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Then I could supply a patch that you can test out.
> 
> - Mani
> 
>> Can you collect a complete dmesg log when booting with
>>
>>    ignore_loglevel pci=earlydump dyndbg="file drivers/pci/* +p"
>>
>> and the output of "sudo lspci -vv"?
>>
>> When the kernel freezes, can you give us any information about where,
>> e.g., a log or screenshot?
>>
>> Do you know if any platforms other than Radxa ROCK 5A/5B have this
>> problem?
>>
>> #regzbot introduced: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
>> #regzbot dup-of: https://github.com/chzigotzky/kernels/issues/17
>>
>>> On 9/23/25 01:16, Manivannan Sadhasivam via B4 Relay wrote:
>>>> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>>>
>>>> So far, the PCI subsystem has honored the ASPM and Clock PM states set by
>>>> the BIOS (through LNKCTL) during device initialization, if it relies on the
>>>> default state selected using:
>>>>
>>>> * Kconfig: CONFIG_PCIEASPM_DEFAULT=y, or
>>>> * cmdline: "pcie_aspm=off", or
>>>> * FADT: ACPI_FADT_NO_ASPM
>>>>
>>>> This was done conservatively to avoid issues with the buggy devices that
>>>> advertise ASPM capabilities, but behave erratically if the ASPM states are
>>>> enabled. So the PCI subsystem ended up trusting the BIOS to enable only the
>>>> ASPM states that were known to work for the devices.
>>>>
>>>> But this turned out to be a problem for devicetree platforms, especially
>>>> the ARM based devicetree platforms powering Embedded and *some* Compute
>>>> devices as they tend to run without any standard BIOS. So the ASPM states
>>>> on these platforms were left disabled during boot and the PCI subsystem
>>>> never bothered to enable them, unless the user has forcefully enabled the
>>>> ASPM states through Kconfig, cmdline, and sysfs or the device drivers
>>>> themselves, enabling the ASPM states through pci_enable_link_state() APIs.
>>>>
>>>> This caused runtime power issues on those platforms. So a couple of
>>>> approaches were tried to mitigate this BIOS dependency without user
>>>> intervention by enabling the ASPM states in the PCI controller drivers
>>>> after device enumeration, and overriding the ASPM/Clock PM states
>>>> by the PCI controller drivers through an API before enumeration.
>>>>
>>>> But it has been concluded that none of these mitigations should really be
>>>> required and the PCI subsystem should enable the ASPM states advertised by
>>>> the devices without relying on BIOS or the PCI controller drivers. If any
>>>> device is found to be misbehaving after enabling ASPM states that they
>>>> advertised, then those devices should be quirked to disable the problematic
>>>> ASPM/Clock PM states.
>>>>
>>>> In an effort to do so, start by overriding the ASPM and Clock PM states set
>>>> by the BIOS for devicetree platforms first. Separate helper functions are
>>>> introduced to override the BIOS set states by enabling all of them if
>>>> of_have_populated_dt() returns true. To aid debugging, print the overridden
>>>> ASPM and Clock PM states as well.
>>>>
>>>> In the future, these helpers could be extended to allow other platforms
>>>> like VMD, newer ACPI systems with a cutoff year etc... to follow the path.
>>>>
>>>> Link: https://lore.kernel.org/linux-pci/20250828204345.GA958461@bhelgaas
>>>> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
>>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>>> Link: https://patch.msgid.link/20250916-pci-dt-aspm-v1-1-778fe907c9ad@oss.qualcomm.com
>>>> ---
>>>>    drivers/pci/pcie/aspm.c | 42 ++++++++++++++++++++++++++++++++++++++++--
>>>>    1 file changed, 40 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>>> index 919a05b9764791c3cc469c9ada62ba5b2c405118..cda31150aec1b67b6a48b60569222ea3d1c3d41f 100644
>>>> --- a/drivers/pci/pcie/aspm.c
>>>> +++ b/drivers/pci/pcie/aspm.c
>>>> @@ -15,6 +15,7 @@
>>>>    #include <linux/math.h>
>>>>    #include <linux/module.h>
>>>>    #include <linux/moduleparam.h>
>>>> +#include <linux/of.h>
>>>>    #include <linux/pci.h>
>>>>    #include <linux/pci_regs.h>
>>>>    #include <linux/errno.h>
>>>> @@ -235,13 +236,15 @@ struct pcie_link_state {
>>>>    	u32 aspm_support:7;		/* Supported ASPM state */
>>>>    	u32 aspm_enabled:7;		/* Enabled ASPM state */
>>>>    	u32 aspm_capable:7;		/* Capable ASPM state with latency */
>>>> -	u32 aspm_default:7;		/* Default ASPM state by BIOS */
>>>> +	u32 aspm_default:7;		/* Default ASPM state by BIOS or
>>>> +					   override */
>>>>    	u32 aspm_disable:7;		/* Disabled ASPM state */
>>>>    	/* Clock PM state */
>>>>    	u32 clkpm_capable:1;		/* Clock PM capable? */
>>>>    	u32 clkpm_enabled:1;		/* Current Clock PM state */
>>>> -	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
>>>> +	u32 clkpm_default:1;		/* Default Clock PM state by BIOS or
>>>> +					   override */
>>>>    	u32 clkpm_disable:1;		/* Clock PM disabled */
>>>>    };
>>>> @@ -373,6 +376,18 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
>>>>    	pcie_set_clkpm_nocheck(link, enable);
>>>>    }
>>>> +static void pcie_clkpm_override_default_link_state(struct pcie_link_state *link,
>>>> +						   int enabled)
>>>> +{
>>>> +	struct pci_dev *pdev = link->downstream;
>>>> +
>>>> +	/* Override the BIOS disabled Clock PM state for devicetree platforms */
>>>> +	if (of_have_populated_dt() && !enabled) {
>>>> +		link->clkpm_default = 1;
>>>> +		pci_info(pdev, "Clock PM state overridden: ClockPM+\n");
>>>> +	}
>>>> +}
>>>> +
>>>>    static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>>>>    {
>>>>    	int capable = 1, enabled = 1;
>>>> @@ -395,6 +410,7 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>>>>    	}
>>>>    	link->clkpm_enabled = enabled;
>>>>    	link->clkpm_default = enabled;
>>>> +	pcie_clkpm_override_default_link_state(link, enabled);
>>>>    	link->clkpm_capable = capable;
>>>>    	link->clkpm_disable = blacklist ? 1 : 0;
>>>>    }
>>>> @@ -788,6 +804,26 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
>>>>    		aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_cap);
>>>>    }
>>>> +static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
>>>> +{
>>>> +	struct pci_dev *pdev = link->downstream;
>>>> +	u32 override;
>>>> +
>>>> +	/* Override the BIOS disabled ASPM states for devicetree platforms */
>>>> +	if (of_have_populated_dt()) {
>>>> +		link->aspm_default = PCIE_LINK_STATE_ASPM_ALL;
>>>> +		override = link->aspm_default & ~link->aspm_enabled;
>>>> +		if (override)
>>>> +			pci_info(pdev, "ASPM states overridden: %s%s%s%s%s%s\n",
>>>> +				 (override & PCIE_LINK_STATE_L0S) ? "L0s+, " : "",
>>>> +				 (override & PCIE_LINK_STATE_L1) ? "L1+, " : "",
>>>> +				 (override & PCIE_LINK_STATE_L1_1) ? "L1.1+, " : "",
>>>> +				 (override & PCIE_LINK_STATE_L1_2) ? "L1.2+, " : "",
>>>> +				 (override & PCIE_LINK_STATE_L1_1_PCIPM) ? "L1.1 PCI-PM+, " : "",
>>>> +				 (override & PCIE_LINK_STATE_L1_2_PCIPM) ? "L1.2 PCI-PM+" : "");
>>>> +	}
>>>> +}
>>>> +
>>>>    static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>>>>    {
>>>>    	struct pci_dev *child = link->downstream, *parent = link->pdev;
>>>> @@ -868,6 +904,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>>>>    	/* Save default state */
>>>>    	link->aspm_default = link->aspm_enabled;
>>>> +	pcie_aspm_override_default_link_state(link);
>>>> +
>>>>    	/* Setup initial capable state. Will be updated later */
>>>>    	link->aspm_capable = link->aspm_support;
>>>>
>>>
>>>
>>> _______________________________________________
>>> Linux-rockchip mailing list
>>> Linux-rockchip@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 


