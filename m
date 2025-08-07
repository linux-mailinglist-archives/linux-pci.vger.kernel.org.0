Return-Path: <linux-pci+bounces-33593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4438CB1DF73
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 00:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBDE218C70D1
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 22:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0866220696;
	Thu,  7 Aug 2025 22:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8tMGNh1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BFC1E520E;
	Thu,  7 Aug 2025 22:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754606952; cv=none; b=ZTaBz3BymrjAz+z5ArKzbgUG3TsaGYn7C18VyuIBNP8y6XN6I1orSKbVuxRxUq3kDagnnlT3Y+jt6QQpbSDhItpWS5jCLkW9pWVMK9rEKxYly4LOxEll5MC/l2NON9GvD4ROwy4770/bxwza13ZoeXEkTUWmO4cY6oMFlDNkPZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754606952; c=relaxed/simple;
	bh=ct9wP1hAXhHSS7zT1f1XYryEJu/IvFRqbmyxNBbRnFM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ciYLDLW6yABVhyyDS+gJY1kbBirB1po7hs8QbIP6i8vTP8IjFS460KwKNqvOvx1t5GFrshviXL5h/5oz6Chrics12onfPgPnfIG7YEuyGztKEILaJ/jaT4GX/uzohhoo1vxYGQ3OaXdJcVwA83V9iafUidCqVjLqAmtL3KnVRvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8tMGNh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62495C4CEEB;
	Thu,  7 Aug 2025 22:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754606952;
	bh=ct9wP1hAXhHSS7zT1f1XYryEJu/IvFRqbmyxNBbRnFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=M8tMGNh1pbTUhX2erH8MrwVCeFfJlseNkNkv0qLXz37KfIfc+g36MZ4K74SyCQotG
	 GE1wUNeiRLHM6z9f0BkU5CNNQccnwUEDeMIn7FcgiJUQVs5sxBrQTh16Xq4DCTwU82
	 Yc5VslmbQ9Y7LYQijDPuY6dWGrxA0pimU+XBRm5oAZ20QUBh6vKTEkDI2dJDEcdpX9
	 1HWasmT10Ge2wj2CSD22CtRRTV4BW/zLiNHBc/TlfGHgsMedYMlP0vZWmxzjfvPs6c
	 P/jAYvsJ+WnQSXzcwpxvRXZcakf5zi6G9e7xWx0CAzMKV+zuZ+IuGNG+80yZoYhWkt
	 anPcYkgkBvUEg==
Date: Thu, 7 Aug 2025 17:49:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com, aik@amd.com,
	lukas@wunner.de
Subject: Re: [PATCH v4 09/10] PCI/TSM: Report active IDE streams
Message-ID: <20250807224911.GA66859@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717183358.1332417-10-dan.j.williams@intel.com>

On Thu, Jul 17, 2025 at 11:33:57AM -0700, Dan Williams wrote:
> Given that the platform TSM owns IDE Stream ID allocation, report the
> active streams via the TSM class device. Establish a symlink from the
> class device to the PCI endpoint device consuming the stream, named by
> the Stream ID.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  Documentation/ABI/testing/sysfs-class-tsm | 10 ++++++++
>  drivers/pci/ide.c                         |  4 ++++
>  drivers/virt/coco/tsm-core.c              | 28 +++++++++++++++++++++++
>  include/linux/pci-ide.h                   |  2 ++
>  include/linux/tsm.h                       |  4 ++++
>  5 files changed, 48 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
> index 2949468deaf7..6fc1a5ac6da1 100644
> --- a/Documentation/ABI/testing/sysfs-class-tsm
> +++ b/Documentation/ABI/testing/sysfs-class-tsm
> @@ -7,3 +7,13 @@ Description:
>  		signals when the PCI layer is able to support establishment of
>  		link encryption and other device-security features coordinated
>  		through a platform tsm.
> +
> +What:		/sys/class/tsm/tsmN/streamH.R.E
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		(RO) When a host bridge has established a secure connection via
> +		the platform TSM, symlink appears. The primary function of this
> +		is have a system global review of TSM resource consumption
> +		across host bridges. The link points to the endpoint PCI device
> +		and matches the same link published by the host bridge. See
> +		Documentation/ABI/testing/sysfs-devices-pci-host-bridge.
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index cafbc740a9da..923b0db4803c 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -5,6 +5,7 @@
>  
>  #define dev_fmt(fmt) "PCI/IDE: " fmt
>  #include <linux/pci.h>
> +#include <linux/tsm.h>
>  #include <linux/sysfs.h>
>  #include <linux/pci-ide.h>
>  #include <linux/bitfield.h>
> @@ -271,6 +272,9 @@ void pci_ide_stream_release(struct pci_ide *ide)
>  	if (ide->partner[PCI_IDE_EP].enable)
>  		pci_ide_stream_disable(pdev, ide);
>  
> +	if (ide->tsm_dev)
> +		tsm_ide_stream_unregister(ide);
> +
>  	if (ide->partner[PCI_IDE_RP].setup)
>  		pci_ide_stream_teardown(rp, ide);
>  
> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> index 093824dc68dd..b0ef9089e0f2 100644
> --- a/drivers/virt/coco/tsm-core.c
> +++ b/drivers/virt/coco/tsm-core.c
> @@ -2,14 +2,17 @@
>  /* Copyright(c) 2024 Intel Corporation. All rights reserved. */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#define dev_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/tsm.h>
>  #include <linux/idr.h>
> +#include <linux/pci.h>
>  #include <linux/rwsem.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/cleanup.h>
>  #include <linux/pci-tsm.h>
> +#include <linux/pci-ide.h>
>  
>  static struct class *tsm_class;
>  static DECLARE_RWSEM(tsm_rwsem);
> @@ -140,6 +143,31 @@ void tsm_unregister(struct tsm_dev *tsm_dev)
>  }
>  EXPORT_SYMBOL_GPL(tsm_unregister);
>  
> +/* must be invoked between tsm_register / tsm_unregister */
> +int tsm_ide_stream_register(struct pci_ide *ide)
> +{
> +	struct pci_dev *pdev = ide->pdev;
> +	struct pci_tsm *tsm = pdev->tsm;
> +	struct tsm_dev *tsm_dev = tsm->ops->owner;
> +	int rc;
> +
> +	rc = sysfs_create_link(&tsm_dev->dev.kobj, &pdev->dev.kobj,
> +				 ide->name);
> +	if (rc == 0)
> +		ide->tsm_dev = tsm_dev;
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(tsm_ide_stream_register);
> +
> +void tsm_ide_stream_unregister(struct pci_ide *ide)
> +{
> +	struct tsm_dev *tsm_dev = ide->tsm_dev;
> +
> +	sysfs_remove_link(&tsm_dev->dev.kobj, ide->name);
> +	ide->tsm_dev = NULL;
> +}
> +EXPORT_SYMBOL_GPL(tsm_ide_stream_unregister);
> +
>  static void tsm_release(struct device *dev)
>  {
>  	struct tsm_dev *tsm_dev = container_of(dev, typeof(*tsm_dev), dev);
> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> index 89c1ef0de841..36290bdaf51f 100644
> --- a/include/linux/pci-ide.h
> +++ b/include/linux/pci-ide.h
> @@ -42,6 +42,7 @@ struct pci_ide_partner {
>   * @host_bridge_stream: track platform Stream ID
>   * @stream_id: unique Stream ID (within Partner Port pairing)
>   * @name: name of the established Selective IDE Stream in sysfs
> + * @tsm_dev: For TSM established IDE, the TSM device context
>   *
>   * Negative @stream_id values indicate "uninitialized" on the
>   * expectation that with TSM established IDE the TSM owns the stream_id
> @@ -53,6 +54,7 @@ struct pci_ide {
>  	u8 host_bridge_stream;
>  	int stream_id;
>  	const char *name;
> +	struct tsm_dev *tsm_dev;
>  };
>  
>  int pci_ide_domain(struct pci_dev *pdev);
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index ce95589a5d5b..4eba45a754ec 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -120,4 +120,8 @@ const char *tsm_name(const struct tsm_dev *tsm_dev);
>  struct tsm_dev *find_tsm_dev(int id);
>  const struct pci_tsm_ops *tsm_pci_ops(const struct tsm_dev *tsm_dev);
>  const struct attribute_group *tsm_pci_group(const struct tsm_dev *tsm_dev);
> +struct pci_dev;
> +struct pci_ide;
> +int tsm_ide_stream_register(struct pci_ide *ide);
> +void tsm_ide_stream_unregister(struct pci_ide *ide);
>  #endif /* __TSM_H */
> -- 
> 2.50.1
> 

