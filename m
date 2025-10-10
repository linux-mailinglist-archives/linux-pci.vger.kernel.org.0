Return-Path: <linux-pci+bounces-37825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85097BCE3B2
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 20:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45CBE401099
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 18:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC592FD1D7;
	Fri, 10 Oct 2025 18:26:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F39B2FD1C3;
	Fri, 10 Oct 2025 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760120768; cv=none; b=UTQGTY0FUn7uWa1ElkAkeJqX1F5ol07kRjLi7vK6Q/nL2Uxp07hG1FStdYGFRFaz3trlEQ6HRFirgcC09WbUDvfIktKsZqalmxTsgIlVo5L8Y2UrGoD1PBr8f8LR3PPS2YXSw2bmYrECMCUiS5ZqvtUvJGIOFoJ5xZWPwxxZITQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760120768; c=relaxed/simple;
	bh=/aRq5DE/FVItXdRivR/J1AsysvS55h/HwYPYIpjLtxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GiKAiN5h6lMTfI2o3DNdLtAVjEcesYwhGZLU7K0vuTsfneQoV5j/VhB9GC3uYt102m5TLbcE93LaiAZfKZloWVIlSx99iURtHu2908FUlAkeIcs1Jsmi48nfseYzC4Dy0YE/SydBEMdU/L60UGUqqGLnDdJMT5J9WRFc86CZpnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8779CC19422;
	Fri, 10 Oct 2025 18:26:07 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Fri, 10 Oct 2025 11:25:48 -0700
Subject: [PATCH 2/3] dt-bindings: PCI: qcom: Enforce check for PHY, PERST#
 and WAKE# properties
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-pci-binding-v1-2-947c004b5699@oss.qualcomm.com>
References: <20251010-pci-binding-v1-0-947c004b5699@oss.qualcomm.com>
In-Reply-To: <20251010-pci-binding-v1-0-947c004b5699@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2265;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=/aRq5DE/FVItXdRivR/J1AsysvS55h/HwYPYIpjLtxs=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBo6U+9VbUO2gwKKLYys5f6gRb/B/W8XsL1AY9mZ
 mlkguOiKJWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaOlPvQAKCRBVnxHm/pHO
 9QeDB/9UqREHY0Jsj6N7L6hrQU4zbgouIU1ekold6aVoNYkTJY3Nans8es//ZD/zT3/xOPIP9wq
 qE3XPQBeEl7T1Jh//yZV5rSuDU3cBJpctenuiaqHMGwnRTWzODAFkfJmC9WacbnrNneb9OZYyIc
 hZdGXD4eHd/3FZ016iy3d7AlXs+h7QoCBd1YOT2GPoBbGr9sUd4AZjt8WEdLEuVBTTzBSCsYBln
 wH0BxC98L3pduVs2QJHej1rEx3gBUzEwcgUl+0Td6kQjv7Uk8hIWSmMjhWgtA4exDqs7Zx0FLbz
 xt9HkrPO2y2tB1cdIkAVHn0MN1Nd+H2Dah4OhSVf5Cz2/C98
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Currently, the binding supports specifying the PHY, PERST#, WAKE#
properties in two ways:

1. Controller node (deprecated)
	- phys
	- perst-gpios
	- wake-gpios

2. Root Port node
	- phys
	- reset-gpios
	- wake-gpios

But there is no check to make sure that the both variants are not mixed.
For instance, if the Controller node specifies 'phys', 'reset-gpios',
'wake-gpios' or if the Root Port node specifies 'phys', 'perst-gpios',
'wake-gpios', then the driver will fail as reported. Hence, enforce the
check in the binding to catch these issues.

It is also possible that DTs could have 'phys' property in Controller node
and 'reset-gpios/wake-gpios' properties in the Root Port node. It will also
be a problem, but it is not possible to catch these cross-node issues in
the binding.

Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Closes: https://lore.kernel.org/linux-pci/8f2e0631-6c59-4298-b36e-060708970ced@oss.qualcomm.com
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 .../devicetree/bindings/pci/qcom,pcie-common.yaml    | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
index 77f8faf54737e0fab089a368976290dece4f2e7d..6eaecf83d6efd37e9acb044049c1ef95611cbf58 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
@@ -111,6 +111,16 @@ patternProperties:
       phys:
         maxItems: 1
 
+    oneOf:
+      - required:
+          - phys
+          - reset-gpios
+          - wake-gpios
+      - properties:
+          phys: false
+          reset-gpios: false
+          wake-gpios: false
+
     unevaluatedProperties: false
 
 required:
@@ -129,6 +139,16 @@ anyOf:
   - required:
       - msi-map
 
+oneOf:
+  - required:
+      - phys
+      - perst-gpios
+      - wake-gpios
+  - properties:
+      phys: false
+      perst-gpios: false
+      wake-gpios: false
+
 allOf:
   - $ref: /schemas/pci/pci-host-bridge.yaml#
 

-- 
2.48.1


