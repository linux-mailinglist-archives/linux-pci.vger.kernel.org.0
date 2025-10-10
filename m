Return-Path: <linux-pci+bounces-37823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8881FBCE3A0
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 20:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381FF3A2861
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 18:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1718B22B8D0;
	Fri, 10 Oct 2025 18:26:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54C921CC61;
	Fri, 10 Oct 2025 18:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760120767; cv=none; b=u2/sEJf//JcTLOllqrjiSv4GKgWqRBPX5DxgwVXoYazR8kk7IpBLCaRlEWWopOxW19RyYvNIVuxu9H3cM0Q7A/fA48fVRK2y6hEjiFEepyjlS0QCx/KD5B9cB8j22BYz3mBeGPuIu+MoS8J47sAmInVFNmzq1yG4pkwk1Xk1JTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760120767; c=relaxed/simple;
	bh=ixSOoPYH/Gln/Gf7PAc0fPBrxkLobai38fL0ouuD1zM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HfBu9HjMx9qdq4FHrcLo+kXv0+CSdwCHM7FQX3302cGESX02hdjwmiWLVEzTyrUBrandLCuBwQtmefyQUlv8ey7E9Yz5HwhpY/URNJ6tngxJMnpsvOz6hFEKUtmiX2/lrm4Gz7nB2M7eGOc1F0rik4pa84+8dShkFVA4oqjp+c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3731C4CEF1;
	Fri, 10 Oct 2025 18:26:05 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 0/3] PCI: qcom: Binding fix
Date: Fri, 10 Oct 2025 11:25:46 -0700
Message-Id: <20251010-pci-binding-v1-0-947c004b5699@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKpP6WgC/x3MQQqAIBBA0avIrBNUKrGrRItyJpuNiUIE4t2Tl
 m/xf4VCmanAIipkerjwHTv0IMBfewwkGbvBKDNppZVMnuXBETkGaXFEa53zMyH0ImU6+f1v69b
 aB02Ql+ldAAAA
X-Change-ID: 20251010-pci-binding-7d4d7799c6ed
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3418;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=ixSOoPYH/Gln/Gf7PAc0fPBrxkLobai38fL0ouuD1zM=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBo6U+90gJMrOAGykRWs8VOXm3YJHroOzGp0SD2C
 IxoL1LdoEGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaOlPvQAKCRBVnxHm/pHO
 9aHYB/9ydgMOP29RkwOrxZToi/GKym/q6J2VVSdiILcZ1zoLRaWCl/f2aP5Qc+Yt7Ok1duGJNfi
 f98qU9NH5iPNtC2rFYAHbt7aNFWhblpNEQaud9hexUcTunrT3U5i90QDIWGEk4UfA9uzuR4uaYb
 lo4f4c+bZpUr9b3ocAPoFCnj0w6MRxi/5oQkednx3QVau8h8iwac00ElAA91bRyoXMEf6bmB5gK
 F4YEaYzDO6PvzTj+3G+bQ9fweEFkQJ30oIeKL73wOIFwuibNJrsj9MolMtpdFHvqd2vDYBacAfS
 Wrg1C2A6OBg9+JIvYxBaXBd+haMGL0PmdWKEHs/gpuXcAhlA
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Hi,

This series fixes the binding issue around the PERST# and PHY properties.
The binding issue was reported in [1], while discussing a DTS fix [2].

The binding fix provided in this series is not sufficient enough to spot all the
shenanigans, especially keeping one property in Controller node and another in
Root Port node. But this series does catch the DTS issue fixed by [2]:

arch/arm64/boot/dts/qcom/sm8750-mtp.dtb: pcie@1c00000 (qcom,pcie-sm8750): 'oneOf' conditional failed, one must be fixed:
	'phys' is a required property
	False schema does not allow [[148, 102, 1]]
	False schema does not allow [[148, 104, 0]]
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sm8550.yaml#
arch/arm64/boot/dts/qcom/sm8750-mtp.dtb: pcie@1c00000 (qcom,pcie-sm8750): pcie@0: 'oneOf' conditional failed, one must be fixed:
	'reset-gpios' is a required property
	'wake-gpios' is a required property
	False schema does not allow [[34]]
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sm8550.yaml#
arch/arm64/boot/dts/qcom/sm8750-mtp.dtb: pcie@1c00000 (qcom,pcie-sm8750): Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'dma-coherent', 'interconnect-names', 'interconnects', 'interrupt-map', 'interrupt-map-mask', 'iommu-map', 'linux,pci-domain', 'msi-map', 'msi-map-mask', 'num-lanes', 'operating-points-v2', 'opp-table', 'pcie@0', 'perst-gpios', 'power-domains', 'ranges', 'wake-gpios' were unexpected)
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sm8550.yaml#

Thanks to Dmitry for suggesting the binding fix!

[1] https://lore.kernel.org/linux-pci/8f2e0631-6c59-4298-b36e-060708970ced@oss.qualcomm.com
[2] https://lore.kernel.org/all/20251008-sm8750-v1-1-daeadfcae980@oss.qualcomm.com

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Manivannan Sadhasivam (3):
      dt-bindings: PCI: Update the email address for Manivannan Sadhasivam
      dt-bindings: PCI: qcom: Enforce check for PHY, PERST# and WAKE# properties
      PCI: qcom: Treat PHY and PERST# as optional for the new binding

 Documentation/devicetree/bindings/pci/pci-ep.yaml  |  2 +-
 .../devicetree/bindings/pci/qcom,pcie-common.yaml  | 22 +++++++++++++++++++++-
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      |  2 +-
 .../devicetree/bindings/pci/qcom,pcie-sa8255p.yaml |  2 +-
 .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml |  2 +-
 .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml  |  2 +-
 .../devicetree/bindings/pci/qcom,pcie-sc8180x.yaml |  2 +-
 .../bindings/pci/qcom,pcie-sc8280xp.yaml           |  2 +-
 .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml  |  2 +-
 .../devicetree/bindings/pci/qcom,pcie-sm8250.yaml  |  2 +-
 .../devicetree/bindings/pci/qcom,pcie-sm8350.yaml  |  2 +-
 .../devicetree/bindings/pci/qcom,pcie-sm8450.yaml  |  2 +-
 .../devicetree/bindings/pci/qcom,pcie-sm8550.yaml  |  2 +-
 .../bindings/pci/qcom,pcie-x1e80100.yaml           |  2 +-
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  2 +-
 drivers/pci/controller/dwc/pcie-qcom.c             | 11 +++++++++--
 16 files changed, 44 insertions(+), 17 deletions(-)
---
base-commit: 5472d60c129f75282d94ae5ad072ee6dfb7c7246
change-id: 20251010-pci-binding-7d4d7799c6ed

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


