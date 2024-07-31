Return-Path: <linux-pci+bounces-11045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 910C1942C76
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 12:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B330283F10
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 10:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5071AE87E;
	Wed, 31 Jul 2024 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+5qO3sb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A7A1AD9C7;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423019; cv=none; b=VMtO29+f5WoAuydq0GHGOaIhj5lgT6N7IJ8SOLkHMyPZBcxUb3mKe2PBzrRPvxNB3UdBdSHxIF4NMsEYAfL0dBexPCyBxsoqdpKtsFyZRiXuSUNwQX8tw2o8vV/6b16wcwJOGND9b9hNPee9jeT5Krgdb/G7KW0UNLDHXK0dYag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423019; c=relaxed/simple;
	bh=gpFkVvbXM7bCqPYW+aDVZ3Ody8SHFkjq1FkAoOcZ9yQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BbrM6Nf8UJdqaxqPnsEX718DnjyFxMmQ6OH5wRlAT2eaVu+cZ8sSaoYAjeY11C2QPmjz0g7FUtgRrHXdi1zgCPldZhb5iz0pRFY6LjZpD2+b/+k4xHVA2HbuYUPCplkb2y82hGtCjh5QTMu0N+jIzty9l45nX39QR3+fELRDmk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+5qO3sb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8AFAC4AF10;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722423018;
	bh=gpFkVvbXM7bCqPYW+aDVZ3Ody8SHFkjq1FkAoOcZ9yQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=P+5qO3sb79fLAyF9fvmvcKTmA4B6eYk+6h7wUyLOghCGPZ8xOhU6O6z+cAzde5urP
	 1fTEMlKet00g7wQa1IKwB0gC3jPrTlLdkDAfAg7Z/O1xhNGEX7Qn+2yKSYr9yzpqyp
	 rq6fCxukuOcJ9vNMNzJ0f9M0xaDGt7Bmx4doFwFeiQAPz/de5jZ40vjL2F47h7fZQo
	 1Hj35w/YhebBrHJLB72l96oU/GOTgNsp6Ua37ee+8RmpVp38VJa5BSGOFliwXQ9fAh
	 yx5CFRAJPo8Y9QQX+Aur57XYJy5la/6VnFu4+p6Hf3fUvTKWQkHDHtIePqt1wD6cKi
	 OliPpdwCunzTA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC74C3DA64;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 31 Jul 2024 16:20:13 +0530
Subject: [PATCH v3 10/13] dt-bindings: PCI: qcom: Add 'global' interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-pci-qcom-hotplug-v3-10-a1426afdee3b@linaro.org>
References: <20240731-pci-qcom-hotplug-v3-0-a1426afdee3b@linaro.org>
In-Reply-To: <20240731-pci-qcom-hotplug-v3-0-a1426afdee3b@linaro.org>
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
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=UnqChimHBG0jtzlN6KxFR0yebxEqg1erfRRq9qEP0p0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmqhbkB/cWBxZAuW9kvnCZmyNplxRrctsF4Cguu
 0gi2zs5h9mJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZqoW5AAKCRBVnxHm/pHO
 9V6YCACMPaLpig/X0T0VKYUbdat2nq1pdJKlbyHurTfL4nDpP54WIHkmka0L/wiJ52wjEtze+2q
 pcRhyrMPNtZbc8D6/fW7rF12kfYbPwD4oosxWbXYEfO3h/ffv7FYf1wHY7JAG2PRYXXWpkDWzlI
 DoKRA+xjS9KOfUEis3kCTQ7Kt2L/yq9n4rhSq9njHL+FvcYOiOvZEPWwXVCfwgo9/tOSFGp88Db
 GuI5usUM3Eh1R9RQ/AdZ8ssCEwjLXrp0YzsYLhBA6rPWwxjcPmeUubKnKDf7YyLhWtS+6HilwIH
 ptrgYF4ULjjhUHpJs52fUqawGxmJUecGq4pW5xGsPgiJem68
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
to the host CPU. This interrupt can be used by the device driver to
identify events such as PCIe link specific events, safety events, etc...

Hence, document it in the binding along with the existing MSI interrupts.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
index 0a39bbfcb28b..704c0f58eea5 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
@@ -21,11 +21,11 @@ properties:
 
   interrupts:
     minItems: 1
-    maxItems: 8
+    maxItems: 9
 
   interrupt-names:
     minItems: 1
-    maxItems: 8
+    maxItems: 9
 
   iommu-map:
     minItems: 1

-- 
2.25.1



