Return-Path: <linux-pci+bounces-22546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56AEA47FB5
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2F2179A5F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6647F23315D;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diTVrCi3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81B5230988;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663654; cv=none; b=MlDzuuDS8lAAorafzJomRVA3DnTMidb6QXNmN6/FXH6ftZMj+WhmMJQddEiydxwB59otLRk+cVVEoYppqelY6FL2W3rycjjFvpe7FqokvYFlWru0vzDHrmPCfWKaxhsZuqbWqJuaPJ51bf7uR4O9xk5rO9lPp5YsLG0gU+K/0PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663654; c=relaxed/simple;
	bh=iHejU2xwBNg7ZmkeRWa9LQq3OarCkrniwME54qhNLGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gUpekEI86VmN42jkef0XAlT5akoLJRsPTLMhLBfm2tQ/kzTET4bF2WmAFTRQRW5t/n8RfrZ8wkGjw+PY34fK7vCV/HjDJSlBhfQmYsh4QcDCDHu7WaRtcb9TNokiuAFskQdydsKUKBtRp0lXkJVZ9R+EVU/el5Nebd8rHhQGb9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diTVrCi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52080C4CEF8;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663654;
	bh=iHejU2xwBNg7ZmkeRWa9LQq3OarCkrniwME54qhNLGA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=diTVrCi3tVpEQsXSbuLEbOvOdXgDwrcSku2QE0nTQOxf9juWM+a4S5E10TUc52mMG
	 tG4wrgDUvY6FgEoVRrApn2khuGF1r/QRxe8lIQvrCxnGi/8IPQEK9/UXe6zzJiioRU
	 PJVj6DazJ0RcGpwEqp5pwHwiZzC/TX3iOx5cL68X19ZOS4tQQrMIfYmbNJjZ+FlSLj
	 Qywgr3qBHxhWh4ryIIHSnPTGQT+YcAfU4WMOKRAA8W69Yc20qVDsHXF5c19+0yI5BF
	 ns72XIvDga19BqE9VvrzprC9bVwy72pFvt3qNDv+NoDodtGSF365g127C3ZwSuPIYw
	 AeWiEX17KFDfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F54C19F2E;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 27 Feb 2025 19:10:48 +0530
Subject: [PATCH 06/23] arm64: dts: qcom: sm8350: Add 'global' PCIe
 interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-pcie-global-irq-v1-6-2b70a7819d1e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=i18yVwc4sTPNI/C25xkscVb6kmXNSLhB7jJ77ZWAalY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnwGteOMnw1KvM/39ZntzX2Iq2Fgh04XaFtPFPK
 I+vBEYU862JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ8BrXgAKCRBVnxHm/pHO
 9QfNB/0XT9WuIpccYGULbX43WUo3G3tUfoWfTDhH6LV5g6A7qLL0toT9+TsozNjSVToJwe1n8kR
 10cIueQ4EmVIA3X0APDTLklULfKhm2HYVRKif6TEgYMaNfBiwU2hgCzLdzhGgyMd0cExfSwtx3e
 OOmx4KZz2+iUsxWxSwrwTSJ29rPyVwXECxnCBTN0Qlqvv9pFxm4fFaUDFp7R2TolzWLt4BbQfMI
 G+60zKtK2H71AgDg9dul0aaBgmEIAZ7hI/0KGy1z6lEUILLMea1T9QFeUKJ0urJolhCkfKX+sM8
 jZUaiJCqUwJ4MDKqTE8hk3HPUtx/uWmztagdPhAIWWDLeOzl
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
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 69da30f35baa..c8fdd9cbecfb 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1536,7 +1536,8 @@ pcie0: pcie@1c00000 {
 				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi0",
 					  "msi1",
 					  "msi2",
@@ -1544,7 +1545,8 @@ pcie0: pcie@1c00000 {
 					  "msi4",
 					  "msi5",
 					  "msi6",
-					  "msi7";
+					  "msi7",
+					  "global";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
@@ -1645,7 +1647,8 @@ pcie1: pcie@1c08000 {
 				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi0",
 					  "msi1",
 					  "msi2",
@@ -1653,7 +1656,8 @@ pcie1: pcie@1c08000 {
 					  "msi4",
 					  "msi5",
 					  "msi6",
-					  "msi7";
+					  "msi7",
+					  "global";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */

-- 
2.25.1



