Return-Path: <linux-pci+bounces-11038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA501942C6F
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 12:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB9C1C20BB2
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 10:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5361B1AE843;
	Wed, 31 Jul 2024 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEgozGST"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17F81AC44F;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423018; cv=none; b=FJJujanlLEc2F6a90LXu/3GZe9RwsxfruJUgcYZR2uAUjXupbkCaa2sh7ompVTc+8dnbln3fYXRlfP5rjcIrlGVsk/IDacdUCzn1NdQEH7x93nX+cYXJmkkex7CpbIZAW4h3H5BiSLCdgasTUFLawguIW4Ww1JBF6lAQn8AEgE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423018; c=relaxed/simple;
	bh=lzIKtgPAyTFqAhhNBnr2RiOhErj0a7AEhzCZTqA8TS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ER74B4t8ME5IlZfxFs5pZr4ZToS+KMiYYT9pCECAzyrYizBtW2UM6d7LoU7+r6Jgq0cogPbj80J6xAch/MN/Itj8tbFfAEfCJ4GEd+Ibhq4Weuqfx4C3Jk5w126vvjF1V1EyIjhKI6WyHUTaf5Xrp5shO7qJEJ+rq5RWfdOcvtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEgozGST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61E53C4AF16;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722423018;
	bh=lzIKtgPAyTFqAhhNBnr2RiOhErj0a7AEhzCZTqA8TS4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZEgozGSTxf5hjpf6pil+qz69VCUhJrWF4Sv1tsCH8q4LhEsUQgVTXKN7Q2zShN/8z
	 pzO1SeE03HWA5ZVnwkBm/sKwgFaI6KRpC7Te/TYh1av0DqXr3qEf5SFILtwy6YlShd
	 20pm5dwnlYP7n529ngU2MxfzzStBdbeM01XHJqCsaONwksuj4Hd/+Yh3UVdLzeUaen
	 dIDE8SM0JcJ5EYVFT6Kl+qLpgWErVnjahGMlwTs/Y2QWiv1faEEevaufiExM/fBKrT
	 +atCHkvIZI1mxs+Uy0e/qI8VrQiTm6s8tS25x4Kdf30ReEX6TqL0xMRNTVTsMMwAJI
	 6w7cEty/AIQmA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D37C3DA7F;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 31 Jul 2024 16:20:07 +0530
Subject: [PATCH v3 04/13] dt-bindings: PCI: pci-ep: Document
 'linux,pci-domain' property
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-pci-qcom-hotplug-v3-4-a1426afdee3b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2076;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=gFM57NfjI22HI5zO2G4ZyvVdTIrBmxWoCkDYpg/zh4Q=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmqhbiAb7YQ78WmQL+3pg/asHYaUv2cb/2l//Pm
 jyYj96EdqiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZqoW4gAKCRBVnxHm/pHO
 9WmQB/9si9S+OmgvS+y51lNqf3cu9EerZUXmpMp9BQPH2G/MbNfuM5P1TnLhFhuNHIDsykyo6kf
 TSKZDjpNjKUtwUKI8/6fVP4laVkYCwd11+WzWiAigELfLKB+3whUNPxIcqxeRXWNFIkGvAHhuW5
 oNTVEpq1kZdGX3LVsVX5QLw+c19f8RLzW3/vOnHzernLgouZFW/RT/Pt+ZAm3APCnE34rMIP4a5
 2qErJkVovUD40tPkIjPs8tm/Xmj0mVhF4rzufUqkbgiVqSedMqVddEeo+Ro3TCNBK3uO+jD7qsp
 YbvEvOq0n3LUQ1jVGxkBdTrrxEwOG5Qy1pC3128GwI+Bk4Td
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



