Return-Path: <linux-pci+bounces-12131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C8195D4A7
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 19:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C421F22B0D
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 17:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F8418D64F;
	Fri, 23 Aug 2024 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/wnBe5s"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1030A188A12;
	Fri, 23 Aug 2024 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724435232; cv=none; b=AS1qBWAwOTCy+AN3eWOSmCWnAXNCIYjGn5vzvxcM+bE7+iAFfcWuclb92bE7Pn7crRh5OW2Yx+78o4HhHTad7R9n4fvP0LMjqINYSTkXAIeJXATBQXKOVDG6Um3K5UF57QMepQ34HYW/PP9hZa56XnWmCiPBz9w6Dfa071+kQYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724435232; c=relaxed/simple;
	bh=7ze++N9tAqQa+Vfl2HhIKMb98yr0SEaVJcjB5T/i8MA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ym5bvvB3Bv2oipOb4xBc7OeLwNXSxobCXV6fCwIQMIijw8l8aNu4IA1YKQvrSmlILxLPETzDWJzXrt6fGWjj1cjXN1AvvYZvbL4PDGVGtDhGMag/hvRaNNgwLv5j35rQQMswb0MoI4Y227dDCcKaBDwBqPROqPkAES1Mhtkc38Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/wnBe5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A20C32786;
	Fri, 23 Aug 2024 17:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724435231;
	bh=7ze++N9tAqQa+Vfl2HhIKMb98yr0SEaVJcjB5T/i8MA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=R/wnBe5szUSqLSLq6C5ICB/yz51hjIp1iPiDRh/iQPa7c57g6vB0joavp+YxoNS0q
	 4GzcZfNxqi2e3mV3mg6ynO3aqVTemsRNXxLZHMbfGlFh6mCN6O9JT5dn4OzpgPnJ56
	 wRgIFVdH6iglqZpDPlyOGAJocWcpaPKGI3+k98/gAzBYCg63K8Te2dtRwdntmdKhka
	 RPIoFoleh9+aSY+LujEQ3IZ/Zzf6ZVlad4yNdG11s20HaYR9UeUVtQ7lcIANYHAlRR
	 yV+yUTDvEUXVYaSC/DkgaUX1q1cFezBhrlZkce8D+h8cRST3lj/OYmmPG0qGTMxRPt
	 oWKitiOVrTI7Q==
Date: Fri, 23 Aug 2024 12:47:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PCI: Make pci_bus_type constant
Message-ID: <20240823174709.GA375542@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823074202.139265-1-kunwu.chan@linux.dev>

On Fri, Aug 23, 2024 at 03:42:01PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <chentao@kylinos.cn>
> 
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the pci_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Applied to pci/misc for v6.12, thanks!

> ---
>  drivers/pci/pci-driver.c | 2 +-
>  include/linux/pci.h      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index f412ef73a6e4..35270172c833 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1670,7 +1670,7 @@ static void pci_dma_cleanup(struct device *dev)
>  		iommu_device_unuse_default_domain(dev);
>  }
>  
> -struct bus_type pci_bus_type = {
> +const struct bus_type pci_bus_type = {
>  	.name		= "pci",
>  	.match		= pci_bus_match,
>  	.uevent		= pci_uevent,
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 4246cb790c7b..0d6c1c089aca 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1098,7 +1098,7 @@ enum pcie_bus_config_types {
>  
>  extern enum pcie_bus_config_types pcie_bus_config;
>  
> -extern struct bus_type pci_bus_type;
> +extern const struct bus_type pci_bus_type;
>  
>  /* Do NOT directly access these two variables, unless you are arch-specific PCI
>   * code, or PCI core code. */
> -- 
> 2.41.0
> 

