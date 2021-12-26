Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9934147F5B3
	for <lists+linux-pci@lfdr.de>; Sun, 26 Dec 2021 08:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhLZHri (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Dec 2021 02:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhLZHri (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Dec 2021 02:47:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686A0C06173E;
        Sat, 25 Dec 2021 23:47:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5DCE60C69;
        Sun, 26 Dec 2021 07:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ED7C36AE8;
        Sun, 26 Dec 2021 07:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640504856;
        bh=yS0jkYyNkY8T9f/vf2NOxZtqE9xjvZoMNQmWrJiqk3k=;
        h=From:To:Cc:Subject:Date:From;
        b=D1WIrxrfUnVzKjyLDYQbII2AHbwDHTOphIsz5QeuKd5H8cYsXchu87wcwgZkZbdJR
         hMX8CZ5phZe2xzBcqzQrJSsIQc3M0Akl1XSTaj8Y1jNC/GACpOpy/ItmmTaFlurzRk
         C/EG0SCwEWL/SRnBqz7Yq7ubPCx8G+w7QDC1Qfd48isXKEv7EAMzUNhWt2flWrPfGl
         mECltOol3YabUfsyrjntcILQnbAGkPeAwBG4Qn/kTM23myQyT3TpImQ7YzcIoxTYsm
         0Fxje6rE8nCJKdJ/dcZbKsdXJHROw3AW0m7nPNeDvJ+S8zUXiOfTqJBabrsGS5HrkP
         7m2rTfu/oaEzg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: dwc: Fix integrated MSI Receiver mask reg setting during resume
Date:   Sun, 26 Dec 2021 15:40:19 +0800
Message-Id: <20211226074019.2556-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the host which makes use of the IP's integrated MSI Receiver losts
power during suspend, we call dw_pcie_setup_rc() to reinit the RC. But
dw_pcie_setup_rc() always set the pp->irq_mask[ctrl] as ~0, so the mask
register is always set as 0xffffffff incorrectly, thus the MSI can't
work after resume.

Fix this issue by moving pp->irq_mask[ctrl] initialization to
dw_pcie_host_init(), so we can correctly set the mask reg during both
boot and resume.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f4755f3a03be..2fa86f32d964 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -362,6 +362,12 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			if (ret < 0)
 				return ret;
 		} else if (pp->has_msi_ctrl) {
+			u32 ctrl, num_ctrls;
+
+			num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+			for (ctrl = 0; ctrl < num_ctrls; ctrl++)
+				pp->irq_mask[ctrl] = ~0;
+
 			if (!pp->msi_irq) {
 				pp->msi_irq = platform_get_irq_byname_optional(pdev, "msi");
 				if (pp->msi_irq < 0) {
@@ -541,7 +547,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 
 		/* Initialize IRQ Status array */
 		for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
-			pp->irq_mask[ctrl] = ~0;
 			dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK +
 					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
 					    pp->irq_mask[ctrl]);
-- 
2.34.1

