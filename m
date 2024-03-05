Return-Path: <linux-pci+bounces-4498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7588717DD
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 09:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3B81F222EC
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 08:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD5F80BFA;
	Tue,  5 Mar 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQFSb6y3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF418061C;
	Tue,  5 Mar 2024 08:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626486; cv=none; b=o92VDLvOv5HlvZvKx4ajygt0NZzNrFYIrxDrSWi2jP7vDu1pTj0EfgaxLCwXC48DfhBB9KYJBEmfOC4B16ItdLSckr7EmXA0PpoD0g9QCEmzqYd1WG3LAqR7o5Yb8u/jFb9cpNKgcC8oaIC+v3QCdIX0gtoDkOPbxOQT4CuQs2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626486; c=relaxed/simple;
	bh=bOVj1Ue9wqeTtzMb+s7vTNCeX2o2j+nx0MuyiNDYpUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUISrI2rR/LtM/rZ4V+aOpUWyg9FPD/rgf3eUUv0JJwNyhF+HQmeC5m+QHhewn5zbCcNDwD3nIh5BG/xrFc3yULMdUVBRwgz3PgHE/+c7+ytllZQAwIKffGQ5UDhQ1muRGNqa+wJrGc4uEXvNIMLktvxlHFzs/Ay7pvjwMAB2fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQFSb6y3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B7DC433B1;
	Tue,  5 Mar 2024 08:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709626485;
	bh=bOVj1Ue9wqeTtzMb+s7vTNCeX2o2j+nx0MuyiNDYpUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kQFSb6y3+Fud40abRadoZrB3xNQf4Ju9tXvkf3ziAPnXcSM2gyHRcJ9/n9QnuYJAq
	 WKRlIAtRlNVTBxYBltyP5XJVR4HO7icMEeJ/GaKT0KiKpIKp4Vcys9PDXciXc8HkGh
	 j8TR1r/NVDufD2QTRRGTXDNklwHUZRPoToZ3hkRiH6pVrioovfTO2pgLQSTnkNhNA/
	 UcP6P5y47eaonS+BiDwmKlZljSVMl9t2Exi3Op/QTlIM/vk6gVHq2g4nl23dz4yj70
	 fZci/Frys8PL6lVe4q9QxXvcNwQAAnjt3cWVOI/Oz3WYRD3G71HXXxfC5bPT8rxcaR
	 ofjtcm7m7KUyA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rhPwq-00000000381-1QPR;
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
Subject: [PATCH v3 07/10] arm64: dts: qcom: sc8280xp-crd: disable ASPM L0s for modem and Wi-Fi
Date: Tue,  5 Mar 2024 09:11:02 +0100
Message-ID: <20240305081105.11912-8-johan+linaro@kernel.org>
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

There are indications that ASPM L0s is not working very well on this
machine so disable it also for the modem and Wi-Fi controllers for now.

This specifically avoids having the modem and Wi-Fi controllers bounce
in an out of L0s when not used (the modem still bounces in and out of
L1) as well as intermittent Correctable errors on the Wi-Fi link when
not used.

Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
Cc: stable@vger.kernel.org      # 6.7
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 7e94a68d5d9f..8fc0380f65a0 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -546,6 +546,8 @@ &pcie2a_phy {
 };
 
 &pcie3a {
+	aspm-no-l0s;
+
 	perst-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
 
@@ -566,6 +568,7 @@ &pcie3a_phy {
 
 &pcie4 {
 	max-link-speed = <2>;
+	aspm-no-l0s;
 
 	perst-gpios = <&tlmm 141 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 139 GPIO_ACTIVE_LOW>;
-- 
2.43.0


