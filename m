Return-Path: <linux-pci+bounces-26773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE54A9CE34
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 18:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E0B9E7AF3
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 16:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FDE199E84;
	Fri, 25 Apr 2025 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUojlsDi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E506C18D656;
	Fri, 25 Apr 2025 16:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745598782; cv=none; b=bR3qJBOaG/8S5mMB4YwOX11AeRcsLPM+N48ITSn+8H/p8sD+A7MteIee6pJbx/2yLuIUQgju4oI6GimRAGBzqRj13UoMEvFouCyMckKBLtqj0JoBcwj44oT0tqHGQQzGFUkyGDFgPbQo5kp5V4ANBrfQF97/C4dWLXcv/Cm+ioI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745598782; c=relaxed/simple;
	bh=qdn06Ig19le3g25nTF9qwPRm9Ux+kIwtPnK5A7jKUQs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IFGlMmIMbM7YKnyzNiGpfpxjJNd2wvamp07a8kGLcE1t+m37KWSY51jQy7P+rNRbyVBn80BtrpdSKLUGB6T2dxEjGYpBQtHcsm1c18C298OIrV3jP+x42YYuAyse3m2O8l+xG0CIBfyZMTBTzGfaoXcVC8AuF6H6e2l4/Lj02LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUojlsDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDCBC4CEE4;
	Fri, 25 Apr 2025 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745598781;
	bh=qdn06Ig19le3g25nTF9qwPRm9Ux+kIwtPnK5A7jKUQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SUojlsDiuPeT8+ts6cC0HnLoXfaejPjPoKtvLv4aSgZzuO1bfuU45w8JhwQIToRwx
	 HzXiNK/vxj87OmkOtAvNb6ZpxdvaWMGkIGqWrCQ+PbLd+t5IVR3/fK608nN/iAHtEw
	 ft6QJ4TXAbFZPGP35QzD0fyu5MNwKXRDFnzYAmlwLQxkw8imWwQUov9suPoCjBW7nT
	 1ikUsg5bRVANvQzcOSEpHfSe+M10n4VkNY6W4wffSJnxwzCG91Ud6p3vZpTftpvbQP
	 TIa0GJn/jv7kEIVbfqn+ni6h4A+zw0Qeh+XAUodSlLlBulXoS5fsA8Ac/VWyQgwSIX
	 toW8Uh2qezHmg==
Date: Fri, 25 Apr 2025 11:32:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	linux-pci@vger.kernel.org, iommu@lists.linux.dev,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 0/2] PCI: Clean up match_driver flag usage
Message-ID: <20250425163259.GA546441@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1745572340.git.lukas@wunner.de>

On Fri, Apr 25, 2025 at 11:24:20AM +0200, Lukas Wunner wrote:
> A small puzzle piece to improve maintainability of the PCI core:
> 
> The match_driver flag in struct pci_dev is used to postpone driver
> binding until all PCI devices have been enumerated.
> 
> The AMD IOMMU driver fiddles with the flag to work around breakage
> introduced 10 years ago.  The breaking change has since been reverted,
> so accessing the flag appears to be superfluous and is hereby dropped
> (patch [1/2]).  The patch needs an ack from AMD IOMMU maintainers.
> 
> This clears the way for moving the flag to struct pci_dev's priv_flags
> and thus prevent any further abuse outside the PCI core (patch [2/2]).
> 
> There are already two patches queued up in this cycle which amend
> priv_flags with new definitions for bits 4, 5 and 6 (on the pci/hotplug
> and pci/bwctrl topic branches), hence the bit number used here is 7.
> 
> Lukas Wunner (2):
>   Revert "iommu/amd: Prevent binding other PCI drivers to IOMMU PCI
>     devices"
>   PCI: Limit visibility of match_driver flag to PCI core
> 
>  drivers/iommu/amd/init.c |  3 ---
>  drivers/pci/bus.c        |  4 +++-
>  drivers/pci/pci-driver.c |  2 +-
>  drivers/pci/pci.h        | 11 +++++++++++
>  drivers/pci/probe.c      |  1 -
>  include/linux/pci.h      |  2 --
>  6 files changed, 15 insertions(+), 8 deletions(-)

Provisionally applied to pci/enumeration for build testing, pending
ack from AMD IOMMU folks.

