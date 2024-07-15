Return-Path: <linux-pci+bounces-10280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7716931978
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 19:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7FA81C21C27
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 17:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8226BFA6;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mzr7uV+8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D907155E48;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064830; cv=none; b=N1zt2OUIMjkU+oAAKaftPb1id0kwLzdaC7gxeFNQZslqU+k1sUe/LzTzfBDQ+vOvrcRAXIkGoknjP9qFrDZ9ScbtOff9cbQ1hI7PnTqJDXNWycvAgULFQIX+gASblLIgeappyDyg355pijpenQT2Z7oKESRI/Cbn98zElDRbvVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064830; c=relaxed/simple;
	bh=LRGU1ZUSjT7pMjV8SjmoQEmYcbLwDjL9G1AFtQWIDsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T3LzI+ZCgUWXu5Zi54HBgKZ6ZsF+ZEWqAX0eUV6VzdcaLpXmbVfOJiXZ7gmujXaR0IbkIvKdcFt8+l0XeP/FjiVQVk/A13U40R3+TUfIa9DW7eqbJrdFWbzhh8IW4VeZkmJW3IasASo0pzcPkuSZZFMu5N2N1JhlHShLIVJVwVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mzr7uV+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8156EC4AF15;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064829;
	bh=LRGU1ZUSjT7pMjV8SjmoQEmYcbLwDjL9G1AFtQWIDsM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Mzr7uV+8K3jodRpcTwqfKCvE8yCXOXCM4+vRSkV7+Gi/c6Hdg6M9+P2SQzBR/66z4
	 DpIeYCAdwOcklN9/ymqfaje6Km8qAUxl1lbZqlb76Dh86ikloz59NFCToNV29pRzOq
	 AgKxGtHuJodic4yT5E84FdqN7ximKMLRNqp3YCSOo/FZ3mO5lbD6qXAXRFX62glBys
	 3/Lg4M8LGOjOEVBgfY7wEXBHZSk29gaTC/OlAN/SOE0j/Ry08tb0RyK1gDod07nqRs
	 xS/F/UdHj+QeyoGOoUzzkzBVQyMzLGavrIzxwnlQNf35CljLj1ijv7z2n3n6rnQ3On
	 IsFtjvBmyhpGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74851C3DA4B;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Mon, 15 Jul 2024 23:03:45 +0530
Subject: [PATCH 03/14] dt-bindings: PCI: pci-ep: Update Maintainers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-pci-qcom-hotplug-v1-3-5f3765cc873a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=988;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=hjExGhGjQYtIRypMJXzdJurZJRAD466HOf0lMqV3fm8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmlV14KYPtRgTg3g5EoPeN8522vVrQhN1qaY7/c
 kIik6AD35uJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpVdeAAKCRBVnxHm/pHO
 9eSuB/9x6dRA5UTZGB8p96YqCmsRpqrOTNu+uvJvQVEwqOSETlWw4EnwEpB2LfPMRFLfmvUWBYt
 wdyMR3qpMNxZgBlhnpz2eD7u0f6c4Mo1xkYKUBMzR4i7+rsGeV2ytOX28WYDiPdXtdF7nt156KJ
 ExX80HAXszwxIUdGz3aovIr9cZV+xsmPvsLT9rBaXy6ax/2elU8LtYdJTB/fj430YEji5KeBvzc
 TeBFn9SyiQ4VPaUr88aQht8PvKDy3hupt52CtnHcIWVWi1r+V4M+ZQPqb5WnpRQ5pM33nt32Qfn
 GJjVn5Kr8wTiI5v920O+QkgudZkDT2he8eJ3xokaafDC7KpE
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



