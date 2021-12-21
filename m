Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C9647C1FD
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 15:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbhLUO4y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 09:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238702AbhLUO4v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 09:56:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D534EC061574;
        Tue, 21 Dec 2021 06:56:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BF9C61655;
        Tue, 21 Dec 2021 14:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D1EC36AEF;
        Tue, 21 Dec 2021 14:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640098610;
        bh=XitsvLC/8XJT/51VWhTuEEqkPH1X2y3/JU2pM5KluWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KBE0gq6r3q7Oi/WAoEZr4Exsun8OSvQOwhBAN857k6nbdRJtP4xpJ66+RDIy2R7F9
         xeYCVrhtcgPSe1QcW8zGPr3ew48V+hV16V4vVs6LBhXItDTxWMpdRkMqq0To44uIxU
         a0+CuifReh9juMvMcqlpsP1JwDkeo2kQA/ee0n/u2v0ylAxpwq2TjjHQXA9ke6aphy
         8NBXa59vFBJ0gF1gHqHla/mSV15m71yUVbOHemj7mCMnaTPOso70bLUmG7yhaj0j6x
         vtjzmbE2sAgzPDi29Idaxdn7zl9Kf3sWayzlqxWVBjHKVwliiYCl6oNKQ1VQkSSPhC
         YAN9yru8u4OQw==
Received: by pali.im (Postfix)
        id 4574228D5; Tue, 21 Dec 2021 15:18:14 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] PCI: mvebu: Add help string for CONFIG_PCI_MVEBU option
Date:   Tue, 21 Dec 2021 15:14:49 +0100
Message-Id: <20211221141455.30011-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211221141455.30011-1-pali@kernel.org>
References: <20211221141455.30011-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is no description for CONFIG_PCI_MVEBU option. Add it.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 67189bcd5d89..534b446f2cf0 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -10,6 +10,10 @@ config PCI_MVEBU
 	depends on ARM
 	depends on OF
 	select PCI_BRIDGE_EMUL
+	help
+	 Add support for Marvell EBU PCIe controller. This PCIe controller
+	 is used on 32-bit Marvell ARM SoCs: Dove, Kirkwood, Armada 370,
+	 Armada XP, Armada 375, Armada 38x and Armada 39x.
 
 config PCI_AARDVARK
 	tristate "Aardvark PCIe controller"
-- 
2.20.1

