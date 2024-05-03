Return-Path: <linux-pci+bounces-7058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C8B8BB5A0
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 23:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3DD21F2463B
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 21:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E8C60BB6;
	Fri,  3 May 2024 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrjrSERt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A154277;
	Fri,  3 May 2024 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771423; cv=none; b=QtndpUMXsRBdYv/C3ARvo7G0TlHD2fMa5zt1elCrTbai7IF53xF/1nMHKdGuTXHDijc07YDgWmZdOqO2NdYQLse6Nd6JReMIRtcBtGuxpO+uz+3W5cCwCkyL2GRqED3ipfJ//Bdvf1uKsrmqDthgzZiZ025sen5iSyUvnt5PnXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771423; c=relaxed/simple;
	bh=WuczIjH4tQAgC9Izm+y0x4zUM7SPXPVvm0vjA/Nne4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qIQWaNGEVuY1oiMueNoLvM44f7+bTE6JLvLxyBv3DtDRODSarDGCPtEGL8nAGEwSRLD12bpOciUMYCpZdujsJ+GioJe6czWcmKGwZsI5Y+QeEk2/S142aspc9cBLkYbx+BIneSrvFrngmBnquRlLcw2lq3BKJW9AQ1EhOTzISeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrjrSERt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C981AC116B1;
	Fri,  3 May 2024 21:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714771423;
	bh=WuczIjH4tQAgC9Izm+y0x4zUM7SPXPVvm0vjA/Nne4Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jrjrSERtIFlnL87ivY3cR6O8rDFWw9X2Rh/Jqw50aegnY1bChtb/aEGgmiQvRDJuC
	 hXEp+dl4bkLwpfsmsncjLgOPVh5PaY+fwfcVUp9uVUISt7rdTnS+gz4qvN5Ke2UzBh
	 hqCuivJ1ljkbJZE/ZAhFh4zvnF2y6f/biGEIuTl6k2rGjRC4K+pUfHxrtxsIbpdVlK
	 rUmOXRDyNJdD6oC8LdKdnNb+puOKVQSAqvvPzHGEc6sYysweXIYtHVA8KWj0jZ1ZJl
	 IK5tIuOwVMt8ccupK5rVFxYm63BWvHmyGzLElJKPdMFuyxD9esO0BTc7UGkNLMHqsh
	 fZghs4MkwaYdg==
Date: Fri, 3 May 2024 16:23:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rajesh Shah <rajesh.shah@intel.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 2/4] PCI: pciehp: bail out if pci_hp_add_bridge() fails
Message-ID: <20240503212341.GA1604125@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401e4044e05d52e4243ca7faa65d5ec8b19526b8.1714762038.git.namcao@linutronix.de>

[+cc Lukas]

On Fri, May 03, 2024 at 09:23:20PM +0200, Nam Cao wrote:
> If there is no bus number available for the downstream bus of the
> hot-plugged bridge, pci_hp_add_bridge() will fail. The driver proceeds
> regardless, and the kernel crashes.
> 
> Abort if pci_hp_add_bridge() fails.

Thanks for this and for the details in the cover letter.  The cover
letter doesn't get directly preserved and connected to the git commit,
so please include some of the details here in the commit log.

I don't think we need *everything* from the cover letter; just enough
of the messages to show what went wrong and how the kernel crashed, so
somebody who trips over this can connect the crash with this fix.  And
the timestamps are not relevant, so you can strip them out.  The qemu
repro case is useful too, thanks for that!

Same for the shpchp patch.

And use "git log --oneline drivers/pci/hotplug/pciehp_pci.c" and match
the formatting (in particular, the capitalization) of your subject
lines.

> Fixes: 0eb3bcfd088e ("[PATCH] pciehp: allow bridged card hotplug")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: Rajesh Shah <rajesh.shah@intel.com>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/pci/hotplug/pciehp_pci.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
> index ad12515a4a12..faf4fcf2fbdf 100644
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -58,8 +58,13 @@ int pciehp_configure_device(struct controller *ctrl)
>  		goto out;
>  	}
>  
> -	for_each_pci_bridge(dev, parent)
> -		pci_hp_add_bridge(dev);
> +	for_each_pci_bridge(dev, parent) {
> +		if (pci_hp_add_bridge(dev)) {
> +			pci_stop_and_remove_bus_device(dev);
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +	}
>  
>  	pci_assign_unassigned_bridge_resources(bridge);
>  	pcie_bus_configure_settings(parent);
> -- 
> 2.39.2
> 

