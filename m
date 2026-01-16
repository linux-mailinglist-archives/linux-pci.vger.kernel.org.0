Return-Path: <linux-pci+bounces-45019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A14DD2C800
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 07:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D3E2300ACA2
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 06:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BE134D903;
	Fri, 16 Jan 2026 06:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stWX1VGn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB4934D4EC;
	Fri, 16 Jan 2026 06:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768544681; cv=none; b=YR/edp9Ygwk/1utTXSBf3FNWzXwxuq2JPCkYzSFaz10mzvvq8IkFacpddskMCUDfEOjPzO7gfAvQSKr4QqgqVbpQx/11qNCHbrnCILPqfNfzMOZoDHlb+2DRDxePOLb6vEPtlw7KnqWlyjX6XrxlfsKx1EFBehljSCyDH3bCz4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768544681; c=relaxed/simple;
	bh=nXaQD01r0B/egv+YlWWDDC2AjjCw+HjqsNVshrGwMLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtvxoNtimfdbyuhQqcuO8f55VlyGzskG9MgFEf8tuFJRsEOY9SEjpICgX8CBv57tGFBn4f6UM7jYqCgSkIlEekUTtfr95CSQa4+Am+kqV/NUjAIJBTnvSHmueixT5b1mZyPpjof3e1rIcpbiuaaR//+OINgGPdV0I5mSTUx5JIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stWX1VGn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A215C116C6;
	Fri, 16 Jan 2026 06:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768544680;
	bh=nXaQD01r0B/egv+YlWWDDC2AjjCw+HjqsNVshrGwMLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=stWX1VGneha5fSLtC9GT/wByTVPJ52rq+FIBE+oCddpcT6JOd8v6e7oZ8Qazo/xfT
	 pY8vBNqqOVtJkcSyoacghzfU7D5YQ7DvPyA+IUjiezdK/pemwyB5Ht6kBf3mAws7iD
	 gGSSbqfRAT/xbMV8UmI0re/7fH8RDMq27xjU9i0IcnILTfLLhS+EoHlxzbL3ec+zxK
	 OoDlQoK+1FbJDXvPKNrRr9iE8GthZGNf6zHgif+RqyyvyaDqrs4PgjliMJfq+ouqj4
	 lqV/adNbcF+61mbCzG9sx7GQR3MpNTr/Jrow0nLanUUklkf/FcyFVmpQ8JOQnmlsfF
	 w5lLkiYgPL5ZA==
Date: Fri, 16 Jan 2026 11:54:26 +0530
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
Message-ID: <55cqkglbgji7tz34hk7aishyq3wal3oba5hy2yfvdbnkugadyg@56yh35kcgtwf>
References: <20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com>
 <0da0295a-4acb-430e-ae1a-e144f07418d0@seco.com>
 <6iqn3pmk7jb7j6cvmuv6ggs6xkd6ouz6klzhzdekrlzpbgxcua@ebskaj25jukl>
 <ef5d5fdc-be08-4859-a625-cdd1ae0c46c2@seco.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef5d5fdc-be08-4859-a625-cdd1ae0c46c2@seco.com>

On Thu, Jan 15, 2026 at 02:26:32PM -0500, Sean Anderson wrote:

[...]

> >> OK, so to clarify the problem is an architecture like
> >> 
> >>     RP
> >>     |-- Bridge 1 (automatic)
> >>     |   |-- Device 1
> >>     |   `-- Bridge 2 (needs pwrseq)
> >>     |       `-- Device 2
> >>     `-- Bridge 3 (automatic)
> >>         `-- Device 3
> >> 
> > 
> > This topology is not possible with PCIe. A single Root Port can only connect to
> > a single bridge. But applies to PCI.
> 
> OK, well imagine it like
> 
>      RP
>      `-- Host Bridge (automatic)
>          |-- Bridge 1 (automatic)
>          |   |-- Device 1
>          |   `-- Bridge 2 (needs pwrseq)
>          |       `-- Device 2
>          `-- Bridge 3 (automatic)
>              `-- Device 3
> 
> You raised the problem, so what I am asking is: is this such a
> problematic topology? And if not, please describe one.
> 

Again, this topology is also incorrect, but my point is that in whatever
topology, if you have a PCIe switch and that requires a pwrctrl driver to power
it on, then there will be a resource allocation problem.

> >> where Bridge 2 has a devicetree node with a pwrseq binding? So we do the
> >> initial scan and allocate resources for bridge/devices 1 and 3 with the
> >> resources for bridge 3 immediately above those for bridge 1. Then when
> >> bridge 2 shows up we can't resize bridge 1's windows since bridge 3's
> >> windows are in the way?
> >> 
> > 
> > It is not a problem with resizing, it is the problem with how much you can
> > resize. And also if that bridge 2 is a switch and if it exposes multiple
> > downstream busses, then the upstream bridge 1 will run out of resources.
> 
> OK, but what I am saying is that I don't believe Bridge 2 can need
> pwrseq if Bridge 1 doesn't. So I don't think the topology as-illustrated
> can exist.
> 
> It's possible that there could be a problem with multiple levels of
> bridges all needing pwrseq, but does such a system exist?
> 

Yes, it does exists atm. Below is the TC9563 PCIe switch topology in Qcom
RB3Gen2 board:

	Host bridge
	`--> Root Port (auto)
	     `--> TC9563 (pwrctrl)

https://lore.kernel.org/linux-arm-msm/20260105-tc9563-v1-1-642fd1fe7893@oss.qualcomm.com/

And then there is also a design which is underway that connects one more TC9653
to the downstream of existing one for peripheral expansion. So the topology will
become:

	Host bridge
	`--> Root Port (auto)
	     `--> TC9563 (pwrctrl)
		  `--> TC9563 (pwrctrl)

This is just one example and the OEMs may come up with many such designs and we
cannot deny them.

> > If bridge 2 is a hotplug bridge, then no issues. But I was only referring to
> > non-hotplug capable switches.
> > 
> >> But is it even valid to have a pwrseq node on bridge 2 without one on
> >> bridge 1? If bridge 1 is automatically controlled, then I would expect
> >> bridge 2 to be as well. E.g. I would expect bridge 2's reset sequence to
> >> be controlled by the secondary bus reset bit in bridge 1's bridge
> >> control register.
> >> 
> > 
> > Technically it is possible for Bridge 2 to have a pwrctrl requirement. What is
> > limiting from spec PoV?
> 
> If this is the case then we need to be able to handle the resource
> constraint problem. But if it doesn't exist then there is no problem
> with the existing architecture. Only this sort of design has resource
> problems, while most designs like
> 
>      RP
>      `-- Bridge 1 (pwrseq)
>          |-- Bridge 2 (automatic)
>          |   |-- Device 1
>          |   |-- Device 2
>          `-- Bridge 3 (automatic)
>              `-- Device 3
> 
> have no resource problems even with the current subsystem.
> 

Not at all. I think you don't get the issue. The Root Port is just a PCI bridge.
If the downstream device is not found during the initial scan, and if RP is a
non-hotplug capable device, then the PCI core will allocate resources for only
one downstream bus. And if the PCIe switch shows up on the downstream bus later,
then it will fail to enumerate due to resource constraint for the switch's
downstream busses.

This is pretty much what happens with the single switch TC9563 design in RB3Gen2
that I referenced above.

> >> And a very similar architecture like
> >> 
> >>     RP
> >>     |-- Bridge 4 (pwrseq)
> >>     |   |-- Device 4
> >>     `-- Bridge 5 (automatic)
> >>         `-- Device 5
> >> 
> >> has no problems since the resources for bridge 4 can be allocated above
> >> those for bridge 5 whenever it shows up.
> >> 
> > 
> > Again, if bridge 4 is not hotplug capable and if it is a switch, the problem is
> > still applicable.
> 
> This doesn't apply even if bridge 4 is not hotplug capable. It will show
> up after bridge 5 gets probed and just grab the next available
> resources.
> 

See above. The next available resources are very limited if the upstream bridge
is not hotplug capable. And we can't blame PCI core for this because, we are
pretty much emulating hotplug on a non-hotplug capable bridge, which is not
ideal.

> >> These problems seem very similar to what hotplug bridges have to handle
> >> (except that we (usually) only need to do one hotplug per boot). So
> >> maybe we should set is_hotplug_bridge on bridges with a pwrseq node.
> >> That way they'll get resources distributed for when the downstream port
> >> shows up. As an optimization, we could then release those resources once
> >> the downstream port is scanned.
> >> 
> > 
> > That would be incorrect. You cannot set 'is_hotplug_bridge' to 'true' for a
> > non-hotplug capable bridge. You can call it as a hack, but there is no place
> > for that in upstream.
> 
> Introduce a new boolean called 'is_pwrseq_bridge' and check for it when
> allocating resources.
> 

Sorry, I'm not upto introducing such hacks.

> >> > Proposal
> >> > ========
> >> > 
> >> > This series addresses both issues by introducing new individual APIs for pwrctrl
> >> > device creation, destruction, power on, and power off operations. Controller
> >> > drivers are expected to invoke these APIs during their probe(), remove(),
> >> > suspend(), and resume() operations.
> >> 
> >> (just for the record)
> >> 
> >> I think the existing design is quite elegant, since the operations
> >> associated with the bridge correspond directly to device lifecycle
> >> operations. It also avoids problems related to the root port trying to
> >> look up its own child (possibly missing a driver) during probe.
> >> 
> > 
> > I agree with you that it is elegant and I even was very reluctant to move out of
> > it [1]. But lately, I understood that we cannot scale the pwrctrl framework if we
> > do not give flexibility to the controller drivers [2].
> > 
> > [1] https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2flinux%2dpci%2feix65qdwtk5ocd7lj6sw2lslidivauzyn6h5cc4mc2nnci52im%40qfmbmwy2zjbe%2f&umid=db5ea813-d162-4dc2-9847-b6f01a3e22ce&rct=1768380513&auth=d807158c60b7d2502abde8a2fc01f40662980862-377ad79c69a5ff9c69de76d9fcf5f030d066027a
> > [2] https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2flinux%2dpci%2faG3IWdZIhnk01t2A%40google.com%2f&umid=db5ea813-d162-4dc2-9847-b6f01a3e22ce&rct=1768380513&auth=d807158c60b7d2502abde8a2fc01f40662980862-9a33d827cf703f2827fca86fd99acf563ca26bd9
> > 
> >> > This integration allows better coordination
> >> > between controller drivers and the pwrctrl framework, enabling enhanced features
> >> > such as D3Cold support.
> >> 
> >> 
> >> I think this should be handled by the power sequencing driver,
> >> especially as there are timing requirements for the other resources
> >> referenced to PERST? If we are going to touch each driver, it would
> >> be much better to consolidate things by removing the ad-hoc PERST
> >> support.
> >> 
> >> Different drivers control PERST in various ways, but I think this can
> >> be abstracted behind a GPIO controller (if necessary for e.g. MMIO-based
> >> control). If there's no reset-gpios property in the pwrseq node then we
> >> could automatically look up the GPIO on the root port.
> >> 
> > 
> > Not at all. We cannot model PERST# as a GPIO in all the cases. Some drivers
> > implement PERST# as a set of MMIO operations in the Root Complex MMIO space and
> > that space belongs to the controller driver.
> 
> That's what I mean. Implement a GPIO driver with one GPIO and perform
> the MMIO operations as requested.
> 
> Or we can invert things and add a reset op to pci_ops. If present then
> call it, and if absent use the PERST GPIO on the bridge.
> 

Having a callback for controlling the PERST# will work for the addressing the
PERST# issue, but it won't solve the PCIe switch issue we were talking above.
And this API design will fix both the problems.

But even in this callback design, you need to have modifications in the existing
controller drivers to integrate pwrctrl. So how that is different from calling
just two (or one unified API for create/power_on)?

> > FYI, I did try something similar before:
> > https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2flinux%2dpci%2f20250707%2dpci%2dpwrctrl%2dperst%2dv1%2d0%2dc3c7e513e312%40kernel.org%2f&umid=db5ea813-d162-4dc2-9847-b6f01a3e22ce&rct=1768380513&auth=d807158c60b7d2502abde8a2fc01f40662980862-e06652b06144d91b37cae1f9289747fe7cbe0762
> >> > The original design aimed to avoid modifying controller drivers for pwrctrl
> >> > integration. However, this approach lacked scalability because different
> >> > controllers have varying requirements for when devices should be powered on. For
> >> > example, controller drivers require devices to be powered on early for
> >> > successful PHY initialization.
> >> 
> >> Can you elaborate on this? Previously you said
> >> 
> >> | Some platforms do LTSSM during phy_init(), so they will fail if the
> >> | device is not powered ON at that time.
> >> 
> >> What do you mean by "do LTSSM during phy_init()"? Do you have a specific
> >> driver in mind?
> >> 
> > 
> > I believe the Mediatek PCIe controller driver used in Chromebooks exhibit this
> > behavior. Chen talked about it in his LPC session:
> > https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flpc.events%2fevent%2f19%2fcontributions%2f2023%2f&umid=db5ea813-d162-4dc2-9847-b6f01a3e22ce&rct=1768380513&auth=d807158c60b7d2502abde8a2fc01f40662980862-59ecd8a94baa970f1f962febb6fe20f15058ef42
> 
> I went through 
> 
> mediatek/phy-mtk-pcie.c
> mediatek/phy-mtk-tphy.c
> mediatek/phy-mtk-xsphy.c
> ralink/phy-mt7621-pci.c
> 
> and didn't see anything where they wait for the link to come up or check
> the link state and fail.
> 

See tegra_pcie_config_rp().

> The mtk PCIe drivers may check for this, but I'm saying that we
> *shouldn't* do that in probe.
> 

Such drivers already exist. Sure they can just leave the LTSSM in detect state
instead of failing probe. But if their Root Port is not hotplug capable, why
should they expect a device to get attached to the bus after probe?

That being said, we do have DWC drivers ignoring the link up failure expecting
the link to come up later. But I may just fix that in the coming days once the
pwrctrl APIs are added. There is no reason to wait for hotplug if the RP is not
hotplug capable. It is just asking for troubles.

> >> I would expect that the LTSSM would remain in the Detect state until the
> >> pwrseq driver is being probed.
> >> 
> > 
> > True, but if the API (phy_init()) expects the LTSSM to move to L0, then it will
> > fail, right? It might be what's happening with above mentioned platform.
> 
> How can the API expect this?
> 
> I'm not saying that such a situation cannot exist, but I don't think
> it's a common case.
>

Starting LTSSM in phy_init() is weird I agree. I for sure know that someone
raised this up earlier, but don't exactly remember which driver is doing it.
 
> >> > By using these explicit APIs, controller drivers gain fine grained control over
> >> > their associated pwrctrl devices.
> >> > 
> >> > This series modified the pcie-qcom driver (only consumer of pwrctrl framework)
> >> > to adopt to these APIs and also removed the old pwrctrl code from PCI core. This
> >> > could be used as a reference to add pwrctrl support for other controller drivers
> >> > also.
> >> > 
> >> > For example, to control the 3.3v supply to the PCI slot where the NVMe device is
> >> > connected, below modifications are required:
> >> > 
> >> > Devicetree
> >> > ----------
> >> > 
> >> > 	// In SoC dtsi:
> >> > 
> >> > 	pci@1bf8000 { // controller node
> >> > 		...
> >> > 		pcie1_port0: pcie@0 { // PCI Root Port node
> >> > 			compatible = "pciclass,0604"; // required for pwrctrl
> >> > 							 driver bind
> >> > 			...
> >> > 		};
> >> > 	};
> >> > 
> >> > 	// In board dts:
> >> > 
> >> > 	&pcie1_port0 {
> >> > 		reset-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>; // optional
> >> > 		vpcie3v3-supply = <&vreg_nvme>; // NVMe power supply
> >> > 	};
> >> > 
> >> > Controller driver
> >> > -----------------
> >> > 
> >> > 	// Select PCI_PWRCTRL_SLOT in controller Kconfig
> >> > 
> >> > 	probe() {
> >> > 		...
> >> > 		// Initialize controller resources
> >> > 		pci_pwrctrl_create_devices(&pdev->dev);
> >> > 		pci_pwrctrl_power_on_devices(&pdev->dev);
> >> > 		// Deassert PERST# (optional)
> >> > 		...
> >> > 		pci_host_probe(); // Allocate host bridge and start bus scan
> >> > 	}
> >> > 
> >> > 	suspend {
> >> > 		// PME_Turn_Off broadcast
> >> > 		// Assert PERST# (optional)
> >> > 		pci_pwrctrl_power_off_devices(&pdev->dev);
> >> > 		...
> >> > 	}
> >> > 
> >> > 	resume {
> >> > 		...
> >> > 		pci_pwrctrl_power_on_devices(&pdev->dev);
> >> > 		// Deassert PERST# (optional)
> >> > 	}
> >> > 
> >> > I will add a documentation for the pwrctrl framework in the coming days to make
> >> > it easier to use.
> >> > 
> >> > Testing
> >> > =======
> >> > 
> >> > This series is tested on the Lenovo Thinkpad T14s laptop based on Qcom X1E
> >> > chipset and RB3Gen2 development board with TC9563 switch based on Qcom QCS6490
> >> > chipset.
> >> > 
> >> > **NOTE**: With this series, the controller driver may undergo multiple probe
> >> > deferral if the pwrctrl driver was not available during the controller driver
> >> > probe. This is pretty much required to avoid the resource allocation issue. I
> >> > plan to replace probe deferral with blocking wait in the coming days.
> >> 
> >> You can only do a blocking wait after deferring at least once, since the
> >> root port may be probed synchronously during boot. I really think this
> >> is rather messy and something we should avoid architecturally while we
> >> have the chance.
> >> 
> > 
> > By blocking wait I meant that the controller probe itself will do a blocking
> > wait until the pwrctrl drivers gets bound. Since this happens way before the PCI
> > bus scan, there won't be any Root Port probed synchronously.
> 
> You can't do that because the pwrctrl driver may *never* be loaded. And
> this may deadlock the boot sequence because the initial probe is
> performed synchronously from the initcall. i.e.
> 
> do_initcalls
>   my_driver_init
>     driver_register
>       bus_add_driver
>         driver_attach
>           driver_probe_device
> 
> If the PCI controller is probed before the device that has the module
> you will deadlock! So you can only sleep indefinitely if you are being
> probed asynchronously.
> 

Yes, I was thinking about controller drivers setting PROBE_PREFER_ASYNCHRONOUS
flag. We can restrict the blocking wait to such drivers.

> -----
> 
> Maybe the best way to address this is to add assert_reset/link_up/
> link_down callbacks to pci_ops. Then pwrctrl_slot probe could look like
> 
>     bridge = to_pci_host_bridge(dev->parent);
>     of_regulator_bulk_get_all();
>     regulator_bulk_enable();
>     devm_clk_get_optional_enabled();
>     devm_gpiod_get_optional(/* "reset" */);
>     if (bridge && bridge->ops->assert_reset)
>         ret = bridge->ops->assert_reset(bridge, slot)
>     else
>         ret = assert_reset_gpio(slot);
> 
>     if (ret != ALREADY_ASSERTED)
> 	    fdelay(100000);
> 
>     /* Deassert PERST and bring the link up */
>     if (bridge && bridge->ops->link_up)
>         bridge->ops->link_up(bridge, slot);
>     else
>         slot_deassert_reset(slot);
> 
>     devm_add_action_or_reset(link_down);
>     pci_pwrctrl_init();
>     devm_pci_pwrctrl_device_set_ready();
> 

Sorry, I'm not inclined to take this route for the reasons mentioned above.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

