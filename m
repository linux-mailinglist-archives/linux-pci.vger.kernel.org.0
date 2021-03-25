Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A66D348A7D
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 08:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhCYHuy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 03:50:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14585 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhCYHuV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 03:50:21 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F5cfT4fbgz19JBc;
        Thu, 25 Mar 2021 15:48:17 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 15:50:08 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <bhelgaas@google.com>, <rjw@rjwysocki.net>, <ruscur@russell.cc>
CC:     <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangxiongfeng2@huawei.com>
Subject: [PATCH 3/4] PCI/PME: Correct pcie_pme_init() function name in the header
Date:   Thu, 25 Mar 2021 15:51:43 +0800
Message-ID: <20210325075144.180030-4-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210325075144.180030-1-wangxiongfeng2@huawei.com>
References: <20210325075144.180030-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/pci/pcie/pme.c:469: warning: expecting prototype for pcie_pme_service_init(). Prototype was for pcie_pme_init() instead

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/pci/pcie/pme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 3fc08488d65f..1d0dd77fed3a 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -463,7 +463,7 @@ static struct pcie_port_service_driver pcie_pme_driver = {
 };
 
 /**
- * pcie_pme_service_init - Register the PCIe PME service driver.
+ * pcie_pme_init - Register the PCIe PME service driver.
  */
 int __init pcie_pme_init(void)
 {
-- 
2.20.1

