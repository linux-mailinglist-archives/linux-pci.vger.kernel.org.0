Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0334B488E4F
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 02:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbiAJBvH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jan 2022 20:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbiAJBvG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jan 2022 20:51:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8BCC06173F
        for <linux-pci@vger.kernel.org>; Sun,  9 Jan 2022 17:51:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A669B60EC8
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 01:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF3AC36AF4;
        Mon, 10 Jan 2022 01:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641779464;
        bh=TQ785+uJDQSZA+Yw7CfOyt5PsjyTp09oxgRfA+zhzAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UdiDnG0J4n9I5Z2bf4OxDXEZs9PZUP5xGnUrfjem7pcrUhM2nd8ZnU8hDsVPRVYol
         kOhwxVx6IvvsHAsNtXDkLfg73UOJmS9hmbki7exmYAHmDeBdJ4Iuy6lO68l+EBkLwX
         yxEnHxG1/rkFLLugNs5agm816IH4qdgGY2x1bGRfrtTM0Pv9p5cYZK+Lm8dtSsbwVp
         +OLRXrE0yCZIDV0AcyJf18x5Jb70y+QXJQVH3VrwG2V6+PNtPD1ekmH6ERWxNYvXTD
         pBikqnFJ4lqGNcTFI2mgkQM6GOfhm0CyfboMBIk8HqCnodZsu9al/JX7V4NhiCzBFn
         V2+3JGXoaHEcg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 20/23] PCI: aardvark: Don't mask irq when mapping
Date:   Mon, 10 Jan 2022 02:50:15 +0100
Message-Id: <20220110015018.26359-21-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220110015018.26359-1-kabel@kernel.org>
References: <20220110015018.26359-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

By default, all Legacy INTx interrupts are masked, so there is no need to
mask this interrupt during irq_map callback.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index a41e3e206478..0e3dcd584f7e 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1339,7 +1339,6 @@ static int advk_pcie_irq_map(struct irq_domain *h,
 {
 	struct advk_pcie *pcie = h->host_data;
 
-	advk_pcie_irq_mask(irq_get_irq_data(virq));
 	irq_set_status_flags(virq, IRQ_LEVEL);
 	irq_set_chip_and_handler(virq, &pcie->irq_chip,
 				 handle_level_irq);
-- 
2.34.1

