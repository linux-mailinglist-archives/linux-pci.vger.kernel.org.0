Return-Path: <linux-pci+bounces-11092-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE819943DEF
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 03:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845FD1F22576
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 01:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEE71D0A02;
	Thu,  1 Aug 2024 00:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkSWuEDh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8FD1D09FC;
	Thu,  1 Aug 2024 00:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472215; cv=none; b=a2RmlRLKhvVoEBf0Vg95r8I+3GfGh4X9vr2nL9lb6Zv/L/gVc0k0dVWbbmY4RhUmbohHatprNo7+/V+PRZSo54gBYU2n0bCrjkSiwNrnIurDqjlJxfjjVrtAHjRlGv//PnpOZeyXFH8XrtHkcVmB1/ayYCP3bro0PyfUYbwrhgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472215; c=relaxed/simple;
	bh=RColRDGhXyRYuVSwACqASDaDSCK4w3PDTdkl/ovss3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cn/lpoacGvHOfZCJTgMU/FYiTYWGw6LGuHph+n79FCiptUYqsbou4JmsJ1ZfvPXMGJgHleGbV+zEVPv8UzuQtsA8c2pBGX11r5yRk9NXcGviPcXC5Shrs0Aw0JQdDck5QkVBPAiqkd/yW5HSI/zi8X0Ke6hfwvRys90Czw9nvx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkSWuEDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A6CC116B1;
	Thu,  1 Aug 2024 00:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472214;
	bh=RColRDGhXyRYuVSwACqASDaDSCK4w3PDTdkl/ovss3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bkSWuEDha7LJU7AEy9DL4JwuP5OFuqZFRjlPggKXM26mcs04yOX2gWu06UZPzEjkh
	 hbpTYgIIKbs0XTzzSO/H7q5SXZ+AMeT4DGOg3CRILw05MyH88f9u4XSxh9zxqAp0xs
	 7cxCKkQ+WB6nQknX4A4N7oxmkg/OHwMwAjL+Kq1ey7CbHM2d3Lc9xA6PTOFQZ0VsTB
	 qWBsPDaXY7/GSsuf+I+1uW8FUKkXX92xIMUyYuuSkKITw7esnPV3nrtL84v4idW2/x
	 1XBzJ5PnBdJwkofytkV+5IegphdMSvsGR/e/yP7Famo1x9AeBf9qgkVoyzHsV/Z6/f
	 /RBN/udN/idxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aleksandr Mishin <amishin@t-argos.ru>,
	Bjorn Helgaas <helgaas@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	jonnyc@amazon.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 30/61] PCI: al: Check IORESOURCE_BUS existence during probe
Date: Wed, 31 Jul 2024 20:25:48 -0400
Message-ID: <20240801002803.3935985-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Aleksandr Mishin <amishin@t-argos.ru>

[ Upstream commit a9927c2cac6e9831361e43a14d91277818154e6a ]

If IORESOURCE_BUS is not provided in Device Tree it will be fabricated in
of_pci_parse_bus_range(), so NULL pointer dereference should not happen
here.

But that's hard to verify, so check for NULL anyway.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Link: https://lore.kernel.org/linux-pci/20240503125705.46055-1-amishin@t-argos.ru
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
[bhelgaas: commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-al.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
index b8cb77c9c4bd2..3132b27bc0064 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -242,18 +242,24 @@ static struct pci_ops al_child_pci_ops = {
 	.write = pci_generic_config_write,
 };
 
-static void al_pcie_config_prepare(struct al_pcie *pcie)
+static int al_pcie_config_prepare(struct al_pcie *pcie)
 {
 	struct al_pcie_target_bus_cfg *target_bus_cfg;
 	struct dw_pcie_rp *pp = &pcie->pci->pp;
 	unsigned int ecam_bus_mask;
+	struct resource_entry *ft;
 	u32 cfg_control_offset;
+	struct resource *bus;
 	u8 subordinate_bus;
 	u8 secondary_bus;
 	u32 cfg_control;
 	u32 reg;
-	struct resource *bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS)->res;
 
+	ft = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
+	if (!ft)
+		return -ENODEV;
+
+	bus = ft->res;
 	target_bus_cfg = &pcie->target_bus_cfg;
 
 	ecam_bus_mask = (pcie->ecam_size >> PCIE_ECAM_BUS_SHIFT) - 1;
@@ -287,6 +293,8 @@ static void al_pcie_config_prepare(struct al_pcie *pcie)
 	       FIELD_PREP(CFG_CONTROL_SEC_BUS_MASK, secondary_bus);
 
 	al_pcie_controller_writel(pcie, cfg_control_offset, reg);
+
+	return 0;
 }
 
 static int al_pcie_host_init(struct dw_pcie_rp *pp)
@@ -305,7 +313,9 @@ static int al_pcie_host_init(struct dw_pcie_rp *pp)
 	if (rc)
 		return rc;
 
-	al_pcie_config_prepare(pcie);
+	rc = al_pcie_config_prepare(pcie);
+	if (rc)
+		return rc;
 
 	return 0;
 }
-- 
2.43.0


