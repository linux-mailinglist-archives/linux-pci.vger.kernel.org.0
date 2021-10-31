Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1C2441009
	for <lists+linux-pci@lfdr.de>; Sun, 31 Oct 2021 19:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhJaSPN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 31 Oct 2021 14:15:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229898AbhJaSPK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 31 Oct 2021 14:15:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 618BD60F45;
        Sun, 31 Oct 2021 18:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635703958;
        bh=7dWtS7IabxxufChgE1lrOYtnRbIhcoqfnxK0McNkq24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eLy6yAthvy38X+aTHC9r+BCkcY1HQOlTSkNBmRDh6dlekg2a31qSTotZSxHUusgPo
         sHHRvOHiPmb8XFIwJghrGDJX8g7ebFur725naPux1rza8CNxK/RJaJWbiRcGXG17Lz
         gltU0S8o7CqNzabkvv+c6ihjeEH35rnwzrYS71CR2sIJetxPLIoVbaTkJJP0adocRH
         fByYs0A5wIV33RrbyUZgqvu8zMoQ2pv1wYbpFt3tw3ow8UWB/laJ3AbDPPO24M1TGp
         cXXS/YS5rEOCJfbOUHfKViGfn54i0w2vIsjU2p9QTW4T/rd+V26QQPBWt7idJWsWEE
         CYAUxKr+2/UfQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 1/7] PCI: pci-bridge-emul: Add description for class_revision field
Date:   Sun, 31 Oct 2021 19:12:27 +0100
Message-Id: <20211031181233.9976-2-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211031181233.9976-1-kabel@kernel.org>
References: <20211031181233.9976-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

The current assignment to the class_revision member

  class_revision |= cpu_to_le32(PCI_CLASS_BRIDGE_PCI << 16);

can make the reader think that class is at high 16 bits of the member and
revision at low 16 bits.

In reality, class is at high 24 bits, but the class for PCI Bridge Normal
Decode is PCI_CLASS_BRIDGE_PCI << 8.

Change the assignment and add a comment to make this clearer.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/pci-bridge-emul.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index db97cddfc85e..a4af1a533d71 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -265,7 +265,11 @@ int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
 {
 	BUILD_BUG_ON(sizeof(bridge->conf) != PCI_BRIDGE_CONF_END);
 
-	bridge->conf.class_revision |= cpu_to_le32(PCI_CLASS_BRIDGE_PCI << 16);
+	/*
+	 * class_revision: Class is high 24 bits and revision is low 8 bit of this member,
+	 * while class for PCI Bridge Normal Decode has the 24-bit value: PCI_CLASS_BRIDGE_PCI << 8
+	 */
+	bridge->conf.class_revision |= cpu_to_le32((PCI_CLASS_BRIDGE_PCI << 8) << 8);
 	bridge->conf.header_type = PCI_HEADER_TYPE_BRIDGE;
 	bridge->conf.cache_line_size = 0x10;
 	bridge->conf.status = cpu_to_le16(PCI_STATUS_CAP_LIST);
-- 
2.32.0

