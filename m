Return-Path: <linux-pci+bounces-10447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE589934113
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 19:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4CA1C2304E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 17:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8F71849CC;
	Wed, 17 Jul 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDetYLCJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8001B182A79;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235795; cv=none; b=uR4CbS8lVHrLYmN5ZyNQ3C5hCSTc8EAtaMvzarmm1HnLnCiXaz15Rv4lLlLOn6Eqz8SbNdNO/m/Oo35S/BVxlaOPJrzzWZQOUar+6uDgF1W3qZ6lAO9r75k/TDN4McTO3lsrdD0yYVi206ps+pe3sdwidRoaca8EaK7RyrmXEmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235795; c=relaxed/simple;
	bh=LRGU1ZUSjT7pMjV8SjmoQEmYcbLwDjL9G1AFtQWIDsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tgt1M9F/vBYo4tvJ/Y9HbU7s1Af7Az/YhYsaut97JTsaMLWquCqC3ClaQA8AyjSZfqE6AUN3OX6HdSjGrre95u9BvNz2QoK1IRmte/P4mL1cc5X2BN3bAbNHDess0gqEx1PirqnRF7nRYhRiPmMXelvvtf62pW0roZtiqN9jp20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDetYLCJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBEE8C4AF14;
	Wed, 17 Jul 2024 17:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721235795;
	bh=LRGU1ZUSjT7pMjV8SjmoQEmYcbLwDjL9G1AFtQWIDsM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RDetYLCJeh7EXB2FwEv3KPfj+0hfPbm1CizCYQb1YtI4etNOPfgxuPBJIXuBCS9Bc
	 WWGA6i41putpOmcaqC/fp2SxdAU9p154PPuiKa4ZI4GGULpIXs2OOFovv+e2otIbrM
	 r38gBJyGu7Oonbzg7Y8D8tu9VN7ODyWCt7JLmUXdSQq4OvWU7y0w7n/hkBc0cnzhh/
	 7GeGdkht1TkurL9Hv/rzldTdg0OdNGG4ohEIqIA9bKeO4is9awcq3VMYyNMy664ity
	 dT3EZQoGPnxitnssU1GgjxgwLlPww85Dni3CJu20WaBg/D/EezMsyocUWoSekUqrqf
	 cVbxCwQrS2kEA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EA2C3DA65;
	Wed, 17 Jul 2024 17:03:14 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 17 Jul 2024 22:33:08 +0530
Subject: [PATCH v2 03/13] dt-bindings: PCI: pci-ep: Update Maintainers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-pci-qcom-hotplug-v2-3-71d304b817f8@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=988;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=hjExGhGjQYtIRypMJXzdJurZJRAD466HOf0lMqV3fm8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBml/lNfQg31fke8+7oE4tHhiVq2trkn1dGnRBUr
 XPgVijg6keJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpf5TQAKCRBVnxHm/pHO
 9au6B/wPjAG890Ex6xuP3e/ld/sG4k3HMnWw4SNgGuWBUlbG0HRtEstH87bHLLybXjXBhnxu8Ap
 lTfSu4AWyCuwvfW3nIsqqjSXL47MrsJxtj3V/h2l9EuGZc4P76S0/d+h+KXyjscab7Tiho2/ThA
 5FgBVTmZ/In+XcxMSx94uKj3jxZX36OXPVJM69piD21ZkdCeU3NMrDfT9ELPh8LohvhycCKgaxE
 EjUoqvxZwZ9W0XMCIoPBxCV7DY8H9IKtkpE1mBH78ESyt9ifmUT5B0FWvbtIzTMqK+oV62C0QxJ
 dfazQj0E3ELoLFT8EODzryuYlc/XNzzuq7wkrkI+nn7zVU3K
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Kishon's TI email ID is not active anymore, so use his korg ID. Also, since
I've been maintaining the PCI endpoint framework, I'm willing to maintain
the DT binding as well. So add myself as the Co-maintainer.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/pci-ep.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/pci-ep.yaml b/Documentation/devicetree/bindings/pci/pci-ep.yaml
index d1eef4825207..0b5456ee21eb 100644
--- a/Documentation/devicetree/bindings/pci/pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/pci-ep.yaml
@@ -10,7 +10,8 @@ description: |
   Common properties for PCI Endpoint Controller Nodes.
 
 maintainers:
-  - Kishon Vijay Abraham I <kishon@ti.com>
+  - Kishon Vijay Abraham I <kishon@kernel.org>
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 
 properties:
   $nodename:

-- 
2.25.1



