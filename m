Return-Path: <linux-pci+bounces-3350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67179851A0F
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 17:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24321280A07
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 16:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A21A3D0D0;
	Mon, 12 Feb 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFI5Baa4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A9D3D39F;
	Mon, 12 Feb 2024 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756819; cv=none; b=fwuHpYyKazjftVYW7clq+JHfnHLgYmX9PCkBS5mUBelOC3WXOEIspVnKWvjhaABxS3jfOInEsaJVhKNQe5neNFt6v8M4SFmt7gqRFO0qU8kJNXNZWSedoW/c1qlR3dA8Q1u0nqCq7p7S6HThah/UcFKDNoUanJVbgs9urPyJ0FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756819; c=relaxed/simple;
	bh=vk+Lt5I2JfW5rauqD9RI4ZcRRxFOCwrY7DdoHCOyR8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xzp80FPJMtFQdEYdxQwtCYENiHSKJc584kJRqHMCtdd1dzEHHbC3pUex7Nx2StQgilZVitn2TWWnqi69puR8pwD3ABlEDzXf3Raw9kslT2GE0zZlu3uUeHlhoncsPmsgpurhwEMB9QmfCxYDQuV7vN4Vymjt5CIOxOSsT0JqIfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFI5Baa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA0DC433B1;
	Mon, 12 Feb 2024 16:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707756818;
	bh=vk+Lt5I2JfW5rauqD9RI4ZcRRxFOCwrY7DdoHCOyR8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kFI5Baa47zDEkpiFIS+is9qV7PpYX7LBgeSj8eFnmELiHBK4oOOFLZe6uIRYPyBcl
	 57uA+HZ3iEbEEJ1Ns03MItwhGmiU3ySRcTsjiUKSLwAYmaQpABdds7j4kyW8IQVgkj
	 bSdOta3yIMNyykDASx8gYDSHf88hIQ2HcBPufi5lJ5iIh2e7iQF30W7GB+0zmYbzfp
	 W7Vqbg0oqM2yxNvVXsgiysSEt3Us24ynKTYcnhKGhtDG8J0vc030TWkvNBVsMoZpOh
	 40fUWUb/1Tf2VNcO+OEZzLqVW1F7Z2JO3A+fB3zewCFIeIrvgJfHMZET3tk7kd0aLb
	 SnTK1bjvPJ9Qw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rZZZ2-000000007N3-282y;
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
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 03/10] arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP
Date: Mon, 12 Feb 2024 17:50:36 +0100
Message-ID: <20240212165043.26961-4-johan+linaro@kernel.org>
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

Add the missing PCIe CX performance level votes to avoid relying on
other drivers (e.g. USB or UFS) to maintain the nominal performance
level required for Gen3 speeds.

Fixes: 813e83157001 ("arm64: dts: qcom: sc8280xp/sa8540p: add PCIe2-4 nodes")
Cc: stable@vger.kernel.org      # 6.2
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index ae41b3051819..36382b1bd965 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1780,6 +1780,7 @@ pcie4: pcie@1c00000 {
 			reset-names = "pci";
 
 			power-domains = <&gcc PCIE_4_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
 
 			phys = <&pcie4_phy>;
 			phy-names = "pciephy";
@@ -1878,6 +1879,7 @@ pcie3b: pcie@1c08000 {
 			reset-names = "pci";
 
 			power-domains = <&gcc PCIE_3B_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
 
 			phys = <&pcie3b_phy>;
 			phy-names = "pciephy";
@@ -1976,6 +1978,7 @@ pcie3a: pcie@1c10000 {
 			reset-names = "pci";
 
 			power-domains = <&gcc PCIE_3A_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
 
 			phys = <&pcie3a_phy>;
 			phy-names = "pciephy";
@@ -2077,6 +2080,7 @@ pcie2b: pcie@1c18000 {
 			reset-names = "pci";
 
 			power-domains = <&gcc PCIE_2B_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
 
 			phys = <&pcie2b_phy>;
 			phy-names = "pciephy";
@@ -2175,6 +2179,7 @@ pcie2a: pcie@1c20000 {
 			reset-names = "pci";
 
 			power-domains = <&gcc PCIE_2A_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
 
 			phys = <&pcie2a_phy>;
 			phy-names = "pciephy";
-- 
2.43.0


