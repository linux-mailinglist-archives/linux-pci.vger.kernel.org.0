Return-Path: <linux-pci+bounces-10801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7755493C915
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 21:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0352C1F24363
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 19:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD603CF4F;
	Thu, 25 Jul 2024 19:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVzcVsY4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0736014E2CC;
	Thu, 25 Jul 2024 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721936797; cv=none; b=QGFg1/FRkvHw4OpBApJbhsK2SPz6XZF98XGd4VItwgSJoBW/4Vxg2YtqdnlwljNiqv6wG21GO9Cl6iodgQyS49ZtJPmAp+3zg+9NncpylaFBdsGfg2j+qgoUngVsvyHi09LIJMxKDGea2QlAFVvvSBmZ3Bl2M2wyZ1KOdz9SUiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721936797; c=relaxed/simple;
	bh=rPAsZ7Or8Kt8DxD45QEXqWuot90hcLSkTjkd/6gYmfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGYsSM7kSqgSYsyO1u/N2Y2iRiGR4Fl/88GG1Hfp9n5j4R4T/eGpJwMOL/n5pQE1Wy7mD5mfmbIzYCLIIc4H7fPQTFaURKbCI5D+F91IY60Yz6GC8lALGn40/tBgBCuZydF1XRg+VFoDv943IHF0VkpZO26ZgMc5lXLEhyIJzRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVzcVsY4; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a9a369055so102648566b.3;
        Thu, 25 Jul 2024 12:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721936794; x=1722541594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zrmoflEai5L5Cs3bgyD3uw+UGfvG5jev2a2GOllSYIk=;
        b=fVzcVsY4QSS9qDN9e+hAXmDDIrk4rypNZiuS/dtpzEPqdW09Y+whUS8NQXNMHvZ/8a
         Uujx6m9sW5kueNA/+ip0yLXqVnYXbRX8O8CmX35fQkR/dC1SJYox7JQLeAwoMY4sOf7I
         toRGODF9jdT/GULOIWh3ycW6PhRL8Y8Oiu2uspyxczNqgpDDJjSgKXay1h5Tl9FAk+3y
         O10lujJbZd3p8hUsJ1IlR7spGNosYkm6wC7/aTuCPc7ARkdVxAsOmD9WowBGLhhSD77f
         YW3Xk5Mb2XqB58QZmJ8bJCJePmkXtad87lcu94IVkCTPb7+1H5+YRqfQlLr3vTNWAWz8
         yTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721936794; x=1722541594;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrmoflEai5L5Cs3bgyD3uw+UGfvG5jev2a2GOllSYIk=;
        b=MV+Z2HxBo1YlrRePicVrsYqZUxYNw+uHd1Gzrsk4VEFxojtzFmexlRz2oO9cLoknvM
         j/WuP9XtrpCezwSaZ/YXHxG2ul/ckVYf2ZNvkuTkWj5ryrEqjnGDuc4Ifv29kvWfB9Yd
         vDb+KwGb9zcnVY1nPgDsqymj4jaQuVuefr6XT2CTya2Ote55S/Gn0VZ6foz9POTrIZ+K
         7sIMVIXCFtgNPWsj6COIo9INs+cfFZwx+DACZklmz9lVZsbcB84wD7pIbZZZp5Jmz9dQ
         ZYpKJ6Ze11PoqHKQfaF1WjAsBJZGoOZavidv9MFgMu5V86YdUDhb/hPMALjJcQpWRnrB
         2b1g==
X-Forwarded-Encrypted: i=1; AJvYcCWnG3rsqILn8ohGgDrjVUtdWSyi3VB4x5DKdVZjKPhTL9gR4+57hxcqdXgXu7KcagxSl/i5ZKNXpS02uV+HaswKxFAjKN2JiMiRPFwsU1BAp5H04cRqvdJ9DnxiflGkUvWdvO78X4uufr36F8NHXfEa5Bk3x4PL4oct9yR33YT8
X-Gm-Message-State: AOJu0Yywn23tbk5ltwHe2puC1SG5rHfm8yTUFBxKkQFIQRuGPRh6LA1r
	h5oEBbmUpKbIixOby0OmrcmCXrDX9MK7vhdpUiLsGpDnz53CVWLo
X-Google-Smtp-Source: AGHT+IEhf7d0t9YZyU2cXcZlfEY84kZ3eTBaQh7vfkyhSSPNnJXUlSG8i5gceqy9liFP8S9VuxlurA==
X-Received: by 2002:a17:907:1b21:b0:a7a:aa35:4099 with SMTP id a640c23a62f3a-a7ac4ef1175mr255146266b.26.1721936793992;
        Thu, 25 Jul 2024 12:46:33 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c54e:e500:2050:c301:6d45:521d? (dynamic-2a01-0c23-c54e-e500-2050-c301-6d45-521d.c23.pool.telefonica.de. [2a01:c23:c54e:e500:2050:c301:6d45:521d])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a7acab23704sm103333466b.3.2024.07.25.12.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 12:46:33 -0700 (PDT)
Message-ID: <39b40ef8-b036-427e-9deb-b25bda61cb37@gmail.com>
Date: Thu, 25 Jul 2024 21:46:32 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: r8169: add suspend/resume aspm quirk
To: George-Daniel Matei <danielgeorgem@chromium.org>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nic_swsd@realtek.com, netdev@vger.kernel.org
References: <CACfW=qpNmSeQVG_qSeYpEdk9pf_RTAEEKp+OiBYrRFd3d6HOXg@mail.gmail.com>
 <20240710213837.GA257340@bhelgaas>
 <CACfW=qqPmiV6ez8Gf6GT6jyN5JEvF=mVeAqckWYVycsRuD746w@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <CACfW=qqPmiV6ez8Gf6GT6jyN5JEvF=mVeAqckWYVycsRuD746w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25.07.2024 14:56, George-Daniel Matei wrote:
> On Wed, Jul 10, 2024 at 11:38 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> On Wed, Jul 10, 2024 at 05:09:08PM +0200, George-Daniel Matei wrote:
>>>>> Added aspm suspend/resume hooks that run
>>>>> before and after suspend and resume to change
>>>>> the ASPM states of the PCI bus in order to allow
>>>>> the system suspend while trying to prevent card hangs
>>>>
>>>> Why is this needed?  Is there a r8169 defect we're working around?
>>>> A BIOS defect?  Is there a problem report you can reference here?
>>>
>>> We encountered this issue while upgrading from kernel v6.1 to v6.6.
>>> The system would not suspend with 6.6. We tracked down the problem to
>>> the NIC of the device, mainly that the following code was removed in
>>> 6.6:
>>>
>>>> else if (tp->mac_version >= RTL_GIGA_MAC_VER_46)
>>>>         rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
>>>
>>> For the listed devices, ASPM L1 is disabled entirely in 6.6. As for
>>> the reason, L1 was observed to cause some problems
>>> (https://bugzilla.kernel.org/show_bug.cgi?id=217814). We use a Raptor
>>> Lake soc and it won't change residency if the NIC doesn't have L1
>>> enabled. I saw in 6.1 the following comment:
>>
>> Can you verify that the problem still exists in a current kernel,
>> e.g., v6.9?
>>
> I tested it with v6.9, still the same problem.
> 
>> If this is a regression that's still present in v6.9, we need to
>> identify the commit that broke it.  Maybe it's 90ca51e8c654 ("r8169:
>> fix ASPM-related issues on a number of systems with NIC version from
>> RTL8168h")?
>>
> I also tried v6.9 with 90ca51e8c654 reverted and it works ok.
> 
>>>> Chips from RTL8168h partially have issues with L1.2, but seem
>>>> to work fine with L1 and L1.1.
>>>
>>> I was thinking that disabling/enabling L1.1 on the fly before/after
>>> suspend could help mitigate the risk associated with L1/L1.1 . I know
>>> that ASPM settings are exposed in sysfs and that this could be done
>>> from outside the kernel, that was my first approach, but it was
>>> suggested to me that this kind of workaround would be better suited
>>> for quirks. I did around 1000 suspend/resume cycles of 16-30 seconds
>>> each (correcting the resume dev->bus->self being configured twice
>>> mistake) and did not notice any problems. What do you think, is this a
>>> good approach ... ?
>>
>> Whatever the problem is, it definitely should be fixed in the kernel,
>> and Ilpo is right that it *should* be done in the PCI core ASPM
>> support (aspm.c) or at least with interfaces it supplies.
>>
> The problem is actually the system not being able to reach
> depper power saving states without certain ASPM states enabled.
> It was mentioned in the other thread replies that this kind of problem
> has been reported several times in the past.
> 
This is a known side effect of disabling ASPM L1 per default.
There isn't really something broken, the system just consumes some more
power. If this is an issue for you and ASPM L1 causes no issues on your
system, you can use sysfs to enable ASPM L1.

The general issue is that there are at least hundreds of combinations of
RTL8168 NICs, host chipsets, and BIOS versions. Several of these combinations
cause serious issues if ASPM L1 is enabled. It's just unknown which ones,
and why. Therefore ASPM L1 is disabled per default.


>> Generally speaking, drivers should not need to touch ASPM at all
>> except to work around hardware defects in their device, but r8169 has
>> a long history of weird ASPM stuff.  I dunno if that stuff is related
>> to hardware defects in the r8169 devices or if it is workarounds for
>> past or current defects in aspm.c.
>>
> What would be a good approach to move forward with this issue to
> get a fix approved?
> 
Propose a patch which fixes your power consumption issue and is guaranteed
not to have negative impact on any other user.

> Make a general version of this toggle workaround in the aspm core
> that would be controllable & configurable for each pci device individually?
> Keep the quirks and fix the aforementioned comments?
> 
>>>> This doesn't restore the state as it existed before suspend.  Does
>>>> this rely on other parts of restore to do that?
>>>
>>> It operates on the assumption that after driver initialization
>>> PCI_EXP_LNKCTL_ASPMC is 0 and that there are no states enabled in
>>> CTL1. I did a lspci -vvv dump on the affected devices before and after
>>> the quirks ran and saw no difference. This could be improved.
>>
>> Yep, we can't assume any of that because the PCI core owns ASPM
>> config, not the driver itself.
>>
>>>> What's the root cause of the issue?
>>>> A silicon bug on the host side?
>>>
>>> I think it's the ASPM implementation of the soc.
>>
>> As Heiner pointed out, if it's a SoC defect, it would potentially
>> affect all devices and a workaround would have to cover them all.
>>
>> Side note: oops, quoting error below, see note about top-posting here:
>> https://people.kernel.org/tglx/notes-about-netiquette
>>
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
>>> ...


