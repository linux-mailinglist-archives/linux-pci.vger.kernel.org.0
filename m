Return-Path: <linux-pci+bounces-38084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 352B0BDB272
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 22:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E47BB4E540A
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 20:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91F53054FE;
	Tue, 14 Oct 2025 20:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGmlOR2E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3362FFDFB;
	Tue, 14 Oct 2025 20:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760472423; cv=none; b=gYUhIJvjRk6Xlk9LLcWKqts/XSdbyNdzfJu5wbLxDR+R0Th8cwXib5evdAB5fT3hQVDce2LL3Q3bttEkP6kmeO8iQx4NQZ874TDWtdMi3PxQYYcxpvG1uWu6xsFaJ/axB2qXI3LVrH+W2nY+coNPkSe3AHl+VbQ8YKJ7DJtCQew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760472423; c=relaxed/simple;
	bh=Z0BJSHmaIit4mQsVLtMhOCrBGLBdeW7Lb3TblmP8GI4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WiDR5amnU+wLnx3SeIimCQNL1HXGrb6/fuk5LywvbffZedEsaOSGJSBF70hg8MsWoLPtrQmYt3iPeMwAk8Ale15HgNsg495IDTFHhjnV8WVDOaELzV9cwaAfc0NcTE9fCIAHY/6UFE51dXAaUUaSOaDip5uFX0yt7F/yzl+9Tes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGmlOR2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE27DC4CEF9;
	Tue, 14 Oct 2025 20:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760472423;
	bh=Z0BJSHmaIit4mQsVLtMhOCrBGLBdeW7Lb3TblmP8GI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TGmlOR2EXwPxxN97KqShYy7FJo/4wQ2KKY1aUcKc1PZpbWv7DJPwNEVK4AQs4RJkt
	 hmksT6eYwRPlKziW5efSLEPDKmHYfwMbawCDM8fvIKmMDNUJa3/3871mXSM4Kyhzj9
	 LtQStn0kICY2XnqVUnVcCAQfUxg8ziUjg3p+xkNwPN8xwz2sUTBVU/XUt8fVYA9lnC
	 V5wpIURwrifNyC46lleFxZ/pcU5cbrz7XeC+MQ3PREZQvwNW1dQHA9tEedRxImWNWU
	 0N15LOhkh5AJ8OlIVKbdQtq6HmdJZL9cHbA1ZoWbTY8mKeTJMN9Kya2YV7/92ClKjo
	 JQnONMpBw/04g==
Date: Tue, 14 Oct 2025 15:07:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vincent Liu <vincent.liu@nutanix.com>
Cc: gregkh@linuxfoundation.org, dakr@kernel.org,
	linux-kernel@vger.kernel.org, rafael@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] driver core: Check drivers_autoprobe for all added
 devices
Message-ID: <20251014200701.GA859701@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013181459.517736-1-vincent.liu@nutanix.com>

On Mon, Oct 13, 2025 at 07:14:59PM +0100, Vincent Liu wrote:
> When a device is hot-plugged, the drivers_autoprobe sysfs attribute is
> not checked. This means that drivers_autoprobe is not working as
> intended, e.g. hot-plugged PCIe devices will still be autoprobed and
> bound to drivers even with drivers_autoprobe disabled.
> 
> Make sure all devices check drivers_autoprobe by pushing the
> drivers_autoprobe check into device_initial_probe. This will only
> affect devices on the PCI bus for now as device_initial_probe is only
> called by pci_bus_add_device and bus_probe_device (but bus_probe_device
> already checks for autoprobe).

> In particular for the PCI devices, only
> hot-plugged PCIe devices/VFs should be affected as the default value of
> pci/drivers_autoprobe remains 1 and can only be cleared from userland.

I'm not sure what this last sentence is telling us.  Does
"pci/drivers_autoprobe" refer to struct pci_sriov.drivers_autoprobe?
If so, can you elaborate on the connection with struct
subsys_private.drivers_autoprobe, which this patch tests?  I don't see
anything in this patch related to pci_sriov.

As far as I can tell, this patch is generic with respect to
conventional PCI vs PCIe.  If so, I'd use "PCI" everywhere instead of
a mix of PCI and PCIe.

> Any future callers of device_initial_probe will respsect the
> drivers_autoprobe sysfs attribute, but this should be the intended
> purpose of drivers_autoprobe.

Add "()" after function names to make them easily recognizable as
functions.

s/respsect/respect/
s/but this should be the/which is the/  # maybe? not sure what you intend

> Signed-off-by: Vincent Liu <vincent.liu@nutanix.com>
> ---
> v1->v2: Change commit subject to include driver core (no code change)
> 	https://lore.kernel.org/20251001151508.1684592-1-vincent.liu@nutanix.com
> ---
>  drivers/base/bus.c |  3 +--
>  drivers/base/dd.c  | 10 +++++++++-
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 5e75e1bce551..320e155c6be7 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -533,8 +533,7 @@ void bus_probe_device(struct device *dev)
>  	if (!sp)
>  		return;
>  
> -	if (sp->drivers_autoprobe)
> -		device_initial_probe(dev);
> +	device_initial_probe(dev);
>  
>  	mutex_lock(&sp->mutex);
>  	list_for_each_entry(sif, &sp->interfaces, node)
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 13ab98e033ea..37fc57e44e54 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1077,7 +1077,15 @@ EXPORT_SYMBOL_GPL(device_attach);
>  
>  void device_initial_probe(struct device *dev)
>  {
> -	__device_attach(dev, true);
> +	struct subsys_private *sp = bus_to_subsys(dev->bus);
> +
> +	if (!sp)
> +		return;
> +
> +	if (sp->drivers_autoprobe)
> +		__device_attach(dev, true);
> +
> +	subsys_put(sp);
>  }
>  
>  /*
> -- 
> 2.43.7
> 

