Return-Path: <linux-pci+bounces-4249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA3D86C8D0
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 13:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E63EB22FFE
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 12:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753F77D06A;
	Thu, 29 Feb 2024 12:07:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADA87CF30;
	Thu, 29 Feb 2024 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709208456; cv=none; b=eu0kCCfZT5F3SjHR1nTv1c/bYTosokJlP/IDXNZgtYe5RfEIdov8WuLi0jTJp17mLmYtvpbmvS2YUAuvSs2QadcHzbJHfoyhQFSHCu5dj/NPb/s8b1ajUpFlzP9UhLU9Yd/OyIeAo+s78VZFiO1dB7h6aZVrB092VKOcUVD/Umc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709208456; c=relaxed/simple;
	bh=/FFfEomu6fYMdhxeZFy2P5C2gv/ZA6OCkelbPwL8e7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q1iuvRlEsI7gjF79JxotcD+xZRXRh0AIkAGgqzcW1AV8XR+Yt6N7T6/5jZ8UJxyD/jK5nsk18xgCsa4mWUrUnLMM65QVNtlZWyaAroI9Ke/IbCnN6K4cHprBGrx3169a6wEctQ7zNtz0l+p54EnoDfGlAMaQ0IpicZaWefmSOoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.06,194,1705330800"; 
   d="scan'208";a="195830394"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Feb 2024 21:07:24 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5A187400857D;
	Thu, 29 Feb 2024 21:07:24 +0900 (JST)
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
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 2/6] dt-bindings: PCI: rcar-gen4-pci-ep: Add R-Car V4H compatible
Date: Thu, 29 Feb 2024 21:07:15 +0900
Message-Id: <20240229120719.2553638-3-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240229120719.2553638-1-yoshihiro.shimoda.uh@renesas.com>
References: <20240229120719.2553638-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document bindings for R-Car V4H (R8A779G0) PCIe endpoint module.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
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


