Return-Path: <linux-pci+bounces-10284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F01493198F
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 19:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDADF1C21B01
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 17:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92307135417;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlX3FHLY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3930B71750;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064830; cv=none; b=mryMeWUswJ5GQ2FEDtyxd4t/FfJ3mgTRc7hlbns07ipXujYPvucFRC+2yb0I78I1N2R0GktHU9hloXlgMC4ZSws6nlMGfcfxCOoWaHuNr+oV7zVbdotjZtmncgYEJD21n0+3xFmJAO+GLT5Q2/DupITrKQ6G3fw8rNvJxsZHO+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064830; c=relaxed/simple;
	bh=gpFkVvbXM7bCqPYW+aDVZ3Ody8SHFkjq1FkAoOcZ9yQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=myEt21Pq9w3nSljGJMMNgMYeETOCG8YOMgzyoIznQA3wV741c77lk0bn/LCIUkER/DuoBKNFwT+FmRhXSBcSYTiOF5/UmJdoc1DvxAnV9uoITryy1WcVDa2sfWA7MYO5SiJQN6WYHwaatxTqUWMOmRJpr3MKJfeUrqp2h+nn5GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlX3FHLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15562C4DDFC;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064830;
	bh=gpFkVvbXM7bCqPYW+aDVZ3Ody8SHFkjq1FkAoOcZ9yQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VlX3FHLYw/qfQbFIpX3Qnotdxluj+Iw12/wdVVgezSiOj+yb3X3cbBO+EQdxWoQWQ
	 m4ImDl5HIvY3paA9KKBth72GcwnPDDEAjgvREBPT1z93jvgWfXFnQ6R4VT9GgFdsDx
	 GYk4MR1QA0IZbX+K2ABGm8FmJWQP121G9HcpPZFIF1tOA1umuMy7aoY0Mi3NuPqoBj
	 pbEWLnGSKxhKk3f+OyHetJkpeSA3v2erC39Lq64A6+WdNehTknFfgL0XMAsrJZP2G7
	 uN1m0En8o09ud2VZRzC1Ewivnqy8PMkI95kJ+dCfgRgTivxQ8kR4AKQuS5u7Svhzlu
	 LyumVyAEAvMSw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05968C3DA4A;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Mon, 15 Jul 2024 23:03:53 +0530
Subject: [PATCH 11/14] dt-bindings: PCI: qcom: Add 'global' interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-pci-qcom-hotplug-v1-11-5f3765cc873a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=UnqChimHBG0jtzlN6KxFR0yebxEqg1erfRRq9qEP0p0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmlV16tFqqZEEX+8rRK462V4QHEJFdB3yZtLtqp
 DZlCdho5XqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpVdegAKCRBVnxHm/pHO
 9YmaB/4t/J9z9MOQ7NeByI3uw0LV5xTLZ9fAGG0TJvIPd+6+hy1g3lhpALJ9DWOosLvRy5uLg1S
 e7gf4y/bVjkW2jgL/v1kdIlFp9szLQk0vUAPTKMHA1eTpMIy96ElBgtld9h6pfkOBZDjxZGbiOC
 E1ifRqkZIQUPFMG3zKYw6TBuEb+rPMn9Px9IWLOMrBFtFS1dQuguHQFtowm14xEIFIgKXCG+Zod
 ORgDqhAfyIeyR0LRltHwGpdHmKX1nEFax9DHVFFrevqQOrwMkrzuchSSUmHnVQ30zRQTL3EVz11
 CxkZNlDLqvoUV8jj+IGGtMhyhy6zlGGIuVl8vVeY2Y62zD4C
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
to the host CPU. This interrupt can be used by the device driver to
identify events such as PCIe link specific events, safety events, etc...

Hence, document it in the binding along with the existing MSI interrupts.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
index 0a39bbfcb28b..704c0f58eea5 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
@@ -21,11 +21,11 @@ properties:
 
   interrupts:
     minItems: 1
-    maxItems: 8
+    maxItems: 9
 
   interrupt-names:
     minItems: 1
-    maxItems: 8
+    maxItems: 9
 
   iommu-map:
     minItems: 1

-- 
2.25.1



