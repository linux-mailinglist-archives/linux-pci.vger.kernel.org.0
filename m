Return-Path: <linux-pci+bounces-12356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4CE962CC5
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 17:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE231F2481B
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 15:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08F91A38DE;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oU13eOsi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C6F1A2573;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859984; cv=none; b=j4L+Qha6eo6mPkjXpxod9H59voy+h42YR28SqQdkP7w6cnpmkUyFhZ/LG9Q13HCobui5LiLvk9eNtw1g22r0oZx1ZycAAxknLcLIuVnplgtAbvAqzMdhNsD5x4W46hEHEGN5P2JmVsPQ83koUOdFFHM/GmJGVVdJboCzv+fxDDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859984; c=relaxed/simple;
	bh=/0egYTr5ShlYzFc5fPufNhKrQdIPFsVyuFZm+VJjZew=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K3n+xxZcJdV201lFyXInFPe5DFnoGSMSm+9na7KcP7r/IoVtneSf5GZ9JIWheNlN/qmYs259Zg9nnm6bbFyBOEhBY3slH4Ocy06k8allvn4gEy8bMpTVQOnKWEIkQJ7oxtzdV6N1oaejN5100kNE+cyhIauDEmmETm8SLHRXr4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oU13eOsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1104DC4CEC7;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724859984;
	bh=/0egYTr5ShlYzFc5fPufNhKrQdIPFsVyuFZm+VJjZew=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=oU13eOsiw7kyfs9OY8XY2o605DXdUa/+Ps/8ooLIDc9W2c1iponTiVc0//Pc0XzQm
	 Nzbtzt81Qf2B0J1C7nj9HdzMLHQyRSE4O9k/XcQDvJYCl9OOsMbtcYN5nlG64HmMld
	 wY4nYINUMtYseg6OBSHqITVUPdsott4tqA0a+ec1VbA08YlPHJyJJyb2tdZabYUj7a
	 JJvJeZF61jqBIF6Pm5DOUYItmjzOEgHrvvI6FiPsrFnU325otpOvh4XO+s7phcSKMX
	 VFySUko/hS+2PWMZBqNg5qWm+8xR5aYw+Q+kp5guHXy1t/dQt2b1AUDjSGJiUiw9VC
	 QFGCJYYuC80Lw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04992C5B557;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Subject: [PATCH v4 00/12] PCI: qcom: Enumerate endpoints based on Link up
 event in 'global_irq' interrupt
Date: Wed, 28 Aug 2024 21:16:10 +0530
Message-Id: <20240828-pci-qcom-hotplug-v4-0-263a385fbbcb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEJGz2YC/33NTQ6CMBCG4auQrq1h2kLRlfcwLkp/oAlSbLHRE
 O5uYYWRuHy/ZJ6ZUNDe6oDO2YS8jjZY16dghwzJVvSNxlalRiQnLOdQ4EFa/JDujls3Dt2zwbV
 UGiRQdQKD0tngtbGvlbzeUrc2jM6/1w8RlvUPFgHnuDCUl4WUFafi0tleeHd0vkGLFslW4DsCS
 QIHRXNWV8BN9SPQjUBhR6BJEMBIKYzSmtZfwjzPH3xq61M1AQAA
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4619;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=/0egYTr5ShlYzFc5fPufNhKrQdIPFsVyuFZm+VJjZew=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmz0ZKdobnw0+XoDweO1CjN0nuSx++Yf1PY2OQg
 baAjzayEcKJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZs9GSgAKCRBVnxHm/pHO
 9VTKB/wNH+RvTSPDjfbPGoOWUBQ3OiHjHbKsVCVsP+PwaVRLhK//KyHolZHQYKNPzZehtYA6W46
 yGW8+q77Z882zzVDsEGcjBrfe7fpfXEzzRjRkxU+vW9j/ysuALG81/t+UHgrMXHjHU2SvNx3oKy
 OLCyJIJdgbuBMZxv4jULvC4jq60DXDv9S3dTUqIFvWlFMu75Ez7foF5bs87VhCAD58GNlt53peO
 ev269wGqF/QuEvKqpm49S3c3NwM7vn34dMHfxsS9awBEHfZy54bBrKeEwuvKvfLYbOBNYCPQx0T
 KuXpGgYpU3J84Z89FQVInpFpFWCJyzjK1JXBvVYhn2Jbsq15
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

Hi,

This series adds support to enumerate the PCIe endpoint devices using the Qcom
specific 'Link up' event in 'global' IRQ. Historically, Qcom PCIe RC controllers
lacked standard hotplug support. So when an endpoint is attached to the SoC,
users have to rescan the bus manually to enumerate the device. But this can be
avoided by rescanning the bus upon receiving 'Link up' event.

Qcom PCIe RC controllers are capable of generating the 'global' SPI interrupt
to the host CPUs. The device driver can use this interrupt to identify events
such as PCIe link specific events, safety events etc...

One such event is the PCIe Link up event generated when an endpoint is detected
on the bus and the Link is 'up'. This event can be used to enumerate the
endpoint devices.

So add support for capturing the PCIe Link up event using the 'global' interrupt
in the driver. Once the Link up event is received, the bus underneath the host
bridge is scanned to enumerate PCIe endpoint devices.

This series also has some cleanups to the Qcom PCIe EP controller driver for
interrupt handling.

NOTE: During v2 review, there was a discussion about removing the devices when
'Link Down' event is received. But this needs some more investigation, so I'm
planning to add it later.

Testing
=======

This series is tested on Qcom SM8450 based development board that has 2 SoCs
connected over PCIe.

Merging Strategy
================

I'm expecting the binding and PCI driver changes to go through PCI tree and DTS
patches through Qcom tree.

- Mani

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v4:
- Fixed the indendation issue reported by Kbot
- Merged the bindings patch adding global IRQ into one as suggested by Rob
- Collected review tag
- Link to v3: https://lore.kernel.org/r/20240731-pci-qcom-hotplug-v3-0-a1426afdee3b@linaro.org

Changes in v3:
- Removed the usage of 'simulating hotplug' and just used 'Link up' as we are
  not fully emulating the hotplug support
- Fixed the build issue wtih CONFIG_PCI_DOMAINS_GENERIC
- Moved the 'global' IRQ entry to last in the binding and also mentioned the ABI
  break and its necessity in patch description.
- Collected tags
- Rebased on top of v6.11-rc1
- Link to v2: https://lore.kernel.org/r/20240717-pci-qcom-hotplug-v2-0-71d304b817f8@linaro.org

Changes in v2:
- Added CONFIG_PCI_DOMAINS_GENERIC guard for domain_nr
- Switched to dev_WARN_ONCE() for unhandled interrupts
- Squashed the 'linux,pci-domain' bindings patches into one
- Link to v1: https://lore.kernel.org/r/20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org

---
Manivannan Sadhasivam (12):
      PCI: qcom-ep: Drop the redundant masking of global IRQ events
      PCI: qcom-ep: Reword the error message for receiving unknown global IRQ event
      dt-bindings: PCI: pci-ep: Update Maintainers
      dt-bindings: PCI: pci-ep: Document 'linux,pci-domain' property
      PCI: endpoint: Assign PCI domain number for endpoint controllers
      PCI: qcom-ep: Modify 'global_irq' and 'perst_irq' IRQ device names
      ARM: dts: qcom: sdx55: Add 'linux,pci-domain' to PCIe EP controller node
      ARM: dts: qcom: sdx65: Add 'linux,pci-domain' to PCIe EP controller node
      arm64: dts: qcom: sa8775p: Add 'linux,pci-domain' to PCIe EP controller nodes
      dt-bindings: PCI: qcom,pcie-sm8450: Add 'global' interrupt
      PCI: qcom: Enumerate endpoints based on Link up event in 'global_irq' interrupt
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
 drivers/pci/endpoint/pci-epc-core.c                | 14 ++++++
 include/linux/pci-epc.h                            |  2 +
 12 files changed, 120 insertions(+), 17 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240715-pci-qcom-hotplug-bcde1c13d91f

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>



