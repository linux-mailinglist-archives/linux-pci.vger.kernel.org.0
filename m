Return-Path: <linux-pci+bounces-39319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F567C09532
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 18:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FA724F9ECF
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 16:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83C23043D4;
	Sat, 25 Oct 2025 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cULVP5y9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDFD3043CD;
	Sat, 25 Oct 2025 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761408823; cv=none; b=sXSwonvfJZ3PS3fIzf4+chlOM9xy2D2/dlmLp82hQOn7hSiOk9qeKCvf+l6I9gkLMu/12j/CK98Ptye+BJY7sk/heJJTlOdfiqLIAPzI+xehnYZZGneyzX+AsLV7WGG4/GSbs/LtEwL6a6ZHR8nzA+HxItVW4pdCq+WjfsYmcg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761408823; c=relaxed/simple;
	bh=b4TnuM5r5LEOWG26HLo90ipWlCN4YEvRfomuc6RUuHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uUQSNnriJEDEnp/Q3mwuUWtzPodnk0kRArzzo0LZdhMhI0uAdU9bOHMQcHlf7FJcVr7Xiv1f6S1a1A1wzPD62C7YB3muUl4N1ZgTSWaaZhnccyHW4t+bjsRbYFd3PYygUXYYP09XcjKtScle9n/w+Xi6qyDVYrlYTWdHrY9EVK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cULVP5y9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A7FC4CEF5;
	Sat, 25 Oct 2025 16:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761408823;
	bh=b4TnuM5r5LEOWG26HLo90ipWlCN4YEvRfomuc6RUuHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cULVP5y9oUJNGY0ZQz9hDYQS29nI9+Wwxf53xzEPIRTaOjzr9e42VDGkB41qjEOHU
	 PYfW1btUThFtzP8ovpQPGgXgdrOLrvscmP0XNPYxCgUw/q+OR8iLnNhXbByfh+tNeu
	 L1TxOTtv8358PGrvYQ66T/60XHLRBC8ZmxrGmCkcSjKyuTNR8yrjvLqSH3IV+cA8B5
	 Vkh1KTGjfX1uRpty6XmUksHwtYjHK421/IG8TWFW1ijH766P1Vnt0hX+q4ogaKHbkC
	 CoPD96+oMH8kJw4dwe2mOlnVYld8fGW60JAqE+rogA2ZV/mSEnM39nezcTZBf9BtdP
	 njAbLcYBCzeuQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.12] PCI: Set up bridge resources earlier
Date: Sat, 25 Oct 2025 11:55:17 -0400
Message-ID: <20251025160905.3857885-86-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit a43ac325c7cbbfe72bdf9178059b3ee9f5a2c7dd ]

Bridge windows are read twice from PCI Config Space, the first time from
pci_read_bridge_windows(), which does not set up the device's resources.
This causes problems down the road as child resources of the bridge cannot
check whether they reside within the bridge window or not.

Set up the bridge windows already in pci_read_bridge_windows().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20250924134228.1663-2-ilpo.jarvinen@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES
- `pci_alloc_child_bus()` copies each subordinate bus window to
  `child->resource[i] = &bridge->resource[PCI_BRIDGE_RESOURCES+i]`
  before any child is scanned (`drivers/pci/probe.c:1245-1248`). Without
  this patch, those `bridge->resource[...]` entries are still zeroed;
  the first call to `pci_read_bridge_windows()` only logged with a
  stack-local `struct resource`.
- Child drivers often probe immediately (device_add → bus_probe_device)
  while the bus scan is still in progress. During their
  `pci_enable_device()` they hit `pci_claim_resource()`
  (`drivers/pci/setup-res.c:154-169`), which calls
  `pci_find_parent_resource()` to make sure the BAR sits inside an
  upstream bridge window (`drivers/pci/pci.c:737-767`). Because
  `pcibios_fixup_bus()` (the point where `pci_read_bridge_bases()` re-
  reads the window into the real resource) runs only after the entire
  bus has been scanned (`drivers/pci/probe.c:3091-3106`), the parent
  window is still zero and the containment test fails. Result:
  `pci_enable_device()` reports “can't claim; no compatible bridge
  window” and the device never comes up behind that bridge.
- The patch fixes that race by writing the values directly into the
  bridge’s real resources the first time we read config space
  (`drivers/pci/probe.c:540-588`). When the subordinate bus is created,
  the copied pointers already describe the real aperture, so drivers can
  claim their BARs successfully even if they probe before the later
  fixup.
- Behavioural risk is negligible: we still populate the same resource
  structures with the same data, only earlier; the later
  `pci_read_bridge_bases()` call simply refreshes them with `log=false`.
  No new dependencies or behavioural changes outside this bug fix path,
  making it safe for stable.

Natural next step: consider tagging with a `Fixes` reference upstream to
ease stable selection.

 drivers/pci/probe.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a56dfa1c9b6ff..0b8c82c610baa 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -524,10 +524,14 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
 	}
 	if (io) {
 		bridge->io_window = 1;
-		pci_read_bridge_io(bridge, &res, true);
+		pci_read_bridge_io(bridge,
+				   pci_resource_n(bridge, PCI_BRIDGE_IO_WINDOW),
+				   true);
 	}
 
-	pci_read_bridge_mmio(bridge, &res, true);
+	pci_read_bridge_mmio(bridge,
+			     pci_resource_n(bridge, PCI_BRIDGE_MEM_WINDOW),
+			     true);
 
 	/*
 	 * DECchip 21050 pass 2 errata: the bridge may miss an address
@@ -565,7 +569,10 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
 			bridge->pref_64_window = 1;
 	}
 
-	pci_read_bridge_mmio_pref(bridge, &res, true);
+	pci_read_bridge_mmio_pref(bridge,
+				  pci_resource_n(bridge,
+						 PCI_BRIDGE_PREF_MEM_WINDOW),
+				  true);
 }
 
 void pci_read_bridge_bases(struct pci_bus *child)
-- 
2.51.0


