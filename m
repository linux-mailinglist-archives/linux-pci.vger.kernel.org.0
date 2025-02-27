Return-Path: <linux-pci+bounces-22541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BBDA47F69
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA8C3A6956
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAFF22FF4F;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcxGYYhV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAA422F397;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663654; cv=none; b=U+cVicByGkZj0pWUUCqdbC+ROYGDW5lOmLTeErPxLTs9qPT5tKwMp5lo0WLPtfuDzgpxmNRvn3c93zAA9OWklCsm98OyConp7VmXBjCMoTvD4L4UEo1nkfjIXJ4l1GAtsoyaReU1RtmElOn2I0n/4W++tCvgxaDDLtADKfuKa4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663654; c=relaxed/simple;
	bh=DsfpIEJszPEAQuW43jGjfUKbpSkRvvrQxM3WE/LyN7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VdK5gaD4jAeZ0lar1FV+cD/YqT0xqWWi4LNbTyUTuMDG0mndx5hpUswRoSfVMWdCnYGETY/dCcZ3hDUv//Jd0DkAbEHaIZkpbMhWAr6CsrmpYnl2/ZnYoMhxz1uHN1OPxiwLUdCS/aPf+IGz31wNyyPe1Z/zl0fjsUaW2d2OW2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcxGYYhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2549AC4AF0C;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663654;
	bh=DsfpIEJszPEAQuW43jGjfUKbpSkRvvrQxM3WE/LyN7E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FcxGYYhV7IbH7zFntaDkWT69h36zG2J5T6/uxS3NwlDfbfS51ZwOSwWKim42g0YjC
	 +5/sKkm2FamfbcU4IMVwsOsaoXA2tMk7jFLxI9Xlo2BaUrlpiwes2N8IDQ7TDKneQj
	 sEjx/WeCulwHZj0MAT3Z9ZlIvflV4cNVAp713LyRQAWWQMQget/yh6kHKXmUJi86jz
	 eVco1lgr/CQVt6vVa/PhdGilaLkTk/iZ43w/aEnA295Xnd/YWdRHjP/F17JciAQXB7
	 yvff9uGHovGAfqkNYYnNHmzQq/TFPIqqhf2x+crTnrU/EWtIG8AC1lBzxVrfKcAice
	 V4fCNPPuxPSXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF5EC19F2E;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 27 Feb 2025 19:10:45 +0530
Subject: [PATCH 03/23] dt-bindings: PCI: qcom,pcie-sm8250: Add 'global'
 interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-pcie-global-irq-v1-3-2b70a7819d1e@linaro.org>
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
In-Reply-To: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=EsGx8DzxLm57OyGTXGe0TOfMlOA4Ni7Q8YePcJ+flH4=;
 b=owGbwMvMwMUYOl/w2b+J574ynlZLYkg/kB075a1Qqc/Sfawc3KnePy2rU+al7n//1Ld8puXn7
 l2ccTInOxmNWRgYuRhkxRRZ0pc6azV6nL6xJEJ9OswgViaQKQxcnAIwkY+l7P+0jMsrQ1av3J3t
 X/hrbmrP0hc/p4fveDW5bmFNecTelHd3dvcmZMY4KBXsPjTpgroVW/9Ge6uTkQr12iuqm3et3fN
 Y+PRlX+FKsdJA5Y9T2KwNmy0fXLBJy0oMrp7WGXdgjaOYxOdbGVxnbGz3yq7+zFzqp6ckyHtKdc
 Fy+62FGaz8pZkVprp7D9RWmyQc52XbVZzjWSCtNc1m1raXQv6rDUKWF1zc8K8tNuGSSNJxGTNWw
 +MeRUkp23y2bzqyd8IK5jw2tyjBa7Fz3u52di8wjjcKF3ylFHZplfVGvfc7mfoSq3bWh+cf67dw
 yXKeqXa+xbJNLaPCbPlM9fwGh382YvV2P5321Zbllv0CAA==
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

'global' interrupt is used to receive PCIe controller and link specific
events.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
index 4d060bce6f9d..af4dae68d508 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
@@ -61,9 +61,10 @@ properties:
 
   interrupts:
     minItems: 8
-    maxItems: 8
+    maxItems: 9
 
   interrupt-names:
+    minItems: 8
     items:
       - const: msi0
       - const: msi1
@@ -73,6 +74,7 @@ properties:
       - const: msi5
       - const: msi6
       - const: msi7
+      - const: global
 
   resets:
     maxItems: 1
@@ -143,9 +145,10 @@ examples:
                          <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+                         <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
             interrupt-names = "msi0", "msi1", "msi2", "msi3",
-                              "msi4", "msi5", "msi6", "msi7";
+                              "msi4", "msi5", "msi6", "msi7", "global";
             #interrupt-cells = <1>;
             interrupt-map-mask = <0 0 0 0x7>;
             interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */

-- 
2.25.1



