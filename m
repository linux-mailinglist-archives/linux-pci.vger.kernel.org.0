Return-Path: <linux-pci+bounces-43022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FCBCBB91F
	for <lists+linux-pci@lfdr.de>; Sun, 14 Dec 2025 10:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5CBF300795D
	for <lists+linux-pci@lfdr.de>; Sun, 14 Dec 2025 09:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7981DED63;
	Sun, 14 Dec 2025 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="lCJ00w6B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-81.smtpout.orange.fr [80.12.242.81])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD12D3B8D7D;
	Sun, 14 Dec 2025 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765706084; cv=none; b=Th2dX7yYEXhuG6Tomxuwwhju/V0/+8/T4zSO3YuLpA1nA81miqUCMlp5fQSuKhklIlS2lUUJ6vzoltvnslEKlRfQSfy0iOhSaWgYbCVppo4UUFvI//2Om2V72Nkw32p3bmw81FtFwWIG28N7zdG+dE9FVCOw9jT6zUGKo9D+hQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765706084; c=relaxed/simple;
	bh=MiLYoG6Ha8Ec/c9s/f0uvsanOJ/j30qQus8nDksp+IY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lTIjQD2030r45V1vxqI+kJIla4Ao0U10EFEV0btyNvHjZlcZrr5Hys56NXU79XDeIKDTR8lB/J7b3S5Ihrd2vtjVdbXhIeLcJM6iP0H4iqJDt8I6sbtP/EKbLj3s8D0X62Fx5J/g+fSMik7X0OeG64GD6jWO5OTxuCps95no8ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=lCJ00w6B; arc=none smtp.client-ip=80.12.242.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id UifTvmqh4YUkFUifUvMFRl; Sun, 14 Dec 2025 10:45:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1765705532;
	bh=nLHwS7D5TJkT1/L8Qlt5PBuPvdd4HPre2Bq5lOBMk0c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=lCJ00w6B0kznumKwcfEFK4G9+8MYLYTbfq/QOJaNEqCQAuxCYw/zifkMFwH8/1EXN
	 q49nx4tmERu6UKDlrTeyEFenrrznyAmpWYngKRsb4zKi6wThGHIqRkc7TUXY1hl/+8
	 wvKOVNNI3RyJl3KSLBSbyhk+AJyLNX/WRE/in+MW45LBhpeX5+hWAEnxj+avFaoO4G
	 t5wnLykCapbQGR3Si5bPaQyODzvDWRNE+LBPzuXJbnlrJXChylPvmfuxDkjLJ2UB2H
	 SjzWj3OHNJf4T+LqULeunaYcP+jBSJaBrcLIC87Yoqac8f5mIEYPPtNHl9rKMgau0E
	 6QlamZSiXdgTQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Dec 2025 10:45:32 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pci@vger.kernel.org
Subject: [PATCH] scsi: target: Constify struct configfs_item_operations and configfs_group_operations
Date: Sun, 14 Dec 2025 10:45:29 +0100
Message-ID: <f1f05f6c1bc0c6f37cd680f012fe08c525364968.1765705512.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct configfs_item_operations' and 'configfs_group_operations' are not
modified in this driver.

Constifying these structures moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  27503	  12184	    256	  39943	   9c07	drivers/pci/endpoint/pci-ep-cfs.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  27855	  11832	    256	  39943	   9c07	drivers/pci/endpoint/pci-ep-cfs.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

This change is possible since commits f2f36500a63b and f7f78098690d.
---
 drivers/pci/endpoint/pci-ep-cfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index ef50c82e647f..034a31c341c9 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -85,7 +85,7 @@ static void pci_secondary_epc_epf_unlink(struct config_item *epc_item,
 	pci_epc_remove_epf(epc, epf, SECONDARY_INTERFACE);
 }
 
-static struct configfs_item_operations pci_secondary_epc_item_ops = {
+static const struct configfs_item_operations pci_secondary_epc_item_ops = {
 	.allow_link	= pci_secondary_epc_epf_link,
 	.drop_link	= pci_secondary_epc_epf_unlink,
 };
@@ -149,7 +149,7 @@ static void pci_primary_epc_epf_unlink(struct config_item *epc_item,
 	pci_epc_remove_epf(epc, epf, PRIMARY_INTERFACE);
 }
 
-static struct configfs_item_operations pci_primary_epc_item_ops = {
+static const struct configfs_item_operations pci_primary_epc_item_ops = {
 	.allow_link	= pci_primary_epc_epf_link,
 	.drop_link	= pci_primary_epc_epf_unlink,
 };
@@ -257,7 +257,7 @@ static void pci_epc_epf_unlink(struct config_item *epc_item,
 	pci_epc_remove_epf(epc, epf, PRIMARY_INTERFACE);
 }
 
-static struct configfs_item_operations pci_epc_item_ops = {
+static const struct configfs_item_operations pci_epc_item_ops = {
 	.allow_link	= pci_epc_epf_link,
 	.drop_link	= pci_epc_epf_unlink,
 };
@@ -508,7 +508,7 @@ static void pci_epf_release(struct config_item *item)
 	kfree(epf_group);
 }
 
-static struct configfs_item_operations pci_epf_ops = {
+static const struct configfs_item_operations pci_epf_ops = {
 	.allow_link		= pci_epf_vepf_link,
 	.drop_link		= pci_epf_vepf_unlink,
 	.release		= pci_epf_release,
@@ -662,7 +662,7 @@ static void pci_epf_drop(struct config_group *group, struct config_item *item)
 	config_item_put(item);
 }
 
-static struct configfs_group_operations pci_epf_group_ops = {
+static const struct configfs_group_operations pci_epf_group_ops = {
 	.make_group     = &pci_epf_make,
 	.drop_item      = &pci_epf_drop,
 };
-- 
2.52.0


