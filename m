Return-Path: <linux-pci+bounces-11039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AD8942C6E
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 12:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71D11C216F6
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 10:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535261AE841;
	Wed, 31 Jul 2024 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRGmKUko"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32A11AC450;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423018; cv=none; b=A1/F+m8ULJMG3yIAk3zNKrTZKv5dDVSDeH3hTMdGfLo8A9QkkfWUilYHn8fdfhBNol/1ryykpgrL3TIBGgvgI6V30c4YR9xawof2hvIeNeTVGhRFPGb0eDeFoJi4nWJbHI5u859UItNJroTNjVvrU1Cd5F4z2U3dTOjx99leAow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423018; c=relaxed/simple;
	bh=I2wSRHaYDVrxwX11GGk6+ukp4VyqQ6OrIa6J7s/t3jQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H0VxboazysybTT3FrUd5s1nAzY2lSx5JaHPtD5lIY0Icy6RyCiBOwpcqF8e5wfK639MlMveBF9r503BHDeM3WxTJvHr5mEnMYiQjjNvgkFOXSepODp2sTy4IEuh1kaptdf1Ar0MADpUtTkP63VmuO6r7ujleIwFJjn2l2l4YvDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRGmKUko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 999E2C4DDE5;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722423018;
	bh=I2wSRHaYDVrxwX11GGk6+ukp4VyqQ6OrIa6J7s/t3jQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YRGmKUkohGUwSCohzekyye3hQf8+259YSxxDyTV+ef4cHWfxt1+sUcVwfL3u9cZl1
	 wUUQWwEMCgRcSor0wNMKQLGna7yGOkWdgrTphT5Vpr612T4/hNMdOrJ7Fl65irqin/
	 gOsKJcCOjysE2yqRqjHFUrVa9vqy2p0I1vr6c3JMcWzoxZhdSbw1bkugy/oDcdP37u
	 QFAl1BrCoPnEQwQU1qfBYD5lcXvXMmfwLNXOuiXkJEh44uKdttryROHkrM8/ZJP0nq
	 WjzZ7y3QUG3eXtWUND6yEveY0WbnToY2uQH7Rf6R25ul+apyVRHizRFSBuLIuJmfPF
	 Qu5He5V/je2Aw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90934C52D54;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 31 Jul 2024 16:20:11 +0530
Subject: [PATCH v3 08/13] ARM: dts: qcom: sdx65: Add 'linux,pci-domain' to
 PCIe EP controller node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-pci-qcom-hotplug-v3-8-a1426afdee3b@linaro.org>
References: <20240731-pci-qcom-hotplug-v3-0-a1426afdee3b@linaro.org>
In-Reply-To: <20240731-pci-qcom-hotplug-v3-0-a1426afdee3b@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=961;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=4ksb8gQi6XxtqZHvRIfOuO8m7D/GXep6HzglfrtwSCA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmqhbj6AuR19gVgM6SXGBTiRSNQwqVP0FlXbfOh
 dH/EI7xJimJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZqoW4wAKCRBVnxHm/pHO
 9VW8B/9MUtYiNGVpuIfJAqYCVOzwF+YamFjxtReGIZzZB/h1zfMILBFtGv/iiAQf0SsENP/AmQK
 7lQtHhyCTi+jSGUT8HlUMLN8k7Oreavy/lwt6D1/qZ0BVzRpdI0G+vYAuCn/X3R6K7N5NPkequ9
 cbIT30CZawkFf+Y8LqSQNhvS441+zuQQlEzXg3MLqf9kuBtyQhmWKHHTmEyhH683xm0I5nTTXMS
 cGfl+gtCrRqjAfmyIE+lw3eOgGUY5kYoVm50maTvndVm4gC8ofnbApX9Prw15Euh4b4dxT8gdEE
 /JcYse9jgoAz2xBLPT8t6UEtXmmpB8OuWg7t2PfesumKpaMr
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
instance of the PCI endpoint controllers in SDX65 SoC.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
index a949454212e9..fcfec4228670 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
@@ -345,6 +345,7 @@ pcie_ep: pcie-ep@1c00000 {
 
 			max-link-speed = <3>;
 			num-lanes = <2>;
+			linux,pci-domain = <0>;
 
 			status = "disabled";
 		};

-- 
2.25.1



