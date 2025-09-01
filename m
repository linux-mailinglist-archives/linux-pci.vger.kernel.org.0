Return-Path: <linux-pci+bounces-35238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A78B3D9CC
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 08:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80304189A0D4
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 06:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A7825333F;
	Mon,  1 Sep 2025 06:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jkTlsK7A"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B53F2512E6;
	Mon,  1 Sep 2025 06:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707705; cv=none; b=frGDSMH7IfOVvUwDMJ5JI1AHWpXyDjEVnzV3fB42o0NWTpfm9sc83VGhmt/0Q1rL0Nbs8NJSWWQ1V8zrnc/iG8l4n5eudlVhpOT3LK9MacEHlWXtbM3tikog4WIq+0koMpRYoTobp/IqlqDI1dznZM/dhAgrTjcE+EBYjBKMT7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707705; c=relaxed/simple;
	bh=zJIoTQ+OBKR6lMmFXzL/vGoic61Ww0sio7H/UXOvu24=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXBF+1plMsL/JqIetQjcFm+IAnd+vdNrc1c718G3jhz0QGtOuMvXT2Gwh/wjyHXN4TM93au/wkqIJNF9pjg6PJpPvZ+TcVtkgoqZwCqoex3v2R96WA9LUno0TQ4y1ezqLbt199qPFWpMZ3rRVf8aWXfeNgU09NZB1rlxiyEH+RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jkTlsK7A; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5816LZvY2308921;
	Mon, 1 Sep 2025 01:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756707695;
	bh=qreIBgZ+kNPapYkn/w3LaOI9NCnN05ikE9S+1+Lf2RQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=jkTlsK7A3IShODXKDyFQ6ixq2nACqv4zHQIWHf0k+0MNYYTofxM4t0pSE7fqGwaRD
	 JPIJSawUG4AMvFpFLFsEnQ6D/nkmZq5sIOavLdojcX+FPjMIduVnUrgG/dnn+Nt5W0
	 m7sGawWWR6IypPbK2NnXjwl4p5F/s/UsJJYM+O/o=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5816LZxB1906194
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 1 Sep 2025 01:21:35 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 1
 Sep 2025 01:21:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 1 Sep 2025 01:21:34 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5816LXZr1719686;
	Mon, 1 Sep 2025 01:21:34 -0500
Date: Mon, 1 Sep 2025 11:51:33 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <robh@kernel.org>, <bhelgaas@google.com>,
        <helgaas@kernel.org>, <kishon@kernel.org>, <vigneshr@ti.com>,
        <stable@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v3] PCI: j721e: Fix programming sequence of "strap"
 settings
Message-ID: <48e9d897-2cd3-48ef-b46a-635ae75f5ac6@ti.com>
References: <20250829091707.2990211-1-s-vadapalli@ti.com>
 <oztilfun77apxtjxumx4tydkcd2gsalsak4m2rvsry2oooqjna@2yvcx6cnuemm>
 <b2fb9252-6bfc-45da-973a-31cdfcc86b3d@ti.com>
 <z3ubracmtlq23yicbrhqjgnzrfoqheffm6cvhfnawlvbu4cmmp@ddu2o7xhw5tz>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <z3ubracmtlq23yicbrhqjgnzrfoqheffm6cvhfnawlvbu4cmmp@ddu2o7xhw5tz>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Mon, Sep 01, 2025 at 11:18:23AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Sep 01, 2025 at 10:27:51AM GMT, Siddharth Vadapalli wrote:
> > On Sun, Aug 31, 2025 at 06:15:13PM +0530, Manivannan Sadhasivam wrote:
> > 
> > Hello Mani,
> > 
> > > On Fri, Aug 29, 2025 at 02:46:28PM GMT, Siddharth Vadapalli wrote:

[...]

> > > > +	/*
> > > > +	 * The PCIe Controller's registers have different "reset-values"
> > > > +	 * depending on the "strap" settings programmed into the PCIEn_CTRL
> > > > +	 * register within the CTRL_MMR memory-mapped register space.
> > > > +	 * The registers latch onto a "reset-value" based on the "strap"
> > > > +	 * settings sampled after the PCIe Controller is powered on.
> > > > +	 * To ensure that the "reset-values" are sampled accurately, power
> > > > +	 * off the PCIe Controller before programming the "strap" settings
> > > > +	 * and power it on after that.
> > > > +	 */
> > > > +	ret = pm_runtime_put_sync(dev);
> > > > +	if (ret < 0) {
> > > > +		dev_err(dev, "Failed to power off PCIe Controller\n");
> > > > +		return ret;
> > > > +	}
> > > 
> > > How does the controller gets powered off after pm_runtime_put_sync() since you
> > > do not have runtime PM callbacks? I believe the parent is turning off the power
> > > domain?
> > 
> > By invoking 'pm_runtime_put_sync(dev)', the ref-count is being
> > decremented and it results in the device being powered off. I have
> > verified it by printing the power domain index within the functions for
> > powering off and powering on devices on the J7200 SoC. Logs:
> > 
> > 	root@j7200-evm:~# modprobe pci_j721e
> > 	[   25.231675] [Powering On]: 240
> > 	[   25.234848] j721e-pcie 2910000.pcie: host bridge /bus@100000/pcie@2910000 ranges:
> > 	[   25.242378] j721e-pcie 2910000.pcie:       IO 0x4100001000..0x4100100fff -> 0x0000001000
> > 	[   25.250496] j721e-pcie 2910000.pcie:      MEM 0x4100101000..0x41ffffffff -> 0x0000101000
> > 	[   25.258588] j721e-pcie 2910000.pcie:   IB MEM 0x0000000000..0xffffffffffff -> 0x0000000000
> > 	[   25.267098] [Powering Off]: 240
> > 	[   25.270318] [Powering On]: 240
> > 	[   25.273511] [Powering On]: 187
> > 	[   26.372361] j721e-pcie 2910000.pcie: PCI host bridge to bus 0000:00
> > 	[   26.378666] pci_bus 0000:00: root bus resource [bus 00-ff]
> > 	[   26.384156] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus address [0x1000-0x100fff])
> > 	[   26.393197] pci_bus 0000:00: root bus resource [mem 0x4100101000-0x41ffffffff] (bus address [0x00101000-0xffffffff])
> > 	[   26.403728] pci 0000:00:00.0: [104c:b00f] type 01 class 0x060400 PCIe Root Port
> > 	[   26.411044] pci 0000:00:00.0: PCI bridge to [bus 00]
> > 	[   26.416009] pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
> > 	[   26.422091] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
> > 	[   26.428874] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> > 	[   26.436676] pci 0000:00:00.0: supports D1
> > 	[   26.440699] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
> > 	[   26.448064] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> > 	[   26.456274] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> > 	[   26.462923] pci 0000:00:00.0: PCI bridge to [bus 01]
> > 	[   26.467933] pci_bus 0000:00: resource 4 [io  0x0000-0xfffff]
> > 	[   26.473595] pci_bus 0000:00: resource 5 [mem 0x4100101000-0x41ffffffff]
> > 	[   26.480337] pcieport 0000:00:00.0: of_irq_parse_pci: failed with rc=-22
> > 	[   26.487479] pcieport 0000:00:00.0: PME: Signaling with IRQ 701
> > 	[   26.493909] pcieport 0000:00:00.0: AER: enabled with IRQ 701
> > 
> > In the above logs, '240' is the Power Domain Index for the PCIe
> > Controller on J7200 SoC. It is powered on initially before the driver is
> > probed.
> 
> In that case, the driver should not call pm_runtime_get_sync() in its probe.
> What it should do is:
> 
> 	pm_runtime_set_active()
> 	pm_runtime_enable()

If I understand correctly, are you suggesting the following?

j721e_pcie_probe()
	pm_runtime_set_active()
	pm_runtime_enable()
	ret = j721e_pcie_ctrl_init(pcie);
		/*
		 * PCIe Controller should be powered off here, but is there
		 * a way to ensure that it has been powered off?
		 */
		=> Program the strap settings and return to
		j721e_pcie_probe()
	/* Power on the PCIe Controller now */
	ret = pm_runtime_get_sync(dev);


> 
> But the driver is supporting several SoC variants. Does the bootloader enable
> PCIe controller for all of them?

By 'bootloader', I assume that you are referring to Firmware that is
responsible for powering on or off the Controller on the basis of Power
Management APIs from Linux. If so, yes, all the SoC variants are Powered
on prior to the probe function being invoked via the
'dev_pm_domain_attach()' API called in drivers/base/platform.c.

> 
> > During driver probe, we see the logs corresponding to
> > "devm_pci_alloc_host_bridge()" from the timestamp of '25.234848' which
> > is prior to the invocation of 'j721e_pcie_ctrl_init()'. Some time around
> > the '25.267098' timestamp, the 'j721e_pcie_ctrl_init()' function is
> > invoked which then decrements the ref-count via 'pm_runtime_put_sync(dev)'
> > leading to the PCIe Controller being powered off. This seems to be
> > consistent across boot unlike the usage of 'dev_pm_domain_detach' which
> > handles the device power off via a workqueue as a result of which it may
> > not be powered off yet when 'j721e_pcie_ctrl_init()' is programming the
> > strap settings. Hence, I switched from 'dev_pm_domain_detach()' to
> > 'pm_runtime_put_sync()' in the v3 patch.
> > 
> 
> No using dev_pm_domain_detach() is a wrong approach.
> 
> > Please let me know if you have any suggestions for alternative means to
> > power off the device in a reliable manner without deferring it to a
> > workqueue as done by the 'dev_pm_domain_detach()' API.
> > 
> 
> Using pm_runtime_put_sync() is the correct way, but the comment and patch
> description needs to be improved. In the comment, you are claiming that
> pm_runtime_put_sync() will power off the controller, even though it is true, it
> is not clear who is responsible for doing that. So reword it to reflect the fact
> that the power domain (genpd?) will turn off the controller.

Thank you for the feedback. Yes, it is indeed genpd that powers off the
PCIe Controller via corresponding requests to the Firmware that manages the
Power states of all devices in the SoC. I will update the commit message
to indicate this.

Regards,
Siddharth.

