Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA124488E3A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 02:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbiAJBud (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jan 2022 20:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237985AbiAJBu3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jan 2022 20:50:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A392BC06173F
        for <linux-pci@vger.kernel.org>; Sun,  9 Jan 2022 17:50:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B11BB8111F
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 01:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9517EC36AF4;
        Mon, 10 Jan 2022 01:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641779426;
        bh=WwwztMYPBfFsKPyVwryWqLcipuz5ybC+HCXaS8W85SI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fsQ+YgNoDwEpSD30cHIQrcJtyUvQqlfdNGpV25P8+4XrSZTfdZ/+XydTlQgrktHEk
         3VNZZ8V4MwCKQYwgViJRcbgao6Drn9VMRWf2pbnOc3htZn9EODsLLKcOTSz163T5+M
         ahBro/mG8So5mc7UJKamm3uhfb727oyej8Z3gx+JR7zEEkhkDLO6zvmrjL2toQNcgC
         BfEtg9IErwSrl9JAbfLoV9YVyaYl0mbe2JxWoXtyhju8mDfbin/vDgzHL3r9ga9CIV
         dHy6X7SvIc/V0SjWWI7Ld4Y4J7mCL4krCD+Ck/6Nb6K5jyhgtFd6XWDQyz2xksd9Yb
         teGNq9ftsJGbg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 01/23] PCI: aardvark: Replace custom PCIE_CORE_INT_* macros with PCI_INTERRUPT_*
Date:   Mon, 10 Jan 2022 02:49:56 +0100
Message-Id: <20220110015018.26359-2-kabel@kernel.org>
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

Header file linux/pci.h defines enum pci_interrupt_pin with corresponding
PCI_INTERRUPT_* values.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index ec0df426863d..62baddd2ca95 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -39,10 +39,6 @@
 #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX_EN			BIT(6)
 #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHCK			BIT(7)
 #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHCK_RCV			BIT(8)
-#define     PCIE_CORE_INT_A_ASSERT_ENABLE			1
-#define     PCIE_CORE_INT_B_ASSERT_ENABLE			2
-#define     PCIE_CORE_INT_C_ASSERT_ENABLE			3
-#define     PCIE_CORE_INT_D_ASSERT_ENABLE			4
 /* PIO registers base address and register offsets */
 #define PIO_BASE_ADDR				0x4000
 #define PIO_CTRL				(PIO_BASE_ADDR + 0x0)
@@ -968,7 +964,7 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 	bridge->conf.pref_mem_limit = cpu_to_le16(PCI_PREF_RANGE_TYPE_64);
 
 	/* Support interrupt A for MSI feature */
-	bridge->conf.intpin = PCIE_CORE_INT_A_ASSERT_ENABLE;
+	bridge->conf.intpin = PCI_INTERRUPT_INTA;
 
 	/* Aardvark HW provides PCIe Capability structure in version 2 */
 	bridge->pcie_conf.cap = cpu_to_le16(2);
-- 
2.34.1

