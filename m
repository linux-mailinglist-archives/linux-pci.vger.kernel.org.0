Return-Path: <linux-pci+bounces-34454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9793B2F87A
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 14:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D12D60557B
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 12:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B0031197D;
	Thu, 21 Aug 2025 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W21/DPCq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7130331196E;
	Thu, 21 Aug 2025 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780097; cv=none; b=B6iay7zpaVF1X2kB3wiliMixMUpcQSGtEbegDB326RHRzVa8Lfp2XxwQ3WXVeVLuyQjLoQv9CAYvR2OSOBg4+JtJcqXScN78PswzvP7eYiSdLHKRIhIA52DJ4o2n71BAZd6uXN3Fau5uyd5XtwfIdQmx/Sx0+1uEvIbcCZ93kKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780097; c=relaxed/simple;
	bh=vMbgsNjjm4zsv6kHeB79Iza9JJ78/9jVyLQ06lZ4lRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNcoSAHWOllbRkM8/SUwwcFM/glpkiW0AC0AouzL/V+sNYAhhkSXQ6o1LfaDnqvuNIHC6HhfAyDUdyO/jYrUvxZUbHQJaFQsRB3icfbL+9BlbGKiYGptV+9ne0ujvCy1inZeSNT1CaRhtH+KdOhxiJLPhBcOSsI1pwxWBmmL1Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W21/DPCq; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3b9e413a219so710812f8f.3;
        Thu, 21 Aug 2025 05:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755780093; x=1756384893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K/rXJGPFK3wi2vxqTh6d3zW1dWSC1/Ce4Xx/Ix7y1KE=;
        b=W21/DPCq+WrHPfgm62YAf8HNr1wWZVlKVf4t/g+Ii0WfIWZuV4BK9pxPkpFx0pChxY
         Hn/7mOPX5y65MUKipsLwMoxJudxT2j/eEglv9sT2EyaJOufkmZQBfmtRcDuF6+5AHwB5
         cDBh0fcvYX52d06Wobr3D9uLH7sJQ1l/eBKHLrX8m6EUJQAqXA8tCLsKsod66e6qNUvd
         cTsKJVANayCeW8BXVVDkENju8Bw7RILNrxoF/zlK8SKvVc2OuxSh90kiIP/LJ8xbI4LF
         SnftMwJQGtNNkVcgN9hlxru2zQdhx5HPdzM/gO6jzpYJLuIgfqp+zqbrBk/FF50CgdoG
         uWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755780093; x=1756384893;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/rXJGPFK3wi2vxqTh6d3zW1dWSC1/Ce4Xx/Ix7y1KE=;
        b=pP30lUQ3lU9xwmNBbOeFzZPkbTtBFP4pqAcQDp4BE76ZW+3r/gGhfAcoBQSyWvQk5R
         5gwp++YyXypqu+BYv/Vhha4KsOMmJsv2RPCXsiA6XCdpoyDLhE8FxzHdFUfNwb6DFFGM
         qaNSiDND13I9cbEj1cPVrGX+kJo//M/qISETxsVy2Q+k6j2h4T2DDF7LcDXUqJIqFTtk
         EPlWagiTU1WimKWzIlBIUYWFQEMrmney18XEBomXVBhwFOQlqlCfvh0I1glGxNtdbqa4
         rHF+B9aBJQsCzqM7jxxco0ESXNIg/cAG3+p3Pys7f2UcZOrdYTF6YLRGxw3ZQ8ZQMcmp
         aDNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnvWsmLdu4XwPPBFqXXLay34ibjSlGjZbJkacajlWSHYZ8VDAPNSb3LHQLV6pZyOjMUWah09PLxA7BCac=@vger.kernel.org, AJvYcCWq/BLhd32VHuzpVVVBp764WbDXASlJqbMJDCRTedN0dRw5DhpANim+9HLoare6yKeJsfKgu+mDILjQ@vger.kernel.org, AJvYcCXhi0KJOcFeQXYAc24astv0F7/fXnm0zXyFi6WvEBbGgjkovXlvJw5nAt1Q5fwLLc1ikvs3mF9K@vger.kernel.org
X-Gm-Message-State: AOJu0YwEZd7+weyWduSN0Hko1WhPgbR8hMiLixSrYm7a7sXhDjWO5ZcL
	CzDk3ShPUJ8S1LnUYujhG1Hu7sXQAsmeDlJBherxRDuB3C0LM7YeuhAa7py5iLxX
X-Gm-Gg: ASbGnctTD7MQp3f2OoHR4lBsJR6mRGgY9HMDYoNgLRigWbjNgsSNO1lbjEpGssbpMJO
	LR6B2KgL+k/vJij108tNDWB260X8kKmcfeKql1WxUCFkyGU7isf8UWblCY+O1ZmVrnI2lUaSQJB
	tU7rx6stQggppVvuxq+frcU5JJ02WluewieBkLS6GKu1s5tkNeq2VIvrBI1eAuxJTakHmwlryQY
	FrZDxVaiCOAO0P/NeAy0KKDGGfMcUdE8tV+SBEPtMvpXSvFnfi8NN9qLtQnWAaFe+qrEFybD2fw
	nYItP5+PWaFvdzFxwMSLdYzYWQATvFIW33vIujWRjLZQK+kBx2uRmBXkPEV3IWVLfz0hjkZyJlB
	3OkqFZKGu+pqM0p+zlu3pEaRay/enwDMl743zZjNUVZQ1W6buX4oEaSoO78+QeF6+KnFEqilcMC
	UuwdC8EyOS3Q9yjjyPRr1TeZNBa/nsD0dOmu2onHfq2l0nDmQ3D4wG
X-Google-Smtp-Source: AGHT+IGcpDcX/P1q3uGkxcuaxRs1676Mc/G7jVz/fGjilz+IUOZqIoSzLB5QGJrKSrKiTI0QC2xV8g==
X-Received: by 2002:a05:6000:4284:b0:3b5:f0af:4bb0 with SMTP id ffacd0b85a97d-3c495687e00mr2017211f8f.23.1755780093100;
        Thu, 21 Aug 2025 05:41:33 -0700 (PDT)
Received: from [26.26.26.1] (ec2-63-178-255-169.eu-central-1.compute.amazonaws.com. [63.178.255.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c3e673ab01sm4930549f8f.18.2025.08.21.05.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 05:41:32 -0700 (PDT)
Message-ID: <048bd3c4-887c-4d17-9636-354cc626afa3@gmail.com>
Date: Thu, 21 Aug 2025 20:41:28 +0800
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
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <aKaK4WS0pY0Nb2yi@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/21/2025 10:56 AM, Brian Norris wrote:
> On Thu, Aug 21, 2025 at 08:54:52AM +0800, Ethan Zhao wrote:
>> On 8/21/2025 1:26 AM, Brian Norris wrote:
>>> From: Brian Norris <briannorris@google.com>
>>>
>>> max_link_speed, max_link_width, current_link_speed, current_link_width,
>>> secondary_bus_number, and subordinate_bus_number all access config
>>> registers, but they don't check the runtime PM state. If the device is
>>> in D3cold, we may see -EINVAL or even bogus values.
>> My understanding, if your device is in D3cold, returning of -EINVAL is
>> the right behavior.
> 
> That's not the guaranteed result though. Some hosts don't properly
> return PCIBIOS_DEVICE_NOT_FOUND, for one. But also, it's racy -- because
> we don't even try to hold a pm_runtime reference, the device could
> possibly enter D3cold while we're in the middle of reading from it. If
> you're lucky, that'll get you a completion timeout and an all-1's
> result, and we'll return a garbage result.
> 
> So if we want to purposely not resume the device and retain "I can't
> give you what you asked for" behavior, we'd at least need a
> pm_runtime_get_noresume() or similar.
I understand you just want the stable result of these caps, meanwhile
you don't want the side effect either.>
>>> Wrap these access in pci_config_pm_runtime_{get,put}() like most of the
>>> rest of the similar sysfs attributes.
>>>
>>> Fixes: 56c1af4606f0 ("PCI: Add sysfs max_link_speed/width, current_link_speed/width, etc")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Brian Norris <briannorris@google.com>
>>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>>> ---
>>>
>>>    drivers/pci/pci-sysfs.c | 32 +++++++++++++++++++++++++++++---
>>>    1 file changed, 29 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>>> index 5eea14c1f7f5..160df897dc5e 100644
>>> --- a/drivers/pci/pci-sysfs.c
>>> +++ b/drivers/pci/pci-sysfs.c
>>> @@ -191,9 +191,16 @@ static ssize_t max_link_speed_show(struct device *dev,
>>>    				   struct device_attribute *attr, char *buf)
>>>    {
>>>    	struct pci_dev *pdev = to_pci_dev(dev);
>>> +	ssize_t ret;
>>> +
>>> +	pci_config_pm_runtime_get(pdev);
>> This function would potentially change the power state of device,
>> that would be a complex process, beyond the meaning of
>> max_link_speed_show(), given the semantics of these functions (
>> max_link_speed_show()/max_link_width_show()/current_link_speed_show()/
>> ....),
>> this cannot be done !
> 
> What makes this different than the 'config' attribute (i.e., "read
> config register")? Why shouldn't that just return -EINVAL? I don't
> really buy your reasoning -- "it's a complex process" is not a reason
It is a reason to know there is side effect to be taken into account.> 
not to do something. The user asked for the link speed; why not give it?
> If the user wanted to know if the device was powered, they could check
> the 'power_state' attribute instead.
> 
> (Side note: these attributes don't show up anywhere in Documentation/,
> so it's also a bit hard to declare "best" semantics for them.)
> 
> To flip this question around a bit: if I have a system that aggressively
> suspends devices when there's no recent activity, how am I supposed to
> check what the link speed is? Probabilistically hammer the file while
> hoping some other activity wakes the device, so I can find the small
> windows of time where it's RPM_ACTIVE? Disable runtime_pm for the device
> while I check?
Hold a PM reference by pci_config_pm_runtime_get() and then write some
data to the PCIe config space, no objection.

To know about the linkspeed etc capabilities/not status, how about
creating a cached version of these caps, no need to change their
power state.

If there is aggressive power saving requirement, and the polling
of these caps will make up wakeup/poweron bugs.


Thanks,
Ethan







> 
> Brian


