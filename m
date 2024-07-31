Return-Path: <linux-pci+bounces-11040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4593E942C7B
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 12:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB2F1B225CC
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 10:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644941AE855;
	Wed, 31 Jul 2024 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtsaLv7d"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B961AD3FC;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423019; cv=none; b=jnBu9XZ+MOQmhtfV+U0eSjd2iIJ32OfsCQmOI3yA2yyNvqMhKBOVOs1iveUmOgLN4G26I/jWp97YNVw4958NxpjhGGHlHxNe0KuC6UWL32yze85jbhQhernXsOwgg0Z8yT/ultZ2hinVZsZuCXGrYG7quDjNnrFfXvRkxz3VrVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423019; c=relaxed/simple;
	bh=22QF55zGLP92w1/Z+PYK8XSQwdKiIg4NOzO1VfG3i/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V+wCYM5cq/JQu6m/pVif86Ibs23mP3Cg1DlRoRhwQB/cPR31UKByWWEqexxm8rN8x+7OhvX96JSe7cL1+aKlE5TjQX2fBTLPinceuoJgvbpEFCxLnRen3jI2DREZNq48l7zb8Y5mS9S5aWsvF7cYJRUspPvNfAJPpbD7j+7XB+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtsaLv7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B9DCC4DDE3;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722423018;
	bh=22QF55zGLP92w1/Z+PYK8XSQwdKiIg4NOzO1VfG3i/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UtsaLv7d/4yu473Jw6DhHJyKGtpOFJPICPGL0tlKVoXm3NcqGKdPjogcLtkdWnTv8
	 ci2sZHgJDd4Ph9xiVLahfyEkemqulFewXp7gyZDT5MzA0YjzNf/XgtQPvcznxH3fID
	 yfw9M06lpQjU+SSNvM3isFE6yssZPS0G8QJ8IrT5PvRdQz24eIt1olY4I3sKuYVzMM
	 OaqwoeB3toOBzRrdGvnt61bb72l9ii9Zjy1fnn8eI6Xr0J670Z0h/FIeOBwoA7gVUS
	 lKYGAH9ssaprnF9SQaEe2wJ0hfIUt9zSsddgB+AwHwFs1CCG1L0rxRMBAJmVuvGPwV
	 B9hutC9gWJUdQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815F5C3DA7F;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 31 Jul 2024 16:20:10 +0530
Subject: [PATCH v3 07/13] ARM: dts: qcom: sdx55: Add 'linux,pci-domain' to
 PCIe EP controller node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-pci-qcom-hotplug-v3-7-a1426afdee3b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=986;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=+Lb2vcF7RPFdOyct+N0+V3AMTmLDYS+SRQY7Fw3HIuE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmqhbjkTiApJTNTSUBKI9q0eAZ0la4yNkAKIvRj
 ljKbglV8RWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZqoW4wAKCRBVnxHm/pHO
 9QfVCACjGPb3cSXofPXXA+xQOK5VyTm0JsWjYGlVhpBRR3i9m8pYPFc1wJeOTKGJCfgCkj1oRc1
 Xadvp5Uc3OD6RDssrwDZ8B1rbpqb0Zqr4ok5k/1/BEtqKVl9UgtRlQ7yqlMV33Z6E/EhAbE34NJ
 EPL8Y/A6JerH7OLUlAPOrqlk34iLQkyFGH2g3iE+0qp70ZH693eUFTLdR4DM+LYADeyxJSjfolu
 VqcFT6b8IoSRFoemRQMBZfkoC1UZCo6NkHpBI71o10uV3ibDH5skWSykTBrru9jvbQ0DOf1P1mc
 d0f6RohT1YZdLtjKWAmZEWPzEQNGQ08Mg/EZQaGugxxFdbwP
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
instance of the PCI endpoint controllers in SDX55 SoC.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index 68fa5859d263..d0f6120b665d 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -437,6 +437,7 @@ pcie_ep: pcie-ep@1c00000 {
 			phy-names = "pciephy";
 			max-link-speed = <3>;
 			num-lanes = <2>;
+			linux,pci-domain = <0>;
 
 			status = "disabled";
 		};

-- 
2.25.1



