Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE763182FD
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 02:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhBKBRf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 20:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhBKBRc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2021 20:17:32 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB959C061574;
        Wed, 10 Feb 2021 17:16:50 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l17so1949995wmq.2;
        Wed, 10 Feb 2021 17:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WXGPmEvy9dSivvx3DCUoFQtWsNlJFnP4j+gTWZ6NVsM=;
        b=XlEkgTkWybu3asiL2QYqXomweDCDbrx9AOVOg3gCmfHOTHvu+nKO3CY0BKHRbc1gfF
         R2DkqQJNJa0Obpt13cLimlki6C6M9iU1LNzD5ZI3GwtUziL6Gqlc0qWw3NySnJTtE63U
         HIcGRsNx1r8ovJOpO7ixW3CU7FvSj3WrHGu+aAZLYjsw5yXKZGtMgqrwZf5ffXZwxMFG
         ZHLRV63bSljeJt+/6Kmtt/syY+zvfNsZkjXh/wJ4YFKxD/fmERkZoBMf1VpwMAAemG04
         7M7nLayG4NMLJXqlJL3fw4IfX2GYMSYwNdSzklZG73q6hIAsC8xuIXVz6MiTjdCkebjw
         E4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WXGPmEvy9dSivvx3DCUoFQtWsNlJFnP4j+gTWZ6NVsM=;
        b=ZRfDN8fc58KjqD5k8mc59bmiNaiJ5ikr1JOysjVWIcbakcJLsfsZf6SuVU3oCEuS1y
         y9WcwmqelcWuu/USCCSjFipcvf4LVlOqTmzClJZ7qd0mhVpooyp8QXpxyvlj5CvzaPPY
         eIlLTP9RbpVBn92/W10MP7GIn+TENeWB3VZU/HNpyfT+Lm4Z1uSvJ8uSLeGX0iLzWO8a
         s3i5hfEPcXAFIHkcy1ToPDEBx1MD7NabHilJWaWYOP9FWLaM7KOqjwQxq109kbG6C28c
         2J6KsOnNcDl7yOYbb46km7qRVhO3pW8xaAhJAQO0vk5kyo3RSmLm2aQO17oybd2Otvqa
         5nag==
X-Gm-Message-State: AOAM533DXUEqEQpr11bB9vSuQlrnFe119Fj1UuqJGeU3GaP+NeX1WJsC
        1ZvGpSeoQ8bCzVgYOC5vwZ0gNLVHkyuwxw==
X-Google-Smtp-Source: ABdhPJw2Vv+G2hjkNsT2yfIQL84InzdFMQTtDC1sDpINbwXBPaf+WSUchuWoay1KN9SpSAG5L4TTCw==
X-Received: by 2002:a1c:48c4:: with SMTP id v187mr1989667wma.145.1613006209013;
        Wed, 10 Feb 2021 17:16:49 -0800 (PST)
Received: from [192.168.2.202] (pd9e5a48d.dip0.t-ipconnect.de. [217.229.164.141])
        by smtp.gmail.com with ESMTPSA id a84sm5847877wme.12.2021.02.10.17.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 17:16:48 -0800 (PST)
Subject: Re: [PATCH] PCI: Run platform power transition on initial D0 entry
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
References: <20210210235749.GA617942@bjorn-Precision-5520>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <e768f68e-4f22-1b9a-e3d4-eb7dbdede58e@gmail.com>
Date:   Thu, 11 Feb 2021 02:16:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210210235749.GA617942@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/11/21 12:57 AM, Bjorn Helgaas wrote:
> [+cc Rafael, linux-pm]
> 
> On Thu, Feb 04, 2021 at 11:06:40PM +0100, Maximilian Luz wrote:
>> On some devices and platforms, the initial platform power state is not
>> in sync with the power state of the PCI device.
>>
>> pci_enable_device_flags() updates the state of a PCI device by reading
>> from the PCI_PM_CTRL register. This may change the stored power state of
>> the device without running the appropriate platform power transition.
> 
> At this point in the code, setting dev->current_state based on the
> value of PCI_PM_CTRL seems reasonable.  We're making the pci_dev state
> match the PCI device hardware state.  This paragraph sort of implies
> we're missing an "appropriate platform power transition" here, but I
> don't think that's the case.

In terms of PCI core, this is fine. But there's no attempt made at
checking that the platform state (not the core state) is compatible with
what we're setting here.

So the core state is correct and shows that the device is on, but
unfortunately there's some ACPI code out there that seems to initialize
some ACPI power resource to a state that doesn't match this (in this
case off). So updating the state without also making sure that the power
resource is also updated (e.g. turned on or at least marked as turned on
here) leaves both states to be different (emphasis on leaves, the were
already out-of-sync before that). E.g. in my case PCI says 'on'
(correct) and ACPI says 'off' (wrong).

The problem is that when we now later transition the device into D3cold,
the PCI core itself will do that transition just fine, but the PCI-ACPI
(i.e. platform) part thinks the power resource is already off and won't
do anything. And that prevents the device from actually being turned
off.

Also running pci_set_power_state(..., PCI_D0) later does not fix that
because the PCI core (correctly) believes that the device is already on
and just returns doing nothing. So it doesn't even attempt to check the
platform state, which is reasonable behavior if one assumes that the
platform state is always in sync with the PCI core state. It's just that
here, I think, we can't assume that they're in sync (mostly because ACPI
/ platform stuff may be weird and buggy and we may not have control over
that).

This is why I suggested replacing pci_set_power_state(dev, PCI_D0) with
pci_power_up(dev). With PCI_D0, they essentially do the same thing,
except for the (first) state check. Also both later call
pci_platform_power_transition() and pci_raw_set_power_state(), which
(should) have their individual state checks. So if the device is already
in D0, this boils down to calling the pci_platform_power_transition()
only.

> But it would be nice if we could combine this bit from
> pci_enable_device_flags() with the pci_set_power_state() in
> do_pci_enable_device().
> 
>> Due to the stored power-state being changed, the later call to
>> pci_set_power_state(..., PCI_D0) in do_pci_enable_device() can evaluate
>> to a no-op if the stored state has been changed to D0 via that. This
>> will then prevent the appropriate platform power transition to be run,
>> which can on some devices and platforms lead to platform and PCI power
>> state being entirely different, i.e. out-of-sync. On ACPI platforms,
>> this can lead to power resources not being turned on, even though they
>> are marked as required for D0.
>>
>> Specifically, on the Microsoft Surface Book 2 and 3, some ACPI power
>> regions that should be "on" for the D0 state (and others) are
>> initialized as "off" in ACPI, whereas the PCI device is in D0.
> 
> So some ACPI power regions are in fact "on" (because the PCI device
> that requires them is in D0), but the ACPI core believes them to be
> "off" (or probably "unknown, treated as 'off'")?

Yes, that's pretty much it.

The problem I'm dealing with specifically is caused by the ACPI code in
[1]. There, _STA gets initialized to 'off' and is only updated when the
power transitions run (i.e. the _ON or _OFF methods). There's nothing in
this ACPI code that checks the actual state of the PCI device, which
causes this problem. So, to me, it seems that this code is expecting the
_ON method to be called in PCI bring-up.

[1]: https://github.com/linux-surface/acpidumps/blob/1ed05b95df844534229f752ea2267c8dd8ae7f8c/surface_book_2/dsdt.dsl#L19170-L19225

>> As the
>> state is updated in pci_enable_device_flags() without ensuring that the
>> platform state is also updated, the power resource will never be
>> properly turned on. Instead, it lives in a sort of on-but-marked-as-off
>> zombie-state, which confuses things down the line when attempting to
>> transition the device into D3cold: As the resource is already marked as
>> off, it won't be turned off and the device does not fully enter D3cold,
>> causing increased power consumption during (runtime-)suspend.
>>
>> By replacing pci_set_power_state() in do_pci_enable_device() with
>> pci_power_up(), we can force pci_platform_power_transition() to be
>> called, which will then check if the platform power state needs updating
>> and appropriate actions need to be taken.
>>
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> 
> I added Rafael & linux-pm because he should chime in here.
> 
>> ---
>>
>> I'm not entirely sure if this is the best way to do this, so I'm open to
>> alternatives. In a previous version of this, I've tried to run the
>> platform/ACPI transition directly after the pci_read_config_word() in
>> pci_enable_device_flags(), however, that caused some regression in
>> intel-lpss-pci, specifically that then had trouble accessing its config
>> space for initial setup.
>>
>> This version has been tested for a while now on [1/2] without any
>> complaints. As this essentially only drops the initial are-we-already-
>> in-that-state-check, I don't expect any issues to be caused by that.
>>
>> [1]: https://github.com/linux-surface/linux-surface
>> [2]: https://github.com/linux-surface/kernel
>>
>> ---
>>   drivers/pci/pci.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index b9fecc25d213..eb778e80d8cf 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1802,7 +1802,7 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
>>   	u16 cmd;
>>   	u8 pin;
>>   
>> -	err = pci_set_power_state(dev, PCI_D0);
>> +	err = pci_power_up(dev);
>>   	if (err < 0 && err != -EIO)
>>   		return err;
>>   
>> -- 
>> 2.30.0
>>
