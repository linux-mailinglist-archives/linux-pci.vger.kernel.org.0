Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC69247C1F5
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 15:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbhLUO4t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 09:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238683AbhLUO4t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 09:56:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147CCC061574;
        Tue, 21 Dec 2021 06:56:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A50D46163B;
        Tue, 21 Dec 2021 14:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBD8C36AEC;
        Tue, 21 Dec 2021 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640098608;
        bh=zB+LhZA/mMW0h3avW6Wp5dGr4zLsowcd1TtLd2uAcf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qe+GY47Bi2ExCyR8FnxN8h/z5Qne05/DB2EqjLqhav+pZYXofgYtxbVawiyZVBkUJ
         XLtkour7BtiJCZn8yRjgJhKwIT7t1XBUtb+JZuLmGqq0l1R43+zE46RpLtrpFgPQ+9
         N4FmYDfTJG7hBHEfYEmQGTFMJyQ67U3SvcJKU9cV4mFat6ZH9XixU8HB2e7G97i99L
         N84P2NufEzDV8cRoeb3xYwat6oRypLmBADusIENzwIFlPiaLSk4SzJwudmWPQPfhAI
         sOI2/NOE9Wt+uzX/WgWjarVYN5+CQpiH3gFyksd18Y+o9DVTOPwzW9qbDt9QazkmcV
         zDSjdorzUBZnA==
Received: by pali.im (Postfix)
        id AA7A62862; Tue, 21 Dec 2021 15:18:13 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] PCI: pci-bridge-emul: Add support for new flag PCI_BRIDGE_EMUL_NO_IO_FORWARD
Date:   Tue, 21 Dec 2021 15:14:48 +0100
Message-Id: <20211221141455.30011-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211221141455.30011-1-pali@kernel.org>
References: <20211221141455.30011-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Like PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD, this new flag specifies that
emulated PCI bridge does not support forwarding of IO requests in given
range between primary and secondary buses. This flag should be used as
argument for pci_bridge_emul_init() for hardware setup without IO support.

Setting this flag cause that IO base and limit registers are read-only.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/pci-bridge-emul.c | 9 +++++++++
 drivers/pci/pci-bridge-emul.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 432b1bec2e22..033bbeb99176 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -378,6 +378,15 @@ int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
 		bridge->pci_regs_behavior[PCI_PREF_MEMORY_BASE / 4].rw = 0;
 	}
 
+	if (flags & PCI_BRIDGE_EMUL_NO_IO_FORWARD) {
+		bridge->pci_regs_behavior[PCI_COMMAND / 4].ro |= PCI_COMMAND_IO;
+		bridge->pci_regs_behavior[PCI_COMMAND / 4].rw &= ~PCI_COMMAND_IO;
+		bridge->pci_regs_behavior[PCI_IO_BASE / 4].ro |= GENMASK(15, 0);
+		bridge->pci_regs_behavior[PCI_IO_BASE / 4].rw &= ~GENMASK(15, 0);
+		bridge->pci_regs_behavior[PCI_IO_BASE_UPPER16 / 4].ro = ~0;
+		bridge->pci_regs_behavior[PCI_IO_BASE_UPPER16 / 4].rw = 0;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_bridge_emul_init);
diff --git a/drivers/pci/pci-bridge-emul.h b/drivers/pci/pci-bridge-emul.h
index 88877ebefbac..ab33609c598b 100644
--- a/drivers/pci/pci-bridge-emul.h
+++ b/drivers/pci/pci-bridge-emul.h
@@ -121,6 +121,7 @@ struct pci_bridge_emul {
 
 enum {
 	PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD = BIT(0),
+	PCI_BRIDGE_EMUL_NO_IO_FORWARD = BIT(1),
 };
 
 int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
-- 
2.20.1

