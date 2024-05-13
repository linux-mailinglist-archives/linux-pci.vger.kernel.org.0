Return-Path: <linux-pci+bounces-7430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8468C4680
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 19:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA1F0B21410
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 17:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA67249F9;
	Mon, 13 May 2024 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OO2MpxNM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307F757C8D;
	Mon, 13 May 2024 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715622694; cv=none; b=Wqk6K53/M4FtNgpwdFmE+Lqx7nUZucdXw1pbMfR1IYHwn3QCsag9dV3xlm04ehN2PQria9ZeMg6zk81M0px4hJlbUxcoWMMXJz1r7UjpXq4N7hhYDQw6veZBmxTme3N12F+kb/kKDgpskapQ+BYJVdPrOynOBNN/ltFua/rAj74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715622694; c=relaxed/simple;
	bh=DA+UD3fsPCm2aGviXf6VM5/MCw3pyuso45xWeS6YsPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fjSDVfiR1Re41+Rzdh1hkwp7Ap8WEzTojKcCWgfRgtwiCdcyQVSSUO/2NRc+JSVzzXTCNqD7fjMxsfh+ERZzlacaOVb+YIj7ZiFnqXlLtAGso8AfQy3aYgyXsbhqT1dbjSJTLc5/Rcu1SWrayMxjfNUjb43YxnPANdOeC4r0+oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OO2MpxNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F072C113CC;
	Mon, 13 May 2024 17:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715622693;
	bh=DA+UD3fsPCm2aGviXf6VM5/MCw3pyuso45xWeS6YsPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OO2MpxNMj1H+5IPfIKaI+0XY2q/eDAH6nd5DVELGDFmMSsdww3S0gviR2LYgG4+55
	 DS/C82prJmvyciUR3FtcWjcQcZ0AFsq+cz/hgzCxsc7hysyZrTBa+LA/6BIYku9Tq0
	 lXnVs/piTxPAFFh0QiFdLLtMiAxOhWK+6J04cOcFpyHYkChNw0Ow/IUCn9ElJHV6gp
	 rXLqYcDR4WKa72sI8dmfu3P7SqfMCAe6YzslsnyXlRGmQraPjKEWgeNGTvzFgirb11
	 HdzL7v9Zo3P+bVoUD+mrSyit29r7xxSehPxvi524Ya+R6bOfP+uxjSNBLtRXr2qCp3
	 viZ+c5otVPfiA==
Date: Mon, 13 May 2024 12:51:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ajit Khaparde <ajit.khaparde@broadcom.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com, michael.chan@broadcom.com,
	kuba@kernel.org, davem@davemloft.net,
	Andy Gospodarek <gospo@broadcom.com>
Subject: Re: [PATCH] pci: Add ACS quirk for Broadcom BCM5760X NIC
Message-ID: <20240513175131.GA1991153@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510204228.73435-1-ajit.khaparde@broadcom.com>

On Fri, May 10, 2024 at 01:42:28PM -0700, Ajit Khaparde wrote:
> The Broadcom BCM5760X NIC may be a multi-function device.
> While it does not advertise an ACS capability, peer-to-peer
> transactions are not possible between the individual functions.
> So it is ok to treat them as fully isolated.
> 
> Add an ACS quirk for this device so the functions can be in independent
> IOMMU groups and attached individually to userspace applications using
> VFIO.
> 
> Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Andy Gospodarek <gospo@broadcom.com>

Looks like this was applied by Krzysztof to pci/acs for v6.10.

I'm hoping Broadcom is still working on using the standard ACS so we
don't have to add quirks forever:

https://lore.kernel.org/all/CACKFLinvohm+jRupNZAV=G+OHg1buXvLDrs0yGgPY3o6NB8biA@mail.gmail.com/#t

> ---
>  drivers/pci/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index eff7f5df08e2..3d8aa3f709e2 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5099,6 +5099,10 @@ static const struct pci_dev_acs_enabled {
>  	{ PCI_VENDOR_ID_BROADCOM, 0x1750, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_BROADCOM, 0x1751, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_BROADCOM, 0x1752, pci_quirk_mf_endpoint_acs },
> +	{ PCI_VENDOR_ID_BROADCOM, 0x1760, pci_quirk_mf_endpoint_acs },
> +	{ PCI_VENDOR_ID_BROADCOM, 0x1761, pci_quirk_mf_endpoint_acs },
> +	{ PCI_VENDOR_ID_BROADCOM, 0x1762, pci_quirk_mf_endpoint_acs },
> +	{ PCI_VENDOR_ID_BROADCOM, 0x1763, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_BROADCOM, 0xD714, pci_quirk_brcm_acs },
>  	/* Amazon Annapurna Labs */
>  	{ PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031, pci_quirk_al_acs },
> -- 
> 2.39.2 (Apple Git-143)
> 



