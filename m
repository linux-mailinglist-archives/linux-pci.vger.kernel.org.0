Return-Path: <linux-pci+bounces-5142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484CD88B7A3
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 03:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A20F1B22BD2
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 02:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964A25788E;
	Tue, 26 Mar 2024 02:51:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D5E5A7B4;
	Tue, 26 Mar 2024 02:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711421469; cv=none; b=B8+tnzdafSTMXisKDxMerG3c5Mh5nzKm4NA2CQ6tFkO2H8jI5ArpVTqVSD8iH3uWWL+HLo2InAydIc2tFBJLmcQZ3loktQHyo2vkQhok7vlLGlBlBrZ/qQM35pOOvzumqtDjXgIVdC9GSVo7dsfJCCgH+t9OkqeiyqAGz7p0oYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711421469; c=relaxed/simple;
	bh=QHWTwOOMMPET8PzAlJc3PFCQ9tLxuzBQFNBgnWpopiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZD8//HejHVtxziQPhFeJJDfABtQWD94wdfqMOszu4A4AMOay/iSdZsPRGDKjgF/gllrpJMeXtaIBUHi2aWcP3hDaVAr+IWLbQv7WtQHu75yYJuOjeilb177RC2F16qfbkV531HyX2ESE1VySzK/biOke1Dmo6v/aSUYxd0AfCtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.07,154,1708354800"; 
   d="scan'208";a="199248028"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 26 Mar 2024 11:45:57 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 957AC415E8CA;
	Tue, 26 Mar 2024 11:45:57 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com,
	mani@kernel.org
Cc: marek.vasut+renesas@gmail.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/6] dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car V4H compatible
Date: Tue, 26 Mar 2024 11:45:35 +0900
Message-Id: <20240326024540.2336155-2-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240326024540.2336155-1-yoshihiro.shimoda.uh@renesas.com>
References: <20240326024540.2336155-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document bindings for R-Car V4H (R8A779G0) PCIe host module.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
index ffb34339b637..955c664f1fbb 100644
--- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
@@ -16,7 +16,9 @@ allOf:
 properties:
   compatible:
     items:
-      - const: renesas,r8a779f0-pcie   # R-Car S4-8
+      - enum:
+          - renesas,r8a779f0-pcie      # R-Car S4-8
+          - renesas,r8a779g0-pcie      # R-Car V4H
       - const: renesas,rcar-gen4-pcie  # R-Car Gen4
 
   reg:
-- 
2.25.1


