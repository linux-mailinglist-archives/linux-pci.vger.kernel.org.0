Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8042D463567
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 14:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240231AbhK3N3J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 08:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240235AbhK3N3H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 08:29:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7E4C061746
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 05:25:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16CFDB817AF
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 13:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D26C53FD0;
        Tue, 30 Nov 2021 13:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638278745;
        bh=dYfzN6X0G22H94LW3KF/P1tqeqWEbRgCPaXPmrfgByY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QGS8qhgYuRoVGeR3Fc73Y3IaBUZbFMfOqECXvYZEr1vcQxciwMlwJ89cLghEGiW9V
         4JA9N+jCO34EXhH9SHVz4hp9qsUC17u8qHcFGqybOGZZWUQzT1KJ4WxefNkja1gg9P
         JKPbJ085FboHRQQJ2BiktdnJlU3H99iX5YyE+vZAJLu8fDFPhrle8rWsyNxX6/sH5D
         s50miMhMCSezJDRJhAUC8956dv1RRioAu8Rp50SX5xG0yVPd38s5gIQbayI1dnO/uV
         OjeJNL5bKa+Xhb4EKNw/trshsn6xtLmKkroJW/uwxnxyHIcfwt3Cy2n/CmL8EPndxv
         GQCIJZML/AC0Q==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v3 10/11] PCI: aardvark: Disable link training when unbinding driver
Date:   Tue, 30 Nov 2021 14:25:22 +0100
Message-Id: <20211130132523.28126-11-kabel@kernel.org>
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

Disable link training circuit in driver unbind sequence.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 271ebecee965..e5c88f1c177b 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1741,6 +1741,11 @@ static int advk_pcie_remove(struct platform_device *pdev)
 	if (pcie->reset_gpio)
 		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
 
+	/* Disable link training */
+	val = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
+	val &= ~LINK_TRAINING_EN;
+	advk_writel(pcie, val, PCIE_CORE_CTRL0_REG);
+
 	/* Disable outbound address windows mapping */
 	for (i = 0; i < OB_WIN_COUNT; i++)
 		advk_pcie_disable_ob_win(pcie, i);
-- 
2.32.0

