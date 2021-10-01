Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B513441F604
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 21:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241941AbhJAUAv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 16:00:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229916AbhJAUAv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Oct 2021 16:00:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9379861AEE;
        Fri,  1 Oct 2021 19:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633118346;
        bh=dfMT05z4eV+e0n5s2He/WUtZ8PLEmwpA1dWSQYxqgfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YFJTVJ0OJLXohGjunqgmodNqXsWhXxPN1P/qbFzyuw2E+IUd2V9pSENHPzoP7Oo5Q
         Dt07TZb9OZS9BFFfv76NsqaNN0ZxG2lnz/tUx0RIh//+lv3rfOosKHYTe4XqRZQhA0
         GU4u3qWhh3zlNIYdQpt+b0cXLN2XXESGwZ6vTorU1weJkR/yvk5/nYPKjVhhEawkoJ
         +bb7MuhgsDKGFC9471Ov+LVnFZEl1cShSH4vXgFqOUqdEX8wedevrdrBTVUd7fpVzP
         D6Ik78kwPJjpRpW6UzdRQu3f4I8QDk199NYilIX3R8wRzwGHVHHska+vIhigDL2B5E
         ai2VWH2lCKxFQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 04/13] PCI: aardvark: Fix preserving PCI_EXP_RTCTL_CRSSVE flag on emulated bridge
Date:   Fri,  1 Oct 2021 21:58:47 +0200
Message-Id: <20211001195856.10081-5-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211001195856.10081-1-kabel@kernel.org>
References: <20211001195856.10081-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Commit 43f5c77bcbd2 ("PCI: aardvark: Fix reporting CRS value") started
using CRSSVE flag for handling CRS responses.

PCI_EXP_RTCTL_CRSSVE flag is stored only in emulated config space buffer
and there is handler for PCI_EXP_RTCTL register. So every read operation
from config space automatically clears CRSSVE flag as it is not defined in
PCI_EXP_RTCTL read handler.

Fix this by reading current CRSSVE bit flag from emulated space buffer and
appending it to PCI_EXP_RTCTL read response.

Fixes: 43f5c77bcbd2 ("PCI: aardvark: Fix reporting CRS value")
Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index a7903c531aa3..bb57ca6aed35 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -724,6 +724,7 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 	case PCI_EXP_RTCTL: {
 		u32 val = advk_readl(pcie, PCIE_ISR0_MASK_REG);
 		*value = (val & PCIE_MSG_PM_PME_MASK) ? 0 : PCI_EXP_RTCTL_PMEIE;
+		*value |= le16_to_cpu(bridge->pcie_conf.rootctl) & PCI_EXP_RTCTL_CRSSVE;
 		*value |= PCI_EXP_RTCAP_CRSVIS << 16;
 		return PCI_BRIDGE_EMUL_HANDLED;
 	}
-- 
2.32.0

