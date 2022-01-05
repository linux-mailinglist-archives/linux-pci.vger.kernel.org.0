Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E27485017
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 10:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbiAEJgM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 04:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238896AbiAEJgL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jan 2022 04:36:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AC5C061761;
        Wed,  5 Jan 2022 01:36:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 261E06164C;
        Wed,  5 Jan 2022 09:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4B8C36AEB;
        Wed,  5 Jan 2022 09:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641375370;
        bh=yavQwAI4HRXXhMr+MS64YOLNNUOWumphyROhMVNBb78=;
        h=From:To:Cc:Subject:Date:From;
        b=aL1rtyiVFWmFII3cxefiiJn9n6ax/jI47lS1L0WtPUS39sYTpXb5rs7jis2abTzzI
         hIa/VwDo0VjrRjIenLclVLMwc4i2F2K9oUxTGTiYaDvoFxIS5jWquhvF7mSqa9SoLf
         PEBe6MSikAIlBe1KxWHc7qfJ75DipZe9ojupZ3i8+DC4IZ0LQHKukCuR5shE4enPty
         HV6IOQaL5hhms5XMbspWVP14O7W1MTmAsoKjKAi7OmnCEan3M3CG8bVFToG3Z0Ofdu
         WmrHRvVuVN6dkd3mPYXGe+UBz6dbf05Z32GOFGIMGhAmC1fPj//YinoU565z0G1L3y
         xHLev+ILRkMvQ==
Received: by pali.im (Postfix)
        id 7898482A; Wed,  5 Jan 2022 10:36:07 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Roman Bacik <roman.bacik@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: iproc: Set all 24 bits of PCI class code
Date:   Wed,  5 Jan 2022 10:35:52 +0100
Message-Id: <20220105093552.27542-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Register 0x43c in its low 24 bits contains PCI class code.

Update code to set all 24 bits of PCI class code and not only upper 16 bits
of PCI class code.

Use a new macro PCI_CLASS_BRIDGE_PCI_NORMAL which represents whole 24 bits
of normal PCI bridge class.

Signed-off-by: Pali Rohár <pali@kernel.org>

---
Roman helped me with this change and confirmed that class code is stored
really in bits [23:0] of custom register 0x43c (normally class code is
stored in bits [31:8] of pci register 0x08).

This patch depends on patch which adds PCI_CLASS_BRIDGE_PCI_NORMAL macro:
https://lore.kernel.org/linux-pci/20211220145140.31898-1-pali@kernel.org/
---
 drivers/pci/controller/pcie-iproc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 3df4ab209253..2519201b0e51 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -789,14 +789,13 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie)
 		return -EFAULT;
 	}
 
-	/* force class to PCI_CLASS_BRIDGE_PCI (0x0604) */
+	/* force class to PCI_CLASS_BRIDGE_PCI_NORMAL (0x060400) */
 #define PCI_BRIDGE_CTRL_REG_OFFSET	0x43c
-#define PCI_CLASS_BRIDGE_MASK		0xffff00
-#define PCI_CLASS_BRIDGE_SHIFT		8
+#define PCI_BRIDGE_CTRL_REG_CLASS_MASK	0xffffff
 	iproc_pci_raw_config_read32(pcie, 0, PCI_BRIDGE_CTRL_REG_OFFSET,
 				    4, &class);
-	class &= ~PCI_CLASS_BRIDGE_MASK;
-	class |= (PCI_CLASS_BRIDGE_PCI << PCI_CLASS_BRIDGE_SHIFT);
+	class &= ~PCI_BRIDGE_CTRL_REG_CLASS_MASK;
+	class |= PCI_CLASS_BRIDGE_PCI_NORMAL;
 	iproc_pci_raw_config_write32(pcie, 0, PCI_BRIDGE_CTRL_REG_OFFSET,
 				     4, class);
 
-- 
2.20.1

