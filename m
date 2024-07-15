Return-Path: <linux-pci+bounces-10287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6DD931982
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 19:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033AC283404
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 17:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E27A1369A3;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPLL9ttg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4277C73467;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064830; cv=none; b=jO7uBYN3NQcoQr9gTbhdXX4K86OapvQjXtrDrgxBEinKzBfdj28fYnmCnDPzhfvgAFyIj1Zdx+Qm27+vyxtzc4ilSJNEHHBLN0d6RUAOx/A2L4Q3WFK7XohGplImxa5+sHAi4OUwIMcUfNT1N5X8LeaFQNyOQYalZal672Qzeto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064830; c=relaxed/simple;
	bh=/+ZJ4zOV8IcXwH+KdUstzU8rIdKdCsPzpCCx98EAYT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iocEVd1nl1jGyx8uF3f1Gq2U7zuyC5KO1Z7jedn/4os08PzeN5ydL+jnhjafuT+3DMVkwhGUYmpWkvktuDr/PhBE8l5cqX/LZEV1s0yMrYvlKgtGWhLZT658PzM9dlP+CQv+6yQTNPK9V3yl/hEoX/JyELRp+2WDPFygbBJVOh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPLL9ttg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEE28C4DDE4;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064829;
	bh=/+ZJ4zOV8IcXwH+KdUstzU8rIdKdCsPzpCCx98EAYT0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JPLL9ttgzdoheB7ryInuSc0EOMtpD0E7Br9v6wt5wvX7d/mOnow4x+GEXbXc/xowA
	 aisDogolRwhMhPFNPZZ+0JjDzKuBVTVn83p7veyeqNLfFgIxR+BY9BoisSK70NML0l
	 NJdGIdCPxhVLvs+HrII3F58WMd/A5WfpkzdoILs3FgO84fjq1BedGH5LTeepjrxvhk
	 /riyCXpd1ENr7X0mIsrO/F3kV3WIqxbV6HzI18Sa9yh180eqLFoGYnXNaxQoykj8V1
	 J67VizrxECVBmIiOfhh5/lpKFzy3MLyq8L7zh8sH3xL/UrT98oErLa6Cb+Z/LAkWvv
	 565r0C3BaXwQg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1847C3DA4B;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Mon, 15 Jul 2024 23:03:50 +0530
Subject: [PATCH 08/14] ARM: dts: qcom: sdx55: Add 'linux,pci-domain' to
 PCIe EP controller node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-pci-qcom-hotplug-v1-8-5f3765cc873a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=931;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=kwx7QGYogFgH9r43zYyha4gga2vYwsd4o33qhsGds+k=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmlV15CSE+uo3sq2/IU8wwhr3HPQhoooREAXiTf
 2moyV4AIy6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpVdeQAKCRBVnxHm/pHO
 9euhB/9SeAVltwvnAJZ+YRfNlsDMbN7Uj/QBB1xmDKKYJ1sL5L26gF9CoVkGnA6K8E0SXy9Gc+A
 NTb8XstE7UvbNDOMutorOlKNUIXv+K1/lxQkbT1xZIxKhqO7R5TGH9+IkEmHMDkr7P7hHoIuXdm
 JPWPepg3a0a78frM+9WUf6zIvSzTh/VL3fTomMstjc/k4BH+mLwhJ/9i6dJLyXCf72NPjX5r+iP
 UuS+5RRveledStbcaGGWSg6crWKVO4ewA8oWBNiR/tlFNBv2BY7Hlo7hx89SafZT70tCDpRczmB
 ze8I8CbxVJS84qqvpCnThxQj8Pd09GoBt8yxELZyQfO0qUzQ
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



