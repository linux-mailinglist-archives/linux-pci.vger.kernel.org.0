Return-Path: <linux-pci+bounces-11775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5F69551FF
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 22:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6C41F22A5D
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 20:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940A213A24A;
	Fri, 16 Aug 2024 20:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVD/b/AU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645BE12A177;
	Fri, 16 Aug 2024 20:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723841142; cv=none; b=lYaHWguifTU5D5L3nbYLu20pHZ9xV5mvOZ2RFyisx7zx5y7Wnm9IxPWa2uHlgGrbE5UZVZTd4nSkuQjW4EC091fAmU56TET1qmKY9wj5wQZJAOUwronrUvvWYl8fzf+zv/Io0amD/PY++oQEeOXeBZxQiSEGPotYDKP0NgiZOeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723841142; c=relaxed/simple;
	bh=oey1uJwMO65z17ZUgy7+gOJgyBWHGuTpjRJ7SJ+e0ds=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TJDTXobiyafsJqzEIutsSu8mUdpAWUyzTfK+t6vLSPcU8D58+oR5L1ea2WkggB7UNb5vj3SRzwGb409U8wBZ6o/IGLjrV+ikdeo7Re6oFRAARaQzknPAf68Or6O0Fiao0IS0LChdWHxhA5dgmRBlve6M2WNmhGAT9uJ4ApbC5jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVD/b/AU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9797CC32782;
	Fri, 16 Aug 2024 20:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723841141;
	bh=oey1uJwMO65z17ZUgy7+gOJgyBWHGuTpjRJ7SJ+e0ds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iVD/b/AU/aVSErTcqPQk5uiFdEzaEfwj0ij/p0yeOSMopt2jzn8AWwi2nyk0+M82Y
	 GV//N5U0+9YNyyf0E2pzaxpTC86QBFSQnIrGmW1pV9Z2gCIRtU2sEqN1cZScrROh2Y
	 pZojj1FvGhS1SNJ/PPSR6BuCXkQicZzwxq9/T3eLPaZQzbuClzgZ+CPCE6Y3rPhhS3
	 kGnA1RDtBOE2IgIgvSv8QFIYFjsDApm6hdI87BM6cw0UXbC48RHvOUvq1HFMLTVu7Y
	 IMLEIA8uSI2cmcNJNDXsffs3NE3g3pXasmOE8oSVl0dWHYnWJ4p93eiLrbEtGa5mKq
	 CTbnLZn/PvhFA==
Date: Fri, 16 Aug 2024 15:45:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_parass@quicinc.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Mayank Rana <quic_mrana@quicinc.com>,
	Markus Elfring <Markus.Elfring@web.de>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4] PCI: Enable runtime pm of the host bridge
Message-ID: <20240816204539.GA73302@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708-runtime_pm-v4-1-c02a3663243b@quicinc.com>

[+cc Rafael, Mayank, Markus (when people have commented on previous
versions, please cc them on new versions).  I'm still hoping Rafael
will have a chance to chime in]

On Mon, Jul 08, 2024 at 10:19:40AM +0530, Krishna chaitanya chundru wrote:
> The Controller driver is the parent device of the PCIe host bridge,
> PCI-PCI bridge and PCIe endpoint as shown below.
> 
>         PCIe controller(Top level parent & parent of host bridge)
>                         |
>                         v
>         PCIe Host bridge(Parent of PCI-PCI bridge)
>                         |
>                         v
>         PCI-PCI bridge(Parent of endpoint driver)
>                         |
>                         v
>                 PCIe endpoint driver
> 
> Now, when the controller device goes to runtime suspend, PM framework
> will check the runtime PM state of the child device (host bridge) and
> will find it to be disabled.

I guess "will find it to be disabled"  means the child (host bridge)
has runtime PM disabled, not that the child device is disabled, right?

> So it will allow the parent (controller
> device) to go to runtime suspend. Only if the child device's state was
> 'active' it will prevent the parent to get suspended.

Can we include a hint like the name of the function where the PM
framework decides this?  Maybe this is rpm_check_suspend_allowed()?

rpm_check_suspend_allowed()  checks ".ignore_children", which sounds
like it could be related, and AFAICS .ignore_children == false here,
so .child_count should be relevant.

But I'm still confused about why we can runtime suspend a bridge that
leads to devices that are not suspended.

> Since runtime PM is disabled for host bridge, the state of the child
> devices under the host bridge is not taken into account by PM framework
> for the top level parent, PCIe controller. So PM framework, allows
> the controller driver to enter runtime PM irrespective of the state
> of the devices under the host bridge. And this causes the topology
> breakage and also possible PM issues like controller driver goes to
> runtime suspend while endpoint driver is doing some transfers.

What does "topology breakage" mean?  Do you mean something other than
the fact that an endpoint DMA might fail if the controller is
suspended?

> So enable runtime PM for the host bridge, so that controller driver
> goes to suspend only when all child devices goes to runtime suspend.

IIUC, the one-sentence description here is that previously, the PCI
host controller could be runtime suspended even while an endpoint was
active, which caused DMA failures.  And this patch changes that so the
host controller is only runtime suspended after the entire hierarchy
below it is runtime suspended?  Is that right?

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
> Changes in v4:

(Note: v4 applies cleanly to v6.10-rc1 and to v6.11-rc1 with a small
offset).

> - Changed pm_runtime_enable() to devm_pm_runtime_enable() (suggested by mayank)
> - Link to v3: https://lore.kernel.org/lkml/20240609-runtime_pm-v3-1-3d0460b49d60@quicinc.com/
> Changes in v3:
> - Moved the runtime API call's from the dwc driver to PCI framework
>   as it is applicable for all (suggested by mani)
> - Updated the commit message.
> - Link to v2: https://lore.kernel.org/all/20240305-runtime_pm_enable-v2-1-a849b74091d1@quicinc.com
> Changes in v2:
> - Updated commit message as suggested by mani.
> - Link to v1: https://lore.kernel.org/r/20240219-runtime_pm_enable-v1-1-d39660310504@quicinc.com
> ---
> 
> ---
>  drivers/pci/probe.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8e696e547565..fd49563a44d9 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3096,6 +3096,10 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>  	}
>  
>  	pci_bus_add_devices(bus);
> +
> +	pm_runtime_set_active(&bridge->dev);
> +	devm_pm_runtime_enable(&bridge->dev);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_host_probe);
> 
> ---
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> change-id: 20240708-runtime_pm-978ccbca6130
> 
> Best regards,
> -- 
> Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 

