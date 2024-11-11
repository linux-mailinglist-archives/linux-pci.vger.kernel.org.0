Return-Path: <linux-pci+bounces-16431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5147A9C38F5
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 08:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160FC2807F3
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 07:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E36750276;
	Mon, 11 Nov 2024 07:20:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D645136A
	for <linux-pci@vger.kernel.org>; Mon, 11 Nov 2024 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731309659; cv=none; b=tQ7yQmCX96WSy+aTeaF8BZPOvYB8yJsfBOh+vbybrAjv976VY1OSdUnlHsV0K/yP00oKlNO9FG+jey/lB1kG84JoURHBSz1+zLTUYhMvKBlDWLX+sYsxlBBbSyURkop6CAZKtWb56HYwE9UrLPGhr2zCwF1u0YrQ6VYzAGmhE6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731309659; c=relaxed/simple;
	bh=rdm+TB/OnvSr5WSGc45760YXsi20YR4gOv5i8N7UiDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umAbB4+freRMTfZ98H2aVmGnFB2bHFmyh6p92oDh/637+7fOufqvNEgw5XMXaaGNrSZqw4HIynpVJj+mxnDVqlPb2lJ61/A5DIVMgHxKfc6FCcA3xXQ9A31izRWVbjMtf/42lVXXfZkS9T+MncrmjgAZF9lS6WCoxRzNwO/jLVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 4E7B02800B49D;
	Mon, 11 Nov 2024 08:20:52 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4331F45FF15; Mon, 11 Nov 2024 08:20:52 +0100 (CET)
Date: Mon, 11 Nov 2024 08:20:52 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCHv3 1/5] pci: make pci_stop_dev concurrent safe
Message-ID: <ZzGwVOJDRZ6vgKL5@wunner.de>
References: <20241022224851.340648-1-kbusch@meta.com>
 <20241022224851.340648-2-kbusch@meta.com>
 <ZyzJgaEOJOKmh_xw@wunner.de>
 <ZyzjKrNPxn5Vw7cF@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyzjKrNPxn5Vw7cF@kbusch-mbp>

On Thu, Nov 07, 2024 at 08:56:26AM -0700, Keith Busch wrote:
> On Thu, Nov 07, 2024 at 03:06:57PM +0100, Lukas Wunner wrote:
> > On Tue, Oct 22, 2024 at 03:48:47PM -0700, Keith Busch wrote:
> > > --- a/drivers/pci/remove.c
> > > +++ b/drivers/pci/remove.c
> > > @@ -31,18 +31,16 @@ static int pci_pwrctl_unregister(struct device *dev, void *data)
> > >  
> > >  static void pci_stop_dev(struct pci_dev *dev)
> > >  {
> > > -	pci_pme_active(dev, false);
> > > -
> > > -	if (pci_dev_is_added(dev)) {
> > > -		device_for_each_child(dev->dev.parent, dev_of_node(&dev->dev),
> > > -				      pci_pwrctl_unregister);
> > > -		device_release_driver(&dev->dev);
> > > -		pci_proc_detach_device(dev);
> > > -		pci_remove_sysfs_dev_files(dev);
> > > -		of_pci_remove_node(dev);
> > > +	if (!pci_dev_test_and_clear_added(dev))
> > > +		return;
> > >  
> > > -		pci_dev_assign_added(dev, false);
> > > -	}
> > > +	pci_pme_active(dev, false);
> > > +	device_for_each_child(dev->dev.parent, dev_of_node(&dev->dev),
> > > +			      pci_pwrctl_unregister);
> > > +	device_release_driver(&dev->dev);
> > > +	pci_proc_detach_device(dev);
> > > +	pci_remove_sysfs_dev_files(dev);
> > > +	of_pci_remove_node(dev);
> > >  }
> > 
> > The above is now queued for v6.13 as commit 6d6d962a8dc2 on pci/locking.
> > 
> > I note there's a behavioral change here:
> > 
> > Previously "pci_pme_active(dev, false)" was called unconditionally,
> > now only if the "added" flag has been set.  The commit message
> > doesn't explain why this change is fine, so perhaps it's inadvertent?
> 
> Hm, not exactly intentional. It doesn't appear to accomplish anything to
> call it multiple times, but it also looks hamrless to do so.  Looking at
> the history of this, it looks like it was purposefully done
> unconditionally with the understanding it's "safe" to do that. With that
> in mind, I'm happy to move it back where it was.

Yes I think it would be good if you could submit a fixup that Bjorn
could fold into 6d6d962a8dc2, just to minimize regression potential.

Thanks,

Lukas

