Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5A11AACC0
	for <lists+linux-pci@lfdr.de>; Wed, 15 Apr 2020 18:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415151AbgDOQBd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Apr 2020 12:01:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415145AbgDOQB2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Apr 2020 12:01:28 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 418C620936;
        Wed, 15 Apr 2020 16:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586966488;
        bh=46RjzSt2lZ7zcuoUcDDNbTHTfazol2LogceQfxy51Hs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xzJPJVkZxfwtu/a2eSdGtHTO119qdoyaejCCTJcaANPSKNcsyNk//UNMozna2NgCU
         f1vJxc7greQtfZUSTTd3tI+nORw6CeEItOAdA9t2MuBe3/roNbapKvpqqkpG7tZ4OF
         1MQNU3Q83fYjfrQ283eHQokIIdm4FTZZ2rpOLc+k=
Received: by pali.im (Postfix)
        id 673C058E; Wed, 15 Apr 2020 18:01:26 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 4/8] PCI: aardvark: Do not overwrite Link Status register and ASPM Control bits in Link Control register
Date:   Wed, 15 Apr 2020 18:00:50 +0200
Message-Id: <20200415160054.951-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415160054.951-1-pali@kernel.org>
References: <20200415160054.951-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Trying to overwrite or change Link Status register does not have any
effect as this is read-only register. Trying to overwrite bits for
Negotiated Link Width value in Link Status register does not make sense.
So remove code which is doing it.

In future proper change of link width can be done via Lane Count Select
bits in PCIe Control 0 register.

Trying to unconditionally enable ASPM L0s via ASPM Control bits in Link
Control register is wrong. There should be at least some detection if
endpoint supports L0s as support for it is not mandatory.

Moreover ASPM Control bits in Link Control register are controlled by
pcie/aspm.c code which sets it according to system ASPM settings,
immediately after aardvark driver probe callback finish. So setting these
bits by aardvark driver has no long running effect.

So remove code which touches ASPM L0s bits from aardvark driver and let
kernel's ASPM implementation to set ASPM state properly.

Some users are reporting issues that this code which unconditionally set
ASPM L0s bits in Link Control register is problematic for some Intel wifi
cards. And disabling that code fixes support for those cards. See e.g.:
https://bugzilla.kernel.org/show_bug.cgi?id=196339

If problem with Intel wifi cards occur also after this commit then driver
independent pcie/aspm.c code could be modified / hooked to not enable ASPM
L0s state for affected problematic cards.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 756b31c4d20b..02c69fc9aadf 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -380,10 +380,6 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 
 	advk_pcie_wait_for_link(pcie);
 
-	reg = PCIE_CORE_LINK_L0S_ENTRY |
-		(1 << PCIE_CORE_LINK_WIDTH_SHIFT);
-	advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
-
 	reg = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
 	reg |= PCIE_CORE_CMD_MEM_ACCESS_EN |
 		PCIE_CORE_CMD_IO_ACCESS_EN |
-- 
2.20.1

