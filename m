Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B668C46CDA8
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 07:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbhLHGW5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 01:22:57 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:49004 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237858AbhLHGW4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 01:22:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 337E4CE2036
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 06:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C25CC341C8;
        Wed,  8 Dec 2021 06:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638944362;
        bh=Kt/sCh+jnnZynpI0is399e8fkVOQKIJTTF44pWn58qM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pr1dU172dk0A6CoPCGtN2+o66XygVbg5akb49TaIJfDeqmW5OfFMFAzeOcI4l4Kqm
         twoYxemRJ08MKvRvoYv275uGqjelR4Y4XWw6up1JjUz72+nnH5CFZ/i4+GMo97ZBbl
         x/62rAmoE23T00AWGi3NplNc+qnW4DE0T7LT+xh3HQ//FrKHXNWKH52nQVxLiyWSjl
         +Fd61SXgUHcpY/i1qHANZUzbd6Cnw/KfgyUpQg9tLT0eWP46ar7ov9DSwVVQICyk4J
         CNmAnXeR8LDrD98GKkROc0V9ugKg91daS13nu/XxN04tPAwfjuaTfUT1amrnSXWbng
         Fee20iv/RUwAQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 16/17] PCI: aardvark: Remove irq_mask_ack callback for INTx interrupts
Date:   Wed,  8 Dec 2021 07:18:50 +0100
Message-Id: <20211208061851.31867-17-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211208061851.31867-1-kabel@kernel.org>
References: <20211208061851.31867-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Callback for irq_mask_ack is the same as for irq_mask. As there is no
special handling for irq_ack, there is no need to define irq_mask_ack too.

Signed-off-by: Pali Rohár <pali@kernel.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 3cde3f761696..4a21387a4693 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1430,7 +1430,6 @@ static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
 	}
 
 	irq_chip->irq_mask = advk_pcie_irq_mask;
-	irq_chip->irq_mask_ack = advk_pcie_irq_mask;
 	irq_chip->irq_unmask = advk_pcie_irq_unmask;
 
 	pcie->irq_domain =
-- 
2.32.0

