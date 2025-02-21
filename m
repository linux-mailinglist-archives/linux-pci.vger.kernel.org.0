Return-Path: <linux-pci+bounces-22047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB626A402E9
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 23:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD73189A44C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 22:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ECB204C10;
	Fri, 21 Feb 2025 22:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOCagVCe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E759202F87;
	Fri, 21 Feb 2025 22:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177650; cv=none; b=jyOeR/1BFLD26DaPS/TzY4Aqw2MURS2S7Dqgzpyrod+yJOY/YJM/JOP+iWcpSC6TG67x1/6e3QHTUTO/lqPeAhLe2NYnCslMM0Kn3VzElOs4xHyBv5Bhyx9xBxOneqWMIPWjNnOVj2SSvWQLbD9jRSoR2URmf5wQhHv8RTCkLKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177650; c=relaxed/simple;
	bh=OIpk/rEXseFwQw9BD/Do6j/VJPOnb7oyxoh1ovAtC8c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YiItE7oXF/oQnn2Hy//IN3meg9EYQc/D32oXfgFNNQAGuebymYOaGrqJRHnNJIcS5ZVCAoh/Eiqo/v/VOIUqfOur83N8sco2ga07ZiY4+z0Ifh5xhPIQLSPXU3LJqQAZKUdfcQBAhreexusIPXJhMGJAofbTuhyMIaqDknR8+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOCagVCe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E50C4CED6;
	Fri, 21 Feb 2025 22:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740177649;
	bh=OIpk/rEXseFwQw9BD/Do6j/VJPOnb7oyxoh1ovAtC8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nOCagVCercFSJwhvUySJcRJcTQBb1dAyo9dDzPjqGLbguTqqLjdIg1u0aUVK0hoBT
	 LFG/pFDmAwyhOswNwBqGHrALe1RmaaZmUN1/UkoSvhN4ipUMF/EIhk5ISQLdglJmSS
	 lpQc+O9MgjWsyaLy2/c0hnBTuAJVxxvaylrZfp/75e6myT7zA52EcWfV6Ns4tJc1n1
	 8KAoLdbKWdCMt9AylQqYciT9JGvGM5zFcEoNJ/fjZX5SCKuq/pdlRGIMJwqoCQE93P
	 NZYs1obbKyfzRdQzgtWz7VTWbkIbe9MVVYBEObq0/dvG/eAFdeJHyqRMcHy8Pif708
	 fJn+qBYDYPrBQ==
Date: Fri, 21 Feb 2025 16:40:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: christophe.jaillet@wanadoo.fr, bhelgaas@google.com, scott@spiteful.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] PCI: cpci: remove unused fields
Message-ID: <20250221224048.GA369678@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217185638.398925-1-trintaeoitogc@gmail.com>

On Mon, Feb 17, 2025 at 03:56:38PM -0300, Guilherme Giacomo Simoes wrote:
> The `get_power()` and `set_power()` function pointers in the
> `cpci_hp_controller ops` struct were declared but never implemented by
> any driver. To improve code readability and reduce resource usage,
> remove this pointers.
> 
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>

Applied to pci/hotplug for v6.15, thanks!

> --- 
> v2 changes
> 
> - Remove uneccessary SLOT_ENABLE constant
> - Remove uneccessary flags fields
> ---
>  drivers/pci/hotplug/cpci_hotplug.h      |  2 --
>  drivers/pci/hotplug/cpci_hotplug_core.c | 17 ++---------------
>  2 files changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/cpci_hotplug.h b/drivers/pci/hotplug/cpci_hotplug.h
> index 03fa39ab0c88..a31d6b62f523 100644
> --- a/drivers/pci/hotplug/cpci_hotplug.h
> +++ b/drivers/pci/hotplug/cpci_hotplug.h
> @@ -44,8 +44,6 @@ struct cpci_hp_controller_ops {
>  	int (*enable_irq)(void);
>  	int (*disable_irq)(void);
>  	int (*check_irq)(void *dev_id);
> -	u8  (*get_power)(struct slot *slot);
> -	int (*set_power)(struct slot *slot, int value);
>  };
>  
>  struct cpci_hp_controller {
> diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
> index d0559d2faf50..dd93e53ea7c2 100644
> --- a/drivers/pci/hotplug/cpci_hotplug_core.c
> +++ b/drivers/pci/hotplug/cpci_hotplug_core.c
> @@ -71,13 +71,10 @@ static int
>  enable_slot(struct hotplug_slot *hotplug_slot)
>  {
>  	struct slot *slot = to_slot(hotplug_slot);
> -	int retval = 0;
>  
>  	dbg("%s - physical_slot = %s", __func__, slot_name(slot));
>  
> -	if (controller->ops->set_power)
> -		retval = controller->ops->set_power(slot, 1);
> -	return retval;
> +	return 0;
>  }
>  
>  static int
> @@ -109,12 +106,6 @@ disable_slot(struct hotplug_slot *hotplug_slot)
>  	}
>  	cpci_led_on(slot);
>  
> -	if (controller->ops->set_power) {
> -		retval = controller->ops->set_power(slot, 0);
> -		if (retval)
> -			goto disable_error;
> -	}
> -
>  	slot->adapter_status = 0;
>  
>  	if (slot->extracting) {
> @@ -129,11 +120,7 @@ disable_slot(struct hotplug_slot *hotplug_slot)
>  static u8
>  cpci_get_power_status(struct slot *slot)
>  {
> -	u8 power = 1;
> -
> -	if (controller->ops->get_power)
> -		power = controller->ops->get_power(slot);
> -	return power;
> +	return 1;
>  }
>  
>  static int
> -- 
> 2.34.1
> 

