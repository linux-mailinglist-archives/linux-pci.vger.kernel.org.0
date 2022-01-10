Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BDC488E4E
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 02:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238002AbiAJBvF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jan 2022 20:51:05 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59602 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238017AbiAJBvD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jan 2022 20:51:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B84B60F61
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 01:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF46C36AF5;
        Mon, 10 Jan 2022 01:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641779462;
        bh=TYb33GgCKOsNY6NxVzwzD4oOwOuZ7EIU5PjjVRGm2nQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LKcxqhBgjydS42WzcWc9t8xqekXY8L8bmv1JJ6ihcwBfgrSNPtS+Kv9cVBkP0lOAx
         keDVNzGo3+p1429wD7OKwNR/oitwIJYrc8rng3jWWYMcO+wSbNbHriX82oHdbhs8NY
         MGjXilO1+/CgJ6gTa2DBM8vyXByoznpLe9t4WoFZhdWmYGsEtEzPd6ASx/RcUnXhQZ
         DjNG9b46HN9PO6uzZGTbx1Uk7SM52H1unQgaPCd55f6Cptr/yhDuNZeJ3JA4jq5EPt
         gw+QjcsGyBAemGDF0DAtjeIhNRLDzcBSnzj/hms+mR5qiDU7GT7FtLyA6gEc50ka9R
         MU0mMjV4r3PBA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 19/23] PCI: aardvark: Remove irq_mask_ack callback for INTx interrupts
Date:   Mon, 10 Jan 2022 02:50:14 +0100
Message-Id: <20220110015018.26359-20-kabel@kernel.org>
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

Callback for irq_mask_ack is the same as for irq_mask. As there is no
special handling for irq_ack, there is no need to define irq_mask_ack too.

Signed-off-by: Pali Rohár <pali@kernel.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index ca519cadcdfe..a41e3e206478 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1422,7 +1422,6 @@ static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
 	}
 
 	irq_chip->irq_mask = advk_pcie_irq_mask;
-	irq_chip->irq_mask_ack = advk_pcie_irq_mask;
 	irq_chip->irq_unmask = advk_pcie_irq_unmask;
 
 	pcie->irq_domain =
-- 
2.34.1

