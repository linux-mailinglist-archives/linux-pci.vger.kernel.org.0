Return-Path: <linux-pci+bounces-11563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEDD94D7C2
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 21:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919441C2298C
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 19:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F961607B7;
	Fri,  9 Aug 2024 19:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8M+CAKx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8541465BA;
	Fri,  9 Aug 2024 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723233450; cv=none; b=qk3YLPYCN7oP6xQfnTpd+IRX/onEGqIpyjLPLks0mkA4WVAPvMQXLMT8pEIeHAfbsIsKMqkBSdYMBj6OFrhMQJJw5Dh4ahCc0Okiahny3dKQFfWB4o8PK6UIA+XC2vZy0YyAQ7LhEQ/iU5kp7sYpXzMRFa0r7Y9VuLMa/SpNV2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723233450; c=relaxed/simple;
	bh=BZiCec9p249HTHunjRa3pP4QNirpr7DiyThJAsr0WDw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jxk5Vyu5Oaw0ztyTlMHvMZ3us9DtN6mxPhC0iDELDwMoV9jU5ryqbLauZbR2qOGXEXa0L3dvoWNaaxSyTijXJA6wiWpGbl5qTKtBM+BLTW0d0xNdzt4k8xwvJvq21SpfwY+nwTn4yVAMV8O3mfjCAbHwoErJ9Nn9qMq/dVgPKFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8M+CAKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D9AC32782;
	Fri,  9 Aug 2024 19:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723233449;
	bh=BZiCec9p249HTHunjRa3pP4QNirpr7DiyThJAsr0WDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=h8M+CAKxvC4ze2u0D4yAA2PsF6RgKV4O8WrvxwdDDWUTdT3dvSG6mgzEC+RiWfEHg
	 I9oO0S0BBWr5EApKE/NcsUKTRp1VeswhbXh4Q98geIczLx7kulEzJjQl+6ISK4Pgpc
	 6D08EDSuvUUIaXpOQjYBlVUxqWP9ZKbZUvfF7cQCdiz3b21ad6goHY3QuPJFglznqq
	 AJ2sI97XuvBKXOhjRPC5ZI7uHnt3lCBqKO7ZdyxYsp+YmN+W/hbWu2Rj/Dd/GqFYyY
	 QtKMm/Kccrq4/XbMiMum0wQsBWFv/tBvkJwSpuxd1zUB6awXWOUVJJUHFtTKTFJ0kF
	 3/UpFMTKWaj6Q==
Date: Fri, 9 Aug 2024 14:57:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Matthew W Carlis <mattc@purestorage.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] PCI: Rework error reporting with PCIe failed link
 retraining
Message-ID: <20240809195727.GA209985@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2408091017050.61955@angie.orcam.me.uk>

On Fri, Aug 09, 2024 at 02:24:40PM +0100, Maciej W. Rozycki wrote:
> Hi,
> 
>  This is v2 superseding a patch series originally posted here: 
> <https://lore.kernel.org/r/alpine.DEB.2.21.2402092125070.2376@angie.orcam.me.uk/>.
> 
>  This patch series addresses issues observed by Ilpo as reported here: 
> <https://lore.kernel.org/r/aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linux.intel.com/>, 
> one with excessive delays happening when `pcie_failed_link_retrain' is 
> called, but link retraining has not been actually attempted, and another 
> one with an API misuse caused by a merge mistake.
> 
>  It also addresses an issue observed by Matthew as discussed here: 
> <https://lore.kernel.org/r/20240806000659.30859-1-mattc@purestorage.com/> 
> and here: 
> <https://lore.kernel.org/r/20240722193407.23255-1-mattc@purestorage.com/>. 
> where a stale LBMS bit state causes `pcie_failed_link_retrain', in the 
> absence of a downstream device, to leave the link stuck at the 2.5GT/s 
> speed rate, which then negatively impacts devices plugged in in the 
> future.
> 
>  See individual change description for further details; 1/4 and 2/4 are 
> new changes, 3/4 supersedes: 
> <https://patchwork.kernel.org/project/linux-pci/patch/alpine.DEB.2.21.2402100045590.2376@angie.orcam.me.uk/>, 
> and 4/4 supersedes: 
> <https://patchwork.kernel.org/project/linux-pci/patch/alpine.DEB.2.21.2402100048440.2376@angie.orcam.me.uk/>.
> 
>  These changes have been verified with a SiFive HiFive Unmatched system, 
> also using a small debug change to verify that the state of the LBMS bit 
> is clear at the exit from `pcie_failed_link_retrain'.
> 
>  Ilpo, since 3/4 and 4/4 have only been trivially updated and their 
> combined effect is not changed even I chose to retain your Reviewed-by 
> tags from v1.  Let me know if you disagree and what to do so you don't.
> 
>  I apologise to take so long, it's been a tough period to me load-wise.

Applied to pci/enumeration for v6.12, thanks for all this debugging
and work.

Matthew, let me know if this addresses the problems you saw, and I can
add your tested-by if appropriate.

Bjorn

