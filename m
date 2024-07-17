Return-Path: <linux-pci+bounces-10440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B279340EE
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 19:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28941F2366D
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 17:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E88182A4E;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5hHJG6k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343CA180A99;
	Wed, 17 Jul 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235795; cv=none; b=oqUJYbRA5PTfCgrMLdEHaOua4NCzljVKfZHu4KbFJ+C0w8uYCbdEXWZb/1xv+UFQt7QjXhnn1O5W0+Y13DsByZ0464JQRYnAJ3XAtohK6/+0L/h61qE/ntbW2cTK26q/Wl4zf/ZiU/vYv+uZQ5BMLOBzVDlo91VlyTnTJLG8dyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235795; c=relaxed/simple;
	bh=Gl1Lq4eAwwgbdu9A+/5F0Vm/X1cX0EaWkeT2ZW+e1L4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pXctMXH8+CLhVK/JamLeVqetwCZbo5KVEgRQp7bpwVnxTKToNVz4aT4eA2fvymO442E3n8Bwp96MWyYzup0jm+JXhJPikpBOu4AehuMhtdw1U1jCyEXdfmRC5ierkA9MGr+OvqZmjkxEyiw2sGhTeg5iFcOuNyy4VN4IjxaTltg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5hHJG6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3E10C2BD10;
	Wed, 17 Jul 2024 17:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721235794;
	bh=Gl1Lq4eAwwgbdu9A+/5F0Vm/X1cX0EaWkeT2ZW+e1L4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=p5hHJG6kstysulXiP+AbGmjFa1RB0rZjwGlixSl2uZpO61I9xThSksxnIv6daPBjo
	 RMsV/iJ8jZzll6LfrSEic8PKJ3ew3BKgDmMk4qUWsBdsQDgXbJ9AV4muVsCNOyGZnv
	 tbBd6k64VzQgmq1ObPvfL9tj//7AqXra3+UplaQHpODvdIsRJrO8gzsYe8W3rVL/Z4
	 7Kgj73wzxgzIIm4GsbRq5sF65yILDXcSWWEnZ3qlU8YCSoE+C7qnbgE2SVoohehX8x
	 EunYhZ57lONq7CCzK4amn5Unk2eo/JjUO3tn0xvKjvkKQY38e/LCRUR+2wytV4Z959
	 KDBGl3qxoMsaA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBE5C3DA60;
	Wed, 17 Jul 2024 17:03:14 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Subject: [PATCH v2 00/13] PCI: qcom: Simulate PCIe hotplug using 'global'
 interrupt
Date: Wed, 17 Jul 2024 22:33:05 +0530
Message-Id: <20240717-pci-qcom-hotplug-v2-0-71d304b817f8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEn5l2YC/32NQQ6CMBBFr0Jm7RjaWlFX3sOwqNNSJsEWWyQaw
 t2tHMDle8l/f4HsErsMl2qB5GbOHEMBuauAehO8Q7aFQdbyUDdC40iMT4oP7OM0Di+Pd7JOkFD
 2LDooszG5jt9b8tYW7jlPMX22h1n87J/YLLBG3anmqIlOjTLXgYNJcR+Th3Zd1y/tpdaKsQAAA
 A==
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3577;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=Gl1Lq4eAwwgbdu9A+/5F0Vm/X1cX0EaWkeT2ZW+e1L4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBml/lMWZqx1/Pu5k8yOvC0cHLJvHvnFyhXkKdAr
 CC/3RTnQY6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpf5TAAKCRBVnxHm/pHO
 9aBjB/oDBwWK+E0JQrCLxm+aj51YYDYhHG2it2pHg3tdqnaQrrAWumg8aclJ2rg1sXfJ1t9SCL8
 eqcpg+C6apu+yd/8uS8TwyJ8e3KnC0/EJs23u4BKYHOxm451J/rY2LLmHxCU63Ey9fKuqHzvoh4
 IuoA1FIENtU1IkgLpq2HBsfVIiXSB6mSmcTY59vczYa1GTTZ6MNfSmn3+q9DX1wSj3pnmdvvB2n
 Ud60Upb7Jnai9DwtOEZOFqRNbasvIbcml+NjPSVUNuoX6aMCnm9str2Ur9ETFG6QxY/EK0gWXyq
 4TLhnqxOXNOI20qM46EzD0QwngLpZG6HEpyF68YzGhGoKaRS
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

Hi,

This series adds support to simulate PCIe hotplug using the Qcom specific
'global' IRQ. Historically, Qcom PCIe RC controllers lack standard hotplug
support. So when an endpoint is attached to the SoC, users have to rescan the
bus manually to enumerate the device. But this can be avoided by simulating the
PCIe hotplug using Qcom specific way.

Qcom PCIe RC controllers are capable of generating the 'global' SPI interrupt
to the host CPUs. The device driver can use this event to identify events such
as PCIe link specific events, safety events etc...

One such event is the PCIe Link up event generated when an endpoint is detected
on the bus and the Link is 'up'. This event can be used to simulate the PCIe
hotplug in the Qcom SoCs.

So add support for capturing the PCIe Link up event using the 'global' interrupt
in the driver. Once the Link up event is received, the bus underneath the host
bridge is scanned to enumerate PCIe endpoint devices, thus simulating hotplug.

This series also has some cleanups to the Qcom PCIe EP controller driver for
interrupt handling.

Testing
=======

This series is tested on Qcom SM8450 based development board that has 2 SoCs
connected over PCIe.

- Mani

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v2:
- Added CONFIG_PCI_DOMAINS_GENERIC guard for domain_nr
- Switched to dev_WARN_ONCE() for unhandled interrupts
- Squashed the 'linux,pci-domain' bindings patches into one
- Link to v1: https://lore.kernel.org/r/20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org

---
Manivannan Sadhasivam (13):
      PCI: qcom-ep: Drop the redundant masking of global IRQ events
      PCI: qcom-ep: Reword the error message for receiving unknown global IRQ event
      dt-bindings: PCI: pci-ep: Update Maintainers
      dt-bindings: PCI: pci-ep: Document 'linux,pci-domain' property
      PCI: endpoint: Assign PCI domain number for endpoint controllers
      PCI: qcom-ep: Modify 'global_irq' and 'perst_irq' IRQ device names
      ARM: dts: qcom: sdx55: Add 'linux,pci-domain' to PCIe EP controller node
      ARM: dts: qcom: sdx65: Add 'linux,pci-domain' to PCIe EP controller node
      arm64: dts: qcom: sa8775p: Add 'linux,pci-domain' to PCIe EP controller nodes
      dt-bindings: PCI: qcom: Add 'global' interrupt
      dt-bindings: PCI: qcom,pcie-sm8450: Add 'global' interrupt
      PCI: qcom: Simulate PCIe hotplug using 'global' interrupt
      arm64: dts: qcom: sm8450: Add 'global' interrupt to the PCIe RC node

 Documentation/devicetree/bindings/pci/pci-ep.yaml  | 14 +++++-
 .../devicetree/bindings/pci/qcom,pcie-common.yaml  |  4 +-
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      |  1 +
 .../devicetree/bindings/pci/qcom,pcie-sm8450.yaml  | 10 ++--
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi             |  1 +
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi             |  1 +
 arch/arm64/boot/dts/qcom/sa8775p.dtsi              |  2 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi               | 12 +++--
 drivers/pci/controller/dwc/pcie-qcom-ep.c          | 21 +++++++--
 drivers/pci/controller/dwc/pcie-qcom.c             | 55 +++++++++++++++++++++-
 drivers/pci/endpoint/pci-epc-core.c                | 10 ++++
 include/linux/pci-epc.h                            |  2 +
 12 files changed, 116 insertions(+), 17 deletions(-)
---
base-commit: 91e3b24eb7d297d9d99030800ed96944b8652eaf
change-id: 20240715-pci-qcom-hotplug-bcde1c13d91f

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>



