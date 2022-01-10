Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5C9488E47
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 02:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbiAJBvC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jan 2022 20:51:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59466 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237996AbiAJBux (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jan 2022 20:50:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FF3460F5F
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 01:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D99BC36AEB;
        Mon, 10 Jan 2022 01:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641779452;
        bh=4A5p3djI1Kwo5RxvvLcygM7XaNAMZHq/gtkzkQlgd8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SDDgnwA+fxs2NvelElNZQE0MFCGIzkAFdlmtrg4qQ9i+BLTLUceXVoSxG9dQdu60u
         gKwD5l3CLSPyS4jmuwKp9MGpRSkqYRQznM6eZMBTKMbsKwzdipEfCsjHOfRgfW1sYC
         A1+OdfUXPZnpHwBaxEQsaj/IlqZRltarhGgkZB5bYeMAbLX+n50oirpGglkxLNdZsD
         9vb5EdJHwK/PzpDFGswdt9ccImzkFEcbnxAu9MSE9Xp2F3kjtVzkTeWwNqM/VEwipo
         W70TGrpLzb1fgupBsaQ/d7NdwtTpagoaLNuZix0LQIZce6I2ajKQ0Q0BVxRUV6l5L/
         M+IhC5mgxdKbQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 14/23] PCI: aardvark: Fix reading PCI_EXP_RTSTA_PME bit on emulated bridge
Date:   Mon, 10 Jan 2022 02:50:09 +0100
Message-Id: <20220110015018.26359-15-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220110015018.26359-1-kabel@kernel.org>
References: <20220110015018.26359-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

The emulated bridge returns incorrect value for PCI_EXP_RTSTA register
during readout in advk_pci_bridge_emul_pcie_conf_read() function: the
correct bit is BIT(16), but we are setting BIT(23), because the code
does
  *value = (isr0 & PCIE_MSG_PM_PME_MASK) << 16
where
  PCIE_MSG_PM_PME_MASK
is
  BIT(7).

The code should probably have been something like
  *value = (!!(isr0 & PCIE_MSG_PM_PME_MASK)) << 16,
but we are better of using an if() and using the proper macro for this
bit.

Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 6fc6c3199954..8706a5f58eb5 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -876,7 +876,9 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 	case PCI_EXP_RTSTA: {
 		u32 isr0 = advk_readl(pcie, PCIE_ISR0_REG);
 		u32 msglog = advk_readl(pcie, PCIE_MSG_LOG_REG);
-		*value = (isr0 & PCIE_MSG_PM_PME_MASK) << 16 | (msglog >> 16);
+		*value = msglog >> 16;
+		if (isr0 & PCIE_MSG_PM_PME_MASK)
+			*value |= PCI_EXP_RTSTA_PME;
 		return PCI_BRIDGE_EMUL_HANDLED;
 	}
 
-- 
2.34.1

