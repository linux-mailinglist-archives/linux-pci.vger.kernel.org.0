Return-Path: <linux-pci+bounces-22550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A89A47F80
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273043B2F51
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABCA23373D;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gso67Zd6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC670230D14;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663655; cv=none; b=jNPTcQNRSGntuZnMtxdkimtIg/79HT9hSuKIVff7DBo4V71HEzT8+7RXMTRsBOW62lexhSUpr1IMpzPe8xE3w947iKpQMa6hOFhh6b80H4usW3TKoD1GXUVwdOVDgM1rE/dB8lzDk1Uk8KroE5eYlmrtdtrmZD+x0/WC4ji1J7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663655; c=relaxed/simple;
	bh=XTat8UbCOLBjjJ5kMuvixKPFMw1/cWSeyGvtabf1UFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nOvSbhN9UFhn/MgiZ9ZDQJ4GuZXrfDFZ6Yk3dAecRc0p0e28X13INH9NkDQ72VyPxNMYt1pLVPVeGbAbQQHcpJ2Nc2hwkQt/yUNWJxHBHjUtL0ScfT9pGnoTHoY98p7MH3kqcZadXUILJbC8WCN/oW+bGhinO4o+y9dNgmSdIMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gso67Zd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D0F8C19424;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663654;
	bh=XTat8UbCOLBjjJ5kMuvixKPFMw1/cWSeyGvtabf1UFU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Gso67Zd6BeHG2fdmTAKAykIMMTdzwyEEw9/P+O7v6Jyhl55Owq54i2JSUBCAD+Im7
	 3kS6uY2M54VLt0LyumkYX05h6Qw+XJ25Y6QR0xWxl+llnfQVDdgF8JNS7Uglz3ceHu
	 SZwR2OmUFDHnMVQU9g4YaO/018hbT8MLUA7E/GsRIYZCWmzo6YXubRUHFdUT/V4762
	 B6s6MUBYyiJdTO0krW63Ya9a5DLB4l4XUxXftxdccBL957qsVlZDzzM8uKWbrhO2W0
	 xIa9eNMYZzQDhcxMobY0HddyznDioyeLzUtqe6DBUsHmeKZKibU47O6+hBm0YaclTw
	 CWVsuH+YxD30Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86122C19F2E;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 27 Feb 2025 19:10:52 +0530
Subject: [PATCH 10/23] arm64: dts: qcom: sc7280: Add 'global' PCIe
 interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-pcie-global-irq-v1-10-2b70a7819d1e@linaro.org>
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
In-Reply-To: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1231;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=rTVW3NDc0JeWq6yq9e/nkqc0ekGHzOskko7jXo30pow=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnwGtfa2G7HwwBqeR8mHB73A8SCXutjIRdwVCRQ
 sx4mOAhz5CJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ8BrXwAKCRBVnxHm/pHO
 9YsUB/9x6+6qzeRcqWVXMmbtVxEG39zy5osUNg9SvPvDjBT28PybAk3653x+KRa3cYMjOk5Br6X
 XIgkKImmlK1ekXArw3UrP73FADar96FKar9h12GApd78di/LSIoR1TWIzcpbpsBkGisTwsEjeZn
 QGZIgFdEUZ0UkygqGogqyU2BhETAa6rwycHhIqz1Mbs+iTjq8tHas6Fx1TIOaT8LjWgDmKfE+2y
 4rajgXgpEGWAeahJTLNohN8/0q1Kkg2mg+9rsg8MpqmqRE6rSpwV+nbF5jUDUszCkulHx4rZw46
 NOJ501gAQd5mP8Zk6oARwYI31GrqTy7GT9MyRbwukVP9E3GE
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

'global' interrupt is used to receive PCIe controller and link specific
events.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 0f2caf36910b..6cfba0862157 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2225,9 +2225,17 @@ pcie1: pcie@1c08000 {
 				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi0", "msi1", "msi2", "msi3",
-					  "msi4", "msi5", "msi6", "msi7";
+				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7",
+					  "global";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>,

-- 
2.25.1



