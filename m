Return-Path: <linux-pci+bounces-12362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C34FC962CD4
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 17:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DBF21F22B41
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 15:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5530E1A4F3F;
	Wed, 28 Aug 2024 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlVSkDRK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97CB1A3BCE;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859985; cv=none; b=DIVlg5eGEr2lMnhhvbAhEylavIYutngUOKbXJ0F+po8jgzCifXNYDdoYOmfOHCibZlUdrwgTWk6M2uy3HZ+SoAWcppWtt/343Fwwm68U+5uEDAk9aJfUf/DzT2FzrdSJz/k+5jgn/95onRoOxcCiTqgd3AXNvy1A/d8yzdZ2nVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859985; c=relaxed/simple;
	bh=22QF55zGLP92w1/Z+PYK8XSQwdKiIg4NOzO1VfG3i/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rPuyKa1YLFdhE3aNsHPav21xAn/IgxHRAnMu6jV73F2b1pBwkryTmr+Itx7LOn7kvmx8Cldo5jtg3hvD/Q9hYkPihqxCZlXFqw0gGSB/BPW5BoA/cYhFsDcWZ5pBU2f/SGmqonaVA2cdTN3j6HZoA9AXuVG5ePSMoFNOgWXVXQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlVSkDRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FB10C4CEE7;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724859984;
	bh=22QF55zGLP92w1/Z+PYK8XSQwdKiIg4NOzO1VfG3i/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jlVSkDRKG8Xj/imBiYdjZgS/oBPL2CJv2dHvjiIEVsdmRPCGjEMxkJmvZZvgOsOX8
	 SZHaqew6FlG3qx9Zu/yFnzkkBYm5/AbTcL3C8gebZzLDkoMMQyZ1yK+fzmzldBEnKn
	 23LQdai04sWZHRqSb7hAjins3keTFf9BEWnb+tzSBLDXaqoLfVqISzR+1U5m8KHfsN
	 VZoP2eChTPsyBnIfcNmvHAnCl7G+7sYdDCFKb8z48okYiSnhZIJSDL4SqpstrQ7wJJ
	 McxGF88EBV+X3mcj0A/EnvmDN1kgKQ3xQ6CegI5hs91+4ajt6gKnf5l7R4fgZsuFVD
	 fX56iiUsyvolw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964C0C61CF0;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 28 Aug 2024 21:16:17 +0530
Subject: [PATCH v4 07/12] ARM: dts: qcom: sdx55: Add 'linux,pci-domain' to
 PCIe EP controller node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-pci-qcom-hotplug-v4-7-263a385fbbcb@linaro.org>
References: <20240828-pci-qcom-hotplug-v4-0-263a385fbbcb@linaro.org>
In-Reply-To: <20240828-pci-qcom-hotplug-v4-0-263a385fbbcb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=986;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=+Lb2vcF7RPFdOyct+N0+V3AMTmLDYS+SRQY7Fw3HIuE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmz0ZM83Z35engVsqec9Qy5XqLnwNrE3yue0oFr
 R5aI0n2kJ2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZs9GTAAKCRBVnxHm/pHO
 9ZQpB/4urQR2QZAmwGp5/dqgmYbmQpFMcVLNKBSE5clsO6sHL7t11dfZG4AGzvrMULZXnV6717K
 qs9cNsufZRyYLTxFB55wWkQtv71t9YRVEPxcF+LvPaA1v7yDqzcxKTouj5ns2A4/3J1ZQNS7TVG
 ApV1piB+JCX4nHLpRMBohk9FLJuxiYcxYMFmxeb44g/6McxFxxPMDCjVIq7SHf9hz54oTDvNfzi
 bjQ2DChgd3UxwTO65qM9FoS5LRvtQDVGIxhy94lHrq8QdizvRwFdxh0kSTD5KGr2d5wfVBVzqwi
 ZxV6yzDbVtJ7SFIJEgXiLKwVgmH3C0OlqVcez+LACnod1wl9
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

'linux,pci-domain' property provides the PCI domain number for the PCI
endpoint controllers in a SoC. If this property is not present, then an
unstable (across boots) unique number will be assigned.

Use this property to specify the domain number based on the actual hardware
instance of the PCI endpoint controllers in SDX55 SoC.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index 68fa5859d263..d0f6120b665d 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -437,6 +437,7 @@ pcie_ep: pcie-ep@1c00000 {
 			phy-names = "pciephy";
 			max-link-speed = <3>;
 			num-lanes = <2>;
+			linux,pci-domain = <0>;
 
 			status = "disabled";
 		};

-- 
2.25.1



