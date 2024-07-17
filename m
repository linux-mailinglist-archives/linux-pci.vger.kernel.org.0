Return-Path: <linux-pci+bounces-10444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797329340F9
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 19:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FAC7284C2E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 17:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4E1181CE9;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTZ8CXwj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E51183065;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235795; cv=none; b=giiUt47IrfGfEwfgz3MhPd5rCPhzBBb4IZzLUKMomo9G5jlwwX6Low4eeQTvkgAxzZc1C7oQOcWSj/ztp55kVczy156Ovn3FK4jRr8XFHv9U15drDX7XamqzLOPA9SJSussVWJHX0W1pWaqtYBi6orGaHMlGZB4v9brp8o+KLNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235795; c=relaxed/simple;
	bh=I2wSRHaYDVrxwX11GGk6+ukp4VyqQ6OrIa6J7s/t3jQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YDjJkcUNRY3PtLuh2M3wrm5ru1GcPAftALaF7TJb3NsGqyz1OR+9Hoemm5ly0GZCO0UkgwtbBqD8A9I7zebb1nLq1z+hpGGhVaBQSrgXh4ZL68yKqKL8ZZeHmMgNqtsD3iobFvgVPyWNEWsRiwL+Y80Um7Fl13afojHyf1DIbho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTZ8CXwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 491DEC4DDE8;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721235795;
	bh=I2wSRHaYDVrxwX11GGk6+ukp4VyqQ6OrIa6J7s/t3jQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DTZ8CXwjoQWzwYBGgBSCy0kUhYdWaM+9JZ1kJvMw7qpGQYkViY/95j9XqL0lZIf21
	 fkwCbS2eucxyXGN12M56HYTtyRSNtC9wgd0LRTITMyLXzjp2Kz4sTrUvMg6xKvXVis
	 lHKS2hYwe6R2x4ln265ZNwRv55G9OyjgMHk2zzayCncSPoHC/X7oEgXDy8nfnKZKSB
	 o7K61yR0rFUgI/SARgIxAIrh1Btg3ilekQ5NMTNPyNwvVEtiG4DaT5xXDjq2UTQgHX
	 eM3eNQTmxlThIHCS1nGsycKYpmFy32Y8rtknl1fsk02h7ScQ+zeSunyZtxpTz6eKWG
	 cR/zBC2kvj4Ow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E64EC3DA64;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 17 Jul 2024 22:33:13 +0530
Subject: [PATCH v2 08/13] ARM: dts: qcom: sdx65: Add 'linux,pci-domain' to
 PCIe EP controller node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-pci-qcom-hotplug-v2-8-71d304b817f8@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=961;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=4ksb8gQi6XxtqZHvRIfOuO8m7D/GXep6HzglfrtwSCA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBml/lOaxt8p1VgGOZBseIX6KvazP7qZyjP7I2qJ
 67f4dQ5/OCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpf5TgAKCRBVnxHm/pHO
 9dS3B/9Rjk+/ba3zu1H6d/sG4cj9IPKv0Z942GUAmrfXH8YUbpeUaBSFG88mexbV8zlFoZz61wQ
 7G1MgSo7bm8JbY/qVmvk0AOxJn/O3y5sW5z5LGupXMkz2ffMp7pN12e9bO8cS3cuaVQll3fVFSr
 ZLzzhTezyNKcZw22kyRKEQ0F3BSg3kFHWeIDQb9OgjPNTv28OhO6rcnZT2JwcHpVLVimvASPMNR
 kclkd+tzsE8wIbW7RE5W3UIbvkvWkFYn5VpjcqyTTMTfslxEE6jlphoqh4Dc4GDyqTzVlfyhqm0
 2IC950TCA0ZOBe+3E6jyu6sxHb3rrsn23W5BZYFfCk6XloRB
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



