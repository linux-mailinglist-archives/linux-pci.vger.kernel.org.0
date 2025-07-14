Return-Path: <linux-pci+bounces-32072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2B4B041A4
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 16:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08FBA4A75A8
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 14:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A36422129F;
	Mon, 14 Jul 2025 14:28:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6772019047A
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503318; cv=none; b=hU+PuULLU2UPoHdxK7YifdIkMGdvtbuWkb0VSjuP/9vytCqWHqBscugmz+stuAdHxhx211l9kxLpZFT+1eSmq7trRAEGEROUBpTbOKgq221fylnjQ4VSqceAkXx7U7GUqOF9mWyoJ43owharue1BehrdnGAVfgCxeGWwIpYFWZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503318; c=relaxed/simple;
	bh=HhMgd1FQ7yBH4dMplS22HBFIQ5+qApJMMg1KMdWvS4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqSVrZMA0VsZpgdnd1l4gdIr28W05HdbrCFx7DuQBEZsRbsub0H60RAhuao/dZAQGWiHSgQq3IBtwhga7iYbHqumQ7PW7kMIn3yJJ/6akVkB8EbGfGMelTAbZWIJxsu0Ee2bhfl86O2JOyJORkDNMgGh9rcREcWCXLpZAs5yKsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id CEBDB20059AA;
	Mon, 14 Jul 2025 16:20:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C3FA5435C4D; Mon, 14 Jul 2025 16:20:03 +0200 (CEST)
Date: Mon, 14 Jul 2025 16:20:03 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-pci@vger.kernel.org, Yaron Avizrat <yaron.avizrat@intel.com>,
	Koby Elbaz <koby.elbaz@intel.com>,
	Konstantin Sinyuk <konstantin.sinyuk@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Even Xu <even.xu@intel.com>, Xinpeng Sun <xinpeng.sun@intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alan Stern <stern@rowland.harvard.edu>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>
Subject: Re: [PATCH] PCI: Allow drivers to opt in to async probing
Message-ID: <aHUSE1Q1V-A-OiUv@wunner.de>
References: <53abe6f5ac7c631f95f5d061aa748b192eda0379.1751614426.git.lukas@wunner.de>
 <20250714134502.GB11300@lst.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714134502.GB11300@lst.de>

On Mon, Jul 14, 2025 at 03:45:02PM +0200, Christoph Hellwig wrote:
> On Fri, Jul 04, 2025 at 09:38:33AM +0200, Lukas Wunner wrote:
> > The PCI core has historically not allowed drivers to opt in to async
> > probing:  Even though drivers may set "PROBE_PREFER_ASYNCHRONOUS", initial
> > probing always happens synchronously.  That's because the PCI core uses
> > device_attach() instead of device_initial_probe().
> 
> Is it?  I see frequent reordering of Qemu NVMe with the current kernel,
> and have to disable it for some of my test setups that require different
> device characteristics.

There's a PCI_DEV_ALLOW_BINDING flag in struct pci_dev which is honored
by pci_bus_match().  Initially the flag is false, so when the device is
enumerated, it's not allowed to probe.  Later on in pci_bus_add_device(),
the flag is set to true and initial probing happens.  It always happens
synchronously because:

  pci_bus_add_device()
    pci_dev_allow_binding()
    device_attach()
      __device_attach(dev, allow_async = false)

I guess what happens in your case is, *after* initial probing has
concluded and user space is up and running, a driver is unbound
from the device and another driver is subsequently re-bound.
E.g. "nvme" is unbound and "virtio-pci" is bound instead.

That happens synchronously, but does not prevent parallel binding
of the same driver to another device because the PCI_DEV_ALLOW_BINDING
flag is true for all devices after initial probing has happened:

  bind_store()
    device_driver_attach()
      __driver_probe_device()
        really_probe()

So that would be a second way (aside from -EPROBE_DEFER) to achieve
asynchronous probing.  The commit aims at asynchronous *initial* probing
to speed up booting.  I may not have made this sufficiently clear in the
commit message. :(

Thanks,

Lukas

