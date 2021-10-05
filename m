Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE2B422FB3
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 20:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhJESL6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 14:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234413AbhJESL5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 14:11:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10B9B61401;
        Tue,  5 Oct 2021 18:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633457407;
        bh=NC+ytKy/5Pzazxm2aG5g1s9AyNrikduMSWvwg0U+DbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OO+l9mntZRTsoNHztvFlwBfrnV+SaL261JFkxa7StclYHICeR3bslCTXZuYyadB5v
         wMKER4WGgqmMXmK6QGcCeOomq7/TqNdCtVFmbswWOr06UUKYiKCX2r8gmA2HxBxHcw
         HaljgpPKzJkqjQBdSPpDKJyuGAukyUIT3nyJkccA808QjVCryyIcdoEROi4UtAElu2
         6iBzCx06LuSbaDJSoaxHdcdp7b9NM1mA87EETCi7bGCAV/hHsjJrMgNxDyaGsWgbJb
         4DJ1x0obpFrfDdYwGd/mxysC2WjnI/hjiESwsfw2FKGqqdWL4zX5v8evDDLO650NCI
         WdxAsbT92Ft+g==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 08/13] PCI: aardvark: Deduplicate code in advk_pcie_rd_conf()
Date:   Tue,  5 Oct 2021 20:09:47 +0200
Message-Id: <20211005180952.6812-9-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211005180952.6812-1-kabel@kernel.org>
References: <20211005180952.6812-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Avoid code repetition in advk_pcie_rd_conf() by handling errors with
goto jump, as is customary in kernel.

Fixes: 43f5c77bcbd2 ("PCI: aardvark: Fix reporting CRS value")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 48 +++++++++++----------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 3448a8c446d4..cd5be284789e 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -920,18 +920,8 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 		    (le16_to_cpu(pcie->bridge.pcie_conf.rootctl) &
 		     PCI_EXP_RTCTL_CRSSVE);
 
-	if (advk_pcie_pio_is_running(pcie)) {
-		/*
-		 * If it is possible return Completion Retry Status so caller
-		 * tries to issue the request again instead of failing.
-		 */
-		if (allow_crs) {
-			*val = CFG_RD_CRS_VAL;
-			return PCIBIOS_SUCCESSFUL;
-		}
-		*val = 0xffffffff;
-		return PCIBIOS_SET_FAILED;
-	}
+	if (advk_pcie_pio_is_running(pcie))
+		goto try_crs;
 
 	/* Program the control register */
 	reg = advk_readl(pcie, PIO_CTRL);
@@ -955,25 +945,13 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 	advk_writel(pcie, 1, PIO_START);
 
 	ret = advk_pcie_wait_pio(pcie);
-	if (ret < 0) {
-		/*
-		 * If it is possible return Completion Retry Status so caller
-		 * tries to issue the request again instead of failing.
-		 */
-		if (allow_crs) {
-			*val = CFG_RD_CRS_VAL;
-			return PCIBIOS_SUCCESSFUL;
-		}
-		*val = 0xffffffff;
-		return PCIBIOS_SET_FAILED;
-	}
+	if (ret < 0)
+		goto try_crs;
 
 	/* Check PIO status and get the read result */
 	ret = advk_pcie_check_pio_status(pcie, allow_crs, val);
-	if (ret < 0) {
-		*val = 0xffffffff;
-		return PCIBIOS_SET_FAILED;
-	}
+	if (ret < 0)
+		goto fail;
 
 	if (size == 1)
 		*val = (*val >> (8 * (where & 3))) & 0xff;
@@ -981,6 +959,20 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 		*val = (*val >> (8 * (where & 3))) & 0xffff;
 
 	return PCIBIOS_SUCCESSFUL;
+
+try_crs:
+	/*
+	 * If it is possible, return Completion Retry Status so that caller
+	 * tries to issue the request again instead of failing.
+	 */
+	if (allow_crs) {
+		*val = CFG_RD_CRS_VAL;
+		return PCIBIOS_SUCCESSFUL;
+	}
+
+fail:
+	*val = 0xffffffff;
+	return PCIBIOS_SET_FAILED;
 }
 
 static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
-- 
2.32.0

