Return-Path: <linux-pci+bounces-22557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7703FA47F93
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4B93A3427
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848FD235C1D;
	Thu, 27 Feb 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS8kZw6k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530C02356D8;
	Thu, 27 Feb 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663656; cv=none; b=NmVfKja8Bbd3J8Rtw+9N9NSJnj8Kahwl6GyQlQByA9A5dZe1QEJ65wkaoJ8Wyefa+qNLYyqAoIUfnO1j5WCu05XfSed58ejmf1L4lBAyJ+riA91NQ0F8tlhPutaxIDsIlpw8fKv0UIhTrwO8QDjveCtDqBst37Q7Q6Uf5OHHjaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663656; c=relaxed/simple;
	bh=diSDB0hy4SghgMpw2m9/1nvMJNRG4+usnRsJLGxDC50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pR4ine1g4TcpAx8HJlCMC3ENV8X7yXQ00NscBmbSjl4c4SH3ijfSVEL233Z64M+zBKtCLGgUV42MwD2aI5k7rnqwK/u95UDUFaoAAhDq7+CKD1Pw4+qQhtUiXP5SZdDStrJ2usocXz4boWDD1ehGlWYEVkZrzEi9gr+TvEEVd6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NS8kZw6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12D34C4AF0C;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663655;
	bh=diSDB0hy4SghgMpw2m9/1nvMJNRG4+usnRsJLGxDC50=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NS8kZw6k2BjZzZUUyRfyFIDlZ+XDvSiL+U/1sH/f8mpyLKSfwZgl9ZpbEjphILBUZ
	 jHHKulpO0Dek58Kybmy5tCie1AYEqR35KlSwWZReSVp6EUmhbSqNccjYTyFPwWE20a
	 hLZGZ+XwqFVQf7HfNUY1cKHrBakV+xkCXiFTO5tCbbFrR9KB5X9ec1F1kGYXSOjwcA
	 hVu8Wc8bXF8Rqcj3bsu0uR3OlbpozvrBqONdMedinHuWZabG2FAAqWJp+Wk/PTOvvI
	 WO0H9osazPr8AzFv//3HwfOImlxGqNuvSetqTXaN2q3exxHBu+Cv6LHvrdmxsyCfw4
	 4ZMbC93al6u3g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBACC19F2E;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 27 Feb 2025 19:10:58 +0530
Subject: [PATCH 16/23] dt-bindings: PCI: qcom: Allow IPQ8074 to use 8 MSI
 and one 'global' interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-pcie-global-irq-v1-16-2b70a7819d1e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=OfBhoTpPsH3HUYKaANPdFRRwP7sOZT/NsW34mrUnbUc=;
 b=owGbwMvMwMUYOl/w2b+J574ynlZLYkg/kJ14W6h68R0jFaO11nve3PK56a64sTHGROHHr/KGs
 JeKT9hLOhmNWRgYuRhkxRRZ0pc6azV6nL6xJEJ9OswgViaQKQxcnAIwkcX72P+H/XF1LSn3vFm0
 o+2/R7fz/+POq961mYZwP3CU8mX5tU5U837mfVWFUteonHlsBya4XeCcLfLrrPpvNhvftkXM6tH
 TLySzCr2PyFPK3uDs4f5sbniEuVTnm/YHbUd+hc6LusesJWDX+l4rtaAl5vqbhX2cbQotRy/m7H
 USs9sSfPblfFV2xq8Le/8EVqyJFFlYeP75nw8KX9c+ZFqSEJBk9uyGmaVdi7jPjsSLurmc944H3
 +F9PMVPebGU7lHz8xOba+OMLv5QS1q9LUGOd1o8M3tYSVi40Gq9hhidVdUPv8x+WWch1CRrZNj4
 tGaKcq8vz2mmr5kzw2/kdzX82LnrWdAvtmor/hRWAa9TAA==
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

IPA8074 has 8 MSI SPI and one 'global' interrupt.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 44b1a6e74c9b..433a4fc4d883 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -586,6 +586,8 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,pcie-ipq8074
+              - qcom,pcie-ipq8074-gen3
               - qcom,pcie-msm8996
               - qcom,pcie-msm8998
               - qcom,pcie-sdm845
@@ -625,8 +627,6 @@ allOf:
               - qcom,pcie-ipq6018
               - qcom,pcie-ipq8064
               - qcom,pcie-ipq8064-v2
-              - qcom,pcie-ipq8074
-              - qcom,pcie-ipq8074-gen3
               - qcom,pcie-qcs404
     then:
       properties:

-- 
2.25.1



