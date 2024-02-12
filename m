Return-Path: <linux-pci+bounces-3351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 123A5851A14
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 17:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3EC21F2412D
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 16:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756543D56A;
	Mon, 12 Feb 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkJ9Yqxe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AC43D3A1;
	Mon, 12 Feb 2024 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756819; cv=none; b=P+CXdLnauS5sM1syTy4uBlQ60TQG0vk7Efie0VTYnf+TTELVNIfYx6q9/uxtp5RPZUjS9Z7z24oc3jfdJiI7zp+2iU/DEbW35/p2fWQmci3gg2rHgnLaeZFQ3DLV2KIHWyrjkeFo9UO1cUeg12k/rpWSJ8n6M1QSP5Qx5nGTP4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756819; c=relaxed/simple;
	bh=nc4MqV6YaWXP4nv2pZ90dCQqT4i4GYj2D270C7X4X5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAHlXxCIcRPm2CBOXOoLvs2rcJBhu+ByzTTC1BMvLSmtRamZFaIGpQ189yB3KF2ajHOrKwHQ3j3hgjkAKiNaZ2IyLXrn9a6+5bX8e7j9kZUpoqTdqa2KHS1wwKwSuhmHvOaGmAgry2n84nIeNnaGK1nusT8MQS5PSnPaCD7Wb2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkJ9Yqxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C7FC43399;
	Mon, 12 Feb 2024 16:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707756818;
	bh=nc4MqV6YaWXP4nv2pZ90dCQqT4i4GYj2D270C7X4X5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YkJ9Yqxe2rkvBsFYQXHVLOHTbYd1bYXt3mmVLH0Uis9itgcKVJJd7cDhi/KtBLHpM
	 yWikgU5w6EiQaofDMr54Sh5raJbarLkP+olgFIvp+wlW16eOaAIQoZTbcT9HwH6b1D
	 xhG0gJDLZMh/6dRjgMaZxMg8Sy2GAMPFyUfyYO2uZzp8AuhoE36LzLbPBuwa6XM2+s
	 Q6uZTdQycmOaVNteQQGhxC7UElnZgVst+TVsyH4zg1ZICmQDzcOJA+35/0q08cjzv8
	 rQJqRlbvyRZTn9BnLXfESp38OPFYGrxCA87WqZ+Sa7arrIhP/h/M32J6h6duojKDiQ
	 mUQ1RiocdSKNA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rZZZ2-000000007NB-3T1E;
	Mon, 12 Feb 2024 17:53:52 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
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
	Johan Hovold <johan+linaro@kernel.org>
Subject: [RFC 07/10] dt-bindings: PCI: qcom: Allow 'aspm-no-l0s'
Date: Mon, 12 Feb 2024 17:50:40 +0100
Message-ID: <20240212165043.26961-8-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212165043.26961-1-johan+linaro@kernel.org>
References: <20240212165043.26961-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 'aspm-no-l0s', which can be used to indicate that ASPM L0s is not
supported, to the binding.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index b28517047db2..4d1060b52592 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -130,6 +130,8 @@ properties:
     description: GPIO controlled connection to WAKE# signal
     maxItems: 1
 
+  aspm-no-l0s: true
+
 required:
   - compatible
   - reg
-- 
2.43.0


