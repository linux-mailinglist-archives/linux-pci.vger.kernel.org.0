Return-Path: <linux-pci+bounces-31769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73374AFE964
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 14:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9CD16F5EB
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 12:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5062D97A6;
	Wed,  9 Jul 2025 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+rZyX+a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ACE27CCF2;
	Wed,  9 Jul 2025 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752065431; cv=none; b=rMsvKrqLIF+vUeeNhLvXey0Jwuki0JZ99bWv8GuXukemR5gbBATnOv2YSJiW3arN4Nw7dkS5LBL2xgleaHG7C9fjouNK3FxCWdUH+QlyW1+Q7/IUwb2Eovd98wX78kBjoA3OLgUTxcKrdWkTOS0ls0j3GqtIDBsOGu621XQrFP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752065431; c=relaxed/simple;
	bh=KjDaX0p5yBi+vtwsw7OhtKZ8O+u5XB5f8uo6IyxGqzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J89GSib0fFWckkhd5srPoWr04vhEnwhKMmCFBCG0PLbBqq79+AE809sc+6DnpnLYcaHVScPRUpfqKkNRG0MR7UkjTwFQJaZYQ7U13QvXGVryg+jKg8hurQft2g7kAicMgGGpTx2AmuZ7V21SPIuWnqKlko/gEotStNLGyYO5JQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+rZyX+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFD0C4CEEF;
	Wed,  9 Jul 2025 12:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752065430;
	bh=KjDaX0p5yBi+vtwsw7OhtKZ8O+u5XB5f8uo6IyxGqzY=;
	h=From:To:Cc:Subject:Date:From;
	b=O+rZyX+aJFkIiENXBZ/gOfDkhti8km4oEvDZVCyL3d/XaIMuYQi4fEdRLMzNIfRk7
	 uLi+fYWcl0JuTJHRHifLQlpyCVl/RSaNwvKPZ16MY6/ELvo6lCzpcjVYLZ8g+Bnklv
	 pFqh2dB3/MU5LCLDZ2kXlJcZsOa6l+vHn7+axPveJhmd1UnJLOeyi6AI3rNPRYOwgt
	 jgPS4Dn6XFxY22fOBXxGxTR8X+j0Of0a8sHpAgc5MXS6WElK9OmH3j3wEZTztKef+P
	 MATH3lDJU43uxBsok2mifritWjYhjkAHFlaBw+Gyu5MTDJDPFnnQ/MvtCOoL2aPEjv
	 r9/EIvMIDS9QA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	kwilczynski@kernel.org,
	bhelgaas@google.com
Cc: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH] PCI: endpoint: pci-epf-vntb: Fix the incorrect usage of __iomem attribute
Date: Wed,  9 Jul 2025 18:20:22 +0530
Message-ID: <20250709125022.22524-1-mani@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__iomem attribute is supposed to be used only with variables holding the
MMIO pointer. But here, 'mw_addr' variable is just holding a 'void *'
returned by pci_epf_alloc_space(). So annotating it with __iomem is clearly
wrong. Hence, drop the attribute.

This also fixes the below sparse warning:

  drivers/pci/endpoint/functions/pci-epf-vntb.c:524:17: warning: incorrect type in assignment (different address spaces)
  drivers/pci/endpoint/functions/pci-epf-vntb.c:524:17:    expected void [noderef] __iomem *mw_addr
  drivers/pci/endpoint/functions/pci-epf-vntb.c:524:17:    got void *
  drivers/pci/endpoint/functions/pci-epf-vntb.c:530:21: warning: incorrect type in assignment (different address spaces)
  drivers/pci/endpoint/functions/pci-epf-vntb.c:530:21:    expected unsigned int [usertype] *epf_db
  drivers/pci/endpoint/functions/pci-epf-vntb.c:530:21:    got void [noderef] __iomem *mw_addr
  drivers/pci/endpoint/functions/pci-epf-vntb.c:542:38: warning: incorrect type in argument 2 (different address spaces)
  drivers/pci/endpoint/functions/pci-epf-vntb.c:542:38:    expected void *addr
  drivers/pci/endpoint/functions/pci-epf-vntb.c:542:38:    got void [noderef] __iomem *mw_addr

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index ac83a6dc6116..83e9ab10f9c4 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -512,7 +512,7 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 	struct device *dev = &ntb->epf->dev;
 	int ret;
 	struct pci_epf_bar *epf_bar;
-	void __iomem *mw_addr;
+	void *mw_addr;
 	enum pci_barno barno;
 	size_t size = sizeof(u32) * ntb->db_count;
 
-- 
2.45.2


