Return-Path: <linux-pci+bounces-19924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FF1A12D13
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 22:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90E01887648
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 21:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908F41547C5;
	Wed, 15 Jan 2025 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAkqFTwy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686C4135A63;
	Wed, 15 Jan 2025 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736974864; cv=none; b=tIrxsz5oqmG12dIPzB4qdg9g8HXTMLaxo83N0yBXuCjEWcYS5y83ntI/bk15Qtiz3H1e6asVNHu+rWsr8wLc5FOSE5HAJTa3r0jUvZVvpGTFyvXMiSAS39kn/a+/ko+ke7JljrWiGR4tD+5IOnIc2B3mH9KLcGmzzkIdYRCWaYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736974864; c=relaxed/simple;
	bh=xk8w/Hm5T7hq0bK1cULse3KqEqZPAlwxboMPLxitLa8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FfWy/6vjGss910Kkw14oqlTDoM1mHNuEyW0vmanumv0IV/lZuDQ/IvhCPphNqwz6EWX7Gn0Q8ftDRNVN1S6wlP+h1U/ORDn50BdPkU+ZJq33/2QZNZSWgDhzcFDMft9OQbmM94YDj7zBYAeajRjv8uwud7TvPWBYkgcdqg93G94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAkqFTwy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7620C4CED1;
	Wed, 15 Jan 2025 21:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736974864;
	bh=xk8w/Hm5T7hq0bK1cULse3KqEqZPAlwxboMPLxitLa8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bAkqFTwyGWq1JZNUw1vqjc13lXgIrUHbWnNpPKMFJL1Z/xPhai054sfv1kJYE6rWK
	 Nxct+kmuSHfJyXzcW78+TlOSHqOcV86o0Xyp/qD1LhYO/Z1PaHLUsjLl1a/z0VgbxN
	 OYJNMmdJnj3fY6nVn0SCeAFzTgbSVG2NPoYzhxPjt+zPC0SZsBy4FB32OYVokg5ToD
	 fhMyEm0NgxHafeWF13Q8apb0ltiBu6qU/c8UMDuFx2Cn2GwIJ3DvBi/SFh1XHUbnb8
	 iR/RauLdHb6wNw35k6tx4us/WGSa4nqNn3+zYZsbIRdyi0tV7F+wwakRtzuQXLgJAJ
	 ucxPKLZJBgHkg==
Date: Wed, 15 Jan 2025 15:01:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 0/2] PCI: Convert the Apple controller to host bridge
 hooks
Message-ID: <20250115210102.GA551434@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204150145.800408-1-maz@kernel.org>

On Wed, Dec 04, 2024 at 03:01:43PM +0000, Marc Zyngier wrote:
> The Apple PCIe controller requires some additional attention when
> enabling an endpoint device, so that the RID gets correctly mapped to
> a SID on its way to the IOMMU.
> 
> So far, we have need relying on a custom bus notifier to perform this
> task, but Frank Li's series [1] is a better approach as it puts the
> complexity in the core code instead of the host controller driver, and
> this series builds on that:
> 
> - allow the new {en,dis}able_device() to be provided via pci_ecam_ops
> 
> - convert the Apple PCIe driver to that infrastructure
> 
> Patches on top of 6.13-rc1, plus Frank's v7 series.
> 
> [1] https://lore.kernel.org/r/20241203-imx95_lut-v7-0-d0cd6293225e@nxp.com
> 
> Marc Zyngier (2):
>   PCI: host-generic: Allow {en,dis}able_device() to be provided via
>     pci_ecam_ops
>   PCI: apple: Convert to {en,dis}able_device() callbacks
> 
>  drivers/pci/controller/pci-host-common.c |  2 +
>  drivers/pci/controller/pcie-apple.c      | 75 +++++-------------------
>  include/linux/pci-ecam.h                 |  4 ++
>  3 files changed, 21 insertions(+), 60 deletions(-)

Applied to pci/controller/iommu-map for v6.14, thank you!

Bjorn

