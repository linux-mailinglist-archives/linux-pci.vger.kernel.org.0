Return-Path: <linux-pci+bounces-6756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 538798B51C3
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 08:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000601F21419
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 06:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898F4111BB;
	Mon, 29 Apr 2024 06:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUjmuQgF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C17E10A13;
	Mon, 29 Apr 2024 06:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714373608; cv=none; b=JvIkno5OdPNdCWvvbG6fAxSQOEbDLYjRO2UAlp3L4GDLZGykw8Ofpg8dMDLTv27CvHkcTv9n6K+z1Es1zCQmud8FY1f1Hi5QWonB+yB8HksZUKFNgN9NSb2PaTpoaxbx0sQMVajNBiLErQS9d/IWnciYYREppOToVHGaX+2nnQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714373608; c=relaxed/simple;
	bh=M8r1mzD/Vp6D6ntAZGbsO8zGjFuc96y23eBr/1kzR5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGHnGnW6DyyQFkwrcBZv80tlxLj3fXz7T9MDZTNI8T+2yiqJ3Gw2QjD8Q+YDGt5Q5bSThaMA1FS1xAcovp1Q8WSdsU0WkrUlnpaxSDc4mgkvxlZTnbgBve6gvxlxEX0B152HGnKCtSfDz//QuNQAT+r3GdEsCFnRTnVskxz+osA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUjmuQgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F48C113CD;
	Mon, 29 Apr 2024 06:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714373607;
	bh=M8r1mzD/Vp6D6ntAZGbsO8zGjFuc96y23eBr/1kzR5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pUjmuQgFWZR0nyY0aH3SyVefbuHf0uA9kGbw4opWhWutgJ9WZgLEWxKzd+iuQrtD6
	 iwiXQAhrIagQqv74dN2oQGIdlPQIsnxbPTFLng7W+xfhtT7UbCRFLHWdI9NXnMp6Ad
	 govuIucxu+9ShSiY0g+GNMS42XzpVTtUryJxGB+tpaVUZtHzI2OaXd09XCv/fbRWg0
	 6F87DFn32q7jVM0FD502ysPROjMYtut9jvlpR3ZBvlxTjo0cSW5NUDg/F7lgYjcyQQ
	 4MSonEW7lInCAYgfgbcui44QZ9aK38Epv9TPRtGpJnNOCJff8c6WFPaqM8iw3Ee7pi
	 0xr2gWUEyhzGw==
Date: Mon, 29 Apr 2024 08:53:21 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] PCI: dwc: keystone: Fix potential NULL dereference
Message-ID: <Zi9D4bWB9tDTXfHV@ryzen.lan>
References: <20240329051947.28900-1-amishin@t-argos.ru>
 <20240425092135.13348-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425092135.13348-1-amishin@t-argos.ru>

On Thu, Apr 25, 2024 at 12:21:35PM +0300, Aleksandr Mishin wrote:
> In ks_pcie_setup_rc_app_regs() resource_list_first_type() may return
> NULL which is later dereferenced. Fix this bug by adding NULL check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
> v2: Add return code processing
> 
>  drivers/pci/controller/dwc/pci-keystone.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 844de4418724..5c6786d9f3e9 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -382,17 +382,22 @@ static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
>  	} while (val & DBI_CS2);
>  }
>  
> -static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
> +static int ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
>  {
>  	u32 val;
>  	u32 num_viewport = ks_pcie->num_viewport;
>  	struct dw_pcie *pci = ks_pcie->pci;
>  	struct dw_pcie_rp *pp = &pci->pp;
> -	u64 start, end;
> +	struct resource_entry *ft;
>  	struct resource *mem;
> +	u64 start, end;
>  	int i;
>  
> -	mem = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM)->res;
> +	ft = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> +	if (!ft)
> +		return -EINVAL;
> +
> +	mem = ft->res;
>  	start = mem->start;
>  	end = mem->end;
>  
> @@ -403,7 +408,7 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
>  	ks_pcie_clear_dbi_mode(ks_pcie);
>  
>  	if (ks_pcie->is_am6)
> -		return;
> +		return 0;
>  
>  	val = ilog2(OB_WIN_SIZE);
>  	ks_pcie_app_writel(ks_pcie, OB_SIZE, val);
> @@ -420,6 +425,8 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
>  	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
>  	val |= OB_XLAT_EN_VAL;
>  	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
> +
> +	return 0;
>  }
>  
>  static void __iomem *ks_pcie_other_map_bus(struct pci_bus *bus,
> @@ -814,7 +821,10 @@ static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
>  		return ret;
>  
>  	ks_pcie_stop_link(pci);
> -	ks_pcie_setup_rc_app_regs(ks_pcie);
> +	ret = ks_pcie_setup_rc_app_regs(ks_pcie);

Since ks_pcie_setup_rc_app_regs() returns 0 on success,
I suggest you do:

if (ret)
	return ret;

Instead.

> +	if (ret < 0)
> +		return ret;
> +


Kind regards,
Niklas

