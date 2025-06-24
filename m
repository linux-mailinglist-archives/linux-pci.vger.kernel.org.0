Return-Path: <linux-pci+bounces-30498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A8DAE63D3
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 13:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51F7E7AD773
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 11:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01090284682;
	Tue, 24 Jun 2025 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PifbXpjs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14381EBA09
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750765670; cv=none; b=DQVh+m7+JZ6aYUlwMhocJTvQsa+2oG68aR+VWwqZjYnHV9q0Pel1MFXsJzgcsdtTLrUdKKR3RXxFHW7ThIUN92RyJi83r0iZ1Jvu9XsT0hwOwD8Gk/HijtV94k2O9cRAzXT42cZZuW+Rod32CBjdZd8qRqAD9S300Q6XRLGUfkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750765670; c=relaxed/simple;
	bh=F9kWnmSwP7L7+kXk9iZ+1nogx7G1TtRpLPLvkj6hbBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYY50pnRJhGXt0K5AJ6rlu5VAuW8+V9Eg32tXyf5gUaunQqSVpshUqodGxzLyo/c8jgFnBSEd3Sqw1dzZjJegp8nMlGLwtUPj78l6T+cE5urH7RmYAdPJ8Y1TJWYHS0kxtydf4CBhJ0k4iLNibDIxjUbT66N1giMgWUU0g82F7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PifbXpjs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0FFC4CEF0;
	Tue, 24 Jun 2025 11:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750765670;
	bh=F9kWnmSwP7L7+kXk9iZ+1nogx7G1TtRpLPLvkj6hbBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PifbXpjsd75V+fri36H8PKaL6pKhqv9Wt6nl/8qPRmPDHp1IShTIwyhVX08gYPi8r
	 HUHVVqyLU5HBuPH01WLd8s9t+UJoCzW0kqZ5gUHN/2XU6wz2ceiHBqeZh12/SLgLQr
	 PJgWR7Ey4+Liml7qScxkztU6NmcvGfc+4XC0KMg/qkpKSJoGIuN/LaZfNqcGfOn0bT
	 vTlYx3cmrDKahbcla+RFFBs2cmZHp4OzkdYN6B7M9Rr7v+7UteA69QsSbTNSrviNtY
	 Xx8/NTzlbJi/yZSBHx/uUsxGHUeqK6EPxC3UzdgtKFy1T1qOyTkZ+LFpgPmXbuvTdV
	 rTQEQRCy78dog==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 1/2] PCI: endpoint: Fix configfs group list head handling
Date: Tue, 24 Jun 2025 20:45:43 +0900
Message-ID: <20250624114544.342159-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624114544.342159-1-dlemoal@kernel.org>
References: <20250624114544.342159-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Doing a list_del() on the epf_group field of struct pci_epf_driver in
pci_epf_remove_cfs() is not correct as this field is a list head, not
a list entry. This list_del() call triggers a KASAN warning when an
endpoint function driver which has a configfs attribute group is torn
down:

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

Remove this incorrect list_del() call from pci_epf_remove_cfs().

Fixes: ef1433f717a2 ("PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/pci-epf-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 577a9e490115..defc6aecfdef 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -338,7 +338,6 @@ static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
 	mutex_lock(&pci_epf_mutex);
 	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry)
 		pci_ep_cfs_remove_epf_group(group);
-	list_del(&driver->epf_group);
 	mutex_unlock(&pci_epf_mutex);
 }
 
-- 
2.49.0


