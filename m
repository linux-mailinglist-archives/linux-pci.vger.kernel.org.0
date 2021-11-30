Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2202A463CD7
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 18:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbhK3RdA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 12:33:00 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:53180 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244801AbhK3Rcy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 12:32:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3526ECE1A94
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 17:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54865C53FD1;
        Tue, 30 Nov 2021 17:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638293371;
        bh=pBomEVB82SlOMvHxL2Ymcsf/tRo4GB4F5I2CPf1ksvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NK82sKKO0qh0koHlRWaGjYPaFa/xvt65DpWG6I1Dd73ATBcPTSNilSo+he2VKmqIX
         o3eyATXQurzmOSSVkJk4Ipx2RSN2vvNNUYvbJRqZE2TjpBCwu6MZrwCCzhuL4minSP
         nIiviWAvCpRZY/PNNIVBn+CnpDFcNOSVHkAlgvi0t4kTImKHuul12TrTO8qKTyOU5m
         iLILLVeHihWUK4Z+liXguaTaHal0olcgR2kclxt5QR6M42SVsucoLEGnfKDKTKMCsr
         psjkCb9tCnpSr87O7c0TFLPLk9krHNArtuE2jhDwTNerM2UDj5d7ikn32o+wSvMZWM
         TRi5V10j+J86A==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v4 09/11] PCI: aardvark: Assert PERST# when unbinding driver
Date:   Tue, 30 Nov 2021 18:29:11 +0100
Message-Id: <20211130172913.9727-10-kabel@kernel.org>
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

Put the PCIe card into reset by asserting PERST# signal when unbinding
driver. It doesn't make sense to leave the card working if it can't
communicate with the host. This should also save some power.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index b3d89cb449b6..271ebecee965 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1737,6 +1737,10 @@ static int advk_pcie_remove(struct platform_device *pdev)
 	/* Free config space for emulated root bridge */
 	pci_bridge_emul_cleanup(&pcie->bridge);
 
+	/* Assert PERST# signal which prepares PCIe card for power down */
+	if (pcie->reset_gpio)
+		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
+
 	/* Disable outbound address windows mapping */
 	for (i = 0; i < OB_WIN_COUNT; i++)
 		advk_pcie_disable_ob_win(pcie, i);
-- 
2.32.0

