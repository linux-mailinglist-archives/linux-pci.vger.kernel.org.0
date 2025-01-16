Return-Path: <linux-pci+bounces-19967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BADFA13BCF
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 15:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F30D1883728
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 14:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3706F22B8C6;
	Thu, 16 Jan 2025 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfMjFDXm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2A222A81E;
	Thu, 16 Jan 2025 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737036560; cv=none; b=NqXzX4XtqWE7utUlOY2XJUPOc+I6oHQUhQjHzKXMAwQ6bxKdkt/SsPouSGRF9ItiQZVsyOG+fn5uzH5HTN+T4VyF9hSNzmVL12IdcxZfSu9OX4QLxMhRDKh38nB+AiolMI9TRUp/aaTat3dWt1v9VeA+Y9uOW42aAKGVRwTgWA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737036560; c=relaxed/simple;
	bh=EmN4Jn2rIvX97LgY0ou3YPQGNYpXchenEI59Nhj03LU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JKgZHoRJJq1nukKgVIGPAdB1+F7fb0VkOwXHnJ9i+V4b5j6Mhp//Gz7PoRo9Xn8M6ezlmTXgBoF3ESbwN13/o4+5nHJZNQHYN3sTeZ0vzoyItApZgzXShDKbR001vNkS/ZniDgkrI+PwWyAR9u1xOOqCO7x2PLnxNHEelNHdFq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfMjFDXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2F6EC4CEE8;
	Thu, 16 Jan 2025 14:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737036559;
	bh=EmN4Jn2rIvX97LgY0ou3YPQGNYpXchenEI59Nhj03LU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JfMjFDXmjTBPi0xan8quzI6WTnwjod9QgB1FSRnOLzT559w3z/PQQWHRv0QjQwe4k
	 vcMrg0bvDu0ouYLMhOcNso5vxNPMLRYZxFZ9KQZomCuQIe4SCYrCEY1YynWw9v8Yzy
	 fhwHqxrcU1NmM95pmu8J3flJ5YB0f8hw9cs320B3gWRSPLX943noVvzkXAeU7u7Vc+
	 tB6KTHgwQv+En+AqHABEzL1VEdSlRfw9VqM6EcYHEMORpLfmyNO+XkeiLgjcejQCM2
	 yBjAduzV494YWDo3XvnP+xB72JWyWNx/dmJPSDq657BBqDYrrxbyOYcg4geu9JJtdj
	 69kUY8yfkcsIg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE40C0218A;
	Thu, 16 Jan 2025 14:09:19 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 16 Jan 2025 19:39:14 +0530
Subject: [PATCH v3 4/5] dt-bindings: vendor-prefixes: Document the
 'pciclass' prefix
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-pci-pwrctrl-slot-v3-4-827473c8fbf4@linaro.org>
References: <20250116-pci-pwrctrl-slot-v3-0-827473c8fbf4@linaro.org>
In-Reply-To: <20250116-pci-pwrctrl-slot-v3-0-827473c8fbf4@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=2V7zx2KeHk/VkOVQ7/eUdxe/lfsvltP4xYw5h/bK3Jg=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBniRMMqJ0tFL1peWsFLw0JQ+t/mHBHcnihGGU48
 F8Ntj+NYuGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ4kTDAAKCRBVnxHm/pHO
 9bDiB/sFmV0721mpAS6mcUNEEuysd2O2czSfvdXp8zeE842N+e8avzu+V/c+dPfFUWAzXWHFmi6
 R1CBNjbE7AhVmFL7aifhF2eKs1FJIFHOnRtAUfTzz5X5Wo2/xN0D2vNenPADyKeToBlT8yKC9Oa
 9y50Eb0h5XuY0Zz7OpoNwW7W2yyEfvQMgcYcbMfE+VxbL68nz0NiTTZDGIuTPFMuZf1ViW/WbEq
 ieMgOd/LSU2v9vv3CFFB7n+YUnKOEM5rbIx74oSY1pT/juA9GyuNWDIykXSz3XPt8QC5gcIgyc/
 l07moVEZhmqkf6kYwZVQmtENLHQb1nBcRd5XXNCPZhD29P2y
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

'pciclass' is an existing prefix used to identify the PCI bridge devices,
but it is not a vendor prefix. So document it in the non-vendor prefix
list.

Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index da01616802c7..0539aea6af5a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -18,7 +18,7 @@ patternProperties:
   # DO NOT ADD NEW PROPERTIES TO THIS LIST
   "^(at25|bm|devbus|dmacap|dsa|exynos|fsi[ab]|gpio-fan|gpio-key|gpio|gpmc|hdmi|i2c-gpio),.*": true
   "^(keypad|m25p|max8952|max8997|max8998|mpmc),.*": true
-  "^(pinctrl-single|#pinctrl-single|PowerPC),.*": true
+  "^(pciclass|pinctrl-single|#pinctrl-single|PowerPC),.*": true
   "^(pl022|pxa-mmc|rcar_sound|rotary-encoder|s5m8767|sdhci),.*": true
   "^(simple-audio-card|st-plgpio|st-spics|ts),.*": true
 

-- 
2.25.1



