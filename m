Return-Path: <linux-pci+bounces-17728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E469E4EB8
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 08:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4759F167516
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 07:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A96A1B218F;
	Thu,  5 Dec 2024 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="evePA4qf"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413B31B2183;
	Thu,  5 Dec 2024 07:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733384026; cv=none; b=oSOI6BiEJ1dn97c3Hb3vEItGvvoauaRU11w44BuzzH98F07lBGZAtrwUEiR5PIscLBlRrx6OV9dkYiM13gM+uxz0W0NekFIa8CXzxUMwWraxuwoyRNOjQhombd8FS04sRzB5pA8f/XBbxmj2xv49rEFtjagOhIBOPNkQx4FP3ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733384026; c=relaxed/simple;
	bh=87LbHUmD8vW7XEbvvf9NdV0yo2rlymB3DHUQob2Qh8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNEZ2UsnatA78PhFQGIXmh81ynhlkCiBQLtM3B7P9UoriV3IziP2YIwGCd4FHT/dsZTpU3A8fcNeSrWeS5qRR6NuFo62MHMqPc9kWjb2JKLaNjs2qgJlRzIR17LQWjFWm6XPK9vAWy049dYdLiIy7DmJyYhcAi15PnANixIoClU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=evePA4qf; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3094FC0002;
	Thu,  5 Dec 2024 07:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733384015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGrI+Mda77uDpcJ7B7OZ+Ds7WpsuDRUmfpo0RjF1ujY=;
	b=evePA4qfARIFJRhDFl6Mm7xrDiNoqCrdWRLfhJOvd2YzI5VT4xBJqGFHdjQY89PUNIfywj
	PUWJn/yr5G3xf9uFtL9oWZsYfhK3yGmlQucX8VdJcXxwi6GRF8XnIXVmqQgvGpkkFd2N0h
	rGo9yHrAbzxmED2pIWMrDo73f3e3p9V7aI6mdbgiguQ4t7j/dS6uEnGwgO5u3L5nZRWPZS
	xOB/ALvj93wJmJQZqrsRzklm4wXjTjmx1QzsW6xGPl+F3NhuHVfb9L+MPPZrS1+Du9o3GF
	aJwBE9oBWIbSwRwz4GKQN5jY30izwMgpwhJLUj89Ac+6T7ISRBU1+vNjE0yKtA==
Date: Thu, 5 Dec 2024 08:33:33 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan
 <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou
 <lizhi.hou@amd.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 1/6] driver core: Introduce
 device_{add,remove}_of_node()
Message-ID: <20241205083333.3a4141b1@bootlin.com>
In-Reply-To: <2024120537-varying-chain-7d1e@gregkh>
References: <20241202131522.142268-2-herve.codina@bootlin.com>
	<20241204213825.GA3016970@bhelgaas>
	<2024120537-varying-chain-7d1e@gregkh>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Greg,

On Thu, 5 Dec 2024 08:00:44 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Dec 04, 2024 at 03:38:25PM -0600, Bjorn Helgaas wrote:
> > [cc->to Greg, Rafael]
> > 
> > On Mon, Dec 02, 2024 at 02:15:13PM +0100, Herve Codina wrote:  
> > > An of_node can be set to a device using device_set_node().
> > > This function cannot prevent any of_node and/or fwnode overwrites.
> > > 
> > > When adding an of_node on an already present device, the following
> > > operations need to be done:
> > > - Attach the of_node if no of_node were already attached
> > > - Attach the of_node as a fwnode if no fwnode were already attached
> > > 
> > > This is the purpose of device_add_of_node().
> > > device_remove_of_node() reverts the operations done by
> > > device_add_of_node().
> > > 
> > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > ---
> > >  drivers/base/core.c    | 52 ++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/device.h |  2 ++  
> > 
> > I suppose this series would go via the PCI tree since the bulk of the
> > changes are there.  If so, I would look for an ack from the driver
> > core folks (Greg, Rafael).
> >   
> > >  2 files changed, 54 insertions(+)
> > > 
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index 8b056306f04e..3953c5ab7316 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -5216,6 +5216,58 @@ void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
> > >  }
> > >  EXPORT_SYMBOL_GPL(set_secondary_fwnode);
> > >  
> > > +/**
> > > + * device_remove_of_node - Remove an of_node from a device
> > > + * @dev: device whose device-tree node is being removed
> > > + */
> > > +void device_remove_of_node(struct device *dev)
> > > +{
> > > +	dev = get_device(dev);
> > > +	if (!dev)
> > > +		return;
> > > +
> > > +	if (!dev->of_node)
> > > +		goto end;
> > > +
> > > +	if (dev->fwnode == of_fwnode_handle(dev->of_node))
> > > +		dev->fwnode = NULL;
> > > +
> > > +	of_node_put(dev->of_node);
> > > +	dev->of_node = NULL;
> > > +
> > > +end:
> > > +	put_device(dev);
> > > +}
> > > +EXPORT_SYMBOL_GPL(device_remove_of_node);
> > > +
> > > +/**
> > > + * device_add_of_node - Add an of_node to an existing device
> > > + * @dev: device whose device-tree node is being added
> > > + * @of_node: of_node to add
> > > + */
> > > +void device_add_of_node(struct device *dev, struct device_node *of_node)
> > > +{
> > > +	if (!of_node)
> > > +		return;
> > > +
> > > +	dev = get_device(dev);
> > > +	if (!dev)
> > > +		return;
> > > +
> > > +	if (WARN(dev->of_node, "%s: Cannot replace node %pOF with %pOF\n",
> > > +		 dev_name(dev), dev->of_node, of_node))
> > > +		goto end;  
> 
> Please do not reboot machines that have panic-on-warn for something that
> you can properly handle and recover from (like this.)  Just print out a
> message and continue on, or better yet, return an error if this didn't
> work properly.
> 

I will change to dev_warn() in the next iteration.

Thanks for pointing this.
Best regards,
Hervé

