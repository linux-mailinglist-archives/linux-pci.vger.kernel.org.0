Return-Path: <linux-pci+bounces-45026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C95D2E0C8
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 09:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC39F3020156
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 08:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059B2304BBF;
	Fri, 16 Jan 2026 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zova+EEp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52233043D6;
	Fri, 16 Jan 2026 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768552268; cv=none; b=ehiaskg8l5Ga87Dle7wKJvFn4nwpcqykFe/tgriglGYd5u4bYh7xk5zqbm/NczRomuxguO8aMsEqmplNYM1B3sUAXJg86BIsbLStPYcOW0515VWQEj59dpPP4wNaoO/8mf43DJW54GDJSkHtOMAfQ5SICbVUgp2wpn5crpN5Wog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768552268; c=relaxed/simple;
	bh=AR1xcGP5nXoxwoSni/RPl3rMxRok8Hq7NHv1MJPbR6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZBiSlNE/febGmoP5h1R8kzsuTvT9EL8rVSo5osHfGN2aldWkRwc59BFzNiELq/C594nnVyJJANOUhcfh9t9J/mUhQvNqfoT7GNHPPscaSt8O0sLsWvdyp97W9ugyig5zHtApvOnNo104rmgAzKnSISii6lsMjwDy6ALwXvH+gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zova+EEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA49DC116C6;
	Fri, 16 Jan 2026 08:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768552268;
	bh=AR1xcGP5nXoxwoSni/RPl3rMxRok8Hq7NHv1MJPbR6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zova+EEpI40oxTZWDlbEiPyAvHpPQ30YXBHlKWokBfG35oYuLyzAn5iwVKWalPMzY
	 kxlOrfYtkMdLnKch+J6oLe8Ph6M4t4S4SClFn1zg5/+imks8hFj7mpJRE7da1zi1o9
	 J5zG2cfH+5YEcel0ZEdtmb9C377Lgua8PXif2Uptrn7sICmsQaQFNF85H1xjPBHAfY
	 NwTSswMxZ9mLPxOwoGVjSKAIGCP8fu/HXIGqviyhsRXMrmcwZaqqiUfASOhJUDufWb
	 tXMBs23f++uV8BNcf9+sCNzGE7sFM5Hvb9RIMYMWogrXRPzlDkZ1CgSNkGuMiRpfQN
	 fSOefTpfFFLHg==
Date: Fri, 16 Jan 2026 14:00:54 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
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
Message-ID: <czpmvuxfdilf5onrh25tucnr2ar42stga4one2jhh4q7h3vspf@rnzgnrk47x2q>
References: <20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com>
 <5925fd05-75fb-4e10-a022-bff5471bc317@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5925fd05-75fb-4e10-a022-bff5471bc317@rock-chips.com>

On Fri, Jan 16, 2026 at 04:02:38PM +0800, Shawn Lin wrote:
> 
> 在 2026/01/05 星期一 21:55, Manivannan Sadhasivam via B4 Relay 写道:
> > Hi,
> > 
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
> > 
> > Proposal
> > ========
> > 
> > This series addresses both issues by introducing new individual APIs for pwrctrl
> > device creation, destruction, power on, and power off operations. Controller
> > drivers are expected to invoke these APIs during their probe(), remove(),
> > suspend(), and resume() operations. This integration allows better coordination
> > between controller drivers and the pwrctrl framework, enabling enhanced features
> > such as D3Cold support.
> > 
> > The original design aimed to avoid modifying controller drivers for pwrctrl
> > integration. However, this approach lacked scalability because different
> > controllers have varying requirements for when devices should be powered on. For
> > example, controller drivers require devices to be powered on early for
> > successful PHY initialization.
> > 
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
> 
> This series looks great.
> 
> In practice, some PCIe devices may need to be powered down dynamically at
> runtime. For example, users might want to disable a PCIe Wi-Fi module when
> there's no internet usage — typically, commands like ifconfig wlan0 downonly
> bring the interface down but leave the Wi-Fi hardware powered. Is there a
> mechanism that would allow the Endpoint driver to leverage pwrctrl
> dynamically to support such power management scenarios?
> 

Glad that you've brought it up. You are talking about the usecase similar to
Airplane mode in mobiles, and we at Qcom are looking into this usecase in
upstream.

They way to handle this would be by using runtime PM ops. Once your WiFi or a
NIC driver runtime suspends, it will trigger the controller driver runtime
suspend callback. By that time, the controller driver can see if the device is
active or not (checking D states), whether wakeup is requested or not and then
initiate the D3Cold sequence using the APIs introduced in this series.

But that comes with a cost though, which is resume latency. It is generally not
advised to do D3Cold during runtime PM due to the latency and also device
lifetime issues (wearout etc...). So technically it is possible, but there are
challenges.

Krishna is going to post a series that allows the pcie-qcom driver to do D3Cold
during system suspend with these APIs. And we do have plans to extend it to
Airplane mode and similar usecases in the future.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

