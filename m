Return-Path: <linux-pci+bounces-5990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFBC89E727
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 02:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB00A1C21277
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 00:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9E51388;
	Wed, 10 Apr 2024 00:48:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623B764A;
	Wed, 10 Apr 2024 00:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712710127; cv=none; b=GKFlL5PpHy81VBH6pFptxZEEPYIuq7yyeiaZy92KCUfXZSxmvbZPeip6iroMzM2oaSLF8/xWYA2fcMzropfdNH0N6bicEYdiPS3mM1sMr3Hz9HXk7iib6SqTC2TWVbzLwkx3XqNDrwWAFt287UQFjm3JQytNv2J/URm7HHf4QVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712710127; c=relaxed/simple;
	bh=dGonVUKvl7liV10e3coRejTBfxj+bpKkbHKvOrjwuug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fBQVggrtTqEcyTsermY98pIxrjPB5/TAB2eD0WhO9+gWBOpEPm/UHwGt3Ls9iqJb1lnyt47hZIeUkvIZuO+PuJZz72h83rgeYsTaScIpkcrS5/MWGFZQgQeIoeauqa+JSx4vOANO2aBWV7iipqvb1aJY7Yc6LfHV8Deebg9jGS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.07,190,1708354800"; 
   d="scan'208";a="204871180"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 10 Apr 2024 09:48:36 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 77AB9400F4ED;
	Wed, 10 Apr 2024 09:48:36 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jingoohan1@gmail.com,
	mani@kernel.org
Cc: marek.vasut+renesas@gmail.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v6 2/7] dt-bindings: PCI: rcar-gen4-pci-ep: Add R-Car V4H compatible
Date: Wed, 10 Apr 2024 09:48:27 +0900
Message-Id: <20240410004832.3726922-3-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410004832.3726922-1-yoshihiro.shimoda.uh@renesas.com>
References: <20240410004832.3726922-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document bindings for R-Car V4H (R8A779G0) PCIe endpoint module.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
index fe38f62da066..91b81ac75592 100644
--- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
@@ -16,7 +16,9 @@ allOf:
 properties:
   compatible:
     items:
-      - const: renesas,r8a779f0-pcie-ep   # R-Car S4-8
+      - enum:
+          - renesas,r8a779f0-pcie-ep      # R-Car S4-8
+          - renesas,r8a779g0-pcie-ep      # R-Car V4H
       - const: renesas,rcar-gen4-pcie-ep  # R-Car Gen4
 
   reg:
-- 
2.25.1


