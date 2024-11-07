Return-Path: <linux-pci+bounces-16262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D223D9C0B7B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 17:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E901F24175
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 16:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032C7218585;
	Thu,  7 Nov 2024 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXtOYSPT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD88B217307;
	Thu,  7 Nov 2024 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996381; cv=none; b=MU2hTd72o+1o5Rf3jpFjwBgdo+dQja7ngkZ+1S7WLb6mtwwKNFRZJq5eCr85ScEopSo/XCU4dGvysPMhKVuC+q1TPr/AP/ZLsam2iG46REes+iUdHgp5vjvemcRa7R/agttks6vFbQB6O9kMoQbk4yNvF7ar/5cnuUtxMegv+qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996381; c=relaxed/simple;
	bh=SqxOv6okU/sodRwTyM+r4oFEioQMmC22R+3bohK4KUo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=L2zPJtM++JcAXt9t33isI2v6YXLcXg7CB5OdO2Ce58rJcCv60xfbnWvGTQA+VzmFLSX5agZE5O8uNgm0CwTZhRYoR2X187ix17NxQJQXk0scKndu9Q19AIgnR2MKJMwRsvLjNjhWMwjDjxn1ew5Hx0GtrSLu/EpgVmCNs1P3VzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXtOYSPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED68C4CECC;
	Thu,  7 Nov 2024 16:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730996381;
	bh=SqxOv6okU/sodRwTyM+r4oFEioQMmC22R+3bohK4KUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GXtOYSPT/H3r3SnyRnmLkGXZaW31eJexqtj829FQ1pCaIQBJOu1cV9PhStGxpY6ZN
	 Bb21beAvVycEuV6K7ZTGhXlazBtYOCHmi2mcueLIWdYCQFCsJWuJ81a83lG24EcUJV
	 +qkLwkysKWz+if7+TZV9P4BdsgCCYFUgO59gReLMFwKbj8oX4fWVoaLuENDN6I8mIv
	 wsD3H98n+WJrIZxxfLol5NtKAtCH1YSpNiEQgNLi+0X61rGJ2vh66xxnsrR1cuE4kq
	 LJqpU8MR+d7AqAYkvkAaQm8xNjNYWfBcDe3AGAMIhtOhGsTLHVjSRU79qpNRaPEUjm
	 7+L1JZkquSGLg==
Date: Thu, 7 Nov 2024 10:19:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joerg Roedel <jroedel@suse.de>, Rob Herring <robh@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Anders Roxell <anders.roxell@linaro.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Xingang Wang <wangxingang5@huawei.com>
Subject: Re: [PATCH RESEND] iommu/of: Fix pci_request_acs() before
 enumerating PCI devices
Message-ID: <20241107161939.GA1618126@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107-pci_acs_fix-v1-1-185a2462a571@quicinc.com>

On Thu, Nov 07, 2024 at 01:29:15PM +0530, Pavankumar Kondeti wrote:
> From: Xingang Wang <wangxingang5@huawei.com>
> 
> When booting with devicetree, the pci_request_acs() is called after the
> enumeration and initialization of PCI devices, thus the ACS is not
> enabled. And ACS should be enabled when IOMMU is detected for the
> PCI host bridge, so add check for IOMMU before probe of PCI host and call
> pci_request_acs() to make sure ACS will be enabled when enumerating PCI
> devices.
> 
> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when configuring IOMMU linkage")
> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
> Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> ---
> Earlier this patch made it to linux-next but got dropped later as it
> broke PCI on ARM Juno R1 board. AFAICT, this issue is never root caused,
> so resending this patch to get attention again.
> 
> https://lore.kernel.org/all/1621566204-37456-1-git-send-email-wangxingang5@huawei.com/
> 
> The original problem that is being fixed by this patch still exists. In
> my use case, all the PCI VF(s) assigned to a VM are sharing the same
> group since these functions are attached under a Multi function PCIe root port 

FWIW, here are the problem reports (which are buried in the thread
above):

  https://lore.kernel.org/all/01314d70-41e6-70f9-e496-84091948701a@samsung.com/ (Marek)
  https://lore.kernel.org/all/CADYN=9JWU3CMLzMEcD5MSQGnaLyDRSKc5SofBFHUax6YuTRaJA@mail.gmail.com/ (Anders)

Given problem reports, the fact that the patch was acked and reviewed
earlier means nothing.  We have to ensure that any issues are resolved
before considering this patch again.

> emulated by the QEMU. This patch fixes that problem.
> ---
>  drivers/iommu/of_iommu.c | 1 -
>  drivers/pci/of.c         | 8 +++++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index e7a6a1611d19..f19db52388f5 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -141,7 +141,6 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
>  			.np = master_np,
>  		};
>  
> -		pci_request_acs();
>  		err = pci_for_each_dma_alias(to_pci_dev(dev),
>  					     of_pci_iommu_init, &info);
>  		of_pci_check_device_ats(dev, master_np);
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index dacea3fc5128..dc90f4e45dd3 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -637,9 +637,15 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
>  
>  int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
>  {
> -	if (!dev->of_node)
> +	struct device_node *node = dev->of_node;
> +
> +	if (!node)
>  		return 0;
>  
> +	/* Detect IOMMU and make sure ACS will be enabled */
> +	if (of_property_read_bool(node, "iommu-map"))
> +		pci_request_acs();
> +
>  	bridge->swizzle_irq = pci_common_swizzle;
>  	bridge->map_irq = of_irq_parse_and_map_pci;
>  
> 
> ---
> base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
> change-id: 20241107-pci_acs_fix-2239e0fb1768
> 
> Best regards,
> -- 
> Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> 

