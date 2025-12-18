Return-Path: <linux-pci+bounces-43268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 48472CCB2BA
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 10:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A59CC3034D6C
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 09:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD2A266B67;
	Thu, 18 Dec 2025 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUNZXB4C"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF2E2D320E;
	Thu, 18 Dec 2025 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766050107; cv=none; b=d82mbzlyuKCLL7PVi5StB31KDjV788DMOj5l2yWprNfUc9fURQLl1Bd5I+50pnRYuGvoR6cxeIa2bD/syXGoYfp8kohEsh3miB5wWSINDiml7LEY8nLzc8IRljXJ428hLhzoxP+lBswJ5FD684bhPSSWcg7CjfqIqB82auqp0gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766050107; c=relaxed/simple;
	bh=V+reZobWx5sxpf3YJDZiOH2ZOQJJknEGCB0e6pBI2rA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JcRmK7TOLXz8kU7MxZ/5nJkbC3TluozWa2y4wfNdKdPFHXwzVFuYTXcu+NTGfQbl1ciGuE+k8WBaCPO0MI0moOBY6Ou1wl9edXHaIbDBpQzvqAsx7onVeT0vZWQKSfkMvEU1e/+IcP1nbVvBNIKKvyPHmcdhEuvKWr/pWnUnZ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUNZXB4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81154C4CEFB;
	Thu, 18 Dec 2025 09:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766050106;
	bh=V+reZobWx5sxpf3YJDZiOH2ZOQJJknEGCB0e6pBI2rA=;
	h=From:To:Cc:Subject:Date:From;
	b=RUNZXB4Cr0ndjJ0DrvCOOmAQCG9D+RbXCnKBC1hVoOAMXi7YDUAnL4ivVkOrQ693Y
	 EoY8jcusMX0lLiiouo+VT9wJ3zZlq00utn+XOGdf2XN0G3PuV31K6NBpm3gOSppVQa
	 UjopBzuQ2QKEOfFcIzEhh/0tg8NNBq6HvOtMp9Z7xc9DXFduCDtd45KnF40hKamvtH
	 WMVnLETrxK2RwtkuL/k/xd4pwE5McyNlv47AFUTkav/LdW4nnB/CL+yh0aomQxned8
	 3iG3klKB47vNJmknrcDxvuSTwB46M1tCLrddGJ1qRF6sThu9hqlWybC2qEBKRc8JWb
	 jNM5tky8INVCA==
From: Philipp Stanner <phasta@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] PCI: Remove useless WARN_ON() from devres
Date: Thu, 18 Dec 2025 10:28:20 +0100
Message-ID: <20251218092819.149665-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI's devres implementation contains a WARN_ON() which served to inform
users relying on the legacy devres iomap table that this table does not
support multiple mappings per BAR.

The WARN_ON() can be regarded as useless by now, since mapping a BAR
multiple times is legal behavior and old users of pcim_iomap_table(),
the accessor function for that table, did not break in the past PCI
devres cleanup. New PCI users will hopefully notice that
pcim_iomap_table() is deprecated and are unlikely to use it for mapping
the same BAR multiple times.

Moreover, WARN_ON()s create noisy, difficult to read error messages
which can be more confusing than helpful, since they don't inform the
user about what precisely the problem is.

Remove the WARN_ON().

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/pci/devres.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 9f4190501395..f075e7881c3a 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -469,9 +469,6 @@ static int pcim_add_mapping_to_legacy_table(struct pci_dev *pdev,
 	if (!legacy_iomap_table)
 		return -ENOMEM;
 
-	/* The legacy mechanism doesn't allow for duplicate mappings. */
-	WARN_ON(legacy_iomap_table[bar]);
-
 	legacy_iomap_table[bar] = mapping;
 
 	return 0;
-- 
2.49.0


