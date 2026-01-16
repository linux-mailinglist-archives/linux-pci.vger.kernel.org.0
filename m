Return-Path: <linux-pci+bounces-45075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E98F5D385E7
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 20:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A61E5302FC6F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 19:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C354C3644CC;
	Fri, 16 Jan 2026 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfPqtIvA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E57934DB61;
	Fri, 16 Jan 2026 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768591763; cv=none; b=DdWztre17QlIrMfQHZuZ6BERwW5KUvQesTIcryrfHVvq+xCmvEu8wBZq7/onSDGevkJMkNWJ4va43tInNA+suYK8PPIKzxVfHkjjT8vmGqnFUNsi672OxqVQN1mdJEitzlTPevcDZ7y9w4vp/HZ9NJkS1WvoEYzzgetK7X4DMy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768591763; c=relaxed/simple;
	bh=kEfRL745wLzkdhLYIaZ2cTgxTmM+p24OLbAnBovRo8A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dA43H9LvZXOcWg0WMt8cdhd/kC2Z3f47zbiK5HzROvhPNewxPbmk2XIXYv+ktzoEtjx4zrJ79MuBzeeXfXUvgGNJOViIxFHyoN+dGxVNhQBgl1NRMV7khYUtUorFfqRzDlj70vwLHLax+doQ3V/HNhgY9FbE6iDmmSGPEczglHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfPqtIvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085D9C116C6;
	Fri, 16 Jan 2026 19:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768591763;
	bh=kEfRL745wLzkdhLYIaZ2cTgxTmM+p24OLbAnBovRo8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YfPqtIvANLpmLw9KzEZMaVbeb0fmqx+hly8PK9TyEkR73coO6JmVhscvjHyjTYbXK
	 pC2yZ5x1qbPduX3pXAiyEdrGyA++jo3ivdpOtXAEGpmAe5XUL1Fu4s4+28y8FSWieH
	 7zt4WI9jo6xnsLFuYGUCigIk84XqNAfBm0dUZRDyu1awhXaWLA5WagwmwLUKraC+Hf
	 AC7Wxj5sRBHS0HHdbm7alWCdBTwqDhAuD3d+TOKSHHPkxSmdE8kDXaobMcvSAnzmdO
	 j0nJR2OXpi8yzQOfZJ6kS9rqcNDyay1GYvPU82yYn6571LCong1lyiwTlmuqs48qGs
	 VNZ+oMfZrHqRg==
Date: Fri, 16 Jan 2026 13:29:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chen-Yu Tsai <wens@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v5 00/15] PCI/pwrctrl: Major rework to integrate pwrctrl
 devices with controller drivers
Message-ID: <20260116192921.GA958817@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com>

On Thu, Jan 15, 2026 at 12:58:52PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
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
> Proposal
> ========
> 
> This series addresses both issues by introducing new individual APIs for pwrctrl
> device creation, destruction, power on, and power off operations. Controller
> drivers are expected to invoke these APIs during their probe(), remove(),
> suspend(), and resume() operations. This integration allows better coordination
> between controller drivers and the pwrctrl framework, enabling enhanced features
> such as D3Cold support.
> 
> The original design aimed to avoid modifying controller drivers for pwrctrl
> integration. However, this approach lacked scalability because different
> controllers have varying requirements for when devices should be powered on. For
> example, controller drivers require devices to be powered on early for
> successful PHY initialization.
> 
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
> probe. This is pretty much required to avoid the resource allocation issue. I
> plan to replace probe deferral with blocking wait in the coming days.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Changes in v5:
> - Incorporated cleanups from Bjorn
> - Splitted the power on/off callback changes
> - Collected tags
> - Link to v4: https://lore.kernel.org/r/20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com
> 
> Changes in v4:
> - Used platform_device_put()
> - Changed the return value of power_off() callback to 'int'
> - Splitted patch 6 into two and reworded the commit message
> - Collected tags
> - Link to v3: https://lore.kernel.org/r/20251229-pci-pwrctrl-rework-v3-0-c7d5918cd0db@oss.qualcomm.com
> 
> Changes in v3:
> - Integrated TC9563 change
> - Reworked the power_on API to properly power off the devices in error path
> - Fixed the error path in pcie-qcom.c to not destroy pwrctrl devices during
>   probe deferral
> - Rebased on top of pci/controller/dwc-qcom branch and dropped the PERST# patch
> - Added a patch for TC9563 to fix the refcount dropping for i2c adapter
> - Added patches to drop the assert_perst callback and rename the PERST# helpers in
>   pcie-qcom.c
> - Link to v2: https://lore.kernel.org/r/20251216-pci-pwrctrl-rework-v2-0-745a563b9be6@oss.qualcomm.com
> 
> Changes in v2:
> - Exported of_pci_supply_present() API
> - Demoted the -EPROBE_DEFER log to dev_dbg()
> - Collected tags and rebased on top of v6.19-rc1
> - Link to v1: https://lore.kernel.org/r/20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com
> 
> ---
> Bjorn Helgaas (5):
>       PCI/pwrctrl: pwrseq: Rename private struct and pointers for consistency
>       PCI/pwrctrl: slot: Rename private struct and pointers for consistency
>       PCI/pwrctrl: tc9563: Clean up whitespace
>       PCI/pwrctrl: tc9563: Add local variables to reduce repetition
>       PCI/pwrctrl: tc9563: Rename private struct and pointers for consistency
> 
> Krishna Chaitanya Chundru (1):
>       PCI/pwrctrl: Add APIs to create, destroy pwrctrl devices
> 
> Manivannan Sadhasivam (9):
>       PCI/pwrctrl: tc9563: Use put_device() instead of i2c_put_adapter()
>       PCI/pwrctrl: slot: Factor out power on/off code to helpers
>       PCI/pwrctrl: pwrseq: Factor out power on/off code to helpers
>       PCI/pwrctrl: Add 'struct pci_pwrctrl::power_{on/off}' callbacks
>       PCI/pwrctrl: Add APIs to power on/off pwrctrl devices
>       PCI/pwrctrl: Switch to pwrctrl create, power on/off, destroy APIs
>       PCI: qcom: Drop the assert_perst() callbacks
>       PCI: Drop the assert_perst() callback
>       PCI: qcom: Rename PERST# assert/deassert helpers for uniformity
> 
>  drivers/pci/bus.c                                 |  19 --
>  drivers/pci/controller/dwc/pcie-designware-host.c |   9 -
>  drivers/pci/controller/dwc/pcie-designware.h      |   9 -
>  drivers/pci/controller/dwc/pcie-qcom.c            |  55 +++--
>  drivers/pci/of.c                                  |   1 +
>  drivers/pci/probe.c                               |  59 -----
>  drivers/pci/pwrctrl/core.c                        | 259 ++++++++++++++++++++--
>  drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c          |  50 +++--
>  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c          | 226 ++++++++++---------
>  drivers/pci/pwrctrl/slot.c                        |  60 +++--
>  drivers/pci/remove.c                              |  20 --
>  include/linux/pci-pwrctrl.h                       |  16 +-
>  include/linux/pci.h                               |   1 -
>  13 files changed, 484 insertions(+), 300 deletions(-)
> ---
> base-commit: 3e7f562e20ee87a25e104ef4fce557d39d62fa85
> change-id: 20251124-pci-pwrctrl-rework-c91a6e16c2f6

Applied to pci/pwrctrl for v6.20, thanks!

I reworked the renaming as we talked about off-line to drop "pci"
(seems redundant) and put the device or driver name first, e.g.,
pci_pwrctrl_slot_probe() -> slot_pwrctrl_probe().

I noticed when build testing that I had to tweak
drivers/pci/pwrctrl/Kconfig to let me build pci-pwrctrl-pwrseq.c.
It would be nice if COMPILE_TEST could enable that.

