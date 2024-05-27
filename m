Return-Path: <linux-pci+bounces-7859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE988D07D8
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 18:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31481F21308
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 16:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B646D155C9A;
	Mon, 27 May 2024 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="DBXdpju4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C7C155C8D;
	Mon, 27 May 2024 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825684; cv=none; b=bZMq1utBtVKRD/RdlYUqg9szHSm8r0Lk5zh8H0yPXzwludSM4yx9higoAYP02lf12mw4L/7EPpb36SmpB+cN8+cRDGHYG1TxFQ1zEmd9htqxIf5pYuhxLua4GVJ5Y8tW5FwvbwBX+J4P4Q1x3jty1X5TJ9dej/xYM/NPLF6zmco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825684; c=relaxed/simple;
	bh=Sruv/YZzitcj90qjhIXuqnC3K/lFTcB08gnVoO8Fw4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=st/TgUmLP4/Y6MhXfX2R4Dhgg1xsO3Z0fpMVH2KRTB9KKtaIpUsFoe6AKsZcaFAWgLwZRKug2gp4T1Em0WiMW5MtgKi8GxCRCs5r0ZeAHgz9mbFLmYPv9q4lMdVTZt6pRkzFU5UnDS5jUyhV8TNSXYfbCoBN7ENUbJvp/8SFGzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=DBXdpju4; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=EE/8qcrliFALaEnFXnUHoU1iKIRNcEvm7lqw9z40qcA=; b=DBXdpju4st9B9+Cc
	W6gFQZ4eLH4oO1AqKct7nLtPJ8HeA2egQ0H2RQTcj12j7U/f0BWWTEFyuCy+F25l2HUGWCumLkMhO
	LDQXmmSflhFpw4k5826B3xai+aPottcakuhoxQBZ1I1YNQapEb+QtY1tre0AKpUjsMkUpUjK3Sw+B
	n9UI+iFZHd1DBI/6HZK2eGvTyS9zBUIqF6FiapOsR7dLvx5K9fKa0zCpDPVxs6YH0iW6cta/Swlay
	vJR96ciWcgIIWswK4bCMb7Iy2PKRXUbWiuoX/5U5OWa+Vuu+VR7J16WTm1TBbJUAQxKIvVuYr4qNi
	BiEp6JmWksse6z8IRw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sBcmk-002m9X-2V;
	Mon, 27 May 2024 16:01:19 +0000
From: linux@treblig.org
To: lpieralisi@kernel.org,
	robh@kernel.org,
	thierry.reding@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] PCI: tegra: remove unused struct 'tegra_pcie_soc'
Date: Mon, 27 May 2024 17:01:18 +0100
Message-ID: <20240527160118.37069-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'tegra_pcie_soc' has been unused since the initial
commit 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 93f5433c5c55..076f040ccc34 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -308,10 +308,6 @@ static inline u32 appl_readl(struct tegra_pcie_dw *pcie, const u32 reg)
 	return readl_relaxed(pcie->appl_base + reg);
 }
 
-struct tegra_pcie_soc {
-	enum dw_pcie_device_mode mode;
-};
-
 static void tegra_pcie_icc_set(struct tegra_pcie_dw *pcie)
 {
 	struct dw_pcie *pci = &pcie->pci;
-- 
2.45.1


