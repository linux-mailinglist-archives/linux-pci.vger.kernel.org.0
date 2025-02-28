Return-Path: <linux-pci+bounces-22657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5D7A4A0BC
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 18:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497371893820
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 17:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07CA1F4CB9;
	Fri, 28 Feb 2025 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccuDFX6u"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3471BCA1C;
	Fri, 28 Feb 2025 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764711; cv=none; b=pQaiYZmyWJewYEixkJzCJLCOgWT8nmAMbvnCNpKRFnazYXVgPRYsOiTXxB30bH1Df1KXFxyHDJebUAvIJsqnIhyhzy7aSqvkgwOeOpB366EAehyIugGltulIyXT4MkDtn9Z1RuqK8Xok0PHBSG6qwGEMppjSvNqtDz2XK8I7BnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764711; c=relaxed/simple;
	bh=Be8JiKViprG/35y62i+pD4AsM5Tw5jHNYjVl9cJ8hQw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Es/bKITqQ/SGDPRg3A7UZ5YUE5/Ymawx/b+Q+IgeVaHhwwm9tgtYkIgUJJuCceeh07pWzHRVH0Xp+nQdUJf/yIZ6JYEq5O5QBaRqeuKokK8na89+gYGQPFkOuWrJ33lrM0HLhZ0+nItseRNk47yJPR9+SVrl6i4M/oV9EQkveBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccuDFX6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FA7C4CED6;
	Fri, 28 Feb 2025 17:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740764710;
	bh=Be8JiKViprG/35y62i+pD4AsM5Tw5jHNYjVl9cJ8hQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ccuDFX6uhWkU3S1yoYepRdColv2hjj9HHXWE+B2YBjayx48qKdPtW3q8ADzXPwmkr
	 G4mGeaE82Wner95FHb6YpDJy84gcbmKhZ8UrqHYR2RduGSwxElFnCjzPpD7tWPyDRd
	 UojHVsJhDFH7Nm2sqwR5aeboQuOf8I3wEslOFk8N388I1R56sHe6QUsImMApiqHSIJ
	 oZZdiW2e2OQvOrDqjfcVH4DqB/4HBguvtkMiYPdW21yG8Ge/mhxlEMHyZJkLhhtNo6
	 V8GOmYmBk3y6/1Ha1YhLb2xGyoqxZ4v8zrBf/jTcE9eatm/ytMj6HvFFfUVzK0620K
	 z4HO3yx3sn9Xw==
Date: Fri, 28 Feb 2025 11:45:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Hsin-Yi Wang <hsinyi@chromium.org>,
	linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	lukas@wunner.de,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v5] PCI: Allow PCI bridges to go to D3Hot on all
 Devicetree based platforms
Message-ID: <20250228174509.GA58365@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126151711.v5.1.Id0a0e78ab0421b6bce51c4b0b87e6aebdfc69ec7@changeid>

On Tue, Nov 26, 2024 at 03:17:11PM -0800, Brian Norris wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Unlike ACPI based platforms, there are no known issues with D3Hot for
> the PCI bridges in Device Tree based platforms. 

Can we elaborate on this a little bit?  Referring to "known issues
with ACPI-based platforms" depends on a lot of domain-specific history
that most readers (including me) don't know.

I don't think "ACPI-based" or "devicetree-based" are good
justifications for changing the behavior because they don't identify
any specific reasons.  It's like saying "we can enable this feature
because the platform spec is written in French."

> Past discussions (Link [1]) determined the restrictions around D3
> should be relaxed for all Device Tree systems. 

This is far too generic a statement for me to sign up to, especially
since "all Device Tree systems" doesn't say anything at all about how
any particular hardware works or what behavior we're relying on.

We need to say something about what D3hot means (i.e., only message
and type 0 config requests accepted) and that we know anything below
the bridge is inaccessible in D3hot and why that's OK.  E.g., maybe we
only care about wakeup requests and we know those still work with the
bridge in D3hot because XYZ.

> So let's allow the PCI bridges to go to D3Hot during runtime.
> 
> To match devm_pci_alloc_host_bridge() -> devm_of_pci_bridge_init(), we
> look at the host bridge's parent when determining whether this is a
> Device Tree based platform. Not all bridges have their own node, but the
> parent (controller) should.
> 
> Link: https://lore.kernel.org/linux-pci/20240227225442.GA249898@bhelgaas/ [1]
> Link: https://lore.kernel.org/linux-pci/20240828210705.GA37859@bhelgaas/ [2]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> [Brian: look at host bridge's parent, not bridge node; rewrite
> description]
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> Based on prior work by Manivannan Sadhasivam that was part of a bigger
> series that stalled:
> 
> [PATCH v5 4/4] PCI: Allow PCI bridges to go to D3Hot on all Devicetree based platforms
> https://lore.kernel.org/linux-pci/20240802-pci-bridge-d3-v5-4-2426dd9e8e27@linaro.org/
> 
> I'm resubmitting this single patch, since it's useful and seemingly had
> agreement. I massaged it a bit to relax some restrictions on how the
> Device Tree should look.
> 
> Changes in v5:
> - Pulled out of the larger series, as there were more controversial
>   changes in there, while this one had agreement (Link [2]).
> - Rewritten with a relaxed set of rules, because the above patch
>   required us to modify many device trees to add bridge nodes.
> 
>  drivers/pci/pci.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e278861684bc..5d898f5ea155 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3018,6 +3018,8 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
>   */
>  bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  {
> +	struct pci_host_bridge *host_bridge;
> +
>  	if (!pci_is_pcie(bridge))
>  		return false;
>  
> @@ -3038,6 +3040,15 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  		if (pci_bridge_d3_force)
>  			return true;
>  
> +		/*
> +		 * Allow D3 for all Device Tree based systems. We assume a host
> +		 * bridge's parent will have a device node, even if this bridge
> +		 * may not have its own.
> +		 */
> +		host_bridge = pci_find_host_bridge(bridge->bus);
> +		if (dev_of_node(host_bridge->dev.parent))
> +			return true;
> +
>  		/* Even the oldest 2010 Thunderbolt controller supports D3. */
>  		if (bridge->is_thunderbolt)
>  			return true;
> -- 
> 2.47.0.338
> 

