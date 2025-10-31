Return-Path: <linux-pci+bounces-39933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6662C2547B
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 14:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4282B40604E
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 13:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799E8221577;
	Fri, 31 Oct 2025 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Mv5qOTdj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com [209.85.166.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DED220F2A
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761917891; cv=none; b=A7gBZa+om0xCrqwbUa0RofIiXiHH2ZFkgbn2bD67jnrpAGBDfnJ0pk+o/Zn5aVxq/wcNG4lHIUNMcr6kQCjZYD+WmEQNPnLiERcdUru2glbmpX4GXrMjSX/5+rH2tB2GIqKucppmp1RW4R2pXFV567vmBiq4j3pYZTM9r73D5qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761917891; c=relaxed/simple;
	bh=0VQdKp3Jr+HY34bWezsEjwJjWZHNfdtg/4c7OLz3/mY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mrnA63wvuF0HLKsfkIhlhpvgBloQn7evAOySzwkk2SeJ5hwy8Fl980TPPRX+S5PPY7V+ra1aMAa4qPBVNCnbXaisy6/FS3CcFWQPzmIh4hfWC0AY0ZnG32YoTMTr6y2g4IDUwKyk/HvJF88hp8k9kbQaK7UcmruV9HuVNB10Hsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Mv5qOTdj; arc=none smtp.client-ip=209.85.166.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f67.google.com with SMTP id ca18e2360f4ac-945a33e0d55so95639839f.1
        for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 06:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761917888; x=1762522688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yzRowIyyZmKGcUOSb4RASNAB36lhMpiLxSTkV7xgA5w=;
        b=Mv5qOTdjUUR/8nLOJTyeUvyX09qa5G8fpSLcqmwUu+a4XfCDr9AnYI4FqPAGYKdSF9
         AU5TaIybJvsYHVvNThBfdi2NZ+9JFBV1rcvwum+ek+bZXngVZSQM2vOsAROt6T0JJgBj
         +8ZgQFszemqxpZK2eQ5PIABtHjQMFdZNdH9Q63IF6YyxIQ3zkEJpfiHrMOm4zhBzdV1/
         gBEGYSrkMDj+sV3+1G2hmjnhVGJk/m9DfOxk5ZGBCBoUrtwZDlDDMl1pVYtYOoJFk3Wf
         87H2iYlWNQKvPHej7LrufGO7zMH07p09wJh2Tn9HTyyBn+andk179XoASjAWxKFCW7sw
         lcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761917888; x=1762522688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzRowIyyZmKGcUOSb4RASNAB36lhMpiLxSTkV7xgA5w=;
        b=QdcEsh/3lh2Ehj48ldjV4LCRQ0JORoXhbWOSq5H8tVrgHHHF5fmw9tWRSKnqS4L3kZ
         rAV/BdZZgyNXfXSLC6HKRkNwxJVw196NB+4K3jfKTaHzjR4D9cXKMUj0WygN6v9VZLSy
         BmN/8WZJ/qt0hiqxKZVTgQZKwlid9FjUYot+SIb9apDVr2dknp2IPWEysTaSp4EIuvn+
         4EqgMLoZ0Yb+LDOvcILyUZUGjq1cM40S1Jj1rsu1UPyKGFxVCsjDNZmicLTOUBdUPico
         fDMjr8jteuwzXagiuakbXjcl+wkVtpU9NJw/IohLTPja2KZIw6qrWjJOwZLp2E1XiMGx
         4KZw==
X-Forwarded-Encrypted: i=1; AJvYcCWVrUE7ncf7V186Ak0AB+u3dCaZB788PbHLUvHgjTHa5uNe1PZmYHAyZITQLm1XU4UVWd8yf2N+xIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOIYx46R9kVNpzCWM8ymRmH6YIYeetIuZT/cH4Pjx5kirkEcTs
	8nbhrn7m33lMAbp/rXVKRJN0RdKH0F8BbAShRJPprDWWeFPbAQBg7ZBL+RXsSbjf+l4=
X-Gm-Gg: ASbGncsMTl0ZVPmoKX4DQ+Z+wEH9vdn7L398yj5e7XgtOW6Urpf+hRLfWIR4IFKpxSZ
	xbXOBvbPAYbaH1tyrLH1RyMYWUWM/rlbPspgbhw7yhQAYcqHw6zb1xjrD2PbRnDxwGYeEafnef2
	obQ5+scWLdpIY5HQvDkm5i57I8yHKtlJx7L6dgBgLZaJhKhIltSrmjmLl3a/FP1D+mBU1YMqgrO
	lEXQTtgpPbRdE+eltTeKiRKKnWsOoYiSG7tsctk0VwR/AbpXnQSliwQ+iAqo6T++22+PQBKuXlm
	pW8gcW6Q5iaUhaZlXIPndREQrYGCjYxTOdubjbRIm0TcOMw1Eb++bG2RNj+KXaDouJORfoQ4YEj
	B1vWuN7A884X2SCvk+wkLNoea7BaPcLn5Ukc8ZcGZM5WHAlScBkI5tf8tBhMUxvQo20oWhieF3n
	BPo+CyeiuDF0eEgdm6CajbcNoZ7CSlYq//3k7Ikv+TYQfhBBcMOII=
X-Google-Smtp-Source: AGHT+IFy2z/iuNwWKERvSpYZtZ5ZpYZ1zRomo2K0p0GcYWw60cslj3gZCJmO6Q+O9lj169DxL5GitQ==
X-Received: by 2002:a05:6602:140c:b0:943:5c83:d68e with SMTP id ca18e2360f4ac-948229124fbmr219775639f.1.1761917888019;
        Fri, 31 Oct 2025 06:38:08 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94827b96fb0sm57705539f.7.2025.10.31.06.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 06:38:07 -0700 (PDT)
Message-ID: <d5d44b8b-94a5-4830-8f61-0b8cbd72889c@riscstar.com>
Date: Fri, 31 Oct 2025 08:38:04 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] PCI: spacemit: introduce SpacemiT PCIe host driver
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 vkoul@kernel.org, kishon@kernel.org, dlan@gentoo.org, guodong@riscstar.com,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 p.zabel@pengutronix.de, christian.bruel@foss.st.com, shradha.t@samsung.com,
 krishna.chundru@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
 namcao@linutronix.de, thippeswamy.havalige@amd.com, inochiama@gmail.com,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251013153526.2276556-1-elder@riscstar.com>
 <20251013153526.2276556-6-elder@riscstar.com>
 <274772thveml3xq2yc7477b7lywzzwelbjtq3hiy4louc6cqom@o5zq66mqa27h>
 <4027609d-6396-44c0-a514-11d7fe8a5b58@riscstar.com>
 <paxtbwlvndtsmllhsdiovwqoes7aqwiltac6ah4ehrpkz554y6@uj5k3w5jxeln>
 <9bebde96-485f-4f30-b54c-be9e6c16f2d6@riscstar.com>
 <546kfkmfkndae32mmculbgacuni4raqwpgmeb4xnhvsuavjl3w@3pjtpmblmril>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <546kfkmfkndae32mmculbgacuni4raqwpgmeb4xnhvsuavjl3w@3pjtpmblmril>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 1:05 AM, Manivannan Sadhasivam wrote:
> On Wed, Oct 29, 2025 at 07:10:10PM -0500, Alex Elder wrote:
>> On 10/28/25 2:06 AM, Manivannan Sadhasivam wrote:
>>> On Mon, Oct 27, 2025 at 05:24:38PM -0500, Alex Elder wrote:
>>>> On 10/26/25 11:55 AM, Manivannan Sadhasivam wrote:
>>>>> On Mon, Oct 13, 2025 at 10:35:22AM -0500, Alex Elder wrote:
>>>>>> Introduce a driver for the PCIe host controller found in the SpacemiT
>>>>>> K1 SoC.  The hardware is derived from the Synopsys DesignWare PCIe IP.
>>>>>> The driver supports three PCIe ports that operate at PCIe gen2 transfer
>>>>>> rates (5 GT/sec).  The first port uses a combo PHY, which may be
>>>>>> configured for use for USB 3 instead.
>>>>>>
>>>>>> Signed-off-by: Alex Elder <elder@riscstar.com>
>>>>>> ---
>>
>> . . .
>>
>>>>>> +	ret = devm_regulator_get_enable(dev, "vpcie3v3-supply");
>>>>>> +	if (ret)
>>>>>> +		return dev_err_probe(dev, ret,
>>>>>> +				     "failed to get \"vpcie3v3\" supply\n");
>>>>>
>>>>> As mentioned in the bindings patch, you should rely on the PWRCTRL_SLOT driver
>>>>> to handle the power supplies. It is not yet handling the PERST#, but I have a
>>>>> series floating for that:
>>>>> https://lore.kernel.org/linux-pci/20250912-pci-pwrctrl-perst-v3-0-3c0ac62b032c@oss.qualcomm.com/
>>>>
>>>> I think that just means that I'll define a DT node compatible with
>>>> "pciclass,0604", and in that node I'll specify the vpcie3v3-supply
>>>> property.  That will cause that (pwrctrl) device to get and enable
>>>> the supply before the "real" PCIe device probes.
>>>>
>>>
>>> Right.
>>>
>>>> And once your PERST work gets merged into the PCI power control
>>>> framework, a callback will allow that to assert PERST# as needed
>>>> surrounding power transitions.  (But I won't worry about that
>>>> for now.)
>>>>
>>>
>>> I'm still nervous to say that you should not worry about it (about not
>>> deasserting PERST# at the right time) as it goes against the PCIe spec.
>>> Current pwrctrl platforms supporting PERST# are working fine due to sheer luck.
>>>
>>> So it would be better to leave the pwrctrl driver out of the equation now and
>>> enable the supply in this driver itself. Later, once my pwrctrl rework gets
>>> merged, I will try to switch this driver to use it.
>>
>> As I understand it, PERST# should be only be deasserted after
>> all power rails are known to be stable.
>>
> 
> Yes
> 
>> This driver enables the regulator during probe, shortly
>> before calling dw_pcie_host_init().  That function calls
>> back to k1_pcie_init(), which enables clocks, deasserts
>> resets, and initializes the PHY before it changes the
>> PERST# state.
>>
>> By "changing the PERST# state" I mean it is asserted
>> (driven low), then deasserted after 100 milliseconds
>> (PCIE_T_PVPERL_MS).
>>
>> I have two questions on this:
>> - You say the PCI spec talks about the "right time" to
>>    deassert PERST# (relative to power).  Is that at all
>>    related to PCIE_T_PVPERL_MS?
> 
> The PCI CEM spec says that PERST# should be deasserted atleast 100ms after the
> power becomes stable. But with the current pwrctrl design, the host controller

So it *is* related to that delay, but the concern you have is about
the pwrctrl design.  Simply probing the pwrctrl device enables all
its regulators, but that probe is not synchronized with the host
controller driver.  In this driver, PERST# is deasserted in the
dw_pcie_host_ops->init callback, which could be called *before*
the pwrctrl probe, and we want it to occur only *after* it.

I find on my system that (at least based on printk() time stamps)
the PERST# is deasserted *before* regulator_bulk_enable() in
pci_pwrctrl_slot_probe() has completed.  So you're absolutely
right about the problem.  The NVMe device doesn't probe until
at least 5 seconds later.

I don't want to rely on this sketchy behavior, so here is what
I plan to do (please tell me whether you agree).

I will back out the change that moves the regulator into the
root port.  I will still use the pwrctrl model--meaning the
root port will still be compatible with "pciclass,0604"--but
because it will define no regulators or clocks, it just won't
do anything of value for now.

Later, when you add the callback to the pwrctrl framework,
we can implement that callback and then move the regulator
definitions into the root port, and no longer enable them
in the host controller driver.

> deasserts the PERST# even before the pwrctrl probe. So this is in violation of
> the spec. But depending on the endpoint device design, this might not cause any
> issue as PERST# is a level triggered signal. So once the endpoint boots up, it
> will see the PERST# deassert and will start working. I'm not justifying the
> current design, but just mentioning that you might not see any issue.

I'm not seeing any issue, but it's true, the sequence of events
is not compliant with what you describe from the spec.

> That being said, we are going to submit a series that reworks pwrctrl framework
> such that each controller can call an API to probe pwrctrl drivers. This way,
> host controller driver can make sure that the device will get powered ON before
> it deasserts the PERST#.

For DesignWare-based devices that might mean a new dw_pcie_host_ops
callback function, or maybe it can just defer calling its ->init
callback until it knows power is enabled and stable.

>> - I notice that PERST# is in a deasserted state at the
>>    time I assert it in this sequence.  Do you see any
>>    reason I should assert it early as an initialization
>>    step, or is asserting it and holding it there for
>>    100 msec sufficient?
>>
> 
> You should assert PERST# before doing any controller initialization sequence as
> that may affect the endpoint. Once PERST# is asserted, it will cause the
> endpoint to 'reset'. So you do your initialization sequence and deassert it once
> done.

Basically the probe function does basic setup, then calls
dw_pcie_host_init().  The next thing that's expected is
the ->init callback from the DesignWare core code, and
that's where PERST# is asserted, then deasserted after
some other actions.

I think I'll assert PERST# (and delay 100 msec) a little
earlier though.

. . .

>>>> In dw_handle_msi_irq(), "num_ctrls" is computed based on
>>>> num_vectors / MAX_MSI_IRQS_PER_CTRL=32.  A loop then
>>>> iterates over those "controllers"(?) to handle each bit
>>>> set in their corresponding register.
>>>>
>>>> This seems OK.  Can you explain why you think it's wrong?
>>>>
>>>
>>> So both 'ctrl' and 'msi' IRQs are interrelated. Each 'ctrl' can have upto 32 MSI
>>> vectors only. If your platform supports more than 32 MSI vectors, like 256, then
>>> the platform DT should provide 8 'msi' IRQs.
>>
>> I have asked SpacemiT about this, specifically whether there
>> are additional interrupts (I don't think there are), or if
>> not that, additional registers to support MSI 32+ (see
>> below).  In their downstream driver they handle interrupts
>> differently.  I suspect num_vectors needs to be set to 32
>> (or I'll leave it unset and take the default).

This was changed to use the default (32 MSI vectors) in v4
of this series.  I haven't heard back from SpacemiT but I'm
pretty sure this is correct.

>> In the DesignWare driver, there are up to 8 "ctrls", and each
>> ctrl has 32 bit positions representing 32 MSI vectors.  Each
>> can have an msi_irq defined.  An msi_irq is always set up for
>> ctrl 0.
>>
>> For any ctrl with an msi_irq assigned, dw_pcie_msi_host_init()
>> sets its interrupt handler to dw_chained_msi_isr(), which just
>> calls dw_handle_msi_irq().
>>
>> The way dw_handle_msi_irq() works, a single ctrl apparently can
>> handle up to 256 MSI vectors, as long as the block of 3 registers
>> that manage the ctrl (ENABLE, MASK, and STATUS presumably) are
>> consecutive in I/O memory for consecutive ctrls.
>>
> 
> I'm not sure how you came up with this observation. dw_handle_msi_irq() loops
> over the 'status' using find_next_bit() of size MAX_MSI_IRQS_PER_CTRL, which is
> 32. So I don't see how a single ctrl can handle up to 256 vectors.

This doesn't matter, because you say it's not correct, but I'll
explain what I meant.

I'm saying *if* there were 8 consecutive sets of 3 registers for
these ctrls:

           ----------
ctrl0:    | ENABLE |
           |--------|
           | STATUS |
           |--------|
           |  MASK  |
           |--------|
ctrl1:    | ENABLE |
           |--------|
           | STATUS |
           |--------|
           |  MASK  |
           |--------|
              ...

then they could all be handled by a single interrupt, based on
the way the loop works.

If every ctrl has its own interrupt, then the interrupt handler
could just handle the one ctrl's 32 possible interrupts.

This loop structure is why I thought it was OK to have 256 MSI
vectors with the one handler.

>> I looked for other examples.  I see that "pcie-fu740.c", which
>> supports compatible "sifive,fu740-pcie", sets num_vectors to
>> MAX_MSI_IRQS, but "fu740-c000.dtsi" defines just one "msi"
>> interrupt.  And "pci-dra7xx.c" seems to do something similar,
>> and maybe "pcie-rcar-gen4.c" too.
>>
> 
> Yes. But I think those are mistakes. I will submit patches to fix them.
OK.  They reinforced my thought that this was doing the right
thing.  The warning you added makes it clear it is not.

Thank you very much for your explanation Mani.

					-Alex

>>> Currently the driver is not strict about this requirement. I will send a patch
>>> to print an error message if this requirement is not satisfied.
>>>
>>>>>> +
>>>>>> +	platform_set_drvdata(pdev, k1);
>>>>>> +
>>>>>
>>>>> For setting the correct runtime PM state of the controller, you should do:
>>>>>
>>>>> pm_runtime_set_active()
>>>>> pm_runtime_no_callbacks()
>>>>> devm_pm_runtime_enable()
>>>>
>>>> OK, that's easy enough.
>>>>
>>>>> This will fix the runtime PM hierarchy of PCIe chain (from host controller to
>>>>> client drivers). Otherwise, it will be broken.
>>>> Is this documented somewhere?  (It wouldn't surprise me if it
>>>> is and I just missed it.)
>>>>
>>>
>>> Sorry no. It is on my todo list. But I'm getting motivation now.
>>>
>>>> This driver has as its origins some vendor code, and I simply
>>>> removed the runtime PM calls.  I didn't realize something would
>>>> be broken without making pm_runtime*() calls.
>>>>
>>>
>>> It is the PM framework requirement to mark the device as 'active' to allow it to
>>> participate in runtime PM. If you do not mark it as 'active' and 'enable' it,
>>> the framework will not allow propagating the runtime PM changes before *this*
>>> device. For instance, consider the generic PCI topology:
>>>
>>> PCI controller (platform device)
>>> 	|
>>> PCI host bridge
>>> 	|
>>> PCI Root Port
>>> 	|
>>> PCI endpoint device
>>>
>>> If the runtime PM is not enabled for the PCI Root Port, then if the PCI endpoint
>>> device runtime suspends, it will not trigger runtime suspend for the Root Port
>>> and also for the PCI controller. Also, since the runtime PM framework doesn't
>>> have the visibility of the devices underneath the bus (like endpoint), it may
>>> assume that no devices (children) are currently active and may trigger runtime
>>> suspend of the Root Port (parent) even though the endpoint device could be
>>> 'active'.
>>
>> So this basically marks this controller as a pass-through device that
>> doesn't itself change state for runtime PM, but still communicates that
>> somewhere at or below it there might be devices that do participate.
> 
> Yes.
> 
> - Mani

