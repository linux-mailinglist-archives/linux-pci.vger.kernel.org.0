Return-Path: <linux-pci+bounces-21809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5795EA3C44D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 16:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA8A188C3FE
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 15:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5989F1F8F09;
	Wed, 19 Feb 2025 15:59:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDED192580;
	Wed, 19 Feb 2025 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980755; cv=none; b=ehT5i3W9bHQtkd+hvVSPnNzRsv4G0LsQaKnHYAeTIvM+OPoKgcIJX8hYzsebbhYQfwRdKJepmKmHj955VyFznTFqqfRe1dDM5hNhNs+VxV72WvDOAKqlMs05dF9se85Y3JSpNm232st3Ut0bBckd/QYWXXaTpUVyvoZz0kBUPrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980755; c=relaxed/simple;
	bh=PGJydsIQuR3b30jEX9zs6NTl+06JSoqWi7rQevLCPbQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I22Qd96v1lfVIm3qxLKsmMcrw0vgZlsp2dGiTt8fn8N97GiNwKX+JZrqQILeTQQvVHsNLTr3Bz2BhUnkOcgx3r0j5amqPOm3DvyH3NK8zrHEvooXkeWI4gut7VWWSfYRXSZ4bkSRgl/bb4Ht0hFh+kw5BnHckkJ5Xm4HckJIM3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YygyJ0q6Zz6GDC2;
	Wed, 19 Feb 2025 23:57:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 07682140AB8;
	Wed, 19 Feb 2025 23:59:04 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 19 Feb
 2025 16:59:03 +0100
Date: Wed, 19 Feb 2025 15:59:01 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Herve Codina <herve.codina@bootlin.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Rob Herring
	<robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
	<steen.hegelund@microchip.com>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 1/5] driver core: Introduce
 device_{add,remove}_of_node()
Message-ID: <20250219155901.000009e4@huawei.com>
In-Reply-To: <20250204073501.278248-2-herve.codina@bootlin.com>
References: <20250204073501.278248-1-herve.codina@bootlin.com>
	<20250204073501.278248-2-herve.codina@bootlin.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue,  4 Feb 2025 08:34:56 +0100
Herve Codina <herve.codina@bootlin.com> wrote:

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
A few passing comments. Not suggestions to actually change anything
at this stage though. Maybe a potential follow up if you think it's
a good idea.

> ---
>  drivers/base/core.c    | 61 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/device.h |  2 ++
>  2 files changed, 63 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 5a1f05198114..d1b044af64de 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -5170,6 +5170,67 @@ void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
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
Maybe use
	struct device *d __free(put_device) = get_device(dev);

	if (!d->of_node);
		return;

Not a reason to respin though!


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
> + *
> + * Return: 0 on success or error code on failure.
> + */
> +int device_add_of_node(struct device *dev, struct device_node *of_node)
> +{
> +	int ret;
> +
> +	if (!of_node)
> +		return -EINVAL;
> +
> +	dev = get_device(dev);

Likewise could use __free() magic here as well for slight simpliciations.

> +	if (!dev)
> +		return -EINVAL;
> +
> +	if (dev->of_node) {
> +		dev_err(dev, "Cannot replace node %pOF with %pOF\n",
> +			dev->of_node, of_node);
> +		ret = -EBUSY;
> +		goto end;
> +	}
> +
> +	dev->of_node = of_node_get(of_node);
> +
> +	if (!dev->fwnode)
> +		dev->fwnode = of_fwnode_handle(of_node);
> +
> +	ret = 0;
> +end:
> +	put_device(dev);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(device_add_of_node);
> +
>  /**
>   * device_set_of_node_from_dev - reuse device-tree node of another device
>   * @dev: device whose device-tree node is being set
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 80a5b3268986..1244e5892292 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1191,6 +1191,8 @@ int device_online(struct device *dev);
>  void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
>  void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
>  void device_set_node(struct device *dev, struct fwnode_handle *fwnode);
> +int device_add_of_node(struct device *dev, struct device_node *of_node);
> +void device_remove_of_node(struct device *dev);
>  void device_set_of_node_from_dev(struct device *dev, const struct device *dev2);
>  
>  static inline struct device_node *dev_of_node(struct device *dev)


