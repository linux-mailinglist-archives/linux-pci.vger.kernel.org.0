Return-Path: <linux-pci+bounces-44749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E4CD1FCDE
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54829301881A
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 15:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462CF39E165;
	Wed, 14 Jan 2026 15:36:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDF639E6DE;
	Wed, 14 Jan 2026 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404960; cv=none; b=LvsA9ugxbvGg7YJya+3/pdbOWChr9a4Wk9ISSKKbzy4GUTB+CA6S236jVItVa6CaWhARcX9fRMHmeYu/j2K8mZCOJTItTAUfq1zYREuO7VHf/c0HfTW5YQUPahYGUMq5lxHdkGZBcHlWtf3RQ5rVy0ETJP7GGvjik4gxfQsv1aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404960; c=relaxed/simple;
	bh=6yMp5evWCo1ffkUYsrdhQSal6c2cp7ciTeWVmzikjIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oquBOUKD6LnwBLeaVkiwCyc6OAXLJnC+O0gHqxsHBWjy93w51wLvjt8D6JqeLPzzfmYqL/yjYOzJRGeqDtYUMli+QzDn9XS/ufSpbqvdeWIHp4D6Jt/6WSKKehgyIP+cSi+t5PY09xBsFuELvZf2VEtLGsZVBocCmELhsg6Mxtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: dAZdDoYhTMWavN0ahfTc2w==
X-CSE-MsgGUID: kw3COy5ZS7KVWPjcEOjvpg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Jan 2026 00:35:50 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.178])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E93C84022B3E;
	Thu, 15 Jan 2026 00:35:44 +0900 (JST)
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
Subject: [PATCH 02/16] PCI: rzg3s-host: Fix inbound window size tracking
Date: Wed, 14 Jan 2026 16:33:23 +0100
Message-ID: <20260114153337.46765-3-john.madieu.xa@bp.renesas.com>
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

The current implementation incorrectly resets size_id each iteration
instead of accumulating, causing incorrect remaining size calculations
when mapping DMA regions across multiple windows.

Fixes: 7ef502fb35b2 ("PCI: rzg3s-host: Add Renesas RZ/G3S SoC host driver")
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index c1053f95bc95..205b60421be1 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1313,7 +1313,7 @@ static int rzg3s_pcie_set_inbound_windows(struct rzg3s_pcie_host *host,
 
 		pci_addr += size;
 		cpu_addr += size;
-		size_id = size;
+		size_id += size;
 		id++;
 	}
 	*index = id;
-- 
2.25.1


