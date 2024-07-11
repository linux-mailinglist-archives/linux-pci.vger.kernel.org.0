Return-Path: <linux-pci+bounces-10187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6246492F079
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 22:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41FCB1C228E1
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 20:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B23254FB5;
	Thu, 11 Jul 2024 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOjqBG81"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775AD8BFC
	for <linux-pci@vger.kernel.org>; Thu, 11 Jul 2024 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720731046; cv=none; b=jOm68LDylfDaQCe8SsljVdGo59A4n3/RIMVbh5KQvixYaUtpl6kih7Tq7q/nMgGHWU2jyqPEPWiCSkOgnSMpuLAZrH42jpQw7hChb8P7PIwek04HBHYbfAxHrlEPAnkbr/X5OFON3qcv/3xgCX7fOwPTT4D8lxSFKU9WCXNT+ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720731046; c=relaxed/simple;
	bh=lfXPQU9kU/OefMphiDw7RB4Oyc2SA+0pD7Ai4g1iVCE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=W+CtO6j+n7DbUjk2UITf8AI7JbhCTTXtpfZY7Hm9gYqRBaadVC/aAzjyT73rpafOy68xjUICcGGzWmfLAEy2N973WjbwlDFIqO1TpOSOLOfxixUgQ2DV5x78P+WPkls7nFnn1WVJGtNHO9vj8upY/OdP9Zk7iN+1+DBBll4u3mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOjqBG81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37E4C116B1;
	Thu, 11 Jul 2024 20:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720731046;
	bh=lfXPQU9kU/OefMphiDw7RB4Oyc2SA+0pD7Ai4g1iVCE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hOjqBG81rgXCtrTUTwf4GKeZWok3zpl52EWZEKmMKbeul7NJSLBymk5T6tlHWkR0s
	 /mKO4BcNZk8E6WVXKvpu2wtQsCV1ygUynUEy4xmudwO/kImTCv6/m7PTTNgele+4NO
	 4XooAHv/ZEITAWFBrTgxC/9MYIAsLy/mYmcD7Sr5YNaTNRIha86Rkhu77AHXO7qyYz
	 nn+Iv1cVi2j6lzqujNQ7OAmHYnUlEsybb3mYYwBJNgprWNn9OL3E4Y9doUqJLt1zKO
	 sn/IX7IzV/APg11H5si1cf752p61Rcv1Q9OOTTShA/lSQTQvUAEsDHlYS5/PM0fSk7
	 vTNBmPR0sPuRg==
Date: Thu, 11 Jul 2024 15:50:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Hans de Goede <hdegoede@redhat.com>, Kalle Valo <kvalo@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCHv2] PCI: fix recursive device locking
Message-ID: <20240711205044.GA296163@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711193650.701834-1-kbusch@meta.com>

[+cc Hans, Kalle, Dave]

On Thu, Jul 11, 2024 at 12:36:50PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> If one of the bus' devices has subordinates, the recursive call locks
> itself, so no need to lock the device before the recursion or it will
> surely deadlock.
> 
> Fixes: dbc5b5c0d268f87 ("PCI: Add missing bridge lock to pci_bus_lock()"
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

dbc5b5c0d268f87 was queued for the v6.11 merge window on pci/reset, so
I squashed this fix into that commit.  Thanks for the fix!

Hans, Kalle, Dave, I retained your Tested-by and Reviewed-by from
dbc5b5c0d268f87.  Please let me know if you want to update or remove
those.

> ---
> Changes from v1:
> 
>  Fixed the same recursive locking for pci_bus_trylock(),
>  pci_slot_lock(), and pci_slot_trylock()
> 
>  drivers/pci/pci.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index df550953fa260..82b74d3f6bb1e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5488,9 +5488,10 @@ static void pci_bus_lock(struct pci_bus *bus)
>  
>  	pci_dev_lock(bus->self);
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> -		pci_dev_lock(dev);
>  		if (dev->subordinate)
>  			pci_bus_lock(dev->subordinate);
> +		else
> +			pci_dev_lock(dev);
>  	}
>  }
>  
> @@ -5502,7 +5503,8 @@ static void pci_bus_unlock(struct pci_bus *bus)
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		if (dev->subordinate)
>  			pci_bus_unlock(dev->subordinate);
> -		pci_dev_unlock(dev);
> +		else
> +			pci_dev_unlock(dev);
>  	}
>  	pci_dev_unlock(bus->self);
>  }
> @@ -5512,16 +5514,15 @@ static int pci_bus_trylock(struct pci_bus *bus)
>  {
>  	struct pci_dev *dev;
>  
> -	pci_dev_lock(bus->self);
> +	if (!pci_dev_trylock(bus->self))
> +		return 0;
> +
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> -		if (!pci_dev_trylock(dev))
> -			goto unlock;
>  		if (dev->subordinate) {
> -			if (!pci_bus_trylock(dev->subordinate)) {
> -				pci_dev_unlock(dev);
> +			if (!pci_bus_trylock(dev->subordinate))
>  				goto unlock;
> -			}
> -		}
> +		} else if (!pci_dev_trylock(dev))
> +			goto unlock;
>  	}
>  	return 1;
>  
> @@ -5529,7 +5530,8 @@ static int pci_bus_trylock(struct pci_bus *bus)
>  	list_for_each_entry_continue_reverse(dev, &bus->devices, bus_list) {
>  		if (dev->subordinate)
>  			pci_bus_unlock(dev->subordinate);
> -		pci_dev_unlock(dev);
> +		else
> +			pci_dev_unlock(dev);
>  	}
>  	pci_dev_unlock(bus->self);
>  	return 0;
> @@ -5563,9 +5565,10 @@ static void pci_slot_lock(struct pci_slot *slot)
>  	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
>  		if (!dev->slot || dev->slot != slot)
>  			continue;
> -		pci_dev_lock(dev);
>  		if (dev->subordinate)
>  			pci_bus_lock(dev->subordinate);
> +		else
> +			pci_dev_lock(dev);
>  	}
>  }
>  
> @@ -5591,14 +5594,13 @@ static int pci_slot_trylock(struct pci_slot *slot)
>  	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
>  		if (!dev->slot || dev->slot != slot)
>  			continue;
> -		if (!pci_dev_trylock(dev))
> -			goto unlock;
>  		if (dev->subordinate) {
>  			if (!pci_bus_trylock(dev->subordinate)) {
>  				pci_dev_unlock(dev);
>  				goto unlock;
>  			}
> -		}
> +		} else if (!pci_dev_trylock(dev))
> +			goto unlock;
>  	}
>  	return 1;
>  
> @@ -5609,7 +5611,8 @@ static int pci_slot_trylock(struct pci_slot *slot)
>  			continue;
>  		if (dev->subordinate)
>  			pci_bus_unlock(dev->subordinate);
> -		pci_dev_unlock(dev);
> +		else
> +			pci_dev_unlock(dev);
>  	}
>  	return 0;
>  }
> -- 
> 2.43.0
> 

