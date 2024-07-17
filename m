Return-Path: <linux-pci+bounces-10460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA1B93429A
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 21:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37B4C1C20CA1
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 19:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B7717545;
	Wed, 17 Jul 2024 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RexfYRmE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FBC6FB6;
	Wed, 17 Jul 2024 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721244853; cv=none; b=FNZF4oWZ4/7jQ3J0XEkUjJLUhlyjzn79gRTtFsloCKqPdEvAK7THBy7lPAoYbEm3LPz14HnJJT0cPWi/08NhqcsIACQpYi47cCyue1TP5FRzRi/bWM8LnWI3HPnlqetC6H2I7a2+SUpsSQO79GdNuOE0w1KAuL25gA8bK5oL7GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721244853; c=relaxed/simple;
	bh=VUAr+Gga6DjkfAlbxst7jQXp5PFbOpfMydi5wlPMqY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FckqaAtrVQkBUTD2Nd9zqxrSJ4pX8D28SafD98z5FX024Z8Px+xexFqvx8mEItlvRVcv+7dMcnSvCufVRnKHUqnEroy/3qXy7uiLhPxuCW1wKD/z06qdZ9zFTVdsyIWdrMmvbheR67tSgbTnRRYkYCxncVM5g1754/wLTV9KrtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RexfYRmE; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52e98087e32so7611e87.2;
        Wed, 17 Jul 2024 12:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721244850; x=1721849650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K531GAsdwyCRmQ+T/cJNTg4B2HzzVmfmf6YyRAc0B2E=;
        b=RexfYRmEb+2/Q/V082NUlXNvkHw5UogjYlAt7zVUMVPM/kjfU5N+QHjHHKEd83ryeT
         ztcdnXE1n2irfSrdM3zRNOQQhrWi6shl28ctmX+WhVKjOXXOxd25j2MJJNJ++DAnRwDO
         0PmZXbLZuTPjEcrjIN4DRTkIRTR1gvOCc38GAcrdATufhcIpkI59CoaGnBJfkSTk9qoQ
         9YT7R2iMaIHzhdOve2HAVhCmj5f6lR2F3/mLH4qvKW0Eimf6Vc3UI6g7aOtwntZXfwiG
         GjDFxcB++GXrFqPD13irX4zPKO1hD/BBluszAwQ3atzgshHGvoRwQXQqzDj6+vlMGR6J
         d/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721244850; x=1721849650;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K531GAsdwyCRmQ+T/cJNTg4B2HzzVmfmf6YyRAc0B2E=;
        b=EaQNo1VaZl92XI3o4qlghdrBKbWmqwz+r4JzSBsdb7UJCJnOvPU4DuK6yLbUhQ2/y7
         d/zQhlBrCIV6D4g+KsGkYq3JLc1BCdHRw224oKl9R3/SXug3z/Mzf/rcKovCrsI94Gzz
         IEaNKVrvCuDfOBk2obAsDI3O17Aa/jSiVennLKjE6nmUZtc+pNRTLzJ6JT3hndt8pP49
         GiwY/6sfbjbNVDAmiA7DEW3GWq3Zi3FCA/8hO2v3O357yB/GVHpE66l11uLukUMe+QqO
         vv/qV4rUHRUmL0pZMt469oL2QcWQI3dFN89PNd9VfnMe+/WzkKZEuq5dJ4lZMgSYHEzX
         O7nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFL/cRNcpi24acC2M+PfVglVZNH0Yv/TuwVH3ml1Gv+EB6ijA8SO81NvKO6oJMcqUmOcxVp5CIlBDx8EbAj1VNyX+Dx3bpmwThoAG1zbLkckR9TGPfwCj3NuGgVSpWwQg/DVSfoBusiC2Kre3gIlO1WgdywtJ9Xe+Vmw+gzeGf
X-Gm-Message-State: AOJu0YwniXvsoMIYJw8fdRbsVE3xvBLSo/j+7Jn/SY6au2+9dHyUNqQK
	nN9MRgwvYJs10oNBZzgHeTegMI66oX7v27oOKBEvPZAU3j+/xANb
X-Google-Smtp-Source: AGHT+IGf/C0lkhj103EQJsHdTYNsCRVI6pZS9fJphACgVEhKFv14zcYoPop/yQxqLjrz4AYAL0z1qg==
X-Received: by 2002:a05:6512:1296:b0:52c:d753:2829 with SMTP id 2adb3069b0e04-52ee53b2456mr2147084e87.19.1721244849347;
        Wed, 17 Jul 2024 12:34:09 -0700 (PDT)
Received: from ?IPV6:2a01:c23:b967:1800:a013:f2e4:b2a8:a7df? (dynamic-2a01-0c23-b967-1800-a013-f2e4-b2a8-a7df.c23.pool.telefonica.de. [2a01:c23:b967:1800:a013:f2e4:b2a8:a7df])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a79bc820d5dsm471188666b.209.2024.07.17.12.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 12:34:08 -0700 (PDT)
Message-ID: <79e93843-b14b-45cc-a8b8-0dc72f3a4f64@gmail.com>
Date: Wed, 17 Jul 2024 21:34:08 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: r8169: add suspend/resume aspm quirk
To: George-Daniel Matei <danielgeorgem@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nic_swsd@realtek.com, netdev@vger.kernel.org,
 Bjorn Helgaas <helgaas@kernel.org>
References: <20240708172339.GA139099@bhelgaas>
 <e1ed82cb-6d20-4ca8-b047-4a02dde115a8@gmail.com>
 <CACfW=qpNmSeQVG_qSeYpEdk9pf_RTAEEKp+OiBYrRFd3d6HOXg@mail.gmail.com>
 <edf2a0aa-d027-489f-891f-254849a47c60@gmail.com>
 <CACfW=qqJ4ubkr036n=VU8GM=OVru-q76O8DG4GV-8hMyK5ZGKA@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <CACfW=qqJ4ubkr036n=VU8GM=OVru-q76O8DG4GV-8hMyK5ZGKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17.07.2024 19:12, George-Daniel Matei wrote:
> On Wed, Jul 10, 2024 at 9:59 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 10.07.2024 17:09, George-Daniel Matei wrote:
>>> Hi,
>>>
>>>>> Added aspm suspend/resume hooks that run
>>>>> before and after suspend and resume to change
>>>>> the ASPM states of the PCI bus in order to allow
>>>>> the system suspend while trying to prevent card hangs
>>>>
>>>> Why is this needed?  Is there a r8169 defect we're working around?
>>>> A BIOS defect?  Is there a problem report you can reference here?
>>>>
>>>
>>> We encountered this issue while upgrading from kernel v6.1 to v6.6.
>>> The system would not suspend with 6.6. We tracked down the problem to
>>> the NIC of the device, mainly that the following code was removed in
>>> 6.6:
>>>> else if (tp->mac_version >= RTL_GIGA_MAC_VER_46)
>>>>         rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
>>> For the listed devices, ASPM L1 is disabled entirely in 6.6. As for
>>> the reason, L1 was observed to cause some problems
>>> (https://bugzilla.kernel.org/show_bug.cgi?id=217814). We use a Raptor
>>> Lake soc and it won't change residency if the NIC doesn't have L1
>>> enabled. I saw in 6.1 the following comment:
>>
>> With residency you refer to the package power saving state?
>>
> Yes, by residency I'm referring to the package power saving state.
> 
>>>> Chips from RTL8168h partially have issues with L1.2, but seem
>>>> to work fine with L1 and L1.1.
>>> I was thinking that disabling/enabling L1.1 on the fly before/after
>>> suspend could help mitigate the risk associated with L1/L1.1 . I know
>>> that ASPM settings are exposed in sysfs and that this could be done
>>> from outside the kernel, that was my first approach, but it was
>>> suggested to me that this kind of workaround would be better suited
>>> for quirks. I did around 1000 suspend/resume cycles of 16-30 seconds
>>> each (correcting the resume dev->bus->self being configured twice
>>> mistake) and did not notice any problems. What do you think, is this a
>>> good approach ... ?
>>>
>> If the root cause really should be in the SoC's ASPM implementation, then:
>> - Other systems with the same SoC may suffer from the same problem,
>>   but are not covered by the quirk.
>> - The issue may occur also with other devices than a RTL8168 NIC.
>>   How about e.g. RTL8125? Or completely different PCI devices?
>>
>> What I understand so far from your description:
>>
>> W/o ASPM L1 the SoC doesn't change "residency". See comment above,
>> please elaborate on this.
>> And w/ ASPM L1 the NIC hangs on suspend?
>> What's the dmesg entries related to this hang? Tx timeout?
>> Or card not accessible at all?
>>
> W/o ASPM L1 the SoC doesn't change power states, yes.
> With ASPM L1 the SoC changes power states. But for the L1
> substates, L1.1 could cause tx timeouts as per 90ca51e8c654 ("r8169:
> fix ASPM-related issues on a number of systems with NIC version from
> RTL8168h". So L1 (and L1.1) couldn't be simply turned back on without the
> possibility of running into these tx timeouts. I never observed them while
> I experimented and tested with L1 and L1.1.
> 
>> My perspective so far:
>> It's a relatively complex quirk that covers only a part of the potentially
>> affected systems, and the issue isn't well understood.
>>
>> And most likely there are lots of systems out there with a Raptor Lake CPU
>> and a RTL8168 on board. Therefore it's surprising that there hasn't been
>> a similar report before.
>>
>>
>>>>> +             //configure device
>>>>> +             pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
>>>>> +                                                PCI_EXP_LNKCTL_ASPMC, 0);
>>>>> +
>>>>> +             pci_read_config_word(dev->bus->self,
>>>>> +                                  dev->bus->self->l1ss + PCI_L1SS_CTL1,
>>>>> +                                  &val);
>>>>> +             val = val & ~PCI_L1SS_CTL1_L1SS_MASK;
>>>>> +             pci_write_config_word(dev->bus->self,
>>>>> +                                   dev->bus->self->l1ss + PCI_L1SS_CTL1,
>>>>> +                                   val);
>>>> Updates the parent (dev->bus->self) twice; was the first one supposed
>>>> to update the device (dev)?
>>> Yes, it was supposed to update the device (dev). It's my first time
>>> sending a patch and I messed something up while doing some style
>>> changes, I will correct it. I'm sorry for that.
>>>
>>>> This doesn't restore the state as it existed before suspend.  Does
>>>> this rely on other parts of restore to do that?
>>> It operates on the assumption that after driver initialization
>>> PCI_EXP_LNKCTL_ASPMC is 0 and that there are no states enabled in
>>> CTL1. I did a lspci -vvv dump on the affected devices before and after
>>> the quirks ran and saw no difference. This could be improved.
>>>
>>>> What is the RTL8168 chip version used on these systems?
>>> It should be RTL8111H.
>>>
>>>> What's the root cause of the issue?
>>>> A silicon bug on the host side?
>>> I think it's the ASPM implementation of the soc.
>>>
>>>> ASPM L1 is disabled per default in r8169. So why is the patch needed
>>>> at all?
>>> Leaving it disabled all the time prevents the system from suspending.
>>>
>> This is not clear to me. You refer to STR?
>> Why should a system not suspend just because one PCI device doesn't
>> have ASPM L1 enabled?
> I think some of my previous comments have been misleading.
> The actual problem is that the SoC doesn't change power states.
> 
This makes sense, thanks for the clarification.

> intel_pmc_core INT33A1:00: CPU did not enter SLP_S0!!!
> 
> In the case of the system I observed the problem, there is an
> EC, separate from the SoC, which will trigger the system to resume
> if following a suspend there is no power state transition
> detected after a period of time. That's why I was mentioning
> "can't suspend" but actually is a "can't achieve s0ix" problem.
> 
> I searched for s0ix problems, I found:
> https://bugzilla.kernel.org/show_bug.cgi?id=207893
> and it looks similar. What do you think ?
> 
> Somehow not having L1 enabled makes it that the PCI controller
> have a state that doesn't meet the criteria to transition to s0ix.
> 

It's a known issue that disabling certain ASPM states can result
in the the system not reaching deeper package power saving states.
It has been reported several times, especially for notebooks and
mini-pc servers, where users try to keep energy consumption at a
minimum. It's a tradeoff which ASPM states to enable, and one of
the reasons why ASPM states can be controlled from user space.

The RTL8168 NIC family has a long history of ASPM issues.
Partially it also seems to depend on the host system chipset.
Root cause isn't known, Realtek doesn't provide datasheets
or errata information.

> 
> 
> 
>>
>>> Thank you,
>>> George-Daniel Matei
>>>
>>>
>>>
>>>
>>>
>>> On Tue, Jul 9, 2024 at 12:15 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>
>>>> On 08.07.2024 19:23, Bjorn Helgaas wrote:
>>>>> [+cc r8169 folks]
>>>>>
>>>>> On Mon, Jul 08, 2024 at 03:38:15PM +0000, George-Daniel Matei wrote:
>>>>>> Added aspm suspend/resume hooks that run
>>>>>> before and after suspend and resume to change
>>>>>> the ASPM states of the PCI bus in order to allow
>>>>>> the system suspend while trying to prevent card hangs
>>>>>
>>>>> Why is this needed?  Is there a r8169 defect we're working around?
>>>>> A BIOS defect?  Is there a problem report you can reference here?
>>>>>
>>>>
>>>> Basically the same question from my side. Apparently such a workaround
>>>> isn't needed on any other system. And Realtek NICs can be found on more
>>>> or less every consumer system. What's the root cause of the issue?
>>>> A silicon bug on the host side?
>>>>
>>>> What is the RTL8168 chip version used on these systems?
>>>>
>>>> ASPM L1 is disabled per default in r8169. So why is the patch needed
>>>> at all?
>>>>
>>>>> s/Added/Add/
>>>>>
>>>>> s/aspm/ASPM/ above
>>>>>
>>>>> s/PCI bus/device and parent/
>>>>>
>>>>> Add period at end of sentence.
>>>>>
>>>>> Rewrap to fill 75 columns.
>>>>>
>>>>>> Signed-off-by: George-Daniel Matei <danielgeorgem@chromium.org>
>>>>>> ---
>>>>>>  drivers/pci/quirks.c | 142 +++++++++++++++++++++++++++++++++++++++++++
>>>>>>  1 file changed, 142 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>>>> index dc12d4a06e21..aa3dba2211d3 100644
>>>>>> --- a/drivers/pci/quirks.c
>>>>>> +++ b/drivers/pci/quirks.c
>>>>>> @@ -6189,6 +6189,148 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b0, aspm_l1_acceptable_latency
>>>>>>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency);
>>>>>>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
>>>>>>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
>>>>>> +
>>>>>> +static const struct dmi_system_id chromebox_match_table[] = {
>>>>>> +    {
>>>>>> +            .matches = {
>>>>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Brask"),
>>>>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>>>>>> +            }
>>>>>> +    },
>>>>>> +    {
>>>>>> +            .matches = {
>>>>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Aurash"),
>>>>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>>>>>> +            }
>>>>>> +    },
>>>>>> +            {
>>>>>> +            .matches = {
>>>>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Bujia"),
>>>>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>>>>>> +            }
>>>>>> +    },
>>>>>> +    {
>>>>>> +            .matches = {
>>>>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Gaelin"),
>>>>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>>>>>> +            }
>>>>>> +    },
>>>>>> +    {
>>>>>> +            .matches = {
>>>>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Gladios"),
>>>>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>>>>>> +            }
>>>>>> +    },
>>>>>> +    {
>>>>>> +            .matches = {
>>>>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Hahn"),
>>>>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>>>>>> +            }
>>>>>> +    },
>>>>>> +    {
>>>>>> +            .matches = {
>>>>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Jeev"),
>>>>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>>>>>> +            }
>>>>>> +    },
>>>>>> +    {
>>>>>> +            .matches = {
>>>>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Kinox"),
>>>>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>>>>>> +            }
>>>>>> +    },
>>>>>> +    {
>>>>>> +            .matches = {
>>>>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Kuldax"),
>>>>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>>>>>> +            }
>>>>>> +    },
>>>>>> +    {
>>>>>> +            .matches = {
>>>>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Lisbon"),
>>>>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>>>>>> +            }
>>>>>> +    },
>>>>>> +    {
>>>>>> +                    .matches = {
>>>>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Moli"),
>>>>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>>>>>> +            }
>>>>>> +    },
>>>>>> +    { }
>>>>>> +};
>>>>>> +
>>>>>> +static void rtl8169_suspend_aspm_settings(struct pci_dev *dev)
>>>>>> +{
>>>>>> +    u16 val = 0;
>>>>>> +
>>>>>> +    if (dmi_check_system(chromebox_match_table)) {
>>>>>> +            //configure parent
>>>>>> +            pcie_capability_clear_and_set_word(dev->bus->self,
>>>>>> +                                               PCI_EXP_LNKCTL,
>>>>>> +                                               PCI_EXP_LNKCTL_ASPMC,
>>>>>> +                                               PCI_EXP_LNKCTL_ASPM_L1);
>>>>>> +
>>>>>> +            pci_read_config_word(dev->bus->self,
>>>>>> +                                 dev->bus->self->l1ss + PCI_L1SS_CTL1,
>>>>>> +                                 &val);
>>>>>> +            val = (val & ~PCI_L1SS_CTL1_L1SS_MASK) |
>>>>>> +                  PCI_L1SS_CTL1_PCIPM_L1_2 | PCI_L1SS_CTL1_PCIPM_L1_2 |
>>>>>> +                  PCI_L1SS_CTL1_ASPM_L1_1;
>>>>>> +            pci_write_config_word(dev->bus->self,
>>>>>> +                                  dev->bus->self->l1ss + PCI_L1SS_CTL1,
>>>>>> +                                  val);
>>>>>> +
>>>>>> +            //configure device
>>>>>> +            pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
>>>>>> +                                               PCI_EXP_LNKCTL_ASPMC,
>>>>>> +                                               PCI_EXP_LNKCTL_ASPM_L1);
>>>>>> +
>>>>>> +            pci_read_config_word(dev, dev->l1ss + PCI_L1SS_CTL1, &val);
>>>>>> +            val = (val & ~PCI_L1SS_CTL1_L1SS_MASK) |
>>>>>> +                  PCI_L1SS_CTL1_PCIPM_L1_2 | PCI_L1SS_CTL1_PCIPM_L1_2 |
>>>>>> +                  PCI_L1SS_CTL1_ASPM_L1_1;
>>>>>> +            pci_write_config_word(dev, dev->l1ss + PCI_L1SS_CTL1, val);
>>>>>> +    }
>>>>>> +}
>>>>>> +
>>>>>> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_REALTEK, 0x8168,
>>>>>> +                      rtl8169_suspend_aspm_settings);
>>>>>> +
>>>>>> +static void rtl8169_resume_aspm_settings(struct pci_dev *dev)
>>>>>> +{
>>>>>> +    u16 val = 0;
>>>>>> +
>>>>>> +    if (dmi_check_system(chromebox_match_table)) {
>>>>>> +            //configure device
>>>>>> +            pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
>>>>>> +                                               PCI_EXP_LNKCTL_ASPMC, 0);
>>>>>> +
>>>>>> +            pci_read_config_word(dev->bus->self,
>>>>>> +                                 dev->bus->self->l1ss + PCI_L1SS_CTL1,
>>>>>> +                                 &val);
>>>>>> +            val = val & ~PCI_L1SS_CTL1_L1SS_MASK;
>>>>>> +            pci_write_config_word(dev->bus->self,
>>>>>> +                                  dev->bus->self->l1ss + PCI_L1SS_CTL1,
>>>>>> +                                  val);
>>>>>> +
>>>>>> +            //configure parent
>>>>>> +            pcie_capability_clear_and_set_word(dev->bus->self,
>>>>>> +                                               PCI_EXP_LNKCTL,
>>>>>> +                                               PCI_EXP_LNKCTL_ASPMC, 0);
>>>>>> +
>>>>>> +            pci_read_config_word(dev->bus->self,
>>>>>> +                                 dev->bus->self->l1ss + PCI_L1SS_CTL1,
>>>>>> +                                 &val);
>>>>>> +            val = val & ~PCI_L1SS_CTL1_L1SS_MASK;
>>>>>> +            pci_write_config_word(dev->bus->self,
>>>>>> +                                  dev->bus->self->l1ss + PCI_L1SS_CTL1,
>>>>>> +                                  val);
>>>>>
>>>>> Updates the parent (dev->bus->self) twice; was the first one supposed
>>>>> to update the device (dev)?
>>>>>
>>>>> This doesn't restore the state as it existed before suspend.  Does
>>>>> this rely on other parts of restore to do that?
>>>>>
>>>>>> +    }
>>>>>> +}
>>>>>> +
>>>>>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_REALTEK, 0x8168,
>>>>>> +                     rtl8169_resume_aspm_settings);
>>>>>>  #endif
>>>>>>
>>>>>>  #ifdef CONFIG_PCIE_DPC
>>>>>> --
>>>>>> 2.45.2.803.g4e1b14247a-goog
>>>>>>
>>>>
>>


