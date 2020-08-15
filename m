Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635622454DF
	for <lists+linux-pci@lfdr.de>; Sun, 16 Aug 2020 01:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgHOXWb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Aug 2020 19:22:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgHOXWa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 15 Aug 2020 19:22:30 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 739D82065C;
        Sat, 15 Aug 2020 23:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597533749;
        bh=SB9wxVHgt3m7T/tEhx/Oa+YJt9VN49b1ddeU7NMOvEk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aVN9qcq6cqmxvD4IsLLewly56VryrzoOr3d3eGSPE1tXpVvGPQOKs97rPBlll36uG
         7bM0cxwtJTA4bjf/rGTjcr8A0Xrcoy9KS/l92ag5S/On003FKZrPumPtta4UJtBrD7
         ghyyujWRbGVHMF1kSphFqAtvcGhXkHRpnPPnx+L8=
Date:   Sat, 15 Aug 2020 18:22:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Roh Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com
Subject: Re: [PATCH 1/2] PCI: rockchip: Work around missing device_type
 property in DT
Message-ID: <20200815232228.GA1325245@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815125112.462652-2-maz@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 15, 2020 at 01:51:11PM +0100, Marc Zyngier wrote:
> Recent changes to the DT PCI bus parsing made it mandatory for
> device tree nodes describing a PCI controller to have the
> 'device_type = "pci"' property for the node to be matched.
> 
> Although this follows the letter of the specification, it
> breaks existing device-trees that have been working fine
> for years.  Rockchip rk3399-based systems are a prime example
> of such collateral damage, and have stopped discovering their
> PCI bus.
> 
> In order to paper over the blunder, let's add a workaround
> to the pcie-rockchip driver, adding the missing property when
> none is found at boot time. A warning will hopefully nudge the
> user into updating their DT to a fixed version if they can, but
> the insentive is obviously pretty small.

s/insentive/incentive/ (Lorenzo or I can fix this up)

> Fixes: 2f96593ecc37 ("of_address: Add bus type match for pci ranges parser")
> Suggested-by: Roh Herring <robh+dt@kernel.org>

s/Roh/Rob/ (similarly)

> Signed-off-by: Marc Zyngier <maz@kernel.org>

This looks like a candidate for v5.9, since 2f96593ecc37 was merged
during the v5.9 merge window, right?

I wonder how many other DTs are similarly broken?  Maybe Rob's DT
checker has already looked?

> ---
>  drivers/pci/controller/pcie-rockchip-host.c | 29 +++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index 0bb2fb3e8a0b..d7dd04430a99 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -949,6 +949,35 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	if (!dev->of_node)
>  		return -ENODEV;
>  
> +	/*
> +	 * Most rk3399 DTs are missing the 'device_type = "pci"' property,
> +	 * potentially leading to PCIe probing failure. Be kind to the
> +	 * users and fix it up for them. Upgrading is recommended.
> +	 */
> +	if (!of_find_property(dev->of_node, "device_type", NULL)) {
> +		const char dtype[] = "pci";
> +		struct property *prop;
> +
> +		dev_warn(dev, "Working around missing device_type property\n");
> +
> +		prop = kzalloc(sizeof(*prop), GFP_KERNEL);
> +		if (!prop)
> +			return -ENOMEM;
> +
> +		prop->name	= kstrdup("device_type", GFP_KERNEL);
> +		prop->value	= kstrdup(dtype, GFP_KERNEL);
> +		prop->length	= ARRAY_SIZE(dtype);
> +		if (!prop->name || !prop->value) {
> +			kfree(prop->name);
> +			kfree(prop->value);
> +			kfree(prop);
> +			return -ENOMEM;
> +		}
> +
> +		if (of_add_property(dev->of_node, prop))
> +			dev_warn(dev, "Failed to add property, probing may fail");
> +	}
> +
>  	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rockchip));
>  	if (!bridge)
>  		return -ENOMEM;
> -- 
> 2.27.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
