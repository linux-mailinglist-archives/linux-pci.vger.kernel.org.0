Return-Path: <linux-pci+bounces-12724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF9296B475
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 10:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49BB328A752
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 08:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C078417C99B;
	Wed,  4 Sep 2024 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYWX/bHD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9875D54BD4;
	Wed,  4 Sep 2024 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438360; cv=none; b=Uq717g1cHLW4AhkCycVApJDBeB2jUXTAiqXv7mulKfTu0P/fEArs83LJAiHX6uoXt5h2Ds9m0j8GstNTbWvWHb2oOjWeN+l0/n7+gGY9FONhADDuuib4zTyQUzS5nxz/LOa2jNgBoAQQo1YwKAhg2quygg8A6h77nDzpYx68tLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438360; c=relaxed/simple;
	bh=EhKAV4Qf0Qg5+BI1GAhGDeW8c9VEqh1XWveVsPZ7AtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tuj4LQy6EEf//FfiIesXP42vpZ7tcFoVUDj6MlGRLAjbi82zpQV6SrDJ9VkWSgOEe2uvfMO7LBQ+kDYHFNe7MdWgkAX3LSVbBnwQwF8gT+r3eE7Lnr+Yg/SMSOMhFIp5j/4lM3Jyk1rPk2t+wyi4OA8UUYB/9zqK3esa0CszJF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYWX/bHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0EAC4CEC5;
	Wed,  4 Sep 2024 08:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725438360;
	bh=EhKAV4Qf0Qg5+BI1GAhGDeW8c9VEqh1XWveVsPZ7AtE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DYWX/bHDcEfRV0u7+cpzdekTg5Kzu2TsXTxWC8kTeJ0UsRZocIi6POi3z8cQPcUVu
	 yytUv5995FV9nhgBwaQa/7GzCFBIscHh2mFpANMPKsfbjiyxF18urVEi9xL468CN12
	 dQnxMlETnvcFKRciW6YxBrEBOTLOM73EldNEL/1zh0N472w3q7cBuxGWyiAG3rYaPu
	 ER2ZfspT1l/VOo1dJ0+rPlaXP6cleKGhJBD5dq2MeOZHbSz4fLZUzWBYky6pyR7ocQ
	 /pgfV6LtY/kZwSCkXUtc42SRqntkQ/aHimdwNh4RCN2MVWseev4kDS3RhdoYW5bIad
	 VFkWq85niSx7Q==
Message-ID: <24c1308a-a056-4b5b-aece-057d54262811@kernel.org>
Date: Wed, 4 Sep 2024 17:25:57 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
To: Philipp Stanner <pstanner@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240725120729.59788-2-pstanner@redhat.com>
 <20240903094431.63551744.alex.williamson@redhat.com>
 <2887936e2d655834ea28e07957b1c1ccd9e68e27.camel@redhat.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <2887936e2d655834ea28e07957b1c1ccd9e68e27.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/09/04 16:06, Philipp Stanner wrote:
> On Tue, 2024-09-03 at 09:44 -0600, Alex Williamson wrote:
>> On Thu, 25 Jul 2024 14:07:30 +0200
>> Philipp Stanner <pstanner@redhat.com> wrote:
>>
>>> pci_intx() is a function that becomes managed if
>>> pcim_enable_device()
>>> has been called in advance. Commit 25216afc9db5 ("PCI: Add managed
>>> pcim_intx()") changed this behavior so that pci_intx() always leads
>>> to
>>> creation of a separate device resource for itself, whereas earlier,
>>> a
>>> shared resource was used for all PCI devres operations.
>>>
>>> Unfortunately, pci_intx() seems to be used in some drivers'
>>> remove()
>>> paths; in the managed case this causes a device resource to be
>>> created
>>> on driver detach.
>>>
>>> Fix the regression by only redirecting pci_intx() to its managed
>>> twin
>>> pcim_intx() if the pci_command changes.
>>>
>>> Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
>>
>> I'm seeing another issue from this, which is maybe a more general
>> problem with managed mode.  In my case I'm using vfio-pci to assign
>> an
>> ahci controller to a VM.
> 
> "In my case" doesn't mean OOT, does it? I can't fully follow.
> 
>>   ahci_init_one() calls pcim_enable_device()
>> which sets is_managed = true.  I notice that nothing ever sets
>> is_managed to false.  Therefore now when I call pci_intx() from vfio-
>> pci
>> under spinlock, I get a lockdep warning
> 
> I suppose you see the lockdep warning because the new pcim_intx() can 
> now allocate, whereas before 25216afc9db5 it was pcim_enable_device()
> which allocated *everything* related to PCI devres.
> 
>>  as I no go through pcim_intx()
>> code after 25216afc9db5 
> 
> You alwas went through pcim_intx()'s logic. The issue seems to be that
> the allocation step was moved.
> 
>> since the previous driver was managed.
> 
> what do you mean by "previous driver"?

The AHCI driver... When attaching a PCI dev to vfio to e.g. passthrough to a VM,
the device driver must first be unbound and the device bound to vfio-pci. So we
switch from ahci/libata driver to vfio. When vfio tries to enable intx with
is_managed still true from the use of the device by ahci, problem happen.

> 
>>   It seems
>> like we should be setting is_managed to false is the driver release
>> path, right?
> 
> So the issue seems to be that the same struct pci_dev can be used by
> different drivers, is that correct?
> 
> If so, I think that can be addressed trough having
> pcim_disable_device() set is_managed to false as you suggest.
> 
> Another solution can could at least consider would be to use a
> GFP_ATOMIC for allocation in get_or_create_intx_devres().

If it is allowed to call pci_intx() under a spin_lock, then we need GFP_ATOMIC.
If not, then vfio-pci needs to move the call out of the spinlock.

Either solution must be implemented regardless of the fix to set is_managed to
false.

So what context is allowed to call pci_intx() ? The current kdoc comment does
not say...


-- 
Damien Le Moal
Western Digital Research


