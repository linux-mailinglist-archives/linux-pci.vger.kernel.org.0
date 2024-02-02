Return-Path: <linux-pci+bounces-2969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 937FD84662A
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 03:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5072928F2AD
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 02:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CA6BA4C;
	Fri,  2 Feb 2024 02:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sC+1NFyp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA02E56D;
	Fri,  2 Feb 2024 02:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706842762; cv=none; b=GehGN/wLRdd/tB3GmdiPpsOIaAHjlN4Aic7lw2pYW+kSiOQil4ZQMY44rv2GyLDz3RV/wrEJpi/3xkN8g78kOuQGK+tJC1cFevpH5KykmmH2A4Ld5L5o3gAcHqeyMEHI3Vh3me4ZdMRW6AGXvEu6gf7DjQSR9vv3vcRk4RDI2Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706842762; c=relaxed/simple;
	bh=r+SvB9zLGCJWcQpfU6TkqIBEDh5OyZdXwt12sASYJsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSWwUvo/P82UUKAACqfA9tpg5oJCBxEE55kjOjXj9qAgsD7SXKvCKZt/R+vTlG3A9JmdV1yPAi0pX9fRIvHFGeRqvTeqXqOo+DhJ0Ib4B2P50vXp3+WGIcT2Yhjp25dIE5LI3/QoiWPHMSc0WHVY2+YGeb3Trqu8kVryMjFnrug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sC+1NFyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D387C433C7;
	Fri,  2 Feb 2024 02:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706842761;
	bh=r+SvB9zLGCJWcQpfU6TkqIBEDh5OyZdXwt12sASYJsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sC+1NFypNfxuFBEhWIbnU8IRj9MaBq/uUm+ma3F4l7JIWq9z5VS4/4a8GOX+KyCDg
	 8+ZaI2eUJnh81vL3qdRrh7lh/Cvgf7OyTOBVZ7by+sjZ+raxykejfcb67QeO9Ym0Wn
	 edY3kWWKi/6WmtZJJ5JtOqAkQkAQCSXeGArYIdJP3hVBpmrW2P4mGsEM4oDrYGyqE9
	 jgDOIRVHrI93PvE21HBfzBj8fl+BxOoItaSf/Pj8CFkxlpd4jf6cYmk8iV8G+zGIVQ
	 CEtxelvPpoMi+SOqRKGaoNN/jgqwhh9GW+oMQ9XyZyBiEjNRswGZgpdyVnfBmm4cc5
	 hkoPR2kKyI36A==
Date: Thu, 1 Feb 2024 20:59:18 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pci@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC 6/9] PCI: create platform devices for child OF nodes of the
 port node
Message-ID: <4epbzsmxj2gfvjcufclfw7vnamr6hyeickrbyakibdtubwnefs@lkyt7mth43nq>
References: <20240201155532.49707-1-brgl@bgdev.pl>
 <20240201155532.49707-7-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201155532.49707-7-brgl@bgdev.pl>

On Thu, Feb 01, 2024 at 04:55:29PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> In order to introduce PCI power-sequencing,

Please provide a proper problem description.

> we need to create platform

And properly express why this is a "need".

> devices for child nodes of the port node. They will get matched against
> the pwrseq drivers

That's not what happens in your code, the child nodes of the bridge node
in DeviceTree will match against arbitrary platform_drivers.

I also would like this commit message to express that the job of the
matched device is to:

1) power up said device, followed by triggering a scan on the parent PCI
bus during it's probe function.

2)  power down said device, during its remove function.

> (if one exists) and then the actual PCI device will
> reuse the node once it's detected on the bus.

I think the "reuse" deserves to be clarified as there will be both a pci
and a platform device associated with the same of_node.

> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/pci/bus.c    | 9 ++++++++-
>  drivers/pci/remove.c | 2 ++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 826b5016a101..17ab41094c4e 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -12,6 +12,7 @@
>  #include <linux/errno.h>
>  #include <linux/ioport.h>
>  #include <linux/of.h>
> +#include <linux/of_platform.h>
>  #include <linux/proc_fs.h>
>  #include <linux/slab.h>
>  
> @@ -342,8 +343,14 @@ void pci_bus_add_device(struct pci_dev *dev)
>  	 */
>  	pcibios_bus_add_device(dev);
>  	pci_fixup_device(pci_fixup_final, dev);
> -	if (pci_is_bridge(dev))
> +	if (pci_is_bridge(dev)) {
>  		of_pci_make_dev_node(dev);
> +		retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
> +					      &dev->dev);

I'm not familiar enough with the ins and outs of the PCI code. Can you
confirm that there are no problems with this (possibly) calling
pci_rescan_bus() before the bridge device is fully initialized below?

Regards,
Bjorn

> +		if (retval)
> +			pci_err(dev, "failed to populate child OF nodes (%d)\n",
> +				retval);
> +	}
>  	pci_create_sysfs_dev_files(dev);
>  	pci_proc_attach_device(dev);
>  	pci_bridge_d3_update(dev);
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index d749ea8250d6..fc9db2805888 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/pci.h>
>  #include <linux/module.h>
> +#include <linux/of_platform.h>
>  #include "pci.h"
>  
>  static void pci_free_resources(struct pci_dev *dev)
> @@ -22,6 +23,7 @@ static void pci_stop_dev(struct pci_dev *dev)
>  		device_release_driver(&dev->dev);
>  		pci_proc_detach_device(dev);
>  		pci_remove_sysfs_dev_files(dev);
> +		of_platform_depopulate(&dev->dev);
>  		of_pci_remove_node(dev);
>  
>  		pci_dev_assign_added(dev, false);
> -- 
> 2.40.1
> 

