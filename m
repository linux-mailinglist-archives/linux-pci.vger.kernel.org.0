Return-Path: <linux-pci+bounces-12357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97967962CC9
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 17:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5622F281CFF
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 15:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47071A38F3;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvwF7wVG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED7C1A2C02;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859984; cv=none; b=qMQQPLMQkIGpeVb9kZkW3uEPxPap/d+iNF85mX7/4EjPpZX264ShO+ISv7CQz4SBFhCSQrcHHSw3R58yCO2iAGtjwv5AjsSDGI1r11ZL9AwVuYAf8swyBcd0fPk3BrOrE9SKIMUaTPs9eQYsmBM+SRzGo3dVb9UKPnIP7ypVMY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859984; c=relaxed/simple;
	bh=lzIKtgPAyTFqAhhNBnr2RiOhErj0a7AEhzCZTqA8TS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e4/Ku/YOUO8daVozP4X6BaD0IXrsvnjoWyV0iP9KRjo9JPSmR/c4ajLea7wiQdt0NXz9V/QF/tOg136fC0qAslQg6eycavTVmH0vGvYCjbERkFDzSiMijI7+nGdIBme0DTlagjSo/uC3VIfuTLjs2zvpAIJO1GXxffM6ZF5MAA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvwF7wVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BAD4C4CED8;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724859984;
	bh=lzIKtgPAyTFqAhhNBnr2RiOhErj0a7AEhzCZTqA8TS4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NvwF7wVGdredPr1UtdZZ1/Jze1aI5+n1U+EYfWjcv27uYZl5sQ23Ojn+b7rfaZJu8
	 nwqlZNHDJY7iSFOddBHiSuFYGkt73Ykf/Mt6ShrUaE5q3xbBgL/KHmmMDUXXkmwK8J
	 Xr2YijOJ291o3+Z436bDNVWk1c4J8QERgoDWP90wdd3RS9Zu4/uyvmFsdILlWqwyM8
	 mbuJ2UGLLQlCwOWLbFmRyUIcXKskxeugHbNAvsQpA3BCbf6BX/qWkKAZuBh1tqnEPL
	 BaFGNxxAWuLbylikBrs7tK2ErFJG3cml7HKDEDN1S3Z0MXrqOY/nc4XE0TBOVJ3V2h
	 rNzCblyfFij2g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9F3C636DB;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 28 Aug 2024 21:16:14 +0530
Subject: [PATCH v4 04/12] dt-bindings: PCI: pci-ep: Document
 'linux,pci-domain' property
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-pci-qcom-hotplug-v4-4-263a385fbbcb@linaro.org>
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
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2076;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=gFM57NfjI22HI5zO2G4ZyvVdTIrBmxWoCkDYpg/zh4Q=;
 b=owGbwMvMwMUYOl/w2b+J574ynlZLYkg77+b9qPD0zoTmjt55705zP/3VGWERKqNUMP9ExrVHd
 Z3c/vNOdzIaszAwcjHIiimypC911mr0OH1jSYT6dJhBrEwgUxi4OAVgIimZHAzdekYzIpiikz8X
 1a5cw84yuXSRRtFuo1gOe/6+g1/OqoXs9f9b9rHRWT0skqXteknqmp/KSg2dDzPCeGt5wtl+FCw
 Ij27vi9kns9r2jopQk/ySEPmZHrs/2n/745YR2quQ8+924sx9u6+4fv/0qHB+MfPPFX8tctrNrl
 Wl+/R2T+H7W6OX98Bs9nzj1lOvbhk35IqX9B4or3XurmLfnbH+75VQV69Gsa1aqRbOm9JPbf6z/
 ajTD86pW2vly2xKpvHIH+MPPXbTPuB3sm+g0cO/8Uovp+0M7tI5K13IzFv4y931IKu993S/D8dt
 7739za4aKdAwrWLjglJeeWYVZt3HScs+hkie1pRbft0FAA==
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

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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



