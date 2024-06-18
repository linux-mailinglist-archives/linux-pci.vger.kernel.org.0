Return-Path: <linux-pci+bounces-8927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 974B090DBDC
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 20:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2DC28363A
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 18:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7BD47773;
	Tue, 18 Jun 2024 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQoLNPNA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21A21171C
	for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718736638; cv=none; b=qP3/eEN2uOgC9qoH2/tNHjRQRoi2VqbSVmJcmIF9Cr5oojeFMUgFxpko84fxGP/C989sDciZF68FdNivraev7+YVHYrC8zHfX8F0EXKCGtZ04ySAR3Z4U9fj+q7lvNwKAiDgFFZPXMhhpU/7YdknjoAJu2voaUujuEvaGV9YaAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718736638; c=relaxed/simple;
	bh=oUJCatabl9usSBAb4ICdmrliOYYjGQ1Rcj/EfrmR8co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATTahUUoTFfancMB1ps/jcmN1bPFQGNmrXm8e+Ndj7fS6i/Nhs5ZEyjPgOtMoOaawR2vQNEtK9TA87MYjVxsIb5amrOHRIvrCU7TFyFJ+r3NRPLrzJmyTtm1tGeNVhS5Or558kc9TrEwiJo2nDRsP0RMyFf5VFd0VeihIX8m+j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQoLNPNA; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d2255f84e9so54017b6e.0
        for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 11:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718736636; x=1719341436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MJ/9v8kUM5CrGoi/bcL/1w7QC6LWz1nYjoLr8YXaSO8=;
        b=YQoLNPNAKcdIpYa03rl8TF8lUWiN3pjA5b2cI1TVYRsbigL2LZpH12J8u7wGidmfwz
         am8T5wuVANnxc71U2u3ccPj8jmqwESy/znnVB2ZAmw6tr0FznVFsL4CdgCR6Os2BNb8s
         fx4in3iaDlKbolZqOyYtYd9XDablDTRlw1vRq9x5uFGrAGIiTHPM2AZvpF5xvsTCBEtU
         nR+CrVhoXXLjrQ6cM7srdMoTEjz1ezao4qPaWD2D6Iw0npQ9TUPhXmlDMGQsuV104TYz
         V4wvDpyh98YtEmFu66rOK7xWX5j2itePOkSG9uSkB4V3CpRSQ+PXk1y4/H2QiOxsBf0h
         cw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718736636; x=1719341436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJ/9v8kUM5CrGoi/bcL/1w7QC6LWz1nYjoLr8YXaSO8=;
        b=tMzudmxieJw9O7SKns0T5e674GSPGXeauc3yWg+hd/KlOYvrHwvK/+sKZbEk6vABs1
         SOhpHYQc2t9Zrc9rWNk/V2Q7ZkhS+Gf08BQQK0+Du9E6UZGfejSIulAt2pjDDoOMptlS
         v37aU4i/iIIM3FNBIUOsZyBFXpFjlnTu0gv3WSQxnR1o0//ApSNIbrsYydqpwYSzFTTU
         yl9RJ+Fqchunt3yIlZ3qzQqV4b/omXxPm8q4Jvj+N6/XYofBElfXQQmaqSseufIvXvrg
         wOtq3uDW2WNsY8IyaFZS4xjGjHPq2O3z8SXALB67qAmjfF13MdbCf4tlKyGtvrf9xV/L
         7reQ==
X-Gm-Message-State: AOJu0YzqvEG1El9yBUjEPHY5vR3rlVbQVRB3F+mqrvtBkpJUshcsMISW
	ZI3A/fp+i/1DHLDGQLSJthtmvLfbJRv4rVvcy1OUYODMGn8xX1vH
X-Google-Smtp-Source: AGHT+IF7r+guKXKs8XfNqlpIIVxtA4t4fG1v42nHZIxlW66FrEFmU1Faypehp9QOTUppL3uTtQh/zQ==
X-Received: by 2002:a05:6808:14c7:b0:3d2:2c03:8642 with SMTP id 5614622812f47-3d51b5bcbcdmr351322b6e.4.1718736635870;
        Tue, 18 Jun 2024 11:50:35 -0700 (PDT)
Received: from [192.168.1.224] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2475e4e8fsm1872658b6e.10.2024.06.18.11.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 11:50:35 -0700 (PDT)
Message-ID: <20ba8352-c1ce-45ba-8cb7-7ef4c02b3352@gmail.com>
Date: Tue, 18 Jun 2024 13:50:32 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams
 <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>,
 Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20240528131940.16924-1-mariusz.tkaczyk@linux.intel.com>
 <20240528131940.16924-3-mariusz.tkaczyk@linux.intel.com>
 <05455f36-7027-4fd6-8af7-4fe8e483f25c@gmail.com> <Zm1uCa_l98yFXYqf@wunner.de>
 <20240618105653.0000796d@linux.intel.com>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <20240618105653.0000796d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/18/2024 3:56 AM, Mariusz Tkaczyk wrote:
> On Sat, 15 Jun 2024 12:33:45 +0200
> Lukas Wunner <lukas@wunner.de> wrote:
> 
>> On Fri, Jun 14, 2024 at 04:06:14PM -0500, stuart hayes wrote:
>>> On 5/28/2024 8:19 AM, Mariusz Tkaczyk wrote:
>>>> +static int pci_npem_init(struct pci_dev *dev, const struct npem_ops *ops,
>>>> +			 int pos, u32 caps)
>>>> +{
>> [...]
>>>> +	ret = ops->get_active_indications(npem, &active);
>>>> +	if (ret) {
>>>> +		npem_free(npem);
>>>> +		return -EACCES;
>>>> +	}
>>>
>>> Failing pci_npem_init() if this ops->get_active_indications() fails
>>> will keep this from working on most (all?) Dell servers, because the
>>> _DSM get/set functions use an IPMI operation region to get/set the
>>> active LEDs, and this is getting run before the IPMI drivers and
>>> acpi_ipmi module (which provides ACPI access to IPMI operation
>>> regions) get loaded.  (GET_SUPPORTED_STATES works without IPMI.)
>>
>> CONFIG_ACPI_IPMI is tristate.  Even if it's built-in, the
>> module_initcall() becomes a device_initcall().
>>
>> PCI enumeration happens from a subsys_initcall(), way earlier
>> than device_initcall().
>>
>> If you set CONFIG_ACPI_IPMI=y and change the module_initcall() in
>> drivers/acpi/acpi_ipmi.c to arch_initcall(), does the issue go away?
> 
> That seems to be the best option. Please test Lukas proposal and let me know.
> Shouldn't I make a dependency to ACPI_IPMI in Kconfig (with optional comment
> about initcall)?
> 
> +config PCI_NPEM
> +	bool "Native PCIe Enclosure Management"
> +	depends on LEDS_CLASS=y
> +	depends on ACPI_IPMI=y
> 

I tried it just to be sure, but changing the module_initcall() to an
arch_initcall() in acpi_ipmi.c (and compiling it into the kernel) doesn't
help... acpi_ipmi is loaded before npem, but the underlying IPMI drivers
that acpi_ipmi uses to provide the IPMI operation region in ACPI aren't
loaded until later... acpi_ipmi needs the IPMI device.

I'll try to think of another solution.  I don't see how to get the IPMI
drivers to load before PCI devices are enumerated, so it seems to me that
the only way to get it to work from the moment the LEDs show up in sysfs
is to somehow delay the npem driver initialization of the LEDs (at least
for _DSM) or use something to trigger a rescan later.

I notice that acpi_ipmi provides a function to wait for it to have an
IPMI device registered (acpi_wait_for_acpi_ipmi()), which is used by
acpi_power_meter.c.  It would be kind of awkward to use that... it just
just waits for a completion (with a 2 second timeout)--it isn't a notifier
or callback.  On my system, the npem driver failed to run a _DSM at
0.72 seconds, and ipmi_si driver didn't initialize the IPMI controller
until 9.54 seconds.

>>
>>> (2) providing a mechanism to trigger this driver to rescan a PCI
>>>      device later from user space
>>
>> If this was a regular device driver and -EPROBE_DEFER was returned if
>> IPMI drivers aren't loaded yet, then this would be easy to solve.
>> But neither is the case here.
>>
>> Of course it's possible to exercise the "remove" and "rescan" attributes
>> in sysfs to re-enumerate the device but that's not a great solution.
> 
> We cannot expect from users to know and do that. If we cannot configure driver,
> we should not register it. We have to guarantee that IMPI commands are
> available at the point we are using them.
> 
> There is not better place to add _DSM device than its enumeration and I have a
> feeling than sooner or later someone else will reach this problem so it would
> be better for community to solve it now.
> 
>>
>>
>>> (3) don't cache the active LEDs--just get the active states using
>>>      NPEM/DSM when brightness is read, and do a get/modify/set when
>>>      setting the brightness... then get_active_indications() wouldn't
>>>      need to be called during init.
>>
>> Not good.  The LEDs are published in sysfs from a subsys_initcall().
>> Brightness changes through sysfs could in theory immediately happen
>> once they're published.  If acpi_ipmi is a module and gets loaded way
>> later, we'd still have to cope with Set State or Get State DSMs going
>> nowhere.
>>
> 
> Agree. I can do it and it should be safe but it is not addressing the issue.
> We would limit time race window but we will not close it.
> 
> Thanks,
> Mariusz

