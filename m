Return-Path: <linux-pci+bounces-43811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F22CE7BCF
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 18:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D269301514D
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 17:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B04F329E71;
	Mon, 29 Dec 2025 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oj3hrbV0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FB82153D8;
	Mon, 29 Dec 2025 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767029226; cv=none; b=g3SdaBDlSxEAj8GAahB1LXuhadB2ap8u+YysORs6AC9+SANqwuSrBwkbagFrhS49c1k2Bw3v2QRZL6iwzsaPe1dqRQqTonjx5JiEYayup/8OkbWbWCP/3mF7U64Dnzhhzeo9VuPkBmqaM7nlOu788d1ylKqsMq0N2pMl2DzhH8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767029226; c=relaxed/simple;
	bh=mSpIdgtJwAirD0uQlsvlQ7lUCR7D8UPU2LCdtLtbkxw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kVzR5s1m/iC49O4EK4YKL+MYwHr0eYfBo1Og4S0nuHNSn9RWR1W8yF6AJfQJd9eAQToJ987f4zXun1TxVIltmB9Sd3yS01oNHnVQHWhGA3Dvg4Gj/eaQssTj283l+OhWaqT47KivWMOVRktCyC5r2RWS8K+GhDYKo9Bb17a70nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oj3hrbV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7185DC116C6;
	Mon, 29 Dec 2025 17:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767029225;
	bh=mSpIdgtJwAirD0uQlsvlQ7lUCR7D8UPU2LCdtLtbkxw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Oj3hrbV0tJmjJqFIE3eKEGF2LxWDk8CcH2ihQgGOZGtDycvSvR50Z1PomYYu+xrir
	 C+5WHjHUrgFRtqp8JQxPmXcdcETNjk2SxRk8llKAprs170w6g99cQNQ7uMT2j8ZvV+
	 Yvva+J0UWI5JyVgfK6HRg1GjxsNzUVeDPEBWbvqRoD5k3tGToDmtPSz37IuIgOvhD3
	 VUolsPeUayPTLd242EOBIJUU27nNCWDNwQ2QhbVgOwx1T2caAaQCsXwZse1vJ1WN0K
	 mrp+1RHpJd1xrdNVRMzNgzc6NnBi7WDV9Vqd4EC0RDQhitv4uKuYmKIOYNtibOs+p9
	 xmXvFRa9jlwxQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EF3E8FDC4;
	Mon, 29 Dec 2025 17:27:05 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH v3 0/7] PCI/pwrctrl: Major rework to integrate pwrctrl
 devices with controller drivers
Date: Mon, 29 Dec 2025 22:56:51 +0530
Message-Id: <20251229-pci-pwrctrl-rework-v3-0-c7d5918cd0db@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANu5UmkC/32PQW6DMBBFr4K8rhFjYxtY5R5RF8YMwUrAZExIq
 yh3ryGVuom6sfQt/TfvP1hE8hhZkz0Y4eqjD1MK8iNjbrDTCbnvUmaiEApAlHx2ns93cgtdOOE
 90Jm7GqxG0E70mqXiTNj7rx16/Ex58HEJ9L3fWGH7/Re3Ai+4qawRWhhdye4QYsyvN3txYRzz9
 LCNuoo/kgD9liQ2Uqms0rKtW9RvSM+XMOH1lsYvL2s2Yox2H99kv666qMBAlVdC1hz4aCd/OCN
 NeMkDnfbddnHDXmmVVNAWtoReQ1VK1ddGohVOCqNQQVfqvgCntlZrI/LNxy9Ntuocak4OktjzB
 xa8STCdAQAA
X-Change-ID: 20251124-pci-pwrctrl-rework-c91a6e16c2f6
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7317;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=mSpIdgtJwAirD0uQlsvlQ7lUCR7D8UPU2LCdtLtbkxw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpUrnljEhqNltdC/TYB2eF7ynwOBwldeM8ihcgB
 35w1h0iV6+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVK55QAKCRBVnxHm/pHO
 9RokB/9sf4gNjL3PXGt7i8O1BWYxdv2I8uMvr6CvomL+ILncbYwijyPeqVeyJ1XZNpl6V6GsD/t
 yLia7gy9OeOawJqOPgbxrLMxYFelfnqOVTwqgmFRJJH9HEFSNOG2NVwRkyaTg0oqG0aQ0h3pjJF
 01LO9XZJfbGeEZmsm3QoEe7dLa3BjBg6Yjm7e7MopSwLONeC4BXFRJB8tOUzsbiqsA/fM9PbBCS
 ljuL2GD6ma99GWjtkvR/h7P7i4sWeGS25WAUtTgFK/X9a/2/kXBj3KonOx/WLAIpFqWDH+IGIsI
 YqHrA0Us1zq0sJSBUwNZa2PNDdtEIQfJxUBTaPd424SlzOah
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

Hi,

This series provides a major rework for the PCI power control (pwrctrl)
framework to enable the pwrctrl devices to be controlled by the PCI controller
drivers.

Problem Statement
=================

Currently, the pwrctrl framework faces two major issues:

1. Missing PERST# integration
2. Inability to properly handle bus extenders such as PCIe switch devices

First issue arises from the disconnect between the PCI controller drivers and
pwrctrl framework. At present, the pwrctrl framework just operates on its own
with the help of the PCI core. The pwrctrl devices are created by the PCI core
during initial bus scan and the pwrctrl drivers once bind, just power on the
PCI devices during their probe(). This design conflicts with the PCI Express
Card Electromechanical Specification requirements for PERST# timing. The reason
is, PERST# signals are mostly handled by the controller drivers and often
deasserted even before the pwrctrl drivers probe. According to the spec, PERST#
should be deasserted only after power and reference clock to the device are
stable, within predefined timing parameters.

The second issue stems from the PCI bus scan completing before pwrctrl drivers
probe. This poses a significant problem for PCI bus extenders like switches
because the PCI core allocates upstream bridge resources during the initial
scan. If the upstream bridge is not hotplug capable, resources are allocated
only for the number of downstream buses detected at scan time, which might be
just one if the switch was not powered and enumerated at that time. Later, when
the pwrctrl driver powers on and enumerates the switch, enumeration fails due to
insufficient upstream bridge resources.

Proposal
========

This series addresses both issues by introducing new individual APIs for pwrctrl
device creation, destruction, power on, and power off operations. Controller
drivers are expected to invoke these APIs during their probe(), remove(),
suspend(), and resume() operations. This integration allows better coordination
between controller drivers and the pwrctrl framework, enabling enhanced features
such as D3Cold support.

The original design aimed to avoid modifying controller drivers for pwrctrl
integration. However, this approach lacked scalability because different
controllers have varying requirements for when devices should be powered on. For
example, controller drivers require devices to be powered on early for
successful PHY initialization.

By using these explicit APIs, controller drivers gain fine grained control over
their associated pwrctrl devices.

This series modified the pcie-qcom driver (only consumer of pwrctrl framework)
to adopt to these APIs and also removed the old pwrctrl code from PCI core. This
could be used as a reference to add pwrctrl support for other controller drivers
also.

For example, to control the 3.3v supply to the PCI slot where the NVMe device is
connected, below modifications are required:

Devicetree
----------

	// In SoC dtsi:

	pci@1bf8000 { // controller node
		...
		pcie1_port0: pcie@0 { // PCI Root Port node
			compatible = "pciclass,0604"; // required for pwrctrl
							 driver bind
			...
		};
	};

	// In board dts:

	&pcie1_port0 {
		reset-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>; // optional
		vpcie3v3-supply = <&vreg_nvme>; // NVMe power supply
	};

Controller driver
-----------------

	// Select PCI_PWRCTRL_SLOT in controller Kconfig

	probe() {
		...
		// Initialize controller resources
		pci_pwrctrl_create_devices(&pdev->dev);
		pci_pwrctrl_power_on_devices(&pdev->dev);
		// Deassert PERST# (optional)
		...
		pci_host_probe(); // Allocate host bridge and start bus scan
	}

	suspend {
		// PME_Turn_Off broadcast
		// Assert PERST# (optional)
		pci_pwrctrl_power_off_devices(&pdev->dev);
		...
	}

	resume {
		...
		pci_pwrctrl_power_on_devices(&pdev->dev);
		// Deassert PERST# (optional)
	}

I will add a documentation for the pwrctrl framework in the coming days to make
it easier to use.

Testing
=======

This series is tested on the Lenovo Thinkpad T14s laptop based on Qcom X1E
chipset and RB3Gen2 development board with TC9563 switch based on Qcom QCS6490
chipset.

**NOTE**: With this series, the controller driver may undergo multiple probe
deferral if the pwrctrl driver was not available during the controller driver
probe. This is pretty much required to avoid the resource allocation issue. I
plan to replace probe deferral with blocking wait in the coming days.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Changes in v3:
- Integrated TC9563 change
- Reworked the power_on API to properly power off the devices in error path
- Fixed the error path in pcie-qcom.c to not destroy pwrctrl devices during
  probe deferral
- Rebased on top of pci/controller/dwc-qcom branch and dropped the PERST# patch
- Added a patch for TC9563 to fix the refcount dropping for i2c adapter
- Added patches to drop the assert_perst callback and rename the PERST# helpers in
  pcie-qcom.c
- Link to v2: https://lore.kernel.org/r/20251216-pci-pwrctrl-rework-v2-0-745a563b9be6@oss.qualcomm.com

Changes in v2:
- Exported of_pci_supply_present() API
- Demoted the -EPROBE_DEFER log to dev_dbg()
- Collected tags and rebased on top of v6.19-rc1
- Link to v1: https://lore.kernel.org/r/20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com

---
Krishna Chaitanya Chundru (1):
      PCI/pwrctrl: Add APIs for explicitly creating and destroying pwrctrl devices

Manivannan Sadhasivam (6):
      PCI/pwrctrl: tc9563: Use put_device() instead of i2c_put_adapter()
      PCI/pwrctrl: Add 'struct pci_pwrctrl::power_{on/off}' callbacks
      PCI/pwrctrl: Add APIs to power on/off the pwrctrl devices
      PCI/pwrctrl: Switch to the new pwrctrl APIs
      PCI: qcom: Drop the assert_perst() callbacks
      PCI: qcom: Rename PERST# assert/deassert helpers for uniformity

 drivers/pci/bus.c                                 |  19 --
 drivers/pci/controller/dwc/pcie-designware-host.c |   9 -
 drivers/pci/controller/dwc/pcie-designware.h      |   8 -
 drivers/pci/controller/dwc/pcie-qcom.c            |  54 +++--
 drivers/pci/of.c                                  |   1 +
 drivers/pci/probe.c                               |  59 -----
 drivers/pci/pwrctrl/core.c                        | 260 ++++++++++++++++++++--
 drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c          |  30 ++-
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c          |  46 ++--
 drivers/pci/pwrctrl/slot.c                        |  46 ++--
 drivers/pci/remove.c                              |  20 --
 include/linux/pci-pwrctrl.h                       |  16 +-
 include/linux/pci.h                               |   1 -
 13 files changed, 363 insertions(+), 206 deletions(-)
---
base-commit: 3e7f562e20ee87a25e104ef4fce557d39d62fa85
change-id: 20251124-pci-pwrctrl-rework-c91a6e16c2f6
prerequisite-message-id: 20251126081718.8239-1-mani@kernel.org
prerequisite-patch-id: db9ff6c713e2303c397e645935280fd0d277793a
prerequisite-patch-id: b5351b0a41f618435f973ea2c3275e51d46f01c5

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



