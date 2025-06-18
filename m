Return-Path: <linux-pci+bounces-30071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BD7ADF0D8
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 17:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E823B36B7
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 15:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF92230BE4;
	Wed, 18 Jun 2025 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCTBLbZU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991342EE96F
	for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750259590; cv=none; b=X+i1n0Gz3D4KUf9NNglITrZUo8BYx+f1ELNl/2e58guiwbbqDmqQ+/GZa+8n7Gw3tncNLh167VIECPuNeg1+Jlspj7rP887EPchpOIeFaEDjJ5joiHDetQPpT+kVZKAu3F09HOA21AQSQkZD4Nru4kVxhN+KNjWY4dRjMbUaArI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750259590; c=relaxed/simple;
	bh=RxyUMiuudcd2zaA9C02HdB4e4SfRw0dOFH1tKyo03Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AC1wRMaabs5EJx97dnYBHtHn4JKlWG8aF+lSWJBuGIOYoYzkNoQTLUJbzZgRmtqVapBMTeoXh3agm4ZCYpN9Z/cUVFmuch4F1m1+Hd+CG/Rr4gNQpUpl469kGqppUsVKTwdg+/+8WI8ZScv/ugV8pTAWpLXvhTL0xNGO7MltjgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCTBLbZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04930C4CEE7;
	Wed, 18 Jun 2025 15:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750259589;
	bh=RxyUMiuudcd2zaA9C02HdB4e4SfRw0dOFH1tKyo03Xs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iCTBLbZU36w1Zp3/rnRzCErxrw/EdeiCJDh5MZ0zfFPsikPoe1GXRq9CZ8XC0HvjI
	 nmSem/3/YMOxILryJTK84Wndu2JvYr0OlUQI28L87Zc9+WfM76QWaKB0Hw0Wn2VOd0
	 jZqOfzou9PBHPQoriWY00jOx0QdWAzSg5yiwGx3L3rruxh+Vbf8WOwlvsSPEZ/stRi
	 mwBDLK1cehod3Y22/GR0LD5vTg1vhVFQr5m7hlG1+7tsrwKo4tOG2wETEGtqMvYGWT
	 RXZQwx51RExTQwdAEVEO0fU3e9DSBM9Xt5IwkLy1T7KSXQLvReFvyt8YDOyYnPaa2K
	 bJm2N06dt8m5A==
Date: Wed, 18 Jun 2025 10:13:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Joel Mathew Thomas <proxy0@tutamail.com>, tcm4095@gmail.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH for-linus] PCI: pciehp: Ignore belated Presence Detect
 Changed caused by DPC
Message-ID: <20250618151307.GA1203119@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9c4286a16253af7e93eaf12e076e3ef3546367a.1750257164.git.lukas@wunner.de>

On Wed, Jun 18, 2025 at 04:38:25PM +0200, Lukas Wunner wrote:
> Commit c3be50f7547c ("PCI: pciehp: Ignore Presence Detect Changed caused
> by DPC") sought to ignore Presence Detect Changed events occurring as a
> side effect of Downstream Port Containment.
> 
> The commit awaits recovery from DPC and then clears events which occurred
> in the meantime.  However if the first event seen after DPC is Data Link
> Layer State Changed, only that event is cleared and not Presence Detect
> Changed.  The object of the commit is thus defeated.
> 
> That's because pciehp_ist() computes the events to clear based on the
> local "events" variable instead of "ctrl->pending_events".  The former
> contains the events that had occurred when pciehp_ist() was entered,
> whereas the latter also contains events that have accumulated while
> awaiting DPC recovery.
> 
> In practice, the order of PDC and DLLSC events is arbitrary and the delay
> in-between can be several milliseconds.
> 
> So change the logic to always clear PDC events, even if they come after an
> initial DLLSC event.
> 
> Fixes: c3be50f7547c ("PCI: pciehp: Ignore Presence Detect Changed caused by DPC")
> Reported-by: Lương Việt Hoàng <tcm4095@gmail.com>
> Reported-by: Joel Mathew Thomas <proxy0@tutamail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219765#c165
> Tested-by: Lương Việt Hoàng <tcm4095@gmail.com>
> Tested-by: Joel Mathew Thomas <proxy0@tutamail.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Applied to pci/for-linus for v6.16, thanks, Lukas!

> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index ebd342b..91d2d92 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -771,7 +771,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>  		u16 ignored_events = PCI_EXP_SLTSTA_DLLSC;
>  
>  		if (!ctrl->inband_presence_disabled)
> -			ignored_events |= events & PCI_EXP_SLTSTA_PDC;
> +			ignored_events |= PCI_EXP_SLTSTA_PDC;
>  
>  		events &= ~ignored_events;
>  		pciehp_ignore_link_change(ctrl, pdev, irq, ignored_events);
> -- 
> 2.47.2
> 

