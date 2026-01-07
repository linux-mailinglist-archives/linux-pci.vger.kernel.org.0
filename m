Return-Path: <linux-pci+bounces-44188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 756A0CFE30F
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 15:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E14DD300160B
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 14:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870B932FA30;
	Wed,  7 Jan 2026 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3lucvlo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F12332AAC4;
	Wed,  7 Jan 2026 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795086; cv=none; b=V6V4b9D7eiBo2wQRJAnW2INiwiKGgbXar2cSa8DuXgfAAVCjRRleJZk3sUJid4nQ4S1UeZbcfXCw1k7O4uchuu08scGEBd2r2Gb7hu3X/EoxjcABFzJBs3D273isjIfOnEithi+z+dG7S3T/lYXx5cVo06m9XQW+1ByCtwc7Emw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795086; c=relaxed/simple;
	bh=69kWmgb5kyt3827slfE0BXPQKtSt8cYB1ahtlFiFOGA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pVXy6H0rZ9y4Q+DAh6dJQ00woaXaX0ZKzD9NR5W+5oQJii8dvqEDfLeu/XVSMsUTFAyRcJsBS5icDYtQG4mRXckrRJZJ8/RUub/2SePR7pI5oeQ7MtBIE0nUSnq2SeUoKIBgnHqCRBQWwl1XwkzUEG58TTIV75BqR58rOGJUllk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3lucvlo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE31FC4CEF1;
	Wed,  7 Jan 2026 14:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767795085;
	bh=69kWmgb5kyt3827slfE0BXPQKtSt8cYB1ahtlFiFOGA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=s3lucvloK8RErUSRJhgi/LQuE/cmAbC1ZacJUcjeIcVc6AKVMtqVsL6bk1VxzRsIG
	 wxGrwNktqStx5s4x5B2YtsuFeJ1/5BugrF3UcAx/oL/YvDbuwr+dSD+vYHuGofTJxy
	 ZmGUXtscYcsBBwDpmgshNhx2RMWtqkHbkytwZWxCdzN2NDJDOFOzyc3Co75V+wLngx
	 +HIkCanqC1pNrA4tFnzG6verexyAOBC8IHTg1s3xT3TU2yg0QIVBQxeU37CZ6lZdUI
	 z/uUUsKEqe36RY7wcu6zDG0cCugxH56oZ2MQXYQurj8vy4ZfQeunR+2xwF7o+u4iCz
	 v5JHSYMECZ2/w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE88CFD642;
	Wed,  7 Jan 2026 14:11:25 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH v5 0/5] PCI: Add initial support for handling PCIe M.2
 connectors in devicetree
Date: Wed, 07 Jan 2026 19:41:22 +0530
Message-Id: <20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIppXmkC/3XNTQ6CMBAF4KuYri1ppz80rryHcdGWqTYRUapEY
 7i7hQRhIZtJ3mS+Nx+SsI2YyG7zIS12McXmmoPabog/2+sJaaxyJsBAcc4EvflIa6ClFkIL7nS
 wluTjW4shvsaiwzHnc0yPpn2PvR0ftlOFmio6Thk10qnAA0eFZt+kVNyf9uKbui7yIENTB0ttf
 hqyRuO8rEoXJFQrWiw0zL9F1l6BYRIsWlmuaDlrgPm3zFppI402jlUq/NF9338BCnfp7V0BAAA
 =
X-Change-ID: 20251103-pci-m2-7633631b6faa
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-pm@vger.kernel.org, linux-ide@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Frank Li <Frank.Li@nxp.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4312;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=69kWmgb5kyt3827slfE0BXPQKtSt8cYB1ahtlFiFOGA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpXmmL70dXctGXdSVrhDngLGraiqgTiIH+5K7Nk
 HosqhOtKTWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaV5piwAKCRBVnxHm/pHO
 9dAbB/4xBAwExMOzXRuRO7kkN1KIOU2V3du5JeI6lr8ThQF6kB0kDWOKFhqCzIet+echU4TE32N
 SPVLslEsbr0lcM1evYc8oXwIl7pFhMP1gly8ynfyv/4jVu2HOirEUMJTW4z2FTaOBvGsP1UgPWO
 1/AxfCJKgddDv2BX9v0UOGTEUb+TGUZMNbF1+C4xt9gmnjzTm7m45kwGlHDx4iHsdVJRh0THP3W
 4mjdwzdDPPf6cAIo+Ks/e47ttqil2dEqcy1sUclf8CuWz/msjJuQDbkxAHHJAD5uBofqNoGhTEi
 C2UJa2vITI5mE7p8YXP+TyISiDKHy9YISzr2SDthUJPufdz5
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

Hi,

This series is an initial attempt to support the PCIe M.2 connectors in the
kernel and devicetree binding. The PCIe M.2 connectors as defined in the PCI
Express M.2 Specification are widely used in Notebooks/Tablet form factors (even
in PCs). On the ACPI platforms, power to these connectors are mostly handled by
the firmware/BIOS and the kernel never bothered to directly power manage them as
like other PCIe connectors. But on the devicetree platforms, the kernel needs to
power manage these connectors with the help of the devicetree description. But
so far, there is no proper representation of the M.2 connectors in devicetree
binding. This forced the developers to fake the M.2 connectors as PMU nodes [1]
and fixed regulators in devicetree.

So to properly support the M.2 connectors in devicetree platforms, this series
introduces the devicetree binding for Mechanical Key M connector as an example
and also the corresponding pwrseq driver and PCI changes in kernel to driver the
connector.

The Mechanical Key M connector is used to connect SSDs to the host machine over
PCIe/SATA interfaces. Due to the hardware constraints, this series only adds
support for driving the PCIe interface of the connector in the kernel.

Also, the optional interfaces supported by the Key M connectors are not
supported in the driver and left for the future enhancements.

Testing
=======

This series, together with the devicetree changes [2] [3] were tested on the
Qualcomm X1e based Lenovo Thinkpad T14s Laptop which has the NVMe SSD connected
over PCIe.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts?h=v6.18-rc4&id=d09ab685a8f51ba412d37305ea62628a01cbea57
[2] https://github.com/Mani-Sadhasivam/linux/commit/40120d02219f34d2040ffa6328f0d406b1e4c04d
[3] https://github.com/Mani-Sadhasivam/linux/commit/ff6c3075836cc794a3700b0ec6a4a9eb21d14c6f

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Changes in v5:
- used of_node_get() and devm_action to free regulators
- Link to v4: https://lore.kernel.org/r/20251228-pci-m2-v4-0-5684868b0d5f@oss.qualcomm.com

Changes in v4:
- Added graph property to SATA in this series and PCI to dtschema:
  https://github.com/devicetree-org/dt-schema/pull/180
- Used 'i2c-parent' instead of SMBus port
- Reworded the -gpios property description
- Rebased on top of v6.19-rc1
- Link to v3: https://lore.kernel.org/r/20251125-pci-m2-v3-0-c528042aea47@oss.qualcomm.com

Changes in v3:
- Changed the VIO supply name as per dtschema
- Added explicit endpoint properties to port 0 node for host I/F
- Used scope based cleanup for OF node in pwrseq driver
- Collected review tags
- Link to v2: https://lore.kernel.org/r/20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com

Changes in v2:
- Incorporated comments from Bartosz and Frank for pwrseq and dt-binding
  patches, especially adding the pwrseq match() code.
- Link to v1: https://lore.kernel.org/r/20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com

---
Manivannan Sadhasivam (5):
      dt-bindings: ata: sata: Document the graph port
      dt-bindings: connector: Add PCIe M.2 Mechanical Key M connector
      PCI/pwrctrl: Add support for handling PCIe M.2 connectors
      PCI/pwrctrl: Create pwrctrl device if the graph port is found
      power: sequencing: Add the Power Sequencing driver for the PCIe M.2 connectors

 .../devicetree/bindings/ata/sata-common.yaml       |   3 +
 .../bindings/connector/pcie-m2-m-connector.yaml    | 133 ++++++++++++++++
 MAINTAINERS                                        |   7 +
 drivers/pci/probe.c                                |   3 +-
 drivers/pci/pwrctrl/Kconfig                        |   1 +
 drivers/pci/pwrctrl/slot.c                         |  35 ++++-
 drivers/power/sequencing/Kconfig                   |   8 +
 drivers/power/sequencing/Makefile                  |   1 +
 drivers/power/sequencing/pwrseq-pcie-m2.c          | 169 +++++++++++++++++++++
 9 files changed, 354 insertions(+), 6 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251103-pci-m2-7633631b6faa

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



