Return-Path: <linux-pci+bounces-26150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A10A92C3E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 22:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E2E1B661D8
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 20:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249D01D6AA;
	Thu, 17 Apr 2025 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhnyQkmf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3461C6B4;
	Thu, 17 Apr 2025 20:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744921570; cv=none; b=DgNUu14A/13xNRcCGTlWPKL01roo91Svh1IYG4x7++PMLwqYRCQlgX689x1ecIMxqF5djVNjai1aG/O3dLbHB+mhnek6jDnCHlLe8P76KFyKMXNXLNco9IaB3MtltFVSr7CYbV78uRnnoUdqWVDjIkJ7EUDxBB/jzqTGJOIpXCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744921570; c=relaxed/simple;
	bh=c6K+IDOm2UmtT0YyTQrVHZ1Z6NC5GdO2MJHTb7XTcsE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VvuYFX/3hZaZ0hEnlA5mJWPsKmrgNEuV6CQQr2NZ28E8xoSpDrHcaGVHCbiwGoGpg+MdzPURUcRQFuxIKBEpcgysZBGd7NC2sVyrLktYMnEpaiYlZ4a+GiQ8FOxBu3uAHl9swQmqLuf2fHKOaUg80wvThAXtxMXZ2v8XXYvp2GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhnyQkmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E9AC4CEE4;
	Thu, 17 Apr 2025 20:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744921569;
	bh=c6K+IDOm2UmtT0YyTQrVHZ1Z6NC5GdO2MJHTb7XTcsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rhnyQkmf9B0RLV1c8/ro72CPxAwk9Yx0IxmG3XPVfnnr3gHrtHmGh/PeU0ywxup61
	 lExzMrUAivK5rUUMUkneStI9MFSeLTuxpDGT4S8HWY4acXorQEcRpAX8H6GozJZ++j
	 G+qrPJ6x4wT0yaO+RyMDllBhF8qdgzu4ernGnayc0200J/chqs2dleUAc0MnAGdis7
	 68O/zHNs4bRtqHgwqQR1s2KJCdNSgAix8Wjkl3e14aNqcb03f7N2bQ7A/PaXJBHeA7
	 750YXziDDxCygxKxiT9NccNhoDGDCpEMO6nvE2SYSsF9o99r8lIiHo3MeA/Z+qR/8G
	 2C91akAGxXMAw==
Date: Thu, 17 Apr 2025 15:26:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: bhelgaas@google.com, mika.westerberg@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, lukas@wunner.de,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	alistair.francis@wdc.com, wilfred.mallawa@wdc.com,
	dlemoal@kernel.org, cassel@kernel.org
Subject: Re: [PATCH v2] PCI: fix the printed delay amount in info print
Message-ID: <20250417202607.GA126859@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414001505.21243-2-wilfred.opensource@gmail.com>

On Mon, Apr 14, 2025 at 10:15:06AM +1000, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> Print the delay amount that pcie_wait_for_link_delay() is invoked with
> instead of the hardcoded 1000ms value in the debug info print.
> 
> Fixes: 7b3ba09febf4 ("PCI/PM: Shorten pci_bridge_wait_for_secondary_bus() wait time for slow links")
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Applied to pci/enumeration for v6.16, thanks!

> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..8139b70cafa9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4935,7 +4935,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  		delay);
>  	if (!pcie_wait_for_link_delay(dev, true, delay)) {
>  		/* Did not train, no need to wait any further */
> -		pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
> +		pci_info(dev, "Data Link Layer Link Active not set in %d msec\n", delay);
>  		return -ENOTTY;
>  	}
>  
> -- 
> 2.49.0
> 

