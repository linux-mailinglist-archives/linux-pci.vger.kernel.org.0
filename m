Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FDC44BC23
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 08:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhKJHgm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 02:36:42 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54860 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhKJHgl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Nov 2021 02:36:41 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AA7XmvN087423;
        Wed, 10 Nov 2021 01:33:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1636529628;
        bh=p7q5H6QSE5r6OR28KUphghlhD38VcA2L1tg1LZW+X1Y=;
        h=From:To:CC:Subject:Date;
        b=CyaSwzoiSejYHu6jVxPyM4QK+djLHK+C7XsXhSu2KBetHyBwR1R+oEMcx/pwjxi38
         jgTS3d9UYauo5dE2pk5qMFIBlZUU/3Gy2docDtUoNnghjvMeMONgQjahDr+/yExkvZ
         7s9ATY11U/nPMaN7QVbmHBaylPiTrhOQFHpV5h4A=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AA7XmWr065115
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Nov 2021 01:33:48 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 10
 Nov 2021 01:33:47 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 10 Nov 2021 01:33:47 -0600
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AA7XiT1020054;
        Wed, 10 Nov 2021 01:33:44 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 0/3] PCI: Keystone: Misc fixes for TI's AM65x PCIe
Date:   Wed, 10 Nov 2021 13:03:40 +0530
Message-ID: <20211110073343.12396-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Patch series includes miscellaneous fixes for TI's AM65x SoC
"PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)"  has
already been sent before [1]

The other patch is to prevent PCIEPORTBUS driver to write to
MSI-X table (which is not mapped) leading to ~10sec delay
due to msix_mask_all().

[1] -> https://lore.kernel.org/r/20210325090026.8843-7-kishon@ti.com

Kishon Vijay Abraham I (3):
  PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)
  PCI: keystone: Add quirk to mark AM654 RC BAR flag as IORESOURCE_UNSET
  PCI: keystone: Set DMA mask and coherent DMA mask

 drivers/pci/controller/dwc/pci-keystone.c | 56 ++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

-- 
2.17.1

