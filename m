Return-Path: <linux-pci+bounces-10290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF64293199C
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 19:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832BD1F2397E
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 17:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADCD13A412;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdkYlrCw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDB38528F;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064830; cv=none; b=pu6rVq6xU/rXTkhdz5FO5uwpYZ5ddfdhESXPzhfJd/rpAE77CZUnk0Z7uz0B9TxHKVIb75KMLQ2tyyRiOKzn0f9s8d3KI8wz1kfWU1YzPfvc9wPNRnCp17TgmowXPm3yB6BkDrY5oTzmYmgWXiOmzQgWQ7qcE/B0KP88pWf+B4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064830; c=relaxed/simple;
	bh=2kFP+bCixJC5hqYNUKgrr+OyZBFt6Z2SRVepHHGhk7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V+dXQWts5LVl48LtSCWu4lMpqpRC2eHyqq5H8EQ0GH0zyEtvrVlWyKBKcNvDW09q0iXjs6zKW2DMVydWXlufTEoC6fQez7qpbcec42lc2VvtKwBX3BZoW1A9TF0rY0/cDx0wvKJiczVR7q+3Qj++iwimm+DM4Oz4D1kykF5RVy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdkYlrCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55BA7C4DE0D;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064830;
	bh=2kFP+bCixJC5hqYNUKgrr+OyZBFt6Z2SRVepHHGhk7w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qdkYlrCwtSFUJC9ZJszIIbObJkcdGSkfQwpJ7/80dapQsO6O+uD3nYiDn0VHOLl1q
	 Q5Vix4ZfHiNboEpxWkDFLz/qPTt+YckjPj1HMVlSEeEmk15creJo5d+7wg7ba3INbd
	 33UvqaD6Fxhb1DIQYKWTN2Izv/AUxZRk2IR8d2YWt+73fVluo/BwKCVinhfAZeU63c
	 LYch3u7NAJmRMm+0d7/ZbS3/7f0P7bQivcyYbQTH2xN6/ZjRuuH9raIMPWalcLABtv
	 q+AafLHVo4kNTd+GZMrFQ4AJcOKdxTDEaOG59KVkKF6H5KFf8WGSrlU1FAfexPfPgO
	 hlambGgdUYdlQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D0FC3DA59;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Mon, 15 Jul 2024 23:03:56 +0530
Subject: [PATCH 14/14] arm64: dts: qcom: sm8450: Add 'global' interrupt to
 the PCIe RC node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-pci-qcom-hotplug-v1-14-5f3765cc873a@linaro.org>
References: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
In-Reply-To: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2237;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=gNxsaYyTdguve7w+Y8w7ph9rzM45Fb14SQIqKjXqzUk=;
 b=owGbwMvMwMUYOl/w2b+J574ynlZLYkibGlsd3Gj04rNd09RrIryyaw6cU5eY9bfz5ialA+ovz
 lRdvH2LvZPRmIWBkYtBVkyRJX2ps1ajx+kbSyLUp8MMYmUCmcLAxSkAFznC/r+ePWP2j8B7p3wk
 PzIz1LC/Xi9r7d5W8cTtt2fkowOvbjN+ff98NePf7fbPls/k+8bYGCtsMOXYshu6sl+L0wrCvKz
 CVG0/KYVFhkgdLWXf5iERxvt2mYXe3INmfCVFwlNiL4otsYuvNvVdWZb47/JGB0d+4dJt7QtiTv
 qq2yjdWWrsFOZvGSJ3+nHM9nQL78+dJwp0+7vLL093z/e3mKJ645ri0qnny4JLJtp8dZgwkVudf
 b7MvNrPl6oPVFyctifC3e9agEpIQVPeYzHfyLCyGt8vt39X8rqfVT92ZKczy5KyF6fT6+eZnllz
 fdd8y5sPYtz0Szx/9d8tOLLKtJY1P8er33DezpkeHbPbAQ==
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
to the host CPUs. This interrupt can be used by the device driver to
identify events such as PCIe link specific events, safety events, etc...

Hence, add it to the PCIe RC node along with the existing MSI interrupts.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 9bafb3b350ff..90d16cb83669 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1780,7 +1780,8 @@ pcie0: pcie@1c00000 {
 			msi-map = <0x0 &gic_its 0x5980 0x1>,
 				  <0x100 &gic_its 0x5981 0x1>;
 			msi-map-mask = <0xff00>;
-			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
@@ -1788,7 +1789,8 @@ pcie0: pcie@1c00000 {
 				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi0",
+			interrupt-names = "global",
+					  "msi0",
 					  "msi1",
 					  "msi2",
 					  "msi3",
@@ -1942,7 +1944,8 @@ pcie1: pcie@1c08000 {
 			msi-map = <0x0 &gic_its 0x5a00 0x1>,
 				  <0x100 &gic_its 0x5a01 0x1>;
 			msi-map-mask = <0xff00>;
-			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
@@ -1950,7 +1953,8 @@ pcie1: pcie@1c08000 {
 				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi0",
+			interrupt-names = "global",
+					  "msi0",
 					  "msi1",
 					  "msi2",
 					  "msi3",

-- 
2.25.1



