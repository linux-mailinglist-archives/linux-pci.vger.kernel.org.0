Return-Path: <linux-pci+bounces-18992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D589FBA7F
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 09:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB26163BED
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 08:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1090E18C924;
	Tue, 24 Dec 2024 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NYfRbolB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D059914A099;
	Tue, 24 Dec 2024 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735028997; cv=none; b=QElYAsSNzqdLhfVnQqv7FLsp7q95awINp5IssIkdTllcIMNB1GZNHgTg1qM2nQo+iAQicgwBWpXMRKqxjcPsIM6O+NIGz1lfH5GfqWysRXd02QNnCx+9q5gaKfxFrA7nAVFvs/fPLQV9Vu1X2TBzEV6Z6nytQxgzdc5Cp2NKYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735028997; c=relaxed/simple;
	bh=/GM5ZUvhitEGZ3IJv96w96QpZukeSQNGr4bt6cew8xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxEPq8n+ytBSsvSgEqUt2vbgjld7inI3LEG2skJPVUi+W0RhBSgHVu1vZh1fLAm3EkDXWGsi3hz16S1JPcIOZDg9rFMovMYC4dBzyn+U+UVF0jXatOE4cjbWbgOk73wIlnDjtaHm5tQe26Yoi2KMBiUuB7VRSNhZ2dqzuX3JDqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NYfRbolB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A20C4CED0;
	Tue, 24 Dec 2024 08:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735028996;
	bh=/GM5ZUvhitEGZ3IJv96w96QpZukeSQNGr4bt6cew8xU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NYfRbolBZwx1aMcMjqSgSFSwsNuJqdyr6HkSKeMnG0NWh5qidrMmdfSj7gQW7NCdV
	 ntOXnjnl1lUaEdGxrOBMP/P/mVw4dd7Ok23KC5kNpYKSc96zSvUHE5nelQSp4Ez8d6
	 Eh4PM4QsCAOtEAMcB8okikBKabg8GYxFRR43ZMN4=
Date: Tue, 24 Dec 2024 09:29:47 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 1/5] driver core: Introduce
 device_{add,remove}_of_node()
Message-ID: <2024122459-only-catchy-9f13@gregkh>
References: <20241209130339.81354-1-herve.codina@bootlin.com>
 <20241209130339.81354-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209130339.81354-2-herve.codina@bootlin.com>

On Mon, Dec 09, 2024 at 02:03:33PM +0100, Herve Codina wrote:
> An of_node can be set to a device using device_set_node().
> This function cannot prevent any of_node and/or fwnode overwrites.
> 
> When adding an of_node on an already present device, the following
> operations need to be done:
> - Attach the of_node if no of_node were already attached
> - Attach the of_node as a fwnode if no fwnode were already attached
> 
> This is the purpose of device_add_of_node().
> device_remove_of_node() reverts the operations done by
> device_add_of_node().
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/base/core.c    | 54 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/device.h |  2 ++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 8b056306f04e..81e5465aa746 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -5216,6 +5216,60 @@ void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
>  }
>  EXPORT_SYMBOL_GPL(set_secondary_fwnode);
>  
> +/**
> + * device_remove_of_node - Remove an of_node from a device
> + * @dev: device whose device-tree node is being removed
> + */
> +void device_remove_of_node(struct device *dev)
> +{
> +	dev = get_device(dev);
> +	if (!dev)
> +		return;
> +
> +	if (!dev->of_node)
> +		goto end;
> +
> +	if (dev->fwnode == of_fwnode_handle(dev->of_node))
> +		dev->fwnode = NULL;
> +
> +	of_node_put(dev->of_node);
> +	dev->of_node = NULL;
> +
> +end:
> +	put_device(dev);
> +}
> +EXPORT_SYMBOL_GPL(device_remove_of_node);
> +
> +/**
> + * device_add_of_node - Add an of_node to an existing device
> + * @dev: device whose device-tree node is being added
> + * @of_node: of_node to add
> + */
> +void device_add_of_node(struct device *dev, struct device_node *of_node)

Why is this void?

> +{
> +	if (!of_node)
> +		return;
> +
> +	dev = get_device(dev);
> +	if (!dev)
> +		return;
> +
> +	if (dev->of_node) {
> +		dev_warn(dev, "Cannot replace node %pOF with %pOF\n",
> +			 dev->of_node, of_node);

Why not return an error too?  Otherwise you can never know if this
worked or not.

thanks,

greg k-h

