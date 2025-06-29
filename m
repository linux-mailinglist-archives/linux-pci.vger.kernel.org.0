Return-Path: <linux-pci+bounces-31028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B42AECCED
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 15:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3718C3A80D5
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 13:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37B22236E1;
	Sun, 29 Jun 2025 13:36:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D945216E24;
	Sun, 29 Jun 2025 13:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751204198; cv=none; b=WONWlfYoqVVWOzZ+Qjkv8N+Iuk6BJSmz/U1rtTcNdjP1EGRDgUxlvEBDk+/UZW+4AGIuBb+9Qkr77IfdFOzL0ibqJNaRZrDp63fSyvQsK5E2ECZflDApRyEqdHRUDoNZsNCO9TgDUMISWU4HPjDqhYvh1ag53JM18dnMEaydtOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751204198; c=relaxed/simple;
	bh=O+gj/fQ2BzErT0zkP2V9IglTzLkxHYu5QrEZq+19iBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwIGKZ/aaEcbTr0QphopGfizIvTje6v+rktwDkEW6/4j2ECP2L9WFaJAL7CHqnLjOXj7mHTfLPymZU4AWvJV0FXbsM4YNtc/HKN1B4WhqlvaKTyUrB1riLV13mV9EDe4Q2xyBJL4Z1aTm9o4TA+iqL55bHX6XCgD/PBOTZmEpX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 4D83F2C0163B;
	Sun, 29 Jun 2025 15:36:28 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DBB7B3B7043; Sun, 29 Jun 2025 15:36:27 +0200 (CEST)
Date: Sun, 29 Jun 2025 15:36:27 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Parav Pandit <parav@nvidia.com>,
	virtualization@lists.linux.dev, stefanha@redhat.com,
	alok.a.tiwari@oracle.com
Subject: Re: [PATCH RFC] pci: report surprise removal events
Message-ID: <aGFBW7wet9V4WENC@wunner.de>
References: <11cfcb55b5302999b0e58b94018f92a379196698.1751136072.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11cfcb55b5302999b0e58b94018f92a379196698.1751136072.git.mst@redhat.com>

On Sat, Jun 28, 2025 at 02:58:49PM -0400, Michael S. Tsirkin wrote:
> At the moment, in case of a surprise removal, the regular
> remove callback is invoked, exclusively.
> This works well, because mostly, the cleanup would be the same.
> 
> However, there's a race: imagine device removal was initiated by a user
> action, such as driver unbind, and it in turn initiated some cleanup and
> is now waiting for an interrupt from the device. If the device is now
> surprise-removed, that never arrives and the remove callback hangs
> forever.
> 
> Drivers can artificially add timeouts to handle that, but it can be
> flaky.
> 
> Instead, let's add a way for the driver to be notified about the
> disconnect. It can then do any necessary cleanup, knowing that the
> device is inactive.
[...]
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -549,6 +549,15 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
>  	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
>  	pci_doe_disconnected(dev);
>  
> +	/* Notify driver of surprise removal */
> +	device_lock(&dev->dev);
> +
> +	if (dev->driver && dev->driver->err_handler &&
> +	    dev->driver->err_handler->disconnect)
> +		dev->driver->err_handler->disconnect(dev);
> +
> +	device_unlock(&dev->dev);
> +
>  	return 0;
>  }

No, that's not good:

1/ The device_lock() will reintroduce the issues solved by 74ff8864cc84.

2/ pci_dev_set_disconnected() needs to be fast so that devices are marked
   unplugged as quickly as possible.  We want to minimize the time window
   where MMIO and Config Space reads already return "all ones" and writes
   go to nirvana, but pci_dev_is_disconnected() still returns false.
   Hence invoking some driver callback which may take arbitrarily long or
   even sleeps is not an option.

The driver is already notified of removal through invocation of the
->remove() callback.  The use case you're describing is arguably
a corner case.  I do think that a timeout is a better approach
than the one proposed here.  How long does it take for the interrupt
to arrive?  If it's not just a few msec, consider polling the device
and breaking out of the pool loop as soon as pci_dev_is_disconnected()
returns true (or the MMIO read returns PCI_POSSIBLE_ERROR()).

If/when respinning, please explain the use case in more detail,
i.e. which driver, which device, pointers to code...

Thanks!

Lukas

