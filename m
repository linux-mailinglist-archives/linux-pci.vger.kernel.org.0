Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89B41FE54E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jun 2020 04:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgFRCZO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 22:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbgFRBRa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jun 2020 21:17:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2BEF21D82;
        Thu, 18 Jun 2020 01:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443049;
        bh=PQr83LUcwriW/k0i0ijFpVbSvPAoZsnTtGv9nIb/nts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kIZTLY93c1iKAlBDBHn6/5nAK8k2LxjN481ryVncENtFFoVB7I2XXVc53q7cJkc6Y
         0yFFQMgPvP/E1uDinYZ31ga2V/0+tesrLhb++jRgHEBpNAtN5D5tvglPQqdMq+OV+x
         xgtz4xBS+8iiGQgXniVokFEvrSKQng3JbPh3a5YY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 043/266] PCI: aardvark: Don't blindly enable ASPM L0s and don't write to read-only register
Date:   Wed, 17 Jun 2020 21:12:48 -0400
Message-Id: <20200618011631.604574-43-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

[ Upstream commit 90c6cb4a355e7befcb557d217d1d8b8bd5875a05 ]

Trying to change Link Status register does not have any effect as this
is a read-only register. Trying to overwrite bits for Negotiated Link
Width does not make sense.

In future proper change of link width can be done via Lane Count Select
bits in PCIe Control 0 register.

Trying to unconditionally enable ASPM L0s via ASPM Control bits in Link
Control register is wrong. There should be at least some detection if
endpoint supports L0s as isn't mandatory.

Moreover ASPM Control bits in Link Control register are controlled by
pcie/aspm.c code which sets it according to system ASPM settings,
immediately after aardvark driver probes. So setting these bits by
aardvark driver has no long running effect.

Remove code which touches ASPM L0s bits from this driver and let
kernel's ASPM implementation to set ASPM state properly.

Some users are reporting issues that this code is problematic for some
Intel wifi cards and removing it fixes them, see e.g.:
https://bugzilla.kernel.org/show_bug.cgi?id=196339

If problems with Intel wifi cards occur even after this commit, then
pcie/aspm.c code could be modified / hooked to not enable ASPM L0s state
for affected problematic cards.

Link: https://lore.kernel.org/r/20200430080625.26070-3-pali@kernel.org
Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 97245e076548..f2481e80e272 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -344,10 +344,6 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 
 	advk_pcie_wait_for_link(pcie);
 
-	reg = PCIE_CORE_LINK_L0S_ENTRY |
-		(1 << PCIE_CORE_LINK_WIDTH_SHIFT);
-	advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
-
 	reg = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
 	reg |= PCIE_CORE_CMD_MEM_ACCESS_EN |
 		PCIE_CORE_CMD_IO_ACCESS_EN |
-- 
2.25.1

