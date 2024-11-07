Return-Path: <linux-pci+bounces-16258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9939C0A87
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 16:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E862835C3
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBEA2144C7;
	Thu,  7 Nov 2024 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FX3snTDu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986E71F130F
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994989; cv=none; b=QQeuHqh17qcmeD0XvoFOMlHuCWHHEwATw81p97FZ9krb+jEA4hi50SCc5uby+MxzzqD+ngFamiYyvbvGxEJ6ylNF5JDnjm2pKlwwTVzwPUiX1HgJ220Ra7iVFtMnkxsdpHzh1b6XTCN6cYLzeKxUHqe1egi9RB9EzOSTqKcnNwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994989; c=relaxed/simple;
	bh=RkkfI5UO2nTSAXfhoL5HO5B1/RvsgR1jSCcyQrhSgSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDNPfe02lfO/E/xZJJd9uNQH8y7OTcYeFUZE8m5mkQ4ZjtKG1lHKrRF8XNhvjczoIMiuILIgrlq8zN14UTOr+WuT7+g4ch7g+7TBMxDfHXiUSJCCpxb9gEAmb8RbiOrq8+WcX/IDVw/hP6OCAtX3qRx6k27vUznMGzmRzdWHucY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FX3snTDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6F1C4CECD;
	Thu,  7 Nov 2024 15:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730994989;
	bh=RkkfI5UO2nTSAXfhoL5HO5B1/RvsgR1jSCcyQrhSgSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FX3snTDudaOv+7R5uAzNjJrKKsJ4aqPxTxBfHHn4kdrNz0hz2poKRvJTBiNr5JHfZ
	 ++Sm7L3O7Cl/LitHREM9ahj98AeOstGfSqLrtVF4OIW6bxEKNLnxugB9RaQ5W9ZDLt
	 hjoQdB7h1DrHwm74/o9njG/Uwwq0RWWTtSEV3I/IJCRoGvGnsoIbpqoSOcrzc24xAJ
	 jGGrrq5HuO0ecAYFZH4x3xBNRAF8XBJDn1vkAY3oLr/yhTPt6q7Djw3VRRu+jfbTkx
	 eIq3T65yY9PmvmkUIwuwSjj1D1LxXQRcuQvI8F64MtvJ+II5AIHtKv1ghPtRa0wQb+
	 mRe+gsR6kF6MA==
Date: Thu, 7 Nov 2024 08:56:26 -0700
From: Keith Busch <kbusch@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCHv3 1/5] pci: make pci_stop_dev concurrent safe
Message-ID: <ZyzjKrNPxn5Vw7cF@kbusch-mbp>
References: <20241022224851.340648-1-kbusch@meta.com>
 <20241022224851.340648-2-kbusch@meta.com>
 <ZyzJgaEOJOKmh_xw@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyzJgaEOJOKmh_xw@wunner.de>

On Thu, Nov 07, 2024 at 03:06:57PM +0100, Lukas Wunner wrote:
> On Tue, Oct 22, 2024 at 03:48:47PM -0700, Keith Busch wrote:
> > --- a/drivers/pci/remove.c
> > +++ b/drivers/pci/remove.c
> > @@ -31,18 +31,16 @@ static int pci_pwrctl_unregister(struct device *dev, void *data)
> >  
> >  static void pci_stop_dev(struct pci_dev *dev)
> >  {
> > -	pci_pme_active(dev, false);
> > -
> > -	if (pci_dev_is_added(dev)) {
> > -		device_for_each_child(dev->dev.parent, dev_of_node(&dev->dev),
> > -				      pci_pwrctl_unregister);
> > -		device_release_driver(&dev->dev);
> > -		pci_proc_detach_device(dev);
> > -		pci_remove_sysfs_dev_files(dev);
> > -		of_pci_remove_node(dev);
> > +	if (!pci_dev_test_and_clear_added(dev))
> > +		return;
> >  
> > -		pci_dev_assign_added(dev, false);
> > -	}
> > +	pci_pme_active(dev, false);
> > +	device_for_each_child(dev->dev.parent, dev_of_node(&dev->dev),
> > +			      pci_pwrctl_unregister);
> > +	device_release_driver(&dev->dev);
> > +	pci_proc_detach_device(dev);
> > +	pci_remove_sysfs_dev_files(dev);
> > +	of_pci_remove_node(dev);
> >  }
> 
> The above is now queued for v6.13 as commit 6d6d962a8dc2 on pci/locking.
> 
> I note there's a behavioral change here:
> 
> Previously "pci_pme_active(dev, false)" was called unconditionally,
> now only if the "added" flag has been set.  The commit message
> doesn't explain why this change is fine, so perhaps it's inadvertent?

Hm, not exactly intentional. It doesn't appear to accomplish anything to
call it multiple times, but it also looks hamrless to do so.  Looking at
the history of this, it looks like it was purposefully done
unconditionally with the understanding it's "safe" to do that. With that
in mind, I'm happy to move it back where it was.

