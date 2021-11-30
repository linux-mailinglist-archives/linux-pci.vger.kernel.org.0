Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFF8463CD8
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 18:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244793AbhK3RdA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 12:33:00 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36898 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244804AbhK3Rc4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 12:32:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3960B819D9
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 17:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688E2C53FC7;
        Tue, 30 Nov 2021 17:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638293374;
        bh=M6tNWO536plERaZIuHbYRn6PBnGBdabqikBGDvoXKgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cuuw7SwWcH74zBZftlYHBouIh/D5n84XG4qddd3riI6Yj0gb2ZH3ABGzMlqqnnpA8
         E+0pB1dKjRr6bSeKSLvtFzczsuQfXa56Uc7pNnxUPG1uDUgIMfPsauhW3KrhjVEcuy
         WdgecgEx3FMMYUA1QxgHbtXerfREQUdB940zy/95VvgricGB3tzrOYxAG4vsGFRdel
         A23jURAiDrtFAWqUwkGJ70QzFKs1KAF/RCow+l2MGybC2luvwcvkKbvJS3kCSu+33S
         MiTBdmcBggMC5VufjA1jaKKHaPqTglzovPBKJrHfs1mCc06xDKvTz+MIcYpJ06huzL
         LKddX3hBcx6VQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v4 11/11] PCI: aardvark: Disable common PHY when unbinding driver
Date:   Tue, 30 Nov 2021 18:29:13 +0100
Message-Id: <20211130172913.9727-12-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211130172913.9727-1-kabel@kernel.org>
References: <20211130172913.9727-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Disable the PCIe PHY when unbinding driver. This should save some power.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index e5c88f1c177b..2a82c4652c28 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1750,6 +1750,9 @@ static int advk_pcie_remove(struct platform_device *pdev)
 	for (i = 0; i < OB_WIN_COUNT; i++)
 		advk_pcie_disable_ob_win(pcie, i);
 
+	/* Disable phy */
+	advk_pcie_disable_phy(pcie);
+
 	return 0;
 }
 
-- 
2.32.0

