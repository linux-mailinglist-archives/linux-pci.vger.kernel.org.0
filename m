Return-Path: <linux-pci+bounces-43061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF05CBFEAF
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 22:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F1EE301516D
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 21:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BBB327790;
	Mon, 15 Dec 2025 21:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPAgoKHw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27220325719;
	Mon, 15 Dec 2025 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765833903; cv=none; b=t1oQ70D2IaqHuIIcxROvfw5l7XRneVW2iL2xLay65p3+u2Eucv66abEcRRrnuUvsS21MooGLCRAFG5/MHwA5x6k4JprD4eqm2S4hmoTKglsKEN+LIEq2aXXYcO+fP3ZJpYZDPRmIFIYUezw0UvOolfwuwnGWO/BmsuhIZXK20cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765833903; c=relaxed/simple;
	bh=M7UaQpz4jW3hjZgi/W6Zm+fYN8tvjLjDw0dBDQ15e5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iu8eP+mq7EHy1mDzjcoAPY1Dh+8SyUrzMYoD3+ZFUC49P0E5ochdazF8x38aSn1EJ4uZB/WMXwdp76d4dTXxmtgMeNivp7k07UUc5Xlf/2x5kG5cuePr6JmB77Ex49XRRmoiHzy9Lm8eP4Z5kdPe4P4IvTFza3p4DoRwycHv94k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPAgoKHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BC6C4CEF5;
	Mon, 15 Dec 2025 21:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765833902;
	bh=M7UaQpz4jW3hjZgi/W6Zm+fYN8tvjLjDw0dBDQ15e5w=;
	h=From:To:Cc:Subject:Date:From;
	b=QPAgoKHwzAjngSr7dD6jsQOt83/ddfFyPv3JcLp+nD1FckJI4CvnsyH0ZFgpTjLGO
	 jfE4lyFoG8jArUnY7vEDdQE6T+20LPtjWSTBMmY29CCKSXb5xrIjgFPf2o62+pOd2c
	 +2PukrEpvdz3LXC0iCGsKFcg0GTdRVlrW17CyZlcmLAhEuQGAtfP6QBhJi4d3SBs1u
	 syk5UyqDf4svXhMQPj9igK//9DxQRDmG4uyBItLv/u/lPXbFjtohbta+HjW4iN04O+
	 8pl0CUlAXHnkNbIBRdfszk6wuHABre1hLkIHEu7cWahjP6Q+VCoDxFa/R79kzlB9YR
	 s0/p09t4Jog9w==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: socionext,uniphier-pcie: Fix interrupt controller node name
Date: Mon, 15 Dec 2025 15:24:56 -0600
Message-ID: <20251215212456.3317558-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The child node name in use by .dts files and the driver is
"legacy-interrupt-controller", not "interrupt-controller".

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/pci/socionext,uniphier-pcie.yaml      | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
index c07b0ed51613..8a2f1eef51bd 100644
--- a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
@@ -51,7 +51,7 @@ properties:
   phy-names:
     const: pcie-phy
 
-  interrupt-controller:
+  legacy-interrupt-controller:
     type: object
     additionalProperties: false
 
@@ -111,7 +111,7 @@ examples:
                         <0 0 0  3  &pcie_intc 2>,
                         <0 0 0  4  &pcie_intc 3>;
 
-        pcie_intc: interrupt-controller {
+        pcie_intc: legacy-interrupt-controller {
             #address-cells = <0>;
             interrupt-controller;
             #interrupt-cells = <1>;
-- 
2.51.0


