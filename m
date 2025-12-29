Return-Path: <linux-pci+bounces-43792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A961CE67AD
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 12:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EDD73006F51
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 11:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C472FB998;
	Mon, 29 Dec 2025 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="XsU5drk0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-78.smtpout.orange.fr [80.12.242.78])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6622FB0B3;
	Mon, 29 Dec 2025 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767006838; cv=none; b=tBZY0I9V/iZLO6m8ajvWoGfax3aBGePA9nagabN/uh5iVW2Gc4j4bp2uQk2/Qbx+ZRsvl+uXavA6LVPdqP9v0z/W3S4RFiI4GYWeKlYBdw2/6HreFjG8dr5C8AVQrvzA6ybzGEYlDn/EeYJz5KJP+hDu9a5g8QdlRBe/JXnlAQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767006838; c=relaxed/simple;
	bh=t8eIzymrbdHrQA+b3JamKmmeJVL0NGLKfnKj9qgihOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aC4cveqp/K1xMtjiWOtWduu4AyQT3iLFDVu/cKq234P7r/wju0hf3FxgBqzJMvVUZwPMGQEvY6xFYMWexl/HDzZPNuqjLEiVrw7e9rOf2GS6PcwiIH/YJOGkJEhIommB7n5GiJhb3NcDd8MAixVNi6ysAcIXd2VnxG+DeQ/3CPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=XsU5drk0; arc=none smtp.client-ip=80.12.242.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id aBC6vvD2mjIvCaBC6vCtGe; Mon, 29 Dec 2025 12:13:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1767006826;
	bh=YkFbAuH7Yxt6j+6bikm0zBXNt47AASMl8TdJe7fm9fY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=XsU5drk05qMxP33ExH+AeyRbo/KHWP6h3Nu6Tdx7bphccpLgm141abn6ZtAMCgvVR
	 3YCSG+Md1dCEZYQ+Et2k9CLz0JXb33Fazgk980o37uYL1b3xCbWahNMHWx7kcMZNgI
	 /tHTQU+lhqhTZQ+16ldjJ1leI/zqcXaZFZ/SkCcBGS4WqvIbmtx4ubYeEcSTajDV3b
	 sTPc/UXOEQczw+Rwkz8oF7Ll9kGT0/jOY6hH8FRw7IG63BDV2cQR4qLYh603gfxmyM
	 hT7Iw8g6P+qYkkxET9QwXF4N1XKFcSvT2Y1jfNxaG5oVLHUAn5/328R6tuAp6QrrOh
	 LfbqQefOf4hxg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 Dec 2025 12:13:46 +0100
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
Subject: [PATCH v2] PCI: endpoint: Constify struct configfs_item_operations and configfs_group_operations
Date: Mon, 29 Dec 2025 12:13:29 +0100
Message-ID: <f1f05f1c10c6caf37dd620fa12f508c53536996b.1765705512.git.christophe.jaillet@wanadoo.fr>
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

Changes in v2:
   - Fix the subject line (was scsi: target:...)    [Bjorn Helgaas]

v1: https://lore.kernel.org/lkml/f1f05f6c1bc0c6f37cd680f012fe08c525364968.1765705512.git.christophe.jaillet@wanadoo.fr/
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


