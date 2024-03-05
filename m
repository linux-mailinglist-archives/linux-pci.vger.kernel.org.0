Return-Path: <linux-pci+bounces-4502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCDD8717F3
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 09:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B51280FBA
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 08:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E8A81AAD;
	Tue,  5 Mar 2024 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcoOjbjL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4C98062F;
	Tue,  5 Mar 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626486; cv=none; b=WDAm+gYgGhO3oKVlhTaKnxiWLsmU9exnZSHfvX0YzWMqJxJqD80TrDlLNdrvMl7htmBESLFOrLyh/mCQrdbjyMhANUOQW5zPdffjs1CltkyJsivgVV3IjoUCNZLKzDKTSlDuJ1Xspn5aRg74W3KfSBnue7nvgYqKEbmd2eeNnFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626486; c=relaxed/simple;
	bh=OJHWjk4Xm5Pt54cy7lIhhGCkWvJvBeW3Z7MBRZ4L81c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gye7EEl17zx1SmocmNAz0Jq382Yah8qDbPBBZwuzHPk8bD8fEIMhpVZm7/ql+4nI53ifcjGpMjIW/+R9yK4JRq3vpDCch1oGo+1dcmSNIbLudX3lXpqT3eUszciwbPEkR3p5HBV93PqxCKW+i9zae5ZNjfP6/NYfoldX1b/T+SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcoOjbjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8996C43330;
	Tue,  5 Mar 2024 08:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709626485;
	bh=OJHWjk4Xm5Pt54cy7lIhhGCkWvJvBeW3Z7MBRZ4L81c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dcoOjbjLKivx6csYxxcB0bZY3VDVvpXOc9+Im43l9NbUZvfjBPD5lymo+2o+sdRTZ
	 jYM5QOdZ8HWEs9MDWk9R0VfYYMnVXFA9K/62D/aguz0SYUi4vALumoqXe3YC+2EqGV
	 gwG0XQGLmTkwim3B4hERpo74J4I/l8XTV9AX6M8KY3vyTt3+IJivk3L9NyODu0KIYK
	 9ztuEowuGulqzmyEWv4ESf1k+O2zeKW+H/4wAgZm0VfPTFEllAsKCWKHPjNkM3dBV9
	 S+fkP86UY5mLtVdVyavKmSHLX+ejEwCdBDa05VCNBFVQvoSoRAEffLlQ2w4K1+31yZ
	 DWPjXat1PyTCA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rhPwq-0000000037x-0gOM;
	Tue, 05 Mar 2024 09:14:52 +0100
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
Subject: [PATCH v3 05/10] arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP
Date: Tue,  5 Mar 2024 09:11:00 +0100
Message-ID: <20240305081105.11912-6-johan+linaro@kernel.org>
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
index c8e84c53935c..424d143ee26a 100644
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


