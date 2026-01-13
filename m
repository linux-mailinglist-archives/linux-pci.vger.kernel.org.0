Return-Path: <linux-pci+bounces-44613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA47DD197C5
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 15:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94CB130208FC
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 14:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4E62857CF;
	Tue, 13 Jan 2026 14:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ryc6Q32k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C947210F59
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 14:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314565; cv=none; b=M0Nk1lhUcfpUMNnyXSmB3L03bIb4rYzP7xS3SrMpIkWVIKkstUJEHbD2KR1L1/6p3lg6EvKKlNSgDnUqQ6zCrS1tIRvtK97w00X0AUF573mhyM9pSXg87dXbSaplhnIaJIQ4yDXrP8+2+egd8igXs6PHBBR8FFdLVKQt76uNo64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314565; c=relaxed/simple;
	bh=AKUBnYj7k5U4bb8Qc2o9gbSoqfhuWPnOOdxbvK7z8p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4O9Cx1wUpPAEFie1KEbNL+Pu2itfQOinK49KexlMPITxFa9/h2ra+1ghWf6otwbNhtM62BxtOHmSJJb1wxwsNXzEq9Gs1bR5c91/uZ61Af4k8c0Q5H9biIRps4c8zwf6Rb6PGWv21SwiXSELS9Epcpn3TeuDrloOMX3viDW3xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ryc6Q32k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52224C116C6;
	Tue, 13 Jan 2026 14:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768314565;
	bh=AKUBnYj7k5U4bb8Qc2o9gbSoqfhuWPnOOdxbvK7z8p8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ryc6Q32kf0YbROemj8sB/ob+NRZpT7pZgLOeSjTAaKZ1lWGVgBirBTT5zSZkgCG09
	 VXmCIXaMFUDpOw8MCJNUO6hi8lJqiCBjNlaKOTHbrD2jExb+9qEpXl4WoCeDxscuGK
	 lGacP0wMT/8oUxgB7W4diDjlTz3lMcbuoCevr8SwX7RjqJd6kXNAqCyAhcABxu+ilz
	 KptE4606D1wFaxKwHu3ZP0yqYYYd8xRYGaTXQ9WoQ2IyWdL9a2O1/8EUbmAUgt6JXH
	 Tz/ZMJ1JCnTWTQLU8NJcSOI222BC4SXys8/cgSNLvlUgVIIjwtgFGLIcvwNkTFOu4P
	 cKjFjiJV2QlSw==
Date: Tue, 13 Jan 2026 19:59:19 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dw-rockchip: Disable BAR 0 and BAR 1 for RC mode
Message-ID: <jrah3krizuwyfwhmvq67wjsye2eeompjflpuo4dz2mgugi5txt@np6gknrtbkqo>
References: <1766570461-138256-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1766570461-138256-1-git-send-email-shawn.lin@rock-chips.com>

On Wed, Dec 24, 2025 at 06:01:01PM +0800, Shawn Lin wrote:
> To slitence the useless bar allocation error log of RC when
> scanning bus, as RC doesn't need BARs at all.

It is not RC, but Root Port. It is OK to disable the Root Port BARs if they
don't serve any purpose, but I think the issue is that the BAR size is bogus.
Both BARs report 1GiB of size, which I don't think it makes sense for a Root
Port.

Can I reword the commit message as:

Some Rockchip PCIe Root Port report bogus size of 1GiB for the BAR memories and
they cause below resource allocation issue during probe. Since there is no use
of the Root Port BAR memories, disable both of them.

- Mani

> 
>   pci 0000:00:00.0: [1d87:3588] type 01 class 0x060400 PCIe Root Port
>   pci 0000:00:00.0: BAR 0 [mem 0x00000000-0x3fffffff]
>   pci 0000:00:00.0: BAR 1 [mem 0x00000000-0x3fffffff]
>   pci 0000:00:00.0: ROM [mem 0x00000000-0x0000ffff pref]
> 	...
>   pci 0000:00:00.0: BAR 0 [mem 0x900000000-0x93fffffff]: assigned
>   pci 0000:00:00.0: BAR 1 [mem size 0x40000000]: can't assign; no space
>   pci 0000:00:00.0: BAR 1 [mem size 0x40000000]: failed to assign
>   pci 0000:00:00.0: ROM [mem 0xf0200000-0xf020ffff pref]: assigned
>   pci 0000:00:00.0: BAR 0 [mem 0x900000000-0x93fffffff]: releasing
>   pci 0000:00:00.0: ROM [mem 0xf0200000-0xf020ffff pref]: releasing
>   pci 0000:00:00.0: BAR 0 [mem 0x900000000-0x93fffffff]: assigned
>   pci 0000:00:00.0: BAR 1 [mem size 0x40000000]: can't assign; no space
>   pci 0000:00:00.0: BAR 1 [mem size 0x40000000]: failed to assign
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index f8605fe..e421fa0 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -80,6 +80,8 @@
>  #define  PCIE_LINKUP_MASK		GENMASK(17, 16)
>  #define  PCIE_LTSSM_STATUS_MASK		GENMASK(5, 0)
>  
> +#define PCIE_TYPE0_HDR_DBI2_OFFSET      0x100000
> +
>  struct rockchip_pcie {
>  	struct dw_pcie pci;
>  	void __iomem *apb_base;
> @@ -292,6 +294,8 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (irq < 0)
>  		return irq;
>  
> +	pci->dbi_base2 = pci->dbi_base + PCIE_TYPE0_HDR_DBI2_OFFSET;
> +
>  	ret = rockchip_pcie_init_irq_domain(rockchip);
>  	if (ret < 0)
>  		dev_err(dev, "failed to init irq domain\n");
> @@ -302,6 +306,10 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>  	rockchip_pcie_configure_l1ss(pci);
>  	rockchip_pcie_enable_l0s(pci);
>  
> +	/* Disable RC's BAR0 and BAR1 */
> +	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_0, 0x0);
> +	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_1, 0x0);
> +
>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

