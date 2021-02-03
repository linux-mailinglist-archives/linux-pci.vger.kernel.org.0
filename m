Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6D030DA5E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 13:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhBCM6r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 07:58:47 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12411 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhBCM4d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2021 07:56:33 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DW1pz1yqnzjHN5;
        Wed,  3 Feb 2021 20:54:35 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Wed, 3 Feb 2021 20:55:28 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <sathyanarayanan.kuppuswamy@linux.intel.com>, <kbusch@kernel.org>,
        <sean.v.kelley@intel.com>, <qiuxu.zhuo@intel.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        <linuxarm@openeuler.org>
Subject: [PATCH] PCI/DPC: Disable ERR_COR explicitly for native dpc service
Date:   Wed, 3 Feb 2021 20:53:15 +0800
Message-ID: <1612356795-32505-2-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612356795-32505-1-git-send-email-yangyicong@hisilicon.com>
References: <1612356795-32505-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Per Downstream Port Containment Related Enhancements ECN[1],
Table 4-6 Interpretation of _OSC Control Field Returned Value,
for bit 7 of _OSC control return value:

  "If firmware allows the OS control of this feature, then,
  in the context of the _OSC method the OS must ensure that
  Downstream Port Containment ERR_COR signaling is disabled
  as described in the PCI Express Base Specification."

and PCI Express Base Specification Revision 4.0 Version 1.0
section 6.2.10.2, Use of DPC ERR_COR Signaling:

  "...DPC ERR_COR signaling is primarily intended for use by
  platform firmware..."

Currently we don't set DPC ERR_COR enable bit, but explicitly
clear the bit to ensure it's disabled.

[1] Downstream Port Containment Related Enhancements ECN,
    Jan 28, 2019, affecting PCI Firmware Specification, Rev. 3.2
    https://members.pcisig.com/wg/PCI-SIG/document/12888

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/pcie/dpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index e05aba8..5cc8ef3 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -302,7 +302,7 @@ static int dpc_probe(struct pcie_device *dev)
 	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
 	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
 
-	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
+	ctl = (ctl & 0xffe4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
 	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
 	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);
 
-- 
2.8.1

