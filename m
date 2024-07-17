Return-Path: <linux-pci+bounces-10443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E737F9340F6
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 19:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239141C23151
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 17:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9580418306B;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4WLFn4k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCB1182A40;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235795; cv=none; b=RmILnBnkRThLpk/MyQeWwRtPAt5Ed50+KNQwTc6+gWnLvwI+pGZCMlKli3j+mNLpqQfjYpbUwLG2zD0mnwu/KUet4vyJ8BqQeknVCCzec4dIYVs6bt9aQ6v3Hh1kcVSX/EBp980hnOvMJp3Q8Vu/ECsINcjhnJx0jMiiz1pYPDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235795; c=relaxed/simple;
	bh=8znAZBcirLJ8Efx48e0wAJqyTm86Mv7/PWdHuyyfnFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nMDTltQ8Osk20IYNK/BXk95GGOcsfdiybFRkRr7i933igH7641TBpbu0tj7owcdvIa1GE69PDOOu02KQnj0gcMYkhSWCBNgcyecQTFW2pvJw2G2UVvcKrHqjH9jAIEUw59TieuBh4vc50TjmpuR9V5J3jDksc2+oyavJe4T6AG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4WLFn4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2D5FC4AF15;
	Wed, 17 Jul 2024 17:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721235795;
	bh=8znAZBcirLJ8Efx48e0wAJqyTm86Mv7/PWdHuyyfnFY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=l4WLFn4k4kL7R+8+NA2DXQC3rmJonpCPAJhL46vDYEuuAA8BFFnNBupupAPPp+Ko3
	 Ywh6fF0gk5otvfS+4JNfPuo0q0pLh3dlkE9pLZkhw8pdwUioIhJH7c8dOYsVUQgyD5
	 KkOt9z+FHmjRe+zj5tRjFk2dC7qBd2D3Ywhw6I5A2mG95k0zBPjcJbSrP/Yj2SD3Z8
	 Fdnte0yl2lWIDzGSqgkiqBor8IwFnT1unLETVw8JlZfk5xnSl4VhquW5IuqvK3Ctw7
	 cGa39VKd/R6UBJBAbPCJv6XdvHKW9lltpIESfFErQM8IkGAR+Y4fa8yoKYMc9Sxwqc
	 vFJ+f+edj1Dfg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9070C3DA60;
	Wed, 17 Jul 2024 17:03:14 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 17 Jul 2024 22:33:09 +0530
Subject: [PATCH v2 04/13] dt-bindings: PCI: pci-ep: Document
 'linux,pci-domain' property
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-pci-qcom-hotplug-v2-4-71d304b817f8@linaro.org>
References: <20240717-pci-qcom-hotplug-v2-0-71d304b817f8@linaro.org>
In-Reply-To: <20240717-pci-qcom-hotplug-v2-0-71d304b817f8@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2026;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=ZuN+bx8IKdLBF21t1VI/ja/rCNR5Gv+31UWAdkgegn8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBml/lNOungbljczBVTQEbuVGUsSyBz514OTIUe1
 XwRJf+2l0mJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpf5TQAKCRBVnxHm/pHO
 9W4TB/4+mQi+zmPUNe4N+A+8BE58IM6mcrr1saFbdM8Fgvd2+J60vl8DNlvStJ3ur9oGHtscFmv
 G6PqO/JxrE92lN2Ele/1qv4qaYEysMGDrMCuBhq2F1kpui1Pp/G9debqLKR0Mr9biZtF7/GZzjv
 bRhIxErl2K8zifTUeRXkXC1oGUthAW3obCaDd0aqTd7jBFixvasyMhd0zbmeXxKR2mkaQCbdxOs
 Tje3RIXecdZk4DuWtL+SevmREnYbMIFSF7OGOTAvbc571M67eq3bSPUNm6rF96ooNapgALrXDdY
 IehQIrNMwRTmhQYH8Bhm8NP9rDoNEZnwoodxn4j12FhcjbJP
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

Devicetrees can specify the domain number based on the actual hardware
instance of the PCI endpoint controllers in the SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/pci-ep.yaml       | 11 +++++++++++
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml |  1 +
 2 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci-ep.yaml b/Documentation/devicetree/bindings/pci/pci-ep.yaml
index 0b5456ee21eb..f75000e3093d 100644
--- a/Documentation/devicetree/bindings/pci/pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/pci-ep.yaml
@@ -42,6 +42,17 @@ properties:
     default: 1
     maximum: 16
 
+  linux,pci-domain:
+    description:
+      If present this property assigns a fixed PCI domain number to a PCI
+      Endpoint Controller, otherwise an unstable (across boots) unique number
+      will be assigned. It is required to either not set this property at all
+      or set it for all PCI endpoint controllers in the system, otherwise
+      potentially conflicting domain numbers may be assigned to endpoint
+      controllers. The domain number for each endpoint controller in the system
+      must be unique.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
 required:
   - compatible
 
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 46802f7d9482..1226ee5d08d1 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -280,4 +280,5 @@ examples:
         phy-names = "pciephy";
         max-link-speed = <3>;
         num-lanes = <2>;
+        linux,pci-domain = <0>;
     };

-- 
2.25.1



