Return-Path: <linux-pci+bounces-45025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F673D2DB76
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 09:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B995830393EE
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 08:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6192A2D640D;
	Fri, 16 Jan 2026 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="UeZ0I/xs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m1973172.qiye.163.com (mail-m1973172.qiye.163.com [220.197.31.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A1926ED25;
	Fri, 16 Jan 2026 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768550884; cv=none; b=I5xqwzCKdR8fMumefEqaE9m18nn/+qaT0O0Y8TJECh2OpZ1c71Cbzn4ulV0QEnNN7i+oQKWvwRqD2ylq+CqfHqrRp6W95tOPOD9k76awIX3imrSGVL1Kf+ie/d3dhg9PjipEvO7Y74nbhow1tyVTu3YsJlFzg2+HQlXXc4cAA8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768550884; c=relaxed/simple;
	bh=BaXXVsD7u+x+dzmJhW14VDMTfapIp68F3I3eFaVeZcI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dEJOBCpMC2Aa/oyI5NCiUXHiFtfEbnDg5KgoN6Vw3LWfAA+Dcfe+/q+boQqHYFo9Qec6GuniSbOYZmdH0N0E4fgKq0UO1pyRPNE7SZCNuNFkjswT5YpKZyZPOS5Dz8WsanxrZ/HmcdJFWEEN7JdtvXm4Io6ccUl9uE89gkU+dpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=UeZ0I/xs; arc=none smtp.client-ip=220.197.31.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30e4d5a1a;
	Fri, 16 Jan 2026 16:02:39 +0800 (GMT+08:00)
Message-ID: <5925fd05-75fb-4e10-a022-bff5471bc317@rock-chips.com>
Date: Fri, 16 Jan 2026 16:02:38 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@kernel.org>, Brian Norris <briannorris@chromium.org>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Chen-Yu Tsai <wenst@chromium.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 0/8] PCI/pwrctrl: Major rework to integrate pwrctrl
 devices with controller drivers
To: manivannan.sadhasivam@oss.qualcomm.com,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>
References: <20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bc5d3efd809cckunm4edc62de6fcbcc
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh5CHVZJTx1MSRoaSUMeGkxWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=UeZ0I/xsZN32drWV/dQz/hBJ6+WpFQrka1718RvSBCvUTdPy6e3j1JsiKGO+y10efoBM+GM7SwwdpvJGDiNxQDLgM0UFIotZpbL1NfqgPRCrs3YpWO6wXdRk/ADPl4U1b+wHurk48TuXa7PFXYHsCY+RxwPKFR7P0tJDEX0RGUA=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Ud8+iwGQrgybsIEyL8sn0UomujULSN26bTMhyz4V/UU=;
	h=date:mime-version:subject:message-id:from;


在 2026/01/05 星期一 21:55, Manivannan Sadhasivam via B4 Relay 写道:
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

This series looks great.

In practice, some PCIe devices may need to be powered down dynamically 
at runtime. For example, users might want to disable a PCIe Wi-Fi module 
when there's no internet usage — typically, commands like ifconfig wlan0 
downonly bring the interface down but leave the Wi-Fi hardware powered. 
Is there a mechanism that would allow the Endpoint driver to leverage 
pwrctrl dynamically to support such power management scenarios?


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
>    probe deferral
> - Rebased on top of pci/controller/dwc-qcom branch and dropped the PERST# patch
> - Added a patch for TC9563 to fix the refcount dropping for i2c adapter
> - Added patches to drop the assert_perst callback and rename the PERST# helpers in
>    pcie-qcom.c
> - Link to v2: https://lore.kernel.org/r/20251216-pci-pwrctrl-rework-v2-0-745a563b9be6@oss.qualcomm.com
> 
> Changes in v2:
> - Exported of_pci_supply_present() API
> - Demoted the -EPROBE_DEFER log to dev_dbg()
> - Collected tags and rebased on top of v6.19-rc1
> - Link to v1: https://lore.kernel.org/r/20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com
> 
> ---
> Krishna Chaitanya Chundru (1):
>        PCI/pwrctrl: Add APIs for explicitly creating and destroying pwrctrl devices
> 
> Manivannan Sadhasivam (7):
>        PCI/pwrctrl: tc9563: Use put_device() instead of i2c_put_adapter()
>        PCI/pwrctrl: Add 'struct pci_pwrctrl::power_{on/off}' callbacks
>        PCI/pwrctrl: Add APIs to power on/off the pwrctrl devices
>        PCI/pwrctrl: Switch to the new pwrctrl APIs
>        PCI: qcom: Drop the assert_perst() callbacks
>        PCI: Drop the assert_perst() callback
>        PCI: qcom: Rename PERST# assert/deassert helpers for uniformity
> 
>   drivers/pci/bus.c                                 |  19 --
>   drivers/pci/controller/dwc/pcie-designware-host.c |   9 -
>   drivers/pci/controller/dwc/pcie-designware.h      |   9 -
>   drivers/pci/controller/dwc/pcie-qcom.c            |  54 +++--
>   drivers/pci/of.c                                  |   1 +
>   drivers/pci/probe.c                               |  59 -----
>   drivers/pci/pwrctrl/core.c                        | 260 ++++++++++++++++++++--
>   drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c          |  30 ++-
>   drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c          |  48 ++--
>   drivers/pci/pwrctrl/slot.c                        |  48 ++--
>   drivers/pci/remove.c                              |  20 --
>   include/linux/pci-pwrctrl.h                       |  16 +-
>   include/linux/pci.h                               |   1 -
>   13 files changed, 367 insertions(+), 207 deletions(-)
> ---
> base-commit: 3e7f562e20ee87a25e104ef4fce557d39d62fa85
> change-id: 20251124-pci-pwrctrl-rework-c91a6e16c2f6
> prerequisite-message-id: 20251126081718.8239-1-mani@kernel.org
> prerequisite-patch-id: db9ff6c713e2303c397e645935280fd0d277793a
> prerequisite-patch-id: b5351b0a41f618435f973ea2c3275e51d46f01c5
> 
> Best regards,


