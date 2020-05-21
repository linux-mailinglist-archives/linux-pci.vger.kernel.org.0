Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5E41DD47E
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 19:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgEURcv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 13:32:51 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2241 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728542AbgEURcv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 13:32:51 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id B94FB3A13135244B263E;
        Thu, 21 May 2020 18:32:46 +0100 (IST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 21 May 2020 18:32:46 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/2] PCI/AER: Do not reset the device status if doing firmware first handling.
Date:   Fri, 22 May 2020 01:31:33 +0800
Message-ID: <20200521173134.2456773-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200521173134.2456773-1-Jonathan.Cameron@huawei.com>
References: <20200521173134.2456773-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_aer_clear_device_status() currently resets the device status even when
firmware first handling is going on.  In particular it resets it on the
root port.

This has been discussed previously
https://lore.kernel.org/patchwork/patch/427375/.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/aer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f4274d301235..43e78b97ace6 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -373,6 +373,9 @@ void pci_aer_clear_device_status(struct pci_dev *dev)
 {
 	u16 sta;
 
+	if (pcie_aer_get_firmware_first(dev))
+		return;
+
 	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
 }
-- 
2.19.1

