Return-Path: <linux-pci+bounces-10391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A67D89331CF
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 21:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2141FB213D4
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 19:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CDC1A0710;
	Tue, 16 Jul 2024 19:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faL0ZqvU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFF31A01DE;
	Tue, 16 Jul 2024 19:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721157943; cv=none; b=PvhOSbd83XTzFRNasUomhfQWbX6VknN/wfL9UjmaeZ0G50LrxMy61Hw7dWXV8eXp51WQ+XJH7fGNETI83h1Izc50qlDVasS28/vHedeh3B6IBvrugLw0HqyyQwmmFnKMzdSs2f//5chlFMqPvWuDbSPUsCrKUN7MRt7BlQr0MIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721157943; c=relaxed/simple;
	bh=Oy9orJQlnzmosURdz4u2TBCFQUqY3pnr54riaR8Qfuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1OAQw60hZzOFV166i3XB0oedprwiSKsV4AhJxzvvm1mGZ17/zYiTROvLZ40pkDsx+XoIuTr8sVdSv6Mrqss7/DmA668sQrPy5uXiQhxxQUB6YnER7bdv04xO7wobYUKKYtDZUITcCSZfILAywKQ7RXecXq6vasw64QdarN04IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faL0ZqvU; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso721562266b.0;
        Tue, 16 Jul 2024 12:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721157940; x=1721762740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mbmokd8A3LcVExoMw0BoXVJBkxw3JiYS/bqgbqiIm6M=;
        b=faL0ZqvUpVpnPdGBEE3c9ivMvEHcEns0NYvUAkeWb+SUFMY0s8unVwALBDIOMOvq6v
         bMvZ/WNxOS7Npo1M+D3Ljj7tyNbmDhaiTZNdz8VpBMoFucr25Fa8aSSrpPR2TA/171Rr
         I0XhII4aDQ7ODoAg5BnnS2byuVpJdo359psfhjyZg50iyfM+jZH55unWmf7/YNnUIrpQ
         avUKarYM0+wnW6h4VbF6Q6oZNNakXFlZLKBa32PGjve4zDWLhUGz66mEG7a4zWsUrkh3
         luzWrI6sEEcw8F8Yo07vns1lQNPxhemwe7bsuSrriRA1wDlTe+ZtSBF8BBWgARSh2/p2
         8Q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721157940; x=1721762740;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbmokd8A3LcVExoMw0BoXVJBkxw3JiYS/bqgbqiIm6M=;
        b=FI90EUneyJJ/3UxivnQjjqSxR8hlc9zuii/Webq1qDMnuDJGIDh/Ic0IjGuBbIAqjC
         NfGaoo3IUOWp9nMK8oeZAErMPqdA0kCUltpd4zLmYglYB3VHWOH39nfiLd35rDlsk+RT
         NmervLbWTzkQEAsk/zEK6WX+NPY127eFJQ1PT+ghevbrQoUaEjQFMjEPTpQjdNEjGgCP
         yCjmEPNEPoW+1BGbVaZClCSrea89RSlkQxrEeCbZTENwLLBgDRJijJnRJlMoOmy5lzlX
         8oXGDqw5Hu7haGi76+NnLxrUE5sOvV5SbNhlq8uZDYtE+b+7YDvXOFCeE2dGLKQinNJq
         3PZg==
X-Forwarded-Encrypted: i=1; AJvYcCWS4TRhv2rhJ3TkDIe1RuRZ+4fKWDyPNlh9vBk33MkW4ycvp7Wq7pAOh07fCmfyWBuLzpEdkRoFaRjB//kraaeUYXrW5J/KRVlrgTC4tneCeR9F1/PmKsqtgq8hZXAdpPGh5tiJtRjOTWTktyoASFNKAvfPLfH1ueNdanQcV/P2
X-Gm-Message-State: AOJu0Yz4heMA9GeYMV0R5FQTyg3mLpw5gbAYXZKDlOpXLtkNuuRvhN7P
	8BtgvIlHlshh67L2iIVcVNYR5IJp3MccPMKFL+88nCuP4TFV6mRU
X-Google-Smtp-Source: AGHT+IFmW6F+kPS5eVF31Cuhh854bQynqQvfDAwz33W1cxly0W7Q+2Tg1bLG1S9fS3lQyMIrwpYz2A==
X-Received: by 2002:a17:906:2cc7:b0:a77:e0ed:8c4 with SMTP id a640c23a62f3a-a79ea3ebe2amr191310466b.7.1721157939325;
        Tue, 16 Jul 2024 12:25:39 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7287:1c00:f14f:4022:635f:3750? (dynamic-2a01-0c22-7287-1c00-f14f-4022-635f-3750.c22.pool.telefonica.de. [2a01:c22:7287:1c00:f14f:4022:635f:3750])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a79bc5a3560sm351579966b.4.2024.07.16.12.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 12:25:38 -0700 (PDT)
Message-ID: <3e0e1ceb-9da8-4227-8964-04e891c1d9e3@gmail.com>
Date: Tue, 16 Jul 2024 21:25:40 +0200
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
 <ad0d1201-1fe1-4170-8cfa-d23e74ef8bfd@gmail.com>
 <CACfW=qrCrXM6Et=Yafug00pbYZzifhVGLhdLMsdYiYXSh=tGFA@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <CACfW=qrCrXM6Et=Yafug00pbYZzifhVGLhdLMsdYiYXSh=tGFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16.07.2024 14:13, George-Daniel Matei wrote:
> On Thu, Jul 11, 2024 at 7:45 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
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
>>>>         rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);1
>>
>> With this (older) 6.1 version everything is ok?
>> Would mean that L1.1 is active and the system suspends (STR?) properly
>> also with L1.1 being active.
>>
> Yes, with 6.1 everything was ok. L1 was active and just the L1.1 substate
> was enabled, L1.2 was disabled.
> 
>> Under 6.6 per default L1 (incl. sub-states) is disabled.
>> Then you manually enable L1 (incl. L1.1, but not L1.2?) via sysfs,
>> and now the system hangs on suspend?
>>
> Yes, in 6.6 L1 (+substates) is disabled. Like Bjorn mentioned, I
> think that is because of 90ca51e8c654 ("r8169:
> fix ASPM-related issues on a number of systems with NIC version from
> RTL8168h". With L1 disabled the system would not suspend so I enabled
> back L1 along with just L1.1 substate through sysfs, just to test, and
> saw that the system could

It still sounds very weird that a system does not suspend to ram
just because ASPM L1 is disabled for a single device.
What if a PCI device is used which doesn't support ASPM?

Which subsystem fails to suspend? Can you provide a log showing
the suspend error?

> suspend again.  L1 is disabled by default for a reason, that's because
> it could cause tx timeouts. So to try to work around the possible timeouts
> I thought  of changing the ASPM states before suspending and then
> restoring on resume.
> 
>> Is this what you're saying? Would be strange because in both cases
>> L1.1 is active when suspending.
>>
>>
>>> For the listed devices, ASPM L1 is disabled entirely in 6.6. As for
>>> the reason, L1 was observed to cause some problems
>>> (https://bugzilla.kernel.org/show_bug.cgi?id=217814). We use a Raptor
>>> Lake soc and it won't change residency if the NIC doesn't have L1
>>> enabled. I saw in 6.1 the following comment:
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


