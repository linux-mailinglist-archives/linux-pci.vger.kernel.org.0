Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BC6375742
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbhEFPds (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:33:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235352AbhEFPdq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0C7A613E4;
        Thu,  6 May 2021 15:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315167;
        bh=dHsqdNjyH3uEKBJHdSqdXMTYkvi4cwFKXYRKyfqwHMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hCUkcoTnKQxQXmXSBCd/GlARbvZoU+rw8K89DtIUwxZ9FWx0T2FxmToOoseROJIPt
         EbMQJwckfLttJTjMmp0CZ5QcCGEUbk7qeSERhshVV9QuEtdJTjUuU58n2bUKWslOKC
         xKdI8T7nq/whQmzDwIibtK4pP1dcP5mm8Zc+wSH8HSBCVm1Pkp7pIyLmwXlpBBi+4M
         9Q0ZiP8oYE7kKsgvHENJz3j1MM455BxNDEzyY7ZWV5jLSYsix3OaxK5z7RWUIRjePk
         bq8HqOablna25truOZSUKba7UVWnPAqggA6x81wxntVKU7HHCjiMhqHhH37deWQf6P
         jmhXzwsDzj70w==
Received: by pali.im (Postfix)
        id A824211AB; Thu,  6 May 2021 17:32:45 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/42] PCI: aardvark: Fix reporting CRS Software Visibility on emulated bridge
Date:   Thu,  6 May 2021 17:31:17 +0200
Message-Id: <20210506153153.30454-7-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CRS Software Visibility is supported and always enabled by PIO.
Correctly report this information via emulated root bridge.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 3f3c72927afb..e297ec9ec390 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -578,6 +578,8 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 	case PCI_EXP_RTCTL: {
 		u32 val = advk_readl(pcie, PCIE_ISR0_MASK_REG);
 		*value = (val & PCIE_MSG_PM_PME_MASK) ? 0 : PCI_EXP_RTCTL_PMEIE;
+		*value |= PCI_EXP_RTCTL_CRSSVE;
+		*value |= PCI_EXP_RTCAP_CRSVIS << 16;
 		return PCI_BRIDGE_EMUL_HANDLED;
 	}
 
@@ -659,6 +661,7 @@ static struct pci_bridge_emul_ops advk_pci_bridge_emul_ops = {
 static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 {
 	struct pci_bridge_emul *bridge = &pcie->bridge;
+	int ret;
 
 	bridge->conf.vendor =
 		cpu_to_le16(advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & 0xffff);
@@ -682,7 +685,16 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 	bridge->data = pcie;
 	bridge->ops = &advk_pci_bridge_emul_ops;
 
-	return pci_bridge_emul_init(bridge, 0);
+	/* PCIe config space can be initialized after pci_bridge_emul_init() */
+	ret = pci_bridge_emul_init(bridge, 0);
+	if (ret < 0)
+		return ret;
+
+	/* Completion Retry Status is supported and always enabled by PIO */
+	bridge->pcie_conf.rootctl = cpu_to_le16(PCI_EXP_RTCTL_CRSSVE);
+	bridge->pcie_conf.rootcap = cpu_to_le16(PCI_EXP_RTCAP_CRSVIS);
+
+	return 0;
 }
 
 static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
-- 
2.20.1

