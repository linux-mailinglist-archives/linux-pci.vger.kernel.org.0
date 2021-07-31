Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A113DC605
	for <lists+linux-pci@lfdr.de>; Sat, 31 Jul 2021 14:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhGaM6G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 31 Jul 2021 08:58:06 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:50615 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhGaM6F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 31 Jul 2021 08:58:05 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id F329D100D9410;
        Sat, 31 Jul 2021 14:57:57 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C31F624ADDB; Sat, 31 Jul 2021 14:57:57 +0200 (CEST)
Message-Id: <7fd76b0591c37287ab94d911d8fd9ab9a2afcd16.1627638184.git.lukas@wunner.de>
In-Reply-To: <cover.1627638184.git.lukas@wunner.de>
References: <cover.1627638184.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 31 Jul 2021 14:39:03 +0200
Subject: [PATCH 3/4] PCI/portdrv: Remove unused pcie_port_bus_{,un}register()
 declarations
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        "Oliver OHalloran" <oohall@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit c6c889d932bb ("PCI/portdrv: Remove pcie_port_bus_type link order
dependency") removed pcie_port_bus_{,un}register() but erroneously
retained their declarations in portdrv.h.  Remove them as well.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pcie/portdrv.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index e9fe0fef6cde..0ef4bf5f811d 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -118,8 +118,6 @@ int pcie_port_device_runtime_suspend(struct device *dev);
 int pcie_port_device_runtime_resume(struct device *dev);
 #endif
 void pcie_port_device_remove(struct pci_dev *dev);
-int __must_check pcie_port_bus_register(void);
-void pcie_port_bus_unregister(void);
 
 struct pci_dev;
 
-- 
2.31.1

