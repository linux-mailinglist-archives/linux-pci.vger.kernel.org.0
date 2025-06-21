Return-Path: <linux-pci+bounces-30299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78859AE2B50
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 21:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3717176DA1
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 19:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4994226FA5C;
	Sat, 21 Jun 2025 19:05:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650DD15CD74;
	Sat, 21 Jun 2025 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750532722; cv=none; b=PjcbujbJxOSrEovg01Dk61q+sPeeFlBhm3SQwqYWJnCo5qhtWPaKznl7aGPVRBdDoUf5sllPF2RMegREZlqG3l9lAJjRxJhqgzljr/RTaMLf/kdZ2TS7kBSIjfHns0MRNtWzCoxL90EvoPExn5OKIFujvWvSHjz0JVt671NiDv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750532722; c=relaxed/simple;
	bh=AkWA8qp1SUCfxVsjdnu/bl5tdqn3xmczgLReR+INRXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXSZpNDOyeHLqVb6S9AW3P5Y8EXXle+zVB0vUpp6Vp852caHK2MyLiNlHhiEI3I5BMoCvZxXMYDM11f+X2d3VxNNBvdGEQ3savSpQxeKELpVYGPHDzfoEnRVt25O/3DqdNIneXyQgfFdDLwar8VN0IZlk+4F8n3Ipnh7YnO6J6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id E7E84200A446;
	Sat, 21 Jun 2025 21:05:15 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id CDA573A6359; Sat, 21 Jun 2025 21:05:15 +0200 (CEST)
Date: Sat, 21 Jun 2025 21:05:15 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 2/2] PCI: Fix runtime PM usage count underflow on
 device unplug
Message-ID: <aFcCaw_IZr-JuUYY@wunner.de>
References: <20250620025535.3425049-1-superm1@kernel.org>
 <20250620025535.3425049-3-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620025535.3425049-3-superm1@kernel.org>

On Thu, Jun 19, 2025 at 09:55:35PM -0500, Mario Limonciello wrote:
> When a USB4 dock is unplugged the PCIe bridge it's connected to will
> remove issue a "Link Down" and "Card not detected event". The PCI core
> will treat this as a surprise hotplug event and unconfigure all downstream
> devices.
> 
> pci_stop_bus_device() will call device_release_driver(). As part of device
> release sequence pm_runtime_put_sync() is called for the device which will
> decrement the runtime counter to 0. After this, the device remove callback
> (pci_device_remove()) will be called which again calls pm_runtime_put_sync()
> but as the counter is already 0 will cause an underflow.
> 
> This behavior was introduced in commit 967577b062417 ("PCI/PM: Keep runtime
> PM enabled for unbound PCI devices") to prevent asymmetrical get/put from
> probe/remove, but this misses out on the point that when releasing a driver
> the usage count is decremented from the device core.
> 
> Drop the extra call from pci_device_remove().
> 
> Fixes: 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI devices")

This doesn't look right.  The refcount underflow issue seems new,
we surely haven't been doing the wrong thing since 2012.


> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -478,9 +478,6 @@ static void pci_device_remove(struct device *dev)
>  	pci_dev->driver = NULL;
>  	pci_iov_remove(pci_dev);
>  
> -	/* Undo the runtime PM settings in local_pci_probe() */
> -	pm_runtime_put_sync(dev);
> -

local_pci_probe() increases the refcount to keep the device in D0.
If the driver wants to use runtime suspend, it needs to decrement
the refcount on ->probe() and re-increment on ->remove().

In the dmesg output attached to...

https://bugzilla.kernel.org/show_bug.cgi?id=220216

... the device exhibiting the refcount underflow is a PCIe port.
Are you also seeing this on a PCIe port or is it a different device?

So the refcount decrement happens in pcie_portdrv_probe() and
the refcount increment happens in pcie_portdrv_remove().
Both times it's conditional on pci_bridge_d3_possible().
Does that return a different value on probe versus remove?

Does any of the port service drivers decrement the refcount
once too often?  I've just looked through pciehp but cannot
find anything out of the ordinary.

Looking through recent changes, 002bf2fbc00e and bca84a7b93fd
look like potential candidates causing a regression, but the
former is for AER (which isn't used in the dmesg attached to
the bugzilla) and the latter touches suspend on system sleep,
not runtime suspend.

Can you maybe instrument the pm_runtime_{get,put}*() functions
with a printk() and/or dump_stack() to see where a gratuitous
refcount decrement occurs?

Alternatively, is there a known-good kernel version which does
not exhibit the issue and which could serve as anchor for
git bisect?

Thanks,

Lukas

