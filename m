Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C699B4844CB
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 16:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbiADPia (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 10:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbiADPi2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jan 2022 10:38:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E36C061761;
        Tue,  4 Jan 2022 07:38:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 809DA614D1;
        Tue,  4 Jan 2022 15:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33146C36AE9;
        Tue,  4 Jan 2022 15:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641310707;
        bh=EL6nV59bNUjoxrhXUx09Q1zdCGJZe3e7ihi5Ki9qF/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pNmQBIaqor3ghqwL/89v2mUPuXjkbtIT2OjRUx1YQ7wGTkrq4O8P4INsSe8eidYXs
         grSvQVWe3T4mUGWJqQ7q7KobrjFiXotm3orcOi7wFFOcjyTwzSKuuQ9pyc9cS2fVdp
         O6O75AKdMRFuxYumlbEPLZGiQMvXMkV6ctXYl66TYQWHVX6gxb3/2Rk/fMveonVuty
         /oAaWzktIc5vYFJ5uexWWG87muNCnc8BcamRmDwgIZoVNKNWOK7mgxTNJa1Bufaykh
         m8/JwbcZBDlJlLZTUb0oq+X5wh3kKh1t31/aU/WNStaF7qTi1NH+BPuDELQYCnDodX
         JS3jlHI/8bzqg==
Received: by pali.im (Postfix)
        id DDB5996B; Tue,  4 Jan 2022 16:38:26 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/11] PCI: mvebu: Add help string for CONFIG_PCI_MVEBU option
Date:   Tue,  4 Jan 2022 16:35:23 +0100
Message-Id: <20220104153529.31647-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220104153529.31647-1-pali@kernel.org>
References: <20211221141455.30011-1-pali@kernel.org>
 <20220104153529.31647-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is no description for CONFIG_PCI_MVEBU option. Add it.

Signed-off-by: Pali Rohár <pali@kernel.org>
Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
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

