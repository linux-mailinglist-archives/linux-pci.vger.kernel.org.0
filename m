Return-Path: <linux-pci+bounces-19771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 195DAA112D9
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 22:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2928A166E56
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 21:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05BB209F47;
	Tue, 14 Jan 2025 21:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCz5E6dJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA4E1FC7FE;
	Tue, 14 Jan 2025 21:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736889416; cv=none; b=RtpgWCK+aBh4iJXob8lP+RpB/M2St0wBJBN7zqb7n0ey5vFGG8rQlJOUHC5mzqIVTna6bjAi0B1IU122a15c1rzQTHOgSewnSprQo4Cud8dmKXyhaU6ePbfqM2F2lN4wiN+gnMdkG8aBjywv9zyetNzjsbC57USOi/DfPToPCAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736889416; c=relaxed/simple;
	bh=UcyyUw1NL2zJARRiyOt9twFY5flZXJf4yqpIFYxTQWo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ItRnbt6xmt84ptTJzKfBEvqhy/Dd4nZ6DwoO6TOJzvjZZ9KJc6kkLp/Sb1H827qBPoPXpJlHVTjWoF4ipWjO8ASj/RHrlEqK2jgixw+fS2sjLgjGfRs/+lSyW59d2C73xjHHpJ8TfbsEjjLiIR/qUgQ7jr1G+dQoxm6TaEXY7t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCz5E6dJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318BBC4CEE0;
	Tue, 14 Jan 2025 21:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736889416;
	bh=UcyyUw1NL2zJARRiyOt9twFY5flZXJf4yqpIFYxTQWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XCz5E6dJpITBeUKsfy6WjKJr9t5zkZ/JyRhPloWcQlrBmej06S/2NoGA7b/KRaR4F
	 QTJDrrRk1O4tPxNYiPc+iuqtFNMITvU6d+GW5+YisKV8y532dfZJgIyUuARWxJzOu4
	 3zih0DUdn8WTd1jnxOxPEzCgvpoPl3T3uhh5+ZPPLcYQj29xm47wXky5dYKmwOI+ef
	 +AoVBGxOh2/rWJtClmCXaU5VPCIHOVx5hHOFxRPuD3Y0GVTRHmcKLeyZCGV0202q1R
	 UT4sWMq5tzC6mXI627KRvYwGymLbiMxRvIa0fkYxddHGY/UCPE7M0C2OJZQh8YdyHG
	 K1WfrGI+vVBig==
Date: Tue, 14 Jan 2025 15:16:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: rafael@kernel.org, ulf.hansson@linaro.org,
	Johan Hovold <johan@kernel.org>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Markus.Elfring@web.de, quic_mrana@quicinc.com,
	m.szyprowski@samsung.com, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH v7 2/2] PCI: Enable runtime pm of the host bridge
Message-ID: <20250114211653.GA487608@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113162549.a2y7dlwnsfetryyw@thinkpad>

On Mon, Jan 13, 2025 at 09:55:49PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Jan 07, 2025 at 03:27:59PM +0100, Johan Hovold wrote:
> > On Tue, Jan 07, 2025 at 07:40:39PM +0530, Krishna Chaitanya Chundru wrote:
> > > On 1/7/2025 6:49 PM, Johan Hovold wrote:
> > 
> > > >> @@ -3106,6 +3106,17 @@ int pci_host_probe(struct pci_host_bridge *bridge)
> > > >>   		pcie_bus_configure_settings(child);
> > > >>   
> > > >>   	pci_bus_add_devices(bus);
> > > >> +
> > > >> +	/*
> > > >> +	 * Ensure pm_runtime_enable() is called for the controller drivers,
> > > >> +	 * before calling pci_host_probe() as pm frameworks expects if the
> > > >> +	 * parent device supports runtime pm then it needs to enabled before
> > > >> +	 * child runtime pm.
> > > >> +	 */
> > > >> +	pm_runtime_set_active(&bridge->dev);
> > > >> +	pm_runtime_no_callbacks(&bridge->dev);
> > > >> +	devm_pm_runtime_enable(&bridge->dev);
> > > >> +
> > > >>   	return 0;
> > > >>   }
> > > >>   EXPORT_SYMBOL_GPL(pci_host_probe);
> > > > 
> > > > I just noticed that this change in 6.13-rc1 is causing the
> > > > following warning on resume from suspend on machines like the
> > > > Lenovo ThinkPad X13s:
> > 
> > > Can you confirm if you are seeing this issue is seen in the
> > > boot-up case also. As this part of the code executes only at the
> > > boot time and will not have effect in resume from suspend.
> > 
> > No, I only see it during resume. And enabling runtime PM can (and
> > in this case, obviously does) impact system suspend as well. 
> > 
> > > > 	pci0004:00: pcie4: Enabling runtime PM for inactive device with active children
> > 
> > > I believe this is not causing any functional issues.
> > 
> > It still needs to be fixed.
> > 
> > > > which may have unpopulated ports (this laptop SKU does not
> > > > have a modem).
> > 
> > > Can you confirm if this warning goes away if there is some
> > > endpoint connected to it.
> > 
> > I don't have anything to connect to the slot in this machine, but
> > this seems to be the case as I do not see this warning for the
> > populated slots, nor on the CRD reference design which has a modem
> > on PCIe4.
> 
> Yes, this is only happening for unpopulated slots and the warning
> shows up only if runtime PM is enabled for both PCI bridge and host
> bridge. This patch enables the runtime PM for host bridge and if the
> PCI bridge runtime PM is also enabled (only happens now for
> ACPI/BIOS based platforms), then the warning shows up only if the
> PCI bridge was RPM suspended (mostly happens if there was no device
> connected) during the system wide resume time.
> 
> For the sake of reference, PCI host bridge is the parent of PCI
> bridge.
> 
> Looking at where the warning gets triggered (in
> pm_runtime_enable()), we have the below checks:
> 
> dev->power.runtime_status == RPM_SUSPENDED
> !dev->power.ignore_children
> atomic_read(&dev->power.child_count) > 0
> 
> When pm_runtime_enable() gets called for PCI host bridge:
> 
> dev->power.runtime_status = RPM_SUSPENDED
> dev->power.ignore_children = 0
> dev->power.child_count = 1
> 
> First 2 passes seem legit, but the issue is with the 3rd one. Here,
> the child_count of 1 means that the PCI host bridge has an 'active'
> child (which is the PCI bridge). The PCI bridge was supposed to be
> RPM_SUSPENDED as the resume process should first resume the parent
> (PCI host bridge). But this is not the case here.
> 
> Then looking at where the child_count gets incremented, it leads to
> pm_runtime_set_active() of device_resume_noirq().
> pm_runtime_set_active() is only called for a device if
> dev_pm_skip_suspend() succeeds, which requires
> DPM_FLAG_SMART_SUSPEND flag to be set and the device to be runtime
> suspended.
> 
> This criteria matches for PCI bridge. So its status was set to
> 'RPM_ACTIVE' even though the parent PCI host bridge was still in the
> RPM_SUSPENDED state. I don't think this is a valid condition as seen
> from the warning triggered for PCI host bridge when
> pm_runtime_enable() is called from device_resume_early():
> 
> pci0004:00: pcie4: Enabling runtime PM for inactive device with
> active children
> 
> I'm not sure of what the fix is in this case. But removing the
> DPM_FLAG_SMART_SUSPEND flag from PCI bridge driver (portdrv) makes
> the warning go away. This indicates that something is wrong with the
> DPM_FLAG_SMART_SUSPEND flag handling in PM core.
> 
> Ulf/Rafael, thoughts?

What's the plan for this?  Does anybody have a proposal?

IIUC there is no functional issue, but the new warning must be fixed,
and it would sure be nice to do it before v6.13.  If there *is* a
functional problem, we need to consider a revert ASAP.

Bjorn

