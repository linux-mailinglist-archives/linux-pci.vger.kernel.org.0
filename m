Return-Path: <linux-pci+bounces-4495-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296D28717D8
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 09:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3EB1C20D85
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 08:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599018063B;
	Tue,  5 Mar 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8zFR9G9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF808061D;
	Tue,  5 Mar 2024 08:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626486; cv=none; b=fVhe42DVXLxcaiMwTK0RHoNOOw+vCX9M5I3Ev5/VPiewUrBkiDyPFAHGNj4QLUH1gAAA7xnuQskAJ9IVwGKbMoENHMJoXFo47vyFWcENWcyd8GrKNi6XAh81wnuuAP917EMUjwCP8tbVJpt9Y5RPI4TLrLq7t3+PhoIa3QaXLYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626486; c=relaxed/simple;
	bh=CwZ0j6uvyi76UV840KbcFaKTKHb147IOIeSH2KfyiDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJj7LymdUZVA256NNgmZ8hsP4PEmhRKoiN9giEotGm486ZHcEbqgUqzckX4dKX/yX05geMpXooVvRZxYZDj0oB9bnVkefeQxqm333ZSINYCV5FzqGnVqiB53TCE+LaO7TXQNf72pIc0gnqEa4JuvDFH48YEgiQnaQvO3WJL5HRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8zFR9G9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1ADEC433B2;
	Tue,  5 Mar 2024 08:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709626485;
	bh=CwZ0j6uvyi76UV840KbcFaKTKHb147IOIeSH2KfyiDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d8zFR9G9r9p0yXlch7TtAJ69ZM1SutM/kUiiJYtGlzULe89xv20W11jyoqlpP9aXh
	 GbXw5/AkcD4FaZuxmckxTg5At+zPstzt6RZaM54oFG/SeTWNPfZvu4pwYDrb9p39s5
	 47VdyIx/8wW6dIbcs/u3UYSUZU+odhlzORd4OpvDOpuNSNggPpUSRf/LBiIr/asGBV
	 ZQd/2+T8fvtLHf2850dXSll75oQNq4D8li9Fbx4EpFeVbIAHIvygZYMCAeidKYOGCY
	 x4glPKmFmJEHh5sNH20WH1GhuJvCh678M+I0HLGIsZ96j473k3Axpc5eDVWPakL4+Q
	 1ZX9U+MvFIE2g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rhPwp-0000000037t-41Fy;
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
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 03/10] dt-bindings: PCI: qcom: Allow 'aspm-no-l0s'
Date: Tue,  5 Mar 2024 09:10:58 +0100
Message-ID: <20240305081105.11912-4-johan+linaro@kernel.org>
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

Add 'aspm-no-l0s', which can be used to indicate that ASPM L0s is not
supported, to the binding.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml | 2 ++
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml        | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
index 0d1b23523f62..40ac5ba81233 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
@@ -78,6 +78,8 @@ properties:
     description: GPIO controlled connection to WAKE# signal
     maxItems: 1
 
+  aspm-no-l0s: true
+
 required:
   - reg
   - reg-names
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index efaab5f82b47..a23d2cfb86c4 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -118,6 +118,8 @@ properties:
     description: GPIO controlled connection to WAKE# signal
     maxItems: 1
 
+  aspm-no-l0s: true
+
 required:
   - compatible
   - reg
-- 
2.43.0


