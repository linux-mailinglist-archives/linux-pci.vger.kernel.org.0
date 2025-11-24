Return-Path: <linux-pci+bounces-41979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9862C8207C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 19:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6788D3A8350
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 18:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FD631691E;
	Mon, 24 Nov 2025 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEd3XJcR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3352C21EB;
	Mon, 24 Nov 2025 18:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007740; cv=none; b=AOYybq+eIwiOellz3hni95oQ1fIIakf4r5UUENIYuhEJboK3p8G8wvlkrm4dIxSvZMtcUWj1ch2/sAsPUfMPVw7XUfi2OiZczUWGKpyINaVnyS0CAJjj4nocdrUbWyAmbI5rGsI5ZnXMxlcx81CQq3uoJPYq1BBuTOj1wakRLck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007740; c=relaxed/simple;
	bh=GhQcWx42J0d0ewB7WVogF7BGD8aTFOdgav+kUNjMAPM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qjRmOACbguWvBioyscAnaTQadAf1B1JLFtT+pPfHY29lOQM8aYtj9DVL8dpHF0t29AOQHr4xbq/dqMl5Tf19pTxItnWbhT4ObJ1ruBrJ6+5pnfYF5bqGJFN2gj22iCkrW0noebtP8P6bdMPAxA8GsZ1Ng3GTFa+lOoAH5mdlCJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEd3XJcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6C9C4CEF1;
	Mon, 24 Nov 2025 18:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764007738;
	bh=GhQcWx42J0d0ewB7WVogF7BGD8aTFOdgav+kUNjMAPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aEd3XJcR7n8AuUrojYsCfxJ8IZxUS8/qCkU28Hu96BCovkBmb6J3Z9oEKsea4Qj+I
	 cwxAfX+QWcrI3wQJ3/p1VAyLBt3ezyakmR1ITcuc1b9cb5WC2Bmul3kDYIsxbl57Pn
	 b1yR2Yh144jWyEfH4SVaCm2xNp0TmJNgwQopp4IjaO0I0AVfHlOdk81BWBuwKLFpEj
	 +PTw1QwjJcJgCX+lJPnaJYMVOEI3RA7mnb/ZfFuN2KcUfFnvgsy+KoRYfr4KoNaVmC
	 xR83NzucXAVQ5PYqSEkIBspYl6jlFomgMiFu3RKy6LZiyYgZIhBtVVqxGt+hb1t+3y
	 jfCx6nFfKtduw==
Date: Mon, 24 Nov 2025 12:08:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Hans Zhang <hans.zhang@cixtech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] PCI: sky1: Fix error codes in
 sky1_pcie_resource_get()
Message-ID: <20251124180857.GA2702217@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSBqp0cglr-Sc8na@stanley.mountain>

On Fri, Nov 21, 2025 at 04:35:35PM +0300, Dan Carpenter wrote:
> Return negative -ENODEV instead of positive ENODEV.
> 
> Fixes: 25b3feb70d64 ("PCI: sky1: Add PCIe host support for CIX Sky1")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Squashed into the commit, thanks!

> ---
>  drivers/pci/controller/cadence/pci-sky1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-sky1.c b/drivers/pci/controller/cadence/pci-sky1.c
> index 99a1f3fae1b3..d8c216dc120d 100644
> --- a/drivers/pci/controller/cadence/pci-sky1.c
> +++ b/drivers/pci/controller/cadence/pci-sky1.c
> @@ -65,7 +65,7 @@ static int sky1_pcie_resource_get(struct platform_device *pdev,
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
>  	if (!res)
> -		return dev_err_probe(dev, ENODEV, "unable to get \"cfg\" resource\n");
> +		return dev_err_probe(dev, -ENODEV, "unable to get \"cfg\" resource\n");
>  	pcie->cfg_res = res;
>  
>  	base = devm_platform_ioremap_resource_byname(pdev, "rcsu_strap");
> @@ -82,7 +82,7 @@ static int sky1_pcie_resource_get(struct platform_device *pdev,
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "msg");
>  	if (!res)
> -		return dev_err_probe(dev, ENODEV, "unable to get \"msg\" resource\n");
> +		return dev_err_probe(dev, -ENODEV, "unable to get \"msg\" resource\n");
>  	pcie->msg_res = res;
>  	pcie->msg_base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(pcie->msg_base)) {
> -- 
> 2.51.0
> 

