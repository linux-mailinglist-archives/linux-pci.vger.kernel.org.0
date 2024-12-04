Return-Path: <linux-pci+bounces-17703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9C89E46F8
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 22:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D3618801CD
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 21:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A82B192D8B;
	Wed,  4 Dec 2024 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaLa6SN8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B73A192D83;
	Wed,  4 Dec 2024 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733348307; cv=none; b=Ll9rLe1RVTpr8zV3UnaaVaBjGwU2xoWsv2SVy1Vd0yI3JLvKPe6dsYNujdKnM9z7xqr3dBTgW9v7wGYmcGegEZmgdDeYBKseU4aNUodvxaMo3sYe4gZPT3ygr3y4YSMjVdPp3A1+8yeTebikIwc+tam4FK8i+rC/doP3Zo6IqtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733348307; c=relaxed/simple;
	bh=l7yTTVmUjjV/VqhMA+V6zq/8SizxCbJ3CpajJl/oHWU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=telj18vnG3E9wedUB3ev4URfqMArmropHB47mquHmjacfOS9ZFOzkx0jWM7FwqvIyOKjCVjvEJG/C3vNxR1wSmrVCq2AgIQSB+xDRY34PTaT0q35rJsVe8okFqB5b2srSsddOwA2J8OZOw6y90Lrsz03yHYQCwzhz8jjbkz6hMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaLa6SN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3FAC4CED1;
	Wed,  4 Dec 2024 21:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733348307;
	bh=l7yTTVmUjjV/VqhMA+V6zq/8SizxCbJ3CpajJl/oHWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DaLa6SN8BM+PWpWbnGgM/0/tA6qmf5zQSGmYTk7AUVcBGNBDoBy+gM5Js4eAUiQHL
	 P9Uumhwjzqj/Le/bOyXm1WPqjrGe0vDFv3i2W4Rov71hgR8R+qkoR63ur3eX4Z8GCr
	 BHp9uTH30RGNibOtI24PG4Kulnajp0w5Q8OZzSxhaUyuF3GsWG7DXKm70V13xLQ9S7
	 FzF6D9besA9lacQI/SZXJ1LUqa++mmoph5kRWV3MUw8SVYz+R31qH+ySWuhZvGewuZ
	 JD9XB5K0NUWrcKkgbzvlarO7SnfhzGIYyOCKEH0Fw9SY6nXmIhW89Td9tkUeCAzh5J
	 iURygTF4RlJnw==
Date: Wed, 4 Dec 2024 15:38:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 1/6] driver core: Introduce
 device_{add,remove}_of_node()
Message-ID: <20241204213825.GA3016970@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202131522.142268-2-herve.codina@bootlin.com>

[cc->to Greg, Rafael]

On Mon, Dec 02, 2024 at 02:15:13PM +0100, Herve Codina wrote:
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
>  drivers/base/core.c    | 52 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/device.h |  2 ++

I suppose this series would go via the PCI tree since the bulk of the
changes are there.  If so, I would look for an ack from the driver
core folks (Greg, Rafael).

>  2 files changed, 54 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 8b056306f04e..3953c5ab7316 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -5216,6 +5216,58 @@ void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
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
> +{
> +	if (!of_node)
> +		return;
> +
> +	dev = get_device(dev);
> +	if (!dev)
> +		return;
> +
> +	if (WARN(dev->of_node, "%s: Cannot replace node %pOF with %pOF\n",
> +		 dev_name(dev), dev->of_node, of_node))
> +		goto end;
> +
> +	dev->of_node = of_node_get(of_node);
> +
> +	if (!dev->fwnode)
> +		dev->fwnode = of_fwnode_handle(of_node);
> +
> +end:
> +	put_device(dev);
> +}
> +EXPORT_SYMBOL_GPL(device_add_of_node);
> +
>  /**
>   * device_set_of_node_from_dev - reuse device-tree node of another device
>   * @dev: device whose device-tree node is being set
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 667cb6db9019..ef4c0f3c41cd 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1149,6 +1149,8 @@ int device_online(struct device *dev);
>  void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
>  void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
>  void device_set_node(struct device *dev, struct fwnode_handle *fwnode);
> +void device_add_of_node(struct device *dev, struct device_node *of_node);
> +void device_remove_of_node(struct device *dev);
>  void device_set_of_node_from_dev(struct device *dev, const struct device *dev2);
>  
>  static inline struct device_node *dev_of_node(struct device *dev)
> -- 
> 2.47.0
> 

