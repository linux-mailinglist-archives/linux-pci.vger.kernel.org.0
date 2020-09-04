Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4637425D68C
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 12:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbgIDKkV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Sep 2020 06:40:21 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:58099 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728658AbgIDKkK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Sep 2020 06:40:10 -0400
X-IronPort-AV: E=Sophos;i="5.76,389,1592838000"; 
   d="scan'208";a="56385879"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Sep 2020 19:40:09 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id DAB77400C751;
        Fri,  4 Sep 2020 19:40:05 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH 3/3] misc: pci_endpoint_test: Add Device ID for RZ/G2H PCIe controller
Date:   Fri,  4 Sep 2020 11:38:51 +0100
Message-Id: <20200904103851.3946-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904103851.3946-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200904103851.3946-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Renesas R8A774E1 in pci_device_id table so that pci-epf-test
can be used for testing PCIe EP on RZ/G2H.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/misc/pci_endpoint_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index ba654f42dc10..ed7425bb073d 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -77,6 +77,7 @@
 #define PCI_DEVICE_ID_RENESAS_R8A774A1		0x0028
 #define PCI_DEVICE_ID_RENESAS_R8A774B1		0x002b
 #define PCI_DEVICE_ID_RENESAS_R8A774C0		0x002d
+#define PCI_DEVICE_ID_RENESAS_R8A774E1		0x0025
 
 static DEFINE_IDA(pci_endpoint_test_ida);
 
@@ -955,6 +956,7 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774A1),},
 	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774B1),},
 	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774C0),},
+	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774E1),},
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
 	  .driver_data = (kernel_ulong_t)&j721e_data,
 	},
-- 
2.17.1

