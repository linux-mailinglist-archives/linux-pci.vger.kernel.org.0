Return-Path: <linux-pci+bounces-22563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CA9A47FA1
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2353AC83C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21224237707;
	Thu, 27 Feb 2025 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbZkDQga"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41C6237180;
	Thu, 27 Feb 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663657; cv=none; b=lcuvNDD2o3UuWiaATjvwlHBMEs+7OyfRgIdl5u7Y/cbvG2HLFDfMUm65SixCCp1PpPgYYLAKgBWFKwk3yZrhQJFnharTjq3V2hSLXjn9E59Ao3oHxI50z9p3oA9BLd3NUJsmiP1EAKNsTv0LImIqsBhdY0fgm4S4c0xZljTsbKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663657; c=relaxed/simple;
	bh=IgcOcgMtZRgIi1utN9DnyDm/nhot1//z1vzicHhPess=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fwIzp6GO696z9ftF0Sf2xPWd8QiIDwQ6oYRkRgLyH5G6hl+HmwkVKigczD79t6+IlGWz5owwbFV2+/Hcq8zWU7Czu2nLi6rNBM0995xqASPG7zWau626WePiCp82rW0+B3qrw750xYrSieb5+uJ2vQ5gRPqJv3h9uSZDw2Fk8/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbZkDQga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7746DC4CEFB;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663655;
	bh=IgcOcgMtZRgIi1utN9DnyDm/nhot1//z1vzicHhPess=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WbZkDQgaUSwDSR2KaYGrL6hrAW9MP9cKFFQcYT+iyZ5f1DZvzFXQlBodteryOnn/I
	 0kkfnSCdlpV4XFJX2cin6v74Is7iL/0BcevK8pmhz2fomS0veEi3Czhd5wtW9ruS7O
	 vQJuuJ8V90RRVZhq3OyfPnBgF4V7wkjv6D4FBULr/uVZZRBzIQ53E5jYlZF005xpB6
	 UDoWH88VNksKiMn/UFR1UXstn9vF1PnWncwsBXXRsXFOyqMK4/+AI9qE4BKF5ez39Y
	 AWFd3MlTdOu+iYv+VuqIsCA0w0mJqNGC1JiVbRIdigKQNP9Lzxb3Nb2eWZAONUOyrS
	 SjnxOkMhEQnvw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69822C282C5;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 27 Feb 2025 19:11:04 +0530
Subject: [PATCH 22/23] arm64: dts: qcom: sar2130p: Add 'global' PCIe
 interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-pcie-global-irq-v1-22-2b70a7819d1e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1881;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=7fvWEld892bXh8SDL7oehEVmJi3Lj7hz/k6Pv7KJChI=;
 b=owGbwMvMwMUYOl/w2b+J574ynlZLYkg/kJ00TWb1q2Ih/ZvVa76qvtt2d5XjhItqfMauZczf2
 lfl3F2q3slozMLAyMUgK6bIkr7UWavR4/SNJRHq02EGsTKBTGHg4hSAiVTrcTC0Pj/uWBtQcab7
 68vZ7yRYtGPsVSM7pra4OrowLl//73ZjVG2mYHCVf0jcw+YGfQ19D9cdv02nm1awLb7Jovhm78d
 Ch+ZOxX2sbO59Bm/5zRyVc32MFD9uvJM23ahof+vOHyIbW3k/Kkn73JU0utG/e0V2xmn7hDTx7W
 XH3/A879MJfMkmxMj4JfnGmctHDbP0Pd/WpIQeiDqr8nipavLZa9pR6tWny3q3P3Rp/XBq+2z7p
 1d9H23/ahcvJNoQeit4+4r4gGYWw8Vr5remiSQLby3Jzla8cfz7vcIHs+SjlugZm6dYqNyQZXY0
 3xd3cNbyROnH8k5GiVmxPbvqXudWTKmbF3hplbbHVe//AA==
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
 arch/arm64/boot/dts/qcom/sar2130p.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sar2130p.dtsi b/arch/arm64/boot/dts/qcom/sar2130p.dtsi
index dd832e6816be..6b6a7ae7c22a 100644
--- a/arch/arm64/boot/dts/qcom/sar2130p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sar2130p.dtsi
@@ -1288,7 +1288,8 @@ pcie0: pcie@1c00000 {
 				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi0",
 					  "msi1",
 					  "msi2",
@@ -1296,7 +1297,8 @@ pcie0: pcie@1c00000 {
 					  "msi4",
 					  "msi5",
 					  "msi6",
-					  "msi7";
+					  "msi7",
+					  "global";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
@@ -1405,7 +1407,8 @@ pcie1: pcie@1c08000 {
 				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi0",
 					  "msi1",
 					  "msi2",
@@ -1413,7 +1416,8 @@ pcie1: pcie@1c08000 {
 					  "msi4",
 					  "msi5",
 					  "msi6",
-					  "msi7";
+					  "msi7",
+					  "global";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */

-- 
2.25.1



