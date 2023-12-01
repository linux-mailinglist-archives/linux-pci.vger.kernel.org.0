Return-Path: <linux-pci+bounces-372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 567338016DE
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 23:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC0D1F2108A
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 22:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98E838DD2;
	Fri,  1 Dec 2023 22:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvKxojd9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B5B619D4;
	Fri,  1 Dec 2023 22:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FABC433C7;
	Fri,  1 Dec 2023 22:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701470970;
	bh=7UHBRH5A/rAUW8O3WYeKaOaOXX0+pl8vP8IIGkcTjO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UvKxojd96ybvz4wCT9QMbUD7BYFKOW7L32k1cM25SmfLk6GBxSewQ5EydhsMm94us
	 rygz+JfUakNQhTBUUoZVdDPJZbLsJOmsHmZcxkfXI74F+u5hHmYqcOFdSgYh+A3x59
	 jkiHiPltMgj7x0VouBYtCgsE2dAgWul/msywmd8AhKr2goC5+57p0FTwkJfxIclrgU
	 YP/WqlHhVtbEvhtLIJwTT0oAaL/v1k0YU0Vty1JTCYD1U6z+HOZzPcBat3lC0hGqGe
	 Dey12bQ/+2mx2mUkRM4vY28KyXA1OpnRC9gHm2DBWfkJHK9GUMU6ggiR549HbVmcXk
	 bu0iD+ZH2Vf5Q==
Date: Fri, 1 Dec 2023 16:49:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
	Rob Herring <robh@kernel.org>, Max Zhen <max.zhen@amd.com>,
	Sonal Santan <sonal.santan@amd.com>,
	Stefano Stabellini <stefano.stabellini@xilinx.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: of: Attach created of_node to existing device
Message-ID: <20231201224928.GA534494@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130165700.685764-3-herve.codina@bootlin.com>

On Thu, Nov 30, 2023 at 05:56:59PM +0100, Herve Codina wrote:
> The commit 407d1a51921e ("PCI: Create device tree node for bridge")
> creates of_node for PCI devices.
> During the insertion handling of these new DT nodes done by of_platform,
> new devices (struct device) are created.
> For each PCI devices a struct device is already present (created and
> handled by the PCI core).
> Having a second struct device to represent the exact same PCI device is
> not correct.

Can you rewrap this or, if you intend multiple paragraphs, add blank
lines between them?

> On the of_node creation, tell the of_platform that there is no need to
> create a device for this node (OF_POPULATED flag), link this newly
> created of_node to the already present device and tell fwnode that the
> device attached to this of_node is ready (fwnode_dev_initialized()).
> 
> With this fix, the of_node are available in the sysfs device tree:
> /sys/devices/platform/soc/d0070000.pcie/
> + of_node -> .../devicetree/base/soc/pcie@d0070000
> + pci0000:00
>   + 0000:00:00.0
>     + of_node -> .../devicetree/base/soc/pcie@d0070000/pci@0,0
>     + 0000:01:00.0
>       + of_node -> .../devicetree/base/soc/pcie@d0070000/pci@0,0/dev@0,0
> 
> On the of_node removal, revert the operations.
> 
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/pci/of.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 51e3dd0ea5ab..5afd2731e876 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -615,7 +615,8 @@ void of_pci_remove_node(struct pci_dev *pdev)
>  	np = pci_device_to_OF_node(pdev);
>  	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
>  		return;
> -	pdev->dev.of_node = NULL;
> +
> +	device_remove_of_node(&pdev->dev);
>  
>  	of_changeset_revert(np->data);
>  	of_changeset_destroy(np->data);
> @@ -668,12 +669,22 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>  	if (ret)
>  		goto out_free_node;
>  
> +	/*
> +	 * This of_node will be added to an existing device.
> +	 * Avoid any device creation and use the existing device
> +	 */
> +	of_node_set_flag(np, OF_POPULATED);
> +	np->fwnode.dev = &pdev->dev;
> +	fwnode_dev_initialized(&np->fwnode, true);
> +
>  	ret = of_changeset_apply(cset);
>  	if (ret)
>  		goto out_free_node;
>  
>  	np->data = cset;
> -	pdev->dev.of_node = np;
> +
> +	/* Add the of_node to the existing device */
> +	device_add_of_node(&pdev->dev, np);
>  	kfree(name);
>  
>  	return;
> -- 
> 2.42.0
> 

