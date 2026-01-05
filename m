Return-Path: <linux-pci+bounces-44027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CD7CF3F86
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 14:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E8E33015586
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 13:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40289318138;
	Mon,  5 Jan 2026 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZXB+VgC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019F42F12BA;
	Mon,  5 Jan 2026 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767621366; cv=none; b=A2AalFett4NtXm7kgFEUw3EA5A8H8CJRI9mv6pACTe6yk9NJroqD+d2VcZcYy/ZECk0APetliMbx4XRN1cpwhQfo7mfoXpsdUOuE3O0S0kL6uZ0QUBTxE7t4G4H2tmAO/ZaH+s/r/fAUDjIrpn2SVc4fJORO9DuM6rc+0EdkxVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767621366; c=relaxed/simple;
	bh=QAF2L+yosmNKfQhDjh7zsZKYs44u7eMXzl1NoJSMU+4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D21HW3rdMHqpvRO9wXhENPb3Raondq+gonIsBFLFUnW3AJjocRM8qNJ9aLCrW4hu7VQoC1m3UD3Q3EZHRWYEbNVcOAj9+PGkTt8zJy4rBEwUaoE3pnkFoEXh6Cjm0cBH+Et6+FzV2Is7x2X+mao8CrPXJyhme2A+rXrJZ4LoWvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZXB+VgC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53B94C116D0;
	Mon,  5 Jan 2026 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767621365;
	bh=QAF2L+yosmNKfQhDjh7zsZKYs44u7eMXzl1NoJSMU+4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=oZXB+VgCc7W+fs9cjAHAdOZXm7Q3ppNx6cvCNHpwCPFQeQ3smDu1U0T/sU+r1QQXo
	 AK3KaJeLSr6fhr0BajtnmVG933QBRQACkPymBSXJiJV4yQtHcajY7UuMLQGLGudJFt
	 Edq7C+FlnBI9PR1b0xDFKz5cRYModbLZW0vfYyWzHFIoHpSsuWnaMfIQeZBt+c4pP1
	 9EP4QCvf5+m4FZxOiSEFzEq0/QPI+UK0k6XuOGDxYsUVxr0sV6v4y2T/wdAA6nwcoU
	 iYMQUe1mqg1101W8XLR8MgFrv0W2rTKatkDLKhJQd6C7+KqZ6IEKubAYcCNWJEFKLb
	 7KavQV2bB1gaQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430E7C79F93;
	Mon,  5 Jan 2026 13:56:05 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH v4 0/8] PCI/pwrctrl: Major rework to integrate pwrctrl
 devices with controller drivers
Date: Mon, 05 Jan 2026 19:25:40 +0530
Message-Id: <20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN3CW2kC/32QzW7CMBCEXyXyuY6y6/iPE++BenCcDViQBOwQW
 iHevU6o1B5oLyvNSvPtztxZohgosU1xZ5HmkMI4ZFG/Fcwf3LAnHtqsGVYoAbDmZx/4+Rb9FE8
 80m2MR+4tOEWgPHaKZeM5Uhc+VujuPetDSNMYP9cbMyzbf3Ez8Ipr4zQq1MqIdjumVF6u7uTHv
 i/zYAt1xh8SgnpJwoVUSyeVaGxD6g+S+EVC+5IkMsnrVlowvq3a5gXp8Ywe6XLNNU7P/KynlNx
 a46b4Tq0qAxpMaVBYDrx3Q9geKQ50Kse4Xxt0kz+slkYKCU3laugUmFrIzmpBDr1ALUlCW6uuA
 i8XV+MS8eWfMG2KWZVgefSQH3t8AY29wNHnAQAA
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
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Chen-Yu Tsai <wenst@chromium.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7654;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=QAF2L+yosmNKfQhDjh7zsZKYs44u7eMXzl1NoJSMU+4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpW8LxXC9atPotcdsq9t4BwmdfIXDcmFntls+GA
 Q3z+3BY2B+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVvC8QAKCRBVnxHm/pHO
 9SoQB/9sBLjTqbpqpupibHSrhwwseGIxxurOp3T8MAJFeomky3VJsj+WTRFBRxZCpPfEdVu5t/l
 PtRFsgAZ0n3oF4kmR6GPK19YO1278I9Zj4pek5vcsPaiU1AlwGXs3+ush26FRbhdlbfdAzCFcQ9
 W/RzB2Shs2ihjf2mgsuMZVG9XEkip2eKOYcqJvPM28p+jDGKNw+4/7QlKKhw6J7xU52J/h5/KtI
 f3HJN1ttEBbmI4VJjkkHJsRPfmwNFKYdx7hQpV6BahhN1hwK+xFQJ0UxGyU3tOX/Z5WOqCvkbgg
 It/q3JOh0DVAyvua129xk4cVYA7F34giK31Ly3ygKxlEPGMl
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
Changes in v4:
- Used platform_device_put()
- Changed the return value of power_off() callback to 'int'
- Splitted patch 6 into two and reworded the commit message
- Collected tags
- Link to v3: https://lore.kernel.org/r/20251229-pci-pwrctrl-rework-v3-0-c7d5918cd0db@oss.qualcomm.com

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

Manivannan Sadhasivam (7):
      PCI/pwrctrl: tc9563: Use put_device() instead of i2c_put_adapter()
      PCI/pwrctrl: Add 'struct pci_pwrctrl::power_{on/off}' callbacks
      PCI/pwrctrl: Add APIs to power on/off the pwrctrl devices
      PCI/pwrctrl: Switch to the new pwrctrl APIs
      PCI: qcom: Drop the assert_perst() callbacks
      PCI: Drop the assert_perst() callback
      PCI: qcom: Rename PERST# assert/deassert helpers for uniformity

 drivers/pci/bus.c                                 |  19 --
 drivers/pci/controller/dwc/pcie-designware-host.c |   9 -
 drivers/pci/controller/dwc/pcie-designware.h      |   9 -
 drivers/pci/controller/dwc/pcie-qcom.c            |  54 +++--
 drivers/pci/of.c                                  |   1 +
 drivers/pci/probe.c                               |  59 -----
 drivers/pci/pwrctrl/core.c                        | 260 ++++++++++++++++++++--
 drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c          |  30 ++-
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c          |  48 ++--
 drivers/pci/pwrctrl/slot.c                        |  48 ++--
 drivers/pci/remove.c                              |  20 --
 include/linux/pci-pwrctrl.h                       |  16 +-
 include/linux/pci.h                               |   1 -
 13 files changed, 367 insertions(+), 207 deletions(-)
---
base-commit: 3e7f562e20ee87a25e104ef4fce557d39d62fa85
change-id: 20251124-pci-pwrctrl-rework-c91a6e16c2f6
prerequisite-message-id: 20251126081718.8239-1-mani@kernel.org
prerequisite-patch-id: db9ff6c713e2303c397e645935280fd0d277793a
prerequisite-patch-id: b5351b0a41f618435f973ea2c3275e51d46f01c5

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



