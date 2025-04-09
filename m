Return-Path: <linux-pci+bounces-25546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A00A82020
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 10:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CE84C5485
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 08:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A60A25D201;
	Wed,  9 Apr 2025 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyIxab97"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3384025D1F1
	for <linux-pci@vger.kernel.org>; Wed,  9 Apr 2025 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744187451; cv=none; b=gPD8HT3CZDB61InpRvSk7G3VWxacMK4ZLIL/ikD1aFqkghG+IOx8EVYsQdc4oiJtGLuzImRdaJYLPGjGWa0J+EgmM5Xmes4WqqMCrMtoVt5MwoTp6D7LYr2o6NhpdMApdYQlu1c0lbWA6WZUqsEfWDdGgfMVWU++VWTPx3r+oU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744187451; c=relaxed/simple;
	bh=Nt8L99Z8ytx6X4EkS6apmyPr6cHk3uAN7Xqv53IQRqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZ4zfejfhA1ecBG8euOFhRMVXFkwT3L0ubh2gd9e8qWSR50ae6ObePfRV3Vxgy3g7/Nb3j6ROF8RIzWh7kLPJpVIBLJsMviHVDD9AOJuHSTgCGDfYCWzBKOQl6hhbW+/dpwG/zoEC/HGVOY39UG9tHVTHY9JuxsLs5QXDrm5/qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyIxab97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABC3C4CEE7;
	Wed,  9 Apr 2025 08:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744187450;
	bh=Nt8L99Z8ytx6X4EkS6apmyPr6cHk3uAN7Xqv53IQRqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TyIxab97LYhRoLtWKwPMnV5grink2bdfUqN1pIVGi6hX1BQ1LObQ2dHlZypmeWzJ5
	 Qykjg/kJ3K+maK1wRX+NDDLz6BnX+Zpb+6qBrMrc9ypKCwu1DXQfTH0VODXsuTShcC
	 cGKQDoFoHcskgv64ZzCwy1CYR7ivQGi+Dmsbe5EYxGY6zUnisSZy2gp6xWQkEupc6a
	 a7U6SE9pNg3dMZM8A/XphF7yXFPcAjZdssF5KYvHCdXOinfTNGCcxyustuKpVZVXlo
	 XRDUbobEgMDSroi1IajFdmwu1tU253/i/mLMa/Ml7YCMEDV5rQYrt0S36jh5SUtL/j
	 sFgC6TkndhwKg==
Date: Wed, 9 Apr 2025 10:30:46 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Remove PCIE_L0S_ENTRY check from
 rockchip_pcie_link_up()
Message-ID: <Z_YwNt6WUuijKTjt@ryzen>
References: <1744180833-68472-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1744180833-68472-1-git-send-email-shawn.lin@rock-chips.com>

On Wed, Apr 09, 2025 at 02:40:33PM +0800, Shawn Lin wrote:
> Two mistakes here:
> 1. 0x11 is L0 not L0S, so the naming is wrong from the very beginning.
> 2. It's totally broken if enabling ASPM as rockchip_pcie_link_up() treat other
> states, for instance, L0S or L1 as link down which is obvioult wrong.
> 
> Remove the check.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index c624b7e..21dc99c 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -44,7 +44,6 @@
>  #define PCIE_LINKUP			(PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
>  #define PCIE_RDLH_LINK_UP_CHGED		BIT(1)
>  #define PCIE_LINK_REQ_RST_NOT_INT	BIT(2)
> -#define PCIE_L0S_ENTRY			0x11
>  #define PCIE_CLIENT_GENERAL_CONTROL	0x0
>  #define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
>  #define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
> @@ -177,8 +176,7 @@ static int rockchip_pcie_link_up(struct dw_pcie *pci)
>  	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
>  	u32 val = rockchip_pcie_get_ltssm(rockchip);
>  
> -	if ((val & PCIE_LINKUP) == PCIE_LINKUP &&
> -	    (val & PCIE_LTSSM_STATUS_MASK) == PCIE_L0S_ENTRY)
> +	if ((val & PCIE_LINKUP) == PCIE_LINKUP)
>  		return 1;
>  
>  	return 0;
> -- 
> 2.7.4
> 

You should probably also add:
Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")


Considering that dw_pcie_link_up() looks like this:
https://github.com/torvalds/linux/blob/v6.15-rc1/drivers/pci/controller/dwc/pcie-designware.c#L714-L725

Why not simply remove the rockchip_pcie_link_up() callback completely?

Is there any advantage of using a rockchip specific way to read link up,
rather than just reading link up via the DWC PCIE_PORT_DEBUG1 register?


Kind regards,
Niklas

