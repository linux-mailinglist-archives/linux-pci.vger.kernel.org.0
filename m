Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D101A8F9D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Apr 2020 02:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392328AbgDOANh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 20:13:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392315AbgDOANX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Apr 2020 20:13:23 -0400
Received: from localhost (mobile-166-175-184-103.mycingular.net [166.175.184.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97B9720774;
        Wed, 15 Apr 2020 00:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586909597;
        bh=DDPko3qzftraw9JGNnT2damoPH954XYBiL7tnFM7Aug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mNjblSYHzwMejKzDZbezJEHTEOJkIpAk5fxnaWdnPwTuXPiXd8kc9yqDvzdlhXgD/
         WVsT2zCRlGHzS9cUBWmbEgc4XN3yscP/1EkpUBD/PMN0gVn2H7yzKlHQt+Gxf9VAi8
         AsFF4OZFCSPHUUBuy+5byaSJ+L6HPjaZfJhGZWXM=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] PCI: keystone: Don't select CONFIG_PCI_KEYSTONE_HOST by default
Date:   Tue, 14 Apr 2020 19:12:42 -0500
Message-Id: <20200415001244.144623-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200415001244.144623-1-helgaas@kernel.org>
References: <20200415001244.144623-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Drivers should not be selected by default because that bloats the kernel
for people who don't need them.

Remove the "default y" for CONFIG_PCI_KEYSTONE_HOST.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/pci/controller/dwc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index ea335ee7ca8e..695f754b2110 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -110,7 +110,6 @@ config PCI_KEYSTONE_HOST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	select PCI_KEYSTONE
-	default y
 	help
 	  Enables support for the PCIe controller in the Keystone SoC to
 	  work in host mode. The PCI controller on Keystone is based on
-- 
2.26.0.110.g2183baf09c-goog

