Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D390410F8D
	for <lists+linux-pci@lfdr.de>; Mon, 20 Sep 2021 08:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbhITGnM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Sep 2021 02:43:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54880 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhITGnM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Sep 2021 02:43:12 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18K6fcEu114069;
        Mon, 20 Sep 2021 01:41:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632120098;
        bh=K/md9ehoI6GpqbhRhep9nyYNlKKepF9K1Mfs6pPKo64=;
        h=From:To:CC:Subject:Date;
        b=iofsHmrnzKG15DPwbhft2WR4wnEk/EVBrGhVmhg37I1MKr80b/jq7U7MzXXe+y4vf
         /8OVKyNPovAIrzLpGYU0J8lctKXCX6nXYbG18Y3kIZaRBLtj8+f0JB82o7OEKDIjoF
         8evdqTL3ec6XhYHIjF3DktyVXVvy5AqcJHJi8Plg=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18K6fcYh064756
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Sep 2021 01:41:38 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Sep 2021 01:41:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Sep 2021 01:41:38 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18K6fYa5015912;
        Mon, 20 Sep 2021 01:41:35 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH 0/3] PCI/gic-v3-its: Add support for same ITS device ID for multiple PCIe devices
Date:   Mon, 20 Sep 2021 12:11:30 +0530
Message-ID: <20210920064133.14115-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

AM64 has an issue in that it doesn't trigger interrupt if the address
in the *pre_its_window* is not aligned to 8-bytes (this is due to an
invalid bridge configuration in HW).

This means there will not be interrupts for devices with PCIe
requestor ID 0x1, 0x3, 0x5..., as the address in the pre-ITS window
would be 4 (1 << 2), 12 (3 << 2), 20 (5 << 2) respectively which are
not aligned to 8-bytes.

The DT binding has specified "msi-map-mask" using which multiple PCIe
devices could be made to use the same ITS device ID.

Add support in irq-gic-v3-its-pci-msi.c for such cases where multiple
PCIe devices are using the same ITS device ID.

Kishon Vijay Abraham I (3):
  PCI: Add support in pci_walk_bus() to invoke callback matching RID
  PCI: Export find_pci_root_bus()
  irqchip/gic-v3-its: Include "msi-map-mask" for calculating nvecs

 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 21 ++++++++++++++++++++-
 drivers/pci/bus.c                        | 13 +++++++++----
 drivers/pci/host-bridge.c                |  3 ++-
 include/linux/pci.h                      |  8 ++++++--
 4 files changed, 37 insertions(+), 8 deletions(-)

-- 
2.17.1

