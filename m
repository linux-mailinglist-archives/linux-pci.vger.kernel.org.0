Return-Path: <linux-pci+bounces-30499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D37AE63D2
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 13:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C398D4A8070
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 11:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A322628C864;
	Tue, 24 Jun 2025 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCUnO4cS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC8F1EBA09
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750765671; cv=none; b=cB7qQt2cGUxmpYM+MKNNfX483D4GlZDR4/zo/Q4Fk8wqktPbtgv6yph0G993yaN+jrQYfTUWIo6/1vqx/wyu8DU9PuDo2oKIGSWsXkQtaG0rtZxzVUKFBeZ5mI9AfgwurlzLe+BpUQBt3cjPdufCkt6LRPo7w8/kCmcBCaW/TNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750765671; c=relaxed/simple;
	bh=mjLCvG4i4jT1iQPJpPrv788xDaB9dv4iitfM6DJZTMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVcIfDgRXxYjQrtPttCBFdUGeyyO/Jmue5oFziNOTDURCR55SbEdMRLq1pLDodyH+Vw5cqrO2s00xT+tAVmxJQOzmnt15Dzw97z6Js9i6wAXbP+5Mrr0BKx/bPWeaCoLW3M2pvN8LbnwnV7q11ppXqu5LfqfTU7lKXmc3MXWf+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCUnO4cS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A025AC4CEEE;
	Tue, 24 Jun 2025 11:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750765671;
	bh=mjLCvG4i4jT1iQPJpPrv788xDaB9dv4iitfM6DJZTMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jCUnO4cSJp/VJoz1mx2b46cWBP/tdyQoyfRlU1ZAxU/N0bPbfYx2f7D6ueAIqwTP4
	 YBa8sM56v0m4l40swhZRweF0Pzn/LEfDlduyJ33s0F7BTdsXKPmcq8+9+DVEvKamrb
	 STvPPs7IyStQqT4EljjrHup3aRs7DBREvmW0bGWcS90gzox6o4pCLy6d6zBEpQMdq4
	 K9DrJHfzrtXnKIeCs98UlB3mI9tehX79/3jt16GWgtkZ7B31eaE7mnvS2dlIrsn55Q
	 5cI7kMYB4nKfd4B+nG1ToOQhEHzhrww01QHvefZDumRkcJNwnTZ8cl41lQ3Dk27hDA
	 blR9v6gI8AiYA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 2/2] PCI: endpoint: Fix configfs group removal on driver teardown
Date: Tue, 24 Jun 2025 20:45:44 +0900
Message-ID: <20250624114544.342159-3-dlemoal@kernel.org>
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

An endpoint driver configfs attributes group is added to the
epf_group list of struct pci_epf_driver by pci_epf_add_cfs() but an
added group is not removed from this list when the attribute group is
unregistered with pci_ep_cfs_remove_epf_group().

Add the missing list_del() call in pci_ep_cfs_remove_epf_group()
to correctly remove the attribute group from the driver list.

With this change, once the loop over all attribute groups in
pci_epf_remove_cfs() completes, the driver epf_group list should be
empty. Add a WARN_ON() to make sure of that.

Fixes: ef1433f717a2 ("PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/pci-ep-cfs.c   | 1 +
 drivers/pci/endpoint/pci-epf-core.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index d712c7a866d2..ef50c82e647f 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -691,6 +691,7 @@ void pci_ep_cfs_remove_epf_group(struct config_group *group)
 	if (IS_ERR_OR_NULL(group))
 		return;
 
+	list_del(&group->group_entry);
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


