Return-Path: <linux-pci+bounces-27994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8F0ABC413
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 18:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37CCE7B0E12
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 16:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DA428C5BE;
	Mon, 19 May 2025 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IuNvrJY+"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4002728C5A6;
	Mon, 19 May 2025 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747670733; cv=none; b=kiThrlYkN0Drm9INR509tGnV/solXDbTO5NulFeKD2elBcJb88nah25sVR0ZR7Ivr8VkYLFTZOuQ2m42nkyuvF3GM1YxQwZrSSujmDu0k0yh9xYA6W9r8ST230bR1XJgnhXArZSdZp9raimRb26Yw37zmSENary5ag4qRnDCfA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747670733; c=relaxed/simple;
	bh=noxDf8ZxNrVndhCt9us9NgISd7alcUElHnhr7+XT1yw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bxp+kPy9RCuZ7yTdsfBOyG8/2pCi/F5H4IRKnRelbtlstU0OnNuAU3ikmUvKMSxCnnyQfnnCNwVdQXFwKWn13RKtj4oiPPp5PzhVb5Y8+BQswE4jbnpCQNNVumILUPjwpWnudUDBfDAiugYiR940s0Zw+5u47ISE9kN1KB0qHeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IuNvrJY+; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ay
	UWXvS06kXSWZnFDAYmWnkUal2jYaVwirTfcPuo9Lk=; b=IuNvrJY+ylitbtsoPL
	8BJIrKyfm0zzCfVmp0yke1AewPrb+wmXxrp6w8aLGmwkfw5lbYrz1OL4wLiOak+T
	9PxEkq6HNTQorRD6bWeA5KfQaJ6QvdWNJsbKflgj0qgRQUYEdhlTfs7+4/uOzS/A
	GPJzdywXcnGNRlcV1Op6B4Bsc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDHWSeiVitokozvCQ--.46206S4;
	Tue, 20 May 2025 00:04:52 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	krzk+dt@kernel.org,
	manivannan.sadhasivam@linaro.org,
	conor+dt@kernel.org
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 2/3] dt-bindings: PCI: pci-ep: Extend max-link-speed to PCIe Gen5/Gen6
Date: Tue, 20 May 2025 00:04:47 +0800
Message-Id: <20250519160448.209461-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250519160448.209461-1-18255117159@163.com>
References: <20250519160448.209461-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHWSeiVitokozvCQ--.46206S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFWUCrWkCw13Jw18CryxuFg_yoWDKFc_uF
	1xXa1qvr48JFyYgw4YyF4xt3W5Za12krs7Cw1kJF1qya40yrWq9F98t3s8Ar1fCay3ZF1a
	9F93JrWDXrsrGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKa9aPUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwRSo2grUi5pvQABsE

Update the PCI Endpoint (EP) device tree binding documentation to
include PCIe Gen5 and Gen6 support for the `max-link-speed` property.
Similar to the Host Controller binding, the original EP binding
limited this value to 1~4 (Gen1~Gen4). With current SOCs requiring
Gen5/Gen6 support (e.g., Synopsys/Cadence IP), this change aligns
the EP binding with the kernel's PCIe 6.0 capabilities.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 Documentation/devicetree/bindings/pci/pci-ep.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/pci-ep.yaml b/Documentation/devicetree/bindings/pci/pci-ep.yaml
index f75000e3093d..68aaad70b112 100644
--- a/Documentation/devicetree/bindings/pci/pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/pci-ep.yaml
@@ -33,7 +33,7 @@ properties:
 
   max-link-speed:
     $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [ 1, 2, 3, 4 ]
+    enum: [ 1, 2, 3, 4, 5, 6]
 
   num-lanes:
     description: maximum number of lanes
-- 
2.25.1


