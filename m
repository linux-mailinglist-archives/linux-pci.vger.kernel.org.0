Return-Path: <linux-pci+bounces-3353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369F9851A18
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 17:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E87280E93
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 16:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B15B3D578;
	Mon, 12 Feb 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHZlh1Vz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B103D3A8;
	Mon, 12 Feb 2024 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756819; cv=none; b=DSPDbv/osGyaFEtXwpl8mm5Do7eKkksxaEnBbx8MY7tcR4QTkIDfi/Ubu/PRkUr2/nBAsP/bwpgDHwp+tHKLBobsoQ6aU7KbOULwtt12s2MpuZxiPCATRLLODPvkoUIYfT/6A0k30UFDtYkJYNXEgTd45PVUocTjjiDYveRv4MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756819; c=relaxed/simple;
	bh=52V8VIBZ6Aa9byRanT+AhHOKtM3PttwSwaL5Jh235Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQVsSAFQo+ur65RE7ayKQAv5tS5/P4OeQAOTjtJ0Eszh2bknkLAN1sGkO6L8qxMv+Fus7S5OdoxwyXw/Lc5zvDKYsZkhSADpnBVe4shr4wYezMGYf3yZo20fMx6zbtRpIl0kryADaIvLWpHUfao3Sm86vByXRwfBj0sqdtkmyUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHZlh1Vz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F34EC433F1;
	Mon, 12 Feb 2024 16:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707756818;
	bh=52V8VIBZ6Aa9byRanT+AhHOKtM3PttwSwaL5Jh235Ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DHZlh1VzVUm+VRt1myKtgo3wHiiHaxhk32t7JnMbWdCainbIcl+pQsRJnMuI4rSiU
	 OAZh0osLEpPBdP4csdJyFjT4niZARt5zCXz4l+q1tIftgTFGKWyJtNjTW7/Kxz0CIk
	 I2/Cz5aB7KQcawEUxbePuzGOe2lvXMpasBQNGaQUh+IFDTPzIXIbtJcUIxIPRcNZqm
	 RzLANQTh45BhFaw/H/jb8WclJionZ9njZI9BEt1535qFQA8qm6FeqSYOPmvLFDxTHZ
	 uqNHthowf632JN0sLPmY1j7wcxEIa79XKBJ26fRK7As0ed5vlhQ4xtbFEVEfrCoxWb
	 nrbivMPGoCqww==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rZZZ2-000000007N5-2R4q;
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
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 04/10] arm64: dts: qcom: sc8280xp-crd: limit pcie4 link speed
Date: Mon, 12 Feb 2024 17:50:37 +0100
Message-ID: <20240212165043.26961-5-johan+linaro@kernel.org>
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

Limit the WiFi PCIe link speed to Gen2 speed (500 GB/s), which is the
speed that Windows uses.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index f34c572253f5..8c1fccf8847a 100644
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


