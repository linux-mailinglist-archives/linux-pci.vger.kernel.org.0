Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBE642A9BA
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 18:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhJLQnv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 12:43:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230148AbhJLQnv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 12:43:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8479661074;
        Tue, 12 Oct 2021 16:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634056909;
        bh=DgDwJyTpY2SNF+BMO6REe24ZpCAwiBRSvTJpcdEY/8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qL3NsbQjWjjIEuH66WqB6s3YfxQ7FKVpEjbbj7jUpTgT0BxfLEh6OQY9m24uZVMKa
         PZ4YJGhUY2o1g4z95NRGZa/p8BC995+aRQIVoOeBEkQul9B7WoVTWMrOIm6MFHE7fU
         ZU45f0hpOJiiXke/2vlCJVLvzehPtmv4UYxwHgxtfqvb7n1OYORBiikN5Rf2/9lgRZ
         aPds+EXO8OWNOKYBIK2Vx9iJxGAlkIXPUNPOnV1z2l68u0B3lUkUWYSgL4i3/fDpuh
         CLuK5qRqftWtKORMSxod4WcnBSngESDp2CvU4mkLpacuDJj8LqFzXtCcSZZFHu4Jq6
         D4rmp6UIPrwGA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 01/14] PCI: pci-bridge-emul: Fix emulation of W1C bits
Date:   Tue, 12 Oct 2021 18:41:32 +0200
Message-Id: <20211012164145.14126-2-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012164145.14126-1-kabel@kernel.org>
References: <20211012164145.14126-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_bridge_emul_conf_write() function correctly clears W1C bits in
cfgspace cache, but it does not inform the underlying implementation
about the clear request: the .write_op() method is given the value with
these bits cleared.

This is wrong if the .write_op() needs to know which bits were requested
to be cleared.

Fix the value to be passed into the .write_op() method to have requested
W1C bits set, so that it can clear them.

Both pci-bridge-emul users (mvebu and aardvark) are compatible with this
change.

Fixes: 23a5fba4d941 ("PCI: Introduce PCI bridge emulated config space common logic")
Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org
Cc: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/pci/pci-bridge-emul.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index fdaf86a888b7..db97cddfc85e 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -431,8 +431,21 @@ int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
 	/* Clear the W1C bits */
 	new &= ~((value << shift) & (behavior[reg / 4].w1c & mask));
 
+	/* Save the new value with the cleared W1C bits into the cfgspace */
 	cfgspace[reg / 4] = cpu_to_le32(new);
 
+	/*
+	 * Clear the W1C bits not specified by the write mask, so that the
+	 * write_op() does not clear them.
+	 */
+	new &= ~(behavior[reg / 4].w1c & ~mask);
+
+	/*
+	 * Set the W1C bits specified by the write mask, so that write_op()
+	 * knows about that they are to be cleared.
+	 */
+	new |= (value << shift) & (behavior[reg / 4].w1c & mask);
+
 	if (write_op)
 		write_op(bridge, reg, old, new, mask);
 
-- 
2.32.0

