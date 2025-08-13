Return-Path: <linux-pci+bounces-33972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07135B2521F
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 19:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBAF417FA52
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 17:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4B028150A;
	Wed, 13 Aug 2025 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMqVgsKj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AE9303CAC;
	Wed, 13 Aug 2025 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755105955; cv=none; b=G3+cw/R3jI3KPkSzYdS7MB+YZcjE9V8lbXZb/0GqaAWtpDF6s8wsK9f8SonStjDOFSOiQyrmWYEw25tFBotVDFxOq1E33lgOT66WiZm3tBz/Cy6nclpKUTMmTWpcmDtFvFrB2ktgNJJgUOxHQua9kknwhtK9k0Qv9z4QAYACkTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755105955; c=relaxed/simple;
	bh=J2ZUsbh8vFjAYeyMTlqPYs0AKnwiTzEgbpyaPxJDLdY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JsEw0rMX1ZMINoCNCRHkLxoFjs2JhN2HAGinDNB5HffKXFWihfSLafw6RLMlA9Y7c6gAALnhS1zkYIuUZBwG991Sy7mw94WkaEF4GcQxer61/4cMk0kmzQLMHtoJQc/TAR//1BK4GzsxK9Ds9cxB508ukCLv/2IdoSsf0UzWfyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMqVgsKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6851AC4CEEB;
	Wed, 13 Aug 2025 17:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755105953;
	bh=J2ZUsbh8vFjAYeyMTlqPYs0AKnwiTzEgbpyaPxJDLdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gMqVgsKjknax0d2sBsgEUcsXh3FRmnJz2LlBmg8qM0S0sFAlu17i1s0CqAOwRsYmi
	 6hyJs8JUWOBbX8M2iDwQ87ukoWFPDdHUsDZ9PC98hNFE3f4CmEs417W2+hT2YkBUGB
	 P5niyZmNuElyQP1IAxBZQi/JifPrC8TexRet2wOw3nQhqotGvYSQ6HJnwXQ/k4RL1P
	 IsFTOhoBciJ2BGvOBq0Q/Ey2n9eDGjrzORwdtTx3oFGJO5ajtfMVNKb6FWlM265Tu8
	 +x5hZcAMS5ZLxGqlm+hSCvxLIjI8NT9NvDN1yGDCypV33xKkAxrqWeuI3Su8S8CI6f
	 9CgScOHERn/QQ==
Date: Wed, 13 Aug 2025 12:25:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Use is_pciehp instead of is_hotplug_bridge
Message-ID: <20250813172552.GA279834@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5632086b8436bc2f9a43e3573acf7a090615b52f.1755005459.git.lukas@wunner.de>

On Tue, Aug 12, 2025 at 03:42:29PM +0200, Lukas Wunner wrote:
> The thunderbolt driver sets up device link dependencies from hotplug ports
> to the Host Router (aka Native Host Interface, NHI).  When resuming from
> system sleep, this allows the Host Router to re-establish tunnels to
> attached Thunderbolt devices before the hotplug ports resume.
> 
> To identify the hotplug ports, the driver utilizes the is_hotplug_bridge
> flag which also encompasses ACPI slots handled by the ACPI hotplug driver.
> 
> Thunderbolt hotplug ports are always Hot-Plug Capable PCIe ports, so it is
> more apt to identify them with the is_pciehp flag.
> 
> Similarly, hotplug ports on older Thunderbolt controllers have broken MSI
> support and are quirked to use legacy INTx interrupts instead.  The quirk
> identifies them with is_hotplug_bridge, even though all affected ports are
> also matched by is_pciehp.  So use is_pciehp here as well.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> The is_pciehp flag was introduced by commit 6cff20ce3b92 ("PCI/ACPI: Fix
> runtime PM ref imbalance on Hot-Plug Capable ports"), which appeared in
> v6.17-rc1.  This patch is submitted separately because it is intended
> to be applied through thunderbolt.git instead of pci.git.  Thanks!
> 
>  drivers/pci/quirks.c     | 2 +-
>  drivers/thunderbolt/tb.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d97335a..17315a8 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3829,7 +3829,7 @@ static void quirk_no_pm_reset(struct pci_dev *dev)
>   */
>  static void quirk_thunderbolt_hotplug_msi(struct pci_dev *pdev)
>  {
> -	if (pdev->is_hotplug_bridge &&
> +	if (pdev->is_pciehp &&
>  	    (pdev->device != PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C ||
>  	     pdev->revision <= 1))
>  		pdev->no_msi = 1;
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index c14ab1f..83a33fc 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -3336,7 +3336,7 @@ static bool tb_apple_add_links(struct tb_nhi *nhi)
>  		if (!pci_is_pcie(pdev))
>  			continue;
>  		if (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM ||
> -		    !pdev->is_hotplug_bridge)
> +		    !pdev->is_pciehp)
>  			continue;
>  
>  		link = device_link_add(&pdev->dev, &nhi->pdev->dev,
> -- 
> 2.47.2
> 

