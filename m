Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F0244100F
	for <lists+linux-pci@lfdr.de>; Sun, 31 Oct 2021 19:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhJaSPQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 31 Oct 2021 14:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230346AbhJaSPQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 31 Oct 2021 14:15:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F87661075;
        Sun, 31 Oct 2021 18:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635703964;
        bh=CFz1ww2PxVubKvD/m4QlsyAK29ZspECeJ2f5FC4F+GM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s/FXG7SI1EESSKL8O8cMVPJLSexDVQi9sGTeAXRwXF28Be5BvvDRGuUv8jNI+J5qq
         JtTtm6LAorQSoiAA+0ru0ZTxbJJtE3ciBR3IOrDBFCero9eAK8Bs8NzEoyiDvY9BoH
         kRh10TTGZhmi84lXtsV9Zvc2vlyHBjMrVBRFx+yN1OtBxrahp0uw9q1Su5bViDLKeZ
         DSrAUdpDXUn1Gj4ypEkFOFcKPF/yn9Yjtvz9IiPqcCygSDUxnj+DHhWK8d77jh63Yq
         e8FL9erSX5EMAuEUxgcz5Auee9yXg6xHSCjChqJAA+BrIzW6neRia+JeiKFQLQqedD
         OVCSHKlz41EGg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 6/7] PCI: aardvark: Free config space for emulated root bridge when unbinding driver to fix memory leak
Date:   Sun, 31 Oct 2021 19:12:32 +0100
Message-Id: <20211031181233.9976-7-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211031181233.9976-1-kabel@kernel.org>
References: <20211031181233.9976-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Do it after disabling and masking all interrupts, since aardvark interrupt
handler accesses config space of emulated root bridge.

Fixes: 526a76991b7b ("PCI: aardvark: Implement driver 'remove' function and allow to build it as module")
Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org
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

