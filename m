Return-Path: <linux-pci+bounces-17729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C289E4EC3
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 08:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E96188053D
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 07:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274FA1B393C;
	Thu,  5 Dec 2024 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pTNj3tHf"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A259419FA7C;
	Thu,  5 Dec 2024 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733384287; cv=none; b=XmXLAgq2OVWZJN1Z1ebX7UJcLAHMJKyHqm48bHsUHgRLI4VZTtxnHhZCbduH5Cn+5eTic1mJzmlooAbQISECEXFAPdY210NJvHW1+GZ14TaXECksHLdxVjmOoRPc7Xo7cGMY6GvlrIfb06O30+qSrUjhpu/N4zC/FKfCn/ehdgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733384287; c=relaxed/simple;
	bh=CJRa21fhkfOQ3WDvy2H2fJtex0WENeCMl38u7O1ybd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETNCkyd7e13znSc3yo6IEmJACQPs0bzpoKT95Pz/EE4PyPZuNz79ZppY/LizJcK2OOgxoI88kIqsnSxF7+k0grBPMr0tbl3pYVaZQa88FoaZVTjW91GamfMkKz/lbVDo9LeizL5t28PEJHdsps2iGiDLkRk4PhivOyLZvC8po8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pTNj3tHf; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 63D5860006;
	Thu,  5 Dec 2024 07:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733384277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y6SLLPVCdmdeOlZVKpMCSyV7RHMVrGvEcykzTA5du14=;
	b=pTNj3tHfzN0aJG83f8B4KfAgU/Tx/BvJQ/KrUUNF4Y6ySQdwOG4EaIsUc88vkVCytGXbg3
	DAHwZ16XitRnnKLYpOexMNTFxMNMXHvvseQ88h/c37wo/jDn/1oglqi+8EggsUIwzAuBJN
	o++e3tIZiS8WpKFXxB1vZc/EpGbGC1nlVaYwu3D62cRUTktcLP7ae00H3S+xFsMAeGZVyF
	JpVEz3eIXC6SwVQhLTrn2LWwAFai1RM097CbkdWHE42iHwJ6xc7hy66wqBUmrE30BDNjEp
	UttztGb1BIvmtCcu+Clubo3gHcBxqmpQWnsbUu3M6q0PyQ2Y2PrzTs3MgwmSCQ==
Date: Thu, 5 Dec 2024 08:37:55 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan
 <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou
 <lizhi.hou@amd.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 6/6] PCI: of: Create device-tree PCI host bridge node
Message-ID: <20241205083755.1d0e0b3e@bootlin.com>
In-Reply-To: <20241204214852.GA3017210@bhelgaas>
References: <20241202131522.142268-7-herve.codina@bootlin.com>
	<20241204214852.GA3017210@bhelgaas>
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

Hi Bjorn,

On Wed, 4 Dec 2024 15:48:52 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Mon, Dec 02, 2024 at 02:15:18PM +0100, Herve Codina wrote:
> > PCI devices device-tree nodes can be already created. This was
> > introduced by commit 407d1a51921e ("PCI: Create device tree node for
> > bridge").
> > 
> > In order to have device-tree nodes related to PCI devices attached on
> > their PCI root bus (the PCI bus handled by the PCI host bridge), a PCI
> > root bus device-tree node is needed. This root bus node will be used as
> > the parent node of the first level devices scanned on the bus. On
> > device-tree based systems, this PCI root bus device tree node is set to
> > the node of the related PCI host bridge. The PCI host bridge node is
> > available in the device-tree used to describe the hardware passed at
> > boot.
> > 
> > On non device-tree based system (such as ACPI), a device-tree node for
> > the PCI host bridge or for the root bus do not exist. Indeed, the PCI
> > host bridge is not described in a device-tree used at boot simply
> > because no device-tree are passed at boot.  
> 
> s/do not exist/does not exist/

Will be fix in the next iteration.

> 
> > +void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
> > +{
> > +	struct device_node *np = NULL;
> > +	struct of_changeset *cset;
> > +	const char *name;
> > +	int ret;
> > +
> > +	/*
> > +	 * If there is already a device-tree node linked to the PCI bus handled
> > +	 * by this bridge (i.e. the PCI root bus), nothing to do.
> > +	 */
> > +	if (pci_bus_to_OF_node(bridge->bus))
> > +		return;
> > +
> > +	/* The root bus has no node. Check that the host bridge has no node too */
> > +	if (bridge->dev.of_node) {
> > +		pr_err("PCI host bridge of_node already set");  
> 
> Can we use dev_err() here?

Yes indeed.
Will be change in the next iteration.

Best regards,
Hervé

