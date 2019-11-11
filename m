Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C080EF6E56
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 07:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfKKGBa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 01:01:30 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15818 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfKKGBa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Nov 2019 01:01:30 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dc8f93a0001>; Sun, 10 Nov 2019 22:01:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 10 Nov 2019 22:01:28 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 10 Nov 2019 22:01:28 -0800
Received: from [10.25.73.138] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 Nov
 2019 06:01:22 +0000
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Sinan Kaya <okaya@kernel.org>, Thierry Reding <treding@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>,
        "Andrew Murray" <andrew.murray@arm.com>,
        Lukas Wunner <lukas@wunner.de>
References: <20191106164148.GA62969@google.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <71f545f7-f14a-d2d9-215c-b3fb22000a5c@nvidia.com>
Date:   Mon, 11 Nov 2019 11:31:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191106164148.GA62969@google.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573452091; bh=WLOQh27QmA+OsuL699D/PX2bBeHem2WDXG3t9hPLNHs=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=awvhqrvlsvIEaHXXkNqwVO/M/XOaIOoXbuaFQJ6cC6HsnRAdCWR97HQ/n4zuwFC99
         GBComktxTO9QXvMBJt8sPdJ3B6zdCALBF+IgAapRshAZeXBzkESc0k7zlb8dy4vZla
         TUMjjeheLubzjJrbXtC4EKQ2KUiDeZtiXGNjkDX63PFgJZ5ttCSeJ7wDxe4CZNY7ZV
         aqWz1EtaKDoRmmV/Z6Fc9J48GE0ktP6llC9EPMcclDqQqaaiKiRrWSd4ZPsVVHNKe2
         rNGQF0t9vRfM+mWyc4zepfDAtUD9MKdZI2U0T1MT1WWLy+tP1zUWviQHFfVVIAhTuj
         HjpEvtIGvk2pQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/6/2019 10:11 PM, Bjorn Helgaas wrote:
> On Tue, Nov 05, 2019 at 11:55:45AM +0100, Rafael J. Wysocki wrote:
>> On Monday, November 4, 2019 6:39:04 PM CET Bjorn Helgaas wrote:
>>> [+cc Andrew, Lukas]
>>>
>>> On Tue, Oct 15, 2019 at 05:44:47PM +0530, Vidya Sagar wrote:
>>>> On 10/15/2019 4:40 PM, Sinan Kaya wrote:
>>>>> ...
>>>>> I think the PCI core should be putting the device back D0 state as one
>>>>> of the first actions before enumerating. Wake up could be a combination
>>>>> of ACPI and/or PCI wake up depending on where your device sits in the
>>>>> topology.
>>>>
>>>> Yup. It is indeed doing it as part of pci_power_up() in pci.c file.
>>>> But, what is confusing to me is the order of the calls.
>>>> pci_power_up() has following calls in the same order.
>>>> 	pci_raw_set_power_state(dev, PCI_D0);
>>>> 	pci_update_current_state(dev, PCI_D0);
>>>> But, pci_raw_set_power_state() is accessing config space without calling
>>>> pci_device_is_present() whereas pci_update_current_state() which is called
>>>> later in the flow is calling pci_device_is_present()...!
>>>
>>> A device should always respond to config reads unless it is in D3cold
>>> or it is initializing after a reset.  IIUC you're doing a resume, not
>>> a reset, so I think your device must be coming out of D3cold.  That's
>>> typically done via ACPI, and I think we are missing some kind of delay
>>> before our first config access:
>>>
>>>    pci_power_up
>>>      platform_pci_set_power_state(PCI_D0)    # eg, ACPI
>>>      pci_raw_set_power_state
>>>        pci_read_config_word(PCI_PM_CTRL)     # <-- first config access
>>>        pci_write_config_word(PCI_PM_CTRL)
>>>        pci_read_config_word(PCI_PM_CTRL)
>>>      pci_update_current_state
>>>        if (... || !pci_device_is_present())
>>>
>>> Mika is working on some delays for the transition out of D3cold [1].
>>> He's more concerned with a secondary bus behind a bridge, so I don't
>>> think his patch addresses this case, but he's certainly familiar with
>>> this area.
>>>
>>> Huh, I'm really confused about this, too.  I don't
>>> understand how resume ever works without any delay between
>>> platform_pci_power_manageable() and the config reads in
>>> pci_raw_set_power_state().  I must be missing something.
>>
>> There is a delay in the runtime_d3cold case, see
>> __pci_start_power_transition().
> 
> I see the delay in __pci_start_power_transition(), but I don't see how
> it's relevant.  It's only called by pci_set_power_state(), and while
> many drivers call pci_set_power_state() from legacy .resume() methods,
> the pci_pm_resume_noirq() path where Vidya is seeing problems doesn't
> use it.
> 
>> But overall platform_pci_power_manageable() only checks whether or
>> not the platform firmware can change the power state of the device.
>> If it can, it is expected to take care of any necessary delays while
>> doing that (because there may be delays required by this particular
>> instance of the platform firmware, beyond what is mandated by the
>> PCI spec, or there may not be any need to wait at all). ...
> 
> That sounds like a reasonable argument for why firmware should be
> responsible for this delay, but I don't think that's very clear in the
> ACPI spec, so I wouldn't be surprised if it got missed.
> 
> Based on Vidya's backtrace, I think the resume path with problems is
> this:
> 
>    pci_pm_resume_noirq
>      pci_pm_default_resume_early
>        pci_power_up
>          if (platform_pci_power_manageable(dev))
>            platform_pci_set_power_state(dev, PCI_D0)  # <-- FW delay here?
>          pci_raw_set_power_state
>          pci_update_current_state
>            pci_device_is_present        # <-- config read returns CRS
> 
> So I think your suggestion is that Vidya's firmware should be doing
> the delay inside platform_pci_set_power_state()?
> 
> Vidya, you typically work on Tegra, so I assume this is on an arm64
> system?  Does it have ACPI?  Do you have access to the firmware
> developers to ask about who they expect to do the delays?
Yes. This is on arm64 (Tegra) and we don't have any ACPI or any other firmware
for that matter. PCIe is brought up directly in the kernel.

> 
>> In any case, I'm not sure how useful it is to add delays for
>> everyone in the cases in which a specific system needs a delay
>> because of its own PM implementation limitations.  It may be better
>> to quirk such systems explicitly as long as there are not too many
>> quirks in there, or we'll end up adding more and more *implicit*
>> quirks in the form of general delays.
> 
> I agree, a general delay doesn't sound good.  Are you thinking
> something like this?
> 
>    void pci_power_up(struct pci_dev *dev)
>    {
>      if (platform_pci_power_manageable(dev)) {
>        platform_pci_set_power_state(dev, PCI_D0);
>        if (dev->XXX)
>          msleep(dev->XXX);
>      }
>      ...
> 
> We already have dev->d3_delay and d3cold_delay, so it's getting a bit
> messy to keep them all straight.
> 
> Bjorn
> 

