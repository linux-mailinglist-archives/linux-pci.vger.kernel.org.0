Return-Path: <linux-pci+bounces-4558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B34873352
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 11:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0E81F265C0
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 10:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CFF5F564;
	Wed,  6 Mar 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="am7F77xP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C21C5DF29;
	Wed,  6 Mar 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719189; cv=none; b=XDiipXs9jZqA43ENuWW/pwR+Y1ukiVDtZvyjqgGZRscFB1TUUZo3a91cIymMoJtr1JnRT/TRAMGwb/9DTFahaAjJnYfVGzHo7kdN0u99I4stKcUxW78+07Sh42XA1hSxBwZUyelgnY+c1xuMaTz3EJDG/ujONLLNPzhOtXZx/do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719189; c=relaxed/simple;
	bh=DQk9lCKuHSluKcrPQ1v0+lTVtvnpI7fwkC/si6tMhYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKGD2u8gP3Gc3HNswEf1JmDJbJqJ1jFa56A1xWoLpIsJze3BBdSfykQeB2HFB39oIbZcyXbz6LnaPIwGXVvJy0VEd+g8Io2WIY+6q3cMqJCIASsluTNxVvXajE1cbnqOhMeBBzSymYcytumeLbwxtrqIrga80+Oo/SGSDmazUe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=am7F77xP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F96C43399;
	Wed,  6 Mar 2024 09:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709719189;
	bh=DQk9lCKuHSluKcrPQ1v0+lTVtvnpI7fwkC/si6tMhYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=am7F77xPfomHxwZCurqDdtuJ7q/YpklXZOPXXxNskzrquKhKKdhxyebSmfhXKwxly
	 UR9p7nLIucCkLeQBpAI848TY4YoZp6oLniZ7P8LgOsiERpaV7j9zyjJWBnHAqY0lcO
	 vXmbdE5zB5FbvYZMXvr6sw1bhyNzKHiy/N6Jg2XbgtkOWtbW1GWQ3p9IqSImAIFNVv
	 Zc6ql6Du7lVvI7BzIPui7VW7dnDJ5vY3kewUljnyUpKEM+npRuj7+AC8WwHgsaiQC2
	 XOuiaB9j4BP8j/IUOiioRptLDfHLjrAGV7z5fMzoKKH/DpoxYLk/JuDTj4hpJCUMZ3
	 FHLbCDLnGChZw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rho44-000000001az-2U32;
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
Subject: [PATCH v4 1/5] dt-bindings: PCI: qcom: Allow 'required-opps'
Date: Wed,  6 Mar 2024 10:56:47 +0100
Message-ID: <20240306095651.4551-2-johan+linaro@kernel.org>
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


