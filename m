Return-Path: <linux-pci+bounces-12361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0C3962CDA
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 17:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275622815B4
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 15:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542581A4F3E;
	Wed, 28 Aug 2024 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUgvdM3R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9791A3BB8;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859985; cv=none; b=LPzaz3LBWgLv5SsnlwcM0zM1M60G2LabE3RwlRw/QrANBmvBmCySeHJxOkp1lZl0L3Ty+eU7tKXniiABH7ozKXPIwhNdbdnbmvBaohFn0jy5wTtOGWtwQrdaOIk3d09k+SgX8fxKmVeMrfO8AiZ0kQkwxG1iysqgUdQU8pinb5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859985; c=relaxed/simple;
	bh=I2wSRHaYDVrxwX11GGk6+ukp4VyqQ6OrIa6J7s/t3jQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uj3GO3Qn+M+0CMKvEdIOcViUPqRkW/bWEa6sWfiNgG18zRDbMNWSRl8wWIx78m5MNYhris+M9mkVJkcSTIQJBi1SNMhze7+MAY4w3zg9CN/jluorfpFpj62lo6QJFT1cVcTJrDQQL+IgujkRacKBki/jXCW+6EZ+TAXURH5FRxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUgvdM3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B522AC4CEC7;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724859984;
	bh=I2wSRHaYDVrxwX11GGk6+ukp4VyqQ6OrIa6J7s/t3jQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DUgvdM3Rl5ZbxCGaaOIoONbnLXZrtxo8G+QfwMGpEDp1+hmQPFZ+W3FUEzFjPp/ds
	 U60XHDdKiS20393XTKdHE0WEy/05GzzBCL6RDzRy9O4BVDK7pgQGljzb1Ym4ctrLhr
	 AB/aubhVA2jAkuKr+WzCJ7QvXN29sbsgw59AA1CmaeWQSqt/ncsrxJ+EXJ/cHScMjF
	 X7lh+EVTGpA02MAuiWUmGSD9/wZzq/3SggBktiscynLVsXzbGTHsbfrVq+YyOyjblr
	 ocGqSMHL8poaJJP9S1rV4N6BeuqDwEPpHKUh+t5rkJDEP1gw71gTOtY8e04hsCvCmi
	 hTu8ep/dvzq3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCE7C61DB8;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 28 Aug 2024 21:16:18 +0530
Subject: [PATCH v4 08/12] ARM: dts: qcom: sdx65: Add 'linux,pci-domain' to
 PCIe EP controller node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-pci-qcom-hotplug-v4-8-263a385fbbcb@linaro.org>
References: <20240828-pci-qcom-hotplug-v4-0-263a385fbbcb@linaro.org>
In-Reply-To: <20240828-pci-qcom-hotplug-v4-0-263a385fbbcb@linaro.org>
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
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=961;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=4ksb8gQi6XxtqZHvRIfOuO8m7D/GXep6HzglfrtwSCA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmz0ZMcCAWuNfIslxrX4tmDNzHiHcwDPbSkkENj
 sUmCBTArPyJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZs9GTAAKCRBVnxHm/pHO
 9bL6B/9rkFj8vlPARTFTa3DZ4FFTrCkpbDbqJHbBLKdXwQzG6jGQIpJ6pzV9klmkPXc9cnN76Wg
 G4IgIamHddxgW+nfOLgdfuSmTRipWuFz6FUm/xNEVfCE6rqMmrPDCy9rav9eX7wFgZSjwtqdQlL
 9g4iOJkPVwrR8GPS1wkQvkIWCiioGJjAkVfs4dtxDsQW+KON2cdEIVIIo5V6MHFGTXzojYGNOwp
 +/k7/liaYzED6Vp3fPQMgtsCLMhcMWry/Skisr50qTDYafouyj7G+i3VIbFGo9ZdOZotlyy0Se2
 cjDdAgN2KXzyZ3ijdfHc4SjqL3dP3HJVpdSTKlFxKm08Ju5L
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



