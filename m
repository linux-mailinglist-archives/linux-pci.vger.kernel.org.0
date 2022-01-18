Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE1A4922B4
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jan 2022 10:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343508AbiARJ0j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jan 2022 04:26:39 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:31100 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245369AbiARJ0i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jan 2022 04:26:38 -0500
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JdNbd0LtLz1FCk7;
        Tue, 18 Jan 2022 17:22:53 +0800 (CST)
Received: from SZX1000464847.huawei.com (10.21.59.169) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Tue, 18 Jan 2022 17:26:36 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH] PCI: Support BAR sizes up to 8TB
Date:   Tue, 18 Jan 2022 17:21:17 +0800
Message-ID: <20220118092117.10089-1-liudongdong3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.21.59.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Current kernel reports disabling BAR if device with a 4TB BAR as it
only supports BAR size to 128GB.

pci 0000:01:00.0: disabling BAR 4:
[mem 0x00000000-0x3ffffffffff 64bit pref] (bad alignment 0x40000000000)

Increase the maximum BAR size from 128GB to 8TB for future expansion.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 drivers/pci/setup-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 547396ec50b5..a7893bf2f580 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -994,7 +994,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 {
 	struct pci_dev *dev;
 	resource_size_t min_align, align, size, size0, size1;
-	resource_size_t aligns[18]; /* Alignments from 1MB to 128GB */
+	resource_size_t aligns[24]; /* Alignments from 1MB to 8TB */
 	int order, max_order;
 	struct resource *b_res = find_bus_resource_of_type(bus,
 					mask | IORESOURCE_PREFETCH, type);
-- 
2.33.0

