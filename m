Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46381488E51
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 02:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbiAJBvO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jan 2022 20:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238026AbiAJBvK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jan 2022 20:51:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0999DC061748
        for <linux-pci@vger.kernel.org>; Sun,  9 Jan 2022 17:51:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9507C60DC9
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 01:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D275C36AEF;
        Mon, 10 Jan 2022 01:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641779468;
        bh=KV7Ev/+vKumsneQrWXEMHP1+QXgo9I55XQRdzbJR9Gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tDGmslbciBZK6YBatPSCm3gqZ8oIsGRAJEJ5UULGjU3QWMMzKwuxck6B1FvIw8Of5
         wHnrYdEh27ejd71+mbElkc4uUfixv2n5wPzQe3M5av2SnpqsHMGTlSIMj6UALbS9Sb
         UnSCyn++6a8dh+5zLjPKw/eLxQWkqgGDRsUB4wktpA1DTQhKzZtLAYP0X+7hRsqrUT
         ajq616PqL/2eKD3axZKupsT5XHgJ6bPOJCb39Bm+1mAKl1mOxvGHrLkWtox8ZpwvYK
         l0OeASi+WSbrYHcUgjSehS9ZbfbAeCQ7z3Ut7MbQ68jv6S6o1WdB/+BrNtsWq2R2y1
         ynJ2jXJDWElXw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 22/23] PCI: aardvark: Update comment about link going down after link-up
Date:   Mon, 10 Jan 2022 02:50:17 +0100
Message-Id: <20220110015018.26359-23-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220110015018.26359-1-kabel@kernel.org>
References: <20220110015018.26359-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update the comment about what happens when link goes down after we have
checked for link-up. If a PIO request is done while link-down, we have
a serious problem.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 360e2e3b3aa6..2c5cc929b94f 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1007,8 +1007,12 @@ static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
 		return false;
 
 	/*
-	 * If the link goes down after we check for link-up, nothing bad
-	 * happens but the config access times out.
+	 * If the link goes down after we check for link-up, we have a problem:
+	 * if a PIO request is executed while link-down, the whole controller
+	 * gets stuck in a non-functional state, and even after link comes up
+	 * again, PIO requests won't work anymore, and a reset of the whole PCIe
+	 * controller is needed. Therefore we need to prevent sending PIO
+	 * requests while the link is down.
 	 */
 	if (!pci_is_root_bus(bus) && !advk_pcie_link_up(pcie))
 		return false;
-- 
2.34.1

