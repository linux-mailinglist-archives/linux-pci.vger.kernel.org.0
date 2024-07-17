Return-Path: <linux-pci+bounces-10448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5797934106
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 19:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130501C21BF6
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 17:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9501849D5;
	Wed, 17 Jul 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OobH63Br"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C87018306E;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235795; cv=none; b=MmK8FJNUm4m7iryb/H5x6VbbO6IuxHdy015t6T4E5pcUJcFjte8azrmmd+RSOfAZzzxRQDaCQDHh/IMIl3Ifemn/y1TokDuCP40MXa4mvixhStxyqK/29uVGIEpK7uaM29iw70D0cNuvVNIAKeUdHK8uEaPwcrcU1tg1JubZlCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235795; c=relaxed/simple;
	bh=9SpPkeVArnB3rJ4nPZ0WPdvcC8ctAG/YXTHNpaqeYTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VIeyRCQkclH2mUPkaR4i5657Z4ya9A/NO1SReiZMd+QD4XyKyU+GB1LuTUeV2XaNlgjlu8kmJ/tABLHIIRWfi3lfgPwa6phViMiYOeXIj0EjwQ36CAPB1333Ekjf30AAEjD2WCsUD7CpoCQI31VuuTGzvLdwN0zZUb3KTWdWXLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OobH63Br; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E999C4AF1A;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721235795;
	bh=9SpPkeVArnB3rJ4nPZ0WPdvcC8ctAG/YXTHNpaqeYTk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OobH63Brw5e3Wl00GuzcRP2jf+t3XLCUngEkFnINvwfybj6SyL81DSLEUjsHboTeD
	 rnYSeSP7DWb01ej/VkNuPz1UA2tPDCsnBAQ+qa9l/ndtNYkaBv/2PipNSrvmEalpWR
	 TReq7ReTvp9nQebNaCvVnocYWtoOXGvEemi7QXUI4C807+8cqA0RQy4iqqs9xgN/2D
	 CDt9wRFYtQKQqNo26NOYxk+jtoSyHFFjhf1gfmBLW5M/rZ28Dakc43yYVhJINaaewA
	 zFF7eDzXqGl177+jE4X5uZajrlpJWMZ6aa8ki1ADUIlpQ7DKB6mM3L3HCCaTRHCsKu
	 KMY9XKc39cGBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCC4C3DA63;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 17 Jul 2024 22:33:14 +0530
Subject: [PATCH v2 09/13] arm64: dts: qcom: sa8775p: Add 'linux,pci-domain'
 to PCIe EP controller nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-pci-qcom-hotplug-v2-9-71d304b817f8@linaro.org>
References: <20240717-pci-qcom-hotplug-v2-0-71d304b817f8@linaro.org>
In-Reply-To: <20240717-pci-qcom-hotplug-v2-0-71d304b817f8@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1289;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=YKSy5vPklQvLJA99UbdPy4mFyoiPQChYvArhByAGkpA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBml/lO0Dmif7USBFz5hYoCiza5W/fd8O+FngHr/
 24+q3osoLiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpf5TgAKCRBVnxHm/pHO
 9awtB/4kSxxPulCuNa6RgrOTzuAeI/hkw6WQQ97HhrEZToQEkUZvp8WMGZ2aQIHLxS2xYUQxE5R
 EdJWwjl83+26qlrhNwwR60/fltegr6Wyb4g3dhiRBrYGav0cCt7hSwbEatBc5axOyxNNwf80eg3
 y4xM9rVaSJICwe8FTw+d4oYXWwcS6HdAR9W8PJpcVI/iFGOr7Dtia2yH1XKywUNyVAdS/JynHxV
 nQfS2SIHXiCs3b2v6xYBx1NBgGVcKZoh7CM1u0bWJkaY4s+QlWL1QMJEK1JkLAzstaWYk/W2lth
 pQLivgbf7hZuXjpGbCnm8+FbHBu0Gd3uSXy1T4cSCTa33tsV
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

'linux,pci-domain' property provides the PCI domain number for the PCI
endpoint controllers in a SoC. If this property is not present, then an
unstable (across boots) unique number will be assigned.

Use this property to specify the domain number based on the actual hardware
instance of the PCI endpoint controllers in SA8775P SoC.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 23f1b2e5e624..198b39abde97 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -4618,6 +4618,7 @@ pcie0_ep: pcie-ep@1c00000 {
 		phy-names = "pciephy";
 		max-link-speed = <3>; /* FIXME: Limiting the Gen speed due to stability issues */
 		num-lanes = <2>;
+		linux,pci-domain = <0>;
 
 		status = "disabled";
 	};
@@ -4775,6 +4776,7 @@ pcie1_ep: pcie-ep@1c10000 {
 		phy-names = "pciephy";
 		max-link-speed = <3>; /* FIXME: Limiting the Gen speed due to stability issues */
 		num-lanes = <4>;
+		linux,pci-domain = <1>;
 
 		status = "disabled";
 	};

-- 
2.25.1



