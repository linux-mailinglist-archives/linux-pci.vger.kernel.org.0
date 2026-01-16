Return-Path: <linux-pci+bounces-45027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4853DD2E41B
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 09:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D60F30255BE
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 08:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA28E3019C5;
	Fri, 16 Jan 2026 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="XvXqCHb7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3277.qiye.163.com (mail-m3277.qiye.163.com [220.197.32.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8043C17;
	Fri, 16 Jan 2026 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768553359; cv=none; b=QH/Za2jt4rd1tzTG6re+2RtlA3F21F7c4K0u2TdTurlswLySjbX2tq+a6uS1Th2grcDCHRiQn/A5AlnYvifC08F/Ao/s/pb9E5DMlrOkcTS7D1qRgq2NUIYbjZTcOl84J3wb3u0921NJitydkt9LYnUCPgj/6YsAQLOu+/6gMBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768553359; c=relaxed/simple;
	bh=w4ormQANbTROoDdeCBKc3WkvgnugxLg+5E8J/LNJ4j8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ntXZWHXabxvvHvR4OvchsskW9gb9Nx8ePSKbWNXhpAdCfLIQ2GRpBdUYRUVjUVK3MstRaabSti0E0jw9gD+0doZO4kCtk0/6UAZe2U6NEhQVW8UjUVmzXE0GErTKIdUtTnsy3pHzFM8Yg0nOx6BSM3I3FunRsntb5ZjGl2j9AXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=XvXqCHb7; arc=none smtp.client-ip=220.197.32.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30e6775f4;
	Fri, 16 Jan 2026 16:43:55 +0800 (GMT+08:00)
Message-ID: <a1f7be0b-57f7-4048-8c43-d101a9c0e1a7@rock-chips.com>
Date: Fri, 16 Jan 2026 16:43:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, manivannan.sadhasivam@oss.qualcomm.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@kernel.org>, Brian Norris <briannorris@chromium.org>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Chen-Yu Tsai <wenst@chromium.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 0/8] PCI/pwrctrl: Major rework to integrate pwrctrl
 devices with controller drivers
To: Manivannan Sadhasivam <mani@kernel.org>
References: <20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com>
 <5925fd05-75fb-4e10-a022-bff5471bc317@rock-chips.com>
 <czpmvuxfdilf5onrh25tucnr2ar42stga4one2jhh4q7h3vspf@rnzgnrk47x2q>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <czpmvuxfdilf5onrh25tucnr2ar42stga4one2jhh4q7h3vspf@rnzgnrk47x2q>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bc5f9b82b09cckunm87e668957069d3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk5NGlZKGBlOH09IHhofHhlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=XvXqCHb79jKNsf8/OwfVN3lyoUTkpC3hr1wIOKhy911N7FbDXWycpYbv2Ap6aM3YX4rfhsu/xQLDlKGWUpVsVNw4KLD3tmULuTECkVSw21X/YIMjAcNlOzoAXo5XsY/MNCbty9qEy5bDSc42gazp2Zgp7IZVLXCLCzkLBpTBYdo=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=GgvurW3btzsyy7Vm2BbFBOddK6G41Q/w+3yy/baB8P8=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/16 星期五 16:30, Manivannan Sadhasivam 写道:
> On Fri, Jan 16, 2026 at 04:02:38PM +0800, Shawn Lin wrote:
>>
>> 在 2026/01/05 星期一 21:55, Manivannan Sadhasivam via B4 Relay 写道:
>>> Hi,
>>>
>>> This series provides a major rework for the PCI power control (pwrctrl)
>>> framework to enable the pwrctrl devices to be controlled by the PCI controller
>>> drivers.
>>>
>>> Problem Statement
>>> =================
>>>
>>> Currently, the pwrctrl framework faces two major issues:
>>>
>>> 1. Missing PERST# integration
>>> 2. Inability to properly handle bus extenders such as PCIe switch devices
>>>
>>> First issue arises from the disconnect between the PCI controller drivers and
>>> pwrctrl framework. At present, the pwrctrl framework just operates on its own
>>> with the help of the PCI core. The pwrctrl devices are created by the PCI core
>>> during initial bus scan and the pwrctrl drivers once bind, just power on the
>>> PCI devices during their probe(). This design conflicts with the PCI Express
>>> Card Electromechanical Specification requirements for PERST# timing. The reason
>>> is, PERST# signals are mostly handled by the controller drivers and often
>>> deasserted even before the pwrctrl drivers probe. According to the spec, PERST#
>>> should be deasserted only after power and reference clock to the device are
>>> stable, within predefined timing parameters.
>>>
>>> The second issue stems from the PCI bus scan completing before pwrctrl drivers
>>> probe. This poses a significant problem for PCI bus extenders like switches
>>> because the PCI core allocates upstream bridge resources during the initial
>>> scan. If the upstream bridge is not hotplug capable, resources are allocated
>>> only for the number of downstream buses detected at scan time, which might be
>>> just one if the switch was not powered and enumerated at that time. Later, when
>>> the pwrctrl driver powers on and enumerates the switch, enumeration fails due to
>>> insufficient upstream bridge resources.
>>>
>>> Proposal
>>> ========
>>>
>>> This series addresses both issues by introducing new individual APIs for pwrctrl
>>> device creation, destruction, power on, and power off operations. Controller
>>> drivers are expected to invoke these APIs during their probe(), remove(),
>>> suspend(), and resume() operations. This integration allows better coordination
>>> between controller drivers and the pwrctrl framework, enabling enhanced features
>>> such as D3Cold support.
>>>
>>> The original design aimed to avoid modifying controller drivers for pwrctrl
>>> integration. However, this approach lacked scalability because different
>>> controllers have varying requirements for when devices should be powered on. For
>>> example, controller drivers require devices to be powered on early for
>>> successful PHY initialization.
>>>
>>> By using these explicit APIs, controller drivers gain fine grained control over
>>> their associated pwrctrl devices.
>>>
>>> This series modified the pcie-qcom driver (only consumer of pwrctrl framework)
>>> to adopt to these APIs and also removed the old pwrctrl code from PCI core. This
>>> could be used as a reference to add pwrctrl support for other controller drivers
>>> also.
>>>
>>> For example, to control the 3.3v supply to the PCI slot where the NVMe device is
>>> connected, below modifications are required:
>>>
>>> Devicetree
>>> ----------
>>>
>>> 	// In SoC dtsi:
>>>
>>> 	pci@1bf8000 { // controller node
>>> 		...
>>> 		pcie1_port0: pcie@0 { // PCI Root Port node
>>> 			compatible = "pciclass,0604"; // required for pwrctrl
>>> 							 driver bind
>>> 			...
>>> 		};
>>> 	};
>>>
>>> 	// In board dts:
>>>
>>> 	&pcie1_port0 {
>>> 		reset-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>; // optional
>>> 		vpcie3v3-supply = <&vreg_nvme>; // NVMe power supply
>>> 	};
>>>
>>> Controller driver
>>> -----------------
>>>
>>> 	// Select PCI_PWRCTRL_SLOT in controller Kconfig
>>>
>>> 	probe() {
>>> 		...
>>> 		// Initialize controller resources
>>> 		pci_pwrctrl_create_devices(&pdev->dev);
>>> 		pci_pwrctrl_power_on_devices(&pdev->dev);
>>> 		// Deassert PERST# (optional)
>>> 		...
>>> 		pci_host_probe(); // Allocate host bridge and start bus scan
>>> 	}
>>>
>>> 	suspend {
>>> 		// PME_Turn_Off broadcast
>>> 		// Assert PERST# (optional)
>>> 		pci_pwrctrl_power_off_devices(&pdev->dev);
>>> 		...
>>> 	}
>>>
>>> 	resume {
>>> 		...
>>> 		pci_pwrctrl_power_on_devices(&pdev->dev);
>>> 		// Deassert PERST# (optional)
>>> 	}
>>>
>>> I will add a documentation for the pwrctrl framework in the coming days to make
>>> it easier to use.
>>>
>>
>> This series looks great.
>>
>> In practice, some PCIe devices may need to be powered down dynamically at
>> runtime. For example, users might want to disable a PCIe Wi-Fi module when
>> there's no internet usage — typically, commands like ifconfig wlan0 downonly
>> bring the interface down but leave the Wi-Fi hardware powered. Is there a
>> mechanism that would allow the Endpoint driver to leverage pwrctrl
>> dynamically to support such power management scenarios?
>>
> 
> Glad that you've brought it up. You are talking about the usecase similar to
> Airplane mode in mobiles, and we at Qcom are looking into this usecase in
> upstream.
> 
> They way to handle this would be by using runtime PM ops. Once your WiFi or a
> NIC driver runtime suspends, it will trigger the controller driver runtime
> suspend callback. By that time, the controller driver can see if the device is
> active or not (checking D states), whether wakeup is requested or not and then
> initiate the D3Cold sequence using the APIs introduced in this series.
> 
> But that comes with a cost though, which is resume latency. It is generally not
> advised to do D3Cold during runtime PM due to the latency and also device
> lifetime issues (wearout etc...). So technically it is possible, but there are
> challenges.
> 

Indeed, that's a fundamental power-performance trade-off for 
battery-powered devices.

> Krishna is going to post a series that allows the pcie-qcom driver to do D3Cold
> during system suspend with these APIs. And we do have plans to extend it to
> Airplane mode and similar usecases in the future.
> 

Thanks for sharing this details.

> - Mani
> 


