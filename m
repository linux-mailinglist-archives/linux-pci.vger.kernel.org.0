Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667FD1AACE5
	for <lists+linux-pci@lfdr.de>; Wed, 15 Apr 2020 18:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410169AbgDOQEI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Apr 2020 12:04:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410164AbgDOQEG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Apr 2020 12:04:06 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C27002173E;
        Wed, 15 Apr 2020 16:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586966645;
        bh=p7e0pThC4DsKXXmaYA9VV5ZorubQAuCZ2UJ40gakewI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N1KgN+4EjmVKgix5IBD5HuBai7EefSQYT5d8GTAOzdnnzEyvj/BCHZTzxDSTv9kme
         sDEmgZ2Arfex/TcUdHtGyOlrXYZNwvznynmNc75d4SfyIa99ZJDJbAxPZkwjN6vnvs
         amxhEUpAsg+jW83CGCh9vFZvREjPgTGyd7mnlK/U=
Received: by pali.im (Postfix)
        id EA64758E; Wed, 15 Apr 2020 18:04:03 +0200 (CEST)
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
Subject: [PATCH 8/8] PCI: aardvark: Add FIXME for code which access PCIE_CORE_CMD_STATUS_REG
Date:   Wed, 15 Apr 2020 18:03:48 +0200
Message-Id: <20200415160348.1146-4-pali@kernel.org>
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

Register PCIE_CORE_CMD_STATUS_REG is applicable only when aardvark
controller is configured for Endpoint mode. Which is not the case of
current kernel driver.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 6a97a3838098..a1cebc734f2d 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -423,6 +423,12 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 		advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
 	} while (1);
 
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
2.20.1

