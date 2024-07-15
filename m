Return-Path: <linux-pci+bounces-10277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D3C93196B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 19:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC8C1C21D5A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 17:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEECE5C8FA;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9DPsXIy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD5555888;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064829; cv=none; b=bCC9qwR1iiViVYScR8dEvoaEVstxoiLa5L/nbGQO++kUsm2BNJnlLOQ1MEaBDOQlsKaD3oYyIfhtxDkP4UuMoBj6ZpjO4+0XbMoOt0g9qpUIOu6lNg8Y5+OSYeGp1GmnOD2d6do/+kiIPmeHdS/T20mgDXZbHP2FMpoeaCSJ5Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064829; c=relaxed/simple;
	bh=XTJGJcJtJ9q3xS6FcYJEn2b9I/JOzQleE68JYB3eyNE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G5SJW5yfdoqWqcCcu4v5yqgZOwxXg9RKxfvDZclFoae7oBk9WEx1mGc84BBE8HH63fY07oy2uJz7r6PDHCtsJXp/MMU+9yYgbir9kjSkYelhRmzOl56jpc1tJVNH0VnhvVaUuCdu+QyOFnrtp71C3VFWtlySrVq6rWDBzg69aik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9DPsXIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EE7BC4AF0D;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064829;
	bh=XTJGJcJtJ9q3xS6FcYJEn2b9I/JOzQleE68JYB3eyNE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=J9DPsXIy5BBa13+5FNZQN803YmdphMmZ4OSEZF1jP8M+aRLLPPUhaKZaE9fAXr15h
	 CBZYuvoJLUSaQ8sPLIcRIzMB7oQAnNObxXWndTP19WMLupmlYku4FClone0KO+paxQ
	 njRvwHj9Rz3TN/fQ/GL/4SzSkmtnlbGOJs3YHqtSTPhmlCwuJRcvqrV6oYaB653Pns
	 G6x/Xnj9ztVE/zt2/R/Q3UNJRU8dzRAcG4unPol3Ah/hXjjvy+EGbtN/L0KImkDDia
	 czmbKyFw05xPyjLEALJydX2ge1r+IRGSoaue7fc6/4n45mPAdOW0FPPUTrfWR2LvOG
	 E9aRjIhewuqNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F015C3DA4B;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Subject: [PATCH 00/14] PCI: qcom: Simulate PCIe hotplug using 'global'
 interrupt
Date: Mon, 15 Jul 2024 23:03:42 +0530
Message-Id: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHZdlWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0NT3YLkTN3C5Pxc3Yz8koKc0nTdpOSUVMNkQ+MUS8M0JaC2gqLUtMw
 KsJHRsbW1AGKo7+JiAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3353;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=XTJGJcJtJ9q3xS6FcYJEn2b9I/JOzQleE68JYB3eyNE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmlV13maAX8I4o+y3OFuBOPbkCeBTBFrFWJcdmH
 pCZf5cw49uJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpVddwAKCRBVnxHm/pHO
 9VBBB/9VPNho4Ta793DhxS1UooDi6ZUjbse7lJmJRXYOwNijJgHBEsmuQcIueZCya4U//MTX7T4
 5k61CKGFDsqrasalpiIpBHR5BtwBJwFAbGnaWPtgmQbKTjCs99gxvrY50/61PqzpbSmHAjPcorh
 Y0PRyyq2YvavoV9eB2jFUAnUEoBhrfp4KAVud019B0myLYyt3ual7lzxk203gI/6kemiJ89lbTp
 6haTOpwL4irKh+dfz1AGWPBaEykSZtUmEwFF1jr2q170IBBsjQyq8qb42B8BaKmcWGpJEwKkaNU
 INjP4BnirSOH+i0gxScZcoaiecnRSPdQ9lnoY0NI+k0C9d6J
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
Manivannan Sadhasivam (14):
      PCI: qcom-ep: Drop the redundant masking of global IRQ events
      PCI: qcom-ep: Reword the error message for receiving unknown global IRQ event
      dt-bindings: PCI: pci-ep: Update Maintainers
      dt-bindings: PCI: pci-ep: Document 'linux,pci-domain' property
      dt-bindings: PCI: qcom-ep: Document "linux,pci-domain" property
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
 drivers/pci/controller/dwc/pcie-qcom.c             | 55 ++++++++++++++++++++++
 drivers/pci/endpoint/pci-epc-core.c                |  1 +
 include/linux/pci-epc.h                            |  2 +
 12 files changed, 108 insertions(+), 16 deletions(-)
---
base-commit: 91e3b24eb7d297d9d99030800ed96944b8652eaf
change-id: 20240715-pci-qcom-hotplug-bcde1c13d91f

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>



