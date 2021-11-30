Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE49463CD6
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 18:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238691AbhK3RdA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 12:33:00 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36874 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244797AbhK3Rcy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 12:32:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28E93B81A1F
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 17:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8867C53FD0;
        Tue, 30 Nov 2021 17:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638293373;
        bh=DtXCis8UpAm0IwqZ7ib0fmmnItpB6w4HA0kaw+icOw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EVA1Lo/eCYgxGio4LHVsnV1TADaRzIOZehBr+w3syJabds6+k98xrQdMO2ZTxHLAI
         NTc+TligZIB/57w1RoR950hGkHabq0gRWhanDYWyEdvdosbIiEIxfIE3wqgOxozwh6
         T/Cmr1yuLo8Y/mk6DEVLxptsbkOfw0aK5o+WDzugROq88uhgR/8M+7qyiWSAEJ7yFc
         wgi4s1KJ2vbkUrSLFBWFySrktWFaiT3/t6KaIoeNqccVhXtqt4Wzv7kV1IQzB41DMU
         5e0MSKTVx9tujNgIY9csO+uUENO+U9Ps6+k1DFrMf/2cLJcRvAhB7APBWOLC/qd3K/
         +jZwBMPH4DpuQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v4 10/11] PCI: aardvark: Disable link training when unbinding driver
Date:   Tue, 30 Nov 2021 18:29:12 +0100
Message-Id: <20211130172913.9727-11-kabel@kernel.org>
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

Disable link training circuit in driver unbind sequence. We want to
leave link training in the same state as it was before the driver was
probed.

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

