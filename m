Return-Path: <linux-pci+bounces-34500-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3C5B30AA8
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 03:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DF7688642
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 01:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBAB19D06B;
	Fri, 22 Aug 2025 01:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHSqCCiB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E75774040;
	Fri, 22 Aug 2025 01:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755825092; cv=none; b=S0AEPfH+S6N8oJdAC8QR8Tv7NqaBj9x7nRQ4PO5/v1kMKJ3eK+N1ozSm2vb8hCPHgmAYeufDroXLIqzsSoEUfYGRAid7PwTV/OL5uZrs0BMes6CEMRrGHrAYxsJo9LqvPNcZxTtHUEoypX+PIFpZmGWUhiIrYl2v8Nv+9jfe9jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755825092; c=relaxed/simple;
	bh=ZZw1Gi5SlK07TGgYQuoVdyVOJgmxZ6EJHyu6KbbhO3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYvOKBCS81JbRR3HCVuu1WWVdp8Z426fHZnN5mNE9VhEaC5eA0W01Q9UDh52Re3OuLNprfRDl6s/JnT0R04kl8/h2ElBi8gsl6oBDQUiNVjXruapEqDGeHPupp+nKrddHHp3s1ql/LKXXhS69Nn4kjTItb1EQuvgVl5WlQswldM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHSqCCiB; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-45a1b0bde14so8562175e9.2;
        Thu, 21 Aug 2025 18:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755825089; x=1756429889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xz6hDvWf0PXsi+emFDG8/Y7AYRpkSFBEs3I/9AbaJzQ=;
        b=hHSqCCiB6YMvVlQzA/HS3SvzDWln13ELXED3fEUJQ1dqaOG1vLARbmdALgcMg/FvNL
         n7e8iChjnfwpklkXbbMPeM/sIcKKPoZRPanSfWHduAoVB5IsKK5IXBwJwdBprCaMTrZx
         0O+qj9Yfe4iBqLtcQcOUvNVy6KDPtLbHCZLsCADzeG9E/zUYUqq6GDdiqjWVNQPPcj18
         C77EWQ5OwMSSFD9vVhEl9a4KOAy4xkkxEmn+bng0TNHpij4UaghJ6AIISd67D5TrRlnf
         vffqhcivpX2d1Kbiv43xJiodXgYmT6LM9/lz0a8tmt6Wd1xD3dhy16dffoLCxZH3F6fe
         O99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755825089; x=1756429889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xz6hDvWf0PXsi+emFDG8/Y7AYRpkSFBEs3I/9AbaJzQ=;
        b=YKUJ16XeieFDH6UPBuFqnqp3XPZhLYYYcF1OVfIxMqqpl5P+bLEpTxOOR1zeXIulES
         jPS6NHzAuM+lEu8sJVzb1/OFcAEKL/jU8s7hj3tleOKd8rZM7zL9pdFOp/GnBNpsp4mi
         FozhKTuM7j/TbEOyohJi6eHOHfK1PIcVfjp5d0sieK/bWu9LQrnikNzJifr+6947DGXB
         mr2kUuPj3S9m09+RkLIegRqvHOhdkjklyRy3EgfMHkZOjzS5hi5nkSXGqx3p8jX3zc4D
         NcaUbhwBiCfMuqDz4zvH1bObBjzYrtQB9n/acLb3CD94ypP/oexw1+SSA2D4kTBO66Ob
         RMGg==
X-Forwarded-Encrypted: i=1; AJvYcCUMqKo7+lB8kpUzHb8ZrPsGzvPYEF5TXJVsyhM+eKhhJuA4bs3iX7RwkzyYu6ndmhRd1gcRNzyE0mNe@vger.kernel.org, AJvYcCV3ryS5ip6VgsN/U0IlHwd0fMtq83Ou43S6go5Z2tDl57JY20P7q4oTidvj1DWjBJlCdIX8BF0TtP1kr3c=@vger.kernel.org, AJvYcCWHLwh1RAjNpIIUh01pF2GgnTDiDHxYVVFsPqmO7hKHEU/k6muJhEpjo5aARrYG4n46qwg6Zuaj@vger.kernel.org
X-Gm-Message-State: AOJu0YzODixu/eDs489KcEB0oi7IY4aPvkmCuucgeTtslf0Agf/2IJpU
	NYJizEuBPd0quQM7WGrZKzlCj+kE2Zu+fbMh4iYjHJvTIzErwTMVmpdR1c5hBVw+
X-Gm-Gg: ASbGncvlyHvbPxCNsiJrCdKFouQD2e+uv6LsXz003wgJStvt/daqIGLXLnDnylMJKFJ
	KITT0PRhNJFBu8cFyhf6GorJyxuUsKebWgLhTFbTLRGKTfdtaQXQw0s7zFpLm+j4wPZYvz7hj4v
	oEr65uXggvlruUXWukjpscsrXKw3iK65gMgnmHrvmCLi7N/85l2CuJvT2y/8GYjf3uc3z2icLEB
	fdHYMDW8MaIrQRXRw9U2RaEGqTJB/7Ylbbjvc61reWiE0ttCo6IbybdKZJwEgC/jstffDBhL9r5
	fDdebsHTkVs71iK6EnFrWkIHUgOMNxFNAA/4oKKRbnjCOlWFR/A8f0Mkb/YCIVTse0cGla+lQla
	uWdqcSBMhdQYB9uuTSRxP54fAfQLcDtzw3VeteCHLkpUmFewEfd/d/WWJGnhSBVCD74CQqpa291
	vuKK3lGiXs5KVE6Htg8aqslCEQtzZ1q0qts3lYiGHRO9kzExftJw==
X-Google-Smtp-Source: AGHT+IFhFpnfdSnJarsN3EZ625iyVag3gHCiBziDcw+PdU2/iLw9spk21RyJ98AyLzMnK2/mbPMRxg==
X-Received: by 2002:a05:600c:1f0d:b0:458:bbed:a812 with SMTP id 5b1f17b1804b1-45b517b961cmr7837455e9.17.1755825088210;
        Thu, 21 Aug 2025 18:11:28 -0700 (PDT)
Received: from [26.26.26.1] (ec2-3-126-215-244.eu-central-1.compute.amazonaws.com. [3.126.215.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b50e3a587sm17402245e9.18.2025.08.21.18.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 18:11:27 -0700 (PDT)
Message-ID: <da46b882-0cd3-48cd-b4fc-b118b25e1e7e@gmail.com>
Date: Fri, 22 Aug 2025 09:11:25 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/sysfs: Ensure devices are powered for config reads
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, stable@vger.kernel.org
References: <20250820102607.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid>
 <dfdc655e-1e06-42df-918f-7d56f26a7473@gmail.com>
 <aKaK4WS0pY0Nb2yi@google.com>
 <048bd3c4-887c-4d17-9636-354cc626afa3@gmail.com>
 <aKc7D78owL_op3Ei@google.com>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <aKc7D78owL_op3Ei@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/21/2025 11:28 PM, Brian Norris wrote:
> Hi Ethan,
> 
> Note: I'm having a hard time reading your emails sometimes, because you
> aren't really adding in appropriate newlines that separate your reply
> from quoted text. So your own sentences just run together with parts of
> my sentences at times. I've tried to resolve this as best I can.
> 
> On Thu, Aug 21, 2025 at 08:41:28PM +0800, Ethan Zhao wrote:
>>
>>
>> On 8/21/2025 10:56 AM, Brian Norris wrote:
>>> On Thu, Aug 21, 2025 at 08:54:52AM +0800, Ethan Zhao wrote:
>>>> On 8/21/2025 1:26 AM, Brian Norris wrote:
>>>>> From: Brian Norris <briannorris@google.com>
>>>>>
>>>>> max_link_speed, max_link_width, current_link_speed, current_link_width,
>>>>> secondary_bus_number, and subordinate_bus_number all access config
>>>>> registers, but they don't check the runtime PM state. If the device is
>>>>> in D3cold, we may see -EINVAL or even bogus values.
>>>> My understanding, if your device is in D3cold, returning of -EINVAL is
>>>> the right behavior.
>>>
>>> That's not the guaranteed result though. Some hosts don't properly
>>> return PCIBIOS_DEVICE_NOT_FOUND, for one. But also, it's racy -- because
>>> we don't even try to hold a pm_runtime reference, the device could
>>> possibly enter D3cold while we're in the middle of reading from it. If
>>> you're lucky, that'll get you a completion timeout and an all-1's
>>> result, and we'll return a garbage result.
>>>
>>> So if we want to purposely not resume the device and retain "I can't
>>> give you what you asked for" behavior, we'd at least need a
>>> pm_runtime_get_noresume() or similar.
>> I understand you just want the stable result of these caps,
> 
> Yes, I'd like a valid result, not EINVAL. Why would I check this file if
> I didn't want the result?
> 
>> meanwhile
>> you don't want the side effect either.
> 
> Personally, I think side effect is completely fine. Or, it's just as
> fine as it is for the 'config' attribute or for 'resource_N_size'
> attributes that already do the same.
> 
>>>>> Wrap these access in pci_config_pm_runtime_{get,put}() like most of the
>>>>> rest of the similar sysfs attributes.
>>>>>
>>>>> Fixes: 56c1af4606f0 ("PCI: Add sysfs max_link_speed/width, current_link_speed/width, etc")
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Brian Norris <briannorris@google.com>
>>>>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>>>>> ---
>>>>>
>>>>>     drivers/pci/pci-sysfs.c | 32 +++++++++++++++++++++++++++++---
>>>>>     1 file changed, 29 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>>>>> index 5eea14c1f7f5..160df897dc5e 100644
>>>>> --- a/drivers/pci/pci-sysfs.c
>>>>> +++ b/drivers/pci/pci-sysfs.c
>>>>> @@ -191,9 +191,16 @@ static ssize_t max_link_speed_show(struct device *dev,
>>>>>     				   struct device_attribute *attr, char *buf)
>>>>>     {
>>>>>     	struct pci_dev *pdev = to_pci_dev(dev);
>>>>> +	ssize_t ret;
>>>>> +
>>>>> +	pci_config_pm_runtime_get(pdev);
>>>> This function would potentially change the power state of device,
>>>> that would be a complex process, beyond the meaning of
>>>> max_link_speed_show(), given the semantics of these functions (
>>>> max_link_speed_show()/max_link_width_show()/current_link_speed_show()/
>>>> ....),
>>>> this cannot be done !
>>>
>>> What makes this different than the 'config' attribute (i.e., "read
>>> config register")? Why shouldn't that just return -EINVAL? I don't
>>> really buy your reasoning -- "it's a complex process" is not a reason
>> It is a reason to know there is side effect to be taken into account.
> 
> OK, agreed, there's a side effect. I don't think you've convinced me the
> side effect is bad though.
> 
>>> not
>>> to do something. The user asked for the link speed; why not give it?
>>> If the user wanted to know if the device was powered, they could check
>>> the 'power_state' attribute instead.
>>>
>>> (Side note: these attributes don't show up anywhere in Documentation/,
>>> so it's also a bit hard to declare "best" semantics for them.)
>>>
>>> To flip this question around a bit: if I have a system that aggressively
>>> suspends devices when there's no recent activity, how am I supposed to
>>> check what the link speed is? Probabilistically hammer the file while
>>> hoping some other activity wakes the device, so I can find the small
>>> windows of time where it's RPM_ACTIVE? Disable runtime_pm for the device
>>> while I check?
>> Hold a PM reference by pci_config_pm_runtime_get() and then write some
>> data to the PCIe config space, no objection.
>>
>> To know about the linkspeed etc capabilities/not status, how about
>> creating a cached version of these caps, no need to change their
>> power state.
> 
> For static values like the "max" attributes, maybe that's fine.
> 
> But Linux is not always the one changing the link speed. I've seen PCI
> devices that autonomously request link-speed changes, and AFAICT, the
> only way we'd know in host software is to go reread the config
> registers. So caching just produces cache invalidation problems.
Maybe you meant the link-speed status, that would be volatile based on
link retraining.
Here we are talking about some non-volatile capabilities value no
invalidation needed to their cached variables.>
>> If there is aggressive power saving requirement, and the polling
>> of these caps will make up wakeup/poweron bugs.
> 
> If you're worried about wakeup frequency, I think that's a matter of
> user space / system administraction to decide -- if it doesn't want to
> potentially wake up the link, it shouldn't be poking at config-based
IMHO, sysfs interface is part of KABI, you change its behavior , you
definitely would break some running binaries. there is alternative
way to avoid re-cooking binaries or waking up administrator to modify
their configuration/script in the deep night. you already got it.

Thanks,
Ethan  > sysfs attributes.
> 
> Brian


