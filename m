Return-Path: <linux-pci+bounces-24259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3D8A6AF72
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 21:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19CB188EF3C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 20:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D684229B1A;
	Thu, 20 Mar 2025 20:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OK6kFbdZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A8B45027;
	Thu, 20 Mar 2025 20:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742504216; cv=none; b=gLjK4WtS7mrrB2GQNDInDRx7e6nX6vHze/i22sQmh8E2xgERNhPSnEHKX5Erxb7bKhiPwdHzXCgj+wKUMgpPkbv7JFQH97p12uUDOoL3WA3QMLag1L0ZR7SQDD/XTLUqz8WGOAkDGs6lTgbW2vZ80M18JpLHas0UdfoKAmZQY+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742504216; c=relaxed/simple;
	bh=KzYuCbF/0WoU7lS07M4U1UqMt3uKsndEKoSXWbsCoGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZSSAE2UZx6TRl3kGmNY/T+KsbeHnijC0nVyaeJ3789WJJwXCQ9cOE+uLaIGgZB/8Xz/5wYA/hZFVni2hE0hJSZuR1YVjEh/q8v4uAmcXp2yrcG7TKNEC+/ef3RWu+rJ8P7t0k4Jw9F4ohX3Xa74e3F/xQZ+ClLCNmG+U4rX/XyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OK6kFbdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD6CC4CEDD;
	Thu, 20 Mar 2025 20:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742504216;
	bh=KzYuCbF/0WoU7lS07M4U1UqMt3uKsndEKoSXWbsCoGQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OK6kFbdZx/S49999jDk1V8ruCLuzxKDjAEjyVAp1JTxfvTeZAS4EyHpxu7xM69LyA
	 GHZjHgAoRY+e+5P4Hdjcy9KpPnie14+HSGSfE+DgG0/gzbHFYwLKKZbqKyNRGPMgae
	 HeGhiRyN5lWM7lk/TiPh2R+Y/e00G3OLKUSeqpK0oAvV3lqU9H2XxqBbcoIAPfmR48
	 In5BtHvG0o3QYVg3LQEnfC1Yp0hIAj6L5QDyqMrsNU32UOgf5P9SAq9kil7yito9E1
	 5naolHxPe4uUgTOgv3rm/GJfat+E/k22WdUHpHnY5voURUXR+cAnrkatoEzjSuJeBC
	 oQjuiNu17/eGg==
Date: Thu, 20 Mar 2025 15:56:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Chuanhua Lei <lchuanhua@maxlinear.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC NOT TESTED] PCI: intel-gw: Use use_parent_dt_ranges
 and clean up intel_pcie_cpu_addr_fixup()
Message-ID: <20250320205654.GA1098970@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305-intel-v1-1-40db3a685490@nxp.com>

On Wed, Mar 05, 2025 at 12:07:54PM -0500, Frank Li wrote:
> Remove intel_pcie_cpu_addr_fixup() as the DT bus fabric should provide correct
> address translation. Set use_parent_dt_ranges to allow the DWC core driver to
> fetch address translation from the device tree.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied to pci/controller/dwc-cpu-addr-fixup for v6.15, thanks!

There is a minor dts change required, but Lei Chuan Hua has confirmed
that all users are internal to Maxlinear and will update:

https://lore.kernel.org/r/BY3PR19MB507667CE7531D863E1E5F8AEBDD82@BY3PR19MB5076.namprd19.prod.outlook.com

> ---
> This patches basic on
> https://lore.kernel.org/imx/20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com/
> 
> I have not hardware to test and there are not intel,lgm-pcie in kernel
> tree.
> 
> Your dts should correct reflect hardware behavor, ref:
> https://lore.kernel.org/linux-pci/Z8huvkENIBxyPKJv@axis.com/T/#mb7ae78c3a22324b37567d24ecc1c810c1b3f55c5
> 
> According to your intel_pcie_cpu_addr_fixup()
> 
> Basically, config space/io/mem space need minus SZ_256. parent bus range
> convert it to original value.
> 
> Look for driver owner, who help test this and start move forward to remove
> cpu_addr_fixup() work.
> ---
> Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-intel-gw.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
> index 9b53b8f6f268e..c21906eced618 100644
> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -57,7 +57,6 @@
>  	PCIE_APP_IRN_INTA | PCIE_APP_IRN_INTB | \
>  	PCIE_APP_IRN_INTC | PCIE_APP_IRN_INTD)
>  
> -#define BUS_IATU_OFFSET			SZ_256M
>  #define RESET_INTERVAL_MS		100
>  
>  struct intel_pcie {
> @@ -381,13 +380,7 @@ static int intel_pcie_rc_init(struct dw_pcie_rp *pp)
>  	return intel_pcie_host_setup(pcie);
>  }
>  
> -static u64 intel_pcie_cpu_addr(struct dw_pcie *pcie, u64 cpu_addr)
> -{
> -	return cpu_addr + BUS_IATU_OFFSET;
> -}
> -
>  static const struct dw_pcie_ops intel_pcie_ops = {
> -	.cpu_addr_fixup = intel_pcie_cpu_addr,
>  };
>  
>  static const struct dw_pcie_host_ops intel_pcie_dw_ops = {
> @@ -409,6 +402,7 @@ static int intel_pcie_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, pcie);
>  	pci = &pcie->pci;
>  	pci->dev = dev;
> +	pci->use_parent_dt_ranges = true;
>  	pp = &pci->pp;
>  
>  	ret = intel_pcie_get_resources(pdev);
> 
> ---
> base-commit: 1552be4855dacca5ea39b15b1ef0b96c91dbea0d
> change-id: 20250305-intel-7c25bfb498b1
> 
> Best regards,
> 

