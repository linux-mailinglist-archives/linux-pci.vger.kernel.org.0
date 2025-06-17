Return-Path: <linux-pci+bounces-29904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70389ADBE5B
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 03:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7129B3B5290
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 01:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5195C603;
	Tue, 17 Jun 2025 01:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBxm3ECH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FEE2BF01B
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 01:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750122575; cv=none; b=qfTrFq574ty+IP4w/GB1wX9K7tfFfHKXCN6J/qx4z9XI1jYposdPYuZDgJLXwCLc4nQuSYMZxkhigkePtkHVe/v6RDX/S42v1yqoofVhCIqYmX37TKUcuJpaUSTOQakUpZrb6mn37N2q4c6wMbn84hvNdUa4/21eEJR/fZGaed0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750122575; c=relaxed/simple;
	bh=HI0k4kycKyIRaxjPbyswh5j+Jrcxp+E0ms+lubbyPtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GP+WB8L9Of/gdsAOHyPux82adcu1u04h6ukTMM4jXrgBCxZEtWVPstp/Zd9wLXq6XGBlC86RqXQeJUN/QP7qXx59CrSZEvLuktM93MP5cUevt/xbG/f8D38wCD+fEwdXuy+kxGPPhSERwCW+LDmuY5z/VU9VTLQwq7p+Xy47UG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBxm3ECH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85942C4CEEA;
	Tue, 17 Jun 2025 01:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750122574;
	bh=HI0k4kycKyIRaxjPbyswh5j+Jrcxp+E0ms+lubbyPtQ=;
	h=From:To:Cc:Subject:Date:From;
	b=hBxm3ECHN85gXGXe5VPni8kxMTq4yo1svMXcM7DIJhzAesw7SjNwgV/2Arn6t4Ipa
	 Vl3kuDW19pj12NqASQYYRwtQsWHFFoMv05iRJYIfXhrfsT7XieEadybj9HQKxqq7dv
	 oSTU7/Cj9KPwO8KXzJ0L77TOO5udatBRZl+qcY2FTvoFSXIec7toWVpO4hLYEUz3sq
	 Rz3KH5oYCGVYEHUXMwJTXHQwjK10FGGYWD9tIIAoCg6EW3x3inFN9Q8QUjRDueL35X
	 E1eqetaSVeiIe906S70xu1RGr0I+Ef3ROURoL31OyFOUt9KSmlZRXkSA8t6vJnsmSH
	 w+EtFDvM3KotA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] PCI: endpoint: Fix configfs group removal on driver teardown
Date: Tue, 17 Jun 2025 10:07:37 +0900
Message-ID: <20250617010737.560029-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An endpoint driver configfs attributes group is added to the
epf_group list of struct pci_epf_driver pci_epf_add_cfs() but not
removed from this list when the attribute group is unregistered with
pci_ep_cfs_remove_epf_group(). Add the missing list_del_init() call in
that function to correctly remove the attribute group from the driver
list.

Furthermore, doing a list_del() on the epf_group field of struct
pci_epf_driver in pci_epf_remove_cfs() is not correct as this field is a
list head, not a list entry, and triggers a KASAN warning:

==================================================================
BUG: KASAN: slab-use-after-free in pci_epf_remove_cfs+0x17c/0x198
Write of size 8 at addr ffff00010f4a0d80 by task rmmod/319

CPU: 3 UID: 0 PID: 319 Comm: rmmod Not tainted 6.16.0-rc2 #1 NONE
Hardware name: Radxa ROCK 5B (DT)
Call trace:
show_stack+0x2c/0x84 (C)
dump_stack_lvl+0x70/0x98
print_report+0x17c/0x538
kasan_report+0xb8/0x190
__asan_report_store8_noabort+0x20/0x2c
pci_epf_remove_cfs+0x17c/0x198
pci_epf_unregister_driver+0x18/0x30
nvmet_pci_epf_cleanup_module+0x24/0x30 [nvmet_pci_epf]
__arm64_sys_delete_module+0x264/0x424
invoke_syscall+0x70/0x260
el0_svc_common.constprop.0+0xac/0x230
do_el0_svc+0x40/0x58
el0_svc+0x48/0xdc
el0t_64_sync_handler+0x10c/0x138
el0t_64_sync+0x198/0x19c
...

Remove this list_del() call from pci_epf_remove_cfs() and replace it
with a warning if the epf_group list is not empty.

Fixes: ef1433f717a2 ("PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/endpoint/pci-ep-cfs.c   | 1 +
 drivers/pci/endpoint/pci-epf-core.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index d712c7a866d2..63876537e7dc 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -691,6 +691,7 @@ void pci_ep_cfs_remove_epf_group(struct config_group *group)
 	if (IS_ERR_OR_NULL(group))
 		return;
 
+	list_del_init(&group->group_entry);
 	configfs_unregister_default_group(group);
 }
 EXPORT_SYMBOL(pci_ep_cfs_remove_epf_group);
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 577a9e490115..167dc6ee63f7 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -338,7 +338,7 @@ static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
 	mutex_lock(&pci_epf_mutex);
 	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry)
 		pci_ep_cfs_remove_epf_group(group);
-	list_del(&driver->epf_group);
+	WARN_ON(!list_empty(&driver->epf_group));
 	mutex_unlock(&pci_epf_mutex);
 }
 
-- 
2.49.0


