Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A50463CD5
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 18:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244817AbhK3Rc7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 12:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238833AbhK3Rcv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 12:32:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB0DC061574
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 09:29:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 250ADB81B11
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 17:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CECC56749;
        Tue, 30 Nov 2021 17:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638293369;
        bh=nanstgKNaG25ZIcyKPqk3VqUVXU/gblk2iUEYKx4BBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aY7hvnjIu7JOwnTP803QcLyJOBZfXIVp7NQB/vYCJ2qyg4xLlGfpQkUW9Ms2MiR62
         iJIueACrkPhw7diUiRwxSEzD2/pmwp34etL/0oAYH+14HCxr83RBQL+Zwc93RyVxlL
         NoGFBCiIVlgADA3OEU8soM5s6e9chTkaDI2Rveg0aWroF8/GCCTnJ5djQnY6TRQVH6
         hi1mO6lfZGrXyshlKqkPtVW9AXBlEVhV2m8R139e2sqaiJP1Fm0WL2YMUtclKMVVwB
         a3/m3z6RuaaWI67BmJ7rZQh9za1lWLU8HQCkEBymi+aw5XbSre4Ojv6EFD2hs/8brM
         /MzdR27bmC90w==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v4 08/11] PCI: aardvark: Fix memory leak in driver unbind
Date:   Tue, 30 Nov 2021 18:29:10 +0100
Message-Id: <20211130172913.9727-9-kabel@kernel.org>
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

Free config space for emulated root bridge when unbinding driver to fix
memory leak. Do it after disabling and masking all interrupts, since
aardvark interrupt handler accesses config space of emulated root
bridge.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 08b34accfe2f..b3d89cb449b6 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1734,6 +1734,9 @@ static int advk_pcie_remove(struct platform_device *pdev)
 	advk_pcie_remove_msi_irq_domain(pcie);
 	advk_pcie_remove_irq_domain(pcie);
 
+	/* Free config space for emulated root bridge */
+	pci_bridge_emul_cleanup(&pcie->bridge);
+
 	/* Disable outbound address windows mapping */
 	for (i = 0; i < OB_WIN_COUNT; i++)
 		advk_pcie_disable_ob_win(pcie, i);
-- 
2.32.0

