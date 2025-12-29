Return-Path: <linux-pci+bounces-43810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B93CE7BB1
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 18:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 852F230019CE
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 17:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43943128C7;
	Mon, 29 Dec 2025 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ht7pREL4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9FF27A107;
	Mon, 29 Dec 2025 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767029094; cv=none; b=rfNsAmSB407iSwH1MRevqk6EEGTE8llhxQgROHE/CS+CtFZ6vzFY1bu/IRuCn7Pb+WYw9akF3gIADzcSQYKG79QsUPDvP62D3BxErTEHDK/dLVomEa5hhcE52hIyotxfIJhX3Wny1T991PvdOY2vNfZpqPLkIclhnug7NqrhPfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767029094; c=relaxed/simple;
	bh=7+nZ5iLH+YQock7P2xAoKeLgV3L6gINgS2Xa/5WeERk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uAbNZwd2NFGncr7TxvT2BfILZkFzcSERO+9CelfMOdq92eAWgMIVjGYiKC9iP1VOyoJX1wxfS+ggKsGAes4lHceaxW5T6ORXCzT+URCgi2r2KgdM9zRFO7v465ECdIysc43K8FxwtJ7haK2Ln2wqztTIv2/2/yxRednpSpk8Afk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ht7pREL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F84C4CEF7;
	Mon, 29 Dec 2025 17:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767029094;
	bh=7+nZ5iLH+YQock7P2xAoKeLgV3L6gINgS2Xa/5WeERk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ht7pREL4lu07kj+wWOntCMk4Btj7011gg2hVfREanvHiDKD3pb0N/LvlQvjgfc6FS
	 q2aKvUMSioSJD+QwgTmJbeBudTfIbkLykIrEx6ePjLDHj/7nMvohLkEx7zL2r7etxu
	 gZREAgNvioOcP5Qhv9ccbk6H2p2ykx74Uzp21Tj1HLAiQIMEsc87OyuZWIb3WZNW0l
	 KtjRsGxQfT3ZLU5T4bMR3IzDInK73RvjFf6KMV23D+CVYnyAtNvjiAwIniict24x1I
	 cbhoK+TCkIkeNtgTyH9npShP1Xrx6xBZNdx5kR0CPMzvaGQza4iJpUC2B4mgSzUsNS
	 vqiENqj0mADUA==
Date: Mon, 29 Dec 2025 11:24:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: PCI: Fix typos in msi-howto.rst
Message-ID: <20251229172451.GA69159@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1766713528-173281-1-git-send-email-shawn.lin@rock-chips.com>

On Fri, Dec 26, 2025 at 09:45:28AM +0800, Shawn Lin wrote:
> Fix subjject-verb agreement for "has a requirements" as well as
> "neither...or" conjunction mistake. And convert "Message Signalled
> Interrupts" to "Message Signaled Interrupts" to match the PCIe spec.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied to pci/misc for v6.20, thanks!

> ---
> 
>  Documentation/PCI/msi-howto.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/PCI/msi-howto.rst b/Documentation/PCI/msi-howto.rst
> index 0692c9a..667ebe2 100644
> --- a/Documentation/PCI/msi-howto.rst
> +++ b/Documentation/PCI/msi-howto.rst
> @@ -98,7 +98,7 @@ function::
>  
>  which allocates up to max_vecs interrupt vectors for a PCI device.  It
>  returns the number of vectors allocated or a negative error.  If the device
> -has a requirements for a minimum number of vectors the driver can pass a
> +has a requirement for a minimum number of vectors the driver can pass a
>  min_vecs argument set to this limit, and the PCI core will return -ENOSPC
>  if it can't meet the minimum number of vectors.
>  
> @@ -127,7 +127,7 @@ not be able to allocate as many vectors for MSI as it could for MSI-X.  On
>  some platforms, MSI interrupts must all be targeted at the same set of CPUs
>  whereas MSI-X interrupts can all be targeted at different CPUs.
>  
> -If a device supports neither MSI-X or MSI it will fall back to a single
> +If a device supports neither MSI-X nor MSI it will fall back to a single
>  legacy IRQ vector.
>  
>  The typical usage of MSI or MSI-X interrupts is to allocate as many vectors
> @@ -203,7 +203,7 @@ How to tell whether MSI/MSI-X is enabled on a device
>  ----------------------------------------------------
>  
>  Using 'lspci -v' (as root) may show some devices with "MSI", "Message
> -Signalled Interrupts" or "MSI-X" capabilities.  Each of these capabilities
> +Signaled Interrupts" or "MSI-X" capabilities.  Each of these capabilities
>  has an 'Enable' flag which is followed with either "+" (enabled)
>  or "-" (disabled).
>  
> -- 
> 2.7.4
> 

