Return-Path: <linux-pci+bounces-25555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 661B2A8231B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 13:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3151F1BA77A7
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 11:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A471115382E;
	Wed,  9 Apr 2025 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="BAaE1NXi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3285.qiye.163.com (mail-m3285.qiye.163.com [220.197.32.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1539A1DF99C
	for <linux-pci@vger.kernel.org>; Wed,  9 Apr 2025 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744196857; cv=none; b=UkqmbM/nA+OTD/hyXhvOCaIP+ATlnG3cHWjFhUdpp+sC0HEYeYhnkk/9/knQcPY6XDbtA3h1dV2/NxRtSmkEtmnpnP+rBOltQtKfRRJYiUB/39DLUqZaX+Zgwq0JVS87RyS7M28MZWM1ed8y2rNx19h5laEUzck+SoalHIfwyKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744196857; c=relaxed/simple;
	bh=pgKbWu+wLLMcF6a8RbGiVOPGxxYGsOD2Vum9vWEMJTE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=jJogPa7rd3UijBbHC8nHfLyV18f6PLTAQ6PSIHZLxo/t4Z1Hfl3H/HNgI8bad5s3e6BNTdpb4UkwpVt78CZYL0ogPtPq4bsGKCWbTwWkaZEWkGOlVLHPeYoMtwGyRkpkaaMwlmAsqmkhHMqsqw7yVQjc5auDtUOXHS1C/95bBiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=BAaE1NXi; arc=none smtp.client-ip=220.197.32.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1139d61b6;
	Wed, 9 Apr 2025 17:51:53 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2] PCI: dw-rockchip: Remove PCIE_L0S_ENTRY check from rockchip_pcie_link_up()
Date: Wed,  9 Apr 2025 17:51:48 +0800
Message-Id: <1744192308-238386-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUlKSFYZSEkZTh5DHU1IGkNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9619f6985f09cckunm1139d61b6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODY6Hww6DjJMAjw4LBM1DwEI
	Dx0wFA1VSlVKTE9PSkJJSEpPSU1NVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlKSEM3Bg++
DKIM-Signature:a=rsa-sha256;
	b=BAaE1NXiTZZ9JEFZ2uhIVmzg/FZyQMyATMIsWDV63JNsCSzzXo+ZBdz0tfoe0Hu0ojFxeMnI/Q0RPZTdMydmNlwwyz4KP2zVjtnAoGrWT3EwVF82bzLW6c6+ZgTBCAUezhWGZuVZiyG1maTTll2jDNFrXsUXoYjap11ExDNoY4Y=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=gywVutG6WB6sYLQFgYZ+H7rTiQCGSWF3bbpFAggbU2g=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Two mistakes here:
1. 0x11 is L0 not L0S, so the naming is wrong from the very beginning.
2. It's totally broken if enabling ASPM as rockchip_pcie_link_up() treat other
states, for instance, L0S or L1 as link down which is obviously wrong.

Remove the check.

Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2:
- add Fixes tag

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index c624b7e..21dc99c 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -44,7 +44,6 @@
 #define PCIE_LINKUP			(PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
 #define PCIE_RDLH_LINK_UP_CHGED		BIT(1)
 #define PCIE_LINK_REQ_RST_NOT_INT	BIT(2)
-#define PCIE_L0S_ENTRY			0x11
 #define PCIE_CLIENT_GENERAL_CONTROL	0x0
 #define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
 #define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
@@ -177,8 +176,7 @@ static int rockchip_pcie_link_up(struct dw_pcie *pci)
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
 	u32 val = rockchip_pcie_get_ltssm(rockchip);
 
-	if ((val & PCIE_LINKUP) == PCIE_LINKUP &&
-	    (val & PCIE_LTSSM_STATUS_MASK) == PCIE_L0S_ENTRY)
+	if ((val & PCIE_LINKUP) == PCIE_LINKUP)
 		return 1;
 
 	return 0;
-- 
2.7.4


