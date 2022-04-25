Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFC950D9E8
	for <lists+linux-pci@lfdr.de>; Mon, 25 Apr 2022 09:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbiDYHLu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Apr 2022 03:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiDYHLt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Apr 2022 03:11:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6211C13D0A;
        Mon, 25 Apr 2022 00:08:45 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kmwyk0JrjzGpLq;
        Mon, 25 Apr 2022 15:05:50 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 15:08:24 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <bhelgaas@google.com>, <rafael@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     <lenb@kernel.org>, <linux-kernel@vger.kernel.org>,
        <yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: [PATCH] PCI/ACPI: Always advertise ASPM support if CONFIG_PCIEASPM=y
Date:   Mon, 25 Apr 2022 15:06:34 +0800
Message-ID: <20220425070634.28227-1-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When we have CONFIG_PCIEASPM enabled it means OS can always support ASPM no
matter user have disabled it through pcie_aspm=off or not. But currently we
won't advertise ASPM support in _OSC negotiation if user disables it, which
doesn't match the fact. This will also have side effects that other PCIe
services like AER and hotplug will be disabled as ASPM support is required
and we won't negotiate other services if ASPM support is absent.

So this patch makes OS always advertising ASPM support if CONFIG_PCIEASPM=y.
It intends no functional change to pcie_aspm=off as it will still mark
aspm_disabled=1 and aspm_support_enabled=false, driver will check these
status before configuring ASPM.

Tested this patch with pcie_aspm=off:
estuary:/$ dmesg | egrep -i "aspm|osc"
[    0.000000] PCIe ASPM is disabled
[    8.706961] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI EDR HPX-Type3]
[    8.726032] acpi PNP0A08:00: _OSC: platform does not support [LTR]
[    8.742818] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME
AER PCIeCapability DPC]
estuary:/sys/module/pcie_aspm/parameters$ cat policy
[default] performance powersave powersupersave
estuary:/sys/module/pcie_aspm/parameters$ echo powersave > policy
bash: echo: write error: Operation not permitted

Cc: Rafael J. Wysocki <rafael@kernel.org>
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
[https://lore.kernel.org/linux-pci/20220407154257.GA235990@bhelgaas/]
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/acpi/pci_root.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 6f9e75d14808..17e78582e633 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -393,7 +393,7 @@ static u32 calculate_support(void)
 	support |= OSC_PCI_HPX_TYPE_3_SUPPORT;
 	if (pci_ext_cfg_avail())
 		support |= OSC_PCI_EXT_CONFIG_SUPPORT;
-	if (pcie_aspm_support_enabled())
+	if (IS_ENABLED(CONFIG_PCIEASPM))
 		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
 	if (pci_msi_enabled())
 		support |= OSC_PCI_MSI_SUPPORT;
-- 
2.24.0

