Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A7C7E43E4
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 16:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344258AbjKGPso (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 10:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344249AbjKGPsH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 10:48:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C906F10E9;
        Tue,  7 Nov 2023 07:47:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CFBC433CA;
        Tue,  7 Nov 2023 15:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372068;
        bh=bpz0U3LZxSfFLxq8A9lqCNLA2l/RdLM6YJC2tsAEoXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eUKgFJ9skIOV7Q8YqlulEIDSOHYr8tNhi8xDZVFIlIps47FSbPIr3XlNTQohA/LRF
         H6d855CoLDQ1MgPP3NmJAuD566H5U0dsAmjhK4NX9xii2ryIC6WmoIgPB3yg58Zk+B
         HalvNsK3YhSamSmNEv/ImwY8FKT1ftVefkayaB83/KoNG6TqTvsSpRGwBjDaXlRezM
         YuJjYv3fKd1JXOPBhMzZFT/pvvCVFoUU19oin5UBRt6unTsmMiLPoTj+9QNsmWAGPv
         QE/Cjvu6dHSRQBMvLOt8bl0QzPVVzbtDNR6Zh7JonwzG7lC13TfTdlUK33En9nTmFU
         6FpvjCncvMjQg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, thomas.petazzoni@bootlin.com,
        pali@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 21/36] PCI: mvebu: Use FIELD_PREP() with Link Width
Date:   Tue,  7 Nov 2023 10:46:03 -0500
Message-ID: <20231107154654.3765336-21-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107154654.3765336-1-sashal@kernel.org>
References: <20231107154654.3765336-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 408599ec561ad5862cda4f107626009f6fa97a74 ]

mvebu_pcie_setup_hw() setups the Maximum Link Width field in the Link
Capabilities registers using an open-coded variant of FIELD_PREP() with
a literal in shift. Improve readability by using
FIELD_PREP(PCI_EXP_LNKCAP_MLW, ...).

Link: https://lore.kernel.org/r/20230919125648.1920-6-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 60810a1fbfb75..29fe09c99e7d9 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -264,7 +264,7 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	 */
 	lnkcap = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP);
 	lnkcap &= ~PCI_EXP_LNKCAP_MLW;
-	lnkcap |= (port->is_x4 ? 4 : 1) << 4;
+	lnkcap |= FIELD_PREP(PCI_EXP_LNKCAP_MLW, port->is_x4 ? 4 : 1);
 	mvebu_writel(port, lnkcap, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP);
 
 	/* Disable Root Bridge I/O space, memory space and bus mastering. */
-- 
2.42.0

