Return-Path: <linux-pci+bounces-41923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1FBC7E420
	for <lists+linux-pci@lfdr.de>; Sun, 23 Nov 2025 17:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D84B4E3AD6
	for <lists+linux-pci@lfdr.de>; Sun, 23 Nov 2025 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D59229B36;
	Sun, 23 Nov 2025 16:35:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FFA2248B9;
	Sun, 23 Nov 2025 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915731; cv=none; b=nIHN5l6VI4we/8BQKA211G6lyPHUpBgEO37OY0FttuNcpTY993yvaCqcaBLk9VHqCYvvj0B5zk2qqen1Djw3IEKGDXhC5F+rcIS9tR26zsIUWQ3QkWl4XJfuypdmizumHvS7HYlpJGlcp4YsOv9f5wujmOkOL5jo6wFdtnP9FbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915731; c=relaxed/simple;
	bh=AQzkDo0QeYK5ImNeYPsQ/IWWOn73CEkP1YVQ3uRo0xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihXaJ8YYWDRZKoxM1pQPbaq9p8GtP/vMimLAzpEpu5JKTqH7wdTvHu7oX1FsXxNH9sjeZlmAETDytO7V8LGGVqgL8ceb1kZEGpTXnm82j/fG9WIi/zwPOuu6zJSXhD9j3Y30jLqFZdUVuiJwqAXFcGgLH55dIxZ2IA20C3MhizY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1C7F02C06A8A;
	Sun, 23 Nov 2025 17:35:20 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 052D41BEAC; Sun, 23 Nov 2025 17:35:19 +0100 (CET)
Date: Sun, 23 Nov 2025 17:35:19 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Tony Hutter <hutter2@llnl.gov>
Cc: Bjorn Helgaas <helgaas@kernel.org>, corey@minyard.net,
	alok.a.tiwari@oracle.com, mariusz.tkaczyk@linux.intel.com,
	minyard@acm.org, linux-pci@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] Introduce Cray ClusterStor E1000 NVMe slot LED driver
Message-ID: <aSM3x-V4Apcybpax@wunner.de>
References: <d485bd74-e49d-4c89-b986-1b45c93e7975@llnl.gov>
 <aQMsVUCBDF7ZUSK-@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQMsVUCBDF7ZUSK-@wunner.de>

On Thu, Oct 30, 2025 at 10:13:57AM +0100, Lukas Wunner wrote:
> On Wed, Oct 08, 2025 at 04:48:22PM -0700, Tony Hutter wrote:
> > @@ -376,8 +383,16 @@ int __init pcie_hp_init(void)
> >  
> >  	retval = pcie_port_service_register(&hpdriver_portdrv);
> >  	pr_debug("pcie_port_service_register = %d\n", retval);
> > -	if (retval)
> > +	if (retval) {
> >  		pr_debug("Failure to register service\n");
> > +		return retval;
> > +	}
> > +
> > +#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
> > +	retval = craye1k_init();
> > +	if (retval)
> > +		pr_debug("Failure to register Cray E1000 extensions");
> > +#endif
> 
> You also need to annotate craye1k_init() with __init.

Sorry, I've realized that I made the following note during review
of your patch but forgot to include it in the reply above:

You may want to consider making this driver modular and auto-load it
using a MODULE_DEVICE_TABLE(dmi, ...) declaration.  craye1k_init()
would then become the module_init() call and you could tear down
everything in a module_exit() call.  If you want to run craye1k_init()
earlier if built-in, use e.g. an arch_initcall() instead of a
module_init() call.  There's precedent in the tree for combinations
of arch_initcall() + module_exit().

Thanks,

Lukas

