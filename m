Return-Path: <linux-pci+bounces-22558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A33A47F8B
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3EAA188AE07
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBBD236425;
	Thu, 27 Feb 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oO5Hkdmg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552D8235BE1;
	Thu, 27 Feb 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663656; cv=none; b=Azz6IfOeRRf2ARitjCXi3Qh3ZFH9z2zvxAOlLDHjC6n4Oa7/kHBa4lLD3omIXE1t0+VNlynD4cBrTIyfqT+sKXkMvhcTo6Q5itv/9Fz1RRXiVRDhp9eBgRBjhrAZEosaQq0aKg5DBnwrGsg9lYFUxJuqggHBSgk8v//iVvG24Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663656; c=relaxed/simple;
	bh=axHn+bZtg4KwDIZ8Sq7t3Asbg6Y4aGsWmSO/vPg3qdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H7mgJKXr5BZCC7refE3tKxb6pNcgvuDZP09Zu9SKJbiUDhOJWA8+Mqxr8rKEfmOTvHm5bh3R8LrVWQysfpMzZX5N5tJR50aB+zyWlna9aJSrDn8tppOC0cArQaXvEjJt60i13Dua6uKMBK/8sq5OS7iEcAEscWfL2tdjrowIzHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oO5Hkdmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 196E5C4CEE8;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663655;
	bh=axHn+bZtg4KwDIZ8Sq7t3Asbg6Y4aGsWmSO/vPg3qdI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oO5HkdmgbprXFEtxqbtoFLzEl5sIvr+2UwKvLtd3Nu6dVecYyhUp0/sRyrjRxhANx
	 StXwgqdbaQ8FVMPlqvmWd1kMoAU/RbX4Nqhm0kNGLWqUpeltraZDasYpjXoscartPw
	 L+QfRAKv7gYoHd6nSlCDRYDXxeiee/ttssoE+4rfGQl8wnOkFvPPhMEKLOf4vv54hj
	 IqAoAuigMgxLtby9oOoty8Djz55Ku61MCkc3TE1VElFngXNVJ4RIAQl0RQHEg8GD2U
	 jhxyo0DqLz1TECbPCvOGCZ2VZt/hpZXn7V73jY6YkQzjowUFb+jwEtHAmx2EjEfdmQ
	 EZIP5VaLFgbwQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C36C19F32;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 27 Feb 2025 19:10:59 +0530
Subject: [PATCH 17/23] arm64: dts: qcom: ipq8074: Add missing MSI and
 'global' IRQs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-pcie-global-irq-v1-17-2b70a7819d1e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2458;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=A1C2q2RTto2KHC7PqTw2NcD1f9QcTx7Rz/V/6QsbTfk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnwGthHuBlwbsBuZD3tAOgJOgSmmXtV8/PaMlLt
 Hq6UdG5ZwCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ8BrYQAKCRBVnxHm/pHO
 9eauB/wJ4TvaTavP+mT0gyZ5Z2YqLGQXiTyW4FnSBrugog4YXsVk85qeu0WRPEIdI8lkjlhEH8P
 hE8StqDbExGQuH37mMIeLfOhbENMXNgx0hrA/cNL/lN6Ppbp1K8zjiS0ivIVqxsj/bbxwiv7EVr
 6571EufsFiNpqxVhs+1MJrxmP7jjvp8MxeoVtDbr7n1UhANvBxFlhiK5nOZRlj924ITUO6UGqDl
 pF72ReEy1DxUQAWcV8rFt/ZfwZViJbVmJl3bVIIMu/wQ9jmDw1idGE+qsUL54UuD7uW53N6dBQp
 CKlgzRkREQHRRaUewrincQoetKoxmUXLVXw60ShuUrHUmtZB
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

IPQ8074 has 8 MSI SPI interrupts and one 'global' interrupt.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 40 +++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 78e1992b7495..fffb47ec2448 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -847,8 +847,24 @@ pcie1: pcie@10000000 {
 			ranges = <0x81000000 0x0 0x00000000 0x10200000 0x0 0x10000>,   /* I/O */
 				 <0x82000000 0x0 0x10220000 0x10220000 0x0 0xfde0000>; /* MEM */
 
-			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
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
 			interrupt-map = <0 0 0 1 &intc 0 0 142
@@ -919,8 +935,24 @@ pcie0: pcie@20000000 {
 			ranges = <0x81000000 0x0 0x00000000 0x20200000 0x0 0x10000>,   /* I/O */
 				 <0x82000000 0x0 0x20220000 0x20220000 0x0 0xfde0000>; /* MEM */
 
-			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
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
 			interrupt-map = <0 0 0 1 &intc 0 0 75

-- 
2.25.1



