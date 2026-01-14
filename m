Return-Path: <linux-pci+bounces-44716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D46CD1D422
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 09:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6113300A36D
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 08:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61D7378D81;
	Wed, 14 Jan 2026 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNzkcZW4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B56537F8AF;
	Wed, 14 Jan 2026 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380509; cv=none; b=sOVljtLIGarYJ5XYxAmZ2QXaLily29jccbDG/QWDdJI+j+hSsDDOMx+ZP0mLl+u1lRl3RLA3w5DQgIn3BdEUECV9fQ55OSjKeSEt89HpxZCcvWwCipgvtQmHBNQWRLQUpPFCCDdLU2EBQA/BXSPsZXXFvb90GDwDjl78msXUaRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380509; c=relaxed/simple;
	bh=bLa7w3OD3PQGeMF5FV7+wQptmfVNAdma/SSM/ZWeg4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dvr2gO099lFMKhRRJ7Yuc1ekTpTPkkN8A6BFGChatEXpATIs4cNt/r/BbOkhlazfgnnE0awKwihXIBWnW3nAZtjLYptu701it8I2E5nne91+QzWO6owKFWgQozgOk81hJCIBKbKKUc4oe6TzpX3PdnJ3BPTHoyRo6BKSByv2mek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNzkcZW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35147C4CEF7;
	Wed, 14 Jan 2026 08:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768380508;
	bh=bLa7w3OD3PQGeMF5FV7+wQptmfVNAdma/SSM/ZWeg4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aNzkcZW4NO1sNljOfkTMW6mFAo3ytySrS4fk0Jsy2UQ9N/A4Ce+mg+YpnquqZncmr
	 AVwXy0y1LZazrbXfr69W2yrbkWHlaO+qFlrihMnAXUMIQwMLpymkqSAaiYEY4onMT1
	 r1n7E4Y3K86XEEcX+5VhtyxBqcPJjTbKdfqhSgOT5nmqwEepcFRaX2z9yGCAe0Csy8
	 iAhCiuL5WD0UqcEA+lzFhjvnCOfglEVW406oFc/6TJziy2gZIta2tCPBfW1a+CYQN5
	 nz/F4s8cXpeaEcspqR+/MnAnZS0F5aJqW/8JtBq9jffm39bTwOAIBzSkYaSFWSv9Mm
	 mwEy0ZBASFoKQ==
Date: Wed, 14 Jan 2026 14:18:18 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sean Anderson <sean.anderson@seco.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Chen-Yu Tsai <wenst@chromium.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 0/8] PCI/pwrctrl: Major rework to integrate pwrctrl
 devices with controller drivers
Message-ID: <6iqn3pmk7jb7j6cvmuv6ggs6xkd6ouz6klzhzdekrlzpbgxcua@ebskaj25jukl>
References: <20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com>
 <0da0295a-4acb-430e-ae1a-e144f07418d0@seco.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0da0295a-4acb-430e-ae1a-e144f07418d0@seco.com>

On Tue, Jan 13, 2026 at 12:15:01PM -0500, Sean Anderson wrote:
> On 1/5/26 08:55, Manivannan Sadhasivam via B4 Relay wrote:
> > Hi,
> 
> I asked substantially similar questions on v2, but since I never got a
> response I want to reiterate them on v4 to make sure they don't get
> lost.
> 

I did respond to your queries in v2, but lost your last reply in that thread:
https://lore.kernel.org/linux-pci/8269249f-48a9-4136-a326-23f5076be487@linux.dev/

Apologies!

> > This series provides a major rework for the PCI power control (pwrctrl)
> > framework to enable the pwrctrl devices to be controlled by the PCI controller
> > drivers.
> > 
> > Problem Statement
> > =================
> > 
> > Currently, the pwrctrl framework faces two major issues:
> > 
> > 1. Missing PERST# integration
> > 2. Inability to properly handle bus extenders such as PCIe switch devices
> > 
> > First issue arises from the disconnect between the PCI controller drivers and
> > pwrctrl framework. At present, the pwrctrl framework just operates on its own
> > with the help of the PCI core. The pwrctrl devices are created by the PCI core
> > during initial bus scan and the pwrctrl drivers once bind, just power on the
> > PCI devices during their probe(). This design conflicts with the PCI Express
> > Card Electromechanical Specification requirements for PERST# timing. The reason
> > is, PERST# signals are mostly handled by the controller drivers and often
> > deasserted even before the pwrctrl drivers probe. According to the spec, PERST#
> > should be deasserted only after power and reference clock to the device are
> > stable, within predefined timing parameters.
> > 
> > The second issue stems from the PCI bus scan completing before pwrctrl drivers
> > probe. This poses a significant problem for PCI bus extenders like switches
> > because the PCI core allocates upstream bridge resources during the initial
> > scan. If the upstream bridge is not hotplug capable, resources are allocated
> > only for the number of downstream buses detected at scan time, which might be
> > just one if the switch was not powered and enumerated at that time. Later, when
> > the pwrctrl driver powers on and enumerates the switch, enumeration fails due to
> > insufficient upstream bridge resources.
> 
> OK, so to clarify the problem is an architecture like
> 
>     RP
>     |-- Bridge 1 (automatic)
>     |   |-- Device 1
>     |   `-- Bridge 2 (needs pwrseq)
>     |       `-- Device 2
>     `-- Bridge 3 (automatic)
>         `-- Device 3
> 

This topology is not possible with PCIe. A single Root Port can only connect to
a single bridge. But applies to PCI.

> where Bridge 2 has a devicetree node with a pwrseq binding? So we do the
> initial scan and allocate resources for bridge/devices 1 and 3 with the
> resources for bridge 3 immediately above those for bridge 1. Then when
> bridge 2 shows up we can't resize bridge 1's windows since bridge 3's
> windows are in the way?
> 

It is not a problem with resizing, it is the problem with how much you can
resize. And also if that bridge 2 is a switch and if it exposes multiple
downstream busses, then the upstream bridge 1 will run out of resources.
If bridge 2 is a hotplug bridge, then no issues. But I was only referring to
non-hotplug capable switches.

> But is it even valid to have a pwrseq node on bridge 2 without one on
> bridge 1? If bridge 1 is automatically controlled, then I would expect
> bridge 2 to be as well. E.g. I would expect bridge 2's reset sequence to
> be controlled by the secondary bus reset bit in bridge 1's bridge
> control register.
> 

Technically it is possible for Bridge 2 to have a pwrctrl requirement. What is
limiting from spec PoV?

> And a very similar architecture like
> 
>     RP
>     |-- Bridge 4 (pwrseq)
>     |   |-- Device 4
>     `-- Bridge 5 (automatic)
>         `-- Device 5
> 
> has no problems since the resources for bridge 4 can be allocated above
> those for bridge 5 whenever it shows up.
> 

Again, if bridge 4 is not hotplug capable and if it is a switch, the problem is
still applicable.

> These problems seem very similar to what hotplug bridges have to handle
> (except that we (usually) only need to do one hotplug per boot). So
> maybe we should set is_hotplug_bridge on bridges with a pwrseq node.
> That way they'll get resources distributed for when the downstream port
> shows up. As an optimization, we could then release those resources once
> the downstream port is scanned.
> 

That would be incorrect. You cannot set 'is_hotplug_bridge' to 'true' for a
non-hotplug capable bridge. You can call it as a hack, but there is no place
for that in upstream.

> > Proposal
> > ========
> > 
> > This series addresses both issues by introducing new individual APIs for pwrctrl
> > device creation, destruction, power on, and power off operations. Controller
> > drivers are expected to invoke these APIs during their probe(), remove(),
> > suspend(), and resume() operations.
> 
> (just for the record)
> 
> I think the existing design is quite elegant, since the operations
> associated with the bridge correspond directly to device lifecycle
> operations. It also avoids problems related to the root port trying to
> look up its own child (possibly missing a driver) during probe.
> 

I agree with you that it is elegant and I even was very reluctant to move out of
it [1]. But lately, I understood that we cannot scale the pwrctrl framework if we
do not give flexibility to the controller drivers [2].

[1] https://lore.kernel.org/linux-pci/eix65qdwtk5ocd7lj6sw2lslidivauzyn6h5cc4mc2nnci52im@qfmbmwy2zjbe/
[2] https://lore.kernel.org/linux-pci/aG3IWdZIhnk01t2A@google.com/

> > This integration allows better coordination
> > between controller drivers and the pwrctrl framework, enabling enhanced features
> > such as D3Cold support.
> 
> 
> I think this should be handled by the power sequencing driver,
> especially as there are timing requirements for the other resources
> referenced to PERST? If we are going to touch each driver, it would
> be much better to consolidate things by removing the ad-hoc PERST
> support.
> 
> Different drivers control PERST in various ways, but I think this can
> be abstracted behind a GPIO controller (if necessary for e.g. MMIO-based
> control). If there's no reset-gpios property in the pwrseq node then we
> could automatically look up the GPIO on the root port.
> 

Not at all. We cannot model PERST# as a GPIO in all the cases. Some drivers
implement PERST# as a set of MMIO operations in the Root Complex MMIO space and
that space belongs to the controller driver.

FYI, I did try something similar before:
https://lore.kernel.org/linux-pci/20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org/

> > The original design aimed to avoid modifying controller drivers for pwrctrl
> > integration. However, this approach lacked scalability because different
> > controllers have varying requirements for when devices should be powered on. For
> > example, controller drivers require devices to be powered on early for
> > successful PHY initialization.
> 
> Can you elaborate on this? Previously you said
> 
> | Some platforms do LTSSM during phy_init(), so they will fail if the
> | device is not powered ON at that time.
> 
> What do you mean by "do LTSSM during phy_init()"? Do you have a specific
> driver in mind?
> 

I believe the Mediatek PCIe controller driver used in Chromebooks exhibit this
behavior. Chen talked about it in his LPC session:
https://lpc.events/event/19/contributions/2023/

> I would expect that the LTSSM would remain in the Detect state until the
> pwrseq driver is being probed.
> 

True, but if the API (phy_init()) expects the LTSSM to move to L0, then it will
fail, right? It might be what's happening with above mentioned platform.

> > By using these explicit APIs, controller drivers gain fine grained control over
> > their associated pwrctrl devices.
> > 
> > This series modified the pcie-qcom driver (only consumer of pwrctrl framework)
> > to adopt to these APIs and also removed the old pwrctrl code from PCI core. This
> > could be used as a reference to add pwrctrl support for other controller drivers
> > also.
> > 
> > For example, to control the 3.3v supply to the PCI slot where the NVMe device is
> > connected, below modifications are required:
> > 
> > Devicetree
> > ----------
> > 
> > 	// In SoC dtsi:
> > 
> > 	pci@1bf8000 { // controller node
> > 		...
> > 		pcie1_port0: pcie@0 { // PCI Root Port node
> > 			compatible = "pciclass,0604"; // required for pwrctrl
> > 							 driver bind
> > 			...
> > 		};
> > 	};
> > 
> > 	// In board dts:
> > 
> > 	&pcie1_port0 {
> > 		reset-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>; // optional
> > 		vpcie3v3-supply = <&vreg_nvme>; // NVMe power supply
> > 	};
> > 
> > Controller driver
> > -----------------
> > 
> > 	// Select PCI_PWRCTRL_SLOT in controller Kconfig
> > 
> > 	probe() {
> > 		...
> > 		// Initialize controller resources
> > 		pci_pwrctrl_create_devices(&pdev->dev);
> > 		pci_pwrctrl_power_on_devices(&pdev->dev);
> > 		// Deassert PERST# (optional)
> > 		...
> > 		pci_host_probe(); // Allocate host bridge and start bus scan
> > 	}
> > 
> > 	suspend {
> > 		// PME_Turn_Off broadcast
> > 		// Assert PERST# (optional)
> > 		pci_pwrctrl_power_off_devices(&pdev->dev);
> > 		...
> > 	}
> > 
> > 	resume {
> > 		...
> > 		pci_pwrctrl_power_on_devices(&pdev->dev);
> > 		// Deassert PERST# (optional)
> > 	}
> > 
> > I will add a documentation for the pwrctrl framework in the coming days to make
> > it easier to use.
> > 
> > Testing
> > =======
> > 
> > This series is tested on the Lenovo Thinkpad T14s laptop based on Qcom X1E
> > chipset and RB3Gen2 development board with TC9563 switch based on Qcom QCS6490
> > chipset.
> > 
> > **NOTE**: With this series, the controller driver may undergo multiple probe
> > deferral if the pwrctrl driver was not available during the controller driver
> > probe. This is pretty much required to avoid the resource allocation issue. I
> > plan to replace probe deferral with blocking wait in the coming days.
> 
> You can only do a blocking wait after deferring at least once, since the
> root port may be probed synchronously during boot. I really think this
> is rather messy and something we should avoid architecturally while we
> have the chance.
> 

By blocking wait I meant that the controller probe itself will do a blocking
wait until the pwrctrl drivers gets bound. Since this happens way before the PCI
bus scan, there won't be any Root Port probed synchronously.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

