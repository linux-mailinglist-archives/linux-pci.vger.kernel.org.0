Return-Path: <linux-pci+bounces-22559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E85A3A47FC5
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7981738B1
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA444237176;
	Thu, 27 Feb 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBRnJ82o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB107236443;
	Thu, 27 Feb 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663656; cv=none; b=CHFVtszeXhBcRzj8blY4OYycNToG43jway+PIFF6aFbRECgc/KPvftWCiMvCES8i++C09RaR46wF2d9ATJcyppgF/jM2bMtBZHbeQ9/quiNEvSRWULgMH2hlMFSHJtXLbPc1Tainr/+0FN7+JzxFiPN5hsidwrwgg/VsT8af4ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663656; c=relaxed/simple;
	bh=PCoQhZBor0nTk1wsAGZJXiAOR7x3bgC2RDh2R3zUaMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FxISU/Ap8fenTj27DwE31731X95tAIEF5S7dPalJVObfETR5UYdHEl00Dyozt/W2BCtY7P358ZdMfuDvjy0Y06HjvEocaD6JPkJt65OSwcohq9f3zGCjRZhe4FqCvAApyFauhvOlUtEMkZkLKjM9zR2EYYmbBBg2ni9pqALveDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBRnJ82o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40483C4CEF7;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663655;
	bh=PCoQhZBor0nTk1wsAGZJXiAOR7x3bgC2RDh2R3zUaMI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vBRnJ82oIQd0K5rCnbC/5uOiWW5lLiKogOBkjBDZRIyFlBDQvM0yEyPuIseUTq34W
	 VUjmGEtvKxGUoViKtAS3CG4BiqarO4JAaPXLm/26kSwd/aK2bvLzUabNVSbM2ELRUN
	 FLZh5G9rMDzpR3TckeJfQSSZFlcAXzBfWAGNlRjgdK2bVsbHFWuRLK8qi/WAClxhOq
	 9K6zQbVw2jLeRWAIqVBRoqUG9zeKRlAyOkc3KBqKkopYJR/jvW2Yi5wt6e8qU1Vexh
	 aMKHry/964wwgoULADLs6JWUZVHfzvPuAql4OFwK/NF5emwUS4E0vhITD8YqXCuI7W
	 Ezz4LfscuMVeQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D86AC1B0FF;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 27 Feb 2025 19:11:00 +0530
Subject: [PATCH 18/23] dt-bindings: PCI: qcom: Allow IPQ6018 to use 8 MSI
 and one 'global' interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-pcie-global-irq-v1-18-2b70a7819d1e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1064;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=3oilXH/eh6Uh87q83kHcwoMClQ62eXD3O03uzw0uOB4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnwGthW5ENmwQn9oN1voJHayqM6bExe8JP4bYOJ
 /Jbguw5L4OJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ8BrYQAKCRBVnxHm/pHO
 9ae9B/0Z4L4/4T9YG3AJGc4k+NVtnkrqDcVGaMxKtoxgz+oXM+SwXbiO/dEPkyO7SWAhavAhmhH
 hF3aUFR6rVaYHXL5kiqVc3ctqiuUyQEEtj8dXh3YWgsffSARTDuSDZ4Qr8HjfWT610g11+aPvMw
 hsuabzpYOlyuK28m6kaUlKJitlcQVdWtTvvPhFe+ZVgnsQfcQ5muAO8oUw+G3173/fardQoPQrM
 jrSCdgRTPbVewyYuRAHuBPPjm43608eA0GzCvGlY20VkEDowcgyadfgQi+dMEFCVj+CfDqiGI4H
 rwm6kEEmOmFj9UaiUBZAdoXwwZiJ1bRsBDU1L9HTIBiajZDR
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

IPQ6018 has 8 MSI SPI and one 'global' interrupt.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 433a4fc4d883..8969254c3c7d 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -586,6 +586,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,pcie-ipq6018
               - qcom,pcie-ipq8074
               - qcom,pcie-ipq8074-gen3
               - qcom,pcie-msm8996
@@ -624,7 +625,6 @@ allOf:
               - qcom,pcie-apq8064
               - qcom,pcie-apq8084
               - qcom,pcie-ipq4019
-              - qcom,pcie-ipq6018
               - qcom,pcie-ipq8064
               - qcom,pcie-ipq8064-v2
               - qcom,pcie-qcs404

-- 
2.25.1



