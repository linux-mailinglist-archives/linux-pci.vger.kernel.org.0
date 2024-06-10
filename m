Return-Path: <linux-pci+bounces-8557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE59D9029A9
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 22:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64406281C0E
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 20:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEA814D70A;
	Mon, 10 Jun 2024 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGGUwV6w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B64B65E;
	Mon, 10 Jun 2024 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718049876; cv=none; b=nRGeci4M4xrtJAF3mxfkDXFBhR67tiRYSoerwrOavHmRHtpCbs35ioDCjjh7KSt3KpkHnPJjfM9vropQmWHf0SSUBaeUWSKk61shsBejigfqXGBmYNypcP+cQdvvHsZtqZWAHGjAdsCbZE/5wXSYgfimM7v46BVFtU9Z4r6xcR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718049876; c=relaxed/simple;
	bh=AxmMtKgOguwKMibo2q1t63b0ArwV5cabYSTSkrpTae0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=X6+b5XXXv6ol+TMuUugWcbVVy/hAtv0dniF3YOXJEoLgek0DBrOsrW3mbl9AN8aDnRWGlVnbffBJs2DK9F5dfk2BVgW0B3WvDr33aI9D5sO/Dm7yaSf5RtACfZs/+RNwxf0rbXUtSEsubljWhdIoWpZ4KTGufh0Y+YRS8itOq0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGGUwV6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104A2C2BBFC;
	Mon, 10 Jun 2024 20:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718049876;
	bh=AxmMtKgOguwKMibo2q1t63b0ArwV5cabYSTSkrpTae0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oGGUwV6wlkuuMXhIelwruH+R2JTmUX0ySl17ItKcvME4jvsDYbRhLLPL1CBRUnOBp
	 vAMvtnQX4E0vE4xkvhRAwCEWeabV/71uwMukQeaXkHJdl3hJihemaHM9B15C6yjTEN
	 RakU9bvu1yn5EiZAngSPVx7ABsrbQLE7WN3ZUrd6XQ00SUBsISVrcn0lBu23aMExKq
	 sNMGnLCXM8uHLvhUqHSv1Ugl+hoyfRSBN2+6OiGldRUe5nH++0G4Bl1GkajkImJDZ+
	 1YFePPaZA6Nwal0sfsZGqafwxe5pnbrlhQ/KSkBvqeGMOMOWMwcNItWUFvhI6sy5vY
	 UXjkIBL1wsgnA==
Date: Mon, 10 Jun 2024 15:04:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev
Subject: Re: [PATCH] PCI: switchtec: make switchtec_class constant
Message-ID: <20240610200434.GA958238@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061053-online-unwound-b173@gregkh>

On Mon, Jun 10, 2024 at 10:20:53AM +0200, Greg Kroah-Hartman wrote:
> Now that the driver core allows for struct class to be in read-only
> memory, we should make all 'class' structures declared at build time
> placing them into read-only memory, instead of having to be dynamically
> allocated at runtime.
> 
> Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <allenbh@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: ntb@lists.linux.dev
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied with reviewed-by from Dave and Logan to pci/switchtec for
v6.11, thanks!

> ---
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c |  2 +-
>  drivers/pci/switch/switchtec.c         | 16 ++++++++--------
>  include/linux/switchtec.h              |  2 +-
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> index d6bbcc7b5b90..31946387badf 100644
> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> @@ -1565,7 +1565,7 @@ static struct class_interface switchtec_interface  = {
>  
>  static int __init switchtec_ntb_init(void)
>  {
> -	switchtec_interface.class = switchtec_class;
> +	switchtec_interface.class = &switchtec_class;
>  	return class_interface_register(&switchtec_interface);
>  }
>  module_init(switchtec_ntb_init);
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 5a4adf6c04cf..c7e1089ffdaf 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -37,7 +37,9 @@ MODULE_PARM_DESC(nirqs, "number of interrupts to allocate (more may be useful fo
>  static dev_t switchtec_devt;
>  static DEFINE_IDA(switchtec_minor_ida);
>  
> -struct class *switchtec_class;
> +const struct class switchtec_class = {
> +	.name = "switchtec",
> +};
>  EXPORT_SYMBOL_GPL(switchtec_class);
>  
>  enum mrpc_state {
> @@ -1363,7 +1365,7 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
>  
>  	dev = &stdev->dev;
>  	device_initialize(dev);
> -	dev->class = switchtec_class;
> +	dev->class = &switchtec_class;
>  	dev->parent = &pdev->dev;
>  	dev->groups = switchtec_device_groups;
>  	dev->release = stdev_release;
> @@ -1851,11 +1853,9 @@ static int __init switchtec_init(void)
>  	if (rc)
>  		return rc;
>  
> -	switchtec_class = class_create("switchtec");
> -	if (IS_ERR(switchtec_class)) {
> -		rc = PTR_ERR(switchtec_class);
> +	rc = class_register(&switchtec_class);
> +	if (rc)
>  		goto err_create_class;
> -	}
>  
>  	rc = pci_register_driver(&switchtec_pci_driver);
>  	if (rc)
> @@ -1866,7 +1866,7 @@ static int __init switchtec_init(void)
>  	return 0;
>  
>  err_pci_register:
> -	class_destroy(switchtec_class);
> +	class_unregister(&switchtec_class);
>  
>  err_create_class:
>  	unregister_chrdev_region(switchtec_devt, max_devices);
> @@ -1878,7 +1878,7 @@ module_init(switchtec_init);
>  static void __exit switchtec_exit(void)
>  {
>  	pci_unregister_driver(&switchtec_pci_driver);
> -	class_destroy(switchtec_class);
> +	class_unregister(&switchtec_class);
>  	unregister_chrdev_region(switchtec_devt, max_devices);
>  	ida_destroy(&switchtec_minor_ida);
>  
> diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
> index 8d8fac1626bd..cdb58d61c152 100644
> --- a/include/linux/switchtec.h
> +++ b/include/linux/switchtec.h
> @@ -521,6 +521,6 @@ static inline struct switchtec_dev *to_stdev(struct device *dev)
>  	return container_of(dev, struct switchtec_dev, dev);
>  }
>  
> -extern struct class *switchtec_class;
> +extern const struct class switchtec_class;
>  
>  #endif
> -- 
> 2.45.2
> 

