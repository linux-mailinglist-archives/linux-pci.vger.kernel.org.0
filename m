Return-Path: <linux-pci+bounces-10095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F41092D9AC
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 22:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63FA2B21476
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 19:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D5519645D;
	Wed, 10 Jul 2024 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6w3e/9f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1F58F66;
	Wed, 10 Jul 2024 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720641592; cv=none; b=aZNo14ye1Zw7KglOZl4tVwfy7wskLrPk0EwQSAbn/k4enfgMzvc08CvjVxxyPzNhkaVCz/Z5PUQ4zVXLc3/Tn1sF4654jH0sVZY/OH82Kv2ZXT4W0stt9JUzRNUopBLYi7sHzAFfjiiw7IMqPCzEniWN4MtE5/w7xLS0h16EmXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720641592; c=relaxed/simple;
	bh=WkPVwyn0LoVyZO7z27cw8hUOZZJ403dhHnfS18uo2aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NzqvceAvTQv6SsSzjYTAODoH4Y8tkglbJlPoWkzm3gXRnBbNbtM3Ys6a+EVGCkIE60R9m2HTPAfdnMylb+a7FhSZ4fbzq4TfLY4beDyNPVKxdlUaHI9K1wCoNIrP3nxxEYfoccY5XN45pZNYi34Hr10c8pIFHAX/bnxJrrWl6Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6w3e/9f; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52e99060b41so167125e87.2;
        Wed, 10 Jul 2024 12:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720641589; x=1721246389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PT1HixXcr8z7nRpwLuMtVLZrK80n3cEIK1PtuloxJHE=;
        b=F6w3e/9f7q0XSO388ES0K3LZokTg8qK82R+NviQviZn8W0G8xxPh1hEdJ3ERkZ9eA3
         bTqlbwj5KeMivXQJCFm9u6YI2ycaYca2o9faGIYfLLgnvdmv3GcB/TYRGEKIxnrvmoz1
         Y7TmRunwwEgQyB2ruLEPaWW1ZgfY0V7uD1RKuUgWW9cMXBhFtNBYDAb7n5QGhkRbnOxZ
         1QUUg05zijhDqxhyQepjC4Gyifj9cJLhFMMT0o3ZkgI2pl+MbkvdeSxxnEcBGurB8tya
         qvklr4b0yrfGLMK/VE7hJtAa6IGI06MPoO2Z/eu0ZYvpwKhBMkr5Ra7KBZBG3JzwJljw
         tXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720641589; x=1721246389;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PT1HixXcr8z7nRpwLuMtVLZrK80n3cEIK1PtuloxJHE=;
        b=QEAEYjTLQkiO6OrJHyjmQx79d6V4cuOXaTYBsShHUBekYV8m7S7xzhBLHb2sScoSka
         UoSRJEVpKh0xjcLOIIe/ax//x1spmddItLgLs9v/M2Fon7YCJfbw+Rf1kr89jK8MwVNx
         OA/2jkGPkQbLPM47EA7fm766EAPfhYu4f5tyKpr/JYUTWACqSkbpSmckBYMucuRbtZFH
         Cv3CrW4Wi5NUfX0zZGZF/0iau0U83BpVQGhWrEeNfMhh9+D2crfHh/MxQUeqSY20nU9Z
         BODn+/Q0/fmB++YkhWgj40N5fHQ3Vwe9lxfUxHi6UI8ljYeWFrN7O9cMER4B0x4HLi1w
         jlYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmnHH+ePZlNUMsSW/FkkymZOGNVh4Ge+9iT6vUcRET+hXd53M/jpcHS+/ot1lZsRcKo6qCr6iQsmhY7EGt2ip/H0RxUaIOM876HYl8kNWgq2OOszLXMqZXhrKE0MdF+Bgu17OZvEC+CDPfVPhAytGoucyks8GH84shSDM58LI/
X-Gm-Message-State: AOJu0YziZFUFbcgrhlLmNDKYNoOq4F4dQd1jVoRY1c671vjco3HThtSs
	0DiLgJTH/i0yZ3AEyuFKr8I6geaE+Dgxc3ZyLvOmBHKwGVqGFU1F
X-Google-Smtp-Source: AGHT+IG2nlfLQ3uwQYqpm4Pzv2NdZPS2dL6iNZQZsoHvoHR4i+Ihw3Tu1J2c1fdSx600R9ZZT4/I4w==
X-Received: by 2002:a05:6512:3b2c:b0:52e:933c:5a18 with SMTP id 2adb3069b0e04-52eb99d4e3amr4519531e87.56.1720641588247;
        Wed, 10 Jul 2024 12:59:48 -0700 (PDT)
Received: from ?IPV6:2a01:c23:b82f:e400:5138:e661:a9e3:8063? (dynamic-2a01-0c23-b82f-e400-5138-e661-a9e3-8063.c23.pool.telefonica.de. [2a01:c23:b82f:e400:5138:e661:a9e3:8063])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a780a85459fsm182478566b.160.2024.07.10.12.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 12:59:47 -0700 (PDT)
Message-ID: <edf2a0aa-d027-489f-891f-254849a47c60@gmail.com>
Date: Wed, 10 Jul 2024 21:59:50 +0200
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
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <CACfW=qpNmSeQVG_qSeYpEdk9pf_RTAEEKp+OiBYrRFd3d6HOXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10.07.2024 17:09, George-Daniel Matei wrote:
> Hi,
> 
>>> Added aspm suspend/resume hooks that run
>>> before and after suspend and resume to change
>>> the ASPM states of the PCI bus in order to allow
>>> the system suspend while trying to prevent card hangs
>>
>> Why is this needed?  Is there a r8169 defect we're working around?
>> A BIOS defect?  Is there a problem report you can reference here?
>>
> 
> We encountered this issue while upgrading from kernel v6.1 to v6.6.
> The system would not suspend with 6.6. We tracked down the problem to
> the NIC of the device, mainly that the following code was removed in
> 6.6:
>> else if (tp->mac_version >= RTL_GIGA_MAC_VER_46)
>>         rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
> For the listed devices, ASPM L1 is disabled entirely in 6.6. As for
> the reason, L1 was observed to cause some problems
> (https://bugzilla.kernel.org/show_bug.cgi?id=217814). We use a Raptor
> Lake soc and it won't change residency if the NIC doesn't have L1
> enabled. I saw in 6.1 the following comment:

With residency you refer to the package power saving state?

>> Chips from RTL8168h partially have issues with L1.2, but seem
>> to work fine with L1 and L1.1.
> I was thinking that disabling/enabling L1.1 on the fly before/after
> suspend could help mitigate the risk associated with L1/L1.1 . I know
> that ASPM settings are exposed in sysfs and that this could be done
> from outside the kernel, that was my first approach, but it was
> suggested to me that this kind of workaround would be better suited
> for quirks. I did around 1000 suspend/resume cycles of 16-30 seconds
> each (correcting the resume dev->bus->self being configured twice
> mistake) and did not notice any problems. What do you think, is this a
> good approach ... ?
> 
If the root cause really should be in the SoC's ASPM implementation, then:
- Other systems with the same SoC may suffer from the same problem,
  but are not covered by the quirk.
- The issue may occur also with other devices than a RTL8168 NIC.
  How about e.g. RTL8125? Or completely different PCI devices?

What I understand so far from your description:

W/o ASPM L1 the SoC doesn't change "residency". See comment above,
please elaborate on this.
And w/ ASPM L1 the NIC hangs on suspend?
What's the dmesg entries related to this hang? Tx timeout?
Or card not accessible at all?

My perspective so far:
It's a relatively complex quirk that covers only a part of the potentially
affected systems, and the issue isn't well understood.

And most likely there are lots of systems out there with a Raptor Lake CPU
and a RTL8168 on board. Therefore it's surprising that there hasn't been
a similar report before.


>>> +             //configure device
>>> +             pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
>>> +                                                PCI_EXP_LNKCTL_ASPMC, 0);
>>> +
>>> +             pci_read_config_word(dev->bus->self,
>>> +                                  dev->bus->self->l1ss + PCI_L1SS_CTL1,
>>> +                                  &val);
>>> +             val = val & ~PCI_L1SS_CTL1_L1SS_MASK;
>>> +             pci_write_config_word(dev->bus->self,
>>> +                                   dev->bus->self->l1ss + PCI_L1SS_CTL1,
>>> +                                   val);
>> Updates the parent (dev->bus->self) twice; was the first one supposed
>> to update the device (dev)?
> Yes, it was supposed to update the device (dev). It's my first time
> sending a patch and I messed something up while doing some style
> changes, I will correct it. I'm sorry for that.
> 
>> This doesn't restore the state as it existed before suspend.  Does
>> this rely on other parts of restore to do that?
> It operates on the assumption that after driver initialization
> PCI_EXP_LNKCTL_ASPMC is 0 and that there are no states enabled in
> CTL1. I did a lspci -vvv dump on the affected devices before and after
> the quirks ran and saw no difference. This could be improved.
> 
>> What is the RTL8168 chip version used on these systems?
> It should be RTL8111H.
> 
>> What's the root cause of the issue?
>> A silicon bug on the host side?
> I think it's the ASPM implementation of the soc.
> 
>> ASPM L1 is disabled per default in r8169. So why is the patch needed
>> at all?
> Leaving it disabled all the time prevents the system from suspending.
> 
This is not clear to me. You refer to STR?
Why should a system not suspend just because one PCI device doesn't
have ASPM L1 enabled?

> Thank you,
> George-Daniel Matei
> 
> 
> 
> 
> 
> On Tue, Jul 9, 2024 at 12:15 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 08.07.2024 19:23, Bjorn Helgaas wrote:
>>> [+cc r8169 folks]
>>>
>>> On Mon, Jul 08, 2024 at 03:38:15PM +0000, George-Daniel Matei wrote:
>>>> Added aspm suspend/resume hooks that run
>>>> before and after suspend and resume to change
>>>> the ASPM states of the PCI bus in order to allow
>>>> the system suspend while trying to prevent card hangs
>>>
>>> Why is this needed?  Is there a r8169 defect we're working around?
>>> A BIOS defect?  Is there a problem report you can reference here?
>>>
>>
>> Basically the same question from my side. Apparently such a workaround
>> isn't needed on any other system. And Realtek NICs can be found on more
>> or less every consumer system. What's the root cause of the issue?
>> A silicon bug on the host side?
>>
>> What is the RTL8168 chip version used on these systems?
>>
>> ASPM L1 is disabled per default in r8169. So why is the patch needed
>> at all?
>>
>>> s/Added/Add/
>>>
>>> s/aspm/ASPM/ above
>>>
>>> s/PCI bus/device and parent/
>>>
>>> Add period at end of sentence.
>>>
>>> Rewrap to fill 75 columns.
>>>
>>>> Signed-off-by: George-Daniel Matei <danielgeorgem@chromium.org>
>>>> ---
>>>>  drivers/pci/quirks.c | 142 +++++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 142 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>> index dc12d4a06e21..aa3dba2211d3 100644
>>>> --- a/drivers/pci/quirks.c
>>>> +++ b/drivers/pci/quirks.c
>>>> @@ -6189,6 +6189,148 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b0, aspm_l1_acceptable_latency
>>>>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency);
>>>>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
>>>>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
>>>> +
>>>> +static const struct dmi_system_id chromebox_match_table[] = {
>>>> +    {
>>>> +            .matches = {
>>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Brask"),
>>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>>>> +            }
>>>> +    },
>>>> +    {
>>>> +            .matches = {
>>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Aurash"),
>>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>>>> +            }
>>>> +    },
>>>> +            {
>>>> +            .matches = {
>>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Bujia"),
>>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>>>> +            }
>>>> +    },
>>>> +    {
>>>> +            .matches = {
>>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Gaelin"),
>>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>>>> +            }
>>>> +    },
>>>> +    {
>>>> +            .matches = {
>>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Gladios"),
>>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>>>> +            }
>>>> +    },
>>>> +    {
>>>> +            .matches = {
>>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Hahn"),
>>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>>>> +            }
>>>> +    },
>>>> +    {
>>>> +            .matches = {
>>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Jeev"),
>>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>>>> +            }
>>>> +    },
>>>> +    {
>>>> +            .matches = {
>>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Kinox"),
>>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>>>> +            }
>>>> +    },
>>>> +    {
>>>> +            .matches = {
>>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Kuldax"),
>>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>>>> +            }
>>>> +    },
>>>> +    {
>>>> +            .matches = {
>>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Lisbon"),
>>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>>>> +            }
>>>> +    },
>>>> +    {
>>>> +                    .matches = {
>>>> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Moli"),
>>>> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>>>> +            }
>>>> +    },
>>>> +    { }
>>>> +};
>>>> +
>>>> +static void rtl8169_suspend_aspm_settings(struct pci_dev *dev)
>>>> +{
>>>> +    u16 val = 0;
>>>> +
>>>> +    if (dmi_check_system(chromebox_match_table)) {
>>>> +            //configure parent
>>>> +            pcie_capability_clear_and_set_word(dev->bus->self,
>>>> +                                               PCI_EXP_LNKCTL,
>>>> +                                               PCI_EXP_LNKCTL_ASPMC,
>>>> +                                               PCI_EXP_LNKCTL_ASPM_L1);
>>>> +
>>>> +            pci_read_config_word(dev->bus->self,
>>>> +                                 dev->bus->self->l1ss + PCI_L1SS_CTL1,
>>>> +                                 &val);
>>>> +            val = (val & ~PCI_L1SS_CTL1_L1SS_MASK) |
>>>> +                  PCI_L1SS_CTL1_PCIPM_L1_2 | PCI_L1SS_CTL1_PCIPM_L1_2 |
>>>> +                  PCI_L1SS_CTL1_ASPM_L1_1;
>>>> +            pci_write_config_word(dev->bus->self,
>>>> +                                  dev->bus->self->l1ss + PCI_L1SS_CTL1,
>>>> +                                  val);
>>>> +
>>>> +            //configure device
>>>> +            pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
>>>> +                                               PCI_EXP_LNKCTL_ASPMC,
>>>> +                                               PCI_EXP_LNKCTL_ASPM_L1);
>>>> +
>>>> +            pci_read_config_word(dev, dev->l1ss + PCI_L1SS_CTL1, &val);
>>>> +            val = (val & ~PCI_L1SS_CTL1_L1SS_MASK) |
>>>> +                  PCI_L1SS_CTL1_PCIPM_L1_2 | PCI_L1SS_CTL1_PCIPM_L1_2 |
>>>> +                  PCI_L1SS_CTL1_ASPM_L1_1;
>>>> +            pci_write_config_word(dev, dev->l1ss + PCI_L1SS_CTL1, val);
>>>> +    }
>>>> +}
>>>> +
>>>> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_REALTEK, 0x8168,
>>>> +                      rtl8169_suspend_aspm_settings);
>>>> +
>>>> +static void rtl8169_resume_aspm_settings(struct pci_dev *dev)
>>>> +{
>>>> +    u16 val = 0;
>>>> +
>>>> +    if (dmi_check_system(chromebox_match_table)) {
>>>> +            //configure device
>>>> +            pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
>>>> +                                               PCI_EXP_LNKCTL_ASPMC, 0);
>>>> +
>>>> +            pci_read_config_word(dev->bus->self,
>>>> +                                 dev->bus->self->l1ss + PCI_L1SS_CTL1,
>>>> +                                 &val);
>>>> +            val = val & ~PCI_L1SS_CTL1_L1SS_MASK;
>>>> +            pci_write_config_word(dev->bus->self,
>>>> +                                  dev->bus->self->l1ss + PCI_L1SS_CTL1,
>>>> +                                  val);
>>>> +
>>>> +            //configure parent
>>>> +            pcie_capability_clear_and_set_word(dev->bus->self,
>>>> +                                               PCI_EXP_LNKCTL,
>>>> +                                               PCI_EXP_LNKCTL_ASPMC, 0);
>>>> +
>>>> +            pci_read_config_word(dev->bus->self,
>>>> +                                 dev->bus->self->l1ss + PCI_L1SS_CTL1,
>>>> +                                 &val);
>>>> +            val = val & ~PCI_L1SS_CTL1_L1SS_MASK;
>>>> +            pci_write_config_word(dev->bus->self,
>>>> +                                  dev->bus->self->l1ss + PCI_L1SS_CTL1,
>>>> +                                  val);
>>>
>>> Updates the parent (dev->bus->self) twice; was the first one supposed
>>> to update the device (dev)?
>>>
>>> This doesn't restore the state as it existed before suspend.  Does
>>> this rely on other parts of restore to do that?
>>>
>>>> +    }
>>>> +}
>>>> +
>>>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_REALTEK, 0x8168,
>>>> +                     rtl8169_resume_aspm_settings);
>>>>  #endif
>>>>
>>>>  #ifdef CONFIG_PCIE_DPC
>>>> --
>>>> 2.45.2.803.g4e1b14247a-goog
>>>>
>>


