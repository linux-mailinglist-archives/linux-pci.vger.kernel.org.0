Return-Path: <linux-pci+bounces-41959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD19C81875
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 17:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4278F4E6224
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 16:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E05315D44;
	Mon, 24 Nov 2025 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebAoZxgk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78305314B69;
	Mon, 24 Nov 2025 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001264; cv=none; b=gKaFSknPPYms1ma/Z5Ezd6NYsy/XD3FGPSVMBmKEre/tUgxsP8zJ3Ifv+AsSmczdZmxcFLuwbHPd1zTipQTFp0n4OO98GcescfHfS/p0F/897cdCpr/6Mb9U2knZ2Fq0k4dmRjDFSKfw68aHhyCDzYtj/x2Tv+k1HSw8WTimcoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001264; c=relaxed/simple;
	bh=G2oM8gOYxWUc+4XHDDX80aRKQxNbGdj0WBo+OD86mLc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AR36FGOKjGv1ngjbW8FfHXc0cnq7fjS9e8zlp9S8SQpDQBEoK3HkU0uWW5xSyQds9huaLwrBtobqpSF7rbfSNeNpt1lOXoDfFwFizDaccdGb/LuiUjezI2FX9+/jkeyrjLCLnjADAt4JlshzEoXmgd0Ebe0zUORMkbqKUtiRkp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebAoZxgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6214C116D0;
	Mon, 24 Nov 2025 16:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764001263;
	bh=G2oM8gOYxWUc+4XHDDX80aRKQxNbGdj0WBo+OD86mLc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ebAoZxgkgdDb5r8OLr0h7WjfVr8BdnrOiTJXqcxyFalE0IMsyZaJzVWJcMEPKeQkp
	 ewKfDE9MXk7NV1mBZVLl2UuogDQOkIpk18lggFK1bsUKtkIx6oZ3kF+VsRFXsgPnrQ
	 IVOa1reIo6WWpPyn8TKk40PHYRU/HkJWDCcGZmiyZSXNVvbn7r8EOsXrsHkXxpvRiI
	 lPvS0TNT1KW+ib5XEL1tSxYBOHwFnW0eXEVoJtDBKeuF+AMwJwKXrr58dLg7+1u9tq
	 W8X5gFRehlvOlFi6Tk6iKdWHpH4xLpNkwdixSwXLgsRi02gjQob2eRpAuROrGEz7vo
	 fzueFWg13/K8Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B412DCFD318;
	Mon, 24 Nov 2025 16:21:03 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH 0/5] PCI/pwrctrl: Major rework to integrate pwrctrl devices
 with controller drivers
Date: Mon, 24 Nov 2025 21:50:43 +0530
Message-Id: <20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANuFJGkC/x3MwQpAQBCA4VfRnE2ZjS1eRQ4ag4nYZoWSd7c5f
 of/fyCKqURosgdMTo26bwmUZ8Bzv02COiSDK1xF5EoMrBgu48NWNLl2W5Br6r2QZzd6SGEwGfX
 +p233vh9eGpGQZAAAAA==
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
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5672;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=G2oM8gOYxWUc+4XHDDX80aRKQxNbGdj0WBo+OD86mLc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpJIXrdQop8rUtEu6HwvV/4pMyrN00I6cSVXeyT
 XwLhcEPePeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaSSF6wAKCRBVnxHm/pHO
 9annB/0bjxxrAq+V6XYRhG3OKrCn4346jT8TUIks6PxHXyecd6UZyQTiGYq9Uc1Ox1ewUHkYxv7
 mb94cV/mETT0S3ruUjNzW1oZICkR07dQNpxq1IPMU5/TQPQ7rCDOFz4/qUmtimemJPJw5LbqD19
 1HAxkOIVTw/endUK3Fz38e4aQPrR6o/ck2h3dosEcDwQKqrO0aY1ZZVic1c5I1TKBkO568SB9Sv
 lpmMyLvfmzqM/7qJ3xjXy3bFztVhmFcwrkQn9076gaZ20mET9Z2aECIy/+3mpE+XEv+4IXw/ejo
 zplEWhUJ6Boge5Vdlwtbo5v08rZTvk59DrkqQnSDY6dKSxYg
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
probe. This is pretty much required to avoid the resource allocation issue.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Krishna Chaitanya Chundru (1):
      PCI/pwrctrl: Add APIs for explicitly creating and destroying pwrctrl devices

Manivannan Sadhasivam (4):
      PCI: qcom: Parse PERST# from all PCIe bridge nodes
      PCI/pwrctrl: Add 'struct pci_pwrctrl::power_{on/off}' callbacks
      PCI/pwrctrl: Add APIs to power on/off the pwrctrl devices
      PCI/pwrctrl: Switch to the new pwrctrl APIs

 drivers/pci/controller/dwc/pcie-qcom.c   | 124 +++++++++++++---
 drivers/pci/probe.c                      |  59 --------
 drivers/pci/pwrctrl/core.c               | 248 +++++++++++++++++++++++++++++--
 drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c |  30 +++-
 drivers/pci/pwrctrl/slot.c               |  46 ++++--
 drivers/pci/remove.c                     |  20 ---
 include/linux/pci-pwrctrl.h              |  16 +-
 7 files changed, 407 insertions(+), 136 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251124-pci-pwrctrl-rework-c91a6e16c2f6

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



