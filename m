Return-Path: <linux-pci+bounces-13874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D56F991228
	for <lists+linux-pci@lfdr.de>; Sat,  5 Oct 2024 00:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06327283DC7
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 22:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC69D1AE013;
	Fri,  4 Oct 2024 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/ev4RRG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86B9231CAD
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728079852; cv=none; b=X932Shz079QA+caoKczXaOCAe0zuwPkqjkrwQ0wCqyRbTbDVe9S6zZnwMmFlUVglMH/+MaaQ5hBH8oWb6Wre0xCL9bvaejTxKYby1iN8XAyJobY/Qv6OMUdtxPhQF3mvOWidBpihS/vTTacAFjHK3KdbmE2o12grCR7AjAp0eKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728079852; c=relaxed/simple;
	bh=vla3ElWORNB+eVvPsanT9aysLmQU6LQjYQPkJXPXtss=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bH5iPLf3kjDsVyIndoQP94Xyy+YSws0+fmAql7DrcnvzpNzTqBITC4usR9XtxuR2262r1dAX9UBqflDqVcn9/fI4glUMFcYtjzhCQtfEFm2BhWj2wSV8Yj+I+iJqEN9O0bqJvuNcxK9HcAw3cmuiTKABBjFokKITD2udfCMrNoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/ev4RRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFB2C4CEC6;
	Fri,  4 Oct 2024 22:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728079852;
	bh=vla3ElWORNB+eVvPsanT9aysLmQU6LQjYQPkJXPXtss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=X/ev4RRGrakhXNQ8PwhkiyRs28phP+f4Wt/P6y79d0XZp920diOuv9Fr4rXXgNZPG
	 zekFzqgXrUmwiGKd9+ZP7ceQc15rxt5jm45yoIV7cm2GZEZEEe8Vcg0eOz/n0ru2kN
	 AOmlmq6Golkqi1VuES44itbIRMCR6DiL/vd4nCUiINCG6SHz50lLiDNEDn3rfKTbEE
	 vVOP1WpijpBb0zJLcnMiDDr00g+2qtrRrOfq4KDpsX371WbiSydjUPPjKsRmCI3HgL
	 DVWSU6iNhPwy4OJNK2jbms33H2WHULlG/rK3A4sdYW32d/EupNPbwaIiER7vSwOn0l
	 lIZMYS6BBPwXA==
Date: Fri, 4 Oct 2024 17:10:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH] PCI: dwc: endpoint: Clear outbound address on unmap
Message-ID: <20241004221050.GA364134@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004141000.5080-1-dlemoal@kernel.org>

On Fri, Oct 04, 2024 at 11:10:00PM +0900, Damien Le Moal wrote:
> In addition to clearing the atu index bit in ob_window_map, also clear
> the address mapped (outbound_addr array) in dw_pcie_ep_unmap_addr(), to
> make sure that dw_pcie_find_index() does not endup matching again an ATU
> index that was already unmapped.

s/atu/ATU/ to match other usage
s/endup matching again/match/

No need to repost for this, whoever applies it can tweak it.

> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 501e527c188e..7f4c082a2d90 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -294,6 +294,7 @@ static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	if (ret < 0)
>  		return;
>  
> +	ep->outbound_addr[atu_index] = 0;
>  	dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_OB, atu_index);
>  	clear_bit(atu_index, ep->ob_window_map);
>  }
> -- 
> 2.46.2
> 

