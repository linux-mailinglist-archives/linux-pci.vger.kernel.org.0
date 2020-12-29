Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391242E7414
	for <lists+linux-pci@lfdr.de>; Tue, 29 Dec 2020 22:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgL2VMs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Dec 2020 16:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgL2VMs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Dec 2020 16:12:48 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C59C061574;
        Tue, 29 Dec 2020 13:12:07 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g185so3188985wmf.3;
        Tue, 29 Dec 2020 13:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4mHNemyOfscvaU8R99Sk6yC2Ggh4qR4nC+SRwDGjXso=;
        b=e3DSjdyejvhyU++ZEtl4xvqynyI6VM67yYHE/yC7HBnGQ3S65b43Bbw9WqqyXi1xqu
         hEIHEEGw+364QcN4O06tqNKaCHqPYLgrB4cnTYVIk9prV/6KGvQJjLO0y/eKMPzaSAkl
         8Okh0JD3MkP3L47zvgEK3TgT/VIdQmCnw4gCcOm+jSC+7kpeZr1aOz7WiMAja4URKdr+
         Z8/ZZJiXzlOaZs58vBVTJEaAEQQqqz8Jtfn0DGTyr3Dg7wAKsQhUFtHIKH6h0+SkR1/d
         rzy3Wn262PyS3YNPv6CIfK4bLfzkLyiwkPff6v3uHdpdfQfwejDQ0DjkZgVmaRCrcTKw
         WUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4mHNemyOfscvaU8R99Sk6yC2Ggh4qR4nC+SRwDGjXso=;
        b=VvjOkTVxrb4osGr7lIzf4V6HyM+cx2FCcPdh8pLnZZ59s1nIUpncDVbMlKMgm/cIK+
         jXYi8tggqBm+NhYfhKlPPY7luUkbeH+by+t3eJPQL9TO8VFHDcwuGenm/8GUYLHM0o5T
         BRQjx0OOzoszAzMqxkB80AHECGYKErsAVufTKRMSOm4BHfn6mYx6XXaif4ZaBG6LgQFt
         obtWfHO2GhTvMap4KXajmW1EI3Pq21Qtj5YFagXAqgdKwgc+Z71Nli2ZDiwS11jFFxQ8
         Z8hNlG79XeGlsPEGlCfKV9UMPaXXoH1mNh9WKVi8s+4meZKpcEv5WHdMIYFmsu9W85Cu
         mD4Q==
X-Gm-Message-State: AOAM532Ag48hB+NKaFPLcKyKpQTnRehEZ2ZGgCVawuB2xWqsADegsAlm
        xTjwRXHXMwHY+5maJ8EA3PBkxY1zggQ=
X-Google-Smtp-Source: ABdhPJyL+zrZtcuOu3XW55L1+hTA5AAQDDQCJe6JIfz2aPPu+MbWRCHRouL0RFNfbdpmcSkshbCXqg==
X-Received: by 2002:a1c:40d6:: with SMTP id n205mr5054917wma.0.1609276324850;
        Tue, 29 Dec 2020 13:12:04 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:c925:14e6:c62b:f4d3? (p200300ea8f065500c92514e6c62bf4d3.dip0.t-ipconnect.de. [2003:ea:8f06:5500:c925:14e6:c62b:f4d3])
        by smtp.googlemail.com with ESMTPSA id p8sm60293313wru.50.2020.12.29.13.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 13:12:04 -0800 (PST)
Subject: Re: Time to re-enable Runtime PM per default for PCI devcies?
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <79940973-b631-90f9-dbc4-9579c6000816@gmail.com>
 <20201117163817.GA1397220@bjorn-Precision-5520>
 <CAJZ5v0ipMJ1gCB7okpROG_yAUi5Q8LknqeH+Jpdrjbb4D_vfuQ@mail.gmail.com>
 <b7bf02fd-c1aa-f430-524e-98922041ed81@gmail.com>
 <CAAd53p43tMEk3b-BUUW1_rxFPo9zr3ZYqpSrLYddxBk_U=aw2g@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <02216a23-067a-03aa-4663-b8f64e8ec78e@gmail.com>
Date:   Tue, 29 Dec 2020 22:11:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAAd53p43tMEk3b-BUUW1_rxFPo9zr3ZYqpSrLYddxBk_U=aw2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29.12.2020 12:56, Kai-Heng Feng wrote:
> On Sat, Dec 26, 2020 at 11:26 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 17.11.2020 17:57, Rafael J. Wysocki wrote:
>>> On Tue, Nov 17, 2020 at 5:38 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>
>>>> [+to Rafael, author of the commit you mentioned,
>>>> +cc Mika, Kai Heng, Lukas, linux-pm, linux-kernel]
>>>>
>>>> On Tue, Nov 17, 2020 at 04:56:09PM +0100, Heiner Kallweit wrote:
>>>>> More than 10 yrs ago Runtime PM was disabled per default by bb910a7040
>>>>> ("PCI/PM Runtime: Make runtime PM of PCI devices inactive by default").
>>>>>
>>>>> Reason given: "avoid breakage on systems where ACPI-based wake-up is
>>>>> known to fail for some devices"
>>>>> Unfortunately the commit message doesn't mention any affected  devices
>>>>> or systems.
>>>
>>> Even if it did that, it wouldn't have been a full list almost for sure.
>>>
>>> We had received multiple problem reports related to that, most likely
>>> because the ACPI PM in BIOSes at that time was tailored for
>>> system-wide PM transitions only.
>>>
>>
>> To follow up on this discussion:
>> We could call pm_runtime_forbid() conditionally, e.g. with the following
>> condition. This would enable runtime pm per default for all non-ACPI
>> systems, and it uses the BIOS date as an indicator for a hopefully
>> not that broken ACPI implementation. However I could understand the
>> argument that this looks a little hacky ..
>>
>> if (IS_ENABLED(CONFIG_ACPI) && dmi_get_bios_year() <= 2016)
> 
> dmi_get_bios_year() may not be a good indicator. Last time I used it
> caused regression, because the value changed after BIOS update.
> For example, my MacBook Pro is manufactured in 2011, but
> dmi_get_bios_year() returns 2018 with latest BIOS.
> 
Right, it's a weak indicator, and I'm aware of it. My thought is:
A massively broken ACPI implementation would have been fixed over
time if there are years between manufacturing date and last BIOS
update. Of course this doesn't have to be true ..

I just had a look at the ACPI spec and maybe we could use the ACPI
version information (major.minor) in the FADT table. E.g. we could
enable runtime pm from version 6.0. That should be reasonable new.
I'm open for any other proposals ..
 
> Kai-Heng
> 
>>
>>
>>
>>>>> With Runtime PM disabled e.g. the PHY on network devices may remain
>>>>> powered up even with no cable plugged in, affecting battery lifetime
>>>>> on mobile devices. Currently we have to rely on the respective distro
>>>>> or user to enable Runtime PM via sysfs (echo auto > power/control).
>>>>> Some devices work around this restriction by calling pm_runtime_allow
>>>>> in their probe routine, even though that's not recommended by
>>>>> https://www.kernel.org/doc/Documentation/power/pci.txt
>>>>>
>>>>> Disabling Runtime PM per default seems to be a big hammer, a quirk
>>>>> for affected devices / systems may had been better. And we still
>>>>> have the option to disable Runtime PM for selected devices via sysfs.
>>>>>
>>>>> So, to cut a long story short: Wouldn't it be time to remove this
>>>>> restriction?
>>>>
>>>> I don't know the history of this, but maybe Rafael or the others can
>>>> shed some light on it.
>>>
>>> The systems that had those problems 10 years ago would still have
>>> them, but I expect there to be more systems where runtime PM can be
>>> enabled by default for PCI devices without issues.
>>>
>>

