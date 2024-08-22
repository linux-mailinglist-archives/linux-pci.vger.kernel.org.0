Return-Path: <linux-pci+bounces-11979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE0F95ADDA
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 08:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F231F22F12
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 06:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BC8482D7;
	Thu, 22 Aug 2024 06:45:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7D613B58B;
	Thu, 22 Aug 2024 06:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309105; cv=none; b=fvVIsIgnjP5N1YcUx1xRl43Jv70K40W1BufXeAk6/0MghCgr5rcDw5LMYPxdwP+AjlIS3tX3xy5uEaRhQEx/W1xch7RGXCWXAVojXh+8UbEO+Hcl7GuiT2h2UYYMRmVFK6ye9UjvsVwW0QtffwBoZ1KyI3/yv6eFXSJ2t8e1vPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309105; c=relaxed/simple;
	bh=erH4YLaytYFotOYeAbM5TMWTTNvxvElUoUew++H0vH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oItMR5CIuKwR6G3zzlmLXkoFz+zq/dQffiQB3kQNPJgBzC0xAx4Ze9yoCR0/QBvPa6FAFnnrNUv9/DFmq5wx7eOmcxJqphhQteeOtO23IFX6IOOIsMPY8sYXFTrkgwIx73PxL/2uHYo7hHcFmOmgRQW89r6OHjwjWWljL8MWiHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.10,166,1719846000"; 
   d="scan'208";a="220238795"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 22 Aug 2024 15:45:01 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AE36B4188DE7;
	Thu, 22 Aug 2024 15:45:01 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: marek.vasut+renesas@gmail.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 1/2] dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car V4M compatible
Date: Thu, 22 Aug 2024 15:44:58 +0900
Message-Id: <20240822064459.1133748-2-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822064459.1133748-1-yoshihiro.shimoda.uh@renesas.com>
References: <20240822064459.1133748-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document bindings for R-Car V4M (R8A779H0) PCIe host module.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
index 955c664f1fbb..bb3f843c59d9 100644
--- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
@@ -19,6 +19,7 @@ properties:
       - enum:
           - renesas,r8a779f0-pcie      # R-Car S4-8
           - renesas,r8a779g0-pcie      # R-Car V4H
+          - renesas,r8a779h0-pcie      # R-Car V4M
       - const: renesas,rcar-gen4-pcie  # R-Car Gen4
 
   reg:
-- 
2.25.1


