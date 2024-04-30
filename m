Return-Path: <linux-pci+bounces-6839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C848B6B24
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 09:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8327228296D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 07:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C335E20DC5;
	Tue, 30 Apr 2024 07:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZk8fJQt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7E1199AD;
	Tue, 30 Apr 2024 07:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714461066; cv=none; b=P4KSWehYgKcVXX308S7noKBvd390rnpcFUndvDF/tdOy0nCPJiec3Cq3dhmo1mcAGYjl0ZB63z0j45hrRGAZHZg85MhGcr9lsIsuOZ5L5WhabNt0Dq2xH2U0HIJvJs+acquWRQp/adiL+aiKZGldQIaU6Vl2MXYurN4roKp6jvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714461066; c=relaxed/simple;
	bh=MgqqXwmWXlkipmBRIZBSIUTe/3u2BXxchsuk8HMH5Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tbf8vzaxExy5vySOzZoQUSsTaE5tA/riL2EpFxLKwAdR26ifLCalAC9byLz8dFILCFJDwySiWksXeSpkgWeHj9KQg+xhFBEW5Zdoax/kxjdgcb48HJPtpESGypakAEH2b6uAYZy6T8NOBYEI5ZEBM0/tUjraYCYPfnqUg4AKZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZk8fJQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41196C2BBFC;
	Tue, 30 Apr 2024 07:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714461066;
	bh=MgqqXwmWXlkipmBRIZBSIUTe/3u2BXxchsuk8HMH5Kw=;
	h=From:To:Cc:Subject:Date:From;
	b=GZk8fJQtLjDKjMIiWQv6LQaS+sgh75EqSA0N0mTsapqr4OeifkOxICH/knfALhKlD
	 x+xEiLynE/pgH5MezktdWWUDsasdHm4RJbyNWyXTegB7AlnCfna+XBP5NOyk/6oLbf
	 ZPOW5GLVD5ORxVonjF8hbfGMUBqnEPA5TiWk7n04X2aG3PnKfqOUHhIiXgEnbK+FzB
	 ZVxtQIVqEfTmOhMEssQiNP1gRi9SptRE9LgT2t7G9qgoktW3gKuJwBFPxDXEZ88wSq
	 +EFpUKR/bvFMAvsuzf15ReQkSR7HeAgTPDhmSenzd9JzkQH87pbxP3l5D8L3aKQUvp
	 3Pz1FzQ+AKUAg==
From: Niklas Cassel <cassel@kernel.org>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] PCI: dra7xx: Fix cpu_addr_fixup parameter name
Date: Tue, 30 Apr 2024 09:10:55 +0200
Message-ID: <20240430071054.248008-3-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1138; i=cassel@kernel.org; h=from:subject; bh=MgqqXwmWXlkipmBRIZBSIUTe/3u2BXxchsuk8HMH5Kw=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIMZtb5HP742MFmz9NID9eXPw+U7ro/3clenYn5H+/+5 l0HhBkkOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRr9sZ/pedT1mzccmk9VFa 0kkul8508C41FPziUDorYcqyyQ/U6z4y/LPozGKRFJ2nbuhyz+lYkK65aoPPy61rF/TfjLq7XJ/ 1DxsA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The function pointer declaration for the cpu_addr_fixup() callback uses
"cpu_addr" as parameter name.

Likewise, the argument that is supplied to the function pointer when the
function is actually called is "cpu_addr".

Rename the cpu_addr_fixup parameter name to match reality.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index d2d17d37d3e0..2b818346bb37 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -113,9 +113,9 @@ static inline void dra7xx_pcie_writel(struct dra7xx_pcie *pcie, u32 offset,
 	writel(value, pcie->base + offset);
 }
 
-static u64 dra7xx_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 pci_addr)
+static u64 dra7xx_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 cpu_addr)
 {
-	return pci_addr & DRA7XX_CPU_TO_BUS_ADDR;
+	return cpu_addr & DRA7XX_CPU_TO_BUS_ADDR;
 }
 
 static int dra7xx_pcie_link_up(struct dw_pcie *pci)
-- 
2.44.0


