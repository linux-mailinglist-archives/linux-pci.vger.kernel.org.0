Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2A44B4F40
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 12:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352394AbiBNLqr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 06:46:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352564AbiBNLpV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 06:45:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547FFBC07;
        Mon, 14 Feb 2022 03:42:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5D0C61239;
        Mon, 14 Feb 2022 11:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DB9C340F0;
        Mon, 14 Feb 2022 11:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644838948;
        bh=N7rh+XBt1OX/shzAlcZiOlTmzf+JEyhpGWcp2MiIStk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OEhdptYx8JASrx2hZQVjdkyeBJgNEQGTvl5Ly9W8hGH8ryFzfz3UOD65bjMe4AOl4
         eHaUJLhWceDn0Tb1NZhuR1SP9+xnLGtDrFh6Z59psqU5xbrgC2VAHoh4968qs7skNx
         5hrk1AhMUhghsSpxG6OvbfraRoBpq3UTD7Njo+zr1BDNK/LbmIhkzPavdNhQ/X/+wi
         +MUued9GxBVl5JsdD9XDlVNOmbGZddaKlxs54ilB2931MZRmBpEDWHhRUTMztyPchE
         ESEJ/13GNsac93biwiUr8rCTyrNioPAlm1gKkD4x/5PKEtrP0js3cn5EazzFkAFF8v
         vlh2Hvwe99fOQ==
Received: by pali.im (Postfix)
        id 0CCE7153C; Mon, 14 Feb 2022 12:42:26 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 2/2] PCI: iproc: Set all 24 bits of PCI class code
Date:   Mon, 14 Feb 2022 12:41:09 +0100
Message-Id: <20220214114109.26809-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220214114109.26809-1-pali@kernel.org>
References: <20220214114109.26809-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Register 0x43c in its low 24 bits contains PCI class code.

Update code to set all 24 bits of PCI class code and not only upper 16 bits
of PCI class code.

Use a new macro PCI_CLASS_BRIDGE_PCI_NORMAL which represents whole 24 bits
of normal PCI bridge class.

Signed-off-by: Pali Rohár <pali@kernel.org>
Acked-by: Roman Bacik <roman.bacik@broadcom.com>
Acked-by: Ray Jui <ray.jui@broadcom.com>

---
Roman helped me with this change and confirmed that class code is stored
really in bits [23:0] of custom register 0x43c (normally class code is
stored in bits [31:8] of pci register 0x08).
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

