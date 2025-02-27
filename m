Return-Path: <linux-pci+bounces-22555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A5FA47FC2
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D27117AE44
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540092356DB;
	Thu, 27 Feb 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvE0zyml"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E228C2356AD;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663656; cv=none; b=Bxbxxa1a7XPMKdoWIPfeAX5yOPEgNmttFg98UM0mZgE+/VoqcQ66TOgicV7hUt/+hvvtePuEk624OLD4iD9VgLE19bPMzoBtcOhCwM4Uk3ORjeG5M1DFokG27nW0zEZ2OGq0NFTYyyAopolJ0hnLxsUyJw5JHQe57A6z1sL9xA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663656; c=relaxed/simple;
	bh=x9n/LL/K3cPgU4HL0+L2IY3Pf8+86E6poCd+Gcg2e6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rkTT7PDzvNaK4FFhbLWoMU4G/4biN7c3FtAOHq1X3BvEIW5DHJ+zkbEYvGI44A4qSBNm8j2hneCt/eIFFvj3s0NWCqfmq6yCaXp88zxxrLvx714N+srljChhyC4tvszqEHLxebL3STih6DaR8q5zI4CSsOp5dqH9JIgDibdppgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvE0zyml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D15FFC4CEEC;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663654;
	bh=x9n/LL/K3cPgU4HL0+L2IY3Pf8+86E6poCd+Gcg2e6k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WvE0zymlvuKS6atu2Baf+ZcoPqZtX6MF1UmwrgnFcEWHAn7DO54WWcCaS+rZDQRaS
	 vP8ybbHmrOVTH9pRbHI3NJDwFRWVvHJz/ivmOhI85amOUXxt30M/GYccBkKKhwyUkS
	 BCad2eruJHiy+RIAkgbiUn6wJlpSLgbf8zscQKsff6zcUVnGAFIB3qr1Q8PqDrPtbY
	 aqGJguvCK48gk7NPMiULQAEHz9g/epD3okyW7tmQ49OA0NJb8RojFOzYfLT9NpUZQf
	 r6tgb0BI6R/xb4Uczb3gCJ7rZitlJe+PqvTtwEEtGm/6FReD9GQCGJb8aeWLNQSdCF
	 z9gHyLzd/ihgw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9049C19F32;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 27 Feb 2025 19:10:56 +0530
Subject: [PATCH 14/23] dt-bindings: PCI: qcom: Allow MSM8998 to use 8 MSI
 and one 'global' interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-pcie-global-irq-v1-14-2b70a7819d1e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=729;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=A3ZjegB9ymOJbKrwFnz4F34ZFvQLAhzn+iJNxtH6+DY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnwGtgBWAF0xKBJhApgk9zItN9GnKDjS4xgEbv+
 ZNkuR4YM72JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ8BrYAAKCRBVnxHm/pHO
 9d6eB/9CdWyEAxsIM8eMjfdKBkUBzEeNntDzkk6MeHURlbBAtSfdTb4yi6SUTs+40eH9jMPVmHX
 IwUA270qzXi6tJ6uC9IpRrJ5sPboH5NZioSQLvF/sfdtbKkbw1f0s9Vp/FefF4bqAJld4eANZ0j
 RyWrZORIm4hjpKQBIuZG5CZwx6loxfmNRXFWgZ117TERZ/cj4jdKAbql0OGgvjmbVbIi8AtHM0R
 BUSrs2qmOW5SYPPpTDNxjZ/AwFnmg0UpbgbXft00upo4WUol7Mm9Cz8uzL8wF+AuecNIem35xT1
 ngF7sm8zsY93s1T8Nl7ZX9bXYEDf98oo4Gcgw/o9ByajQEx/
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

MSM8998 has 8 MSI SPI and one 'global' interrupt.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 3776dfcd2dca..44b1a6e74c9b 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -587,6 +587,7 @@ allOf:
           contains:
             enum:
               - qcom,pcie-msm8996
+              - qcom,pcie-msm8998
               - qcom,pcie-sdm845
     then:
       oneOf:

-- 
2.25.1



