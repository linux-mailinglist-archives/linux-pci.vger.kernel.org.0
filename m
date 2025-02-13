Return-Path: <linux-pci+bounces-21382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD81A34FDB
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 21:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 241927A4EED
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 20:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF19270EA8;
	Thu, 13 Feb 2025 20:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="rfykS5mE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-70.smtpout.orange.fr [80.12.242.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A549026FA5C;
	Thu, 13 Feb 2025 20:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479556; cv=none; b=cCTihtvZ5Fxx7eE7w7uuQcPZ6qb2fswTmm5qZWyJ/mdaISt7NOJA+cZVJVYoN2kCDUFe92LBEplIHKf+fFXOeApQAIiARhUZq4IfRvkkcTB8vPKQ9qzQ4rOLBwfU8ZfD1HsIoGqapj1TWi7V5O+RpZ77mP3BnedEb7HLXu6vOos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479556; c=relaxed/simple;
	bh=QW4zP2U+IjjpQ+TStpydmk8FGeVp2iCrn2W8AjIobw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=anokXfmgwLR7ecdWLU+BS4op3dKpkw8XN452zVEgpUxrvW3ShS4V0vc4P1vNeZNaIJGBttimP3CWzp0lcpnO3C8ef8+mcvSAO7BEPP+Y4xQyq5AgyMsCIbSDm+4bDaQtuoCqrrKSpc+wfnve8Dmt7g88Tk7LOTeAmSse8j5Zc7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=rfykS5mE; arc=none smtp.client-ip=80.12.242.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id ig4StaDDcmXj3ig4WtV2Gv; Thu, 13 Feb 2025 21:44:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1739479473;
	bh=CJcCjCLAQO2O/5OGGV8ihwCBev8U59q2w5V0fw84bJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=rfykS5mEu2ZOi/fL+ggzdVq/VcOTVyE9iLa25pLgKL0Wcvlrl2BPIUjYk8CnIkHwX
	 7UAt4xBoAWcJ1jLUVcl7PhwXCD4YftswLdXshu/FRnI10Ryu1LUMPZZK6tywAHyeJh
	 FnlO/OWOOjOyku/z53bDq74C3uxdiat6sQsRnb/vTcAF7mgHgAqtmbDQUCwPR3mypB
	 bXOjvyHVCPZLXjCsS6qCRA1bG0JI8kVDecHs5DWFqGQpchP1fggEHpBHMU7wohQ42D
	 ltZiDg8eO5k6ijjuV4Q5/z61cNPaaXUBe8jnKgljpEENDTPd2F/EdqGS4QVls0lOO5
	 9P9Bn+KhP6fDA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Thu, 13 Feb 2025 21:44:33 +0100
X-ME-IP: 90.11.132.44
Message-ID: <a1af3a07-1e76-488b-82f7-87b3a4907f26@wanadoo.fr>
Date: Thu, 13 Feb 2025 21:44:27 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] PCI: cpci: remove unused fields
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>, scott@spiteful.org,
 bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250213173925.200404-1-trintaeoitogc@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250213173925.200404-1-trintaeoitogc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 13/02/2025 à 18:39, Guilherme Giacomo Simoes a écrit :
> The `get_power()` and `set_power()` function pointers in the
> `cpci_hp_controller ops` struct were declared but never implemented by
> any driver. To improve code readability and reduce resource usage,
> remove this pointers and replace with a `flags` field.
> 
> Use the new `flags` field in `enable_slot()`, `disable_slot()`, and
> `cpci_get_power_s atus()` to track the slot's power state using the
> `SLOT_ENABLED` macro.
> 
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
> ---
>   drivers/pci/hotplug/cpci_hotplug.h      |  3 +--
>   drivers/pci/hotplug/cpci_hotplug_core.c | 21 +++++++--------------
>   2 files changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/cpci_hotplug.h b/drivers/pci/hotplug/cpci_hotplug.h
> index 03fa39ab0c88..c5cb12cad2b4 100644
> --- a/drivers/pci/hotplug/cpci_hotplug.h
> +++ b/drivers/pci/hotplug/cpci_hotplug.h
> @@ -44,8 +44,7 @@ struct cpci_hp_controller_ops {
>   	int (*enable_irq)(void);
>   	int (*disable_irq)(void);
>   	int (*check_irq)(void *dev_id);
> -	u8  (*get_power)(struct slot *slot);
> -	int (*set_power)(struct slot *slot, int value);
> +	int flags;
>   };
>   
>   struct cpci_hp_controller {
> diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
> index d0559d2faf50..87a743c2a5f1 100644
> --- a/drivers/pci/hotplug/cpci_hotplug_core.c
> +++ b/drivers/pci/hotplug/cpci_hotplug_core.c
> @@ -27,6 +27,8 @@
>   #define DRIVER_AUTHOR	"Scott Murray <scottm@somanetworks.com>"
>   #define DRIVER_DESC	"CompactPCI Hot Plug Core"
>   
> +#define SLOT_ENABLED 0x00000001
> +
>   #define MY_NAME	"cpci_hotplug"
>   
>   #define dbg(format, arg...)					\
> @@ -71,13 +73,12 @@ static int
>   enable_slot(struct hotplug_slot *hotplug_slot)
>   {
>   	struct slot *slot = to_slot(hotplug_slot);
> -	int retval = 0;
>   
>   	dbg("%s - physical_slot = %s", __func__, slot_name(slot));
>   
> -	if (controller->ops->set_power)
> -		retval = controller->ops->set_power(slot, 1);
> -	return retval;
> +	controller->ops->flags |= SLOT_ENABLED;
> +
> +	return 0;
>   }
>   
>   static int
> @@ -109,11 +110,7 @@ disable_slot(struct hotplug_slot *hotplug_slot)
>   	}
>   	cpci_led_on(slot);
>   
> -	if (controller->ops->set_power) {
> -		retval = controller->ops->set_power(slot, 0);
> -		if (retval)
> -			goto disable_error;
> -	}
> +	controller->ops->flags &= ~SLOT_ENABLED;
>   
>   	slot->adapter_status = 0;
>   
> @@ -129,11 +126,7 @@ disable_slot(struct hotplug_slot *hotplug_slot)
>   static u8
>   cpci_get_power_status(struct slot *slot)
>   {
> -	u8 power = 1;
> -
> -	if (controller->ops->get_power)
> -		power = controller->ops->get_power(slot);
> -	return power;
> +	return controller->ops->flags & SLOT_ENABLED;

If neither get_power nor set_power where defined in any driver, then 
cpci_get_power_status() was always returning 1.

IIUC, now it may return 1 or 0 depending of if enable_slot() or 
disable_slot() have been called.

I don't know the impact of this change and I dont know if it is correct, 
but I think you should explain why this change of behavior is fine.

Just my 2c.

CJ


>   }
>   
>   static int


