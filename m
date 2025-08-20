Return-Path: <linux-pci+bounces-34392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14128B2E1A8
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 18:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88DA16D3F9
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 15:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A1532276C;
	Wed, 20 Aug 2025 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prO3xTMJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72C4322764;
	Wed, 20 Aug 2025 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755705469; cv=none; b=T3VX1TYeDb74EHmb+9am7qdHOX0uVNDYBUDHiTOBgS5+5gHimxUxJzN/HhQZCxsO+mKJC4hxzoIZfz1gydsr0SEsvflVEgWfrXCFBMPdzwSVzvrlQ30AAjTmI/GKSi9bjgA+DY14jMzGDbTGHO7+5pTqhPxaei3awbcLes2h8+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755705469; c=relaxed/simple;
	bh=p8L/MSQcq7yF/LI2ZVnymQ3FOXY3S7Zhq5jrLFURDYw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YGD7zCd0efpoYqzsN/gkgDCLNKPg/IVTDhNuyG28OA7spgyCkB9q4qc6yMi88S4bQU+wtp3MZdRHn82Ldv4qdcoQpFhYzQtsx0rNnLchfRozE381T6zvuvw62BlbW0jzoFVKCdd/ICfVKzbwFJhbD5xBD2lf/Q2VUJ3su4gE1WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prO3xTMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFB2C4CEE7;
	Wed, 20 Aug 2025 15:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755705469;
	bh=p8L/MSQcq7yF/LI2ZVnymQ3FOXY3S7Zhq5jrLFURDYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=prO3xTMJrHASsyJv+GWfgfUF8IJH4vY+Ktdyp7frUwqvzrATsej91VY+mKrqCcoJA
	 GiPEWxx8R89u8WU2jMluM3L5BIv22jeZXxfQ+e6bmHygxNY5ceTjttjfwrVtLV3RJT
	 cjL1eIIhPs8N1UgqRV+r8WgHPsjvt7O41ym2gIc7sen7c7nu1JVrfojVsQG3pHBmdU
	 98sIb25Tv+DSrDFAtjrW1kmyTjHDopKfApgGvHruNvasnO6A7IJ0MiEmBnSPqXzL4y
	 CYTtpVV0S+NSjxHrEVCQdXwVTP685vVL/6QDKfjgiwa/xxF2pucvZ3mUD0Pk30DG6e
	 enrARmDXpglYw==
Date: Wed, 20 Aug 2025 10:57:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] PCI: dwc: Invoke post_init in
 dw_pcie_resume_noirq()
Message-ID: <20250820155747.GA628315@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820081048.2279057-2-hongxing.zhu@nxp.com>

On Wed, Aug 20, 2025 at 04:10:47PM +0800, Richard Zhu wrote:
> If the ops has post_init callback, invoke it in dw_pcie_resume_noirq().

Can you briefly explain why .post_init() is required here?  Bread
crumbs about the purpose of .post_init() will help other driver
writers (and me!)

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 952f8594b5012..f24f4cd5c278f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1079,6 +1079,9 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
>  	if (ret)
>  		return ret;
>  
> +	if (pci->pp.ops->post_init)
> +		pci->pp.ops->post_init(&pci->pp);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
> -- 
> 2.37.1
> 

