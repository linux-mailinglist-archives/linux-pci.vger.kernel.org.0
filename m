Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9255845E964
	for <lists+linux-pci@lfdr.de>; Fri, 26 Nov 2021 09:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359526AbhKZIgv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 03:36:51 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44040 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359451AbhKZIev (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 03:34:51 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AQ8VOQm038054;
        Fri, 26 Nov 2021 02:31:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637915484;
        bh=FDa1+Ibk21gyEv8jq7C266SXuVB5FFuGZ5AmU0gqT7k=;
        h=From:To:CC:Subject:Date;
        b=oyiCcaWO4rG5TG4M/kPNIIfoueHlB3thOLvJ64XgtfiCIJuzo4fzCfEyedE3rxwQD
         uLWiOTZpDcbHM0abfYuI2YstKFPzbPN/rXDIrKyA0TmEVqOPR0/4gXzwlJg9utKf8X
         72cLNp5THs/Rbl6qAQEHhu7Ik1fIlX3DWPz05DFk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AQ8VOGr074470
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Nov 2021 02:31:24 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 26
 Nov 2021 02:31:24 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 26 Nov 2021 02:31:24 -0600
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AQ8VKEk127547;
        Fri, 26 Nov 2021 02:31:21 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/5] PCI: Keystone: Misc fixes for TI's AM65x PCIe
Date:   Fri, 26 Nov 2021 14:01:14 +0530
Message-ID: <20211126083119.16570-1-kishon@ti.com>
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

v1 if the patch series is @ [2]

Changes from v1:
1) Added two patches to fix 'dtbs_check'; a DT binding documentation
update and a driver update.
2) Remove falling back to smaller DMA mask as suggested by Christoph.

[1] -> https://lore.kernel.org/r/20210325090026.8843-7-kishon@ti.com
[2] -> https://lore.kernel.org/r/20211110073343.12396-1-kishon@ti.com

Kishon Vijay Abraham I (5):
  dt-bindings: PCI: ti,am65: Fix
    "ti,syscon-pcie-id"/"ti,syscon-pcie-mode" to take argument
  PCI: keystone: Use phandle argument from
    "ti,syscon-pcie-id"/"ti,syscon-pcie-mode"
  PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)
  PCI: keystone: Add quirk to mark AM654 RC BAR flag as IORESOURCE_UNSET
  PCI: keystone: Set DMA mask and coherent DMA mask

 .../bindings/pci/ti,am65-pci-ep.yaml          |  8 +-
 .../bindings/pci/ti,am65-pci-host.yaml        | 16 +++-
 drivers/pci/controller/dwc/pci-keystone.c     | 82 ++++++++++++++++++-
 3 files changed, 96 insertions(+), 10 deletions(-)

-- 
2.17.1

