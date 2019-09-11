Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9811BAFD00
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2019 14:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfIKMnS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Sep 2019 08:43:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2265 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726928AbfIKMnR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Sep 2019 08:43:17 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 33702FBA1A97D1E50F64;
        Wed, 11 Sep 2019 20:43:16 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 11 Sep 2019 20:43:10 +0800
From:   tiantao6 <tiantao6@huawei.com>
To:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] PCI: vc: fix warning: no previous prototype
Date:   Wed, 11 Sep 2019 20:40:51 +0800
Message-ID: <1568205651-60209-1-git-send-email-tiantao6@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: tiantao <tiantao6@huawei.com>

drivers/pci/vc.c:351:5: warning: no previous prototype for
pci_save_vc_state [-Wmissing-prototypes]
int pci_save_vc_state(struct pci_dev *dev)

drivers/pci/vc.c:388:6: warning: no previous prototype for
pci_restore_vc_state [-Wmissing-prototypes]
void pci_restore_vc_state(struct pci_dev *dev)

drivers/pci/vc.c:412:6: warning: no previous prototype for
pci_allocate_vc_save_buffers [-Wmissing-prototypes]
void pci_allocate_vc_save_buffers(struct pci_dev *dev)

Signed-off-by: Tian Tao <tiantao6@huawei.com>
---
 drivers/pci/vc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
index b39e854..111f6d3 100644
--- a/drivers/pci/vc.c
+++ b/drivers/pci/vc.c
@@ -12,6 +12,7 @@
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/types.h>
+#include "pci.h"
 
 /**
  * pci_vc_save_restore_dwords - Save or restore a series of dwords
-- 
2.7.4

