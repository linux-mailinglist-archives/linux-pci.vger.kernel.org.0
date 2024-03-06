Return-Path: <linux-pci+bounces-4563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49CC873362
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 11:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66111C22FF4
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 10:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF56D5FDB5;
	Wed,  6 Mar 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehZ3et0b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA775F87A;
	Wed,  6 Mar 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719189; cv=none; b=jp9sj4JBxz8+k4tDshqp0x9rMXRwIPFNy0K0YenVhsXZtvIXwseAfXoYIGSuBOOdi/Neq8SHwEQqG9dwIqgtcr0eTEd5JHQ1TSbyUH9fgw/L4+2rYLTrc1Vs8o4JzGOgTY/N7p+HUXllQQksossJXZIt/UvC7J31/VUAc8RCMiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719189; c=relaxed/simple;
	bh=et5lilMWMjndYk7hnjmXvEqmk3WER9uNeffbRsLDvYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsFqsaVCVDP8IEMO8Kl3ww44lclHAKwjv5VorjjnT1LGriJg87K5KrgZ4xfPHvymTegdZqOMn/Oe/8MVXbaFp8IAD1us1k9opBVTTG7GNzvR3Bg2gchyq2S9cUhLkuYTeVuu5N9FeDNVuSgHML1udPYtOyIXnd4IjZqtvPq4YIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehZ3et0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECD1C4160E;
	Wed,  6 Mar 2024 09:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709719189;
	bh=et5lilMWMjndYk7hnjmXvEqmk3WER9uNeffbRsLDvYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ehZ3et0bR95TOoUFbYAJFyp03YgXIS8x7wwBhlHEEnIpo5yj13fCRQvybd8X+Ry/w
	 BTsqp4C/tLq7Pc84jOi2Nlz/Q1IlH5Xbggq9Ym+HfI7acLNY1ru24kwylUcDUPlXhC
	 jH+2ZCZEqE6ZBEnENeXAqjBLXp/F7KRSmZ/hd6duaQPpQD6WJHt1W4IiLtLgUOZMyK
	 PRcD7hZqEZYaRzbmE/tskmF9uoKtkuXPcOVeKGMeeR+BcL/CT+IRq1Q4wZ/b78bgqb
	 lwRCK0ui6VfvnAY/5Y0uhMmD9AX28qssZ0tdoni8i/N4WAB3Bc4R/ODy+YmjYVEBQG
	 XkY/rCtI/FpOQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rho44-000000001b5-3d78;
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
	stable@vger.kernel.org
Subject: [PATCH v4 4/5] arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP
Date: Wed,  6 Mar 2024 10:56:50 +0100
Message-ID: <20240306095651.4551-5-johan+linaro@kernel.org>
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

Add the missing PCIe CX performance level votes to avoid relying on
other drivers (e.g. USB or UFS) to maintain the nominal performance
level required for Gen3 speeds.

Fixes: 813e83157001 ("arm64: dts: qcom: sc8280xp/sa8540p: add PCIe2-4 nodes")
Cc: stable@vger.kernel.org      # 6.2
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 2fc8d3308844..a8279ba6a756 100644
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


