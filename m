Return-Path: <linux-pci+bounces-30082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E186ADF139
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 17:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1BC03BC4C1
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 15:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACDE2EFDAE;
	Wed, 18 Jun 2025 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Uhmj0vaq"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295622EFDB7;
	Wed, 18 Jun 2025 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750260105; cv=none; b=ClW7oLQyDwaDWUZwKfcbNoIZloH5ey/+7+UVd1WWU3uyPg2RuJP7l7qKUtiFZSEJvCRBY8+UMTX4pSWpj/e2a3SwK7yrJjqF0UzOve5dvaOZ49aGDZDCGeKnNKgoG3d0Gw/7gK6i6cm6bjfjTGqfav/+Drv2ekwUnFVdoilQmBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750260105; c=relaxed/simple;
	bh=uHw15SEfgJhjk0plrbNOxwEmIEjDnYKRuTeithPcYq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cEAzuqUfUPZDVpIMWLZfcF27TB4nmbS+sYu6kc0wdnWcC5/QHj2Wl3gTMvUdlhjp9T47+TSrhEQwF5o97RF6agr+2xEmLzMbs7eqbCwqEXPsgWTeL+HxUW857F8enRhMxOf5Qs24NW1tiZT29DevXzLAWw7CiBcMGY51vMQLO3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Uhmj0vaq; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=lz
	037P2kaVzqsQ34A3LWfibKKWlS33MGjH64LQLCkDA=; b=Uhmj0vaq/FSWYCyHKK
	SXCv5pl1QkZldRIcz/5204acUf9cunLphDScBHvQiCD4ArzM3PAS/Ok5ztXD8LlX
	d/P9ZbyAXxdOwZm7MaydmZjjZgr/si62tHhjVCbp5ngzqg5UhY0E9vtc1sdu29dJ
	k7GAcTfEcuSFQdQCVwCV/iQ5A=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBXvXd32VJoWFISAQ--.22704S5;
	Wed, 18 Jun 2025 23:21:29 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 08/13] PCI: dw-rockchip: Refactor code by using dw_pcie_clear_and_set_dword()
Date: Wed, 18 Jun 2025 23:21:07 +0800
Message-Id: <20250618152112.1010147-9-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618152112.1010147-1-18255117159@163.com>
References: <20250618152112.1010147-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXvXd32VJoWFISAQ--.22704S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1rGr4Dtr1DJF1ruw18Grg_yoW8CrW5p3
	y3Aa4akF4rJw4rua1kAa97ZF13ta9xAFW7JFZ3Gw1SqFy2k34DKF1YkFyaqF1xGr42vF1a
	93yUt3yUZa13AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR2jg3UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhFwo2hS1URmFgAAsj

Rockchip PCIe driver implements L0s capability enablement through
explicit register read-modify-write. The current approach reads the
LNKCAP register, modifies the ASPM_L0S bit, then writes back the
value with DBI write protection handling.

Refactor ASPM capability configuration using
dw_pcie_clear_and_set_dword(). The helper combines bit manipulation with
DBI protection in a single call, replacing three-step manual operations.
This simplifies the capability setup flow and reduces code complexity.

Adopting the standard helper improves maintainability by eliminating
local variables and explicit bitwise operations. The change also ensures
consistent handling of DBI write protection across capability modification
functions.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 93171a392879..e6bd9c54b164 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -194,15 +194,14 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
 
 static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
 {
-	u32 cap, lnkcap;
+	u32 cap;
 
 	/* Enable L0S capability for all SoCs */
 	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	if (cap) {
-		lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
-		lnkcap |= PCI_EXP_LNKCAP_ASPM_L0S;
 		dw_pcie_dbi_ro_wr_en(pci);
-		dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
+		dw_pcie_clear_and_set_dword(pci, cap + PCI_EXP_LNKCAP,
+					    0, PCI_EXP_LNKCAP_ASPM_L0S);
 		dw_pcie_dbi_ro_wr_dis(pci);
 	}
 }
-- 
2.25.1


