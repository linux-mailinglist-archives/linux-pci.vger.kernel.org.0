Return-Path: <linux-pci+bounces-21899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E82A3DA47
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 13:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50F5189FB38
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 12:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CB41F3FD7;
	Thu, 20 Feb 2025 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/5Iyl2A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEA1286298;
	Thu, 20 Feb 2025 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740055375; cv=none; b=uBtK8YHHCZKAYAHMx70vod/fYUplRQzPKh1Sp9N+8hb4f6D9y4Qy4s/hmoBtV+Ejfs6FGlDiucx8/OHUY/SESx+B/+icm5ywYaZ1p5QXSyxFOIc4H0pop2iEvLR4mC5diAmFUU0a0QANGNkN2TEgsHG0puI8G1dCXYEOgC7ChZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740055375; c=relaxed/simple;
	bh=RVZ/swUs318iSPWUVj9+byY1sTALGlfS4yGzHO5zGEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFRBLrx1z/q8OizLY/eG6eGBmrAlfywliUzcGdwQ9jEIZkTMkdRaMHQWUnkcRvAvmZEsyEXvR1KkdUqYqDmP153s5M1fDxuk21b3hQ8Qo7RYlMtlHWZvZMTHcNfT4hRECXeAXWA6SPTGkHqw2gsRab2rmTfs23hiv8jZMHWrNk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/5Iyl2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A97C4CED6;
	Thu, 20 Feb 2025 12:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740055374;
	bh=RVZ/swUs318iSPWUVj9+byY1sTALGlfS4yGzHO5zGEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W/5Iyl2A8LrY2JUM0IzIQPtoJ4yKX40TTq/3WN9psph4YCrW5Q3J8Eam2+D7L7MwZ
	 PnXhOanXHE2SEmQ/auErLnmPpXIJH1Gnl01cVp2IOSUdrioRNlb26J56L2VHQy8zVJ
	 xsWy6p6hh9tqBqRNOc7sGl7BESkIIn+T8U8NGC4kGmXoZP7T8c/aZWmQ2wAngH7tsq
	 TfQNZC5abXf3hI45pxg3Yvuk5cJ2Bv4KXTFwAqWNj15zt3agjKqxWXkGV20GIXw1gK
	 Ta3Hjp1PFsa6OITZ6+ZcL7rvi/Lw3oQbRFYQgFWMSfI+MIhMcClUGKzZKGu3XRTNPf
	 Wdga0gXIWjfTA==
Date: Thu, 20 Feb 2025 13:42:51 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Cc: helgaas@kernel.org, bhelgaas@google.com, christian.koenig@amd.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Update Resizable BAR Capability Register fields
Message-ID: <Z7cjS7iuX655O7b3@ryzen>
References: <20250219183424.GA226683@bhelgaas>
 <20250220013034.318848-1-daizhiyuan@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220013034.318848-1-daizhiyuan@phytium.com.cn>

On Thu, Feb 20, 2025 at 09:30:34AM +0800, Zhiyuan Dai wrote:
> PCI Express Base Spec r6.0 defines BAR size up to 8 EB (2^63 bytes),
> but supporting anything bigger than 128TB requires changes to pci_rebar_get_possible_sizes()
> to read the additional Capability bits from the Control register.
> 
> If 8EB support is required, callers will need to be updated to handle u64 instead of u32.
> For now, support is limited to 128TB, and support for sizes greater than 128TB can be
> deferred to a later time.

Did you run ./scripts/checkpatch.pl on this?

I'm guessing that you will see:
Prefer a maximum 75 chars per line (possible unwrapped commit description?)

With that fixed:
Reviewed-by: Niklas Cassel <cassel@kernel.org>

> 
> Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
> ---
>  drivers/pci/pci.c             | 4 ++--
>  include/uapi/linux/pci_regs.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 661f98c6c63a..77b9ceefb4e1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3752,7 +3752,7 @@ static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
>   * @bar: BAR to query
>   *
>   * Get the possible sizes of a resizable BAR as bitmask defined in the spec
> - * (bit 0=1MB, bit 19=512GB). Returns 0 if BAR isn't resizable.
> + * (bit 0=1MB, bit 31=128TB). Returns 0 if BAR isn't resizable.
>   */
>  u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
>  {
> @@ -3800,7 +3800,7 @@ int pci_rebar_get_current_size(struct pci_dev *pdev, int bar)
>   * pci_rebar_set_size - set a new size for a BAR
>   * @pdev: PCI device
>   * @bar: BAR to set size to
> - * @size: new size as defined in the spec (0=1MB, 19=512GB)
> + * @size: new size as defined in the spec (0=1MB, 31=128TB)
>   *
>   * Set the new size of a BAR as defined in the spec.
>   * Returns zero if resizing was successful, error code otherwise.
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 1601c7ed5fab..ce99d4f34ce5 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1013,7 +1013,7 @@
>  
>  /* Resizable BARs */
>  #define PCI_REBAR_CAP		4	/* capability register */
> -#define  PCI_REBAR_CAP_SIZES		0x00FFFFF0  /* supported BAR sizes */
> +#define  PCI_REBAR_CAP_SIZES		0xFFFFFFF0  /* supported BAR sizes */
>  #define PCI_REBAR_CTRL		8	/* control register */
>  #define  PCI_REBAR_CTRL_BAR_IDX		0x00000007  /* BAR index */
>  #define  PCI_REBAR_CTRL_NBAR_MASK	0x000000E0  /* # of resizable BARs */
> -- 
> 2.43.0
> 

