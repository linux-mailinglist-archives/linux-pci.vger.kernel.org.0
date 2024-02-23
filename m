Return-Path: <linux-pci+bounces-3932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FE0861591
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 16:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF99DB24DB4
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 15:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188B9839E3;
	Fri, 23 Feb 2024 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRY9ySyF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF9483A0E;
	Fri, 23 Feb 2024 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701788; cv=none; b=PfhPz7E+32a4rYOWwbD3hzUG+W6bOVqxJKjLUdTcq0zWxw2Q73IA3MIv+GFaQq9LshZ87sR/i3uq5UulrVd7zemSZ9txVEuhiWPoqXIR4m8YVLKAmuUaxm3rgbFXqSK6x0+OjMpIxWbeX78c2r/CJykWms1ePGVxyVTOFDvzFYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701788; c=relaxed/simple;
	bh=jVZUt4YG+wPeP4sDqHFS9RcmoM+nVy3+c7gqaqdvxNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0IccknntARvR2NskJz4pUGpDEBkLptEIyVUS5FwoiXncdd6lsrv9SaD4Z/QL96G6QhTnh2Cm9FW2vwGXBeIQLLW334aIsi8auZUIAvjlERAjpYftkdOOKEje3fqer8x187tWJU4j+wvU7IlYXS0L/0JTzhSNOZEaWqvAQaBVDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRY9ySyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95172C43399;
	Fri, 23 Feb 2024 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708701786;
	bh=jVZUt4YG+wPeP4sDqHFS9RcmoM+nVy3+c7gqaqdvxNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uRY9ySyF+q/Bqrj1OVKddGDpv1hliLUQkBbjGwzajppkTt/imWCpi3zjflQf5Gnf0
	 jZupC3jRkOpAyb74BHUzODkJClItg77QjE/bwy31Q1p3OfkutaE5ftbGDd9BdDuHO7
	 ls4Ildmwurs13GNyzDlMfhIZnM5YDw33oA3h8Lg820WcVCKMntpKVeBJJFGxqhkBSZ
	 GwiQBFT5YVqf9JAPh7lzBJB25tqAhDPAuyLy6uTQR5Tamcv+4p577efVtzmIEatBsp
	 5uRTGdC36/XLYtH3AW2h7LWj4ItppftXlzMzMNoiFDQ7QJwqmTn1VR1Kj/KrrjD/Jj
	 ho/4D6azXpg0Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rdXOJ-000000005Fn-2a69;
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
Subject: [PATCH v2 10/12] arm64: dts: qcom: sc8280xp-x13s: disable ASPM L0s for Wi-Fi
Date: Fri, 23 Feb 2024 16:21:22 +0100
Message-ID: <20240223152124.20042-11-johan+linaro@kernel.org>
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

Enabling ASPM L0s on the Lenovo Thinkpad X13s results in Correctable
Errors (BadTLP, Timeout) when accessing the Wi-Fi controller so disable
it for now.

Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
Cc: stable@vger.kernel.org      # 6.7
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index a67756ada990..70824294108e 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -769,6 +769,7 @@ &pcie3a_phy {
 
 &pcie4 {
 	max-link-speed = <2>;
+	aspm-no-l0s;
 
 	perst-gpios = <&tlmm 141 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 139 GPIO_ACTIVE_LOW>;
-- 
2.43.0


