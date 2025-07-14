Return-Path: <linux-pci+bounces-32037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B28B4B036A2
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 08:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A16189B3F6
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 06:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07FC221FAC;
	Mon, 14 Jul 2025 06:11:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC758221727;
	Mon, 14 Jul 2025 06:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752473475; cv=none; b=FW0If5+Luh9tSTKQSHsVZJv31tkGI43fWfnAY4vWfjYbSYee/O5qFtHEpC1bdyH7CjBwCZXMew2UZoHmEeW3XkIQaiFtZRd/ePgp/PA9cn4yGGgLeZGgs1zt9pc+ORdXm5DJOcjaVHcdtfT9XffyAiRxMktzk19hv6+tFJb0Ztc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752473475; c=relaxed/simple;
	bh=IVw/uBOewMo2OC3Rh1leGaAzDQVXNJEsiqaJAT6ZtpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvjJqPm2I6wFg4Az2ytdIBAwluyF7YRgmYb5A9h+5+bEFKsS0GkJ6D8GjVq6u1tS1weoyHIqhPg49x3NbjFd54q+iB6R9D1h+ibK4vSj0i71EN7nJHBsvDhIH3+vBewkVl9hqfvkijq5ZAPXhyFo932/jSXOEwWFsnAhtM4mMgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 297B12C051CB;
	Mon, 14 Jul 2025 08:11:05 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DF62E435C3E; Mon, 14 Jul 2025 08:11:04 +0200 (CEST)
Date: Mon, 14 Jul 2025 08:11:04 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <aHSfeNhpocI4nmQk@wunner.de>
References: <cover.1752094439.git.mst@redhat.com>
 <fba3d235e38c1c6fcef2a30ed083ad9e25b20fa3.1752094439.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fba3d235e38c1c6fcef2a30ed083ad9e25b20fa3.1752094439.git.mst@redhat.com>

On Wed, Jul 09, 2025 at 04:55:26PM -0400, Michael S. Tsirkin wrote:
> At the moment, in case of a surprise removal, the regular remove
> callback is invoked, exclusively.  This works well, because mostly, the
> cleanup would be the same.
> 
> However, there's a race: imagine device removal was initiated by a user
> action, such as driver unbind, and it in turn initiated some cleanup and
> is now waiting for an interrupt from the device. If the device is now
> surprise-removed, that never arrives and the remove callback hangs
> forever.

For PCI devices in a hotplug slot, user space can initiate "safe removal"
by writing "0" to the hotplug slot's "power" file in sysfs.

If the PCI device is yanked from the slot while safe removal is ongoing,
there is likewise no way for the driver to know that the device is
suddenly gone.  That's because pciehp_unconfigure_device() only calls
pci_dev_set_disconnected() in the surprise removal case, not for
safe removal.

The solution proposed here is thus not a complete one:  It may work
if user space initiated *driver* removal, but not if it initiated *safe*
removal of the entire device.  For virtio, that may be sufficient.

> +++ b/drivers/pci/pci.h
> @@ -553,6 +553,12 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
>  	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
>  	pci_doe_disconnected(dev);
>  
> +	if (READ_ONCE(dev->disconnect_work_enable)) {
> +		/* Make sure work is up to date. */
> +		smp_rmb();
> +		schedule_work(&dev->disconnect_work);
> +	}
> +
>  	return 0;
>  }

Going through all the callers of pci_dev_set_disconnected(),
I suppose the (only) one you're interested in is
pciehp_unconfigure_device().

The other callers are related to runtime resume, resume from
system sleep and ACPI slots.

Instead of amending pci_dev_set_disconnected(), I'd prefer
an approach where pciehp_unconfigure_device() first marks
all devices disconnected, then wakes up some global waitqueue, e.g.:

-	if (!presence)
+	if (!presence) {
		pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
+		wake_up_all(&pci_disconnected_wq);
+	}

The benefit is that there's no delay when marking devices disconnected.
(Granted, the delay is small for smp_rmb() + schedule_work().)
And just having a global waitqueue is simpler and may be useful
for other use cases.

So instead of adding timeouts when waiting for interrupts, drivers would
be woken via the waitqueue.

But again, it's not a complete solution as it doesn't cover the
"surprise removal during safe removal" case.

I also agree with Bjorn's and Keith's comments that the driver should
use timeouts for robustness, but still wanted to provide additional
(hopefully constructive) thoughts.

Thanks!

Lukas

