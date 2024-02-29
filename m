Return-Path: <linux-pci+bounces-4246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 543A586C8C5
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 13:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055391F23A0C
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 12:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6D77C6CA;
	Thu, 29 Feb 2024 12:07:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFC17C6EB;
	Thu, 29 Feb 2024 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709208453; cv=none; b=BhSgyoXS+yu6B9pClQtr36RlxKCUF3rfXj8qkrAehrv2+W9JhlS75mRuLnmgp/jeciAGG95CC0VCkmutNbAGY5F8zLXcuNIj6IzEGqsw4bdydW0lziP18mwAz+e9y7sWsxhoi1XPljQBV/kP6XzuBvklb0vFdxh4z7W6Nd9y/wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709208453; c=relaxed/simple;
	bh=zg7n6UwlMs+MTL+PWXm95KJxhyUcIhP/3a5D1Z+u+O4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i+TJj3I4iurO6LzAgC69rSO7nYuzouSqLlnhZ3RH+JJkyUcqPDJMNqeCgceu9ZnNdJds0ooVi7ZaeprotIvI3U5NSthq23mRKiHkKsnKMiMTAwuQqvl5TejFShnipozsuG7v+hExl8QFMJjmdX+TTOAyka3AGrHaLMO+2VMPT9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.06,194,1705330800"; 
   d="scan'208";a="199768931"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Feb 2024 21:07:24 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 330EA400857D;
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
Subject: [PATCH 1/6] dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car V4H compatible
Date: Thu, 29 Feb 2024 21:07:14 +0900
Message-Id: <20240229120719.2553638-2-yoshihiro.shimoda.uh@renesas.com>
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

Document bindings for R-Car V4H (R8A779G0) PCIe host module.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
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


