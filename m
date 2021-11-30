Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3D8463565
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 14:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhK3N3E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 08:29:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60260 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240202AbhK3N3E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 08:29:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0304EB817AF
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 13:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAF9C53FC7;
        Tue, 30 Nov 2021 13:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638278742;
        bh=nanstgKNaG25ZIcyKPqk3VqUVXU/gblk2iUEYKx4BBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gzh6oL+8eLueTThxbF7Gz5LATFfq3BivVk2ze53+7xycgrX9sGgccaRDEOZRtx3uf
         P6gT/qJJUQbu+a8KzVVIi2Cbsz0BVU4HFLwoFnFAY64/UGuNYTZCUWEygifpjEi3RJ
         BTkwwWiVTLOysV1PjtebtQ7e4qYCWLiQ2LphFcMRkciCwRP8bfyJwxO1GBXEOh7KVj
         XKZ0rl8YwkkF4uLh8XyHoKmx0YHK3zQClRbcBxShU4FAgIBZKpa+Z3j/tStS5N60nt
         ihIA5PnEwczhpL+CsDi0s6vC4J8KJG2mdlDJ1/mHzXdrnQrK74ppaqB6hRfBFk49PE
         QLd9H9SrmVnsA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v3 08/11] PCI: aardvark: Fix memory leak in driver unbind
Date:   Tue, 30 Nov 2021 14:25:20 +0100
Message-Id: <20211130132523.28126-9-kabel@kernel.org>
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

