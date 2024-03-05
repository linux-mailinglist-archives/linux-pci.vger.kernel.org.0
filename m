Return-Path: <linux-pci+bounces-4501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112298717F4
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 09:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434DD1C20A80
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 08:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0918A81AAE;
	Tue,  5 Mar 2024 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMwah7VV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7296580C02;
	Tue,  5 Mar 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626486; cv=none; b=IYqK1aICkTQK3Y+Phapf2NxEmj5smtQSILFLTmEt50KPKCEvNo4fJ4j5RZ4+xrtMHqXoyVcYn8G94zzJUE3vjRjmerwVrDBzf2Bq3a5KQN6YfEZxyaS5p+4EKVCOuuactILftp4M+98jT50ZtHrrJ3ztCCcvMxZgRd4d6hJnFJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626486; c=relaxed/simple;
	bh=YyzJd5EjL4gnLemAYI0eCwc4e5Q6VYtrbvPZbBch1h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KttUUCcj8DUWoKmkMQ1eKCO3wL7R6QSLFC3K+ZNpudiDC0wv/dp5i9C06VJemDGPGyL6s7ySl6XHAeAd+r9s15COOrJ3wE+KwMI+9Y+0y8i1mhlg9FDGaHHnOlXpu5y/fbsmVjed2wp6HSAt+GUEFE4kDJmiZ2cYVhSfntymC3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMwah7VV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B890DC43141;
	Tue,  5 Mar 2024 08:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709626485;
	bh=YyzJd5EjL4gnLemAYI0eCwc4e5Q6VYtrbvPZbBch1h4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YMwah7VV7xvdtDONagk+i+LRvS5xXjX+HSCVwJElg938vGn5PTNe0nqWlOYx3KZip
	 76lj9PorAWeImUQficLJ2396rQaCNtd9gkzsQwpyxwxMRPcktxADS/mmQhG05dp278
	 rKICEpi888tvCfsVpYZRYRAleTt7flDkI6oFqviGDqeaNVYhsbf4ost9KMnbw5GBEc
	 njiV1dwzcCT8/MzBLc3EvF5KZolrIiNINMsx65XfknQgAxzZc28MjTbszIm6foTvx8
	 YJjfyyBhP6OUBI7mOnlhgKtlu/FpOokQeIX1mwL2jKpIVZk1wZqxDmTBpOqgZg389w
	 F6m2V21PNIAMg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rhPwq-00000000385-2A4L;
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
Subject: [PATCH v3 09/10] arm64: dts: qcom: sc8280xp-x13s: disable ASPM L0s for NVMe and modem
Date: Tue,  5 Mar 2024 09:11:04 +0100
Message-ID: <20240305081105.11912-10-johan+linaro@kernel.org>
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
machine so disable it also for the NVMe and modem controllers for now.

Note that this is done as a precaution based on problems with the Wi-Fi
on the X13s as well as the NVMe, modem and Wi-Fi on the sc8280xp-crd
reference design (the NVMe controller on my X13s does not support L0s
and the machine lacks a modem).

Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
Cc: stable@vger.kernel.org      # 6.7
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 9567b82db9a5..057e4d9d3c0f 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -695,6 +695,8 @@ keyboard@68 {
 };
 
 &pcie2a {
+	aspm-no-l0s;
+
 	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
 
@@ -714,6 +716,8 @@ &pcie2a_phy {
 };
 
 &pcie3a {
+	aspm-no-l0s;
+
 	perst-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
 
-- 
2.43.0


