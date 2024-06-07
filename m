Return-Path: <linux-pci+bounces-8487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7E4900E1A
	for <lists+linux-pci@lfdr.de>; Sat,  8 Jun 2024 00:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6545C285B9C
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 22:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4D413DDCA;
	Fri,  7 Jun 2024 22:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOO1W/2z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5FA15532A
	for <linux-pci@vger.kernel.org>; Fri,  7 Jun 2024 22:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717799603; cv=none; b=BTlhpeEGP4Mj2lg2pNrzl2JLm49JpCjhGn7MlDdbCIPOPLLKDLnp4Of3znVCMVVb0DOs3relC433HJ3gxrDUMBG6cWJ/XgK+ezvN6qLnEU9rrnt1Rf/1/X95pgNJX5KzyBionWIKwnQzkoB8QG7QrcFQj1aTekDe9a8DhrpGynY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717799603; c=relaxed/simple;
	bh=qQAOukjOYW+i2BYzNws5+1TiNwWe5jlkryxhnvfavEY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Vn/Yl8cgQMEjrXeXx0osf2wxb1/7/UZixVKboQRQGhloMJElpOaRr+8kW5K22HH0t6lV87l+ILLMRtxtsmmmzvP8DxfR61Im/gdbxRem4zhFHoMSObs0aSOfNW5lRgLUtSzCvbHnYrQWxx7zA6U1T3lQqvEbg0exe0PN3OPMNM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOO1W/2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39729C2BBFC;
	Fri,  7 Jun 2024 22:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717799602;
	bh=qQAOukjOYW+i2BYzNws5+1TiNwWe5jlkryxhnvfavEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fOO1W/2zLMFuB1YYNW+8c1G5ai3pv0jcN66Z2JnodOnLMNnwQoOW965AmQCRiDSDu
	 I8d3ShDyBRS8wqPqfRSKXsoBc86Zzxjg8nzK3D2w3vhz6uf+7V+iClCOAiensaw9Eq
	 A14cLbjxjIkJtr+c89iIHhvImRIHi334FS7Qgpec3NeeLCR/PIQ633YYUq7UQySYVY
	 GPcGvp1BBHUGHqH5R4Ni20ryLJJsJsV83LZp56keIxzAHzNpndJ/+17+s9kuGKnaUT
	 j5lSJn+yCGsEhdmTCihd/KsUHYLe0SfoxflG9cbU1+WseWrvfIK+wa7vrV0ctofdti
	 4l/QuoXz/anIQ==
Date: Fri, 7 Jun 2024 17:33:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, geoff@hostfission.com
Subject: Re: [PATCH] PCI: Release unused bridge resources during resize
Message-ID: <20240607223320.GA863404@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507213125.804474-1-alex.williamson@redhat.com>

On Tue, May 07, 2024 at 03:31:23PM -0600, Alex Williamson wrote:
> Resizing BARs can be blocked when a device in the bridge hierarchy
> itself consumes resources from the resized range.  This scenario is
> common with Intel Arc DG2 GPUs where the following is a typical
> topology:
> 
>  +-[0000:5d]-+-00.0-[5e-61]----00.0-[5f-61]--+-01.0-[60]----00.0  Intel Corporation DG2 [Arc A380]
>                                              \-04.0-[61]----00.0  Intel Corporation DG2 Audio Controller
> 
> Here the system BIOS has provided a large 64bit, prefetchable window:
> 
> pci_bus 0000:5d: root bus resource [mem 0xb000000000-0xbfffffffff window]
> 
> But only a small portion is programmed into the root port aperture:
> 
> pci 0000:5d:00.0:   bridge window [mem 0xbfe0000000-0xbff07fffff 64bit pref]
> 
> The upstream port then provides the following aperture:
> 
> pci 0000:5e:00.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]
> 
> With the missing range found to be consumed by the switch port itself:
> 
> pci 0000:5e:00.0: BAR 0 [mem 0xbff0000000-0xbff07fffff 64bit pref]
> 
> The downstream port above the GPU provides the same aperture as upstream:
> 
> pci 0000:5f:01.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]
> 
> Which is entirely consumed by the GPU:
> 
> pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]
> 
> In summary, iomem reports the following:
> 
> b000000000-bfffffffff : PCI Bus 0000:5d
>   bfe0000000-bff07fffff : PCI Bus 0000:5e
>     bfe0000000-bfefffffff : PCI Bus 0000:5f
>       bfe0000000-bfefffffff : PCI Bus 0000:60
>         bfe0000000-bfefffffff : 0000:60:00.0
>     bff0000000-bff07fffff : 0000:5e:00.0
> 
> The GPU at 0000:60:00.0 supports a Resizable BAR:
> 
> 	Capabilities: [420 v1] Physical Resizable BAR
> 		BAR 2: current size: 256MB, supported: 256MB 512MB 1GB 2GB 4GB 8GB
> 
> However when attempting a resize we get -ENOSPC:
> 
> pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> pcieport 0000:5f:01.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> pcieport 0000:5e:00.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> pcieport 0000:5e:00.0: bridge window [mem size 0x200000000 64bit pref]: can't assign; no space
> pcieport 0000:5e:00.0: bridge window [mem size 0x200000000 64bit pref]: failed to assign
> pcieport 0000:5f:01.0: bridge window [mem size 0x200000000 64bit pref]: can't assign; no space
> pcieport 0000:5f:01.0: bridge window [mem size 0x200000000 64bit pref]: failed to assign
> pci 0000:60:00.0: BAR 2 [mem size 0x200000000 64bit pref]: can't assign; no space
> pci 0000:60:00.0: BAR 2 [mem size 0x200000000 64bit pref]: failed to assign
> pcieport 0000:5d:00.0: PCI bridge to [bus 5e-61]
> pcieport 0000:5d:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> pcieport 0000:5d:00.0:   bridge window [mem 0xbfe0000000-0xbff07fffff 64bit pref]
> pcieport 0000:5e:00.0: PCI bridge to [bus 5f-61]
> pcieport 0000:5e:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> pcieport 0000:5e:00.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]
> pcieport 0000:5f:01.0: PCI bridge to [bus 60]
> pcieport 0000:5f:01.0:   bridge window [mem 0xb9000000-0xb9ffffff]
> pcieport 0000:5f:01.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]
> pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]: assigned
> 
> In this example we need to resize all the way up to the root port
> aperture, but we refuse to change the root port aperture while resources
> are allocated for the upstream port BAR.
> 
> The solution proposed here builds on the idea in commit 91fa127794ac
> ("PCI: Expose PCIe Resizable BAR support via sysfs") where the BAR can
> be resized while there is no driver attached.  In this case, when there
> is no driver bound to the upstream switch port we'll release resources
> of the bridge which match the reallocation.  Therefore we can achieve
> the below successful resize operation by unbinding 0000:5e:00.0 from the
> pcieport driver before invoking the resource2_resize interface on the
> GPU at 0000:60:00.0.

resource2_resize?  Oh, I guess this is the sysfs interface
(resourceN_resize, which leads to pci_resize_resource(), and in this
case we're resizing BAR 2 to 8GB, so it must have been something like
this?  (2 ^ (13+20) == 8G)

  # echo 0000:5f:01.0 > /sys/bus/pci/drivers/pcieport/unbind
  # echo 0000:5e:00.0 > /sys/bus/pci/drivers/pcieport/unbind
  # echo 0000:5d:00.0 > /sys/bus/pci/drivers/pcieport/unbind
  # echo 13 > /sys/bus/pci/devices/0000:60:00.0/resource2_resize

(Maybe we don't need 5d:00.0, since that looks like a Root Port and
doesn't have a BAR that needs to be released?)

And I guess we probably need to rebind pcieport afterwards so hotplug,
etc will work again?

> pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> pcieport 0000:5f:01.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> pci 0000:5e:00.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> pci 0000:5e:00.0: BAR 0 [mem 0xbff0000000-0xbff07fffff 64bit pref]: releasing
> pcieport 0000:5d:00.0: bridge window [mem 0xbfe0000000-0xbff07fffff 64bit pref]: releasing
> pcieport 0000:5d:00.0: bridge window [mem 0xb000000000-0xb2ffffffff 64bit pref]: assigned
> pci 0000:5e:00.0: bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]: assigned
> pci 0000:5e:00.0: BAR 0 [mem 0xb200000000-0xb2007fffff 64bit pref]: assigned
> pcieport 0000:5f:01.0: bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]: assigned
> pci 0000:60:00.0: BAR 2 [mem 0xb000000000-0xb1ffffffff 64bit pref]: assigned
> pci 0000:5e:00.0: PCI bridge to [bus 5f-61]
> pci 0000:5e:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> pci 0000:5e:00.0:   bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]
> pcieport 0000:5d:00.0: PCI bridge to [bus 5e-61]
> pcieport 0000:5d:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> pcieport 0000:5d:00.0:   bridge window [mem 0xb000000000-0xb2ffffffff 64bit pref]
> pci 0000:5e:00.0: PCI bridge to [bus 5f-61]
> pci 0000:5e:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> pci 0000:5e:00.0:   bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]
> pcieport 0000:5f:01.0: PCI bridge to [bus 60]
> pcieport 0000:5f:01.0:   bridge window [mem 0xb9000000-0xb9ffffff]
> pcieport 0000:5f:01.0:   bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/pci/setup-bus.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 909e6a7c3cc3..15fc8e4e84c9 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2226,6 +2226,26 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
>  }
>  EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
>  
> +static void pci_release_resource_type(struct pci_dev *pdev, unsigned long type)
> +{
> +	int i;
> +
> +	if (!device_trylock(&pdev->dev))
> +		return;
> +
> +	if (pdev->dev.driver)
> +		goto unlock;
> +
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		if (pci_resource_len(pdev, i) &&
> +		    !((pci_resource_flags(pdev, i) ^ type) & PCI_RES_TYPE_MASK))
> +			pci_release_resource(pdev, i);
> +	}
> +
> +unlock:
> +	device_unlock(&pdev->dev);
> +}
> +
>  int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
>  {
>  	struct pci_dev_resource *dev_res;
> @@ -2260,8 +2280,10 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
>  
>  			pci_info(bridge, "%s %pR: releasing\n", res_name, res);
>  
> -			if (res->parent)
> +			if (res->parent) {
>  				release_resource(res);
> +				pci_release_resource_type(bridge, type);
> +			}
>  			res->start = 0;
>  			res->end = 0;
>  			break;
> -- 
> 2.44.0
> 

