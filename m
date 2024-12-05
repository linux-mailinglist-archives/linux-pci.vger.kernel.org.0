Return-Path: <linux-pci+bounces-17727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1136E9E4DDE
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 08:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDFA3167F40
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 07:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96D2191F70;
	Thu,  5 Dec 2024 07:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c+dQx9O+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BB32F56;
	Thu,  5 Dec 2024 07:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382047; cv=none; b=gYYSAmyLcrGTlXEM+BNgcxpuqQx63BxEiCA+oehtIwCK6xW8MJmUAMlG63mH3tKt+RPfAd5eMVpZ7vOrfkfjshdLyEfw3QHL0A5mzxvjORUKcvW4X/hOZwOhaC+FyQfp6DSRwFyErEiB+8hsHxUKIFyJdx9vr2tu/b3FKmchhGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382047; c=relaxed/simple;
	bh=aMm7FPbcneILDvmgciZe4j8OA9WEOczTdT+do9Vm7ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJhf+4vwDvS76PuT0afBLbFp9+1q+HTgRCnGzLzbSlVfZXtHJiunEg9zB+ZomJ+OJhO8dp3ekY/DA3ahYyHf0TFm60vXHK/jWGaXvPvPNY/hv2z1cqI/z9jHpnqBEl62AGUVNyV0kfkDqOuw69GH+JpXxNwoHNof6bN2ImgX2j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c+dQx9O+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A904C4CED1;
	Thu,  5 Dec 2024 07:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733382047;
	bh=aMm7FPbcneILDvmgciZe4j8OA9WEOczTdT+do9Vm7ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+dQx9O+jWE8UFSlk+gUaUL/n8AncQMRlmV50VYzb250gr9j5ycr61Ni3OjSXrX0x
	 mpJY3NLqasK5axM+6gvTqThZaYcaE6zvU/aSYasHmEPaOl18VARPuN4YD708f6YCsn
	 /u3I0+O0lu7+C4PoTn3EbAj/0RcvqK85NXdim/mk=
Date: Thu, 5 Dec 2024 08:00:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 1/6] driver core: Introduce
 device_{add,remove}_of_node()
Message-ID: <2024120537-varying-chain-7d1e@gregkh>
References: <20241202131522.142268-2-herve.codina@bootlin.com>
 <20241204213825.GA3016970@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204213825.GA3016970@bhelgaas>

On Wed, Dec 04, 2024 at 03:38:25PM -0600, Bjorn Helgaas wrote:
> [cc->to Greg, Rafael]
> 
> On Mon, Dec 02, 2024 at 02:15:13PM +0100, Herve Codina wrote:
> > An of_node can be set to a device using device_set_node().
> > This function cannot prevent any of_node and/or fwnode overwrites.
> > 
> > When adding an of_node on an already present device, the following
> > operations need to be done:
> > - Attach the of_node if no of_node were already attached
> > - Attach the of_node as a fwnode if no fwnode were already attached
> > 
> > This is the purpose of device_add_of_node().
> > device_remove_of_node() reverts the operations done by
> > device_add_of_node().
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  drivers/base/core.c    | 52 ++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/device.h |  2 ++
> 
> I suppose this series would go via the PCI tree since the bulk of the
> changes are there.  If so, I would look for an ack from the driver
> core folks (Greg, Rafael).
> 
> >  2 files changed, 54 insertions(+)
> > 
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 8b056306f04e..3953c5ab7316 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -5216,6 +5216,58 @@ void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
> >  }
> >  EXPORT_SYMBOL_GPL(set_secondary_fwnode);
> >  
> > +/**
> > + * device_remove_of_node - Remove an of_node from a device
> > + * @dev: device whose device-tree node is being removed
> > + */
> > +void device_remove_of_node(struct device *dev)
> > +{
> > +	dev = get_device(dev);
> > +	if (!dev)
> > +		return;
> > +
> > +	if (!dev->of_node)
> > +		goto end;
> > +
> > +	if (dev->fwnode == of_fwnode_handle(dev->of_node))
> > +		dev->fwnode = NULL;
> > +
> > +	of_node_put(dev->of_node);
> > +	dev->of_node = NULL;
> > +
> > +end:
> > +	put_device(dev);
> > +}
> > +EXPORT_SYMBOL_GPL(device_remove_of_node);
> > +
> > +/**
> > + * device_add_of_node - Add an of_node to an existing device
> > + * @dev: device whose device-tree node is being added
> > + * @of_node: of_node to add
> > + */
> > +void device_add_of_node(struct device *dev, struct device_node *of_node)
> > +{
> > +	if (!of_node)
> > +		return;
> > +
> > +	dev = get_device(dev);
> > +	if (!dev)
> > +		return;
> > +
> > +	if (WARN(dev->of_node, "%s: Cannot replace node %pOF with %pOF\n",
> > +		 dev_name(dev), dev->of_node, of_node))
> > +		goto end;

Please do not reboot machines that have panic-on-warn for something that
you can properly handle and recover from (like this.)  Just print out a
message and continue on, or better yet, return an error if this didn't
work properly.

thanks,

greg k-h

