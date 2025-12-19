Return-Path: <linux-pci+bounces-43407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 167C4CD11DA
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 840C13096AB2
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 17:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8852C3064B3;
	Fri, 19 Dec 2025 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aw8l5ZWz"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4461529B76F
	for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766164788; cv=none; b=pg0R/C91rmZZilo/wdFFnyYpOG2JmmZAG+G8jdz+yrnFX3/Wby6EemTHi1XjNSBs7DxGBQYkfgm+m0j6SEYKklAze/yIMlZ82f613JyCE3OwLZQK2Kf2BclTj5btjfne8SmSAnDOs5z4iiWQIihxJwuN6YTAvwE8R1aUcdXZgVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766164788; c=relaxed/simple;
	bh=xzu0ib6hHB6LSoZmxaC5yBjOyyWTRlpWAc69Viwmgvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cF0Q8VdPyfwmAbWxIz1+FsbUjniaQZAs31rbMqTkf5iWshrx6Z5gBtx4d47vPgsk/IMqACDxtzoolgxTAgTi84DC6pvSgoU6+gN9v1vWAkiWhrqVV69OS4KCoQJi/bPzIzHz5qxrF2T6tm6lZVbPuJj2BaQZSb+32PwOpmq2qBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aw8l5ZWz; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <39e025bd-50f4-407d-8fd4-e254dbed46b2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766164784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KcTZ6T/rdlJiOM11s74YihRu9dE9rgDcr4qXhc6ZMio=;
	b=aw8l5ZWztWySKnRzB3pskYK0zwnj9BysLm6c0KCauphqdZyyXevQZke/s69EOfHNo2TIA/
	oC7jY+kmToyS18IGwiTBYd2EDJ/SAwp6DoEQ/Z2UzTggMYZc4ehN/VnieAaiOzKULsf1YP
	lejvQbMgkqCe/vgDcc9uNmTt86h9t9g=
Date: Fri, 19 Dec 2025 12:19:36 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/5] PCI/pwrctrl: Major rework to integrate pwrctrl
 devices with controller drivers
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>,
 Brian Norris <briannorris@chromium.org>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>,
 Chen-Yu Tsai <wenst@chromium.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20251216-pci-pwrctrl-rework-v2-0-745a563b9be6@oss.qualcomm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20251216-pci-pwrctrl-rework-v2-0-745a563b9be6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

I have a few comments on the overall architecture. I did some work to
add PERST as well (sent as replies to this message).

On 12/16/25 07:51, Manivannan Sadhasivam wrote:
> Hi,
> 
> This series provides a major rework for the PCI power control (pwrctrl)
> framework to enable the pwrctrl devices to be controlled by the PCI controller
> drivers.
> 
> Problem Statement
> =================
> 
> Currently, the pwrctrl framework faces two major issues:
> 
> 1. Missing PERST# integration
> 2. Inability to properly handle bus extenders such as PCIe switch devices
> 
> First issue arises from the disconnect between the PCI controller drivers and
> pwrctrl framework. At present, the pwrctrl framework just operates on its own
> with the help of the PCI core. The pwrctrl devices are created by the PCI core
> during initial bus scan and the pwrctrl drivers once bind, just power on the
> PCI devices during their probe(). This design conflicts with the PCI Express
> Card Electromechanical Specification requirements for PERST# timing. The reason
> is, PERST# signals are mostly handled by the controller drivers and often
> deasserted even before the pwrctrl drivers probe. According to the spec, PERST#
> should be deasserted only after power and reference clock to the device are
> stable, within predefined timing parameters.
> 
> The second issue stems from the PCI bus scan completing before pwrctrl drivers
> probe. This poses a significant problem for PCI bus extenders like switches
> because the PCI core allocates upstream bridge resources during the initial
> scan. If the upstream bridge is not hotplug capable, resources are allocated
> only for the number of downstream buses detected at scan time, which might be
> just one if the switch was not powered and enumerated at that time. Later, when
> the pwrctrl driver powers on and enumerates the switch, enumeration fails due to
> insufficient upstream bridge resources.
>
>
> Proposal
> ========
> 
> This series addresses both issues by introducing new individual APIs for pwrctrl
> device creation, destruction, power on, and power off operations.

I wrote my own PCI power sequencing subsystem last year but didn't get
around to upstreaming it before the current subsystem was merged. This
approach (individual APIs for each power sequence) was how I did it. But
I think the approach to do everything in probe is rather elegant, since
it integrates with the existing device model and we don't need to modify
existing drivers.

To contrast, in U-Boot the second issue doesn't apply because driver
probing happens synchronously and config space accesses are done after
devices get probed. So you have something like

host bridge probe()
pci_scan_child_bus()
   discover root port
   root port probe()
      initialize slot resources (power supplies, clocks, etc.)
   allocate root port BARs
   discover root port children

I guess your approach is the only way to do it in Linux given the
asynchronous nature of driver binding. What is the overhead for hotplug
switches like? Maybe it makes sense to just treat all switches as
hotplug capable when PCI power sequencing is enabled?

> Controller
> drivers are expected to invoke these APIs during their probe(), remove(),
> suspend(), and resume() operations. This integration allows better coordination
> between controller drivers and the pwrctrl framework, enabling enhanced features
> such as D3Cold support.

How does PERST work? The only reference I can find to GPIOs in this
series is in the first patch. Is every driver supposed to add support
for PERST and then call these new functions? Shouldn't this be handled
by the power sequencing driver, especially as there are timing
requirements for the other resources referenced to PERST? IMO if we are
going to touch each driver, it would be much better to consolidate
things by removing the ad-hoc PERST support.

> The original design aimed to avoid modifying controller drivers for pwrctrl
> integration. However, this approach lacked scalability because different
> controllers have varying requirements for when devices should be powered on. For
> example, controller drivers require devices to be powered on early for
> successful PHY initialization.

Is this the case for qcom? The device I tested (nwl) was perfectly
happy to have the PCI device show up some time after the host bridge
got probed.

--Sean

> By using these explicit APIs, controller drivers gain fine grained control over
> their associated pwrctrl devices.
> 
> This series modified the pcie-qcom driver (only consumer of pwrctrl framework)
> to adopt to these APIs and also removed the old pwrctrl code from PCI core. This
> could be used as a reference to add pwrctrl support for other controller drivers
> also.
> 
> For example, to control the 3.3v supply to the PCI slot where the NVMe device is
> connected, below modifications are required:
> 
> Devicetree
> ----------
> 
> 	// In SoC dtsi:
> 
> 	pci@1bf8000 { // controller node
> 		...
> 		pcie1_port0: pcie@0 { // PCI Root Port node
> 			compatible = "pciclass,0604"; // required for pwrctrl
> 							 driver bind
> 			...
> 		};
> 	};
> 
> 	// In board dts:
> 
> 	&pcie1_port0 {
> 		reset-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>; // optional
> 		vpcie3v3-supply = <&vreg_nvme>; // NVMe power supply
> 	};
> 
> Controller driver
> -----------------
> 
> 	// Select PCI_PWRCTRL_SLOT in controller Kconfig
> 
> 	probe() {
> 		...
> 		// Initialize controller resources
> 		pci_pwrctrl_create_devices(&pdev->dev);
> 		pci_pwrctrl_power_on_devices(&pdev->dev);
> 		// Deassert PERST# (optional)
> 		...
> 		pci_host_probe(); // Allocate host bridge and start bus scan
> 	}
> 
> 	suspend {
> 		// PME_Turn_Off broadcast
> 		// Assert PERST# (optional)
> 		pci_pwrctrl_power_off_devices(&pdev->dev);
> 		...
> 	}
> 
> 	resume {
> 		...
> 		pci_pwrctrl_power_on_devices(&pdev->dev);
> 		// Deassert PERST# (optional)
> 	}
> 
> I will add a documentation for the pwrctrl framework in the coming days to make
> it easier to use.
> 
> Testing
> =======
> 
> This series is tested on the Lenovo Thinkpad T14s laptop based on Qcom X1E
> chipset and RB3Gen2 development board with TC9563 switch based on Qcom QCS6490
> chipset.
> 
> **NOTE**: With this series, the controller driver may undergo multiple probe
> deferral if the pwrctrl driver was not available during the controller driver
> probe. This is pretty much required to avoid the resource allocation issue.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Changes in v2:
> - Exported of_pci_supply_present() API
> - Demoted the -EPROBE_DEFER log to dev_dbg()
> - Collected tags and rebased on top of v6.19-rc1
> - Link to v1: https://lore.kernel.org/r/20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com
> 
> ---
> Krishna Chaitanya Chundru (1):
>       PCI/pwrctrl: Add APIs for explicitly creating and destroying pwrctrl devices
> 
> Manivannan Sadhasivam (4):
>       PCI: qcom: Parse PERST# from all PCIe bridge nodes
>       PCI/pwrctrl: Add 'struct pci_pwrctrl::power_{on/off}' callbacks
>       PCI/pwrctrl: Add APIs to power on/off the pwrctrl devices
>       PCI/pwrctrl: Switch to the new pwrctrl APIs
> 
>  drivers/pci/controller/dwc/pcie-qcom.c   | 124 +++++++++++++---
>  drivers/pci/of.c                         |   1 +
>  drivers/pci/probe.c                      |  59 --------
>  drivers/pci/pwrctrl/core.c               | 248 +++++++++++++++++++++++++++++--
>  drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c |  30 +++-
>  drivers/pci/pwrctrl/slot.c               |  46 ++++--
>  drivers/pci/remove.c                     |  20 ---
>  include/linux/pci-pwrctrl.h              |  16 +-
>  8 files changed, 408 insertions(+), 136 deletions(-)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251124-pci-pwrctrl-rework-c91a6e16c2f6
> 
> Best regards,

