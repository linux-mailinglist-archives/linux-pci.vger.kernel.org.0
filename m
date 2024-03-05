Return-Path: <linux-pci+bounces-4499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DB98717EB
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 09:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD672820CD
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 08:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37DA81AA2;
	Tue,  5 Mar 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ip7Bo1GS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F51F80630;
	Tue,  5 Mar 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626486; cv=none; b=EGJUB9ZP/Y1xt/U1YSm/WTBSSLVtO8KD9kAjPwcD/WqHmQ3EE4pZbBuozaYIHyZ05FzFAnl4XMhA1IeFe7feABP0F37neQFIY0Gw0umPm75DyP64saGazIGIKZ+nvBkXPZSh/13P8Dy0kon9mG8X+8Nn3PkKwn9LE/iitZu81NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626486; c=relaxed/simple;
	bh=LG9qzAt51k9B0led/p2cn23iSKOm/jB6p41538MCRnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMDGSUWyCm6JJ1nRWn4UnFfglsSLLO4+jwtdbx+x6giOBGu7TFmd1z+GtVmKKfKUxKH2iYk2TBbJvPTnDLQ6goX1BiQzb4uLids3SR1JJznsk2Vxhipfqh6+0pwvzEj7pLFTxqjItjyAFsTN3LVN8YtFK1tl6DBLXviGDGHMo8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ip7Bo1GS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C76C433A6;
	Tue,  5 Mar 2024 08:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709626485;
	bh=LG9qzAt51k9B0led/p2cn23iSKOm/jB6p41538MCRnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ip7Bo1GSWMZvafG6V1OdRzhkxJTO2CP8BJKyz6JVNyzfGMNeKYfbrbuCIUVGAZFsr
	 dgxPlS54HHE9ISyY0StS1xLNNke6mlB0MK8yPLMxtJ96rj5vO/8Ua9kzr5Sy1J5Fo1
	 nGlyMeCAMeeiAhbWjrsoaA8dH0qRIsA0I6FLyjLEIcw/KNfhk3cBmcx3HbvoY2pC3B
	 /STfXbfUy0GmBIU4N2uAV+Hy3l8O9TvQHx5ikxfqST685KVV7mPhTqNtT2xtFdtnsB
	 zf1yXvwWqnR7OP8UXrydYaaINA/2at7C18nqeA6KwlVul/JKLwE6xBmSiVYeHZ/ABx
	 bIGLcamm2ghbw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rhPwp-0000000037r-3e5U;
	Tue, 05 Mar 2024 09:14:51 +0100
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
Subject: [PATCH v3 02/10] dt-bindings: PCI: qcom: Do not require 'msi-map-mask'
Date: Tue,  5 Mar 2024 09:10:57 +0100
Message-ID: <20240305081105.11912-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305081105.11912-1-johan+linaro@kernel.org>
References: <20240305081105.11912-1-johan+linaro@kernel.org>
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


