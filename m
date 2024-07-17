Return-Path: <linux-pci+bounces-10449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A136E934114
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 19:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A211F24A14
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 17:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4131849D8;
	Wed, 17 Jul 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqkUfyQ8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE6218306F;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235795; cv=none; b=RbdjU3xUClOk+yODYSueV10eKDth8JFvg+4XgTU3lNqtmncchzhOgFzjr3RrxSVGk2K30z6+KbS5FfHGPeEnL9DfWyfBgGTPjIQPkZ9e+iqKr7WhW4+pF+89y/Tmlz+MyPZFYrd2l8YBQUwrNeZctH6C3xfnp8UXWWYkH9J6XBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235795; c=relaxed/simple;
	bh=22QF55zGLP92w1/Z+PYK8XSQwdKiIg4NOzO1VfG3i/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HtzSUSR5hdA8fykdTheWzrCTGnIjSrnQ1is9Ew6o6iRVTD/zQ7SQhq7HCWtbrW5ao74SJbTVIWUyhUfT9UBhh1sqjuOCqs96wP7zjTh84VmY9IPEJVHVV1uDwBEzaIbydUucCRgp14rD4vJj5QgZiib8dw5CDjEJnIdp5DuxK8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqkUfyQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A15CC4AF68;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721235795;
	bh=22QF55zGLP92w1/Z+PYK8XSQwdKiIg4NOzO1VfG3i/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pqkUfyQ8zcUacciepePEdFEY44EiX5ybwY0CB7QGxxP20h9Mfw9gRAdFAsPbznq7X
	 8syhxChMx1JYXTvlSmFJrI0L7/4gwLaSX/Sgwyx+iL86mGhTjLtfVyXRdXtYJxJ2WC
	 zXTIbzdGNkOh6Yr1MjK0p2zG+Qw7hK5VZlaX25wKgdA4v4STpcdHbzdYZUeqqCA56E
	 EnLR29W3PThiIwE/K/zxnGrymjU15GnU4cS+RlDk+hcSdJVxWz6eTqp2currNoOxtG
	 8Imsqt+fAi9fra2hvsoQa/zvWnsWbSpedMlSyzqalEwpFY72wjoetkxONTr+y/33gg
	 QAffMFZTGT2bg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E584C3DA60;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 17 Jul 2024 22:33:12 +0530
Subject: [PATCH v2 07/13] ARM: dts: qcom: sdx55: Add 'linux,pci-domain' to
 PCIe EP controller node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-pci-qcom-hotplug-v2-7-71d304b817f8@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=986;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=+Lb2vcF7RPFdOyct+N0+V3AMTmLDYS+SRQY7Fw3HIuE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBml/lO5lBDAIgog7/DCQS8jI0fHtovZQlYwqd5B
 WyOgUwNCS+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpf5TgAKCRBVnxHm/pHO
 9drCCACjiN6bdLASGYBDuhq74Vb33fBJv4q/jyLQI7eY1YopkvdioFtdULJXkMXon5Zuk0IaPku
 kTBOiAX6Fn8kn/Xlj5sScthaADAb3cWT0JlJyEMgcpT52ASfJAroHamUTcqSigY5q4qh+j9yIC9
 7BkhTsQjOnd7TLxKYFC4A59LbfM8Rd7loU2mV0Et8D8agByUjG9JrtsxXjxvYhaI+JbV4OBvXrJ
 qjDsuvabamJDN3ijnuhEeC6DsCu1povehl1QaFsAzAtPJdQ62Kjn6HUiYSBQB3y1PNw7YmwLIkR
 B3++UcnUscWAB4kR2N2KnO4ZQ5P1Es90cNCEk8EtGiAME9pD
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



