Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2BD463475
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 13:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241628AbhK3MkI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 07:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241641AbhK3MkB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 07:40:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C7DC061574
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 04:36:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 325D8CE1992
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 12:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CC5C53FD0;
        Tue, 30 Nov 2021 12:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638275799;
        bh=nanstgKNaG25ZIcyKPqk3VqUVXU/gblk2iUEYKx4BBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zft96Le2XT7G3NQ1TvsFXdB+3u+pnTH5wyRcG+KWjPMTBzJ/oYsy0/Z5Y7wQfn69f
         3GRkKLNYkVxz50KpZ2LTJef/gtJ9wuGgBcqB8Rd9MhZ/8GsCH9W7AJtqmx8BqgMS46
         X4DEYLPxihEzmQ1GG8lJeQO2HRh0WQtikuwBJ+itGMTI2TqBFC+SgeJtQgXNr+qjbO
         XeZv+3BuMEYvXgqcyumrzEt4qQMeMk5XElBhscAWzCPS+IvWO2EX6bQ7rHZZ3nRrjn
         rrezZ3irgUnszciFVbQvXhXD/YrX14D5sCmVMSOKomVJP+nJqKkunNrv72EsWv0wfW
         HGW8OIcO5sPqw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 08/11] PCI: aardvark: Fix memory leak in driver unbind
Date:   Tue, 30 Nov 2021 13:36:18 +0100
Message-Id: <20211130123621.23062-9-kabel@kernel.org>
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

