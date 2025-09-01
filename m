Return-Path: <linux-pci+bounces-35223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F8CB3D907
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 07:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8149C3BB71B
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 05:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3B4242917;
	Mon,  1 Sep 2025 05:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ix0Z3xcy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF7B23F40D;
	Mon,  1 Sep 2025 05:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756705712; cv=none; b=cblJpRIZF5v14PgYhyYZczRWJFQIz2BgyxR/O4jRS+xEoREAJbgYJ7/7J3mR23jsbozS2LbPxVfavoRn9mc582o8zIFjiyZPMk398bHwhm6+xD/xaZRCyrldHFXXuvPYd6ynafLOqS/kJ/eUNCX49NFu/2hFsDY4jCaQvflkppI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756705712; c=relaxed/simple;
	bh=KGRAIByVMvQoYHbe0Wfm9mSqDggNUsNczmX3xKAry2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gexkr3jMP0g0Oa56Q6H2HTOW/1yMatfb1uJVDHti+d+sgzC/EaRqwzV4JF6ZXapzOxXYT83gNsMyisOE6ls5C3mJXXH0wCUVQs2CThnoEe219e9E2N4wPAal+zH5xBPWsigsmuaxX7GEVWVdih58jNrBzZEhm1kOE5oWH4c+Hnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ix0Z3xcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE55EC4CEF7;
	Mon,  1 Sep 2025 05:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756705711;
	bh=KGRAIByVMvQoYHbe0Wfm9mSqDggNUsNczmX3xKAry2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ix0Z3xcyMCEAazztA5hZ9vWWKOjO/h142DnZcxy1OJz2F3EsKcUmrWzq2jnQUfxMC
	 T/keb07pZDG1d5Q7AzxV1wf/O7HE/sIZjeEn/oDD+dOsWrWH6VyBaJPZtoJ89AUozt
	 UKLybJCgA/OcNU3Qm2Y63b9MrEjywTMYQGYsCEKPnEYY9GzB67TGkyueluP8NymzcO
	 ZssXbq6Ij5VzNc9807QtKoy98H9/drV+xwmxI7BU/0WINWUzR67p10ieg13ldid5nD
	 spCbdp3sC1D0uWh4SKo926pHk5IZul1bEnUcyQXIF/3a1nPvROIgFcL0hPO4WGmIOn
	 /wiUFYn3JzwzA==
Date: Mon, 1 Sep 2025 11:18:23 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, helgaas@kernel.org, kishon@kernel.org, vigneshr@ti.com, 
	stable@vger.kernel.org, linux-pci@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v3] PCI: j721e: Fix programming sequence of "strap"
 settings
Message-ID: <z3ubracmtlq23yicbrhqjgnzrfoqheffm6cvhfnawlvbu4cmmp@ddu2o7xhw5tz>
References: <20250829091707.2990211-1-s-vadapalli@ti.com>
 <oztilfun77apxtjxumx4tydkcd2gsalsak4m2rvsry2oooqjna@2yvcx6cnuemm>
 <b2fb9252-6bfc-45da-973a-31cdfcc86b3d@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2fb9252-6bfc-45da-973a-31cdfcc86b3d@ti.com>

On Mon, Sep 01, 2025 at 10:27:51AM GMT, Siddharth Vadapalli wrote:
> On Sun, Aug 31, 2025 at 06:15:13PM +0530, Manivannan Sadhasivam wrote:
> 
> Hello Mani,
> 
> > On Fri, Aug 29, 2025 at 02:46:28PM GMT, Siddharth Vadapalli wrote:
> > > The Cadence PCIe Controller integrated in the TI K3 SoCs supports both
> > > Root-Complex and Endpoint modes of operation. The Glue Layer allows
> > > "strapping" the Mode of operation of the Controller, the Link Speed
> > > and the Link Width. This is enabled by programming the "PCIEn_CTRL"
> > > register (n corresponds to the PCIe instance) within the CTRL_MMR
> > > memory-mapped register space. The "reset-values" of the registers are
> > > also different depending on the mode of operation.
> > > 
> > > Since the PCIe Controller latches onto the "reset-values" immediately
> > > after being powered on, if the Glue Layer configuration is not done while
> > > the PCIe Controller is off, it will result in the PCIe Controller latching
> > > onto the wrong "reset-values". In practice, this will show up as a wrong
> > > representation of the PCIe Controller's capability structures in the PCIe
> > > Configuration Space. Some such capabilities which are supported by the PCIe
> > > Controller in the Root-Complex mode but are incorrectly latched onto as
> > > being unsupported are:
> > > - Link Bandwidth Notification
> > > - Alternate Routing ID (ARI) Forwarding Support
> > > - Next capability offset within Advanced Error Reporting (AER) capability
> > > 
> > > Fix this by powering off the PCIe Controller before programming the "strap"
> > > settings and powering it on after that.
> > > 
> > > Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > ---
> > > 
> > > Hello,
> > > 
> > > This patch is based on commit
> > > 07d9df80082b Merge tag 'perf-tools-fixes-for-v6.17-2025-08-27' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools
> > > of Mainline Linux.
> > > 
> > > v2 of this patch is at:
> > > https://lore.kernel.org/r/20250819101336.292013-1-s-vadapalli@ti.com/
> > > Changes since v2:
> > > - Based on Bjorn's feedback at:
> > >   https://lore.kernel.org/r/20250819221748.GA598958@bhelgaas/
> > >   1) Commit message has been rephrased to summarize the issue and the
> > >   fix without elaborating too much on the details.
> > >   2) Description of the issue's symptoms noticeable by a user has been
> > >   added to the commit message.
> > >   3) Comment has been wrapped to fit within 80 columns.
> > >   4) The implementation has been simplified by moving the Controller
> > >   Power OFF and Power ON sequence into j721e_pcie_ctrl_init() as a
> > >   result of which the code reordering as well as function parameter
> > >   changes are no longer required.
> > > - Based on offline feedback from Vignesh, Runtime PM APIs are used
> > >   instead of PM DOMAIN APIs to power off and power on the PCIe
> > >   Controller.
> > > - Rebased patch on latest Mainline Linux.
> > > 
> > > Test Logs on J7200 EVM without the current patch applied show that the
> > > ARI Forwarding Capability incorrectly shows up as not being supported:
> > > https://gist.github.com/Siddharth-Vadapalli-at-TI/768bca36025ed630c4e69bcc3d94501a
> > > 
> > > Test Logs on J7200 EVM with the current patch applied show that the
> > > ARI Forwarding Capability correctly shows up as being supported:
> > > https://gist.github.com/Siddharth-Vadapalli-at-TI/fc1752d17140646c8fa57209eccd86ce
> > > 
> > > As explained in the commit message, this discrepancy is solely due to
> > > the PCIe Controller latching onto the incorrect reset-values which
> > > occurs when the strap settings are programmed after the PCIe Controller
> > > is powered on, at which point, the reset-values don't toggle anymore.
> > > 
> > > Regards,
> > > Siddharth.
> > > 
> > >  drivers/pci/controller/cadence/pci-j721e.c | 22 ++++++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> > > index 6c93f39d0288..c178b117215a 100644
> > > --- a/drivers/pci/controller/cadence/pci-j721e.c
> > > +++ b/drivers/pci/controller/cadence/pci-j721e.c
> > > @@ -284,6 +284,22 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
> > >  	if (!ret)
> > >  		offset = args.args[0];
> > >  
> > > +	/*
> > > +	 * The PCIe Controller's registers have different "reset-values"
> > > +	 * depending on the "strap" settings programmed into the PCIEn_CTRL
> > > +	 * register within the CTRL_MMR memory-mapped register space.
> > > +	 * The registers latch onto a "reset-value" based on the "strap"
> > > +	 * settings sampled after the PCIe Controller is powered on.
> > > +	 * To ensure that the "reset-values" are sampled accurately, power
> > > +	 * off the PCIe Controller before programming the "strap" settings
> > > +	 * and power it on after that.
> > > +	 */
> > > +	ret = pm_runtime_put_sync(dev);
> > > +	if (ret < 0) {
> > > +		dev_err(dev, "Failed to power off PCIe Controller\n");
> > > +		return ret;
> > > +	}
> > 
> > How does the controller gets powered off after pm_runtime_put_sync() since you
> > do not have runtime PM callbacks? I believe the parent is turning off the power
> > domain?
> 
> By invoking 'pm_runtime_put_sync(dev)', the ref-count is being
> decremented and it results in the device being powered off. I have
> verified it by printing the power domain index within the functions for
> powering off and powering on devices on the J7200 SoC. Logs:
> 
> 	root@j7200-evm:~# modprobe pci_j721e
> 	[   25.231675] [Powering On]: 240
> 	[   25.234848] j721e-pcie 2910000.pcie: host bridge /bus@100000/pcie@2910000 ranges:
> 	[   25.242378] j721e-pcie 2910000.pcie:       IO 0x4100001000..0x4100100fff -> 0x0000001000
> 	[   25.250496] j721e-pcie 2910000.pcie:      MEM 0x4100101000..0x41ffffffff -> 0x0000101000
> 	[   25.258588] j721e-pcie 2910000.pcie:   IB MEM 0x0000000000..0xffffffffffff -> 0x0000000000
> 	[   25.267098] [Powering Off]: 240
> 	[   25.270318] [Powering On]: 240
> 	[   25.273511] [Powering On]: 187
> 	[   26.372361] j721e-pcie 2910000.pcie: PCI host bridge to bus 0000:00
> 	[   26.378666] pci_bus 0000:00: root bus resource [bus 00-ff]
> 	[   26.384156] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus address [0x1000-0x100fff])
> 	[   26.393197] pci_bus 0000:00: root bus resource [mem 0x4100101000-0x41ffffffff] (bus address [0x00101000-0xffffffff])
> 	[   26.403728] pci 0000:00:00.0: [104c:b00f] type 01 class 0x060400 PCIe Root Port
> 	[   26.411044] pci 0000:00:00.0: PCI bridge to [bus 00]
> 	[   26.416009] pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
> 	[   26.422091] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
> 	[   26.428874] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> 	[   26.436676] pci 0000:00:00.0: supports D1
> 	[   26.440699] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
> 	[   26.448064] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> 	[   26.456274] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> 	[   26.462923] pci 0000:00:00.0: PCI bridge to [bus 01]
> 	[   26.467933] pci_bus 0000:00: resource 4 [io  0x0000-0xfffff]
> 	[   26.473595] pci_bus 0000:00: resource 5 [mem 0x4100101000-0x41ffffffff]
> 	[   26.480337] pcieport 0000:00:00.0: of_irq_parse_pci: failed with rc=-22
> 	[   26.487479] pcieport 0000:00:00.0: PME: Signaling with IRQ 701
> 	[   26.493909] pcieport 0000:00:00.0: AER: enabled with IRQ 701
> 
> In the above logs, '240' is the Power Domain Index for the PCIe
> Controller on J7200 SoC. It is powered on initially before the driver is
> probed.

In that case, the driver should not call pm_runtime_get_sync() in its probe.
What it should do is:

	pm_runtime_set_active()
	pm_runtime_enable()

But the driver is supporting several SoC variants. Does the bootloader enable
PCIe controller for all of them?

> During driver probe, we see the logs corresponding to
> "devm_pci_alloc_host_bridge()" from the timestamp of '25.234848' which
> is prior to the invocation of 'j721e_pcie_ctrl_init()'. Some time around
> the '25.267098' timestamp, the 'j721e_pcie_ctrl_init()' function is
> invoked which then decrements the ref-count via 'pm_runtime_put_sync(dev)'
> leading to the PCIe Controller being powered off. This seems to be
> consistent across boot unlike the usage of 'dev_pm_domain_detach' which
> handles the device power off via a workqueue as a result of which it may
> not be powered off yet when 'j721e_pcie_ctrl_init()' is programming the
> strap settings. Hence, I switched from 'dev_pm_domain_detach()' to
> 'pm_runtime_put_sync()' in the v3 patch.
> 

No using dev_pm_domain_detach() is a wrong approach.

> Please let me know if you have any suggestions for alternative means to
> power off the device in a reliable manner without deferring it to a
> workqueue as done by the 'dev_pm_domain_detach()' API.
> 

Using pm_runtime_put_sync() is the correct way, but the comment and patch
description needs to be improved. In the comment, you are claiming that
pm_runtime_put_sync() will power off the controller, even though it is true, it
is not clear who is responsible for doing that. So reword it to reflect the fact
that the power domain (genpd?) will turn off the controller.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

