Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0301FDFBC
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jun 2020 03:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732812AbgFRBnG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 21:43:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731556AbgFRB3K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jun 2020 21:29:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 605AA2222D;
        Thu, 18 Jun 2020 01:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443750;
        bh=VTQcOj6M88egVnqn8qF8AE2x6eOEzr3Uv885uP9VKZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ptmgkG2BKfJi2n/CH2jma1cqouVh/xI9fluw771tQDJnKjlZoDhCUQ//hOYB99zg+
         Fhxn/t9IM7BYDZWPq0OBKHA1hSY8NB3w1cOr0gCf6VfLiblrEKowp4kT90ECm1uvqs
         kL0ya+vMH4zi/VXgH04ejXftjqvdpYd7pPmwdN0c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 38/80] PCI: rcar: Fix incorrect programming of OB windows
Date:   Wed, 17 Jun 2020 21:27:37 -0400
Message-Id: <20200618012819.609778-38-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012819.609778-1-sashal@kernel.org>
References: <20200618012819.609778-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Andrew Murray <andrew.murray@arm.com>

[ Upstream commit 2b9f217433e31d125fb697ca7974d3de3ecc3e92 ]

The outbound windows (PCIEPAUR(x), PCIEPALR(x)) describe a mapping between
a CPU address (which is determined by the window number 'x') and a
programmed PCI address - Thus allowing the controller to translate CPU
accesses into PCI accesses.

However the existing code incorrectly writes the CPU address - lets fix
this by writing the PCI address instead.

For memory transactions, existing DT users describe a 1:1 identity mapping
and thus this change should have no effect. However the same isn't true for
I/O.

Link: https://lore.kernel.org/r/20191004132941.6660-1-andrew.murray@arm.com
Fixes: c25da4778803 ("PCI: rcar: Add Renesas R-Car PCIe driver")
Tested-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/host/pcie-rcar.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 7f6b454bca65..3ff423220df6 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -328,11 +328,12 @@ static struct pci_ops rcar_pcie_ops = {
 };
 
 static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie,
-				   struct resource *res)
+				   struct resource_entry *window)
 {
 	/* Setup PCIe address space mappings for each resource */
 	resource_size_t size;
 	resource_size_t res_start;
+	struct resource *res = window->res;
 	u32 mask;
 
 	rcar_pci_write_reg(pcie, 0x00000000, PCIEPTCTLR(win));
@@ -346,9 +347,9 @@ static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie,
 	rcar_pci_write_reg(pcie, mask << 7, PCIEPAMR(win));
 
 	if (res->flags & IORESOURCE_IO)
-		res_start = pci_pio_to_address(res->start);
+		res_start = pci_pio_to_address(res->start) - window->offset;
 	else
-		res_start = res->start;
+		res_start = res->start - window->offset;
 
 	rcar_pci_write_reg(pcie, upper_32_bits(res_start), PCIEPAUR(win));
 	rcar_pci_write_reg(pcie, lower_32_bits(res_start) & ~0x7F,
@@ -377,7 +378,7 @@ static int rcar_pcie_setup(struct list_head *resource, struct rcar_pcie *pci)
 		switch (resource_type(res)) {
 		case IORESOURCE_IO:
 		case IORESOURCE_MEM:
-			rcar_pcie_setup_window(i, pci, res);
+			rcar_pcie_setup_window(i, pci, win);
 			i++;
 			break;
 		case IORESOURCE_BUS:
-- 
2.25.1

