Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FE1372EB8
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 19:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhEDRTR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 13:19:17 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:36799 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbhEDRTD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 May 2021 13:19:03 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d41 with ME
        id 0hJ62500B21Fzsu03hJ6ua; Tue, 04 May 2021 19:18:07 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 04 May 2021 19:18:07 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     thierry.reding@gmail.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com, jonathanh@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/3] PCI: tegra: make const array err_msg static
Date:   Tue,  4 May 2021 19:18:04 +0200
Message-Id: <5f3f35296b944b94546cc7d1e9cc6186484620d8.1620148539.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <55b11e9a7fa2987fbc0869d68ae59888954d65e2.1620148539.git.christophe.jaillet@wanadoo.fr>
References: <55b11e9a7fa2987fbc0869d68ae59888954d65e2.1620148539.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Don't populate the array err_msg on the stack but instead make it
static. Makes the object code smaller by 64 bytes.

While at it, add a missing const, as reported by checkpatch.

Compiled with gcc 11.0.1

Before:
$ size drivers/pci/controller/pci-tegra.o
   text	   data	    bss	    dec	    hex	filename
  25623	   2844	     32	  28499	   6f53	drivers/pci/controller/pci-tegra.o

After:
$ size drivers/pci/controller/pci-tegra.o
   text	   data	    bss	    dec	    hex	filename
  25559	   2844	     32	  28435	   6f13	drivers/pci/controller/pci-tegra.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pci/controller/pci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index fe8e21ce3e3d..b1250b15d290 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -764,7 +764,7 @@ static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
 
 static irqreturn_t tegra_pcie_isr(int irq, void *arg)
 {
-	const char *err_msg[] = {
+	static const char * const err_msg[] = {
 		"Unknown",
 		"AXI slave error",
 		"AXI decode error",
-- 
2.30.2

