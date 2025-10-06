Return-Path: <linux-pci+bounces-37619-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3E2BBE9B8
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 18:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1244634A03C
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 16:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42352D94B3;
	Mon,  6 Oct 2025 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpUOsYsw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8557D2D73A7;
	Mon,  6 Oct 2025 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767289; cv=none; b=QpKIzk+Y0nTKtI9IruXjk2N1wj0FSnHNItNSHisSj/Y+Um165mKNKbnQYk7kmD+pXBnly5gw5yDyCq8JPeFA9ecr3ueFvbFVLXwe8Ejcruw5XhPvPrygEwcI15VHPiUb/AH3rAiurjpcOcKSx3UYEqcfF20+EoYaJqYLp8Mq04U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767289; c=relaxed/simple;
	bh=94oJ9caDdvG59xpvIjfSBv9UCE7Qfj6W+KBmHijwk+w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZhXV4kNMIIUD+yp0CAxYE/R/dVAGG5ltxitQAA7ryyngDUuubFsDtahkb17pxd8pU4pkuMYaHTwz0uy9kwZCyBmtfPRsAE5t/dysEMeQH7L/E+ORsNUE9y8ptOqk87bSpN9YTyVcW/jsMGdw+aJr9nXUEnLEqpKhXKj74kaFHXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpUOsYsw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0025C4CEF5;
	Mon,  6 Oct 2025 16:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759767289;
	bh=94oJ9caDdvG59xpvIjfSBv9UCE7Qfj6W+KBmHijwk+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MpUOsYswLerIqfAAY58/P2aoL+Ggn3eBaT/bQoiNgTM22caB9MDJiAxYOtiUyNBKZ
	 MJzwdjVNVThhasekah8wteKl7FnB2pwYWUUuoWxALK2hfe0bK9Xs3uCgwI93egSMcF
	 G/3YCozmcjdk0b/lGOah6j7i9HqhYMX/Qzk20yT78CrGnMqQiaC15fILOxlUWVMhFX
	 jMS3X21BqO8s3VN2JkP8YCqpdpK6Mm2bUNLgZkkZfcGZHEIE24qgVN1E3jCh115qcz
	 GwZOOn/0LMmHhdUV1d9uUUPix5NFanpfiAnyg6Uom0grsLcXLiWD4MLzk0+sM3RFoW
	 bZ+dA+XB6VppQ==
Date: Mon, 6 Oct 2025 11:14:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Victor Paul <vipoll@mainlining.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lukas Wunner <lukas@wunner.de>,
	Greg KH <gregkh@linuxfoundation.org>,
	Daniel Martin <dmanlfc@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: probe: fix typo: CONFIG_PCI_PWRCTRL ->
 CONFIG_PCI_PWRCTL
Message-ID: <20251006161447.GA521686@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006143714.18868-1-vipoll@mainlining.org>

On Mon, Oct 06, 2025 at 06:37:14PM +0400, Victor Paul wrote:
> The commit
> 	8c493cc91f3a ("PCI/pwrctrl: Create pwrctrl devices only when CONFIG_PCI_PWRCTRL is enabled")
> introduced a typo, it uses CONFIG_PCI_PWRCTRL while the correct symbol
> is CONFIG_PCI_PWRCTL. As reported by Daniel Martin, it causes device
> initialization failures on some arm boards.
> I encountered it on sm8250-xiaomi-pipa after rebasing from v6.15.8
> to v6.15.11, with the following error:
> [    6.035321] pcieport 0000:00:00.0: Failed to create device link (0x180) with supplier qca6390-pmu for /soc@0/pcie@1c00000/pcie@0/wifi@0
> 
> Fix the typo to use the correct CONFIG_PCI_PWRCTL symbol.
> 
> Fixes: 8c493cc91f3a ("PCI/pwrctrl: Create pwrctrl devices only when CONFIG_PCI_PWRCTRL is enabled")
> Cc: stable@vger.kernel.org
> Reported-by: Daniel Martin <dmanlfc@gmail.com>
> Closes: https://lore.kernel.org/linux-pci/2025081053-expectant-observant-6268@gregkh/
> Signed-off-by: Victor Paul <vipoll@mainlining.org>

Might this be a stale .config file?

I think 13bbf6a5f065 ("PCI/pwrctrl: Rename pwrctrl Kconfig symbols and
slot module") should have resolved this. 

In the current upstream tree (fd94619c4336 ("Merge tag 'zonefs-6.18-rc1'
of git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs"),
git grep "\<CONFIG_PCI_PWRCTL\>" finds nothing at all.

> ---
>  drivers/pci/probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 19010c382864..7e97e33b3fb5 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2508,7 +2508,7 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>  }
>  EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
>  
> -#if IS_ENABLED(CONFIG_PCI_PWRCTRL)
> +#if IS_ENABLED(CONFIG_PCI_PWRCTL)
>  static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
>  {
>  	struct pci_host_bridge *host = pci_find_host_bridge(bus);
> -- 
> 2.51.0
> 

