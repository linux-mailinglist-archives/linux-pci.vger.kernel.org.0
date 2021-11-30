Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DEC463568
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 14:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240275AbhK3N3J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 08:29:09 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60318 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240253AbhK3N3I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 08:29:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EBE3B819D8
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 13:25:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E3AC56748;
        Tue, 30 Nov 2021 13:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638278747;
        bh=OyvDA4KdWu05oEmPO5pM0S8DH5a/aV8ZVB4bn8ffkxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AF6pyn/nbq2iD260wB/zFAH5nFrmo3z+vHPP5AmJb88fRxSTK4SzhWIRUyxbF6mOn
         T873Ue9oDMuoNYS9p+SjbqbzThirdSQYFoE3T0TLYSGgw14xUtO3GrC7UYIwlLIu/n
         j3BBA03CnXr/+4sgGrzYEoGGYyMDeNbcEg1gSv3SkZvCrv6ggrrUpO1feJXz9C40x7
         8rFj9gBJ2p6y7OEaVpxQv7oONOh2WeI8HstAO0Wk7QMU9IK+tVIjk5tsp90+9Y0Qra
         LqIDOKiQWyOLX8zNwvN6MsyoEc8/Ka8uf1aJXYxxHSEJDywyghdW9X5RNh2xfJVvDB
         jI3HtCAXd8uqw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v3 11/11] PCI: aardvark: Disable common PHY when unbinding driver
Date:   Tue, 30 Nov 2021 14:25:23 +0100
Message-Id: <20211130132523.28126-12-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211130132523.28126-1-kabel@kernel.org>
References: <20211130132523.28126-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Disable the PCIe PHY when unbinding driver, to save power.

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

