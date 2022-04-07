Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AB14F8053
	for <lists+linux-pci@lfdr.de>; Thu,  7 Apr 2022 15:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbiDGNTj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Apr 2022 09:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241658AbiDGNTi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2022 09:19:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2751CABFD;
        Thu,  7 Apr 2022 06:17:34 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KZ21w02ShzgYFr;
        Thu,  7 Apr 2022 21:15:48 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 21:17:33 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <bhelgaas@google.com>, <rafael@kernel.org>, <lenb@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yangyicong@hisilicon.com>,
        <linuxarm@huawei.com>
Subject: [PATCH] PCI/ACPI: Decouple the negotiation of ASPM and other PCIe services
Date:   Thu, 7 Apr 2022 21:16:02 +0800
Message-ID: <20220407131602.14727-1-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently we regard ASPM as a necessary PCIe service and if it's disabled
by pcie_aspm=off we cannot enable other services like AER and hotplug.
However the ASPM is just one of the PCIe services and other services
mentioned no dependency on this. So this patch decouples the negotiation
of ASPM and other PCIe services, then we can make use of other services
in the absence of ASPM.

Aaron Sierra tried to fix this originally:
https://lore.kernel.org/linux-pci/20190702201318.GC128603@google.com/

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/acpi/pci_root.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 6f9e75d14808..16fa7c5a11ad 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -37,8 +37,6 @@ static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
 }
 
 #define ACPI_PCIE_REQ_SUPPORT (OSC_PCI_EXT_CONFIG_SUPPORT \
-				| OSC_PCI_ASPM_SUPPORT \
-				| OSC_PCI_CLOCK_PM_SUPPORT \
 				| OSC_PCI_MSI_SUPPORT)
 
 static const struct acpi_device_id root_device_ids[] = {
-- 
2.24.0

