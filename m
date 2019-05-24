Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32C1028F09
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 04:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387720AbfEXCP6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 22:15:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:21267 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387732AbfEXCP6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 May 2019 22:15:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 19:15:56 -0700
X-ExtLoop1: 1
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.59])
  by orsmga006.jf.intel.com with SMTP; 23 May 2019 19:15:53 -0700
Received: by ubuntu (sSMTP sendmail emulation); Fri, 24 May 2019 10:15:52 +0800
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lftan.linux@gmail.com, Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH] PCI: altera: Fix no return warning for altera_pcie_irq_teardown()
Date:   Fri, 24 May 2019 10:15:51 +0800
Message-Id: <1558664151-2584-1-git-send-email-ley.foon.tan@intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix compilation warning caused by patch "PCI: altera: Allow building as module".

drivers/pci/controller/pcie-altera.c: In function ‘altera_pcie_irq_teardown’:
drivers/pci/controller/pcie-altera.c:723:1: warning: no return statement in function returning non-void [-Wreturn-type]
 }

Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
---
 drivers/pci/controller/pcie-altera.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 6c86bc69ace8..27222071ace7 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -706,7 +706,7 @@ static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
 	return 0;
 }
 
-static int altera_pcie_irq_teardown(struct altera_pcie *pcie)
+static void altera_pcie_irq_teardown(struct altera_pcie *pcie)
 {
 	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
 	irq_domain_remove(pcie->irq_domain);
-- 
2.19.0

