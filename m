Return-Path: <linux-pci+bounces-20006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E506A14170
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 19:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE70188C30A
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 18:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC4F22BADC;
	Thu, 16 Jan 2025 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLBzzTWy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F17A14EC4E;
	Thu, 16 Jan 2025 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737050795; cv=none; b=QnnS9pRIH8Wfnfwmwhg1f7HlANO1FSb2FylVejpLMD30y4ah4JW596W1ssBBpG1h/bXPxImV8Dj2uUulzw2Xqjue3E+lCOdxvfZoyzAlATsYTW+/WFO2BNhTVf/o+vvUvVHlPXA6OyVknM0LskjF8zRKaqQBkd9HF7qYjiLiRo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737050795; c=relaxed/simple;
	bh=t//JoD3DeCX6eJrnKCnZlRXXU42HxUUxEKvBNxNioOs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RGyrEt4vXkgdsWaYjN49z4seFCDD6mkRs2ZCkSsjeu9fdHrXMeuaBykk0oTTG0VG8b8B06vIYEfevYNzmL5qafFj8wUdwyCusyekYNDcp1v7GxmiUdAI9KdBGUqzHGQ8i1LUcIh8UtoAPejio4YDIucY025cPlZ8tdNxLxttAvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLBzzTWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A43C4CED6;
	Thu, 16 Jan 2025 18:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737050794;
	bh=t//JoD3DeCX6eJrnKCnZlRXXU42HxUUxEKvBNxNioOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GLBzzTWy5hgyyuw2UCkRWn2pJfGjl2NdBoEWyDE4iJm1l2quonSEs5+tjlBgxFDhQ
	 oXiGxxZJ5RT+9wSVuTjahxRsnAHODfRI+uKS0J8O6G/rtMGaDGagFsEWMhwpEoCseQ
	 HklJiyxkBnZNs/2QkbldVCXMwqLmDvVrRh3VM0FgoXP3XX01+a0VzxFW8E8HxijI0y
	 zIqDlEGSzYqCjool4VqaTMaeakEcBekghO6pUVsLnPsLxi5JXWhisJ5CDqB1BGr6FB
	 LWRgCt4UPUGMyGLDgnS8Mcd+9HQ2xijRgOic8ix2YtfPsUWUYxjv0Fswtf2mEin+hd
	 YNUYRKZz3an1g==
Date: Thu, 16 Jan 2025 12:06:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] PCI: Fix ternary operator that never returns 0
Message-ID: <20250116180632.GA594177@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116172019.88116-1-colin.i.king@gmail.com>

On Thu, Jan 16, 2025 at 05:20:19PM +0000, Colin Ian King wrote:
> The left hand size of the ? operator is always true because of the addition
> of PCIE_STD_NUM_TLP_HEADERLOG and so dev->eetlp_prefix_max is always being
> returned and the 0 is never returned (dead code). Fix this by adding the
> required parentheses around the ternary operator.
> 
> Fixes: 00048c2d5f11 ("PCI: Add TLP Prefix reading to pcie_read_tlp_log()")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Squashed into the 00048c2d5f11 ("PCI: Add TLP Prefix reading to
pcie_read_tlp_log()") commit, headed for v6.14, thanks!

> ---
>  drivers/pci/pcie/tlp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
> index 9b9e348fb1a0..0860b5da837f 100644
> --- a/drivers/pci/pcie/tlp.c
> +++ b/drivers/pci/pcie/tlp.c
> @@ -22,8 +22,8 @@
>  unsigned int aer_tlp_log_len(struct pci_dev *dev, u32 aercc)
>  {
>  	return PCIE_STD_NUM_TLP_HEADERLOG +
> -	       (aercc & PCI_ERR_CAP_PREFIX_LOG_PRESENT) ?
> -	       dev->eetlp_prefix_max : 0;
> +	       ((aercc & PCI_ERR_CAP_PREFIX_LOG_PRESENT) ?
> +		dev->eetlp_prefix_max : 0);
>  }
>  
>  #ifdef CONFIG_PCIE_DPC
> -- 
> 2.47.1
> 

