Return-Path: <linux-pci+bounces-30482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9229AE5F02
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 10:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE11F3B491D
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 08:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF19A257AEC;
	Tue, 24 Jun 2025 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oE1Agwco"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B35D248F59
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753316; cv=none; b=vGIRUi14zO2+x/+e6ICLRIx8RH/qHUu65xHYzBWiY7t3ee6HFai+lBLO+2abDYrx0YH6LL7HcK/CuxJfsM98t5E8J4qd7stNsNUuk1ZU+rzLTEDkPeD66PXUm9zGxmYWTv6dsEffBs4pgt+AuxM5Ooua3BIgSJankpg8Zi9co6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753316; c=relaxed/simple;
	bh=9Tw/svMKcBlYFUH4u1cAEbUgml0veNjRMJK1Pzk7uW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knPhjcawx6uzs3JkyVo9cQD1uJggqbzHE8UkQ24wio67w3oDbZqrozs6c7YSz+0kE1zWt+qb6/YSkOhkINEJAkCdxq+Ubci9HQH73GpkUtilNkdRAIodo/kmm7vNs0VioaLEXdGxNm6KSRgv1ok52sWvpu1KjOEf8fW68nK9EAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oE1Agwco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4770C4CEF3;
	Tue, 24 Jun 2025 08:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750753316;
	bh=9Tw/svMKcBlYFUH4u1cAEbUgml0veNjRMJK1Pzk7uW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oE1AgwcosKg4Ea/iBiQSY5yfPtjG5Xqfi/rPv5/DrSpdrCG15m3bcJ2oUdJw2XxW3
	 erS35If9Lzxe3Axf3ZGFt7cg4DVEQb/iiMEBdTrvPFD5Ws9JUxYs6U99DTuVeR+rJ7
	 09Hhq1R89RGrx5ri1VonYNvOriqDj2cXo6mBi1tNuIp217bTTWr5HVj1Y3jsaNq+9U
	 a9JwU98Hq+130vBheDJAKF04/ruz9P0MgMLz3p23r3yymnu9XoRxdQTM9m1AIt1wQI
	 BOeEXvvFT6UgbKxo/MIC6HZx25JJvaDj8JR5tQZ/+jZ5C90CURrGB9eQ8201Rnf4vo
	 B9XQ5VDbAqkRA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 2/2] PCI: endpoint: Fix configfs group removal on driver teardown
Date: Tue, 24 Jun 2025 17:19:49 +0900
Message-ID: <20250624081949.289664-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624081949.289664-1-dlemoal@kernel.org>
References: <20250624081949.289664-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An endpoint driver configfs attributes group is added to the
epf_group list of struct pci_epf_driver by pci_epf_add_cfs() but an
added group is not removed from this list when the attribute group is
unregistered with pci_ep_cfs_remove_epf_group().

Add the missing list_del_init() call in fpci_ep_cfs_remove_epf_group()
to correctly remove the attribute group from the driver list.

With this change, once the loop over all attribute groups in
pci_epf_remove_cfs() completes, the driver epf_group list should be
empty. Add a WARN_ON() to make sure of that.

Fixes: ef1433f717a2 ("PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/endpoint/pci-ep-cfs.c   | 1 +
 drivers/pci/endpoint/pci-epf-core.c | 1 +
 2 files changed, 2 insertions(+)

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
index defc6aecfdef..167dc6ee63f7 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -338,6 +338,7 @@ static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
 	mutex_lock(&pci_epf_mutex);
 	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry)
 		pci_ep_cfs_remove_epf_group(group);
+	WARN_ON(!list_empty(&driver->epf_group));
 	mutex_unlock(&pci_epf_mutex);
 }
 
-- 
2.49.0


