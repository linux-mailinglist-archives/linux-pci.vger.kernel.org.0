Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F8848D60D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 11:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiAMKtq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jan 2022 05:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbiAMKto (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jan 2022 05:49:44 -0500
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:1::465:204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F57BC061751
        for <linux-pci@vger.kernel.org>; Thu, 13 Jan 2022 02:49:44 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4JZLm66KR0zQk4J
        for <linux-pci@vger.kernel.org>; Thu, 13 Jan 2022 11:49:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
From:   Stefan Roese <sr@denx.de>
To:     linux-pci@vger.kernel.org
Subject: [PATCH v3 0/2] Add support to register platform service IRQ
Date:   Thu, 13 Jan 2022 11:49:37 +0100
Message-Id: <20220113104939.1635398-1-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some platforms have dedicated IRQ lines for platform-specific System Errors
like AER/PME etc. The root complex on these platform will use these seperate
IRQ lines to report AER/PME etc., interrupts and will not generate
MSI/MSI-X/INTx interrupts for these services.

These patches will add new method for these kind of platforms to register the
platform IRQ number with respective PCIe services.

Changes in v3 (Stefan):
- Restructure patches from 4 patches in v2 to now 2 patches in v3
- Rename of functions names
- init_platform_service_irqs() now uses "struct pci_dev *" instead of
  "struct pci_host_bridge *"
- pcie_init_platform_service_irqs() is called before pcie_init_service_irqs()
- Use more PCIe spec terminology as suggested by Bjorn (hopefully enough, I
  don't have the spec at hand)

Bharat Kumar Gogada (2):
  PCI/portdrv: Add option to setup IRQs for platform-specific Service
    Errors
  PCI: xilinx-nwl: Add method to init_platform_service_irqs hook

 drivers/pci/controller/pcie-xilinx-nwl.c | 14 ++++++++
 drivers/pci/pcie/portdrv_core.c          | 43 +++++++++++++++++++++++-
 include/linux/pci.h                      |  2 ++
 3 files changed, 58 insertions(+), 1 deletion(-)

-- 
2.34.1

