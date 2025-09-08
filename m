Return-Path: <linux-pci+bounces-35652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DF0B489D3
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 12:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0A9341F40
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 10:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3657B29B22F;
	Mon,  8 Sep 2025 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUjCb4rW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E14C281375;
	Mon,  8 Sep 2025 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326574; cv=none; b=FyvFRNkd4byiiT41z53cgpBSrRTLwvBvypuF/F4lduhX03bEfiNJPbaX1fB2SctVpoQr7HfFJYCE6ErYYajHMJlrPbAPKPz2MfHQtz2WIUn9uyZCSfbfJ6ATzlCjqz+dvEwQ+h6TzAgft1r80d2e/BK1oLeLgf1hTPsbSXR7LVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326574; c=relaxed/simple;
	bh=5DFonyNsZnbO+w46KiqgO+HRV9ffXCJz7BHFXEip3Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYtGMxsvWP42KomWYBpWLvLWvD9cqkVfbTAVYhksLbaXBVw4WthH9WJhTlC3NMzAQbgopMqk71FS+Sx+YPxRoGClQDOOdx9vNNfoqtBEhNZGo7UmeuFkCv5EC5+4TBlaODnymt38vjCqXkKlcoIpIKkzW4gY8Qin7aU0B+E8Ph8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUjCb4rW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED5EC4CEF9;
	Mon,  8 Sep 2025 10:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757326572;
	bh=5DFonyNsZnbO+w46KiqgO+HRV9ffXCJz7BHFXEip3Mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eUjCb4rWvjaImzId0vGs71hkor/+yJuySYeFh48VIWa6oBD1QvNZBd2MULAFawYve
	 O6lXUidasKRC7XB32hPCjZKeHs6lZGU9cNTTKdDThLCpLnjQVM8k8wW2+DtdV80erq
	 3KgfI8FDjbf8pE02+1tcRDfyhQPExFJ6dWkTpgSqma/pG9tMv+vh4EOyZPA+4J0Mhj
	 BXXhwlS44Oj7Y3d6HV50R4xpaxHsO0LJuJhmYhmSNPJZi0UCkLhZFgP0W//jmUHQz+
	 2cb3RY3jMMRgBdkMaPZ5h/zE9GChCQGxT0vzn2zM4iAj+DAaw40q6U1F0Xq8UViPLo
	 Vf9+lUbGFwHHQ==
Date: Mon, 8 Sep 2025 15:46:05 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: daire.mcnamara@microchip.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, bhelgaas@google.com, robh@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: plda: Remove the use of dev_err_probe()
Message-ID: <pxvdomiyvmor6eix4y733izqey763ygebtvzopf6fwppda4xm2@34c3afoxpipl>
References: <20250820085200.395578-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250820085200.395578-1-zhao.xichao@vivo.com>

On Wed, Aug 20, 2025 at 04:52:00PM GMT, Xichao Zhao wrote:
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Applied to pci/controller/plda!

- Mani

> ---
>  drivers/pci/controller/plda/pcie-plda-host.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
> index 8e2db2e5b64b..3c2f68383010 100644
> --- a/drivers/pci/controller/plda/pcie-plda-host.c
> +++ b/drivers/pci/controller/plda/pcie-plda-host.c
> @@ -599,8 +599,7 @@ int plda_pcie_host_init(struct plda_pcie_rp *port, struct pci_ops *ops,
>  
>  	bridge = devm_pci_alloc_host_bridge(dev, 0);
>  	if (!bridge)
> -		return dev_err_probe(dev, -ENOMEM,
> -				     "failed to alloc bridge\n");
> +		return -ENOMEM;
>  
>  	if (port->host_ops && port->host_ops->host_init) {
>  		ret = port->host_ops->host_init(port);
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

