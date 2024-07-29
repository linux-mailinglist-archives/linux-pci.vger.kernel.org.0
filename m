Return-Path: <linux-pci+bounces-10945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F4493F40B
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 13:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568D71C21EA8
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 11:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953A41459E4;
	Mon, 29 Jul 2024 11:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbdgQhVJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8441448FA;
	Mon, 29 Jul 2024 11:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252600; cv=none; b=JgLxhbrM1i/7xvjrduzwMWL+JvMI4sHeiA8GeV7sUPBZSfuj9wJI1sv2TEHMoysfsM6hjida+qhj3pjBYLg6FMOJ3HgTAt3uun/s8he9k77Q7bMd20IPcNqESpDxiqTK8XzQTLPklfwdyvArUhZClix+uJFs40jnFazgJp/chfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252600; c=relaxed/simple;
	bh=jU5MdIjEGVQCjk1wsJHSVEQFdc3ni/pdNCW7HkOiyEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9fsSVuJlbNiTlwDy6ae4LIau8hUlHUKqqRMqDZvjnoDcWnu3N+x3QWLLgAR5xM2rCVM+MEeLnEutrXoTHVwLbXWv3hD53rFAjsMXojqXLJCoSURGk54fGCi0rwleAZPvo5W4yxjUi4ndfmF86Mrchw6Hw+I9sriRlhWwhlz3ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbdgQhVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42632C32786;
	Mon, 29 Jul 2024 11:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722252599;
	bh=jU5MdIjEGVQCjk1wsJHSVEQFdc3ni/pdNCW7HkOiyEc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dbdgQhVJc6pf0kEzta9tlx02VjbM+40HHBUHujn5XodAgJv0E/E1XhOUeW667HgWE
	 2BKSA4ZsJ7B52CVSsXXCAo/6kT50ifGvBNdiWLHNKPcNHUEDcPyUgvjX1RDsLRJCHt
	 AMFzLJ4jjeWSspJf8oFdczqHSTk6pfgIdtWYhsuvY97oru2WC6DMzEG6RO00+jdZhp
	 G5CTPMIIHVQ4paD9bvQzvOcJfrJd2smBH8oiqgcOIONha3UKgdgryrHY92F5lV6xcH
	 Zu6Tkgf65ydK2IHRC+wJiuOtkyt2QeiZrz3lZonSBReeyLG2sS/OKSmiMFnVqsazQ/
	 DP4N4U1uqrKsQ==
Message-ID: <d4bb01e9-0293-4d6a-a2c1-3d37b3a368ca@kernel.org>
Date: Mon, 29 Jul 2024 20:29:58 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
To: pstanner@redhat.com, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240725120729.59788-2-pstanner@redhat.com>
 <6ce4c9f4-7c75-4451-8c6f-fe3d6a3dd913@kernel.org>
 <ee44ea7ac760e73edad3f20b30b4d2fff66c1a85.camel@redhat.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ee44ea7ac760e73edad3f20b30b4d2fff66c1a85.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/27/24 03:43, pstanner@redhat.com wrote:
>> That said, I do not see that as an issue in itself. What I fail to
>> understand
>> though is why that intx devres is not deleted on device teardown. I
>> think this
>> may have something to do with the fact that pcim_intx() always does
>> "res->orig_intx = !enable;", that is, it assumes that if there is a
>> call to
>> pcim_intx(dev, 0), then it is because intx where enabled already,
>> which I do not
>> think is true for most drivers... So we endup with INTX being wrongly
>> enabled on
>> device teardown by pcim_intx_restore(), and because of that, the intx
>> resource
>> is not deleted ?
> 
> Spoiler: The device resources that have initially been created do get
> deleted. Devres works as intended. The issue is that the forces of evil
> invoke pci_intx() through another path, hidden behind an API, through
> another devres callback.
> 
> So the device resource never gets deleated because it is *created* on
> driver detach, when devres already ran.

That explains the issue :)

>> Re-enabling intx on teardown is wrong I think, but that still does
>> not explain
>> why that resource is not deleted. I fail to see why.
> 
> You came very close to the truth ;)
> 
> With some help from my favorite coworker I did some tracing today and
> found this when doing `rmmod ahci`:
> 
> => pci_intx
> => pci_msi_shutdown
> => pci_disable_msi
> => devres_release_all
> => device_unbind_cleanup
> => device_release_driver_internal
> => driver_detach
> => bus_remove_driver
> => pci_unregister_driver
> => __do_sys_delete_module
> => do_syscall_64
> => entry_SYSCALL_64_after_hwframe
> 
> The SYSCALL is my `rmmod`.
> 
> As you can see, pci_intx() is invoked indirectly through
> pci_disable_msi() – which gets invoked by devres, which is precisely
> one reason why you could not find the suspicious pci_intx() call in the
> ahci code base.
> 
> Now the question is: Who set up that devres callback which indirectly
> calls pci_intx()?
> 
> It is indeed MSI, here in msi/msi.c:
> 
> static void pcim_msi_release(void *pcidev)
> {
>  struct pci_dev *dev = pcidev;
> 
>  dev->is_msi_managed = false;
>  pci_free_irq_vectors(dev); // <-- calls pci_disable_msi(), which calls pci_intx(), which re-registers yet another devres callback
> }
> 
> /*
>  * Needs to be separate from pcim_release to prevent an ordering problem
> 
> ==> Oh, here they even had a warning about that interacting with devres somehow...
> 
>  * vs. msi_device_data_release() in the MSI core code.
>  */
> static int pcim_setup_msi_release(struct pci_dev *dev)
> {
>  int ret;
> 
>  if (!pci_is_managed(dev) || dev->is_msi_managed)
>  return 0;
> 
>  ret = devm_add_action(&dev->dev, pcim_msi_release, dev);
>  if (ret)
>  return ret;
> 
>  dev->is_msi_managed = true;
>  return 0;
> }
> 
> I don't know enough about AHCI to see where exactly it jumps into
> these, but a candidate would be:
>  * pci_enable_msi(), called among others in acard-ahci.c
> 
> Another path is:
>    1. ahci_init_one() calls
>    2. ahci_init_msi() calls
>    3. pci_alloc_irq_vectors() calls
>    4. pci_alloc_irq_vectors_affinity() calls
>    5. __pci_enable_msi_range() OR __pci_enable_msix_range() call
>    6. pci_setup_msi_context() calls
>    7. pcim_setup_msi_release() which registers the callback to
>       pci_intx()

ahci_init_one() is the function used by the default AHCI driver (ahci.ko), so
this path is correct.

> Ha!
> 
> I think I earned myself a Friday evening beer now 8-)

I was way ahead of you :)

> Now the interesting question will be how the heck we're supposed to
> clean that up.

If pcim_intx() always gets called on device release, AND MSI/MSIX are also
managed interrupts with a devres action on release, I would say that
pcim_msi_release() should NOT lead to a path calling pci_intx(dev, 0), as that
would create the intx devres again. But given the comment you point out above,
it seems that there are some ordering constraints between disabling msi and intx
? If that is the case, then may be this indeed will be tricky.

> Another interesting question is: Did that only work by coincidence
> during the last 15 years, or is it by design that the check in
> pci_intx():
> 
> if (new != pci_command)
> 
> only evaluates to true if we are not in a detach path.

I would say that it evaluates to true for any device using intx, which tend to
be rare these days. In such case, then enabling on device attach and disabling
on detach would lead to new != pci_command, including in the hidden intx disable
path triggered by disabling msi. But the devres being recreated on detach
definitely seem to depend on the disabling order though. So we may have been
lucky indeed.

> 
> If it were coincidence, it would not have caused faults as it did now
> with my recent work, because the old version did not allocate in
> pci_intx().
> 
> But it could certainly have been racy and might run into a UAF since
> the old pci_intx() would have worked on memory that is also managed by
> devres, but has been registered at a different place. I guess that is
> what that comment in the MSI code quoted above is hinting at.
> 
> 
> Christoph indeed rightfully called it voodoo ^^
> 
> 
> Cheers,
> P.
> 
> 

-- 
Damien Le Moal
Western Digital Research


