Return-Path: <linux-pci+bounces-37990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B609DBD6683
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 23:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E75E4E9481
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 21:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6BC2FA0F6;
	Mon, 13 Oct 2025 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPN1OHRT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643E42DF13A;
	Mon, 13 Oct 2025 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392238; cv=none; b=AUD95xzJFZ2X29xg/Kftiqi7LTbW1Nm93Gir14mM2TiNSrCaM8gm/ds+brQLGHrvD8IoNqXGkb1SV2zClqGsrgWfFPrrgFNGi7Ti+2xSdDC8OcA/Olbaii/YUNiay2MuB8KN/iwNDsIbNoLwZLh/MULqIfZegG5HDKiJ2zSOVYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392238; c=relaxed/simple;
	bh=ymKuPXBsFv/u0TtxiDIqOl7RHihyuM04NYtYM3NNQT4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qcRgzN300qb3UoC3HrU4xPCF+mGNDXfvySn5WaIuc/MOY2oZa42MC5EWdABEnAdwcZKGGayxh/13TSA2Z+ai78M8LC+gRSPfyyrbrqd7xRsaWRo9sTlE6i+xw8FwcCyIhx6wxP+Fn54k6Fi9rYKB3rlxPnsX2ZuFRI2PLJJjSgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPN1OHRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35A4C4CEE7;
	Mon, 13 Oct 2025 21:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760392238;
	bh=ymKuPXBsFv/u0TtxiDIqOl7RHihyuM04NYtYM3NNQT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JPN1OHRTtWDf0nED0mv2+IbTG9zMLmfBJ35p9foN1uFZfUrDBD6ivkKKSUtlSsbxT
	 +RzZsIz5CLLCQexwpwHK16Msm+CiBwBk7owpJNOZZykzMpA/sqGd0fXsbMXBIDvRIh
	 bs0PSU2rDAiLOstXQCcoqaCLXctKOLbjinLvNoooYZ2bZibiz/vtHyt7Fq0puhqt/d
	 ZJDbzQ6umAz4HwqSFMHw2BBchHIV428LFrTd6uwuQgtwv+NDGxkXyaJ9jdui/fpZkA
	 PdojRpu6gCI9X0zP5zw8oEPFoMmOLt7JjwtX0GbPgl7fosPYwczL3/AETk5V9t5kY7
	 XwP/qteC0N/Ng==
Date: Mon, 13 Oct 2025 16:50:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	mani@kernel.org, robh@kernel.org, sashal@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pci: cadence-ep: Fix incorrect MSI capability ID
Message-ID: <20251013215036.GA866714@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010144307.12979-1-18255117159@163.com>

On Fri, Oct 10, 2025 at 10:43:07PM +0800, Hans Zhang wrote:
> In a previous change, the MSIX capability ID (PCI_CAP_ID_MSIX)
> was mistakenly used when trying to locate the MSI capability in
> cdns_pcie_ep_get_msi(). This is incorrect as the function handles
> MSI functionality, not MSIX.
> 
> Fix this by replacing PCI_CAP_ID_MSIX with the correct MSI capability
> ID(PCI_CAP_ID_MSI) when calling cdns_pcie_find_capability(). This
> ensures the MSI capability is properly located, allowing MSI functionality
> to work asintended.
> 
> Fixes: 907912c1daa7 ("PCI: cadence: Use cdns_pcie_find_*capability() to avoid hardcoding offsets")
> Reported-by: Sasha Levin <sashal@kernel.org>
> Closes: https://lore.kernel.org/r/aOfMk9BW8BH2P30V@laps/
> Signed-off-by: Hans Zhang <18255117159@163.com>

Applied to pci/for-linus for v6.18, thanks!

> ---
> Dear Maintainer,
> 
> Since the previous patch mistakenly changed the MSI ID to MSIX ID,
> a patch is submitted here to fix it. Thank you very much, Sasha, for
> pointing it out.
> 
> Best regards,
> Hans
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index 1eac012a8226..c0e1194a936b 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -255,7 +255,7 @@ static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
>  	u16 flags, mme;
>  	u8 cap;
>  
> -	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSIX);
> +	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSI);
>  	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
>  
>  	/* Validate that the MSI feature is actually enabled. */
> -- 
> 2.34.1
> 

