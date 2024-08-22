Return-Path: <linux-pci+bounces-11981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF23795ADE1
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 08:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD11B21145
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 06:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC7013CA97;
	Thu, 22 Aug 2024 06:45:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A8F13B5AE;
	Thu, 22 Aug 2024 06:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309107; cv=none; b=be08twyOUxWfkXXrX+pFNG7e22JI/ScYgO/5ZSMadqFVHRbFBxqon00yF4d41wJpY7g28LElAd55i2jtJ4s9S2GPeEjzYaxDlRU88hrwVusW4RJE7764sJbR3WPt0+RF5BBdDVj+gmpmxnQmY5gqgd5RotZudsPFR2y+iUbtL6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309107; c=relaxed/simple;
	bh=aqNBSgQKzAEbwDNJ0nI1ru/kNAPD8mR5CqdbrpPcrGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lbgloom9WH7Ox3zHTkbeF5TlYWsqOQCCKYqtgYnJ6qD3GH2dpBMNeRs5pILj4xiH4ttYcIVNkFyAS17Nx+pMyBRRHkfM8yZFzANcaPGG4ZDCUSMgcXZRy2alhLfDfl5qhKMdvh2tGqxfpSKPvll88WF5b4T90hFeTeiwPf17tqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.10,166,1719846000"; 
   d="scan'208";a="216265998"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Aug 2024 15:45:01 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D28704188DE7;
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
Subject: [PATCH 2/2] dt-bindings: PCI: rcar-gen4-pci-ep: Add R-Car V4M compatible
Date: Thu, 22 Aug 2024 15:44:59 +0900
Message-Id: <20240822064459.1133748-3-yoshihiro.shimoda.uh@renesas.com>
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

Document bindings for R-Car V4M (R8A779H0) PCIe endpoint module.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
index 91b81ac75592..b23293314a6d 100644
--- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
@@ -19,6 +19,7 @@ properties:
       - enum:
           - renesas,r8a779f0-pcie-ep      # R-Car S4-8
           - renesas,r8a779g0-pcie-ep      # R-Car V4H
+          - renesas,r8a779h0-pcie-ep      # R-Car V4M
       - const: renesas,rcar-gen4-pcie-ep  # R-Car Gen4
 
   reg:
-- 
2.25.1


