Return-Path: <linux-pci+bounces-44748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76906D1FCD2
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A56A3017859
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 15:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C6E39E6E1;
	Wed, 14 Jan 2026 15:35:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDAE39E19F;
	Wed, 14 Jan 2026 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404954; cv=none; b=Vpz9z9JI35tNqnmSObP/WTfOcxmjTS++fQvVUa3YvBjkG+KpM8qCKXEMPQvnzEwFC+GSQYjT44PePddQelkBQg8QCy2ZR5SmKrG/uwXfGD4zXdT81KyVZYWkzR2aFSUdBQ1dykdlGX4sW3jGbKG7OKhA6S0/UnZifF0Kq9Wjc6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404954; c=relaxed/simple;
	bh=4G8tfVL+PwrbBcnSP2ZAg8xL5VBpwhhBNMPFyxTdSrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNnzlGH3XuDj5rMgACc8dIPt4N4AY7v5YxU+XoikqEojgiN9DzHokw8PUNBaUNK7wDC6zAy/CmubfyQN62YwaxGZZ3tuQwi7R3CLul3qvfRO5qbo+C8LSo4ADJMd18nTuEIEquU6/PbwgqcNYy3cgsEnv/S8CUyB374UHClEG88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 2GDRWKt7QnaqxkITrwa3SQ==
X-CSE-MsgGUID: OmBj0LzOQ6uZgfdYIOsocQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jan 2026 00:35:44 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.178])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 869F04022B3F;
	Thu, 15 Jan 2026 00:35:38 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: claudiu.beznea.uj@bp.renesas.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	geert+renesas@glider.be,
	krzk+dt@kernel.org
Cc: robh@kernel.org,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	john.madieu@gmail.com,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH 01/16] PCI: rzg3s-host: Fix reset handling in probe error path
Date: Wed, 14 Jan 2026 16:33:22 +0100
Message-ID: <20260114153337.46765-2-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
References: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect reset_control_bulk_deassert() call in the probe error
path. When unwinding from a failed pci_host_probe(), the configuration
resets should be asserted to restore the hardware to its initial state,
not deasserted again.

Fixes: 7ef502fb35b2 ("PCI: rzg3s-host: Add Renesas RZ/G3S SoC host driver")
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 5aa58638903f..c1053f95bc95 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1588,7 +1588,7 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 
 host_probe_teardown:
 	rzg3s_pcie_teardown_irqdomain(host);
-	reset_control_bulk_deassert(host->data->num_cfg_resets,
+	reset_control_bulk_assert(host->data->num_cfg_resets,
 				    host->cfg_resets);
 rpm_put:
 	pm_runtime_put_sync(dev);
-- 
2.25.1


