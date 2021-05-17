Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FCE383B16
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 19:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241941AbhEQRUE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 13:20:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241395AbhEQRUC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 May 2021 13:20:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26B8A60FD8;
        Mon, 17 May 2021 17:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621271926;
        bh=5EXXKrTEZggHrz5JlWeNkc4VW59P/1NQcRzu78RsYh4=;
        h=From:To:Cc:Subject:Date:From;
        b=L6AX5/QUb4GeLSO8wgtLFwnX5ydTAuEiHJZm18I/AsQctwuJU1noXH+LUWbOz0oMG
         vVgR9ft/jNkY/anR5aM368MDo7woqDUxuIVqj73h0CJB11YXXzubQyCJsM2OleLswp
         it16ue17T++rkc2kuiHeYP2VUTaq8ilzp/9Ne8Ed3B08uFyUXi+qgyicYFscEudIrx
         nefPZchipYkvd8EfPC27M08/OHsDdncmr53IEJqwIEipTTOxaKL8nTAxIuo9dCT6Tj
         GfM0uKVnyOmgvm9WJ4MHTw5PScm2rw90VeFMTDTjN3Llg7kuAY7X8sz3bsWRG3lUFg
         iTYtkp9BnUHMg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Toan Le <toan@os.amperecomputing.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] PCI: xgene: Annotate __iomem pointer
Date:   Mon, 17 May 2021 12:18:39 -0500
Message-Id: <20210517171839.25777-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

"bar_addr" is passed as the argument to writel(), which expects a
"void __iomem *".  Annotate "bar_addr" correctly.  Resolves an sparse
"incorrect type in argument 2 (different address spaces)" warning.

Link: https://lore.kernel.org/r/202105171809.Tay9fImZ-lkp@intel.com
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/pci-xgene.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index 7f503dd4ff81..1a412f5377fb 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -485,7 +485,7 @@ static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *port,
 {
 	void __iomem *cfg_base = port->cfg_base;
 	struct device *dev = port->dev;
-	void *bar_addr;
+	void __iomem *bar_addr;
 	u32 pim_reg;
 	u64 cpu_addr = entry->res->start;
 	u64 pci_addr = cpu_addr - entry->offset;
-- 
2.25.1

