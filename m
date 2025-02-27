Return-Path: <linux-pci+bounces-22544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC39A47FAA
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC211641F3
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56B523027C;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaTLX2GX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBBA22FE05;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663654; cv=none; b=DodtGEgpHrwQnBJiovyRy1CWhxI8eXeTpT9DLP0amK1pUdQLNTAcVpIMb8R0stxGFp5VlFY9n1wspE2WB/gGeVKSFu43AkVZZindJVUT2AkpqjL7iOpYAgt9798nq6WxzBqLQvz0uqFZBwFQKLBqm4k4MOoTN30/f0Wc23eQU8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663654; c=relaxed/simple;
	bh=EDBrFEqGXCmp/lR9TA9ZDa3602RxAjfTzKEBgxyXAXg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oGIIh8DCEVXW2yS417QwtV8ZXWbUaR827vJpunCES9hBF/qVV2wU7t9kYAby7+eNOsHkrSVrGXwwhKikmP32wM5wL7uLAsKzIYQAGW0MsHsWwQZav5rH5yNKV0fq/xNn966rdjXUa9Cmxfk84N7QPLqCFTEkq0YdHdJpiJ+5pbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaTLX2GX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0021EC4CEE6;
	Thu, 27 Feb 2025 13:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663654;
	bh=EDBrFEqGXCmp/lR9TA9ZDa3602RxAjfTzKEBgxyXAXg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=MaTLX2GXYb9RSpelgkCu8mwzB7svaadG7W5aWyaDKQf7yCUO+XiQencqcL8Gyhcom
	 VZCA9OXXJOSZYIbOKcBstBeHvgvJCo6H+N8TXaGyw5wjvB26MOSi1a/OfAZd1w67WK
	 /cnqls4TgsVpaB/kzGFAStzgktftNjtTge+xKNeS7OmxJ+K5yjnHRSlHlfPkbebHbd
	 0eQVbgnaTxmTjraa5JD61vb/Vq6up4JvC8M6nQz6CgwY0tEBJlb27m4AQmYwGfs9K9
	 2nfTHD6abT1neDlca20GwgIpEWB111BqZAV9xcSjQA5/a3RTubLuIR7b0Yya7dolrv
	 hcm/D1K4xov6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0386C021BE;
	Thu, 27 Feb 2025 13:40:53 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Subject: [PATCH 00/23] arm64: dts: qcom: Add 'global' IRQ to supported SoCs
Date: Thu, 27 Feb 2025 19:10:42 +0530
Message-Id: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFtrwGcC/x3MQQqAIBBA0avIrBtIwZKuEi3KmWwgyhQikO6et
 HyL/wtkTsIZBlUg8S1ZzqNCNwr8Nh+BUagaTGtsa0yP0Qtj2M9l3lHShUTak+2co15DrWLiVZ7
 /OE7v+wGN/SjbYQAAAA==
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4126;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=EDBrFEqGXCmp/lR9TA9ZDa3602RxAjfTzKEBgxyXAXg=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnwGtdjTGtJxMtF4CD++uH0HTDRyZM+vVszZyrQ
 XcJH0Cxgg2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ8BrXQAKCRBVnxHm/pHO
 9U5tB/9ud8/6+REWjHULCz/4oZ98TOULWIK4kUQj4wPAnsEWpbn2BF2ijppNUBNC7a44lH9zFGx
 aXwz0D20UwaTap+9BQ4MjJvm4yQMiOK3Rb3XcMJ0nW8jwREvjH5F7ov7bCa8DqQKRklQ1jZxS1/
 yKjiHtsZpHT0Ugq/QgKuHSPfupABu8ppYnTMJgfv1m+htJVn/CPEuoYH8Kt3g2WPnABCgZEJgWW
 6Uh59rlqEKyL6onWuO/dP2MHyXvay2b6xDjb9VDqROK5zHSKonDqfx3VwNziRP001szp55MzOqf
 gdOCqy7le0WmuyrEIBCXcz8T1tYXv3jCX6NQ50o48DKZ0+1h
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

Hi,

This series adds the Qualcomm specific 'global' IRQ to the supported SoCs.
This IRQ is used to receive the PCIe controller and link specific events
such as Link Up/Down, MSI, PTM etc... in the driver. Support for this IRQ
was already added to the pcie-qcom driver. So enabling this IRQ would allow
the driver to enumerate the endpoint device and also retrain the link when
the device is removed [1] without user intervention.

This series also adds missing MSI SPI IRQ to some of the SoCs.

Testing
=======

This series was tested on Qualcomm RB5 board based on SM8250 SoC and
Qualcomm Ride MX board based on SA8775p SoC.

NOTE
====

I've left a few SoCs in the tree like QCS404, SC8280XP due to lack of
documentation. Those will be added later.

[1] https://lore.kernel.org/linux-pci/20250221172309.120009-1-manivannan.sadhasivam@linaro.org/

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Manivannan Sadhasivam (23):
      dt-bindings: PCI: qcom,pcie-sm8150: Add 'global' interrupt
      arm64: dts: qcom: sm8150: Add 'global' PCIe interrupt
      dt-bindings: PCI: qcom,pcie-sm8250: Add 'global' interrupt
      arm64: dts: qcom: sm8250: Add 'global' PCIe interrupt
      dt-bindings: PCI: qcom,pcie-sm8350: Add 'global' interrupt
      arm64: dts: qcom: sm8350: Add 'global' PCIe interrupt
      dt-bindings: PCI: qcom,pcie-sa8775p: Add 'global' interrupt
      arm64: dts: qcom: sa8775p: Add 'global' PCIe interrupt
      dt-bindings: PCI: qcom,pcie-sc7280: Add 'global' interrupt
      arm64: dts: qcom: sc7280: Add 'global' PCIe interrupt
      dt-bindings: PCI: qcom: Add 'global' interrupt for SDM845 SoC
      arm64: dts: qcom: sdm845: Add missing MSI and 'global' IRQs
      arm64: dts: qcom: msm8996: Add missing MSI SPI interrupts
      dt-bindings: PCI: qcom: Allow MSM8998 to use 8 MSI and one 'global' interrupt
      arm64: dts: qcom: msm8998: Add missing MSI and 'global' IRQs
      dt-bindings: PCI: qcom: Allow IPQ8074 to use 8 MSI and one 'global' interrupt
      arm64: dts: qcom: ipq8074: Add missing MSI and 'global' IRQs
      dt-bindings: PCI: qcom: Allow IPQ6018 to use 8 MSI and one 'global' interrupt
      arm64: dts: qcom: ipq6018: Add missing MSI and 'global' IRQs
      dt-bindings: PCI: qcom,pcie-sc8180x: Add 'global' interrupt
      arm64: dts: qcom: sc8180x: Add 'global' PCIe interrupt
      arm64: dts: qcom: sar2130p: Add 'global' PCIe interrupt
      arm64: dts: qcom: x1e80100: Add missing 'global' PCIe interrupt

 .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml | 10 ++--
 .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml  |  9 ++--
 .../devicetree/bindings/pci/qcom,pcie-sc8180x.yaml | 10 ++--
 .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml  |  9 ++--
 .../devicetree/bindings/pci/qcom,pcie-sm8250.yaml  |  9 ++--
 .../devicetree/bindings/pci/qcom,pcie-sm8350.yaml  |  9 ++--
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 14 ++++--
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              | 20 +++++++-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              | 40 ++++++++++++++--
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 54 +++++++++++++++++++---
 arch/arm64/boot/dts/qcom/msm8998.dtsi              | 20 +++++++-
 arch/arm64/boot/dts/qcom/sa8775p.dtsi              | 28 ++++++++---
 arch/arm64/boot/dts/qcom/sar2130p.dtsi             | 12 +++--
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 14 ++++--
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              | 24 ++++++----
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 40 ++++++++++++++--
 arch/arm64/boot/dts/qcom/sm8150.dtsi               | 12 +++--
 arch/arm64/boot/dts/qcom/sm8250.dtsi               | 18 +++++---
 arch/arm64/boot/dts/qcom/sm8350.dtsi               | 12 +++--
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 18 +++++---
 20 files changed, 300 insertions(+), 82 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250227-pcie-global-irq-dd1cd5688d71

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>



