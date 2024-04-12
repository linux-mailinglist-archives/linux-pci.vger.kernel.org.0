Return-Path: <linux-pci+bounces-6194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653718A3639
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 21:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B691C21934
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 19:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8928D150988;
	Fri, 12 Apr 2024 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjVggVJ8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D12914AD37;
	Fri, 12 Apr 2024 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712949245; cv=none; b=kCCGG2BFc0QP5zoRZ2h9R9aTGbZ2vlHw4sTklas0JtYs7CQ9vzqUECBBzem0ccsGXTSJcqNwIbxk/6ZTVmN+RTtw8rQp0MlyM/SV3LZwnhVcGQYzGsxX8fsRKAYbXdLoZuUVp7TyI77D2KP2uAYebz6h8Pk0DzPLFKxObOLjT78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712949245; c=relaxed/simple;
	bh=cQNWyLD2FXfR0yTg5/S/h+2fInQpSquK/RmrY9b7Mz8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uNkjP5sbbFtzF5p2kR7kEhiNUT+FnjcoYtslmQ9s27/gfowKr/vanzEfruSmZGTcn5u9SUta9PLFcj0wQ+AWzaBsFbphK+F88qEOcfp13/oIguTV/JVhHyrg1NVzKA4T5pCrrguBCav/b36uNJOQsR/jlib0Q3ew0AxXz97hohQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjVggVJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E21C113CC;
	Fri, 12 Apr 2024 19:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712949244;
	bh=cQNWyLD2FXfR0yTg5/S/h+2fInQpSquK/RmrY9b7Mz8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SjVggVJ87kGjQuEsrOsNZnIIfAWGFMlRga+rNqiycOEgJOppv6aYB55CDWixv2RAm
	 +iuQR4ebN6F8HeU73Ay0Z9vUXZTnoni3WoKYYOjGZcMBqYLIoVe0bNiBAW+v7y9HkG
	 TI34d6nA8XrJYbcKnSQAPLfPkJoLdXljv2GkTCvY1YgBlPsSYXriEQmEk7Tj/vXgPi
	 BDYlUkIR1Zhy/gF6zp/JSCtMFbRtZbOWKMp+zKki2RnPRROrnx4aylrfVW6yJvlQdY
	 7Td/LciZFcnWYHIU8k/ka2mROB7uwYk55DqUQjJcKI9ObxPuZ3d+xOkvX/hjiRgpu9
	 BggogoAJ7PdDA==
Date: Fri, 12 Apr 2024 14:14:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, kthota@nvidia.com,
	mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2] PCI: tegra194: Fix probe path for Endpoint mode
Message-ID: <20240412191402.GA10938@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408093053.3948634-1-vidyas@nvidia.com>

On Mon, Apr 08, 2024 at 03:00:53PM +0530, Vidya Sagar wrote:
> Tegra194 PCIe probe path is taking failure path in success case for
> Endpoint mode. Return success from the switch case instead of going
> into the failure path.
> 
> Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> v2:
> * Added 'Fixes' and 'Reviewed-by' from Jon Hunter
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 4bba31502ce1..1a8178dc899a 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2273,11 +2273,14 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>  		ret = tegra_pcie_config_ep(pcie, pdev);
>  		if (ret < 0)
>  			goto fail;
> +		else
> +			return 0;

Wow, how did you ever notice this?  It looks like this path would
previously have returned "ret" (which was most likely 0 for success)
but with an extra tegra_bpmp_put() that we shouldn't have done.

Eagle eyes!

>  		break;
>  
>  	default:
>  		dev_err(dev, "Invalid PCIe device type %d\n",
>  			pcie->of_data->mode);
> +		ret = -EINVAL;
>  	}
>  
>  fail:
> -- 
> 2.25.1
> 

