Return-Path: <linux-pci+bounces-44755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 444BDD1FDB0
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D20EA30CB88D
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 15:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6EF39E165;
	Wed, 14 Jan 2026 15:36:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D01279327;
	Wed, 14 Jan 2026 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404990; cv=none; b=m4zsYC/fNkSa/elRxyY8VrnAoFgtmY299mF30uG/WY0FvX04/fhSWl8Rp4Vfnn0aa1Yo5bisRiBEvAvqU172j+U4ojYXYrUkyB/ypqx8XsOfU/wQIEU2bGcrapBRIaPXUMirKvyd6BNBQFVTscOn6x+K+2/v6SgwPKv868pWy9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404990; c=relaxed/simple;
	bh=+gdviEdln4vVIlD640KlFBvvTyDddNA3p3qbEEBUSbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkMKYtACaeDrK1kWxPaw203E+8GjqHB19t4wAv+BtDOdyIIp3+MaMrUue661LyzNAJonTuXlEuId3jGiURCUGgxed8Q9MA3mTs7sfapzqTzcGmE1heCIeXJIE2ER2/S5X+uoZOgSKUUI3mkUw5hOFcPp7qh4BmPaZnznipiP7gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: DMtmeGveQD2q9Yib0ifQCw==
X-CSE-MsgGUID: e3f+CduDTUOp/NJy0/7ipA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Jan 2026 00:36:27 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.178])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2A2FD4022B3F;
	Thu, 15 Jan 2026 00:36:21 +0900 (JST)
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
Subject: [PATCH 08/16] PCI: rzg3s-host: Make inbound window setup SoC-specific
Date: Wed, 14 Jan 2026 16:33:29 +0100
Message-ID: <20260114153337.46765-9-john.madieu.xa@bp.renesas.com>
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

Different RZ/G3 SoCs have different requirements for inbound window
configuration. While both require power-of-2 sized windows (4KB * 2^N),
they differ in how non-power-of-2 memory regions are handled:

- RZ/G3S: Uses roundup_pow_of_two() to create a single larger window
  that may over-map beyond the actual memory region. This approach is
  simpler but relies on hardware tolerance for over-mapped regions.

- RZ/G3E: Requires precise coverage without over-mapping. Memory regions
  must be split into multiple power-of-2 windows, and window sizes must
  respect address alignment constraints to ensure proper hardware address
  decoding.

Move the inbound window sizing and splitting logic to a SoC-specific
callback to accommodate these differences. This allows each SoC variant
to implement its own window setup strategy while maintaining the common
window programming sequence.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index fcedccadecf6..a9773e5f25c7 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -223,6 +223,7 @@ struct rzg3s_pcie_host;
 /**
  * struct rzg3s_pcie_soc_data - SoC specific data
  * @init_phy: PHY initialization function
+ * @set_inbound_windows: SoC-specific function to set up inbound windows
  * @power_resets: array with the resets that need to be de-asserted after
  *                power-on
  * @cfg_resets: array with the resets that need to be de-asserted after
@@ -233,6 +234,9 @@ struct rzg3s_pcie_host;
  */
 struct rzg3s_pcie_soc_data {
 	int (*init_phy)(struct rzg3s_pcie_host *host);
+	int (*set_inbound_windows)(struct rzg3s_pcie_host *host,
+				   struct resource_entry *entry,
+				   int *index);
 	const char * const *power_resets;
 	const char * const *cfg_resets;
 	struct rzg3s_sysc_info sysc_info;
@@ -1354,7 +1358,7 @@ static int rzg3s_pcie_parse_map_dma_ranges(struct rzg3s_pcie_host *host)
 	int i = 0, ret;
 
 	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
-		ret = rzg3s_pcie_set_inbound_windows(host, entry, &i);
+		ret = host->data->set_inbound_windows(host, entry, &i);
 		if (ret)
 			return ret;
 	}
@@ -1753,6 +1757,7 @@ static const struct rzg3s_pcie_soc_data rzg3s_soc_data = {
 	.cfg_resets = rzg3s_soc_cfg_resets,
 	.num_cfg_resets = ARRAY_SIZE(rzg3s_soc_cfg_resets),
 	.init_phy = rzg3s_soc_pcie_init_phy,
+	.set_inbound_windows = rzg3s_pcie_set_inbound_windows,
 	.sysc_info = {
 		.rst_rsm_b = {
 			.offset = 0xd74,
-- 
2.25.1


