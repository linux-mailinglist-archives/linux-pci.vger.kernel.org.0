Return-Path: <linux-pci+bounces-18417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5EA9F1925
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 23:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A2F1635BE
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 22:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECDB192B9D;
	Fri, 13 Dec 2024 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="HTUAuXsC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C56193436;
	Fri, 13 Dec 2024 22:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734129223; cv=none; b=RXELajiJ2/uEN1vOU24+KWxM4qGnPNT6wuoRFsLLachGdcJ79ru2ZjyLMAo2d8XWcPGaRzz2LhcoI1ZLvpjN7BmlNhne+kKRGTGBqOh4+xY8RjUI08+1ks09JOK0SkAritxhpZX280DA/oRF/PyAsxKNCQOwNhu8GiYdVBfkHU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734129223; c=relaxed/simple;
	bh=L0nLusJU/aEXmm/r3uIu9U8EXqHymrDBOtbc95x1JiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dyE/Hath+TERupnH+O18uZYBfZrePl8ZoXfJ9U2OHVY9flDsNPoVvr6RJayQ4BoUJdalzCBRD9tyzlTGcbj7bQJ8756rRzNFNdsiWfiKTRRayDkESu6psByTIOOziSvkJbwZRR8AioPieWEw553IndHjhQ6c4QYVwxzMY2pSRqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=HTUAuXsC; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.80.133] (unknown [207.7.121.250])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4Y93yp1nTBz16lq;
	Fri, 13 Dec 2024 17:33:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1734129219; bh=L0nLusJU/aEXmm/r3uIu9U8EXqHymrDBOtbc95x1JiE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HTUAuXsCdDLaOT6v1Gmn9htqyLM+WKdurq/m+QJcj3DTt6282LuP22VCqUKvax17w
	 y6XR3VWI09LPHK/3SHF96CrQ5JtdZZu8Vrp+6aZ3JEZ1RZtkn63afvoNt9QWDi3uIR
	 yEexYh21hmhb1uUlYjgqRHnHOE87si1GPusvrGAk=
Message-ID: <2d13787e-51fd-4a58-bd3f-9bcbb1217675@panix.com>
Date: Fri, 13 Dec 2024 14:33:37 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Vidya Sagar <vidyas@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Andrea Righi <andrea.righi@canonical.com>,
 You-Sheng Yang <vicamo.yang@canonical.com>, linux-pm@vger.kernel.org,
 linux-pci@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>,
 Nirmal Patel <nirmal.patel@linux.ntel.com>, Me <kenny@panix.com>
References: <20241213164335.GA3381091@bhelgaas>
 <66843f3e-e8f9-40e6-8f7e-a332ff386fe7@panix.com>
 <ff7abb52-fb53-40ce-bef5-50540d6b9512@panix.com>
 <0f708fdf-ca54-488f-8c7e-160c1164308a@panix.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <0f708fdf-ca54-488f-8c7e-160c1164308a@panix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Ah, that sweet power savings! :)

----
C1E%    C10%    CPU%c7  PkgTmp  GFX%rc6 GFXMHz  GFXAMHz CPUGFX% Pkg%pc8 
Pk%pc10 CPU%LPI SYS%LPI PkgWatt CorWatt GFXWatt
0.65    93.77   36.12   49      0.00    1033    1050    2.93    7.53 
21.66   21.70   0.00    3.28    1.34    0.02
0.09    99.23   41.68   48      0.00    1033    1050    0.91    11.98 
10.22   10.24   0.00    1.95    0.22    0.01
0.09    99.17   41.41   49      0.00    1033    1050    0.25    29.83 
39.18   39.26   11.38   1.10    0.34    0.00
0.02    99.78   42.40   48      0.00    1033    1050    0.20    31.63 
48.31   48.40   42.58   0.55    0.11    0.00
0.06    99.35   41.67   46      0.00    1033    1050    0.21    23.86 
51.95   52.04   46.83   0.80    0.30    0.00
C1E%    C10%    CPU%c7  PkgTmp  GFX%rc6 GFXMHz  GFXAMHz CPUGFX% Pkg%pc8 
Pk%pc10 CPU%LPI SYS%LPI PkgWatt CorWatt GFXWatt
0.04    99.71   42.38   46      0.00    1033    1050    0.20    24.74 
58.05   58.15   51.85   0.44    0.11    0.00
0.07    99.41   41.77   46      0.00    1033    1050    0.17    25.20 
52.57   52.65   46.99   0.73    0.27    0.00
0.03    99.76   42.39   45      0.00    1033    1050    0.18    26.67 
56.59   56.68   50.16   0.46    0.11    0.00
0.06    99.24   41.54   45      0.00    1033    1050    0.24    23.89 
46.83   46.90   41.40   0.91    0.32    0.00
0.03    99.75   42.42   45      0.00    1033    1050    0.20    22.65 
59.64   59.73   52.87   0.46    0.10    0.00
----

-K

On 12/13/24 14:26, Kenneth Crudup wrote:
> 
> OK, it looks like the effective change (that's not already contained in 
> the LTR SNOOP patches already in Linus' master (et al.)) comes from this 
> line from the Ubuntu commit 1a0102a0 ("UBUNTU: SAUCE: PCI/ASPM: Enable 
> ASPM for links under VMD domain"):
> 
> ----
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 00143f5fb83a..d2ff44e7fbb1 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -688,7 +688,8 @@ static void pcie_aspm_cap_init(struct 
> pcie_link_state *link, int blacklist)
>          aspm_l1ss_init(link);
> 
>          /* Save default state */
> -       link->aspm_default = link->aspm_enabled;
> +       link->aspm_default = parent->dev_flags & 
> PCI_DEV_FLAGS_ENABLE_ASPM ?
> +                            ASPM_STATE_ALL : link->aspm_enabled;
> ----
> 
> Where "PCI_DEV_FLAGS_ENABLE_ASPM" (a new flag) is set if the parent 
> bridge is a VMD (determined via Ubuntu commit 154d48da2 ("UBUNTU: SAUCE: 
> vmd: fixup bridge ASPM by driver name instead").
> 
> So, as we've both noticed, most of the three patches I'd pointed out 
> aren't required as the LTR SNOOP values are either fixed up, or 
> previously set in the BIOS.
> 
> So I've folded the new commits into the attached patch (against Linus' 
> master), which now gives me full power-saving.
> 
> -K
> 
> 
> On 12/13/24 12:27, Kenneth Crudup wrote:
>>
>> Turns out that my current VMD is already listed as "VMD_FEATS_CLIENT" 
>> after all:
>>
>> ----
>>          {PCI_VDEVICE(INTEL, 0x467f),
>>                  .driver_data = VMD_FEATS_CLIENT,},
>> ----
>> 0000:00:0e.0 0104: 8086:467f
>>          Subsystem: 1028:0af3
>>          Flags: bus master, fast devsel, latency 0, IOMMU group 9
>>          Memory at 603c000000 (64-bit, non-prefetchable) [size=32M]
>>          Memory at 72000000 (32-bit, non-prefetchable) [size=32M]
>>          Memory at 6040100000 (64-bit, non-prefetchable) [size=1M]
>>          Capabilities: [80] MSI-X: Enable+ Count=19 Masked-
>>          Capabilities: [90] Express Root Complex Integrated Endpoint, 
>> MSI 00
>>          Capabilities: [e0] Power Management version 3
>>          Kernel driver in use: vmd
>> ----
>>
>> I'm going to compare the commits you'd pointed out in master to what 
>> the working (Ubuntu) patches do and figure out where the disconnect is.
>>
>> -K
>>
>> On 12/13/24 11:48, Kenneth Crudup wrote:
>>>
>>> I was really hopeful this would have handled it, but no joy.
>>>
>>> I also tried dropping "PCI/ASPM: Enable LTR for endpoints behind VMD" 
>>> and "PCI/ASPM: Enable ASPM for links under VMD domain" each 
>>> separately on top of the below quirk patch to no avail.
>>>
>>> The only thing that works is the aggregate patch I've added.
>>>
>>>  > However, IDs 0x9a09, 0xa0b0, and 0xa0bc are NOT tagged with
>>>  > VMD_FEATS_CLIENT.  In fact, they're not included in vmd_ids[] at all,
>>>  > so I'd be surprised if VMD worked for those devices unless BIOS set
>>>  > up the VMD itself.
>>>
>>> Yeah, my BIOS does- not sure if you'd missed it, but I'd rewritten 
>>> "Enable LTR for endpoints behind VMD" to print if the BIOS already 
>>> does that for you, and sent the patch here (since I wasn't seeing the 
>>> message printed when the fixup was being done and wanted to know why).
>>>
>>> I'd REALLY like to get this into mainline, so if there's anything I 
>>> can do to help, LMK.
>>>
>>> Thanks,
>>> -Kenny
>>>
>>>
>>> On 12/13/24 08:43, Bjorn Helgaas wrote:
>>>> [+cc David, Nirmal, linux-pci]
>>>>
>>>> On Thu, Dec 12, 2024 at 03:04:53PM -0800, Kenneth Crudup wrote:
>>>>> On 12/12/24 12:56, Bjorn Helgaas wrote:
>>>>>> On Wed, Dec 11, 2024 at 03:26:37PM -0800, Kenneth Crudup wrote:
>>>>>>> So we're on 6.13-rc2 and the patches are getting closer and
>>>>>>> closer, but they still need to be manually added.
>>>>>>>
>>>>>>> The good news is now only (variants of) "PCI/ASPM: Enable LTR
>>>>>>> for endpoints behind VMD" and "PCI/ASPM: Enable ASPM for links
>>>>>>> under VMD domain" are needed.
>>>>> ...
>>>>
>>>>> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/ 
>>>>> lunar/commit/?id=47c7bfd31514e7b54a1f830f7707297aebbb8679
>>>>
>>>> This is "UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints behind
>>>> VMD", which writes PCI_LTR_MAX_SNOOP_LAT and PCI_LTR_MAX_NOSNOOP_LAT
>>>> for PCI_CLASS_STORAGE_EXPRESS devices directly below VMDs with Device
>>>> IDs 0x9a09, 0xa0b0, or 0xa0bc.
>>>>
>>>> This looks equivalent in spirit to upstream
>>>> https://git.kernel.org/linus/f492edb40b54 ("PCI: vmd: Add quirk to
>>>> configure PCIe ASPM and LTR"), which writes PCI_LTR_MAX_SNOOP_LAT and
>>>> PCI_LTR_MAX_NOSNOOP_LAT for any kind of device below VMDs tagged with
>>>> VMD_FEATS_CLIENT, which includes 0x467f, 0x4c3d, 0x7d0b, 0x9a0b,
>>>> 0xa77f, 0xad0b, 0xb06f, 0xb60b.
>>>>
>>>> However, IDs 0x9a09, 0xa0b0, and 0xa0bc are NOT tagged with
>>>> VMD_FEATS_CLIENT.  In fact, they're not included in vmd_ids[] at all,
>>>> so I'd be surprised if VMD worked for those devices unless BIOS set
>>>> up the VMD itself.
>>>>
>>>> Maybe David or Nirmal can comment on this?
>>>>
>>>>> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/ 
>>>>> lunar/commit/?id=1a0102a08f206149d9abd56c2b28877c878b5526
>>>>
>>>> This is "UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under VMD
>>>> domain", which adds "link->aspm_default = ASPM_STATE_ALL" for device
>>>> IDs 0x9a09 and 0xa0b0.
>>>>
>>>> This looks like it should also be handled by upstream f492edb40b54
>>>> ("PCI: vmd: Add quirk to configure PCIe ASPM and LTR") [1], which adds
>>>> "pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL)".
>>>>
>>>> But again, the Device IDs mentioned in the Ubuntu commit are NOT
>>>> included in the upstream VMD_FEATS_CLIENT list.
>>>>
>>>>> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/ 
>>>>> lunar/commit/?id=154d48da2c57514e4b5dadc7b8c70a4edb550981
>>>>
>>>> This is "UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name
>>>> instead", which applies the quirk that writes PCI_LTR_MAX_SNOOP_LAT
>>>> and PCI_LTR_MAX_NOSNOOP_LAT for PCI_CLASS_STORAGE_EXPRESS devices
>>>> below any VMD claimed by the "vmd" driver, not just VMDs with Device
>>>> IDs 0x9a09, 0xa0b0, or 0xa0bc.
>>>>
>>>> I think the only thing that's missing is that the upstream vmd_ids[]
>>>> needs to be updated with some new VMD Device IDs that are tagged with
>>>> VMD_FEATS_CLIENT.
>>>>
>>>> I don't know what the vmd_ids[] strategy is, but Kenneth, you might
>>>> try an upstream patch like the one below.  If that resolves the
>>>> standby/low-power issues, maybe David or Nirmal can figure out the
>>>> "right" way to do this.
>>>>
>>>> Bjorn
>>>>
>>>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/ 
>>>> vmd.c
>>>> index 9d9596947350..4de7ff3bbf23 100644
>>>> --- a/drivers/pci/controller/vmd.c
>>>> +++ b/drivers/pci/controller/vmd.c
>>>> @@ -1109,6 +1109,12 @@ static const struct pci_device_id vmd_ids[] = {
>>>>                   .driver_data = VMD_FEATS_CLIENT,},
>>>>       {PCI_VDEVICE(INTEL, 0xb06f),
>>>>                   .driver_data = VMD_FEATS_CLIENT,},
>>>> +    {PCI_VDEVICE(INTEL, 0x9a09),
>>>> +                .driver_data = VMD_FEATS_CLIENT,},
>>>> +    {PCI_VDEVICE(INTEL, 0xa0b0),
>>>> +                .driver_data = VMD_FEATS_CLIENT,},
>>>> +    {PCI_VDEVICE(INTEL, 0xa0bc),
>>>> +                .driver_data = VMD_FEATS_CLIENT,},
>>>>       {0,}
>>>>   };
>>>>   MODULE_DEVICE_TABLE(pci, vmd_ids);
>>>>
>>>
>>
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


