Return-Path: <linux-pci+bounces-11033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAEC942C5B
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 12:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B5C1F2701A
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 10:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5CF1AC429;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qt823roh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E382190473;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423018; cv=none; b=Xg8SZQCZ9PNDdW8HNu7mLh2ybTMlDm781jP05/OyNFJNe5eXFlonGOq1XJkH3lJzRpoSRO9pWpoyU9ZXh9ZeouDCuwfFDIv40grROCx/O1fezsXbqcbEIFgvXHXZz14UTxUf85ycdKbiPeRMv5EVj/xqcOfW5h/k9f9k0AYr5eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423018; c=relaxed/simple;
	bh=Dynz9QHhPHZXKKO8GD6i2AnmK4GVgprdx9YpUpdCd88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bDmPSL68vKnTyEnn5C+n7K3JjjBibeuKdkWwQ6SiUsDwoYAnMMNqk61Eg1wWBhOi1UIo1eKo3j5j4I/BH4ZSs04vj1H2I7WZHBd0sJf+g3BWUw5vNgOIOAMHkT2c8UCBwksyfYoGPJMbW7jfYWVtBP6tUKv9VVC9p/lLuwZobOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qt823roh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A06DC4AF15;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722423018;
	bh=Dynz9QHhPHZXKKO8GD6i2AnmK4GVgprdx9YpUpdCd88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qt823rohYmRVJijVk2TGpSwApHT+m0YcM75pemMkauB0JNyiYj20EAfYS8nR35U2h
	 gd7x9Z7e76PiKGeKfZ83l3gxRaZtIFuZIGXk9QE6B0pEjGifHbE4giw1bCgUH3ZUnr
	 t7XndlamRYoE3VcZz0O7vgn2uszx1Gwk2O8Dszfeu0fOFXtPhhPZXoXxmAUG2MzF+x
	 +U6fOqCSMAYW1KCz/jUnCFZnZLiXpBdSSDEux0D8LAqOAvCLa/i3UlBEeXduaFutQf
	 BYOLjoSqV8hvWiDGTRjuX2q8rrRV0h8NSxyhhDuQjuF849VmBNifEeTZNJaYA+Aoom
	 u6YIwEBRFsQ7Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49116C52D54;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 31 Jul 2024 16:20:06 +0530
Subject: [PATCH v3 03/13] dt-bindings: PCI: pci-ep: Update Maintainers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-pci-qcom-hotplug-v3-3-a1426afdee3b@linaro.org>
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
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1035;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=5QyilnsJ9fmtdU7GTZXO3WdPGs0Omyndpvk9fplsO9U=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmqhbiWXLtJTjlNETMDM7azE6UNNZ/+BSyYNgB2
 PM0PCX5slWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZqoW4gAKCRBVnxHm/pHO
 9ZD7B/4nj0MZlzCQQDaBTKeZ+pE483Fs54t3lKiHBZlOYBnvaoG7FuJfxfVfXauKlHN4Hy/npdo
 C+bGJAHJxyKGX7wqRJN9HybGr9xeTy7MK7y+yXdifFP3w1hWy8IWWJIoWKsE7YHOBLKrZ1XfHhU
 iSDMnAbaBPrncZn2M8ZgcteoQUPCXfZpv8s5UfeNi+KncWpMN284N1our24zdgfTKg7UTI226+9
 5C8yM2dvlNaMR17hhohIeoKD5f0jtmiU65SOiyLtu2RkTSrXedIwOY2/Hp/fCPHPc2U2NyCxzR2
 6OmbqIoxFr1LqLmFQ490KkfbFmwXYWgYnZR9mpm8R2ex0Gbm
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

Acked-by: Rob Herring (Arm) <robh@kernel.org>
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



