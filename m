Return-Path: <linux-pci+bounces-33223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8511FB16A73
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 04:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776ED3A4653
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 02:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064A686353;
	Thu, 31 Jul 2025 02:33:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3560E8F6C
	for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 02:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753929216; cv=none; b=Mz7YWNBX7Y73rqS8dCwjFiWP7Y/3sGhejkerEivk4qYlxsZ/ywT5PvR6HQqXNAdvjOJWFtT3MkFFexyQ6R99CxPteuh/Di2Ey9dPGCBPWGKXPPmRPRvsxbytr7d8duamFxFYlapZ2r5biwlh/RotcCGGbSw2VtuHXKdNPvWpZro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753929216; c=relaxed/simple;
	bh=A6eJ5o2OSkbTMZW983LlaU9UE9wgeQy0+6Lbaw1JMqw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=gEpVFhSRoZs4oKTxmKjCc84HDRqow8TH+H6n5rynOA18ctJtjHo8kbBv+20OYZhoD7GLFFXKAB16LEspYIbQ1NJm+HGWxzYC6WuoaYaSVNdEKtW1O+JyNiRkeZtqeoCO9QM+p/bEslHJq/2ql3ufqCjtMXGZUKZK9I3kgLwlKe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bec170b26db611f0b29709d653e92f7d-20250731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:30a3c179-95f8-4389-866b-a39be1acea9e,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:9d6529cd32ce44b797805968b2752388,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:5,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bec170b26db611f0b29709d653e92f7d-20250731
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 981165522; Thu, 31 Jul 2025 10:33:30 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH] pci: Fix kernel coding style
Date: Thu, 31 Jul 2025 10:33:26 +0800
Message-Id: <20250731023326.542847-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These changes just fix Linux Kernel Coding Style, no functuional
improve.

-Missing a blank line after declarations
-space required after that ','

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 drivers/pci/setup-bus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7853ac6999e2..119f97b96480 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1402,6 +1402,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct pci_bus *b = dev->subordinate;
+
 		if (!b)
 			continue;
 
@@ -1784,6 +1785,7 @@ static void pci_bus_release_bridge_resources(struct pci_bus *bus,
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct pci_bus *b = dev->subordinate;
+
 		if (!b)
 			continue;
 
@@ -2136,7 +2138,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 		res = &dev->resource[PCI_BRIDGE_MEM_WINDOW];
 		align = pci_resource_alignment(dev, res);
 		resource_set_size(&mmio,
-				  ALIGN_DOWN_IF_NONZERO(mmio_per_b,align));
+				  ALIGN_DOWN_IF_NONZERO(mmio_per_b, align));
 		mmio.start -= resource_size(res);
 
 		res = &dev->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
-- 
2.25.1


