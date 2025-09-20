Return-Path: <linux-pci+bounces-36555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DC7B8C039
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 07:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9623C7BA17F
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 05:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D4322069A;
	Sat, 20 Sep 2025 05:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCqcihvz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3D734BA38;
	Sat, 20 Sep 2025 05:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758347910; cv=none; b=fBY6o6wVwuRBEGy8/XPm7gVtpX6ATmdQ60573x3eCRjJAlE5OteM/kqv1DCT/TjgnDSKdQAZaLnjjxZWd0qe9Pjyt7rhXIWdefbfOOgVJydYDKcCAPjSVT/ipONmIDubKy4/T8ni9IK4lzpSNPvFQAH6NyYzXyOlkHYhneioU5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758347910; c=relaxed/simple;
	bh=LgoGjH1XdA48//RXYVqBWOJOuvKHUowW2mhgoXCVrHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJoaWH/3LEEbyA7Ry44sPSLWaA6s2n+CQrghsos/zIs7gEC1Jq1PBid891+DD2LG3MBrdtj8xxjObAENUovT7L8GkxeNJCi5DyeVEA5itPOOaKD36Eij3JEOCfqwKhaCjADq+jp/glSBx++pS4LeqJJD/mqdsMQEy9XfwxLKoAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCqcihvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779D2C4CEEB;
	Sat, 20 Sep 2025 05:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758347909;
	bh=LgoGjH1XdA48//RXYVqBWOJOuvKHUowW2mhgoXCVrHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FCqcihvz61B5+wy2FpVXUwtjvMzvln8X6FRMQOD/j9FdLd378Qf5zX49TiZ2SUL9s
	 JJ/7kr5F5pVk6Up+CIq+oznzJJC7ne7xgUjGGncNYuRzpae0a/jouzrxEY29SifkR8
	 ynFtNFqPLGBRTQHhtTUMWTs1Obkx0YYxdmPB2nW8UC5TjzLS8uBtl6l+0J9QCl+mGy
	 XwoxvUmgVkiaq0poYdOyebqmfVpdSImmejR7DuQE3roADaEt805Y/I9gRwxrsBNSAV
	 lWbdqGtJiTralJxpLuFRA7Tum6vZjGOm7faz8C8axm6XvxV01rJ0RWZMTcrEhB1NYk
	 M2IcNU+vx+c4w==
Date: Sat, 20 Sep 2025 11:28:20 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/6] PCI: dwc: Remove the L1SS check before putting
 the link into L2
Message-ID: <b44numhx2wnelicynz36b3wdqrkudchn6l2s2jjmg6iecjk6ae@uo535zip3vq3>
References: <20250902080151.3748965-1-hongxing.zhu@nxp.com>
 <20250902080151.3748965-2-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250902080151.3748965-2-hongxing.zhu@nxp.com>

On Tue, Sep 02, 2025 at 04:01:46PM +0800, Richard Zhu wrote:
> Since this L1SS check is just an encapsulation problem, and the ASPM
> shouldn't leak out here. Remove the L1SS check during L2 entry.
> 

Sorry, I couldnt' decipher this statement. Could you please elaborate?

- Mani

> Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 952f8594b501..9d46d1f0334b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1005,17 +1005,9 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
>  
>  int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  {
> -	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  	u32 val;
>  	int ret;
>  
> -	/*
> -	 * If L1SS is supported, then do not put the link into L2 as some
> -	 * devices such as NVMe expect low resume latency.
> -	 */
> -	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
> -		return 0;
> -
>  	if (pci->pp.ops->pme_turn_off) {
>  		pci->pp.ops->pme_turn_off(&pci->pp);
>  	} else {
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

