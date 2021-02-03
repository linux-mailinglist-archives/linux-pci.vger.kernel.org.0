Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085F730DA5D
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 13:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhBCM62 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 07:58:28 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12016 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbhBCM4R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2021 07:56:17 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DW1pb234rzjJK7;
        Wed,  3 Feb 2021 20:54:15 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Wed, 3 Feb 2021 20:55:27 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <sathyanarayanan.kuppuswamy@linux.intel.com>, <kbusch@kernel.org>,
        <sean.v.kelley@intel.com>, <qiuxu.zhuo@intel.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        <linuxarm@openeuler.org>
Subject: [PATCH v2] PCI/DPC: Check host->native_dpc before enable dpc service
Date:   Wed, 3 Feb 2021 20:53:14 +0800
Message-ID: <1612356795-32505-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Per Downstream Port Containment Related Enhancements ECN[1]
Table 4-6, Interpretation of _OSC Control Field Returned Value,
for bit 7 of _OSC control return value:

  "Firmware sets this bit to 1 to grant the OS control over PCI Express
  Downstream Port Containment configuration."
  "If control of this feature was requested and denied,
  or was not requested, the firmware returns this bit set to 0."

We store bit 7 of _OSC control return value in host->native_dpc,
check it before enable the dpc service as the firmware may not
grant the control.

[1] Downstream Port Containment Related Enhancements ECN,
    Jan 28, 2019, affecting PCI Firmware Specification, Rev. 3.2
    https://members.pcisig.com/wg/PCI-SIG/document/12888

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
Change since v1:
- use correct reference for _OSC control return value

 drivers/pci/pcie/portdrv_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index e1fed664..7445d03 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -253,7 +253,8 @@ static int get_port_device_capability(struct pci_dev *dev)
 	 */
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
 	    pci_aer_available() &&
-	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
+	    (pcie_ports_dpc_native ||
+	    ((services & PCIE_PORT_SERVICE_AER) && host->native_dpc)))
 		services |= PCIE_PORT_SERVICE_DPC;
 
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
-- 
2.8.1

