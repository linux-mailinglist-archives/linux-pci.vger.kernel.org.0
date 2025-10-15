Return-Path: <linux-pci+bounces-38160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D51F3BDD2C2
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 09:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7688188B362
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 07:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10A52C3768;
	Wed, 15 Oct 2025 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jhp0dbfd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A635A248F57;
	Wed, 15 Oct 2025 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760514037; cv=none; b=E7yuzW0rLGNDyQkvaCVJiTRXSBxGBhkkCSknQYYk9Tndf01lIdRxVjVDF8ru8s3ZYAiQtT63Po7IhTYVHQP3mRD4I35uxNqGuWGgHpdwxQJ0ncFOmmgVJgIYeEi8dePmsoKlzmXQm7Y7lF7asdg8fL8XD1tnBk7qMP8ilmk3fvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760514037; c=relaxed/simple;
	bh=aezqpQtdc2IZVeJjr14RhvvsN/PyWhP34fokKeuwJ1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhjkUzenqjoXuIuSXa++PYs8D4+X6oFTxoOwYjGRojOnKJ7p1SRE3yHYtmXdZ3BRlSoyrzvCcctU2neFQObR5cKrQ71y+fSx6IMET8/YiMvAyyftFJk2G2VyDlatuG+hjfFlqgD/02+cD0UEWKleIt+hUw6C9qL/jWBOmsDFlSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jhp0dbfd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8505C4CEF9;
	Wed, 15 Oct 2025 07:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760514037;
	bh=aezqpQtdc2IZVeJjr14RhvvsN/PyWhP34fokKeuwJ1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jhp0dbfdB9IfysKdHQfz5NWlOzPWwmQ31A4BFqUFwFEbgY1eP0BBN14FnFDk9XzXx
	 nWFkCjbnGV5+64K9IzHbL59dmPD9vHWDT4V4schr0SYd8WuodbFoMyBUONgfvuAOpm
	 6Z9xN1pYdvTtWmbqirbLzbvwQZVcZzO7n+8NQNzG6RfqAwYlrDnpX3s7w2cox7NgSb
	 Uw86vUseBdw0jPzVaWjSlBZ8nHhX/CzRJBmd2GMIS2VV/r4rMT7z7cdLQbQOEBACZ2
	 sNAVxx2WLUczpUvj1aQxw8/vQmnUtA1fHsV0daueMemmscUJen2SQ0v/Rv8XtQ7Snf
	 b2TcwOJLkfdwQ==
Date: Wed, 15 Oct 2025 09:40:30 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Scott Branden <sbranden@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Frank Li <Frank.Li@nxp.com>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 3/4] PCI: iproc: Implement MSI controller node
 detection with of_msi_xlate()
Message-ID: <aO9P7rRW0o9UmFz1@lpieralisi>
References: <20251014095845.1310624-1-lpieralisi@kernel.org>
 <20251014095845.1310624-4-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014095845.1310624-4-lpieralisi@kernel.org>

On Tue, Oct 14, 2025 at 11:58:44AM +0200, Lorenzo Pieralisi wrote:
> The functionality implemented in the iproc driver in order to detect an
> OF MSI controller node is now fully implemented in of_msi_xlate().
> 
> Replace the current msi-map/msi-parent parsing code with of_msi_xlate().
> 
> Since of_msi_xlate() is also a deviceID mapping API, pass in a fictitious
> 0 as deviceID - the driver only requires detecting the OF MSI controller
> node not the deviceID mapping per-se (of_msi_xlate() return value is
> ignored for the same reason).
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> ---
>  drivers/pci/controller/pcie-iproc.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)

Heads-up (I will have to respin anyway), of_msi_xlate() needs to be
exported for this to work when compiled as a module, kbuild-bot barfed
at it, I have fixed it already - if anyone can help me test it anyway
that would be great.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index 22134e95574b..ccf71993ea35 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -17,6 +17,7 @@
>  #include <linux/irqchip/arm-gic-v3.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_platform.h>
>  #include <linux/phy/phy.h>
> @@ -1337,29 +1338,16 @@ static int iproc_pcie_msi_steer(struct iproc_pcie *pcie,
>  
>  static int iproc_pcie_msi_enable(struct iproc_pcie *pcie)
>  {
> -	struct device_node *msi_node;
> +	struct device_node *msi_node = NULL;
>  	int ret;
>  
>  	/*
>  	 * Either the "msi-parent" or the "msi-map" phandle needs to exist
>  	 * for us to obtain the MSI node.
>  	 */
> -
> -	msi_node = of_parse_phandle(pcie->dev->of_node, "msi-parent", 0);
> -	if (!msi_node) {
> -		const __be32 *msi_map = NULL;
> -		int len;
> -		u32 phandle;
> -
> -		msi_map = of_get_property(pcie->dev->of_node, "msi-map", &len);
> -		if (!msi_map)
> -			return -ENODEV;
> -
> -		phandle = be32_to_cpup(msi_map + 1);
> -		msi_node = of_find_node_by_phandle(phandle);
> -		if (!msi_node)
> -			return -ENODEV;
> -	}
> +	of_msi_xlate(pcie->dev, &msi_node, 0);
> +	if (!msi_node)
> +		return -ENODEV;
>  
>  	/*
>  	 * Certain revisions of the iProc PCIe controller require additional
> -- 
> 2.50.1
> 

