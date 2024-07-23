Return-Path: <linux-pci+bounces-10660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A4893A398
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 17:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17651C22BF0
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 15:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06678154BE0;
	Tue, 23 Jul 2024 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qw4HxPt3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AE33D55D;
	Tue, 23 Jul 2024 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721747721; cv=none; b=F/4nqPqSU7BBETymL/EnNYQTHJgg2Y24l1CjeHMxVdQM0r0ZR4IZMQPDYK/UifaTo5Q1/y1Xve386A4d8UZB49DaQrcpcTL5nIb4VxrNjmRb42r5ELwbAIzNe0CQPqUkQ5OLof0jRR4ZCn8Vzu6dHoPFp+zRDa+9KcayIyHftPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721747721; c=relaxed/simple;
	bh=ol9JsVUnRtg4oc6OjI3SRRYJtqUxFY8FVh6ck81PLJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rC1dODBcVQCTygLUTa1iGAMbZPBnqtSxXXFSCjzlAH8voK89ED84g9Y0MliwtRVxGaV2ttZwohQHZ5FCA1pup6h9pCgq8nYaI4ZhLakjOQmP/jFcvnWS/vbccITa/YAjoS8PV5GgQkg+UW9lW16dJlnOA9YOZygJywAyOR4OPk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qw4HxPt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F94FC4AF09;
	Tue, 23 Jul 2024 15:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721747721;
	bh=ol9JsVUnRtg4oc6OjI3SRRYJtqUxFY8FVh6ck81PLJg=;
	h=From:To:Cc:Subject:Date:From;
	b=Qw4HxPt3jZRflwxFHdqJIxfBYds5uGaRBGRpyHsM7uazwqHY9bGrQMTucacb9lR1j
	 d+m4VL0URHPeIboa0n57AGoFeReH9C3HWmj5DWUay5pW15qOcMxv3XtLbDr+IQ8pPI
	 jyr60qj9YF8O/kiOboxHLl04k1i9gJwVOP6cR5wCyPLYG0HKZ3CLM52LUvKPx3TOs0
	 Qu/g6wwdblzgN4W9cuVjD617aQpecdeoADPnk4UOuMFqtVU5gyBBi9IfeNj1dv9iUd
	 B5KDV2jx1NComhR5NWO1HyfbRJ4q+aUDPDS9GT0Lov21RlgCUHCsdPY3yu0Z/Ia7+Q
	 fhDmIT5tP/0sw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1sWHEW-000000000CV-1yBN;
	Tue, 23 Jul 2024 17:15:21 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] dt-bindings: PCI: qcom: Allow 'vddpe-3v3-supply' again
Date: Tue, 23 Jul 2024 17:13:28 +0200
Message-ID: <20240723151328.684-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to
dedicated schema") incorrectly removed 'vddpe-3v3-supply' from the
bindings, which results in DT checker warnings like:

	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb: pcie@600000: Unevaluated properties are not allowed ('vddpe-3v3-supply' was unexpected)
        from schema $id: http://devicetree.org/schemas/pci/qcom,pcie.yaml#

Note that this property has been part of the Qualcomm PCIe bindings
since 2018 and would need to be deprecated rather than simply removed if
there is a desire to replace it with 'vpcie3v3' which is used for some
non-Qualcomm controllers.

Fixes: 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to dedicated schema")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml   | 3 +++
 Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml   | 3 ---
 Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml | 3 ---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml          | 3 +++
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
index 0a39bbfcb28b..2b6f5a171f20 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
@@ -78,6 +78,9 @@ properties:
     description: GPIO controlled connection to WAKE# signal
     maxItems: 1
 
+  vddpe-3v3-supply:
+    description: PCIe endpoint power supply
+
 required:
   - reg
   - reg-names
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
index 634da24ec3ed..7ed46a929d73 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
@@ -66,9 +66,6 @@ properties:
     items:
       - const: pci
 
-  vddpe-3v3-supply:
-    description: PCIe endpoint power supply
-
 allOf:
   - $ref: qcom,pcie-common.yaml#
 
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
index 25c9f13ae977..15ba2385eb73 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
@@ -58,9 +58,6 @@ properties:
     items:
       - const: pci
 
-  vddpe-3v3-supply:
-    description: A phandle to the PCIe endpoint power supply
-
 required:
   - interconnects
   - interconnect-names
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index f867746b1ae5..ffabbac57fc1 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -91,6 +91,9 @@ properties:
   vdda_refclk-supply:
     description: A phandle to the core analog power supply for IC which generates reference clock
 
+  vddpe-3v3-supply:
+    description: A phandle to the PCIe endpoint power supply
+
   phys:
     maxItems: 1
 
-- 
2.44.2


