Return-Path: <linux-pci+bounces-27733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B98EAB70E2
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 18:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29B0516445A
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 16:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD53623CE;
	Wed, 14 May 2025 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiwLuLGB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34111E9B1A
	for <linux-pci@vger.kernel.org>; Wed, 14 May 2025 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747239079; cv=none; b=kmLIPvQhcD4Su5RB0GCkuSc8tzkbeJ7kuUL//zeU4096N91xeyHS0qzem23bfGRymZNotRh1BKe4bxHL8M22jnG2u/Lvb+zBb1UJ+U1XtjCuXK6phWFq+MjnN6XF+qcPk6HvRdDzn2syKJlgshrSHoS6nr/b+Y71ZiQBD8Go4UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747239079; c=relaxed/simple;
	bh=Y2/V4Vh+d+a0nZcON/MiVuUcn+BjyzHoYwdbSHuLjiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mr5YxoAXZ7GQfdJvXHpbYUVBuCPH++pAn1V840TOgjv5RPByUoJpz7CXFN6WIF0vBLsaFpfAq6opZqN8YwlIuVOfW9PzsJ2/LhyLldic5skpJVuxxIKM9CpGvSua57Gtjzrc/98BHiNH9zZpZffEWvPLYSPskL7VgMB3/OBCHsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiwLuLGB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso47068635e9.2
        for <linux-pci@vger.kernel.org>; Wed, 14 May 2025 09:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747239076; x=1747843876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y2/V4Vh+d+a0nZcON/MiVuUcn+BjyzHoYwdbSHuLjiw=;
        b=IiwLuLGBSANOVfPVpVxvuwXF8Sr9gGVpkKtEAl5Rg4cZ+O2sLb5faZi5MlHvSWsDfD
         b9tCRpFTotaYP7XOtfPn/y0UxBNiCl3EBYIRMaeOPC40Hf1rZq6WN3Fzo+Q7Z3JGbHix
         69CojXO2oJVzNODpC6u4qG43i2wm/C+ilv0O5SwueB7o3yYND0+X3tqs7L3wwGpB5gf2
         5waXeuGQ4EE97J1xWEHUfXhuIWn8PGrzFoJ5Un5ZjdRztuMsSeCzhtVvCMlSEJDvUXx/
         +QtEha0vqRi/oFA9nTFBfIWX4fXNLlNa8vtU9fgEBWTy1Rh0/y855rRt5e53iDm+NzTu
         D0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747239076; x=1747843876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2/V4Vh+d+a0nZcON/MiVuUcn+BjyzHoYwdbSHuLjiw=;
        b=QxeV6LqWAviu3MPDt4CosVg6EJLoKVo+rvxAUOtU5BD8JTqi9VK6NYBOJxGsWOD04y
         eHYn3gKZqgD0d+coUFuXAl9WzrWsVbSvxXx/vlldEOguOvMUPejq/pZsGTTIFbKL5M3E
         JZFP59zBQWMdRNjEqoeZwZKqSIadZjCVhK9R6PGvyAB44r7sGhR1oW/niRSFmJ8cF2Tu
         Zo74JoV+PGGtqqlX44PEqBZTdGx6u4741EaKs81NJYwfVQhlcwtBaF+SzcKg67fN5hty
         y/BLjnS/TMvNHZtCbY0w8Yb/ZWIe8ZrwANX3DAGVSpVQYNmchdVJQCHMwhJ7YQOEvJR5
         i8Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWPexNI88SA3n8tMk+O8zFGtOiI4RF+/3XopLePHXWR9YBtJ79dy/ImqJp4rU6zq/LnaiSTaQ6PV6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu/x75JZkSno+5J/dWP0HfUfz4rGJc5mtHlUh7W89A/ElJ0R9J
	HN50yXYBPzmIwjkHDMuafBLdotyq4vsxRe3dyuvKefFFDMchAb7x
X-Gm-Gg: ASbGnctPvrOQ/IIkRnLKozl4E1UnvK63BNJmxzO9lciIDpz8LNa6LnrCijq/iyyzonP
	eSCBdJBw1UrpVtyT0utN/okZJf1E40srqOHyQUJllks2UOiQpdtYStKv94LFBDtd70O495Kgy2o
	CL6aJ1aeo+jaRt9omMSqAMkac99t0aZzpnXjWF40rhRg2CUxQeKXBh/DfZ6d5szvIP58oQ0g0/y
	LnaLzhshXktn/amVnVpS+8QWPRkbAt5I4UozF1pOh9Yvi4/Z5QeGw8mpsBeo4XvgFkqhHSsmE0d
	ACR2mNRj+XlBfv/3QoLn5SJgoWB8BUEOkQMpsIbHQ5zqgS7lIO0bA16qMm0QTJo=
X-Google-Smtp-Source: AGHT+IFGHec//hF81vQxUlFa4erK/ez1voAa+p6UTDP3HcrYgaIZTtF6BiQEOAEJgs3Vbq8qTw4hYQ==
X-Received: by 2002:a05:600c:348a:b0:43c:fa0e:4713 with SMTP id 5b1f17b1804b1-442f20bb25dmr40829335e9.2.1747239074979;
        Wed, 14 May 2025 09:11:14 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.99.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f337dbb7sm35500765e9.14.2025.05.14.09.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 09:11:14 -0700 (PDT)
Message-ID: <965c9753-f14b-4a87-9f6d-8798e09ad6f5@gmail.com>
Date: Wed, 14 May 2025 18:11:13 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 220110] probably thunderbolt or pci leads to pci usage
 counter underflow
To: Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Yijun Shen
 <Yijun_Shen@dell.com>, David Perry <david.perry@amd.com>,
 Kai-Heng Feng <kaihengf@nvidia.com>, AceLan Kao <acelan.kao@canonical.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 =?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250513194506.GA1155899@bhelgaas>
 <b2f9c88d-59b5-416f-b8d5-2e0fb1fc74fd@amd.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <b2f9c88d-59b5-416f-b8d5-2e0fb1fc74fd@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/13/25 21:51, Mario Limonciello wrote:
> On 5/13/2025 2:45 PM, Bjorn Helgaas wrote:
>>  From Denis's report at https://bugzilla.kernel.org/show_bug.cgi?id=220110:
>>
>>> I am having problems with my laptop that has a thunderbolt
>>> controller to which I connected an AMD 6750XT.
>>>
>>> The topology of my system is described in this bug:
>>> https://gitlab.freedesktop.org/drm/amd/-/issues/4014 yet I don't
>>> know if this is related or not.
>>>
>>> I experienced PC attempting to enter s2idle while playing a YT
>>> video; PC has become totally unresponsive to input in any
>>> keyboard/mouse and power button after turning off screens attached
>>> to the AMD card (the built-in screen was off already).
>>>
>>>  From a look at the logs it appears one uncorrectible AER pci error
>>> triggered a pci root reset, and that comes with a bug where the
>>> usage counter assumes a wrong value; this in turn seems to cause all
>>> sorts of weird bugs.
>>>
>>> That however is my interpretation of the attached log, that might be
>>> very wrong.
>>>
>>> This is the first time I experience this bug in a year with this
>>> laptop and I don't know how easy it is to reproduce.
>>>
>>> The kernel has been compiled from sources and it has
>>>
>>>    [PATCH v2] PCI: Explicitly put devices into D0 when initializing
>>>    [PATCH v4] PCI/PM: Put devices to low power state on shutdown
>>>
>>> as I am helping testing things. I find unlikely any of those might
>>> cause these issues especially "PCI: Explicitly put devices into D0
>>> when initializing" that has been there for a few weeks now.
>>>
>>> Thanks in advice to whoever will help me.
>
> From the logs the system didn't actually enter s2idle, but because of the failure to recover after AER he lost the external GPU.
>
> I don't expect that "PCI/PM: Put devices to low power state on shutdown" has anything to do with this issue.  This should only affect system shutdown.  (Tangentially related comment; we have another version of this on the linux-pm list now that is more generic [1]).
>
> How readily can this be reproduced?  Can you try to reproduce once more?
> Can this reproduce on an unpatched kernel?
>
I have tried many different of unpatched and patched 6.14.6 for a few hours and I could not get this same bug again.

After unsuccessfully attempting to reproduce with the kernel I have been running I decided to test the newest "PM_ Use hibernate flows for system power off" patch [1].

and that patch seems to help quickly poweroff my laptop when combined with the other mentioned patch.

> To confirm if "PCI: Explicitly put devices into D0 when initializing" is the cause can you compare the PCI state of all devices from sysfs with and without the patch in place after bootup?  Basically run this in patched kernel and unpatched kernel and let's compare.
>
> $ grep -v foo /sys/bus/pci/devices/*/power_state
>
>
unpatched: https://pastebin.com/Ym31Vjh6
patched with just "PCI: Explicitly put devices into D0 when initializing": https://pastebin.com/SSSWLgcs

diff for easy view: https://www.diffchecker.com/y5GVyEG1/


two devices were D3hot and two were unknown, while now are recognized as D0.


Having those two patches together does not seem to cause any harm and I could not reproduce the issue.

I do not believe any of those patches are the cause for the particular crash I experienced, however I do believe there is something wrong going on because on power on the amdgpu on the thunderbolt card sometimes is there sometimes is not and I have to unplug and replug it for it to work.

The only patch that alleviates this particular problem is [2] "[PATCH v3] PCI: Prevent power state transition of erroneous device" but it comes with a regression where I can no longer wake up the laptop properly.

I will write this in detail as a response to that patch given that was not part of the subject here.

[2] https://lore.kernel.org/linux-pci/aCLNe2wHTiKdE5ZO@wunner.de/T/#m90fb151a4ab4af5ec8c667a27eb98bf43a9942dc

> [1] https://lore.kernel.org/linux-pm/20250512212628.2539193-1-superm1@kernel.org/T/#u

