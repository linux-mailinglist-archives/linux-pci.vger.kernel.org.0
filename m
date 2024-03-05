Return-Path: <linux-pci+bounces-4503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B713D8717F5
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 09:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90181C20D61
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 08:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D25E81AB3;
	Tue,  5 Mar 2024 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2EQX+Wm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7249A80BFE;
	Tue,  5 Mar 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626486; cv=none; b=bFO9sqPikphub27YoD1a/o990TBZpUeH8X+dnpDblC8IvL6AqELPJVTbdw/TtiVrH30kcK12TrunSvz71wKjMp6rTTrTQlafrxs0zSpxYmTc+c0uyF8kAxQG3FwBoBI8ANkI8tPa+aO7N+qTNxACA4fmhjGXYtf6kxCmSBVaO+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626486; c=relaxed/simple;
	bh=DQk9lCKuHSluKcrPQ1v0+lTVtvnpI7fwkC/si6tMhYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aa5FqH2HxnoWtRl4/qN7xVW8QT3SYVE5jjzvOJw/LlFmBjP2+RkVLKRde6YUCdcAzxbfaxWKLvE8oJcZnXifyX2rb0rSAKiCrTIXazbXDy33XMFDlWLtsHtVjc+HQr6nFFwaw/VsYApLjU+aIQ9jq+bSJumI1rlAnPnD1Qn3V00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2EQX+Wm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF83C43601;
	Tue,  5 Mar 2024 08:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709626485;
	bh=DQk9lCKuHSluKcrPQ1v0+lTVtvnpI7fwkC/si6tMhYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2EQX+WmdUT7kERI1AuoPc5sQiTWG9h1kybHRySR06cxllxxIBAxndYRgXj12B5Mk
	 pJiZwNVbK3xuE5v20ER+5tn1WnCaJ+qEv4FXssHSdxZFw6a5KwkikDmPPpP2ILiJYT
	 LpWmpCj6/h1Uf6wjgWouLEAJWcHutLP5oZW4jmYpjjEf05RhB3dwq3ooZG3BU4C7Fq
	 7sly7H8U5LbWudfCSAZiyeZnMznwQ16KjKBj7fG0O5Coek/MoWbqKWrLgkdbWrgff3
	 Af7DS7vk3JKZSL56iEKoQ4s6OJv9L/9fcOq7q90FM/AMWR4j5ghnll+zj5ChzxwHiE
	 asz11h/BE7YJw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rhPwp-0000000037p-3Gna;
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
Subject: [PATCH v3 01/10] dt-bindings: PCI: qcom: Allow 'required-opps'
Date: Tue,  5 Mar 2024 09:10:56 +0100
Message-ID: <20240305081105.11912-2-johan+linaro@kernel.org>
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

Some Qualcomm SoCs require a minimum performance level for the power
domain so add 'required-opps' to the binding.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml | 3 +++
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml        | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
index 125136176f93..8d570669650a 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
@@ -59,6 +59,9 @@ properties:
   power-domains:
     maxItems: 1
 
+  required-opps:
+    maxItems: 1
+
   resets:
     minItems: 1
     maxItems: 12
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index c8f36978a94c..1d7a6a520fef 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -111,6 +111,9 @@ properties:
     description: GPIO controlled connection to PERST# signal
     maxItems: 1
 
+  required-opps:
+    maxItems: 1
+
   wake-gpios:
     description: GPIO controlled connection to WAKE# signal
     maxItems: 1
-- 
2.43.0


