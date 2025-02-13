Return-Path: <linux-pci+bounces-21387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF57A35074
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 22:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515C316DA2E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 21:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9E52661AF;
	Thu, 13 Feb 2025 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxcId6lt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A332266194;
	Thu, 13 Feb 2025 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739481989; cv=none; b=Lp/svnhZaQex0xUs80IwSifabL60LOtDidVFVSHYP6M3yX/VpNH4ubspioImZIGYOnSNBFXS5eMRqn+2NwgXlKrNgNe1qT4DYr+SBSY5sam3dZ1Y153mL+PojBwe9nLoE1KyOhqLP98h/4foet14/z32PcQKvK4mseF1gM/9CLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739481989; c=relaxed/simple;
	bh=kd5YH4NzkubOTTFMv3z34LQ4GBHbqGwLBDJZ3FgGaHw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FRKczMfboCUg/dXUV24p2ZNtFDnukKvnqLRIL8evEbyKun7Mb/GC5jOpW4tzuuVy9WTsV6F7WzH9Lsr1xbe9x18YZWHHOS/7L75Vs2lp/I0PlM1seWXW1/XGFHW0tlFhxcmW0HY64HvJsZ25KsWOXYPEphnDHJAy91KQOWxkA2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxcId6lt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9425C4CED1;
	Thu, 13 Feb 2025 21:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739481989;
	bh=kd5YH4NzkubOTTFMv3z34LQ4GBHbqGwLBDJZ3FgGaHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DxcId6ltk/cwmtittF2HjOuXY+DT7BGPXEpyiGpfxRoBIECUspiS6lS2YzmbrWsNp
	 tFAsq9H5dtX1qfdyhUktXJKm8iJ3DOx6P2a/hLUvSnjylALLcOiXBt3mFhJHgFrl1Y
	 i1b3GF0C2CtUGz+tvuStdRPNcuWOKvvlUBv+cX5Py6sLDqUvEEN7mRHvoHEhvFslAx
	 sCBWceOVWraY9KZoGZsyJFP8T6sPovu7WyuQ8booJ9T+CNNZySz1r3pIU3Zi0c1FtO
	 MFur9HfUCFb5QryHdpp87yWxA8BIB3Dm4rHDy59cgEOuzmu4X2CugbIAAeNAvG4zx5
	 XazZIaW7V1RRg==
Date: Thu, 13 Feb 2025 15:26:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: scott@spiteful.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] PCI: cpci: remove unused fields
Message-ID: <20250213212627.GA129476@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213173925.200404-1-trintaeoitogc@gmail.com>

On Thu, Feb 13, 2025 at 02:39:25PM -0300, Guilherme Giacomo Simoes wrote:
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
>  drivers/pci/hotplug/cpci_hotplug.h      |  3 +--
>  drivers/pci/hotplug/cpci_hotplug_core.c | 21 +++++++--------------
>  2 files changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/cpci_hotplug.h b/drivers/pci/hotplug/cpci_hotplug.h
> index 03fa39ab0c88..c5cb12cad2b4 100644
> --- a/drivers/pci/hotplug/cpci_hotplug.h
> +++ b/drivers/pci/hotplug/cpci_hotplug.h
> @@ -44,8 +44,7 @@ struct cpci_hp_controller_ops {
>  	int (*enable_irq)(void);
>  	int (*disable_irq)(void);
>  	int (*check_irq)(void *dev_id);
> -	u8  (*get_power)(struct slot *slot);
> -	int (*set_power)(struct slot *slot, int value);
> +	int flags;
>  };
>  
>  struct cpci_hp_controller {
> diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
> index d0559d2faf50..87a743c2a5f1 100644
> --- a/drivers/pci/hotplug/cpci_hotplug_core.c
> +++ b/drivers/pci/hotplug/cpci_hotplug_core.c
> @@ -27,6 +27,8 @@
>  #define DRIVER_AUTHOR	"Scott Murray <scottm@somanetworks.com>"
>  #define DRIVER_DESC	"CompactPCI Hot Plug Core"
>  
> +#define SLOT_ENABLED 0x00000001
> +
>  #define MY_NAME	"cpci_hotplug"
>  
>  #define dbg(format, arg...)					\
> @@ -71,13 +73,12 @@ static int
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
> +	controller->ops->flags |= SLOT_ENABLED;

There are no implementations of ->set_power() or ->get_power(), are
there?  If not, we can just remove them and the calls to them.

I don't see why we should add SLOT_ENABLED.

> +	return 0;
>  }
>  
>  static int
> @@ -109,11 +110,7 @@ disable_slot(struct hotplug_slot *hotplug_slot)
>  	}
>  	cpci_led_on(slot);
>  
> -	if (controller->ops->set_power) {
> -		retval = controller->ops->set_power(slot, 0);
> -		if (retval)
> -			goto disable_error;
> -	}
> +	controller->ops->flags &= ~SLOT_ENABLED;
>  
>  	slot->adapter_status = 0;
>  
> @@ -129,11 +126,7 @@ disable_slot(struct hotplug_slot *hotplug_slot)
>  static u8
>  cpci_get_power_status(struct slot *slot)
>  {
> -	u8 power = 1;
> -
> -	if (controller->ops->get_power)
> -		power = controller->ops->get_power(slot);
> -	return power;
> +	return controller->ops->flags & SLOT_ENABLED;
>  }
>  
>  static int
> -- 
> 2.34.1
> 

