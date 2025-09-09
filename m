Return-Path: <linux-pci+bounces-35748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B89B50292
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 18:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7970F1897E46
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 16:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F9234F497;
	Tue,  9 Sep 2025 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="G26Ppfwu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uhcLEw+F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D2D352FEF;
	Tue,  9 Sep 2025 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435252; cv=none; b=jjjdrqVQesFAzJr3uNfUt2fpjajmFyXtiGOkAdodKhJmVQUzv1wutMie/KOo7bfwY658K6NnZbIY+f44yNNQJKD+dqAEJR6t5ryUaOAPSUPMJxkvP13CkqzW77J73h/Rc8KhLsAEmJjXf7FgID3Ej2e16txAXK0JP8srAqfYLo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435252; c=relaxed/simple;
	bh=hIHfuHkwoJ7qCIeTm7eB7xTst6Uf1IQG1UI8dacbT6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZNSGsVAzR2oEz5kYU/WXTC99lRAOeIJztE997t0PpQsxI/VBsc06dJ6ld90EZIqpkampv/1OPf+Qa6XpmFeWdbra4NUVrgEHL/VlbYAlLqIRth54Pj/Sa4FwZWEOsk/Tp/Nkp01gT3uNQfRYOj6khukcVaEbypO6DVphSiysaT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=G26Ppfwu; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=uhcLEw+F; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cLq3h2098z9t2s;
	Tue,  9 Sep 2025 18:27:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757435248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BKNOBb0vwxlazoow05NYqUcT4q1UWwsxterBmE83so8=;
	b=G26PpfwubzL7DFj7xyo5PxTWePQCkcJHyP6T7irTXzUUBEHwDZz6OQAeZhiTYA1Si+tV9O
	VLdzCllNgfPgHDu4adevmjyZ8eZO/Bcr7INB9VWjtpwPDwwi5nsJjUtncGzRIFMMy5VpIZ
	J2QLqXu8MKZgsb0YG/qKIlEZOuQd0VCRe8sTVoiV0FQ71b0xzUwGqpS7BQ6YNhekClkCjQ
	+JP6e9FU8PziRJrnu0MbFTRpJR3XnYPoFlou8+nSckai1Ppwo48Vp8vf5Ea3Bfnex/+j1M
	obwr71fFZXM0OKzUn71cqeMZlPX5ucX4CSK2nfs9PHBFxefJmfp72+HdPKY21w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757435246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BKNOBb0vwxlazoow05NYqUcT4q1UWwsxterBmE83so8=;
	b=uhcLEw+FbEuvCQozDjoL8osIwEQ8FsxXgInQv7nX/uoImdJWPl1MhInmpFJT53GqkEei6+
	Ms41X0PSvswZvh8/BVOIZ8vbdAa79Ndsg1MMKl+5CmvD6VDWKFbl8pqLqkR/axdM0Ewl/p
	wOEMxF2yGD54AjFstESPQ8jEutFMIaL42xCxfj3bDea/WDaskmhxIapn+co6x2Pah/GwYZ
	A6CGmeMxYjhs4oIkExbnbU5EpJuEGY4/k1s8W+dHQEQbvOUZlkaXb629LKmmUuNX8eby3S
	SxcyhnazvNpbvKEHKr+voxmFd9a1mV8TlfQqsKyObMYToxktu01FoffFbY2VjA==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>,
	stable@vger.kernel.org,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/2] PCI: rcar-host: Drop PMSR spinlock
Date: Tue,  9 Sep 2025 18:26:24 +0200
Message-ID: <20250909162707.13927-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: a9bpr95hgxcnqfggiudz43wic4k3fx1e
X-MBO-RS-ID: 06807477ab19596fa15

The pmsr_lock spinlock used to be necessary to synchronize access to the
PMSR register, because that access could have been triggered from either
config space access in rcar_pcie_config_access() or an exception handler
rcar_pcie_aarch32_abort_handler().

The rcar_pcie_aarch32_abort_handler() case is no longer applicable since
commit 6e36203bc14c ("PCI: rcar: Use PCI_SET_ERROR_RESPONSE after read
which triggered an exception"), which performs more accurate, controlled
invocation of the exception, and a fixup.

This leaves rcar_pcie_config_access() as the only call site from which
rcar_pcie_wakeup() is called. The rcar_pcie_config_access() can only be
called from the controller struct pci_ops .read and .write callbacks,
and those are serialized in drivers/pci/access.c using raw spinlock
'pci_lock' . CONFIG_PCI_LOCKLESS_CONFIG is never set on this platform.

Since the 'pci_lock' is a raw spinlock , and the 'pmsr_lock' is not a
raw spinlock, this constellation triggers 'BUG: Invalid wait context'
with CONFIG_PROVE_RAW_LOCK_NESTING=y .

Remove the pmsr_lock to fix the locking.

Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
Reported-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Reported-by: Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>
Cc: stable@vger.kernel.org
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
=============================
[ BUG: Invalid wait context ]
6.17.0-rc4-next-20250905-00048-ga08e553145e7-dirty #1116 Not tainted
-----------------------------
swapper/0/1 is trying to lock:
ffffffd92cf69c30 (pmsr_lock){....}-{3:3}, at: rcar_pcie_config_access+0x48/0x260
other info that might help us debug this:
context-{5:5}
3 locks held by swapper/0/1:
 #0: ffffff84c0f890f8 (&dev->mutex){....}-{4:4}, at: device_lock+0x14/0x1c
 #1: ffffffd92cf675b0 (pci_rescan_remove_lock){+.+.}-{4:4}, at: pci_lock_rescan_remove+0x18/0x20
 #2: ffffffd92cf674a0 (pci_lock){....}-{2:2}, at: pci_bus_read_config_dword+0x54/0xd8
stack backtrace:
CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.17.0-rc4-next-20250905-00048-ga08e553145e7-dirty #1116 PREEMPT
Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
Call trace:
 dump_backtrace+0x6c/0x7c (C)
 show_stack+0x14/0x1c
 dump_stack_lvl+0x68/0x8c
 dump_stack+0x14/0x1c
 __lock_acquire+0x3e8/0x1064
 lock_acquire+0x17c/0x2ac
 _raw_spin_lock_irqsave+0x54/0x70
 rcar_pcie_config_access+0x48/0x260
 rcar_pcie_read_conf+0x44/0xd8
 pci_bus_read_config_dword+0x78/0xd8
 pci_bus_generic_read_dev_vendor_id+0x30/0x138
 pci_bus_read_dev_vendor_id+0x60/0x68
 pci_scan_single_device+0x11c/0x1ec
 pci_scan_slot+0x7c/0x170
 pci_scan_child_bus_extend+0x5c/0x29c
 pci_scan_child_bus+0x10/0x18
 pci_scan_root_bus_bridge+0x90/0xc8
 pci_host_probe+0x24/0xc4
 rcar_pcie_probe+0x5e8/0x650
 platform_probe+0x58/0x88
 really_probe+0x190/0x350
 __driver_probe_device+0x120/0x138
 driver_probe_device+0x38/0xec
 __driver_attach+0x158/0x168
 bus_for_each_dev+0x7c/0xd0
 driver_attach+0x20/0x28
 bus_add_driver+0xe0/0x1d8
 driver_register+0xac/0xe8
 __platform_driver_register+0x1c/0x24
 rcar_pcie_driver_init+0x18/0x20
 do_one_initcall+0xd4/0x220
 kernel_init_freeable+0x308/0x30c
 kernel_init+0x20/0x11c
 ret_from_fork+0x10/0x20
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/pci/controller/pcie-rcar-host.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 4780e0109e583..625a00f3b2230 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -52,20 +52,13 @@ struct rcar_pcie_host {
 	int			(*phy_init_fn)(struct rcar_pcie_host *host);
 };
 
-static DEFINE_SPINLOCK(pmsr_lock);
-
 static int rcar_pcie_wakeup(struct device *pcie_dev, void __iomem *pcie_base)
 {
-	unsigned long flags;
 	u32 pmsr, val;
 	int ret = 0;
 
-	spin_lock_irqsave(&pmsr_lock, flags);
-
-	if (!pcie_base || pm_runtime_suspended(pcie_dev)) {
-		ret = -EINVAL;
-		goto unlock_exit;
-	}
+	if (!pcie_base || pm_runtime_suspended(pcie_dev))
+		return -EINVAL;
 
 	pmsr = readl(pcie_base + PMSR);
 
@@ -87,8 +80,6 @@ static int rcar_pcie_wakeup(struct device *pcie_dev, void __iomem *pcie_base)
 		writel(L1FAEG | PMEL1RX, pcie_base + PMSR);
 	}
 
-unlock_exit:
-	spin_unlock_irqrestore(&pmsr_lock, flags);
 	return ret;
 }
 
-- 
2.51.0


