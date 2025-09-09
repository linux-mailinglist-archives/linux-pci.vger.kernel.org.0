Return-Path: <linux-pci+bounces-35736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069D4B4A652
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 11:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C3B37AAEF1
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 08:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580F227586C;
	Tue,  9 Sep 2025 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgONOUF3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E392459C9;
	Tue,  9 Sep 2025 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408446; cv=none; b=B2+ZKzL+Ev7lNLj4evX2Y4TA0b9c+0gUg1V44CVo1YOr30EoSJg98QR6rgLrN/32hZgHEATYWNo54A0rJsjNSCJQSjsTu9twfP5Oro3m4VTv4w9a6go9lcO49VW3e6SeIOfXP1kSuN0klMyUdY4PN3QKTo3hPWXgIG+bNNGVk9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408446; c=relaxed/simple;
	bh=ALlxNsIscQgE1MW2G44pZiPc1j/HZOfg72IZlSKTjxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2i/T/6S6H5CU/49Xy2V8y7iaw2Fx1TdP1kMWCNUPV6D80+UOrslQJ+OLX4Unj9xe3rjLUf8IJIP7TFSG8VSlDZtWQrVVlESkzVXG6fqOKLe3V+qTcsX2PC8PPArc7YyzCX19Dw8N3ekautqd5DGKzjF0UYarjegPbIE2a1NmYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgONOUF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5791C4CEF4;
	Tue,  9 Sep 2025 09:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757408445;
	bh=ALlxNsIscQgE1MW2G44pZiPc1j/HZOfg72IZlSKTjxw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sgONOUF34dJjeqWsm4AfHIk6nkiav045F+95MzjnJYOdbsmWh/JUkg+PX5R5OhQ4w
	 Yx/fRZ+F62fNFlTq7FlRNFCS50S4LX398TReDiwU4jLbVMMJQfhZVjaFn/xFyxV+zr
	 VTfn4orFqfWZdqxdWQy8cnOTstKKheFpSlkGww9K724pZEJfx1oLo0VRi4WfbGbm0k
	 +4H3AcQvYjE6i/dXgYiIsugtHS/CJ4VWXW9PydWGwEPZW4ISNBJusvj4srmPppo6c9
	 3YkNsO3en2OoUtoMP/6Lrgi+WmYoUhD7hcxb2bUEcIn4ukqrchcxyQ8UThneoUO8AN
	 o6jYBdNdmcr+w==
Message-ID: <bf390f9e-e06f-4743-a9dc-e0b995c2bab2@kernel.org>
Date: Tue, 9 Sep 2025 11:00:41 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] PCI: pnv_php: Properly clean up allocated IRQs on
 unplug
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 christophe leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Shawn Anastasio <sanastasio@raptorengineering.com>
References: <1268570622.1359844.1752615109932.JavaMail.zimbra@raptorengineeringinc.com>
 <2013845045.1359852.1752615367790.JavaMail.zimbra@raptorengineeringinc.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <2013845045.1359852.1752615367790.JavaMail.zimbra@raptorengineeringinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15. 07. 25, 23:36, Timothy Pearson wrote:
> In cases where the root of a nested PCIe bridge configuration is
> unplugged, the pnv_php driver would leak the allocated IRQ resources for
> the child bridges' hotplug event notifications, resulting in a panic.
> Fix this by walking all child buses and deallocating all it's IRQ
> resources before calling pci_hp_remove_devices.
> 
> Also modify the lifetime of the workqueue at struct pnv_php_slot::wq so
> that it is only destroyed in pnv_php_free_slot, instead of
> pnv_php_disable_irq. This is required since pnv_php_disable_irq will now
> be called by workers triggered by hot unplug interrupts, so the
> workqueue needs to stay allocated.
> 
> The abridged kernel panic that occurs without this patch is as follows:
> 
>    WARNING: CPU: 0 PID: 687 at kernel/irq/msi.c:292 msi_device_data_release+0x6c/0x9c
>    CPU: 0 UID: 0 PID: 687 Comm: bash Not tainted 6.14.0-rc5+ #2
>    Call Trace:
>     msi_device_data_release+0x34/0x9c (unreliable)
>     release_nodes+0x64/0x13c
>     devres_release_all+0xc0/0x140
>     device_del+0x2d4/0x46c
>     pci_destroy_dev+0x5c/0x194
>     pci_hp_remove_devices+0x90/0x128
>     pci_hp_remove_devices+0x44/0x128
>     pnv_php_disable_slot+0x54/0xd4
>     power_write_file+0xf8/0x18c
>     pci_slot_attr_store+0x40/0x5c
>     sysfs_kf_write+0x64/0x78
>     kernfs_fop_write_iter+0x1b0/0x290
>     vfs_write+0x3bc/0x50c
>     ksys_write+0x84/0x140
>     system_call_exception+0x124/0x230
>     system_call_vectored_common+0x15c/0x2ec
> 
> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
> ---
>   drivers/pci/hotplug/pnv_php.c | 94 ++++++++++++++++++++++++++++-------
>   1 file changed, 75 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> index 573a41869c15..aec0a6d594ac 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
...
> @@ -647,6 +702,15 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)

This is preceded by:
         php_slot = kzalloc(sizeof(*php_slot), GFP_KERNEL);

Ie. php_slot is zeroed.

>   		return NULL;
>   	}
>   
> +	/* Allocate workqueue for this slot's interrupt handling */
> +	php_slot->wq = alloc_workqueue("pciehp-%s", 0, 0, php_slot->name);
> +	if (!php_slot->wq) {
> +		SLOT_WARN(php_slot, "Cannot alloc workqueue\n");

I believe this introduced a (unlikely) NULL ptr dereference.

> +		kfree(php_slot->name);
> +		kfree(php_slot);
> +		return NULL;
> +	}
> +
>   	if (dn->child && PCI_DN(dn->child))
>   		php_slot->slot_no = PCI_SLOT(PCI_DN(dn->child)->devfn);
>   	else

This continues:
         php_slot->pdev                  = bus->self;
         php_slot->bus                   = bus;


And SLOT_WARN() is defined as:
#define SLOT_WARN(sl, x...) \
         ((sl)->pdev ? pci_warn((sl)->pdev, x) : 
dev_warn(&(sl)->bus->dev, x))

The else branch is alkays taken in the 'if' above, which still 
dereferences NULLed (sl)->bus here.

> @@ -843,14 +907,6 @@ static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
>   	u16 sts, ctrl;
>   	int ret;
>   
> -	/* Allocate workqueue */
> -	php_slot->wq = alloc_workqueue("pciehp-%s", 0, 0, php_slot->name);
> -	if (!php_slot->wq) {
> -		SLOT_WARN(php_slot, "Cannot alloc workqueue\n");

Here, php_slot used to have both ->pdev and ->bus assigned at this point.

> -		pnv_php_disable_irq(php_slot, true);
> -		return;
> -	}
> -

Right?

thanks,
-- 
js
suse labs


