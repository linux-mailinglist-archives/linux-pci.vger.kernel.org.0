Return-Path: <linux-pci+bounces-29846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B285CADAB8A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 11:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF37C3AB705
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 09:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20B020CCC9;
	Mon, 16 Jun 2025 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTAE97ti"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D8D1DF982
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750065079; cv=none; b=LWmFNeWrNrzUlHVnNHEtKto/wg4vnIOdWr8sD/rh3E9IOriBQU4uv30wNjaPSd/tXjpxkUZddSa1F8uKZgGzvjb7Yd7gK7SEYiTYTZ7KaN3zRx4FeWky2kauMrZmI63w79oRqhtwMTpfl3D7/VZ7/qWwmxkaPLatsqwS1g1ihIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750065079; c=relaxed/simple;
	bh=BTa8aVaqiUpxckh+IQqd0L32TqofzMKzc5w53O0i5jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rf3k+FyDOVG0wOwKRmRVmFUr1shCZc/+HaumurNXnaQXkw60JB/UfvDgyQzcFMNMvMpkf/71tHBdP3hwjsaF8gALDyGsVJpFAESmtnO8pppzYMRiptHhZINn2kx39w6+ozGOLCGJQTKnQ8yE+cEeQnxDI0oZ8M+o3LVUDVwOaMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HTAE97ti; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750065076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DTBlq5DowCTNu5KZgZrUmlJP9CY6rsK/0xVE//pVHoM=;
	b=HTAE97tifsgey3DVmimAa+e4u//BxLBLrDm/Lkw3xVTdyegoVywqZZQOG82y2LWQefC6Lp
	S2O9YUtUenP7H4WNIq3Z1fz1mrYp0VdyVgz5ZVQkOTbTuXWOMcCXdJ0BULZQz055fxlhqI
	ubrcML4fUJSzKP41S//CQ+sSKL5bj9A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-zWYG_xdoNIWxDjKL0wBKXg-1; Mon,
 16 Jun 2025 05:11:13 -0400
X-MC-Unique: zWYG_xdoNIWxDjKL0wBKXg-1
X-Mimecast-MFC-AGG-ID: zWYG_xdoNIWxDjKL0wBKXg_1750065072
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12BE118089B5;
	Mon, 16 Jun 2025 09:11:12 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.44.34.65])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C13019560A3;
	Mon, 16 Jun 2025 09:11:11 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
	id 3AE2946C376; Mon, 16 Jun 2025 11:11:07 +0200 (CEST)
Date: Mon, 16 Jun 2025 11:11:07 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Mario Limonciello <superm1@kernel.org>, 
	Bjorn Helgaas <helgaas@kernel.org>, mario.limonciello@amd.com, bhelgaas@google.com, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/VGA: Look at all PCI display devices in VGA arbiter
Message-ID: <qysuj6ocfay6hxjclvc3sjptmrzhtvwpfysbukd74rsv4bm7ta@2sdtpotd372q>
References: <20250613190718.GA968774@bhelgaas>
 <3a0a7aeb-436d-442a-bede-9e760a69fa47@kernel.org>
 <20250613151929.3c944c3c.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613151929.3c944c3c.alex.williamson@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

  Hi,

> > >> -	/* Only deal with VGA class devices */
> > >> -	if (!pci_is_vga(pdev))
> > >> +	/* Only deal with display devices */
> > >> +	if (!pci_is_display(pdev))
> > >>   		return 0;  
> > > 
> > > Are there any other pci_is_vga() users that might want
> > > pci_is_display() instead?  virtio_gpu_pci_quirk()?  
> > 
> > +AlexW for comments on potential virtio changes here.
> 
> I can't comment on virtio_gpu, Cc +Gerd for that.

virtio-gpu comes in two variants, with and without vga compatibility
mode, and they advertise them self as "display/other" and "display/vga".

The driver has some pci_is_vga() checks and they need to stay that way
because only the variant with vga compatibility mode has to care about
vga compat things.

> I do however take issue with the premise of this patch.  The VGA
> arbiter is for adjusting VGA routing.  If neither device is VGA, why
> are they registering with the VGA arbiter and what sense does it make
> to create a boot_vga sysfs attribute of a non-VGA device?

100% agree.  If a device is not vga compatible, why register it with the
vga arbiter in the first place?

With BIOS support starting to disappear I expect VGA compatibility in
GPU will be less and less common, and the concept "primary VGA" will
slowly disappear too.

> It seems like we're trying to adapt the kernel to create a facade for
> userspace when userspace should be falling back to some other means of
> determining a primary graphical device.  For instance, is there
> something in UEFI that could indicate the console?  ACPI?  DT?

I don't think there is the one source of truth here.  I expect userspace
(with the help of the kernel) needs collect information from multiple
sources, then try make a good default choice, and of course offer ways
to override that of needed.

The VGA arbiter can be one of these sources, but using it as the *only*
source looks wrong to me.

From UEFI one hint is the firmware framebuffer (GOP aka efi graphics
output protocol, also known as efifb).

aperture_remove_conflicting_pci_devices() will disable firmware
framebuffers before the native gpu driver takes over and could record
the fact as hint, so userspace can figure later which device was used
to display the boot screen.

There also is the ConOut EFI variable, with the console output devices.
That isn't always present though.  When booting something based on edk2
it is there, when booting for example with u-boot in EFI mode it is not.

take care,
  Gerd


