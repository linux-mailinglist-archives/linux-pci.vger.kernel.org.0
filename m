Return-Path: <linux-pci+bounces-4559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C08C9873355
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 11:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623621F26628
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 10:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8309F5F875;
	Wed,  6 Mar 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSDDBmgg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F295F481;
	Wed,  6 Mar 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719189; cv=none; b=YRX0m1BzQZgBbr8hS+sJXSATHDcOKHhn5XqNxdvqNd4D54HVH5sw8yy4kcX6FOrcauF+r2RDG2lAhs5WyNhMTggHrlQ3WzixvLc0KY1HMewx6mPkz3N0/T1UoBxb9NBvaqU7gBx7DfgGP5F9rJnTwpGJmuei0ApkJorn4J2HHoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719189; c=relaxed/simple;
	bh=LG9qzAt51k9B0led/p2cn23iSKOm/jB6p41538MCRnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxPpOPYybgCGy4lz8I125deC8GCPPne+Bj4JQHInNRLqGRYWT18kP6EUGqFX9Z/pcMBTYvWxxeRmfuNyEZQ38xrQkk9LrjQerpRA5DGvwiZ8QKQObJR2lVCrO/XliCAB165+0hmDXH33Qh/mI/pV6puVFzHqpkwg1jMBwjH40G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSDDBmgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F24C43390;
	Wed,  6 Mar 2024 09:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709719189;
	bh=LG9qzAt51k9B0led/p2cn23iSKOm/jB6p41538MCRnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CSDDBmggTyiVIlQmCe6H0SVuUIUkts6lV2ttygne7UjuVdaWOg9UfQ0c+9kPfCmvl
	 BE4po2Ra9QTcBdMwqqYMDKUiSU4vkdXXbsnT8S1b9/zkOXK379rzslASZxMuvLnCNy
	 5gXC4zYKA7ZKRpFmryovhGOM2nz+gOibKkmL1otkVvnqWPSYdLtaWIrskwK42hx6EW
	 OjZZSM7SmMG/syoIrkh7rl+R/D+bsfq9WdMI9v9MEkBtRowjATJr4tDl3NV3/KZ9iz
	 ohvHfcR2nVswdN/LUnL0Y/Drgu0jZa2D0Lsnzeb5mVTR0S+sIkZ3TBqNOHCE/a++1S
	 aPBmaStZzo0Tg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rho44-000000001b1-2sbR;
	Wed, 06 Mar 2024 10:59:56 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 2/5] dt-bindings: PCI: qcom: Do not require 'msi-map-mask'
Date: Wed,  6 Mar 2024 10:56:48 +0100
Message-ID: <20240306095651.4551-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306095651.4551-1-johan+linaro@kernel.org>
References: <20240306095651.4551-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whether the 'msi-map-mask' property is needed or not depends on how the
MSI interrupts are mapped and it should therefore not be described as
required.

Note that the current schema fails to detect omissions of the mask
property if the internal MSI controller properties are also present.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml | 1 -
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml        | 1 -
 2 files changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
index 8d570669650a..0d1b23523f62 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
@@ -93,7 +93,6 @@ anyOf:
       - "#interrupt-cells"
   - required:
       - msi-map
-      - msi-map-mask
 
 allOf:
   - $ref: /schemas/pci/pci-bus.yaml#
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 1d7a6a520fef..efaab5f82b47 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -134,7 +134,6 @@ anyOf:
       - "#interrupt-cells"
   - required:
       - msi-map
-      - msi-map-mask
 
 allOf:
   - $ref: /schemas/pci/pci-bus.yaml#
-- 
2.43.0


