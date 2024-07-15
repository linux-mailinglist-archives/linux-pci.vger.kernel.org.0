Return-Path: <linux-pci+bounces-10281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2897F931976
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 19:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5BB11F22FEF
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 17:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265C26F068;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nlxo+Aq0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D909356440;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064830; cv=none; b=XuCn/hVR3F8YUfGGVRF5/v2Z9ozQHQYVmQSbMXSAvmj5O76AKVtDRy8HMKcpTP/zo5EyJdhKLyhlmkspZ15u0nj7S5p5iYMxBgAfNN2SHc7Yn9OpmqEwadAVSpyaO2U43rEpfQgCSmb2YeAxsfmNUoyvx7mvTFmiCNHjtCojRPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064830; c=relaxed/simple;
	bh=JodG2X/6iAMSp3kPrYKmjLQmZw4WuSJ7AGPo4O5dqYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UYtTd7+ZUfNz9+Qhcy6YxYZWYSrHe3/8jKPUQolUDWyT8ayQerv34njyspHVf4HGkqAMxIz5vVqIMPnpdt5k6MDAY+iMdiWozAvCGRKueS9fyXgxoV0J7So2WeQ7crr9j4z+SkfTI/N3xg3J6KCvoqrMj07/HUToYjFR7v7oIkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nlxo+Aq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 945E4C4AF16;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064829;
	bh=JodG2X/6iAMSp3kPrYKmjLQmZw4WuSJ7AGPo4O5dqYE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Nlxo+Aq0mSRrMKNVBH2zTC1llFUIi7qB6dnngDD4S620PDaXF4Ly7qpTBnpWwsZvL
	 Vg7obPVvz+mdrIU70bO5PlIoZ+gbuEY6uNlWgKKFcwJH5QL0erJq6JPNfsAV7B/H2y
	 YsCxrrK+WTZuHkq55ikPVBaFERW5Y62oTYONQ9+hU+/0nYr+CF5+2eQJAY/G0gAl6l
	 OFV4sB+Gb3FT6AgrCZKO42JLiuJ4tytYu+eFrYGrrH6GogWphVZLiLkVI4DqHgHiYP
	 aoFJwMJvxw71h0HVhCZH2SuTwz81/mOQLC2BMvVkEGUv5Fd/z9RZ/bVLfiwlia014O
	 m8Ix561W0PTug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88090C3DA61;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Mon, 15 Jul 2024 23:03:46 +0530
Subject: [PATCH 04/14] dt-bindings: PCI: pci-ep: Document
 'linux,pci-domain' property
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-pci-qcom-hotplug-v1-4-5f3765cc873a@linaro.org>
References: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
In-Reply-To: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=AdGl5m97uW0nytJxHIv1uC0b7XTjC/3siXK0QubHe3A=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmlV14F9MHhAndakYHmQubDUeQEqYLKrlW9Kq/s
 a1PHQeg2yCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpVdeAAKCRBVnxHm/pHO
 9RR/B/9xARyrbyS7qtcfVGThO0D22TMAVIFcHJjlb98oUOxms57Sz7OYbCh6MVwSk/ZfHGLEEwk
 uOfxUX/ficqQlv9euJIo2MNUoS/Z9X+/LmQctpOTyRa/DQOb1TQlBQc5mPSQI9JWvAyOuUkc+YM
 Gscnc/N8+05NATJ+7HOOImp8lvpoyMsQuFnl8Uf/LjNGMLNIBP1qN27ItK03xnozskJeYxPdFnE
 ftz6QmvjCLR5Fwx1KIsctuIb7Alb2dQhqz4eFZbAyni2Wn0El58ZG9w7wYmzGl6K/eAtsL5sh6z
 bxX5HVZzv0o0cKb0H5uEwNEYfyF4snrcXdWd9BuPZYwiubI6
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
 Documentation/devicetree/bindings/pci/pci-ep.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

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
 

-- 
2.25.1



