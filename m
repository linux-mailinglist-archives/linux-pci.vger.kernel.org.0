Return-Path: <linux-pci+bounces-13790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 901FD98F93B
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 23:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51133282164
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 21:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AB51C1AC7;
	Thu,  3 Oct 2024 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFkJM08r"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD511BDAB9;
	Thu,  3 Oct 2024 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727992339; cv=none; b=RqHyg/dinZSEp3HByvNWJ0GhJh5lcbrQM7ZhtR1wKEhhaQRsM9bBbZfrddG+1g3HKVSzE+TqQnHRxsxIZfLAf8lK3/DaHk66J+Ds3cJYCnUJO9Auso1bhM9uh7jYVMv7JXGPET7ZCr6Wy9K4CLdnI/t+99Kl7Ps3aukQcGUYw3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727992339; c=relaxed/simple;
	bh=dNBSGplwis3K3/BoL1llvA0r10YCQrzM8dDYNiQKPf0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hFkaAq+OO6OYT87WyVWjS3shyESJJXs4eX8L7L5O85IJ9plVE//62zKHQ172AHU9QmmxgU44Urs+NKudxd4p3fNemlS3IqsxJE9fvHAECEMJ4kfOaLrGNxoYQ22JVyZ5Eo40lDH08kamitAl3FcyL1zHgRdo6nGxnNAd0H28YtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFkJM08r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B90C4CEC5;
	Thu,  3 Oct 2024 21:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727992338;
	bh=dNBSGplwis3K3/BoL1llvA0r10YCQrzM8dDYNiQKPf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OFkJM08rFSi8aZtXHy9IcjrHdWQ0uJl4NGs2vHxEYWcVSCL++MdeTG14/EMMULXR4
	 mAs2LRqTtUB5P3xWP/OEpwzrOVR9zzyPaSejovUAZskqTSnpEXafq0xYTwEbLleb7M
	 /sjXgymA0+ZB9mpjGj5TLbnTRtA85IhP8Id5nb/niURGG98WY/OuS4FqA7YDOW4AWt
	 Ujm2aFbY/oIWFm8Dqgul9AC6K0nXig05mWpjdmGxvDd5z+DYzLyjMBHRKot3Bhc6fW
	 Z8RlyqCJhYwh6gYC+8y4dAiLLDvUqmwD6mNsvsag8gwpaIwTghfa4aJGnjthx96G5p
	 PXoPaAr7aJRmQ==
Date: Thu, 3 Oct 2024 16:52:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	linux-pci@vger.kernel.org, vigneshr@ti.com, s-vadapalli@ti.com,
	lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com, krzk@kernel.org,
	alim.akhtar@samsung.com, shawn.guo@linaro.org,
	songxiaowei@hisilicon.com, marek.vasut+renesas@gmail.com,
	yoshihiro.shimoda.uh@renesas.com, thierry.reding@gmail.com,
	jonathanh@nvidia.com, thomas.petazzoni@bootlin.com, pali@kernel.org,
	florian.fainelli@broadcom.com,
	angelogioacchino.delregno@collabora.com, ryder.lee@mediatek.com,
	heiko@sntech.de, kevin.xie@starfivetech.com, kishon@kernel.org,
	dlemoal@kernel.org, shawn.lin@rock-chips.com,
	linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: controller: Switch back to struct
 platform_driver::remove()
Message-ID: <20241003215217.GA326383@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tdxrmmqyzcufupnwkdbg7lwgadizm7v3lxjirykijbml7x54ze@upbdzycdsilm>

On Thu, Oct 03, 2024 at 12:17:08PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> I found this patch in next as 712359cb5e9d9553c1383fc5005593aa1988efc4.
> 
> While rebasing my patches with the same purpose I found that this patch
> handled the indention differently than I did for two files:

Updated 712359cb5e9d ("PCI: controller: Switch back to struct
platform_driver::remove()") to adopt your indentation changes and also
convert drivers/pci/controller/pcie-xilinx-nwl.c, thank you very much
for noticing this!

> On Mon, Sep 23, 2024 at 08:57:06AM +0200, Sergio Paracuellos wrote:
> > diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
> > index ef73baefaeb9..b921bbb4de80 100644
> > --- a/drivers/pci/controller/pcie-altera.c
> > +++ b/drivers/pci/controller/pcie-altera.c
> > @@ -817,7 +817,7 @@ static void altera_pcie_remove(struct platform_device *pdev)
> >  
> >  static struct platform_driver altera_pcie_driver = {
> >  	.probe		= altera_pcie_probe,
> > -	.remove_new	= altera_pcie_remove,
> > +	.remove	= altera_pcie_remove,
> >  	.driver = {
> >  		.name	= "altera-pcie",
> >  		.of_match_table = altera_pcie_of_match,
> 
> here indention is inconsistent already before, I replaced the tabs after
> ".probe" by a single space (and after .remove, too).
> 
> > [...]
> > diff --git a/drivers/pci/controller/pcie-hisi-error.c b/drivers/pci/controller/pcie-hisi-error.c
> > index ad9d5ffcd9e3..cb5fcfe032d1 100644
> > --- a/drivers/pci/controller/pcie-hisi-error.c
> > +++ b/drivers/pci/controller/pcie-hisi-error.c
> > @@ -317,7 +317,7 @@ static struct platform_driver hisi_pcie_error_handler_driver = {
> >  		.acpi_match_table = hisi_pcie_acpi_match,
> >  	},
> >  	.probe		= hisi_pcie_error_handler_probe,
> > -	.remove_new	= hisi_pcie_error_handler_remove,
> > +	.remove	= hisi_pcie_error_handler_remove,
> >  };
> >  module_platform_driver(hisi_pcie_error_handler_driver);
> >  
> 
> Here I added another tab after ".remove".
> 
> > [...]
> 
> Also the patch missed to adapt drivers/pci/controller/pcie-xilinx-nwl.c.
> 
> Best regards
> Uwe



