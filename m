Return-Path: <linux-pci+bounces-23974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CD7A65BD4
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 19:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D1B881F83
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 17:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE531B043E;
	Mon, 17 Mar 2025 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRjmX+BQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D518E1B0435;
	Mon, 17 Mar 2025 17:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234344; cv=none; b=dTnwVC0be6VVdIDeJ9CxFsFGuoI2hEzhQ2ALJygVJwk39k/YgUYKxAVbnKD75Qwc1jXPWpNduhCe8IhWsX0rdluimWEJHg6n2vnjS9m5kapYkoxGpnBTO+9lo3dc+sLWHDoZy9idDVrqaI4qeVCC7XoDXhON1VU7bEl0+b2frBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234344; c=relaxed/simple;
	bh=Ao/Q1TdsuIo6DPrZFpK335g5H7u6ziXmDeACnbRYYzk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SYkZFkCm7jMvKWkdHPqbUFgt2QNcFkjv02om14c58mZ8D0DLyIOpsUydC3qAROqKS6FdXUBu26pBmHDcPRLC5+cxAYQEY5RwNEltADKHGE1cuDvSe8M1MFgca4UZZxJ0CtagJMC5jZnI0t4lfuPGKXC7hpqeBDkUN8mjQgzVfz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRjmX+BQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D8EC4CEE3;
	Mon, 17 Mar 2025 17:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742234344;
	bh=Ao/Q1TdsuIo6DPrZFpK335g5H7u6ziXmDeACnbRYYzk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bRjmX+BQVsq9fWgV5dx+0r73WyI/OoZd5ruO71XLwrfB9pcwR7pV/4haaaL5BcTke
	 DQXO71UhjfG0wpLQbu9J21X4h4mfw7f1I7oeyXBBBlgUGBhwTt1QUtJu2gn4d0tr/O
	 Z6I735FiVvWzi8Hi+ulkdfahfvCaGjzyAagdWIAbtkYTptsKJA/rMdECDZKubFiRlM
	 owqDkwXZGGDduEXXfKzYVJnTPJYvA/+QjiNOtlD+iRQOl9Ymgu89SthSnu5kgRoCEy
	 WbNZgtAW8rhxPt8UVf7wmQvJwnwQrm6i+H8YRMjvHZLNDRFcPDTpli3wJNS7Bmf837
	 MwvOqzxSZ3bVw==
Date: Mon, 17 Mar 2025 12:59:02 -0500
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
Message-ID: <20250317175902.GA934093@bhelgaas>
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

Any update on this, Chuanhua?

I plan to merge v12 of Frank's series [1] for v6.15.  We need to know
ASAP if that would break intel-gw.

If we knew that it was safe to also apply this patch to remove
intel_pcie_cpu_addr(), that would be even better.

I will plan to apply the patch below on top of Frank's series [1] for
v6.15 unless I hear that it would break something.

Bjorn

[1] https://lore.kernel.org/r/20250315201548.858189-1-helgaas@kernel.org

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

