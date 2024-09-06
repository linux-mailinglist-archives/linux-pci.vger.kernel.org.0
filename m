Return-Path: <linux-pci+bounces-12862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DE196E6E1
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 02:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B911F241B6
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 00:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8148EEB3;
	Fri,  6 Sep 2024 00:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkE5S8Fh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8764E8BF0;
	Fri,  6 Sep 2024 00:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725583035; cv=none; b=BXwAsXv51EOvvxhEwI9xPCwvm3WkprPOLFz9r3H7P6fzQNMH7iabz3IDoG7PL7+EJKBaygnyaIQjJfa0eDerMJMdFLpdGnKyCAMPUw/wSUb9KJbkx4yutUrTaBjTxQI6VZdQXO0MoM8BaoMCN0mr+mFcRwfBLGAWAMSs3JkU+SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725583035; c=relaxed/simple;
	bh=xMtci75vl+s2j3G5k3OK8Fk71gwHjAnhMnoSMR+CJlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kW2ZZAGk5TOz+lzngCwRtY7dXg7ipL+Dgf1Wq1agXXIrekydUz9iCmx+9oXTkk3i3sOp5d2w1PM8/YKfa3zgmi8Kuu0GRhtPsgJoBUYzNf3mZdY+5JrGXmnyhkO43ZJ9KGZSRSsPGnGNgJwvy4LYWIBwE9h8eCVaSF4G7sc0lpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkE5S8Fh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB60C4CEC3;
	Fri,  6 Sep 2024 00:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725583035;
	bh=xMtci75vl+s2j3G5k3OK8Fk71gwHjAnhMnoSMR+CJlI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jkE5S8FhvleKztX+KyZ8H3t6xn516/AKBDhDkKsp7ZaoIaFwRI7bbeaFTojlGMVcX
	 oSgif8TjKY4XD2AmTYcGefDkV4gggQtHGAST3kpcP943SYrPw/JEQMZ/jvAJHWWuIN
	 uVii+epLSSEuFTf/DDZmPWVgoarEaGfT8hQ9IPYoEM/0RZUJcivnaFHvJTpldhQxsd
	 s5bLosrJlaouj1sU+YNx/DUmSz7SULEL+QM9GpOCXsOFS0l9ULQ/faf0ABpg6McMPq
	 Hg7x3vUJIQXat/4PF2n8/zIGZfhwVavaysCGlYoxWqTwTDu0DCjLvsztegdtYW6PLI
	 /7aKFuuZYbUSA==
Message-ID: <2072aac8-cdab-40e3-806c-399d38e683f9@kernel.org>
Date: Fri, 6 Sep 2024 09:37:11 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
To: Philipp Stanner <pstanner@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240725120729.59788-2-pstanner@redhat.com>
 <20240903094431.63551744.alex.williamson@redhat.com>
 <2887936e2d655834ea28e07957b1c1ccd9e68e27.camel@redhat.com>
 <24c1308a-a056-4b5b-aece-057d54262811@kernel.org>
 <dcbf9292616816bbce020994adb18e2c32597aeb.camel@redhat.com>
 <20240904120721.25626da9.alex.williamson@redhat.com>
 <ZtjCFR3kd5GfV_6m@surfacebook.localdomain>
 <20240904151020.486f599e.alex.williamson@redhat.com>
 <65fe5c47-e420-4b4d-a575-2bb90e13482c@kernel.org>
 <6a17c02077543f98b72662a7189407d0452e6d47.camel@redhat.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <6a17c02077543f98b72662a7189407d0452e6d47.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/5/24 16:13, Philipp Stanner wrote:
> On Thu, 2024-09-05 at 09:33 +0900, Damien Le Moal wrote:
>> On 2024/09/05 6:10, Alex Williamson wrote:
>>> On Wed, 4 Sep 2024 23:24:53 +0300
>>> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>>
>>>> Wed, Sep 04, 2024 at 12:07:21PM -0600, Alex Williamson kirjoitti:
>>>>> On Wed, 04 Sep 2024 15:37:25 +0200
>>>>> Philipp Stanner <pstanner@redhat.com> wrote:  
>>>>>> On Wed, 2024-09-04 at 17:25 +0900, Damien Le Moal wrote:  
>>>>
>>>> ...
>>>>
>>>>>> If vfio-pci can get rid of pci_intx() alltogether, that might
>>>>>> be a good
>>>>>> thing. As far as I understood Andy Shevchenko, pci_intx() is
>>>>>> outdated.
>>>>>> There's only a hand full of users anyways.  
>>>>>
>>>>> What's the alternative?  
>>>>
>>>> From API perspective the pci_alloc_irq_vectors() & Co should be
>>>> used.
>>>
>>> We can't replace a device level INTx control with a vector
>>> allocation
>>> function.
>>>  
>>>>> vfio-pci has a potentially unique requirement
>>>>> here, we don't know how to handle the device interrupt, we only
>>>>> forward
>>>>> it to the userspace driver.  As a level triggered interrupt,
>>>>> INTx will
>>>>> continue to assert until that userspace driver handles the
>>>>> device.
>>>>> That's obviously unacceptable from a host perspective, so INTx
>>>>> is
>>>>> masked at the device via pci_intx() where available, or at the
>>>>> interrupt controller otherwise.  The API with the userspace
>>>>> driver
>>>>> requires that driver to unmask the interrupt, again resulting
>>>>> in a call
>>>>> to pci_intx() or unmasking the interrupt controller, in order
>>>>> to receive
>>>>> further interrupts from the device.  Thanks,  
>>>>
>>>> I briefly read the discussion and if I understand it correctly
>>>> the problem here
>>>> is in the flow: when the above mentioned API is being called.
>>>> Hence it's design
>>>> (or architectural) level of issue and changing call from foo() to
>>>> bar() won't
>>>> magically make problem go away. But I might be mistaken.
>>>
>>> Certainly from a vector allocation standpoint we can change to
>>> whatever
>>> is preferred, but the direct INTx manipulation functions are a
>>> different thing entirely and afaik there's nothing else that can
>>> replace them at a low level, nor can we just get rid of our calls
>>> to
>>> pci_intx().  Thanks,
>>
>> But can these calls be moved out of the spinlock context ? If not,
>> then we need
>> to clarify that pci_intx() can be called from any context, which will
>> require
>> changing to a GFP_ATOMIC for the resource allocation, even if the use
>> case
>> cannot trigger the allocation. This is needed to ensure the
>> correctness of the
>> pci_intx() function use.
> 
> We could do that I guess. As I keep saying, it's not intended to have
> pci_intx() allocate _permanently_. This is a temporary situation.
> pci_intx() should have neither devres nor allocation.
> 
>> Frankly, I am surprised that the might sleep splat you
>> got was not already reported before (fuzzying, static analyzers might
>> eventually
>> catch that though).
> 
> It's a super rare situation:
>  * pci_intx() has very few callers
>  * It only allocates if pcim_enable_device() instead of
>    pci_enable_device() ran.
>  * It only allocates when it's called for the FIRST TIME
>  * All of the above is only a problem while you hold a lock
> 
>>
>> The other solution would be a version of pci_intx() that has a gfp
>> flags
>> argument to allow callers to use the right gfp flags for the call
>> context.
> 
> I don't think that's a good idea. As I said, I want to clean up all
> that in the mid term.
> 
> As a matter of fact, there is already __pcim_intx() in pci/devres.c as
> a pure unmanaged pci_intx() as a means to split and then cleanup the
> APIs.

Yeah. That naming is in fact confusing. __pcim_intx() should really be named
pci_intx()...

> One path towards getting the hybrid behavior out of pci_intx() could be
> to rename __pcim_intx() to pci_intx_unmanaged() and port everyone who
> uses pci_enable_device() + pci_intx() to that version. That would be
> better than to have a third version with a gfp_t argument.

Sounds good. But ideally, all users that rely on the managed variant should be
converted to use pcim_intx() and pci_intx() changed to not call in devres. But
that may be too much code churn (I have not checked).


-- 
Damien Le Moal
Western Digital Research


