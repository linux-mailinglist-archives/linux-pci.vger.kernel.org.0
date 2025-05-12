Return-Path: <linux-pci+bounces-27604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE2EAB4766
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 00:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4A81890537
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 22:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07E7299A9F;
	Mon, 12 May 2025 22:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="kqLd3Zdt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F1F134D4;
	Mon, 12 May 2025 22:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747089717; cv=none; b=gmFgM+Ngdf1ZCMpNTg0sbZ5ay/1/M9UR7+Ot4PyoKXEaRjRNRM/RtuEUfZTdDp0EXxOs6tkU2Vn1l7Vsc/yBURyWcxhGXmxwbM9vLZ1Lzi/vTnVMuhgjH0dYgLYwCMU0AkE+HTsUDJwQy7flDgizSbF+2yN2AShjjr54ni4UDro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747089717; c=relaxed/simple;
	bh=1RGgfC8JB7sUmcEQ6ExfzMsHu8VnunUHtPAL3pmszdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GWCQfKLghE//BzmM0TmIvWyKZH5q7FPPtTsW6qJUOZPvqqC+58v8ZHJhxFtkEtGZsaymAR4sHrNDBJFzb62R/QtOofDi2JVfblvQnhtmlfFbbCm8k8nDVqRrCwRlH1dIS4ILRDDOmc4zyod/2p/ZKuBYHGy7n7+515SXqxLFCnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=kqLd3Zdt; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.55.22] (ip174-65-98-148.sd.sd.cox.net [174.65.98.148])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4ZxF2x0Xdhz4Fnj;
	Mon, 12 May 2025 18:41:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1747089706; bh=1RGgfC8JB7sUmcEQ6ExfzMsHu8VnunUHtPAL3pmszdE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kqLd3ZdtJwya0WW9fyeijeuMOOiuPTDwZ/xKDjuvsIUZX5nZIKyybALRPhWkIcisx
	 ibLQwDxBKF0OeIfwuy4zp5nNE7fVRqqtSfFOKmaiwsPwUt1j2u+Lhemj/duw3W/rfb
	 wJ9AOWF0gEjeel7FUXd9bJ4AJGFnXp11ENEpLyAo=
Message-ID: <373358c3-6af9-4177-b425-883023f10c55@panix.com>
Date: Mon, 12 May 2025 15:41:43 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Raphael, I'd like your help upstreaming this VMD power-saving
 patch, please
To: Bjorn Helgaas <helgaas@kernel.org>, Me <kenny@panix.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, Vidya Sagar
 <vidyas@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Andrea Righi <andrea.righi@canonical.com>,
 You-Sheng Yang <vicamo.yang@canonical.com>, linux-pci@vger.kernel.org,
 Sergey Dolgov <sergey.v.dolgov@gmail.com>,
 Nirmal Patel <nirmal.patel@linux.intel.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>,
 Jian-Hong Pan <jhp@endlessos.org>, "David E. Box"
 <david.e.box@linux.intel.com>
References: <20250512210938.GA1128238@bhelgaas>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20250512210938.GA1128238@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


What about a quirk, or whitelist?

That's hacky AF, but that way for systems that this is known to work on, 
it could be enabled?

-K


On 5/12/25 14:09, Bjorn Helgaas wrote:
> [+cc Sergey, Nirmal, Jonathan, Jian-Hong, David]
> 
> On Sun, May 11, 2025 at 01:10:24PM -0700, Kenneth R. Crudup wrote:
>>
>> Hello Raphael,
>>
>> For almost two years now, I've been trying to get patches from Ubuntu that
>> enable ASPM for devices behind Intel's VMD, necessary to get full lower-power
>> states (including very-reduced power usage during s0ix sleep) on my Alderlake
>> (et al.) laptop, upstreamed into mainline.
>>
>> One such thread: https://lore.kernel.org/linux-pm/218aa81f-9c6-5929-578d-8dc15f83dd48@panix.com/
>>
>> Since the original set of patches on this, most of the work has been pushed
>> upstream, with only this last patch required to get fully into the "CPU%LPI"
>> and "SYS%LPI" (names according to "turbostat") states.
>>
>> I'm surprised that with the number of VMD-enabled laptops out there (which I
>> had to keep on so I could dual-boot into Win11 (the disk geometry changes if
>> I disable it, rendering the Win11 partition useless)), that there haven't been
>> many reports of excessive power usage in Linux during sleep; perhaps because
>> many installations are running stock Ubuntu kernels (where I assume variants
>> of this patch remain) it isn't an issue, but I do believe having this upstreamed
>> is still valuable.
>>
>> I don't have the resources you've got to test this fully for regressions, nor
>> the expertise getting a patch into the kernel, so I'd like to again bring this
>> up for discussion (hence the phone-book of a CC: here).
>>
>> If there's anything I can do to help get this done, please let me know.
>>
>> Thank you,
>>
>> -Kenneth Crudup
>>
>> -- 
>> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
> 
>>  From ee3618a598a261bbc8a875557d42d6dbbbc4cdd0 Mon Sep 17 00:00:00 2001
>> From: "Kenneth R. Crudup" <kenny@panix.com>
>> Date: Fri, 13 Dec 2024 15:28:42 -0800
>> Subject: [PATCH] PCI/ASPM: Fixup ASPM for VMD bridges
>>
>> Effectively a squashed commit of:
>> UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under VMD domain
>> UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints behind VMD
>> UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name instead
>> ---
>>   drivers/pci/pcie/aspm.c | 28 +++++++++++++++++++++++++++-
>>   1 file changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 29fcb0689a91..fdc1ce2755ff 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -788,6 +788,31 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
>>   		aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_cap);
>>   }
>>   
>> +/*
>> + * BIOS may not be able to access config space of devices under VMD domain, so
>> + * it relies on software to enable ASPM for links under VMD.
>> + */
>> +static bool pci_fixup_vmd_bridge_enable_aspm(struct pci_dev *pdev)
>> +{
>> +       struct pci_bus *bus = pdev->bus;
>> +       struct device *dev;
>> +       struct pci_driver *pdrv;
>> +
>> +       if (!pci_is_root_bus(bus))
>> +               return false;
>> +
>> +       dev = bus->bridge->parent;
>> +       if (dev == NULL)
>> +               return false;
>> +
>> +       pdrv = pci_dev_driver(to_pci_dev(dev));
>> +       if (pdrv == NULL || strcmp("vmd", pdrv->name))
>> +               return false;
>> +
>> +       pci_info(pdev, "enable ASPM for pci bridge behind vmd");
>> +       return true;
>> +}
>> +
>>   static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>>   {
>>   	struct pci_dev *child = link->downstream, *parent = link->pdev;
>> @@ -866,7 +891,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>>   	}
>>   
>>   	/* Save default state */
>> -	link->aspm_default = link->aspm_enabled;
>> +	link->aspm_default = pci_fixup_vmd_bridge_enable_aspm(parent) ?
>> +		PCIE_LINK_STATE_ASPM_ALL : link->aspm_enabled;
> 
> PCIE_LINK_STATE_ASPM_ALL includes PCIE_LINK_STATE_L1_2, so I think
> this potentially enables L1.2.  The L1.2 configuration depends on
> T_POWER_ON and Common_Mode_Restore_Time, which depend on electrical
> design and are not discoverable by the kernel.  See PCIe r6.0, sec
> 5.5.4:
> 
>    The TPOWER_ON and Common_Mode_Restore_Time fields must be programmed
>    to the appropriate values based on the components and AC coupling
>    capacitors used in the connection linking the two components. The
>    determination of these values is design implementation specific.
> 
> aspm_calc_l12_info() tries to compute these values, but I don't think
> it can do it correctly, and we have a related problem report where
> BIOS set them correctly and then Linux came along and messed them up:
> 
>    https://lore.kernel.org/r/20250407155742.GA178541@bhelgaas
> 
> I think the only thing we can do with L1.2 is rely on values already
> programmed by BIOS.  There is a _DSM method for Latency Tolerance
> Reporting configuration (PCI Firmware r3.3, sec 4.6.6), but AFAICT it
> only addresses the LTR Capability in upstream ports, not the
> T_POWER_ON and Common_Mode_Restore_Time values.
> 
> _HPX Type 2 and 3 records (ACPI r6.5, sec 6.2.9.3 and 6.2.9.4) are
> quite general and maybe there's a way to use them to configure the
> L1.2 parameters, but I am skeptical that these have been implemented
> in Linux and BIOSes.  At least, I don't recall any reports of problems
> or of them being used.
> 
> Maybe something like this patch can be done for ASPM *except* for
> L1.2?
> 
> Bjorn
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


