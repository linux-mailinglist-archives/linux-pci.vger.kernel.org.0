Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E390A45DA67
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 13:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350028AbhKYMxU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Nov 2021 07:53:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:45578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353365AbhKYMvo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Nov 2021 07:51:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CA366112D;
        Thu, 25 Nov 2021 12:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637844397;
        bh=M7RVNYqJpq9GBdt/IbkDk02dbz1vB+spQULec4Ir+Cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ixvmxJhjksDOJD4scZVavPK6vsC14fkStyOjsYuJyH6kp7Kk13lwTuv+JlEAY6KKy
         hD99qv3k1nuFILREDjCQTp0fOCXertNrKjjHTFFFya53mniotvv7Pzhhf2iFGZJYbQ
         Fch4YnLZbxjcBlnF9/XhR/BDBLRJ5IHi5uSPaQt4qkxebJG8Izb5v42VnzxXDhq4a/
         u5AyJ8GOVCjzWzwkSr2i2EaJlbxuvyQ4KJZrntNqd6TeLeVDLJpIzJQg3IKe6sS+FO
         1RnQI96aAfz4anv6RGm6dblkqVqkeZJuOdM/ZNx0/tYQtBshPZWcw7Mgfb6qDSKs8h
         Uy5lcmVH3PnkA==
Received: by pali.im (Postfix)
        id 5D6DAEDE; Thu, 25 Nov 2021 13:46:37 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] PCI: mvebu: Do not modify PCI IO type bits in conf_write
Date:   Thu, 25 Nov 2021 13:45:57 +0100
Message-Id: <20211125124605.25915-8-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211125124605.25915-1-pali@kernel.org>
References: <20211125124605.25915-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI IO type bits are already initialized in mvebu_pci_bridge_emul_init()
function and only when IO support is enabled. These type bits are read-only
and pci-bridge-emul.c code already does not allow to modify them from upper
layers.

When IO support is disabled then all IO registers should be read-only and
return zeros. Therefore do not modify PCI IO type bits in
mvebu_pci_bridge_emul_base_conf_write() callback.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 1f08673eef12 ("PCI: mvebu: Convert to PCI emulated bridge config space")
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-mvebu.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 32694763e930..a0b661972436 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -522,13 +522,6 @@ mvebu_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
 		break;
 
 	case PCI_IO_BASE:
-		/*
-		 * We keep bit 1 set, it is a read-only bit that
-		 * indicates we support 32 bits addressing for the
-		 * I/O
-		 */
-		conf->iobase |= PCI_IO_RANGE_TYPE_32;
-		conf->iolimit |= PCI_IO_RANGE_TYPE_32;
 		mvebu_pcie_handle_iobase_change(port);
 		break;
 
-- 
2.20.1

