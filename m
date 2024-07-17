Return-Path: <linux-pci+bounces-10452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D15934116
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 19:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C471C23006
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 17:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEAE18508B;
	Wed, 17 Jul 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5k/ff+k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61CD1836C8;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235795; cv=none; b=GS2gjcMP4fvejwoAvz7LtBlon7uwk/iJlFd4QOiRAwUM07q3Tfpjpy8hBjnG16RcvplgVA3zkPHECsGWGU3pbn+ILfqjj7oCKs7+P8qjuPVKciLzt+J6hG7gcdFQQRp1U3vEybFxEh35a75nV+L6FXSoRlaea0bas1SPgC16D7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235795; c=relaxed/simple;
	bh=gpFkVvbXM7bCqPYW+aDVZ3Ody8SHFkjq1FkAoOcZ9yQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=drbfdYIaufz2gUx0fsHU3EIAxM9nDVuBzhjzyGG0M+mmxJTKuEJbKRPQbvhqzWocJB2q2QOM6+A79nVsYBmrcYZpfyfb5Q0awo/Xn3qeBRjpbqRVPajWEnBR0V1Zgr1U6pKS1wZZDiJgSDXmxxAYx5wfeY44DC1Man1HLe7oiew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5k/ff+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A0E0C4DDF1;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721235795;
	bh=gpFkVvbXM7bCqPYW+aDVZ3Ody8SHFkjq1FkAoOcZ9yQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=A5k/ff+kojrUZicsQxusOfefvYvGscS7lPv2v7Btk8GNADzwviJQnlO9b5EbAFGep
	 OLY5ssSp/wSouPRV8zhw1cNRi7ceLQhdoHSxPBe0GZuXDatG0Z59CRv24R1MLGs/Nl
	 e+YIpU9ezcc7iPmZhYPx++PDUQuygADS/vPi012h/3OibcqG0SiNbXWfn9yHHQMrek
	 XzdHPys5y7SR7zlwl4snG+sLlf3VZHhXgLYi5Vw+apMotj6iSZMJSJwGoj9xeGz+X7
	 Y6hKx2t3OadPhX55UgPKPgVzaD6cIupMtRDkXyE7w3bG0+YULulXiA5VvENvDKI8GG
	 Vtc/8N9wwWYvA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6065EC3DA60;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 17 Jul 2024 22:33:15 +0530
Subject: [PATCH v2 10/13] dt-bindings: PCI: qcom: Add 'global' interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-pci-qcom-hotplug-v2-10-71d304b817f8@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=UnqChimHBG0jtzlN6KxFR0yebxEqg1erfRRq9qEP0p0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBml/lPbog6HMzM14ffuorA6JAroE66s8hMQxxvS
 6uDBQeGfSmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpf5TwAKCRBVnxHm/pHO
 9ZBDB/97pJk0fM/DxV2aQn2c/+/glj5xjJYHG8hLSjWp1JoZDbXyZjRhn9+JeFUtLzdcyc3uuQe
 DuCPTNpiADDPM9WQqJOlVW01Iq3gBDvWePUubjNax4+ug+4BJUiRKTPttTTYqP6362OUQV2UaZE
 xCAm4n0Jz9DafsHpQ9ALN4l+fpCVjL43IkzSoGji/SomcdWQ8bK7o2z97Sbh8THFydl1pG/XxR8
 G0Cr2r/EJdoFEjAo2NHb6jyQ5gXP98gCjPCSlgvRRHFGc7xi9RhRVPkPCWZ6E4aRQ+VqFqVCSFM
 B/ff6u6YIQVrhI7HlTK+GvLGaSE/xkwfcbQRe8wrRh3sy2+D
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



