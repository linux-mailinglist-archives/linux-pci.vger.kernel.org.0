Return-Path: <linux-pci+bounces-11517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9C694C680
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 23:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CBFF1C21E03
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 21:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6201A158853;
	Thu,  8 Aug 2024 21:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZuj7V1J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39245156238;
	Thu,  8 Aug 2024 21:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723154086; cv=none; b=nIeCKdkOgVFvy4MaouSd+cNolVrtikhfWrYSPg8GjBLOw11A6zn25Q2zreqIUD3wUIQ5JrrbxM3Zh2KOdEMCDFhnmw4z5rTJFZgrHyl9LgFiVuLIFHGPVJnSbv6Xhh3d82zlF+v8/Yb7pl956/bGOaydM0ITH9MdbfH2dgQZmxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723154086; c=relaxed/simple;
	bh=LoslgA8E8+8H3FxNBhFY04ImXxOkq0yqahD0vaNKJng=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=u+JDCj843V8j9ezOPYXOsqJencx3bz5Mttimu9nsTRgF3NO+FEBsPv1oUVOCqWGEdcdtM8k8Cb1MCLgtzZF+TJ2PZxToA3mjvwwsOySVsxx6n/zeiMJ9O8ezZrjPfKMJ9oDdbvKFrOBfeNTlL79Brt19stvHcKYNC8Ug7W/s5N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZuj7V1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FE0C32782;
	Thu,  8 Aug 2024 21:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723154085;
	bh=LoslgA8E8+8H3FxNBhFY04ImXxOkq0yqahD0vaNKJng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jZuj7V1JFJXnJhAS/COPznmUBhLfVnHLMKzeOnNjSItELqv3urCFabunwC9bu97O8
	 z32bLDslRNqMQxEBBAZPeed13pDXBdymvYRvTRGZSsCrS9pcLtVYH4NdkG+fL7xS7Y
	 9zgCL8C2O2vfyHyxmV1Ua4aPmH6orw1+/GRMAHD/LvBLLGAdFM7JhdMYGQCTReWys7
	 ouYSXs34Rvmr5e9RARueXE1CChn0TtsSax0MDKXUXvuhCHVbsugLQ2ALiLpaWylrwn
	 CycgPjwk8CmFVoks3wufuBcXWuTb9Cvt+mu3Utd9MowitbEjpQ9Cf5FqtRKopPdYut
	 7YErv9ar6iI4Q==
Date: Thu, 8 Aug 2024 16:54:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stewart Hildebrand <stewart.hildebrand@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/8] PCI: Restore resource alignment
Message-ID: <20240808215443.GA158993@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d46536be-9036-44f5-a208-34f6c69b4ead@amd.com>

On Thu, Aug 08, 2024 at 04:28:50PM -0400, Stewart Hildebrand wrote:
> On 8/8/24 15:28, Bjorn Helgaas wrote:
> > On Wed, Aug 07, 2024 at 11:17:12AM -0400, Stewart Hildebrand wrote:
> >> Devices with alignment specified will lose their alignment in cases when
> >> the bridge resources have been released, e.g. due to insufficient bridge
> >> window size. Restore the alignment.
> > 
> > I guess this fixes a problem when the user has specified
> > "pci=resource_alignment=..." and we've decided to release and
> > reallocate a bridge window?  Just looking for a bit more concrete
> > description of what this problem would look like to a user.
> 
> Yes. When alignment has been specified via pcibios_default_alignment()
> or by the user with "pci=resource_alignment=...", and the bridge window
> is being reallocated, the specified alignment is lost and the resource
> may not be sufficiently aligned after reallocation.
> 
> I can expand the commit description.

I think a hint about where the alignment gets lost would be helpful,
too.

This seems like a problem users could be seeing today, even
independent of the device passthrough issue that I think is the main
thrust of this series.  If there's a problem report or an easy way to
reproduce this problem, that would be nice, too.

Bjorn

