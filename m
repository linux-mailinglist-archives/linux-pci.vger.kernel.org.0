Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7362741954E
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 15:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbhI0NqA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 09:46:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234560AbhI0Np7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Sep 2021 09:45:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 043D960240;
        Mon, 27 Sep 2021 13:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632750262;
        bh=SN7I+ERVyd1zo0MptDUz1h+P5y2dPIG6f3EW36wPgUs=;
        h=From:To:Cc:Subject:Date:From;
        b=sp9BW5sguJIuS0QPYWJie/Qr8MZXEXTJaWijlO4wWUuzhW+G3kLBX22VR5//0bS/g
         71DTJJpEqkajb47YXH+8h/Y7p8XIYMFc6iCgnxwD1rLy7STaWWSWJD/uG1xjNZekVl
         e0d9Yuqnl4cISD9IWikPH4IB3DSAlJ5xn82hnPDgzsz/dazBGvlLtP5wsK+abQRaHL
         al2GjUX33+wnOvA8aA3E5qq/5gvEIChz6bVkoqQCeVaFlWX08fqkD9USYlQi6UmfD+
         L3vcuxaUwodnoKKKC97qybRJoNGIDbpw37BL7wb4qbBTMJTCqI2dgciL68RCF57eBT
         Q5920axH1kr5w==
Received: by pali.im (Postfix)
        id 7357BC83; Mon, 27 Sep 2021 15:44:19 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: xgene: Use PCI_VENDOR_ID_AMCC macro
Date:   Mon, 27 Sep 2021 15:43:56 +0200
Message-Id: <20210927134356.11799-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Header file linux/pci_ids.h defines AMCC vendor id (0x10e8) macro named
PCI_VENDOR_ID_AMCC. So use this macro instead of driver custom macro.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-xgene.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index e64536047b65..56d0d50338c8 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -48,7 +48,6 @@
 #define EN_COHERENCY			0xF0000000
 #define EN_REG				0x00000001
 #define OB_LO_IO			0x00000002
-#define XGENE_PCIE_VENDORID		0x10E8
 #define XGENE_PCIE_DEVICEID		0xE004
 #define SZ_1T				(SZ_1G*1024ULL)
 #define PIPE_PHY_RATE_RD(src)		((0xc000 & (u32)(src)) >> 0xe)
@@ -560,7 +559,7 @@ static int xgene_pcie_setup(struct xgene_pcie_port *port)
 	xgene_pcie_clear_config(port);
 
 	/* setup the vendor and device IDs correctly */
-	val = (XGENE_PCIE_DEVICEID << 16) | XGENE_PCIE_VENDORID;
+	val = (XGENE_PCIE_DEVICEID << 16) | PCI_VENDOR_ID_AMCC;
 	xgene_pcie_writel(port, BRIDGE_CFG_0, val);
 
 	ret = xgene_pcie_map_ranges(port);
-- 
2.20.1

