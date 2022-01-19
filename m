Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2BD49371F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jan 2022 10:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiASJWJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jan 2022 04:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353023AbiASJWH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jan 2022 04:22:07 -0500
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:1::465:204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C4EC06173E
        for <linux-pci@vger.kernel.org>; Wed, 19 Jan 2022 01:22:07 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4Jf0XF6fhJzQl4k;
        Wed, 19 Jan 2022 10:22:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
From:   Stefan Roese <sr@denx.de>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
Subject: [PATCH v3 2/2] PCI/AER: Enable AER on all PCIe devices supporting it
Date:   Wed, 19 Jan 2022 10:22:00 +0100
Message-Id: <20220119092200.35823-3-sr@denx.de>
In-Reply-To: <20220119092200.35823-1-sr@denx.de>
References: <20220119092200.35823-1-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With this change, AER is now enabled on all PCIe devices, also when the
PCIe device is hot-plugged.

Please note that this change is quite invasive, as with this patch
applied, AER now will be enabled in the Device Control registers of all
available PCIe Endpoints, which currently is not the case.

When "pci=noaer" is selected, AER stays disabled of course.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Pali Rohár <pali@kernel.org>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Yao Hongbo <yaohongbo@linux.alibaba.com>
Cc: Naveen Naidu <naveennaidu479@gmail.com>
---
v3:
- New patch, replacing the "old" 2/2 patch
  Now enabling of AER for each PCIe device is done in pci_aer_init(),
  which also makes sure that AER is enabled in each PCIe device even when
  it's hot-plugged.

 drivers/pci/pcie/aer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9fa1f97e5b27..01a25e4a5168 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -387,6 +387,10 @@ void pci_aer_init(struct pci_dev *dev)
 	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR, sizeof(u32) * n);
 
 	pci_aer_clear_status(dev);
+
+	/* Enable AER if requested */
+	if (pci_aer_available())
+		pci_enable_pcie_error_reporting(dev);
 }
 
 void pci_aer_exit(struct pci_dev *dev)
-- 
2.34.1

