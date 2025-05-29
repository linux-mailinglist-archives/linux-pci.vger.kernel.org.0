Return-Path: <linux-pci+bounces-28521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E529AC75B1
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 04:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734DB4E5017
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 02:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D05B242D96;
	Thu, 29 May 2025 02:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AMZ0r8eC"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5AA242D60;
	Thu, 29 May 2025 02:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748484674; cv=none; b=rEUWtmDUsIN7sFCSv0QfVZ6J1w5STFCCEBzKMciMvyf5vgRzktSZ3jaFAFhQO7jcDZ5aMQxtvygEQ3ZmuqMGBE1zV4srEn1R81u15wN99fZD9HehAsms0YLmG/nfPmiULvmNRiZVAFGNFDua93/Xwb/RGu6prqOnHQd907jIMmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748484674; c=relaxed/simple;
	bh=yROuWMz5tpoccEEXwruiMnFO4fu2RIJRme5SmCASgFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nzbLmUANizksVirDl/DD30fIfWPlI2YhggUzwm8g4At1raAGyqJ8tbnl94XnXAfcqrIoZORG/kHuc5Bso1eUgWt0LBbqv3QUtWThbPeHiG5iPAbKoaf10jYUh/9VjE0s+VeDTs7KRFCjdKA0bB82bY2OpJ+hjhIoBdk2NIywnbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AMZ0r8eC; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=CA
	Fxj+rb/r9uwLufsBzLzI7S2IO7EmqXIwnAuOg88+c=; b=AMZ0r8eCPBNbgrOkCO
	cswKADPPaVzWoblxQNKq6IcooM7terh5zthG9B89AcBzzGvowo7IoU8YxtG9LWxd
	rH4Bk8TQVFenaI8AOtFbu4ZIfx6eNHfeuLFXh00Z5o1ZOf9ubSfZ9Qg+qxGksFkG
	ANdfdYbNzb5DPeqOnRbhtgAJs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wC3we4Uwjdot_dqEg--.40331S4;
	Thu, 29 May 2025 10:10:36 +0800 (CST)
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
Subject: [PATCH v2 2/3] dt-bindings: PCI: pci-ep: Extend max-link-speed to PCIe Gen5/Gen6
Date: Thu, 29 May 2025 10:10:25 +0800
Message-Id: <20250529021026.475861-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250529021026.475861-1-18255117159@163.com>
References: <20250529021026.475861-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3we4Uwjdot_dqEg--.40331S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFWUCrWkCw13Jw18CryxuFg_yoWkWFg_uF
	1xAa1qvr4rJFyYgw4YyF4xtF15Za1jkrs7Cw1kJF1qya48ArWq9F98t3s8Ar1fCayfZF1a
	9F93JrWDXrnrGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRCeHqUUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwhco2g3vlq+nwAAsi

Update the PCI Endpoint (EP) device tree binding documentation to
include PCIe Gen5 and Gen6 support for the `max-link-speed` property.
Similar to the Host Controller binding, the original EP binding
limited this value to 1~4 (Gen1~Gen4). With current SOCs requiring
Gen5/Gen6 support (e.g., Synopsys/Cadence IP), this change aligns
the EP binding with the kernel's PCIe 6.0 capabilities.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
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


