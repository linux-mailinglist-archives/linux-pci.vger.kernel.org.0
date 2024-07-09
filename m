Return-Path: <linux-pci+bounces-10027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D107692C6A9
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 01:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDE2BB21FB4
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 23:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D06189F25;
	Tue,  9 Jul 2024 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjH1w3+G"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ABF144D00;
	Tue,  9 Jul 2024 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568251; cv=none; b=Z2HuTm/dqDu1MbbSoemf+vD4QKa4L13MobM3KOUwkVPuIcrIJhbCcY5Ac2Ss9idMA0M5gd88pwaPHhhp75XQ/pFSVzHciutSp1rIgLKmg/f7zHSnsZIkmf+yTnsVinFB+XMRND/4aSSW7dPlPn/QXHDQi4pNXGNG1cEWeSgiS8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568251; c=relaxed/simple;
	bh=ce5m4W0fTEHvtlSSwUCGDSLthpcNoLs+lwaEEU/0Tqk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KSDg51FmeQSSRqc+KYNnwGneRM+6aItmJV3bjYQPJj3akeBrxiyywblwibv8ZqXk9xp6TxRt4no+8oHMlqBZ4LLSIC1Qch3T9bOosJp10BVLhsqgwfsBdbBl0PyXvnHJLQKV0mWt2Z/EPCRF9QOjLH4PN9SEpME/EZgAgBsAtS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjH1w3+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E15C3277B;
	Tue,  9 Jul 2024 23:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720568250;
	bh=ce5m4W0fTEHvtlSSwUCGDSLthpcNoLs+lwaEEU/0Tqk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KjH1w3+GK6JjMxQpEFrZQX8ts8VlEcvNb3CYpGGD4EHPnf3XI9Cb+fBDRs5vFbk+7
	 q+/jXZj03pb7qNYHJWBib4/v+1IYiFd5vHa/qBxZexlIZUw2Lsjbd2QBF8Be4QFHrH
	 iNwHFnhb9/KblVSrNVCCgrZajLrxkDNW5B/WSV4B5DpY6/b4G5Qr71OretdkcDKOz7
	 eCTlCkSmgCnglMxvrmnKRxdeNSQfD2NAQvAKV2iOd2f0lYsBeHqxdUW5ddi3vo1dIR
	 K2rbp6ZEpqlwVhyRwyYm3//p0ftPsujgamKOTpbXanAk2G5L19DXEGs6PNYtlc8kmH
	 mGKiLSoZhzUJw==
Date: Tue, 9 Jul 2024 18:37:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: kirin: fix memory leak in kirin_pcie_parse_port()
Message-ID: <20240709233728.GA226193@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609-pcie-kirin-memleak-v1-1-62b45b879576@gmail.com>

On Sun, Jun 09, 2024 at 12:56:14PM +0200, Javier Carrasco wrote:
> The conversion of this file to use the agnostic GPIO API has introduced
> a new early return where the refcounts of two device nodes (parent and
> child) are not decremented.
> 
> Given that the device nodes are not required outside the loops where
> they are used, and to avoid potential bugs every time a new error path
> is introduced to the loop, the _scoped() versions of the macros have
> been applied. The bug was introduced recently, and the fix is not
> relevant for old stable kernels that might not support the scoped()
> variant.
> 
> Fixes: 1d38f9d89f85 ("PCI: kirin: Convert to use agnostic GPIO API")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

FYI, I moved this to the pci/controller/gpio patch just before
1d38f9d89f85.  That way there's no bisection hole and we don't need to
complicate this commit log with details about the bug because the bug
never exists.

> ---
> This bug was found while analyzing the code and I don't have hardware to
> validate it beyond compilation and static analysis. Any test with real
> hardware to make sure there are no regressions is always welcome.
> 
> The dev_err() messages have not been converted into dev_err_probe() to
> keep the current format, but I am open to convert them if preferred.
> ---
>  drivers/pci/controller/dwc/pcie-kirin.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index d1f54f188e71..0a29136491b8 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -403,11 +403,10 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  				 struct device_node *node)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct device_node *parent, *child;
>  	int ret, slot, i;
>  
> -	for_each_available_child_of_node(node, parent) {
> -		for_each_available_child_of_node(parent, child) {
> +	for_each_available_child_of_node_scoped(node, parent) {
> +		for_each_available_child_of_node_scoped(parent, child) {
>  			i = pcie->num_slots;
>  
>  			pcie->id_reset_gpio[i] = devm_fwnode_gpiod_get_index(dev,
> @@ -424,14 +423,13 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  			pcie->num_slots++;
>  			if (pcie->num_slots > MAX_PCI_SLOTS) {
>  				dev_err(dev, "Too many PCI slots!\n");
> -				ret = -EINVAL;
> -				goto put_node;
> +				return -EINVAL;
>  			}
>  
>  			ret = of_pci_get_devfn(child);
>  			if (ret < 0) {
>  				dev_err(dev, "failed to parse devfn: %d\n", ret);
> -				goto put_node;
> +				return ret;
>  			}
>  
>  			slot = PCI_SLOT(ret);
> @@ -439,10 +437,8 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  			pcie->reset_names[i] = devm_kasprintf(dev, GFP_KERNEL,
>  							      "pcie_perst_%d",
>  							      slot);
> -			if (!pcie->reset_names[i]) {
> -				ret = -ENOMEM;
> -				goto put_node;
> -			}
> +			if (!pcie->reset_names[i])
> +				return -ENOMEM;
>  
>  			gpiod_set_consumer_name(pcie->id_reset_gpio[i],
>  						pcie->reset_names[i]);
> @@ -450,11 +446,6 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  	}
>  
>  	return 0;
> -
> -put_node:
> -	of_node_put(child);
> -	of_node_put(parent);
> -	return ret;
>  }
>  
>  static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
> 
> ---
> base-commit: d35b2284e966c0bef3e2182a5c5ea02177dd32e4
> change-id: 20240609-pcie-kirin-memleak-18c83a31d111
> 
> Best regards,
> -- 
> Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 

