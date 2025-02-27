Return-Path: <linux-pci+bounces-22564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8FEA47F92
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AC8D7A3BE8
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D7A238157;
	Thu, 27 Feb 2025 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Le5gHyEq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE812376F5;
	Thu, 27 Feb 2025 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663657; cv=none; b=dh+9wrAmVdXhIzrIc4ATCI2uObxT7Xc5kYHHYzltmuhPfHHi3p/+ONAo6zRxRMQeLCq2RQnft/+JhtEEfSsFYYgclpn+fiYgmeZmUHuSKeKq+D9cLAcSub8gKpmZq+rvMzsxG3dQOT56jiLxZvNZsMdKiT/LCmYvJZ3rImLoY04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663657; c=relaxed/simple;
	bh=s36GOsQlI5Bxg0X5/RvjyGg6LyV0xa3Y39vcYmt7bB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uMOb2OjydFJPx69SbPh9H0F15AtGOrraVD2JdkYXIVqZnefGe9HDcmzkz1Rjh53/rAkv2okfno8rw0m+oF+f0mvv5Zz7D9cw4j/YWCtd0XSjEv5jBZnH2HkJooSaHyRAsNBcSY3qr2dgM3sDCEaiROov0Om+wc04hpz57tAN66U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Le5gHyEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DFB2C4DE0E;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663655;
	bh=s36GOsQlI5Bxg0X5/RvjyGg6LyV0xa3Y39vcYmt7bB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Le5gHyEqExZjEKmxgLZ0UDPjVWyP7e12I4i7+3nrIycqHUJTjuoDM9TcEs17wmlUn
	 CSpeHSlYdCkUe8HfhLli/fohKxVmeZShJJ0paXl0jc7XWez1vSkAvjsoiGUvEaMQAJ
	 XfMTpDDG3h+Zo24yltyzzcZ+1hY5G1qGpx0Ti+dDFgQA1orrV+YYRzin4hJejVhOjU
	 Su5YZ7Ykjv3mSGWmJmHpmXxKKLMBZ5AlhZAPI+H6qFC5Xd34f1ZCLZjMnPzDjaewcd
	 5MyH1a9A3qBZ+dl3EEXjpOPdEXiivMV4b9uSIClh6ZfDAGfuianKLWhfEj5MCs8BmT
	 MNVl/qD1qftVw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778ABC19F32;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 27 Feb 2025 19:11:05 +0530
Subject: [PATCH 23/23] arm64: dts: qcom: x1e80100: Add missing 'global'
 PCIe interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-pcie-global-irq-v1-23-2b70a7819d1e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2331;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=D+b9sJdvKhFSUCftBjhpfmmmILsMj4McEC3OdoOVoxc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnwGtiqVZNe1xC6tTLX7QsrP7cApoKwQC3cixH9
 89ms7ZhdnKJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ8BrYgAKCRBVnxHm/pHO
 9eyVB/4pXp/Y8V0U4S2uZSPb8oYmVLDF+X1mBwCW9GwMn7YMBk8trEwDd+2zGUyf9g3akusCuEj
 TmdT0RTW59JmJKVhQSjIJFSldBp8DY7EfcADKkaOq+eQfgrMhtTLmIkQQSY78mG2/fxB1fEVtOd
 IptrKO0e/vfyHv6Y6JyIBl+fRi6v9yjAp6bRpwtPJOPRwFu1Z7sAkvaqu98rka/0YyMltPjMPRA
 8ursC+cogA+rQFN76isBjAALM/l1AOllPsjPISkzacUvkJjrDWMsjIXYVJNOGKGt3ZE0uGfM8JG
 MQj2Is64LObltY86F+obue5kMZfTRyKtM8CJQDVRmM9QUwAG
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
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 4936fa5b98ff..cea199966d82 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3358,7 +3358,8 @@ pcie6a: pci@1bf8000 {
 				     <GIC_SPI 839 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 842 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 842 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 672 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi0",
 					  "msi1",
 					  "msi2",
@@ -3366,7 +3367,8 @@ pcie6a: pci@1bf8000 {
 					  "msi4",
 					  "msi5",
 					  "msi6",
-					  "msi7";
+					  "msi7",
+					  "global";
 
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
@@ -3485,7 +3487,8 @@ pcie5: pci@1c00000 {
 				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi0",
 					  "msi1",
 					  "msi2",
@@ -3493,7 +3496,8 @@ pcie5: pci@1c00000 {
 					  "msi4",
 					  "msi5",
 					  "msi6",
-					  "msi7";
+					  "msi7",
+					  "global";
 
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
@@ -3609,7 +3613,8 @@ pcie4: pci@1c08000 {
 				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi0",
 					  "msi1",
 					  "msi2",
@@ -3617,7 +3622,8 @@ pcie4: pci@1c08000 {
 					  "msi4",
 					  "msi5",
 					  "msi6",
-					  "msi7";
+					  "msi7",
+					  "global";
 
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;

-- 
2.25.1



