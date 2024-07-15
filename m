Return-Path: <linux-pci+bounces-10286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EED99931990
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 19:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA751C21CF1
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 17:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D97481A3;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeAHLaQK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403CF73462;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064830; cv=none; b=n+6fo1ZholsGqIkfnE817biJhe7tINOYVXaB5r9OyDqQSvZKThjCY1XGHTMP3+mVevQw19QLZ8Yees8jpwUN5tPBfTfoG7GjOLos0oChFqo2JWH7M4OeCX3GAqiA/ebB+UAkdCqAHpFFh+qsdhZxHG8RgNxtdiM0NV1fTKA0pmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064830; c=relaxed/simple;
	bh=uf2gmip5094Xe/ELLjWs+bvQfphMpBDzXrzLLgYLAUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qXcnBsnmKxLuQRV2su/TWkkmb6akZMHZ+3NaLvhv91v6rE+vkqwYcgXMXtBendCG9do76P5G4LJ0BEEusknzxDXU6PJNKRga8MMyWzAVRNEKwcEyUXgAsrmMpLB/w4F7IVl1pcAfLJNTOSvrp3+UeHjOMfrOJ2/IImsnMY+hvV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeAHLaQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8905C4DDF1;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064829;
	bh=uf2gmip5094Xe/ELLjWs+bvQfphMpBDzXrzLLgYLAUE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZeAHLaQKECA6DixHkpXmrQd3abxj3/ZpiFkmEL9SuZBsg+pb4Y0raxj+Onj7rf+nl
	 Xof8UTC4q2eKMc++EypFRE6WuLkrdfiXpECnsOcL+j0V8F9V7xs12Zxq3rq8nyZY8Q
	 9J2hr+r+15XReB/tD5EZtvuopbmftKzB6aUSzBE3AUZi9+JTqIPXo9G9RyEnM5Ximb
	 WaAYd9ndBsuSXRYzAkdjw5LTpS+p2b9SfcRI8or6zXdWk3r4gq57F/QSg09VbkLo5C
	 eqHXOCmgX16d4wk/JzNXkObtWCHHd4OV2fhS3+eSU8itZkcLnRhEXueNz73tNmN095
	 aMoctYu49hEGw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D017DC3DA59;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Mon, 15 Jul 2024 23:03:51 +0530
Subject: [PATCH 09/14] ARM: dts: qcom: sdx65: Add 'linux,pci-domain' to
 PCIe EP controller node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-pci-qcom-hotplug-v1-9-5f3765cc873a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=906;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=csDoZP2OLES7tPZyHjq00PkbEc3m+4OOmtcZKbO5fqQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmlV15ILF+SBcNiGMrBAY25nZOAZu7j9Kv2LBvw
 ZMFFcRVTL6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpVdeQAKCRBVnxHm/pHO
 9Sv8B/4yrtadvSEQqOUXqW6F0dvNf6+Zln9x+SGI/lNhwGwZqkjc55QHUCEyTPwRmWWUB89jP78
 q0a/m4kXRCkrAYxsPcLRwJmyUY2zqh2/k5Cih1iFqcNbqALrMSRxQ9rXxNbQ7uKkbOZsRCS6lsB
 YkfrQbRNZouw7BU7+FRVa1y1NQdCMVbKIdoJVD9XeD2xVFg0v9RrpIssIZ6WTmoAgyOFq6EEr3D
 rzbwgTcqBSwcFaW5M+oKVS8BLg73fwMqX6+ZofQH5DNK2mhRVUHfwiGyjV2M56z/3hlzvbTqe3a
 9wZ5g8IytbMFVCnWUEEFo+0xViAHeDhrpmr8nN6BOeWNSu7f
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



