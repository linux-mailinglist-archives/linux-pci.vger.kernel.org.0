Return-Path: <linux-pci+bounces-13791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3417E98F99E
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 00:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD611F2371B
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 22:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF5D1C7B6D;
	Thu,  3 Oct 2024 22:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EH+Ew4ed"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D311E1C2DB2;
	Thu,  3 Oct 2024 22:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993436; cv=none; b=ELGsO4KeH+v9v1zHd3UPpc2zrGmu6pBKREe4267abf7/9XAKxgBEjj69GA3XMpek/YQiKB25Tl89ahaqLGHqcEEalxZxtkzan3fNIyaTm9ae5tT8BbR1td8o7pZVSsoWMwnYAeDJx4b5h721pKfDxf1owJnS8WcGmj0UEoPTzuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993436; c=relaxed/simple;
	bh=MadVuRwfh5yDTb8GHcmeHrDGyQR1j2Mwx4Mzz3rndFk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AkNaOEL6Ipdk0hEhunFm5R8v2OB9sN4kXL51zGiBi3CVkCArdNN83HMzJ68eDfnqoBEMY12Eo9E/rofIUykxzhmq8gcbrRYD9aK3qM6qQoy/VnzdICjTsJVuHNGCsmx2IfV/s0CQG/GmUcXMRIwpho4mNgmdSZOCNBrYcuP8QEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EH+Ew4ed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9CBC4CEC5;
	Thu,  3 Oct 2024 22:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727993435;
	bh=MadVuRwfh5yDTb8GHcmeHrDGyQR1j2Mwx4Mzz3rndFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EH+Ew4ed9IHArjrYs1HV1urju/HuGP4XDPcMdXcjEELWmBj43BmlTrkg241eg4hCi
	 6oE8Jc3q3hg0EHHVk7E3g3M7RPp9pu1upwA/BPVdQUZ+Mnr+SEjM0M/k7MPF01P31M
	 IUFBPfNUsvm+hrY5U4na1Wa7OyBtSpJsbvyNO8B0x2FhSSNcHswD+yoNfhdjlgN7Lu
	 B8y/wWjLUyaoSQZ9yyAU3mDPkLYPumP35HNVh1sXngwI36pgkNymOWnUhHb7C6pLTv
	 FuzoW5XqXyJGink6A/yhin8Wtk421kv/uEUFL8Ajfip2MtkhmhRZARG7JXEAP6WFNA
	 ARei4DOMVgSdA==
Date: Thu, 3 Oct 2024 17:10:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, manivannan.sadhasivam@linaro.org,
	Markus.Elfring@web.de, quic_mrana@quicinc.com, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_ramkri@quicinc.com
Subject: Re: [PATCH v5] PCI: Enable runtime pm of the host bridge
Message-ID: <20241003221033.GA327855@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003-runtime_pm-v5-1-3ebd1a395d45@quicinc.com>

On Thu, Oct 03, 2024 at 11:32:32AM +0530, Krishna chaitanya chundru wrote:
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
> will find it to be disabled. So it will allow the parent (controller
> device) to go to runtime suspend. Only if the child device's state was
> 'active' it will prevent the parent to get suspended.
> 
> It is a property of the runtime PM framework that it can only
> follow continuous dependency chains.  That is, if there is a device
> with runtime PM disabled in a dependency chain, runtime PM cannot be
> enabled for devices below it and above it in that chain both at the
> same time.
> 
> Since runtime PM is disabled for host bridge, the state of the child
> devices under the host bridge is not taken into account by PM framework
> for the top level parent, PCIe controller. So PM framework, allows
> the controller driver to enter runtime PM irrespective of the state
> of the devices under the host bridge. And this causes the topology
> breakage and also possible PM issues like controller driver goes to
> runtime suspend while endpoint driver is doing some transfers.
> 
> Because of the above, in order to enable runtime PM for a PCIe
> controller device, one needs to ensure that runtime PM is enabled for
> all devices in every dependency chain between it and any PCIe endpoint
> (as runtime PM is enabled for PCIe endpoints).
> 
> This means that runtime PM needs to be enabled for the host bridge
> device, which is present in all of these dependency chains.
> 
> After this change, the host bridge device will be runtime-suspended
> by the runtime PM framework automatically after suspending its last
> child and it will be runtime-resumed automatically before resuming its
> first child which will allow the runtime PM framework to track
> dependencies between the host bridge device and all of its
> descendants.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to pci/pm for v6.13, thanks for your patience is working
through this!

> ---
> Changes in v5:
> - call pm_runtime_no_callbacks() as suggested by Rafael.
> - include the commit texts as suggested by Rafael.
> - Link to v4: https://lore.kernel.org/linux-pci/20240708-runtime_pm-v4-1-c02a3663243b@quicinc.com/
> Changes in v4:
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
>  drivers/pci/probe.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4f68414c3086..8409e1dde0d1 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3106,6 +3106,11 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>  		pcie_bus_configure_settings(child);
>  
>  	pci_bus_add_devices(bus);
> +
> +	pm_runtime_set_active(&bridge->dev);
> +	pm_runtime_no_callbacks(&bridge->dev);
> +	devm_pm_runtime_enable(&bridge->dev);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_host_probe);
> 
> ---
> base-commit: c02d24a5af66a9806922391493205a344749f2c4
> change-id: 20241003-runtime_pm-655d48356c8b
> 
> Best regards,
> -- 
> Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 

