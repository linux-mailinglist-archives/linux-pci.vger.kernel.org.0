Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8F11B24CB
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 13:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgDULRI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Apr 2020 07:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbgDULRH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Apr 2020 07:17:07 -0400
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE36C061A0F
        for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2020 04:17:06 -0700 (PDT)
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 2819A141340;
        Tue, 21 Apr 2020 13:17:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587467823; bh=r9bdGAG5M5N9+p3nHxmgXMqIUDtLD9nRMzilW07Er/o=;
        h=From:To:Date;
        b=UVGpn8Ienr6XFyro6MVBpwQtp9IZF/Ygh/XFuhqzkhQHfS2cWwmaJ5r9R+kN0cx5X
         ck5KO4bK2CYMbpw0v/T7HWDDh9jPD3jCQsRECC8EkBcRUcn2dkIVrPyo3/MuZAYuaG
         sJkAmJVNEBAurKJ2BBoWAzDCQf4DHeEMtrkgM3/U=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     linux-pci@vger.kernel.org
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH v2 5/9] PCI: aardvark: add FIXME comment for PCIE_CORE_CMD_STATUS_REG access
Date:   Tue, 21 Apr 2020 13:16:57 +0200
Message-Id: <20200421111701.17088-6-marek.behun@nic.cz>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200421111701.17088-1-marek.behun@nic.cz>
References: <20200421111701.17088-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Spam-Status: No, score=0.00
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Register PCIE_CORE_CMD_STATUS_REG is applicable only when the controller
is configured for Endpoint mode, which is not the case for the current
version of this driver.

Add a FIXME comment, since this needs to be explained, removed or fixed.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index e2d18094d8ca..e893d7d8859f 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -429,6 +429,12 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 
 	advk_pcie_train_link(pcie);
 
+	/*
+	 * FIXME: Following code which access PCIE_CORE_CMD_STATUS_REG register
+	 *        is suspicious. This register is applicable only when the PCI
+	 *        controller is configured for Endpoint mode. And not when it
+	 *        is configured for Root Complex.
+	 */
 	reg = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
 	reg |= PCIE_CORE_CMD_MEM_ACCESS_EN |
 		PCIE_CORE_CMD_IO_ACCESS_EN |
-- 
2.24.1

