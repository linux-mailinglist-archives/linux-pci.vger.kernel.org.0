Return-Path: <linux-pci+bounces-23517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8301A5E1CF
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 17:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C89017796A
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 16:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B531023CEE7;
	Wed, 12 Mar 2025 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioAFRGk4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913A623C367
	for <linux-pci@vger.kernel.org>; Wed, 12 Mar 2025 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741796987; cv=none; b=djrSWbu2cxXujfP0kLynQgq0yvjPumsQUQ7A36B57UPpjsiUWGoQjwNx/iOcMOWNi16SAmTwFpGCbFExLbXglrprVHt/C+/Z1hFgo6KcxYqeplulT9sS/I89jPfK3txIDKuTloNcWWIT85G+HxVihRD9ZtytSlFrqa10PmNQ0v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741796987; c=relaxed/simple;
	bh=kjECReFy4yiPntdE+s30vN+hpaL3k0y5cCiyjTPu4nk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LRoYgSbO36G9eQSUWoPmPVoEa5POCQeir83Vbbt2s5R10rJAmK0ccjuVwq4U7PSTL34FxVqE0ZApM399MHFD61KZ+VIa3sOE6uS7tRJEhNhqqXVO8x2TGVU0TlB9rNo0dL3dIpPvBe/WVJu3doq17b/y0EYf8qOgMTuzu8b3p0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioAFRGk4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DD0C4CEEC;
	Wed, 12 Mar 2025 16:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741796987;
	bh=kjECReFy4yiPntdE+s30vN+hpaL3k0y5cCiyjTPu4nk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ioAFRGk4w+zbKtQcrWSsnTVzYVixiLNd8PMeX06PXqkQ/Fs3Yaev3G1w/N+B7Z10C
	 Oee6/+CmksOD4SK9GjzSXiYfdDfGRU9ywviO2h9V3y+Ciry9i60Dabmhc77w9rWzgT
	 w1sBV6mJce+bkJq5AMzqN5y2nPfjkpt2k7ST47dbSx73AyvNWh0GuOJdFObwSxnetq
	 zsbueR2hZRWdgwsJNJ8ZpJvJKo9k1ESul+fZDa4yycULHLsxZM7krek/t8jkm3YiPN
	 jVQV44yDTGqC3NrwqkYIVWBZEwC1qoZKMYedZMZ1nV9VesJoEFtJO8GV11BzYGQU+5
	 Oc1rKLq+Rn6Nw==
Date: Wed, 12 Mar 2025 11:29:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Kenneth Crudup <kenny@panix.com>,
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Ricky Wu <ricky_wu@realtek.com>
Subject: Re: [PATCH] PCI: pciehp: Avoid unnecessary device replacement check
Message-ID: <20250312162945.GA689268@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02f166e24c87d6cde4085865cce9adfdfd969688.1741674172.git.lukas@wunner.de>

On Tue, Mar 11, 2025 at 07:27:32AM +0100, Lukas Wunner wrote:
> Hot-removal of nested PCI hotplug ports suffers from a long-standing
> race condition which can lead to a deadlock:  A parent hotplug port
> acquires pci_lock_rescan_remove(), then waits for pciehp to unbind
> from a child hotplug port.  Meanwhile that child hotplug port tries to
> acquire pci_lock_rescan_remove() as well in order to remove its own
> children.
> 
> The deadlock only occurs if the parent acquires pci_lock_rescan_remove()
> first, not if the child happens to acquire it first.
> 
> Several workarounds to avoid the issue have been proposed and discarded
> over the years, e.g.:
> 
> https://lore.kernel.org/r/4c882e25194ba8282b78fe963fec8faae7cf23eb.1529173804.git.lukas@wunner.de/
> 
> A proper fix is being worked on, but needs more time as it is nontrivial
> and necessarily intrusive.
> 
> Recent commit 9d573d19547b ("PCI: pciehp: Detect device replacement
> during system sleep") provokes more frequent occurrence of the deadlock
> when removing more than one Thunderbolt device during system sleep.
> The commit sought to detect device replacement, but also triggered on
> device removal.  Differentiating reliably between replacement and
> removal is impossible because pci_get_dsn() returns 0 both if the device
> was removed, as well as if it was replaced with one lacking a Device
> Serial Number.
> 
> Avoid the more frequent occurrence of the deadlock by checking whether
> the hotplug port itself was hot-removed.  If so, there's no sense in
> checking whether its child device was replaced.
> 
> This works because the ->resume_noirq() callback is invoked in top-down
> order for the entire hierarchy:  A parent hotplug port detecting device
> replacement (or removal) marks all children as removed using
> pci_dev_set_disconnected() and a child hotplug port can then reliably
> detect being removed.
> 
> Fixes: 9d573d19547b ("PCI: pciehp: Detect device replacement during system sleep")
> Reported-by: Kenneth Crudup <kenny@panix.com>
> Closes: https://lore.kernel.org/r/83d9302a-f743-43e4-9de2-2dd66d91ab5b@panix.com/
> Reported-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> Closes: https://lore.kernel.org/r/20240926125909.2362244-1-acelan.kao@canonical.com/
> Tested-by: Kenneth Crudup <kenny@panix.com>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.11+

Applied with Mika's reviewed-by to pci/hotplug for v6.15, thanks,
Lukas!

Thanks to Kenneth and AceLan for all your work to report and test
this, and to everybody who helped debug and puzzle this out.  I really
appreciate all your work and patience.

> ---
>  drivers/pci/hotplug/pciehp_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index ff458e6..997841c 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -286,9 +286,12 @@ static int pciehp_suspend(struct pcie_device *dev)
>  
>  static bool pciehp_device_replaced(struct controller *ctrl)
>  {
> -	struct pci_dev *pdev __free(pci_dev_put);
> +	struct pci_dev *pdev __free(pci_dev_put) = NULL;
>  	u32 reg;
>  
> +	if (pci_dev_is_disconnected(ctrl->pcie->port))
> +		return false;
> +
>  	pdev = pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0));
>  	if (!pdev)
>  		return true;
> -- 
> 2.43.0
> 

