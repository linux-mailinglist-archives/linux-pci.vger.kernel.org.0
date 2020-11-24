Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077C82C2FD0
	for <lists+linux-pci@lfdr.de>; Tue, 24 Nov 2020 19:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390777AbgKXSMy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 24 Nov 2020 13:12:54 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35307 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390813AbgKXSMx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2020 13:12:53 -0500
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1khco5-0005Fz-Ch
        for linux-pci@vger.kernel.org; Tue, 24 Nov 2020 18:12:49 +0000
Received: by mail-pl1-f199.google.com with SMTP id bf9so14164328plb.18
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2020 10:12:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=snL9RNSX8zVjZ8Edo4JkJG0/fQQHPHAezPnsIg3vdfE=;
        b=uG9rsuAw76JAJaBCwuufutptNxMmSkq5zeAIPZEU7ePCeL3VdxvZAztAXH4Nyhbrj3
         vRb1ir9MQjhgSnWo9eSlQYnF4ya57M/UyHa8pekzSQPjhOk7mGMBoII3DokXFBANgChJ
         nnfensKqfywvTX4HUrj/sNN49Gbg2c8R/6sQsWF5aLbSEp2Ic0Ul85WBGgACkbDMj1Co
         ejfgSRl1Gfsq1EEjjJaq3N8Rqywjt90AHrClm1X8sQnx6LwMSmX+KOnh9hWAzwIUAdt9
         2YjEY5R1E8fS0WGiqFLuOa+271vhKMu/uU8nkqTfXCWkdVBZq2jSo9JNiezCImmykooy
         McCA==
X-Gm-Message-State: AOAM533rEMLYHcB9RgVnVWYSQmAtiOe4z1VmQ++qYYmhacigU1Wf5QdL
        GgSg5K5uXyJ98D9n5h6E8Za57hrk2o7lU7yLxcYPD/UtDbggaP7qJlUR9EjdgeqnOxzkCezNB/n
        ZRPzImIuHhO89Gv1dn9K2a/VTQwHVC9G1DfY0mw==
X-Received: by 2002:a17:902:be07:b029:da:c5e:81b6 with SMTP id r7-20020a170902be07b02900da0c5e81b6mr51386pls.43.1606241567981;
        Tue, 24 Nov 2020 10:12:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwd3mz1ZOBELu8eXstZJ67YyW3RJKTrqevKyFMPdaSoCeau9k7+iHzDJCB1R9vUqbB3XEJ6kg==
X-Received: by 2002:a17:902:be07:b029:da:c5e:81b6 with SMTP id r7-20020a170902be07b02900da0c5e81b6mr51355pls.43.1606241567586;
        Tue, 24 Nov 2020 10:12:47 -0800 (PST)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id g14sm4132662pji.32.2020.11.24.10.12.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 10:12:46 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH] ACPI: PM: Re-enable ACPI GPE if it's already enabled
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <2176101.IjXNKL1iO1@kreacher>
Date:   Wed, 25 Nov 2020 02:12:42 +0800
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <9458714B-6C0E-450D-9332-803B73506A39@canonical.com>
References: <20201124073619.771940-1-kai.heng.feng@canonical.com>
 <CAJZ5v0iJ_x5oXL9gG_TvCriNnPwzZYvGkkEK6_HWrH4fmCqBxQ@mail.gmail.com>
 <90E54BA3-FC3A-4538-ACD0-4C4DDF570C7C@canonical.com>
 <2176101.IjXNKL1iO1@kreacher>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On Nov 25, 2020, at 01:48, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> 
> On Tuesday, November 24, 2020 6:31:56 PM CET Kai-Heng Feng wrote:
>> 
>>> On Nov 24, 2020, at 22:00, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> 
>>> On Tue, Nov 24, 2020 at 8:36 AM Kai-Heng Feng
>>> <kai.heng.feng@canonical.com> wrote:
>>>> 
>>>> Dell Precision 5550 fails to detect Thunderbolt device hotplug events,
>>>> once the Thunderbolt device and its root port are runtime-suspended to
>>>> D3cold.
>>>> 
>>>> While putting the entire hierarchy to D3cold, the root port ACPI GPE is
>>>> enabled via acpi_pci_propagate_wakeup() when suspending Thunderbolt
>>>> bridges/switches. So when putting the root port to D3cold as last step,
>>>> ACPI GPE is untouched as it's already enabled.
>>>> 
>>>> However, platform may need PCI devices to be in D3hot or PME enabled
>>>> prior enabling GPE to make it work.
>>> 
>>> What platforms and why.
>> 
>> Dell Precision 5550. Its thunderbolt port can't detect newly plugged thunderbolt devices.
> 
> OK
> 
>>> 
>>>> So re-enable ACPI GPE to address this.
>>>> 
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>> ---
>>>> drivers/acpi/device_pm.c | 13 ++++++-------
>>>> 1 file changed, 6 insertions(+), 7 deletions(-)
>>>> 
>>>> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
>>>> index 94d91c67aeae..dc25d9d204ae 100644
>>>> --- a/drivers/acpi/device_pm.c
>>>> +++ b/drivers/acpi/device_pm.c
>>>> @@ -757,11 +757,10 @@ static int __acpi_device_wakeup_enable(struct acpi_device *adev,
>>>> 
>>>>       mutex_lock(&acpi_wakeup_lock);
>>>> 
>>>> -       if (wakeup->enable_count >= max_count)
>>>> -               goto out;
>>>> -
>>>> -       if (wakeup->enable_count > 0)
>>>> -               goto inc;
>>>> +       if (wakeup->enable_count > 0) {
>>>> +               acpi_disable_gpe(wakeup->gpe_device, wakeup->gpe_number);
>>>> +               acpi_disable_wakeup_device_power(adev);
>>>> +       }
>>> 
>>> An event occurring at this point may be lost after this patch.
>> 
>> Yes, so this approach is not optimal.
>> 
>>> 
>>> It looks like you are trying to work around a hardware issue.  
>> 
>> Windows doesn't have this issue. So I don't think it's hardware issue.
> 
> Windows may exercise the hardware in a different way.
> 
>>> Can you
>>> please describe that issue in detail?
>> 
>> The GPE used by Thunderbolt root port, was previously enabled by Thunderbolt switches/bridges.
> 
> This shouldn't matter, because enabling a GPE means flipping its bit in the
> "enable" register.  There's no dependency between that and the devices below
> the port.
> 
> There may be dependency there for enabling the device wakeup power, however.

Right, didn't notice re-enabling the wakeup power alone can solve this.

> 
>> So when the GPE is already enabled when Thunderbolt root port is suspended.
>> However, the GPE needs to be enabled after root port is suspended, and that's the approach this patch takes.
> 
> No, it is not.
> 
> It still enables the GPE and the device wakeup power before putting the port
> into D3.  Please see pci_finish_runtime_suspend() for details.

What I meant "already enabled" is that GPE doesn't get touched because of "wakeup->enable_count > 0" check.

> 
> However, it enables wakeup for after putting the subordinate device(s) into D3hot
> which may matter in theory.
> 
>> Is there any actual hardware benefits from acpi_pci_propagate_wakeup()?
> 
> Yes, there is AFAICS.
> 
>> If there's no actual device benefits from it, we can remove it and only enable GPE for the root port.
>> Otherwise we need to quirk off Thunderbolt bridges/switches, since their native PME just work without the need to enable root port GPE.
> 
> Can you please check if the alternative (untested) patch below still helps?

Yes, it helps. Thanks a lot!

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> 
> ---
> drivers/acpi/device_pm.c |   40 ++++++++++++++++++++++++++--------------
> 1 file changed, 26 insertions(+), 14 deletions(-)
> 
> Index: linux-pm/drivers/acpi/device_pm.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/device_pm.c
> +++ linux-pm/drivers/acpi/device_pm.c
> @@ -749,7 +749,7 @@ static void acpi_pm_notify_work_func(str
> static DEFINE_MUTEX(acpi_wakeup_lock);
> 
> static int __acpi_device_wakeup_enable(struct acpi_device *adev,
> -				       u32 target_state, int max_count)
> +				       u32 target_state)
> {
> 	struct acpi_device_wakeup *wakeup = &adev->wakeup;
> 	acpi_status status;
> @@ -757,15 +757,26 @@ static int __acpi_device_wakeup_enable(s
> 
> 	mutex_lock(&acpi_wakeup_lock);
> 
> -	if (wakeup->enable_count >= max_count)
> -		goto out;
> -
> +	/*
> +	 * If the device wakeup power is already enabled, disable it and enable
> +	 * it again in case it depends on the configuration of subordinate
> +	 * devices and the conditions have changed since it was enabled last
> +	 * time.
> +	 */
> 	if (wakeup->enable_count > 0)
> -		goto inc;
> +		acpi_disable_wakeup_device_power(adev);
> 
> 	error = acpi_enable_wakeup_device_power(adev, target_state);
> -	if (error)
> +	if (error) {
> +		if (wakeup->enable_count > 0) {
> +			acpi_disable_gpe(wakeup->gpe_device, wakeup->gpe_number);
> +			wakeup->enable_count = 0;
> +		}
> 		goto out;
> +	}
> +
> +	if (wakeup->enable_count > 0)
> +		goto inc;
> 
> 	status = acpi_enable_gpe(wakeup->gpe_device, wakeup->gpe_number);
> 	if (ACPI_FAILURE(status)) {
> @@ -778,7 +789,10 @@ static int __acpi_device_wakeup_enable(s
> 			  (unsigned int)wakeup->gpe_number);
> 
> inc:
> -	wakeup->enable_count++;
> +	if (wakeup->enable_count < INT_MAX)
> +		wakeup->enable_count++;
> +	else
> +		acpi_handle_info(adev->handle, "Wakeup enable count out of bounds!\n");
> 
> out:
> 	mutex_unlock(&acpi_wakeup_lock);
> @@ -799,7 +813,7 @@ out:
>  */
> static int acpi_device_wakeup_enable(struct acpi_device *adev, u32 target_state)
> {
> -	return __acpi_device_wakeup_enable(adev, target_state, 1);
> +	return __acpi_device_wakeup_enable(adev, target_state);
> }
> 
> /**
> @@ -829,8 +843,7 @@ out:
> 	mutex_unlock(&acpi_wakeup_lock);
> }
> 
> -static int __acpi_pm_set_device_wakeup(struct device *dev, bool enable,
> -				       int max_count)
> +static int __acpi_pm_set_device_wakeup(struct device *dev, bool enable)
> {
> 	struct acpi_device *adev;
> 	int error;
> @@ -850,8 +863,7 @@ static int __acpi_pm_set_device_wakeup(s
> 		return 0;
> 	}
> 
> -	error = __acpi_device_wakeup_enable(adev, acpi_target_system_state(),
> -					    max_count);
> +	error = __acpi_device_wakeup_enable(adev, acpi_target_system_state());
> 	if (!error)
> 		dev_dbg(dev, "Wakeup enabled by ACPI\n");
> 
> @@ -865,7 +877,7 @@ static int __acpi_pm_set_device_wakeup(s
>  */
> int acpi_pm_set_device_wakeup(struct device *dev, bool enable)
> {
> -	return __acpi_pm_set_device_wakeup(dev, enable, 1);
> +	return __acpi_pm_set_device_wakeup(dev, enable);
> }
> EXPORT_SYMBOL_GPL(acpi_pm_set_device_wakeup);
> 
> @@ -876,7 +888,7 @@ EXPORT_SYMBOL_GPL(acpi_pm_set_device_wak
>  */
> int acpi_pm_set_bridge_wakeup(struct device *dev, bool enable)
> {
> -	return __acpi_pm_set_device_wakeup(dev, enable, INT_MAX);
> +	return __acpi_pm_set_device_wakeup(dev, enable);
> }
> EXPORT_SYMBOL_GPL(acpi_pm_set_bridge_wakeup);

