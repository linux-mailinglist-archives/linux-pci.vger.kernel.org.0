Return-Path: <linux-pci+bounces-3358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BF6851A36
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 17:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9591F24174
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 16:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062673F8ED;
	Mon, 12 Feb 2024 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QazmYjNS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFF33D565;
	Mon, 12 Feb 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756819; cv=none; b=T3bscHW8rqqFPhxNmbfhbad/8/0avyLV4Dumv2AZ16xD4O+oZkRbeND1N3hNZtxKTUfzPjchfHtIhQpIbBi8ZQs/WYkdrurD6Jhu5/EMFofJCp80QxbvwvFjAIzkfnoF2p3DMU2Ffaiy3T/TQiFyw98a43HnUHcmV3jC09pXsGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756819; c=relaxed/simple;
	bh=mFlQy5tvAhpclwFJjCDguvWh8qyMMwHvkbQ54iBIAmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2KuGIf8VnS+3eu1CLT1yd6fP4Z/4wB/y8HSbEhLvZKz0vkXKyjVOjeG8GX0BR8Sw+XpmmGqgGSw6TXkO8uLqRChIqUP7d1aJT5ms5GHKRxTMCYMGY9sda5A4iAfBbCUc2XpIC/61802pIq3Fc6/hNSwtRvzkNahgtObwchmKas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QazmYjNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1915C43394;
	Mon, 12 Feb 2024 16:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707756818;
	bh=mFlQy5tvAhpclwFJjCDguvWh8qyMMwHvkbQ54iBIAmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QazmYjNSyuroI/MJ8mMKecXHVW5sxOkWkFowEUaf8GAOZB+a9A050hSJnzs2a11eI
	 IJbeObTk2s8AqG8fQC3tBleFxU2HldiJzT/XbYZU+n4mmc/iNiO+lA6u6bRyNLLwxF
	 pPQFzowW2rK+LM/PWFyNHWzeBkQbjU5jumldM+TxJXnSo1/vMqJDIsPsFOnquPneLE
	 CFiuelrBWXjfaTdPXAaKo/HOenF46p0KRRBe7wPmd4jlYKhtvJ3OKfaMIdg9NZPwUC
	 unUw2Gd+4A4yutjXN+LT13lpw+tk+i8zIbgbpAZwlly0EqTb3izU7gbV7NkRMUcR0y
	 b9TR7sW40xLYQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rZZZ2-000000007N7-2kAz;
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
Subject: [PATCH 05/10] arm64: dts: qcom: sc8280xp-x13s: limit pcie4 link speed
Date: Mon, 12 Feb 2024 17:50:38 +0100
Message-ID: <20240212165043.26961-6-johan+linaro@kernel.org>
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
speed that the boot firmware has brought up the link at (and that
Windows uses).

This is specifically needed to avoid a large amount of link errors when
restarting the link during boot (but which are currently not reported).

This may potentially also help with intermittent failures to download
the ath11k firmware during boot which can be seen when there is a
longer delay between restarting the link and loading the WiFi driver
(e.g. when using full disk encryption).

Fixes: 123b30a75623 ("arm64: dts: qcom: sc8280xp-x13s: enable WiFi controller")
Cc: stable@vger.kernel.org      # 6.2
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 511d53d9c5a1..ff4b896b1bbf 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -863,6 +863,8 @@ &pcie3a_phy {
 };
 
 &pcie4 {
+	max-link-speed = <2>;
+
 	perst-gpios = <&tlmm 141 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 139 GPIO_ACTIVE_LOW>;
 
-- 
2.43.0


