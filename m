Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65775463477
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 13:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241635AbhK3MkI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 07:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241653AbhK3MkE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 07:40:04 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E399EC061746
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 04:36:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 412B2CE1992
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 12:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9033C53FCF;
        Tue, 30 Nov 2021 12:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638275802;
        bh=dYfzN6X0G22H94LW3KF/P1tqeqWEbRgCPaXPmrfgByY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hg/v2MPqT+nHMuHVKjY8f0UKDczzAoVXyt7Um61FX0xqyhk6lupSEoNrRN5OsRstC
         j1b7U8jUcTTKIU2IOmm4bIf6DwXFKuhEIuVIsdpGdrB10xk3IrnXEeDRoZOMpf4n7W
         bH1tTox2l7OB9uRmkd6HAIB/my6mV23jCFij4ThlQzjii8Odk+Wij3kt8EvdbfUrxj
         Dz70QjT5U52UOjPimx/cPyNkrzwiy0/BJQ4hmJfeKiipKQpg1vuwZpW0SWP4e2vszV
         TSOgQePAlX3CBbQmIYMhQ26azXmSnV81bkhAd/RLbDprYQTB2OAtYxoZOFvCd2gw18
         0MFWdBq0dRMMg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 10/11] PCI: aardvark: Disable link training when unbinding driver
Date:   Tue, 30 Nov 2021 13:36:20 +0100
Message-Id: <20211130123621.23062-11-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211130123621.23062-1-kabel@kernel.org>
References: <20211130123621.23062-1-kabel@kernel.org>
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

