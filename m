Return-Path: <linux-pci+bounces-16658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFA49C7374
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 15:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FCF91F24CCD
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 14:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EF11DEFF5;
	Wed, 13 Nov 2024 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lHgPtiMb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C668743172;
	Wed, 13 Nov 2024 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507894; cv=none; b=op0TcBilk+UIfuykxx8bzJAjl6jnWzF4UnTgZe0dh8784x3KMQWI/wn+WCjfWnAG3sFBZGu0yhcP6efJm8ePlGUdP4PZpUjMIDS7oGUsFIqCI057TOIYFtqLvfMdQ2pahrO0pog/Eixkew/HIF+93ZdtWKAzKUDRlLuf6x7+xwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507894; c=relaxed/simple;
	bh=w3KA42vZqZnTiGziMk7b/yRyjsLnkFIFQiy2JpfoeKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3+G6sLKg8Vw2qqobFp6yBwRZLdeae1JxyLF3KmfuAdlkTmzWydMz6ovp9ngutJOp0RM5FGCEpKwU22hYPP9goXZ2AfMiVEY9XEgFLS/5N8DVLfGyVrsBQpGb3UZbthPwvOKLLoxqqRnApdD2H01gfTd+CDAVMC0GqnTJ/iMP0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lHgPtiMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C09C4CEC3;
	Wed, 13 Nov 2024 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731507893;
	bh=w3KA42vZqZnTiGziMk7b/yRyjsLnkFIFQiy2JpfoeKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lHgPtiMbHRVWSqvsp+o6JF3Ks1lyQBMcJu61L4muW6tpaAJaU8Dp4/rg4eIqhipxG
	 Oxh21Zt/B86ukCYl8bekJIFaBOhNOUr0fYaOiTV71YJkpN43f+YzTruUGRG3olbDY1
	 vI4+ydqP9Bd2MJ0r4bnFPrEwEPFdrGAR1dE6gDCg=
Date: Wed, 13 Nov 2024 15:24:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Daniel Wagner <dwagner@suse.de>, Daniel Wagner <wagi@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 1/8] driver core: bus: add irq_get_affinity callback
 to bus_type
Message-ID: <2024111328-cheer-mutate-3ee2@gregkh>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
 <20241112-refactor-blk-affinity-helpers-v3-1-573bfca0cbd8@kernel.org>
 <76da6c05-4f28-41cc-a48e-da2ae16c64c4@oracle.com>
 <2d85aa5e-037a-45c3-9f2d-e46b2159b697@flourine.local>
 <bed15207-c3d8-4e0b-b356-4880f5a4fdff@oracle.com>
 <2024111323-darkening-sappy-23fa@gregkh>
 <5ed6e072-5ff1-4327-aee1-e6cdf673fa67@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ed6e072-5ff1-4327-aee1-e6cdf673fa67@oracle.com>

On Wed, Nov 13, 2024 at 02:12:30PM +0000, John Garry wrote:
> On 13/11/2024 13:54, Greg Kroah-Hartman wrote:
> > > diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> > > b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> > > index 342d75f12051..5172af77a3f0 100644
> > > --- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> > > +++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> > > @@ -3636,6 +3636,7 @@ static struct platform_driver hisi_sas_v2_driver = {
> > >                 .name = DRV_NAME,
> > >                 .of_match_table = sas_v2_of_match,
> > >                 .acpi_match_table = ACPI_PTR(sas_v2_acpi_match),
> > > +               .irq_get_affinity_mask = hisi_sas_v2_get_affinity_mask,
> > >         },
> > > };
> > > 
> > > 
> > > > If no one objects, I go ahead and add the callback to struct
> > > > device_driver.
> > > I'd wait for Christoph and Greg to both agree. I was just wondering why we
> > > use bus_type.
> > bus types are good to set it at a bus level so you don't have to
> > explicitly set it at each-and-every-driver.  Depends on what you want
> > this to be, if it is a "all drivers of this bus type will have the same
> > callback" then put it on the bus.  otherwise if you are going to
> > mix/match on a same bus, then put it in the driver structure.
> 
> Understood, I think all drivers on same bus will use the same callback.
> 
> FWIW, most drivers of interest are pci drivers, so I thought that it would
> simply be a change like this (for those drivers if we use struct
> device_driver):
> 
> @@ -1442,6 +1455,7 @@ int __pci_register_driver(struct pci_driver
> *drv, struct module *owner,
>        drv->driver.mod_name = mod_name;
>        drv->driver.groups = drv->groups;
>        drv->driver.dev_groups = drv->dev_groups;
> +       drv->driver.irq_get_affinity = pci_device_irq_get_affinity;

Yes, you can do that too.  But now you have a pointer-per-driver instead
of just one-per-bus.  It's not a big deal, but again if this is always
going to be the same for everything on a bus, make it a bus pointer
please.

thanks,

greg k-h

