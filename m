Return-Path: <linux-pci+bounces-35192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75118B3D275
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 13:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF402189D3D3
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 11:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEE61FC7C5;
	Sun, 31 Aug 2025 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JY8jpMau"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C27E1B2186;
	Sun, 31 Aug 2025 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756639216; cv=none; b=DWtatc2NbCXQU8Xv8s0U5y/CtD43jon/Qzz8laW7BBv/W7RlwevkUWjIRSgvP5QUvpnoQJIDGarkjYUtW0fLSSInZYffKWWIP8FFQ/bW9z5aApV8p3g6rhJM0aUYpaQC3vejKQVatPW9Z69uq3u0KCfRdv9AMb+8pAffu+cy1tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756639216; c=relaxed/simple;
	bh=UzT7xj/bbfHi7nArp4mCwWSZ0oHnfBIV0P7CWeu148E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UM33bIjGYy2h6730cqzaGwO0izjhdI22TFjLhB7UYmnexzNvqvDSBWIlKdu0/E6mjSAz6hlzDaXTm2TJKpzW1jB5GMjSs3OK45EYr/1dfPqEW1tga1weebhjlvE3T6EenbfmaHdKp66/GpsB/jwcO9aZk26DHdzZGQKH/zIjSjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JY8jpMau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C5AC4CEED;
	Sun, 31 Aug 2025 11:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756639215;
	bh=UzT7xj/bbfHi7nArp4mCwWSZ0oHnfBIV0P7CWeu148E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JY8jpMauZ2GUkGBm/jlBC3gW6URueV8ERNKm6dOcTyqlfCj9pEMXTTduwcsXTlIFw
	 +rmoD54zD092QEYtjJfyN9WTf99pYpp2moBhg9pyC5tDMGf30/UNzpCyd5riLdFTUk
	 Jpm8QPkolPUYmSpdHBcmy1Mc6LCdHHPx1mUmS2/ovG9ZUVdzTNC31c3IQCeM19+/Z/
	 G9JFo+3YRrzKDnAWVHKKfOTdu/HnZjD7c3agKnh8B3htu+mEsq6FnvMv0tS9Pkaqqt
	 HD5kDR+JPMVXWrQoM28CPqAbgoMtY84olz/l2e3QlV/2+AOkKy2wAcuT+EO6sAdS7Y
	 EaPfM6AIQCimg==
Date: Sun, 31 Aug 2025 16:50:09 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: thierry.reding@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, jonathanh@nvidia.com, 
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: fix devm_kcalloc argument order for
 port->phys allocation
Message-ID: <6yaka4sjghyq727gyhlf3usu24amj3q46ckh24ukvx4kuffmfm@d3nwn34zwijt>
References: <20250819150436.3105973-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819150436.3105973-1-alok.a.tiwari@oracle.com>

On Tue, Aug 19, 2025 at 08:04:08AM GMT, Alok Tiwari wrote:
> Fix incorrect argument order in devm_kcalloc() when allocating
> port->phys, The original call used sizeof(phy) as the number of
> elements and port->lanes as the element size, which is reversed.
> While this happens to produce the correct total allocation size with
> current pointer size and lane counts, the argument order is wrong.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Missing Fixes tag. I'll add it while applying.

- Mani

> ---
>  drivers/pci/controller/pci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 467ddc701adc..bb88767a3797 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -1344,7 +1344,7 @@ static int tegra_pcie_port_get_phys(struct tegra_pcie_port *port)
>  	unsigned int i;
>  	int err;
>  
> -	port->phys = devm_kcalloc(dev, sizeof(phy), port->lanes, GFP_KERNEL);
> +	port->phys = devm_kcalloc(dev, port->lanes, sizeof(phy), GFP_KERNEL);
>  	if (!port->phys)
>  		return -ENOMEM;
>  
> -- 
> 2.50.1
> 

-- 
மணிவண்ணன் சதாசிவம்

