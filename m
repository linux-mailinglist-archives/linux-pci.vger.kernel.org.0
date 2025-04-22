Return-Path: <linux-pci+bounces-26399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E70A96D23
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 15:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDEBC166E9D
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 13:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CBD27700A;
	Tue, 22 Apr 2025 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tajhB1K5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F2422A7FF
	for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745329217; cv=none; b=ZYyy+fX0f3OfpQCMKAec5kg0g5n0n+gvubhNYEeDu0lP0yzfpaALH7ovI7+aSfubckyRFS1dF+JtftGtWXaZV7eEz6hp25kk/G6FpazTHJSgCk0z8AjTYpPrK4QDzTiHlSatLq39hqQxzEwE2w8YuSjn998lm5WvE8ADGwWTvKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745329217; c=relaxed/simple;
	bh=ckFrNhytTIGHxtcRvg4ubnb1zRDET7CdT+Ql84+XTqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rjumwpGXA4dfed4WjyqVQKe/5dWh+3FxKiZuaLkEJu3eBSuifHzNFw1oOQYKmoZ3SzzXOA2l3N6LWfCFFHWk1KoTxUsdvggau7pYMdodtKeCwLTe1ykQcWOKS3KffPeAgSo4u7WwLWiTqotVS5SgzKCfiVatnnc7ZiP09LDl/WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tajhB1K5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48ED9C4CEE9;
	Tue, 22 Apr 2025 13:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745329216;
	bh=ckFrNhytTIGHxtcRvg4ubnb1zRDET7CdT+Ql84+XTqk=;
	h=From:To:Cc:Subject:Date:From;
	b=tajhB1K5TxNqv9gkALhEII5s78VXppaG/qayVfcDPvE0GVeObY7XdumHIOJmwm99f
	 eWF3It62ufsvCtFKiY6cLiMVP50RHffvLwIv1ikI+CPckrCUbgogLvpES4fBAH3dC4
	 t1+XcHBIijTkK34M6WL1Yvj7yyGasakObpf5dLQEgsDl//jIWPChohde/NBDLmRyXl
	 0cFKZoQnmwimKju+gOubIyZjhn65Tk4xBWD25b85qsdrjY/LB6bd+cPdNZ/Na93bKn
	 OKD6HLKmfIdrsNMm/paANb0g5BSPJkMKD9Ys/6yXbkfymytRHLte2KwR4ypIOKEdkd
	 /WfPa09CV7ILg==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	bhelgaas@google.com,
	rafael.j.wysocki@intel.com,
	huang.ying.caritas@gmail.com,
	stern@rowland.harvard.edu
Cc: linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Explicitly put devices into D0 when initializing
Date: Tue, 22 Apr 2025 08:38:09 -0500
Message-ID: <20250422133944.1940679-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

AMD BIOS team has root caused an issue that NVME storage failed to come
back from suspend to a lack of a call to _REG when NVME device was probed.

commit 112a7f9c8edbf ("PCI/ACPI: Call _REG when transitioning D-states")
added support for calling _REG when transitioning D-states, but this only
works if the device actually "transitions" D-states.

commit 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI
devices") added support for runtime PM on PCI devices, but never actually
'explicitly' sets the device to D0.

To make sure that devices are in D0 and that platform methods such as
_REG are called, explicitly set all devices into D0 during initialization.

Fixes: 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI devices")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Note: an earlier internal version of this attempted to do this in local_pci_probe()
but this doesn't affect PCI root ports and we need _REG called on the root ports too.

 drivers/pci/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 53a070394739a..cd87c8370dede 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3266,6 +3266,7 @@ void pci_pm_init(struct pci_dev *dev)
 	pci_read_config_word(dev, PCI_STATUS, &status);
 	if (status & PCI_STATUS_IMM_READY)
 		dev->imm_ready = 1;
+	pci_set_power_state(dev, PCI_D0);
 }
 
 static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
-- 
2.43.0


