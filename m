Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B18B512D02D
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2019 14:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfL3NPB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Dec 2019 08:15:01 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8649 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727397AbfL3NPB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Dec 2019 08:15:01 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EE8631FFC469F65389ED;
        Mon, 30 Dec 2019 21:14:57 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Mon, 30 Dec 2019 21:14:47 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <bhelgaas@google.com>, <corbet@lwn.net>
CC:     <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.or>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrew Murray <andrew.murray@arm.com>
Subject: [PATCH v2] Documentation: PCI: msi-howto.rst: Fix wrong function name
Date:   Mon, 30 Dec 2019 21:14:28 +0800
Message-ID: <20191230131428.1200-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_irq_alloc_vectors() -> pci_alloc_irq_vectors().

Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---

v1 -> v2:
	Add Andrew's R-b tag.

 Documentation/PCI/msi-howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/PCI/msi-howto.rst b/Documentation/PCI/msi-howto.rst
index 994cbb660ade..aa2046af69f7 100644
--- a/Documentation/PCI/msi-howto.rst
+++ b/Documentation/PCI/msi-howto.rst
@@ -283,5 +283,5 @@ or disabled (0).  If 0 is found in any of the msi_bus files belonging
 to bridges between the PCI root and the device, MSIs are disabled.
 
 It is also worth checking the device driver to see whether it supports MSIs.
-For example, it may contain calls to pci_irq_alloc_vectors() with the
+For example, it may contain calls to pci_alloc_irq_vectors() with the
 PCI_IRQ_MSI or PCI_IRQ_MSIX flags.
-- 
2.19.1


