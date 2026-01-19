Return-Path: <linux-pci+bounces-45173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B86D3A79E
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 12:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E9FE3060597
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 11:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A156931BC95;
	Mon, 19 Jan 2026 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iphJyRm9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75A031B80B
	for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823833; cv=none; b=PJAmNWWuI9MZQaAPFSPWAfLHQUux24HwfM2poYeTiM3qvH3O0O9h9GWqRqA1KdFvROH1kfWCzOZfy9NagBrq5/lbWV3IsMVALzsaLqHVIQ3OkOjshSJpPfk5W5PIyDKPf0HfU0fqNmLaqrOvocjA67dfTZHgG4f/NzqU3o0OAH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823833; c=relaxed/simple;
	bh=lN49dSWIXSzQVQ/AGceCiuBR2wnRoz/OfIwf9iCXlXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oeFvKryNOSj7FxBUkOKPLku+hGxMdvbWEuO4eESVHQETnl+mz48LnyIL/ga1F7Qhbt6LYZzuI/tTZsszr3gALGd5ScLHkov4d7TNfPiBg0xmL6JihAsx/fdpZJou/3/JyEJDhRp2x7pZLaKY/YD9F9mw1qpcaSeMDoe1rHrt6tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iphJyRm9; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so2272664f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 03:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768823830; x=1769428630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rU5rVNMH9FwuytnsYY8KQix/3Ww8tOMfufmDlvcm95A=;
        b=iphJyRm9MQ12u/fFaW4glSZ4FTpDK0y7Dyy4wgkB3/5YKCt0lLWIamzROXv7urDwft
         7MAgAC94WfKPNItuSoGZW7dqV0JgP2VTWXvDaUVg3fK50fZwVEXCHQUXgak+V21fSUhO
         1Ply2Vf/CRlcM9JGLCIm3frAjISjxENPR2IwT+eIXxpxAKpffIeJmdETCp5+uGSuEZQ9
         XNz/9xCGEg3p5dzcA7bvUypsYNI/djWDPh8XEKL7pm3RRqbM9bsu5jcUNmkMZVReLXXn
         DOPE0K9TsuFe5oBWqirNK1FPEAPHywsW+NcUgwVUFjBWoQhvdpk6Jk4hbYB0xik3c21s
         Bj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768823830; x=1769428630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rU5rVNMH9FwuytnsYY8KQix/3Ww8tOMfufmDlvcm95A=;
        b=YPlosUyDr0rVjVnu4yeBPxS+c3uNbwe0Nhx2mvljIHn2YZ0YuNWb9AdBrOYs5UrHz3
         LSCNB78ttUwprp5CxAMLPxh4jDLorupoQ5BnqUNWVK3IjbmJpdm9KsRm+ZS2CGIWihNK
         l9ROjgNi79qAUWFbCbcOZdnYmeMgWEFTAzrCVzMDNgERQ7WFv5Pfr72asap9TNOcFfa6
         mVP3dZyt57IECnZJ63OPNPeHvru1uoa9xvtUOdVk4hWPinj7ZSyiXgg5ax2G+FWbE6w8
         EiRUFjqq91CeUKchh1A9dlxbJTyKRTo82S4WRDma0qBG9N1+vHuMZG9oFN4fF5l8Nt/P
         0u/A==
X-Forwarded-Encrypted: i=1; AJvYcCWSRMrEiUDtuFlEL9xNptxuKF/qceVtv17COP8srxSlmsmnKdgMZZqhA1GmnpQxjyBlq6apgJGAN84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl0iOs6JZPTFO+yTts9rmZHy06OCgeYzCBXGGEq7ypHnYJRJHA
	b92kkecZLoz994RH6o7DZfPUVIC2+ROJ/VHekjySmYUHi8Y8J6Q0eMnt
X-Gm-Gg: AZuq6aLIv9cPgOCGfPZdgZBqXTjwhhfyz3IAYmtVt4v8qgUyR5a4FnAeJYXnsXJ7Fpa
	kgAQTne+SuVk63PVYYDKQA7rbarRENdiBGn4EQtCVaKwe5SMkpPe04q9ZE3X9XpVE7QAncOTtll
	YicCXj4u3rgOJYe69gO4QVpwHC2zEA6jPEQ91NI5GSsZEC5J4Jo3sSlw6dMsfNq9RMxaVe9ldL1
	wnpXaPLdzos/xqk+7z89icBPIThyhIPndL3Ua9KHBJPtN8Uu/Hit2CbA4/9oz40aKR4gl3RQRiH
	mcptvtT8yLhoZBFqDqLqn3gPvfynHtzrk9Humb/OZlIbJSwIa93P7nM0elqJAs1Jy9NCXvZP93r
	sisvMHPrufh8K6uY0BufD1OyADAZm4wEiBaySnSjrg1N3t2XzmFHGYL4sCJSqM7hkMa8lF0hf+z
	o2l3qq99Wh2ARJV7GKZNIz08AZRlDM6naYXIUevkkt6PrD9RJ6GCHV+TqE/2NcmHeynRWnlk7Q+
	O7G+6haTfUSNHrrfNdkU58bOFsx8CDSmWo0e7zwuZIzHg==
X-Received: by 2002:a5d:5d03:0:b0:431:a50:6ead with SMTP id ffacd0b85a97d-4356a02c4e5mr12617439f8f.20.1768823829908;
        Mon, 19 Jan 2026 03:57:09 -0800 (PST)
Received: from ?IPV6:2003:f6:f71c:a900:884f:578f:4f43:4e3f? (p200300f6f71ca900884f578f4f434e3f.dip0.t-ipconnect.de. [2003:f6:f71c:a900:884f:578f:4f43:4e3f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569927007sm22420038f8f.16.2026.01.19.03.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 03:57:09 -0800 (PST)
Message-ID: <a3e23d6c-8cbf-42be-8ca9-3fd68dca6998@gmail.com>
Date: Mon, 19 Jan 2026 12:56:14 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/ACPI: Confine program_hpx_type2 to the AER bits
To: Bjorn Helgaas <helgaas@kernel.org>, Haakon Bugge <haakon.bugge@oracle.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@suse.de>,
 Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Johannes Thumshirn <jth@kernel.org>, Myron Stowe <myron.stowe@redhat.com>
References: <20260116211135.GA959225@bhelgaas>
Content-Language: en-US
From: Johannes Thumshirn <morbidrsa@gmail.com>
In-Reply-To: <20260116211135.GA959225@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/16/26 10:11 PM, Bjorn Helgaas wrote:
> [+cc Johannes (author of e42010d8207f ("PCI: Set Read Completion
> Boundary to 128 iff Root Port supports it (_HPX)"), Myron; start of
> thread:
> https://lore.kernel.org/r/20260113171522.3446407-1-haakon.bugge@oracle.com]
>
> On Fri, Jan 16, 2026 at 10:10:43AM +0000, Haakon Bugge wrote:
>>> On Thu, Jan 15, 2026 at 03:39:21PM +0000, Haakon Bugge wrote:
>>>> Thanks for the review, Bjørn!
>>>> ...
> I should have mentioned this earlier, but I think the commit log
> should include something about the problem this change fixes.  I
> assume that the current code changes ExtTag and/or RO, and that causes
> something bad.  That's what is motivating this change.
>
>>>>>> if (pcie_cap_has_lnkctl(dev)) {
>>>>>> + u16 lnkctl;
>>>>>>
>>>>>> - /*
>>>>>> -  * If the Root Port supports Read Completion Boundary of
>>>>>> -  * 128, set RCB to 128.  Otherwise, clear it.
>>>>>> -  */
>>>>>> - hpx->pci_exp_lnkctl_and |= PCI_EXP_LNKCTL_RCB;
>>>>>> - hpx->pci_exp_lnkctl_or &= ~PCI_EXP_LNKCTL_RCB;
>>>>>> - if (pcie_root_rcb_set(dev))
>>>>>> - hpx->pci_exp_lnkctl_or |= PCI_EXP_LNKCTL_RCB;
>>>>>> -
>>>>>> - pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
>>>>>> - ~hpx->pci_exp_lnkctl_and, hpx->pci_exp_lnkctl_or);
>>>>>> + pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
>>>>>> + if (lnkctl)
>>>>>> + pci_warn(dev, "Some bits in PCIe Link Control are set: 0x%04x\n",
>>>>>> +  lnkctl);
>>>>>>
>>>>> Sorry, I wasn't clear about this.  I meant that we could log the
>>>>> LNKCTL AND/OR values from _HPX, not the values from
>>>>> PCI_EXP_LNKCTL itself.  There will definitely be bits set in
>>>>> PCI_EXP_LNKCTL in normal operation, which is perfectly fine.
>>>>>
>>>>> But if pci_exp_lnkctl_and or pci_exp_lnkctl_or are non-zero, the
>>>>> platform is telling us to do something, and we're ignoring it.
>>>>> *That's* what I think we might want to know about.  pci_info()
>>>>> is probably sufficient; the user doesn't need to *do* anything
>>>>> with it, I just want it in case we need to debug an issue.
>>>> My bad, Yes, that makes more sense to me. And, you're OK with
>>>> removing the RCB tweaking as well?
>>> Good question.  My hope is that the code here is just to make sure
>>> that we don't *clear* PCI_EXP_LNKCTL_RCB when we want it set but a
>>> type 2 record might clear it by mistake.
>> Commit e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff
>> Root Port supports it (_HPX)") fixes the "opposite" case, where _HPX
>> sets the RCB even though the RC does not support it. That commit
>> removes any RCB setting from the type 2 record from the equation,
>> and sets RCB if the RC has the bit set. And to me, that seems to be
>> the correct behaviour.
> Thanks for digging into that.  You're right that it looks like
> e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff Root Port
> supports it (_HPX)") was motivated by a machine with a Root Port with
> PCI_EXP_LNKCTL_RCB cleared, but an _HPX record telling us to set
> PCI_EXP_LNKCTL_RCB.

IIRC (this is nearly 10 years old) that's been the case. But back then 
it clearly was a bios issue, but we decided to fix it in the kernel if 
my memory serves me well.


