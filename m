Return-Path: <linux-pci+bounces-44016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7B2CF38E5
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 13:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7723F30A6AEB
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 12:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B82F33ADB7;
	Mon,  5 Jan 2026 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QiR84lM3"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6A033ADB5;
	Mon,  5 Jan 2026 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615957; cv=none; b=VCJaYxMuDuVr2guA4T2SAFA5Hf24txGm2Vq/f8NcC8STTcjHj6QHyLuwFhXdJIfSP3HRl9g11R4U+2VZmrfTasOn5FN7fdAq3LJCQ3HaSBJBP+nGF7JVE5sYyBXJS2/XUbBJh+PU5Sr77aOXo+2jWWN+62bBBaETf9w8b32eNlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615957; c=relaxed/simple;
	bh=qh8jtoMFPEHHepmGnuAMEkyqmpW4B9KCVYzHVFqxwhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sUoMPqawnoVWaJSfnJ0o+lpK/2pIkhpzT5/lfDdLgUyr0YzDmf/c3oVFLP3R8QL97/E0FgfgTWQdb2Xk0YjDqFtNKFcATDdUwS2HT+mhLGZp5/UWxrmXyP1dYzNWSR5W3FlsFgsvAuAliUqBfLvWAWy2n7dI58BOCr4MKomjoJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QiR84lM3; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767615952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HAJ50QDzcNGq8LvMiguZDX4QYKgW6XNq4PfpmpJ7fsI=;
	b=QiR84lM3TZB4l+3xFAitFbeO9zeHAOpLNHAtziktyk5eD/4piimyWCNMsgcWzw1q2r5yg5
	EqMXve8AXKAI+q/VAaonszFQzyYB4DeuJ7ay2oNGuM1ZHfEFON1jJEsD5yOP4u1zCVj3dF
	XetPVVHB25SXhFSHkH8LPmg2k50XLH0=
From: sunliming@linux.dev
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au
Cc: npiggin@gmail.com,
	chleroy@kernel.org,
	bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunliming <sunliming@kylinos.cn>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH] PCI: pnv_php: Fix smatch warnings about "address of NULL pointer"
Date: Mon,  5 Jan 2026 20:23:45 +0800
Message-Id: <20260105122345.157991-1-sunliming@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: sunliming <sunliming@kylinos.cn>

Fix below smatch warnings:
drivers/pci/hotplug/pnv_php.c:710 pnv_php_alloc_slot() warn: address of NULL pointer
'php_slot->bus'

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202601050123.5JEZ4Znh-lkp@intel.com/
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 drivers/pci/hotplug/pnv_php.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index c5345bff9a55..a22b8d69a479 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -801,6 +801,9 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
 		return NULL;
 	}
 
+	php_slot->bus	                = bus;
+	php_slot->pdev	                = bus->self;
+
 	/* Allocate workqueue for this slot's interrupt handling */
 	php_slot->wq = alloc_workqueue("pciehp-%s", 0, 0, php_slot->name);
 	if (!php_slot->wq) {
@@ -818,8 +821,6 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
 	kref_init(&php_slot->kref);
 	php_slot->state	                = PNV_PHP_STATE_INITIALIZED;
 	php_slot->dn	                = dn;
-	php_slot->pdev	                = bus->self;
-	php_slot->bus	                = bus;
 	php_slot->id	                = id;
 	php_slot->power_state_check     = false;
 	php_slot->slot.ops              = &php_slot_ops;
-- 
2.25.1


