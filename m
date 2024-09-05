Return-Path: <linux-pci+bounces-12799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E03E496CBCF
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 02:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971351F2738C
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 00:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8081A621;
	Thu,  5 Sep 2024 00:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRvFpIAy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561DA4A33;
	Thu,  5 Sep 2024 00:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725496419; cv=none; b=GvM2zLsSKBrjNYSyITG1gLtS5lk6xwiaakFILwf6iHvRUm8vE0G9kZAfm6OBqbEh7UuLT+oKbzKjF3sQPtfBrwDB36mKk8Kl5WYI462nPt4zj6xr1nuvp+0gtqL0wriTn7irdEAfPnC9Q1b7hYFffPrOxBoWE/sRRQjlFWm4HCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725496419; c=relaxed/simple;
	bh=fzt1B8Us93+SiK9aJ2QOG+7wx9bwY1q2znDa7Ktu+nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVmmCxyQTptCRGrk/S06rov3OZkLwSY7rBKw2DiqbydC20Q/+unRghoTKKshEVrztlgZFsZbKzdVaCXx9M2E2wGwvr0yfeX2p6d/5K1s/LHBcNZmHP6J1APBHFTPwAL02DSl/Qx6qr8j4woIhqAiPtkab3HJzl98PK0rDZYX0AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRvFpIAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2116C4CEC2;
	Thu,  5 Sep 2024 00:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725496418;
	bh=fzt1B8Us93+SiK9aJ2QOG+7wx9bwY1q2znDa7Ktu+nw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KRvFpIAyty9efxq7106JkzacvXq/rZa5FlKBthp+O3d53sAu5N0Go365xFTCGsuwl
	 uWgyD5vUbxHKGxB5WkuKauoIZTwM5Boq1q4WlMw6R4qKzgKfrwyuOlasNw08QGKmAo
	 d5oD5u3M33lB0rU7BfuBswMOdRE5KPv8DhuYWKcPv0MKHOGlFO9nu2WtxUrYT0iE2M
	 o4sdDsS4QyKy6Rkys7CvadBckQrPNGOQHnnEgINvaIrkF3js8eFsF1TSUmbzhtzrNu
	 +gGp4iH6Cluz9FsnrJ67dY+aGpiGG64VLKwkfpWAiG5It8+G6X7pvPjRXc7BXS+OaT
	 WpwI1fKN4juzw==
Message-ID: <65fe5c47-e420-4b4d-a575-2bb90e13482c@kernel.org>
Date: Thu, 5 Sep 2024 09:33:35 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
To: Alex Williamson <alex.williamson@redhat.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Philipp Stanner <pstanner@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240725120729.59788-2-pstanner@redhat.com>
 <20240903094431.63551744.alex.williamson@redhat.com>
 <2887936e2d655834ea28e07957b1c1ccd9e68e27.camel@redhat.com>
 <24c1308a-a056-4b5b-aece-057d54262811@kernel.org>
 <dcbf9292616816bbce020994adb18e2c32597aeb.camel@redhat.com>
 <20240904120721.25626da9.alex.williamson@redhat.com>
 <ZtjCFR3kd5GfV_6m@surfacebook.localdomain>
 <20240904151020.486f599e.alex.williamson@redhat.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240904151020.486f599e.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/09/05 6:10, Alex Williamson wrote:
> On Wed, 4 Sep 2024 23:24:53 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
>> Wed, Sep 04, 2024 at 12:07:21PM -0600, Alex Williamson kirjoitti:
>>> On Wed, 04 Sep 2024 15:37:25 +0200
>>> Philipp Stanner <pstanner@redhat.com> wrote:  
>>>> On Wed, 2024-09-04 at 17:25 +0900, Damien Le Moal wrote:  
>>
>> ...
>>
>>>> If vfio-pci can get rid of pci_intx() alltogether, that might be a good
>>>> thing. As far as I understood Andy Shevchenko, pci_intx() is outdated.
>>>> There's only a hand full of users anyways.  
>>>
>>> What's the alternative?  
>>
>> From API perspective the pci_alloc_irq_vectors() & Co should be used.
> 
> We can't replace a device level INTx control with a vector allocation
> function.
>  
>>> vfio-pci has a potentially unique requirement
>>> here, we don't know how to handle the device interrupt, we only forward
>>> it to the userspace driver.  As a level triggered interrupt, INTx will
>>> continue to assert until that userspace driver handles the device.
>>> That's obviously unacceptable from a host perspective, so INTx is
>>> masked at the device via pci_intx() where available, or at the
>>> interrupt controller otherwise.  The API with the userspace driver
>>> requires that driver to unmask the interrupt, again resulting in a call
>>> to pci_intx() or unmasking the interrupt controller, in order to receive
>>> further interrupts from the device.  Thanks,  
>>
>> I briefly read the discussion and if I understand it correctly the problem here
>> is in the flow: when the above mentioned API is being called. Hence it's design
>> (or architectural) level of issue and changing call from foo() to bar() won't
>> magically make problem go away. But I might be mistaken.
> 
> Certainly from a vector allocation standpoint we can change to whatever
> is preferred, but the direct INTx manipulation functions are a
> different thing entirely and afaik there's nothing else that can
> replace them at a low level, nor can we just get rid of our calls to
> pci_intx().  Thanks,

But can these calls be moved out of the spinlock context ? If not, then we need
to clarify that pci_intx() can be called from any context, which will require
changing to a GFP_ATOMIC for the resource allocation, even if the use case
cannot trigger the allocation. This is needed to ensure the correctness of the
pci_intx() function use. Frankly, I am surprised that the might sleep splat you
got was not already reported before (fuzzying, static analyzers might eventually
catch that though).

The other solution would be a version of pci_intx() that has a gfp flags
argument to allow callers to use the right gfp flags for the call context.


> 
> Alex
> 

-- 
Damien Le Moal
Western Digital Research


