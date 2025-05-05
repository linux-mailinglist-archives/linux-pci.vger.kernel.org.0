Return-Path: <linux-pci+bounces-27196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 150FEAA9CF3
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 22:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0808F1A805F1
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 20:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF851DE3B5;
	Mon,  5 May 2025 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDgAXrwp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD92819C546;
	Mon,  5 May 2025 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746475453; cv=none; b=TtrlJrGauOmN8Smh0M2d9xdQdSUlHuoGNlvR8S7OA5PMgAtd0uKMlmY5P37UE0Y6/K0kGIc5GYt9WKaocj705JLyV+fQvJcaNlztdUhSmKfdLrtT6S6QMonZRjzgWHHa83MXGEvkArCQ8+mbkBOvXDsNQa59a4XsJbjsvUExfAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746475453; c=relaxed/simple;
	bh=KCO028YU4+zLz2T0WIbkuCDLRwZcftXFm5u2mPzRqBI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=F3VihPsQCK+y2fPO3UN3tk22S5GeR6MNzEiqOte0l6M720tKh9wMn9xLO7Vsk4MEL5l/pvDKxJakXogX6Q5vugRcbBwGiMNGUzPcnRubNuh4xkiVv7pGJkaD1v8srLMxCcg//nUEfPQMziQV7lS3FTnHQ6i4RilARf2INUgUVQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDgAXrwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75A8C4CEE4;
	Mon,  5 May 2025 20:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746475453;
	bh=KCO028YU4+zLz2T0WIbkuCDLRwZcftXFm5u2mPzRqBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VDgAXrwppm/5kKLKH6ths4VBgB0+BhO7OZFYdF9nymEuhUAld//y0uSD4qLhbq93O
	 Ud8eyHz/j4cA/8HcLgUJYpLYPjt+3g8Pm4puuPaEahSzOICwHbdcglHJMnYz2NSr/9
	 6pSJ+sqn+XPpfqadzZcrJXQeVCDqRksThvaBW56b0OYltELkreLG91bhMaEb1lDOaE
	 w92vhz/EePRSwXUxZRL5M5d1TRyXmzgTT/sMSnA2GD4bcwOVVlny8SkQWPQu36Gw96
	 yc1yMim3LuBCXUY1prhiRUdJIGby5KPuJY4Ss4CYtg4kE2Nlh/oDBtIrkMPSwo0BwN
	 WcHiOv33QY+ug==
Date: Mon, 5 May 2025 15:04:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Moshe Shemesh <moshe@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Keith Busch <kbusch@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] PCI: Fix lock symmetry in pci_slot_unlock()
Message-ID: <20250505200411.GA995574@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250505115412.37628-1-ilpo.jarvinen@linux.intel.com>

On Mon, May 05, 2025 at 02:54:12PM +0300, Ilpo Järvinen wrote:
> The commit a4e772898f8b ("PCI: Add missing bridge lock to
> pci_bus_lock()") made the lock function to call depend on
> dev->subordinate but left pci_slot_unlock() unmodified creating locking
> asymmetry compared with pci_slot_lock().
> 
> Because of the asymmetric lock handling, the same bridge device is
> unlocked twice. First pci_bus_unlock() unlocks bus->self and then
> pci_slot_unlock() will unconditionally unlock the same bridge device.
> 
> Move pci_dev_unlock() inside an else branch to match the logic in
> pci_slot_lock().
> 
> Fixes: a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: <stable@vger.kernel.org>

Applied to pci/reset for v6.16, thanks!

> ---
> 
> v2:
> - Improve changelog (Lukas)
> - Added Cc stable
> 
>  drivers/pci/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 4d7c9f64ea24..26507aa906d7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5542,7 +5542,8 @@ static void pci_slot_unlock(struct pci_slot *slot)
>  			continue;
>  		if (dev->subordinate)
>  			pci_bus_unlock(dev->subordinate);
> -		pci_dev_unlock(dev);
> +		else
> +			pci_dev_unlock(dev);
>  	}
>  }
>  
> 
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> -- 
> 2.39.5
> 

