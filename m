Return-Path: <linux-pci+bounces-15538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 557629B4E20
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 16:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156F1281BA5
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 15:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCFC19415D;
	Tue, 29 Oct 2024 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/9rUhkS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AF1A23;
	Tue, 29 Oct 2024 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216148; cv=none; b=mmFRK6c0GXRMzhtf5feTe5h1KEJP/pyV5v2WgGF/XhDeXrLrD0RAWgYADh8o6/hGe5e1TReNvOq0FT1NCaNq72SJ/WUqKFHiiF44W5aWQRI9kGcm0VSctJje6vdElCWrcX4qVolgc3hm4q2/CHddrO6Q2eRMbvW2q9vquQw8TJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216148; c=relaxed/simple;
	bh=m3sq7wXYLvTDYHbfRMB5UeUtoYck6rsjkP+zWtVTWso=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QjXiQdMcUf0Oe1rH+qyT49ZDz095tPddQtP2ckmWUpC1u9hBlqHiOEQOKUn1MyL853w82ACEdJvekcODPwRdKp6m13zrWvnskdHT8d6sPtP5+1Tfd/HjInK8kUfWpJnQG9VmsHRCSsO8/Hsa/DgtQTKgUqyki1FaGRVBKll0qDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/9rUhkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4044C4CECD;
	Tue, 29 Oct 2024 15:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730216148;
	bh=m3sq7wXYLvTDYHbfRMB5UeUtoYck6rsjkP+zWtVTWso=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=V/9rUhkSwmeb4TU+DpjHy53bTOaz+7d0lKjpQyy8Wbcfz+0/EINsQhS2CJAKRCly8
	 Ict46b77/vCzqINZMtP9m7wtcmoJpXRUCSLXyj4XuVdmjKyeR3dMGqjL0OCKhVj+gR
	 R4rjjEGiija7sI3FcQUZHHu4mOojN1Q1EQhR1ve7PAFwoA2zauvPod3uevfNKlnpuu
	 qCSxGvmYkEDlXxqnCrlfRoj0cqbGo1l+xF2lwZmzWSmBYYQc0DReT89ijZKmEr7mts
	 cfh6efqLNDlcwx6yyqfOzGghf1Av4VkspjhSu7cu4uZBO3Y4QI2ZzFO/wYyDnbtNsW
	 JmPaoWzyXbc1Q==
Date: Tue, 29 Oct 2024 10:35:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Markus.Elfring@web.de, quic_mrana@quicinc.com, rafael@kernel.org,
	m.szyprowski@samsung.com, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] PCI: Enable runtime pm of the host bridge
Message-ID: <20241029153546.GA1156846@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017-runtime_pm-v6-2-55eab5c2c940@quicinc.com>

On Thu, Oct 17, 2024 at 09:05:51PM +0530, Krishna chaitanya chundru wrote:
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

Earlier I asked about how we can verify that no other drivers need a
change like the starfive one:
https://lore.kernel.org/r/20241012140852.GA603197@bhelgaas

I guess this sentence is basically how we verify all drivers are safe
with this change?  

Since this patch adds devm_pm_runtime_enable() in pci_host_probe(),
can we expand this along the lines of this so it's more specific about
what we need to verify?

  Every host bridge driver must call pm_runtime_enable() before
  runtime PM is enabled by pci_host_probe().

Please correct me if that's not the right requirement.

> After this change, the host bridge device will be runtime-suspended
> by the runtime PM framework automatically after suspending its last
> child and it will be runtime-resumed automatically before resuming its
> first child which will allow the runtime PM framework to track
> dependencies between the host bridge device and all of its
> descendants.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
> Changes in v6:
> - no change
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
> -- 
> 2.34.1
> 

