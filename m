Return-Path: <linux-pci+bounces-27387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E06E5AAE52C
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 17:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C554C1C43156
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 15:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C3C28B3FB;
	Wed,  7 May 2025 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmlLLJwN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87FF19CD07;
	Wed,  7 May 2025 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632594; cv=none; b=tRK5IrZVFQ7YyKPEo1r5jjgjQ0XPfT2G+WimPIAcQxi6dhWj3Pm9cSAaR5Pfm7g//r0K7EVgpg1fwK4DViXtO69ije4FnbL02FfToYnUiLdFb9+WvorKALa6Ac7muG/ils19YKdmWo9hB9N3AP5idfzuZYRnZwYDnYPS0wAiAoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632594; c=relaxed/simple;
	bh=rR8OrlMotJbouypp9SJ0FCBRopfgKKhZwEBcrprcrEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T8DO1Mk+KUIrcDYD97gLAzEDpiIJvVAIpXehudiRIEdrmTDUNBCr456289dDqvQVdN6c1OM5xB7z3Sai8F5JfUAtRbAnct1q+n6QQPH+fP29vy+vEzpARn4nUEboD39N/bGbp82hRKM+Fw0DQWXoeh8ywdu7GMB+DPUX1NuSCtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmlLLJwN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B21C4CEE9;
	Wed,  7 May 2025 15:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746632594;
	bh=rR8OrlMotJbouypp9SJ0FCBRopfgKKhZwEBcrprcrEY=;
	h=From:To:Cc:Subject:Date:From;
	b=bmlLLJwNr9g5MlYlkFqvj8tih9yIRfiOgZJl+1zp2G1/ZlaA5+X7IEG+J+20mK5j0
	 vl6J8dMwVuuEb+9Ahe3OYYpNeE2HV7l02d6bx2Y+l1Q3oE1VFK3EBKGG16vjkPdReu
	 e2cfae2uDEKXv1E1rJLy/DSiQ+cINJA5f2MOGIZmyF2R9UqaXzQnt5t/TItd4lGmfN
	 8RHtUayJmuL00E7ZY6d4oJYiqyUghD7CPxXN8LleJpp4BDlJRofRtoCYHy8oF9XEnM
	 VPCZFMQ5nqGe4L1EvoXqWLdHfel27GYr7v6k8r5KZymcBiF+k3vDWzJc0Bha1Xpn6W
	 171p8kBGSVIWg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joyce Ooi <joyce.ooi@intel.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH] dt-bindings: Move altr,msi-controller to interrupt-controller directory
Date: Wed,  7 May 2025 10:42:53 -0500
Message-ID: <20250507154253.1593870-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While altr,msi-controller is used with PCI, it is not a PCI host bridge
and is just an MSI provider. Move it with other MSI providers in the
'interrupt-controller' directory.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../{pci => interrupt-controller}/altr,msi-controller.yaml      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/{pci => interrupt-controller}/altr,msi-controller.yaml (94%)

diff --git a/Documentation/devicetree/bindings/pci/altr,msi-controller.yaml b/Documentation/devicetree/bindings/interrupt-controller/altr,msi-controller.yaml
similarity index 94%
rename from Documentation/devicetree/bindings/pci/altr,msi-controller.yaml
rename to Documentation/devicetree/bindings/interrupt-controller/altr,msi-controller.yaml
index 98814862d006..d046954b8a27 100644
--- a/Documentation/devicetree/bindings/pci/altr,msi-controller.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/altr,msi-controller.yaml
@@ -2,7 +2,7 @@
 # Copyright (C) 2015, 2024, Intel Corporation
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/altr,msi-controller.yaml#
+$id: http://devicetree.org/schemas/interrupt-controller/altr,msi-controller.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Altera PCIe MSI controller
-- 
2.47.2


