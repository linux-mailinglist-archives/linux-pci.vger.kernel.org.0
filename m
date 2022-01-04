Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30814844C8
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 16:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbiADPi2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 10:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiADPi1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jan 2022 10:38:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3624DC061761;
        Tue,  4 Jan 2022 07:38:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C807A614D1;
        Tue,  4 Jan 2022 15:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A9DC36AF5;
        Tue,  4 Jan 2022 15:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641310706;
        bh=hVpmL6carw5FHfSaRzrs6Ykkswp2VyP7qkjYE90lc6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jwm6LKxmU62KKfm+HrSdDh8ADqOhqWlb+/oP/+V0k+FUJZor620FE2qpr5RtPkaAN
         ez502/JmHsBooNlJN4XDTu8iiDv/Py6mvFy6p5EhIDV6nXObmdNadFnltDMRstWkxv
         WPgc8rG8S8Y9xrYXe9SHOSNYyxXU7B7BBLxU6mQH24ht5Z0t3rERzAkdMpXP+s74MS
         oliyVGFr0nPIb0q0kAx+TGvtXDinUKuC/W6E9WxA26ATmCv7vznoBqmTG/lzv8AYFu
         Uz8MYdfl+gCWHsxD1sVOfPh3m786XqHPYNSDwmzN2En8yVWX83JqIejuGXnD+KrsAc
         MTQKQ9xZJ/baA==
Received: by pali.im (Postfix)
        id C17E496B; Tue,  4 Jan 2022 16:38:25 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/11] PCI: pci-bridge-emul: Add support for new flag PCI_BRIDGE_EMUL_NO_IO_FORWARD
Date:   Tue,  4 Jan 2022 16:35:22 +0100
Message-Id: <20220104153529.31647-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220104153529.31647-1-pali@kernel.org>
References: <20211221141455.30011-1-pali@kernel.org>
 <20220104153529.31647-1-pali@kernel.org>
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
Changes in v2:
* Add comment into code.
---
 drivers/pci/pci-bridge-emul.c | 9 +++++++++
 drivers/pci/pci-bridge-emul.h | 6 ++++++
 2 files changed, 15 insertions(+)

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
index 087b5fa01bcf..4953274cac18 100644
--- a/drivers/pci/pci-bridge-emul.h
+++ b/drivers/pci/pci-bridge-emul.h
@@ -125,6 +125,12 @@ enum {
 	 * requests between primary and secondary buses.
 	 */
 	PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD = BIT(0),
+
+	/*
+	 * PCI bridge does not support forwarding of IO requests between
+	 * primary and secondary buses.
+	 */
+	PCI_BRIDGE_EMUL_NO_IO_FORWARD = BIT(1),
 };
 
 int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
-- 
2.20.1

