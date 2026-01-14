Return-Path: <linux-pci+bounces-44837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77944D20FE2
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 20:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6032303371D
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614C932E15B;
	Wed, 14 Jan 2026 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9BumdeR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF9A4502A
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768418310; cv=none; b=jSa5MhJ79zwStB143C0jbyinnlQB3UuGRiSNuLQIr1bvcZlgjr6B8I/yoTdbzT/MF58izjFeGS8TRLRXaOIAjPLvCQfJHOlmOa3k1VSF8n09eL7E3FikQyqb9m8Pklw/Tdhg9LhmtoSgT9ijhRAlahyUGyDLvDyVaI5RvTbvTus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768418310; c=relaxed/simple;
	bh=77cHCs8stIX+7mteF3sBj2Pg0Eh0ATANF5xhZTXj3FY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ixRbfx+2+Lk0ET0YrmzmpXkP5zCFdEBwP0AU+LaLjxyZlzn/1koC45iHkMpWysLT5HVUkuX94v6rCgTLx6sGpEoRs7UpmzPv3LtSSS/HTWMFj2Z/SiRK7syK2xv6EcaNS1pMHsPC/qRhpa3Xtq39g7GpBJlXxiyTw/rZ/oR6x/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9BumdeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4950C4CEF7;
	Wed, 14 Jan 2026 19:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768418309;
	bh=77cHCs8stIX+7mteF3sBj2Pg0Eh0ATANF5xhZTXj3FY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=V9BumdeRsR862jLq6GeMJBDDhU+ToaG1SjCeCu/rdomXQ/JsmhSUaBcH++SaUsOv1
	 rmetFes9hAgrNSS2iCetGI7BhRJA0aj9TA2pBrNMiMZC/aO/6xXvscrNwZwuuN2ghT
	 tkjdWdcnDvyQzdSpOxS0OTR8zHjpbnoXeEvhf61L8c4OKfagHFoiYNUtpVbGw5elbD
	 BwSlKwZvyS5WvEHQ/CuIv2rWsieyYz9f73rJQA9Swdm9biTcoSFKK/AwbEc0lOVGkC
	 VIcaFO1XhigWdkFC2djPPD2NCt+qyLt+4z4Qp6BU1DXoKYgLtT0NNlPfVHQwBSAnvb
	 srSpV8uqUxVdA==
Date: Wed, 14 Jan 2026 13:18:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Keith Busch <kbusch@kernel.org>, Alex Williamson <alex@shazbot.org>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] pci: make reset_subordinate hotplug safe
Message-ID: <20260114191828.GA830415@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114185821.704089-1-kbusch@meta.com>

[+cc Alex, Lukas]

On Wed, Jan 14, 2026 at 10:58:21AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Use the slot reset method when resetting the bridge if the bus contains
> hotplug slots. This fixes spurious hotplug events the secondary bus
> reset triggers by utilizing slot's specific reset callback that ignores
> link events.

What do these spurious events look like in dmesg?

> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> The new function introduced here is essentially the same as
> pci_bus_error_reset, except it uses the reset functions that save and
> restore the device. This is the same as before if not resetting a
> hotplug slot.
> 
>  drivers/pci/pci-sysfs.c |  3 +--
>  drivers/pci/pci.c       | 27 +++++++++++++++++++++++++++
>  drivers/pci/pci.h       |  2 +-
>  3 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 3881359440b1a..5c7c6f0c435f3 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -553,7 +553,6 @@ static ssize_t reset_subordinate_store(struct device *dev,
>  				const char *buf, size_t count)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct pci_bus *bus = pdev->subordinate;
>  	unsigned long val;
>  
>  	if (!capable(CAP_SYS_ADMIN))
> @@ -563,7 +562,7 @@ static ssize_t reset_subordinate_store(struct device *dev,
>  		return -EINVAL;
>  
>  	if (val) {
> -		int ret = __pci_reset_bus(bus);
> +		int ret = pci_reset_bridge(pdev);
>  
>  		if (ret)
>  			return ret;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b14dd064006cc..ca426ff68c820 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5747,6 +5747,33 @@ int __pci_reset_bus(struct pci_bus *bus)
>  	return rc;
>  }
>  
> +int pci_reset_bridge(struct pci_dev *bridge)
> +{
> +	struct pci_bus *bus = bridge->subordinate;
> +	struct pci_slot *slot;
> +
> +	if (!bus)
> +		return -ENOTTY;
> +
> +	mutex_lock(&pci_slot_mutex);
> +	if (list_empty(&bus->slots))
> +		goto bus_reset;
> +
> +	list_for_each_entry(slot, &bus->slots, list)
> +		if (pci_probe_reset_slot(slot))
> +			goto bus_reset;
> +
> +	list_for_each_entry(slot, &bus->slots, list)
> +		if (__pci_reset_slot(slot))
> +			goto bus_reset;
> +
> +	mutex_unlock(&pci_slot_mutex);
> +	return 0;
> +bus_reset:
> +	mutex_unlock(&pci_slot_mutex);
> +	return __pci_reset_bus(bus);
> +}
> +
>  /**
>   * pci_reset_bus - Try to reset a PCI bus
>   * @pdev: top level PCI device to reset via slot/bus
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 36f8c0985430a..f216e7a37d726 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -197,7 +197,7 @@ bool pci_reset_supported(struct pci_dev *dev);
>  void pci_init_reset_methods(struct pci_dev *dev);
>  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
>  int pci_bus_error_reset(struct pci_dev *dev);
> -int __pci_reset_bus(struct pci_bus *bus);
> +int pci_reset_bridge(struct pci_dev *dev);
>  
>  struct pci_cap_saved_data {
>  	u16		cap_nr;
> -- 
> 2.47.3
> 

