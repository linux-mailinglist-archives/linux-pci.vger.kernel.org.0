Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F38F488E41
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 02:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbiAJBum (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jan 2022 20:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237992AbiAJBum (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jan 2022 20:50:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBEFC06173F
        for <linux-pci@vger.kernel.org>; Sun,  9 Jan 2022 17:50:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DD5260EC8
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 01:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F16C36AE3;
        Mon, 10 Jan 2022 01:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641779440;
        bh=19RdElfSftNYfU757yNma9VL06wj5lXcpWlMxa9HNbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+4GFUiAIuMHJnaBrrcj0t3vWdGnXEv/7Tyt1J0siotacX74qGcwAZyet3uObo4AA
         7UfefnRFSmX/0Ucw7Ecv7lDh2J5/jE/F+t2SCyoNNcl6fFp5zhmC2rdzGEXQam6+Z9
         te82X31FSsi1j6dJMdhEFJt7AuRXixox8P2pWw/HdwlqNcsEt8tkXC6QJSXAe9vucb
         21y24jd5pjmwhMNOIoO0UOQPdVPq7jK1EPtGjrELyEMluWGc3M2SWfv9UD7zmM67Wj
         7yI4Cxc2mVqBc6V3CmujbrT81uycvh60fuS0J5v/OUSYngsdOtxcbfntazXgmTbfkc
         FKypoEoUy/jbA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 08/23] PCI: aardvark: Use dev_fwnode() instead of of_node_to_fwnode(dev->of_node)
Date:   Mon, 10 Jan 2022 02:50:03 +0100
Message-Id: <20220110015018.26359-9-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220110015018.26359-1-kabel@kernel.org>
References: <20220110015018.26359-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use simple
  dev_fwnode(dev)
instead of
  struct device_node *node = dev->of_node;
  of_node_to_fwnode(node)
especially since the node variable is not used elsewhere in the function.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 5ab107f65c6c..3f7515814167 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1301,7 +1301,6 @@ static struct msi_domain_info advk_msi_domain_info = {
 static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
-	struct device_node *node = dev->of_node;
 	phys_addr_t msi_msg_phys;
 
 	mutex_init(&pcie->msi_used_lock);
@@ -1320,7 +1319,7 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
 		return -ENOMEM;
 
 	pcie->msi_domain =
-		pci_msi_create_irq_domain(of_node_to_fwnode(node),
+		pci_msi_create_irq_domain(dev_fwnode(dev),
 					  &advk_msi_domain_info,
 					  pcie->msi_inner_domain);
 	if (!pcie->msi_domain) {
-- 
2.34.1

