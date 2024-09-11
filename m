Return-Path: <linux-pci+bounces-13039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBD2975518
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 16:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C143B25AE5
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 14:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5E518FDC5;
	Wed, 11 Sep 2024 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIJj4V/n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB537DA79;
	Wed, 11 Sep 2024 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064221; cv=none; b=D5pacA1E4wergKHiJMDypPZ4d0yZOIrwWsKz+g3YUOLjon9EzHIo/YIhgP6niivPsjtZVWBtmGpU/BTu09u5A2mG9ISTOFZ2pbN4s05AKmE+yMmN3L9hRFTtIjrGjOk/2wHiByygERsmPnMmr22yml8gDzvxWBmNhFNlEqR6cvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064221; c=relaxed/simple;
	bh=yjhgEM7kcYa6l2/+x2WzgcnyBOupWlUBMTKZvdp5avc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TuSU3vCE0ZX3IlXCb1BcQmXGRIl44LcZjzUbIdRxU7Z13YeIzJBBSoZYYY38LT/xhgs4KRsSX41njw9bJL8w0nn9r0KZ31Jy7JgxaHLRD48BKt0WOlmRz2jpkvhbfSa+WUzYWFIuwKsUqLIyUYtR6ZSZBRdcMo5bxUHPXEp3AQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIJj4V/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902A4C4CEC0;
	Wed, 11 Sep 2024 14:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726064221;
	bh=yjhgEM7kcYa6l2/+x2WzgcnyBOupWlUBMTKZvdp5avc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iIJj4V/nSbdat7JiCqwJEQ1K5SlkPq9tyWxNtNftGSyXn1U/YGKWqqysXFwVcm50P
	 ZgJEScoMxrMKM5UyvUfNA/qMApGp+PtWOdYA3rFcN3+P33u/e0NXaJGR0Yj2gxeHPD
	 t9yna94IzPaqDpAS6ErbhRpzJop1zwN3odszBLizqlGe38/D554FxujBfHoaNvKHl8
	 QYkdRwfqUasJT13meMgkPdKZgGHosRCy7Dl19WJjQx3K/jVd6/CW1GZi6pht9oY44R
	 5e8EBHidgA8ekjpDgz7Y1NhknXud9HssXkpFdYW4jJrDwMv16fzCAAtxPzKBIQI1D7
	 rp55lH2q1eY/Q==
Date: Wed, 11 Sep 2024 09:16:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, shawnguo@kernel.org,
	s.hauer@pengutronix.de, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: imx6: Fix a "Null pointer dereference" issue
Message-ID: <20240911141658.GA632894@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911125055.58555-1-qianqiang.liu@163.com>

On Wed, Sep 11, 2024 at 08:50:57PM +0800, Qianqiang Liu wrote:
> The "resource_list_first_type" function may return NULL, which
> will make "entry->offset" dereferences a NULL pointer.
> 
> Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 0dbc333adcff..04e90ba4e7d6 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1017,13 +1017,14 @@ static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
>  	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
>  	struct dw_pcie_rp *pp = &pcie->pp;
>  	struct resource_entry *entry;
> -	unsigned int offset;
> +	unsigned int offset = 0;
>  
>  	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
>  		return cpu_addr;
>  
>  	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> -	offset = entry->offset;
> +	if (entry)
> +		offset = entry->offset;
>  
>  	return (cpu_addr - offset);
>  }

I made the edit I proposed here:
https://lore.kernel.org/r/20240911140721.GA630378@bhelgaas

Please double-check it at:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=c2699778e6be

