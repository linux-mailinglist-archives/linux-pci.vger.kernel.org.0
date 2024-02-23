Return-Path: <linux-pci+bounces-3929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CF986157C
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 16:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9771C23EFB
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 15:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6439B84A33;
	Fri, 23 Feb 2024 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXTUmzaX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7A0839EC;
	Fri, 23 Feb 2024 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701787; cv=none; b=nK2b6Duu4Jier3vGZRlkgCSP0cOVEn/1Ia3xkMT0Zt0/pMKg7/z7rHZV2DyoHmFy//4endgYJ3LDgQJN6ckQ9V1NsEoJovXXOnXzQtlXymXW2oilOyoKDLWZDtrrxdQeYQ+pFLXpMNtD/T7RkrdR3rSl0YLF/IUSqMD2GVht074=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701787; c=relaxed/simple;
	bh=hKdAU8xGeWoBEDF62SIFZ8ycEZqo56n2cRdtQJsOYWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGdwhzOJJ/YuvjpGuQvOGzzkOjUatnLZjGMnr55zWUnhG908YdOyd1WO1pja3CbSw98DIOvSKGrZ5Yv0kDQM0owyCWIxp8O+r3KW8zqTXRlAXFzCvQVLcLZKQuWavGCz8eaQKqG0WPaMV7IixcQI/+shaNeoOHV4BZMZDCHOpOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXTUmzaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852CBC43390;
	Fri, 23 Feb 2024 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708701786;
	bh=hKdAU8xGeWoBEDF62SIFZ8ycEZqo56n2cRdtQJsOYWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cXTUmzaXMkILnO7RQP11RNpxQxwSqANnovUfeLsNj/+qwgrEIDdtEsiEC3SBLJa7D
	 zCN57TEjBeF7KkzYGum7kYT5t2cEST8NtvRFz3IdjwHCb1jbmhNgPEVhn32aZCYdq1
	 kq56BfhR7wynQ1vQpmCypa7P3SnCbmH+t3PEFPH0YVnMEhBmEKM+NG0OKKXDpfRyoB
	 7o4YCezeFA6Un2PCF99Yuw3zoq6IT5SS2rEwrAm/06o/BOAXpgj6D2f+Sy0bofGHGP
	 adGEbKQnBfZjcXtf7GhjbB4Vwjz1N4KBAYkUbuXEiNZF3uM2U4V/zfvhjgF6WfwAHB
	 oIxUTvAjG3SFw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rdXOJ-000000005Ff-1Da7;
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
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 06/12] arm64: dts: qcom: sc8280xp-crd: limit pcie4 link speed
Date: Fri, 23 Feb 2024 16:21:18 +0100
Message-ID: <20240223152124.20042-7-johan+linaro@kernel.org>
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

Limit the WiFi PCIe link speed to Gen2 speed (500 MB/s), which is the
speed that Windows uses.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index ffc4406422ae..41215567b3ae 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -563,6 +563,8 @@ &pcie3a_phy {
 };
 
 &pcie4 {
+	max-link-speed = <2>;
+
 	perst-gpios = <&tlmm 141 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 139 GPIO_ACTIVE_LOW>;
 
-- 
2.43.0


