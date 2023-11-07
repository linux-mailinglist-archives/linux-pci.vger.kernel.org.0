Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E08B7E44CF
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 16:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343910AbjKGP56 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 10:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbjKGP5f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 10:57:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029845BBF;
        Tue,  7 Nov 2023 07:51:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F2BC433C7;
        Tue,  7 Nov 2023 15:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372269;
        bh=xnwLLrOtV0XNMAWL9nFKXKRIvwqgnK5CKXFhpg70WoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hQQdJWwJA7IJnxBK/uJoTkiCfwSCvHxaS+LAXOtCu+4IzxAMvcKn9yN1mmKUfsBOy
         gUtPmpYyrlIqw+hMsvlvUvMLv0YV2g4/kLqAnA2KIIzyjwSD+Ai6ZawmaCIt/0pSIC
         1ipgqSBTxmhrsSeIdBlelyOMzQKMU2oTeDIFM/4mKhpbd7U+AuyFvjD9NwjbDP6iVx
         I4LPto8tWqKxGmdwms81zSvVK46BtXWmYV/mMYxEWyfXEi7Q4WeiL59B5lnlETjj48
         eNRl0M3rIS6Pz6SDGwJBEW5Wdix/3Og93kN9EeR2kvULrI5UufqxZjSkYRYTkt5Xhe
         uka45h3ntejVw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, thomas.petazzoni@bootlin.com,
        pali@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 17/30] PCI: mvebu: Use FIELD_PREP() with Link Width
Date:   Tue,  7 Nov 2023 10:49:51 -0500
Message-ID: <20231107155024.3766950-17-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155024.3766950-1-sashal@kernel.org>
References: <20231107155024.3766950-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
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
index 1ced73726a267..668601fd0b296 100644
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

