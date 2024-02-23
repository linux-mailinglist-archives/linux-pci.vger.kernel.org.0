Return-Path: <linux-pci+bounces-3936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE8A8615A3
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 16:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2FC4B2497F
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 15:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0278A82880;
	Fri, 23 Feb 2024 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOvQbWkD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271788288A;
	Fri, 23 Feb 2024 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701789; cv=none; b=fLt0eeRFhyWL6okvqf+x8tEEPxALMJl833mYOFR03MpwRjVuvH2XUqt5F3/fm2asleScPQ0+Yy0fAK7tHw+BBDYi5G7/fXPXME5JCJtPfUH/f46AcWdUJ2Chj0GeeKrsN00LBzrqUwA/emGJL8+3tPeIhyxd2MbbUq11bejFt5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701789; c=relaxed/simple;
	bh=CrZ5ilwQu4dqM9fOfVslL0lVToxLm2aDUIvFF2TgBD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4NuPQ19IIF8P/Cr6s8B09hDVkMqrDoDhJJk2ZrgqByh5vD0jde5uYsXor4bBxGks0UARS/Dwz2LvIBpHfdVH69d6iYFVdLTHZ6YkSl2ld3sBnlo2EDTNIq5E+z6Ptqoq234OLTyXJqt92iKMFAiQDm2aERnWsyldNmWgm0nLOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOvQbWkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A192DC43141;
	Fri, 23 Feb 2024 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708701786;
	bh=CrZ5ilwQu4dqM9fOfVslL0lVToxLm2aDUIvFF2TgBD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gOvQbWkDRnfkrzZuP2H2k7hnyQfaBAfjbnY8Kc6FcUaAA+StKmWwvUHaCKr5LoRzy
	 EVmK6oz5NpmMom+vxhAhKxmFE1P23Z2zvWndfXUuGWrq3uwibD0igZDeqBUZO33w75
	 4ais53pwKx+xXyT4gc8mcKwIf4tjym4sv0E0Dkv2ufGjup2thhi4HwBWE241Vif/4N
	 LgdEhOTWlLxAH3atanshZYLIUCinr9KN6PDpsRvAez0HHjmxAYFemvRWkZJkSMt4xA
	 l9ucolIypeabofmj8tspxb+Da+dGW5dockGI7mIeS5uYdTWAGjI0KZVKkUfZqUd5YQ
	 LyyfMQBlLr8cA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rdXOJ-000000005Fl-29ue;
	Fri, 23 Feb 2024 16:23:11 +0100
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
Subject: [PATCH v2 09/12] arm64: dts: qcom: sc8280xp-crd: disable ASPM L0s for modem and Wi-Fi
Date: Fri, 23 Feb 2024 16:21:21 +0100
Message-ID: <20240223152124.20042-10-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223152124.20042-1-johan+linaro@kernel.org>
References: <20240223152124.20042-1-johan+linaro@kernel.org>
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


