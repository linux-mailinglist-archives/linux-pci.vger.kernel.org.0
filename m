Return-Path: <linux-pci+bounces-29649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53021AD8364
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 08:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB071895B5B
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 06:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F835257AF2;
	Fri, 13 Jun 2025 06:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeCuvtCG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B271369B4;
	Fri, 13 Jun 2025 06:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749797693; cv=none; b=IB8//+PDkk/gtn9/rrH104TnWdaJ2GJdwZit8xTPzZCAtnxmRZHd6pMf4V5SLZ1czNCeCR21GObrwK7Bj2zz9jeMtORsQuG3hXJYMA08ujTjf5PN3zgmi/wX/Yok2ktx2e/Q7IN/tJtIUhH65cItYTN8PMSravj/uGmKNNtJoqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749797693; c=relaxed/simple;
	bh=1s/szMVjHm2c5YpFJE4JzICjVT6sl1T+nHxY2oXfPJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8bWNddjzoc92MwGxP45qZiDJKd8zC9/iDru9QBMP7MqLodUBnrl2ecJipcXxd/xz95uDxPuWPcgR6DbOcZ3RYCONmMyhjrLmE+1P23FpfaVGDH0el7ahOYpwDqbw7KbErBqiQOX1V2MwFHEsL4Oa7B3p5q9FNrPHpJyzN+xGa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeCuvtCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F465C4CEF1;
	Fri, 13 Jun 2025 06:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749797692;
	bh=1s/szMVjHm2c5YpFJE4JzICjVT6sl1T+nHxY2oXfPJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WeCuvtCG8iIXRXnhJ5iaXqjj6hBoLE9nJhyZji6mGfw9szRLL/Xy8f1ycbXigCuA0
	 WIpW3PtLH3zAaZyLQDW/cX2DUoNiB+goqVATpP01Qea3eOEg9GCgh5QexINECMGp/4
	 bPmFsLCXhGAn5t78RMVAqR6W2u5OnhX5B3lKZ9a6G2SDoFddyWs4dfw5Ocq1CuDinq
	 uAopszmsyYSwpmdYpIJZ0rWr3S3LJcRGpSwrTcMCvG/P2Y3G/kQX5hIKeMsmhv4bZr
	 2A6WingZ25Re1WjygPKDCtn1gR1UrNGiHyEPP2+pANoVrQDuNmOXqS/H9/DBebDa2/
	 2Ocmit6DjOuww==
Date: Fri, 13 Jun 2025 12:24:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com, 
	heiko@sntech.de, manivannan.sadhasivam@linaro.org, yue.wang@amlogic.com, 
	pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org, jingoohan1@gmail.com, 
	khilman@baylibre.com, jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 2/2] PCI: dwc: Remove redundant MPS configuration
Message-ID: <6v7m7qt4n26n6pmx5tggmmvv7na6t5v5wtfqev5x4wxosymwul@j3dizxyyy4tg>
References: <20250510155607.390687-1-18255117159@163.com>
 <20250510155607.390687-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250510155607.390687-3-18255117159@163.com>

On Sat, May 10, 2025 at 11:56:07PM +0800, Hans Zhang wrote:
> The Meson PCIe controller driver manually configures maximum payload
> size (MPS) through meson_set_max_payload, duplicating functionality now
> centralized in the PCI core.  Deprecating redundant code simplifies the
> driver and aligns it with the consolidated MPS management strategy,
> improving long-term maintainability.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>

I believe that the root port MPS set by PCI core in patch 1 should be enough to
remove the logic in the driver. But given that we already saw that is not the
case with Armada controllers, it would be good if one of the Meson maintainers
could verify if this series works as intented. Since the driver is not using the
DEVCAP value, but using the hardcoded value, I'm slightly worried that setting
MPS value other than 256 would have any downside.

But anyway, the root port MPS should be the same with and without this series.
This can be verified by:

sudo lspci -vvv | grep MaxPayload

Also, performing any benchmark and making sure that the device performance
didn't get affected would be great.

- Mani

> ---
>  drivers/pci/controller/dwc/pci-meson.c | 17 -----------------
>  1 file changed, 17 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index db9482a113e9..126f38ed453d 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -261,22 +261,6 @@ static int meson_size_to_payload(struct meson_pcie *mp, int size)
>  	return fls(size) - 8;
>  }
>  
> -static void meson_set_max_payload(struct meson_pcie *mp, int size)
> -{
> -	struct dw_pcie *pci = &mp->pci;
> -	u32 val;
> -	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	int max_payload_size = meson_size_to_payload(mp, size);
> -
> -	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
> -	val &= ~PCI_EXP_DEVCTL_PAYLOAD;
> -	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
> -
> -	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
> -	val |= PCIE_CAP_MAX_PAYLOAD_SIZE(max_payload_size);
> -	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
> -}
> -
>  static void meson_set_max_rd_req_size(struct meson_pcie *mp, int size)
>  {
>  	struct dw_pcie *pci = &mp->pci;
> @@ -381,7 +365,6 @@ static int meson_pcie_host_init(struct dw_pcie_rp *pp)
>  
>  	pp->bridge->ops = &meson_pci_ops;
>  
> -	meson_set_max_payload(mp, MAX_PAYLOAD_SIZE);
>  	meson_set_max_rd_req_size(mp, MAX_READ_REQ_SIZE);
>  
>  	return 0;
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

