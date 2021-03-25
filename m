Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A88348A70
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 08:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCYHuZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 03:50:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14588 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCYHuT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 03:50:19 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F5cfT3rVcz19HFm;
        Thu, 25 Mar 2021 15:48:17 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 15:50:08 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <bhelgaas@google.com>, <rjw@rjwysocki.net>, <ruscur@russell.cc>
CC:     <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangxiongfeng2@huawei.com>
Subject: [PATCH 2/4] PCI/AER: Correct function names in the header
Date:   Thu, 25 Mar 2021 15:51:42 +0800
Message-ID: <20210325075144.180030-3-wangxiongfeng2@huawei.com>
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

 drivers/pci/pcie/aer.c:138: warning: expecting prototype for enable_ercr_checking(). Prototype was for enable_ecrc_checking() instead
 drivers/pci/pcie/aer.c:162: warning: expecting prototype for disable_ercr_checking(). Prototype was for disable_ecrc_checking() instead
 drivers/pci/pcie/aer.c:1450: warning: expecting prototype for aer_service_init(). Prototype was for pcie_aer_init() instead

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/pci/pcie/aer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ba22388342d1..ec943cee5ecc 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -129,7 +129,7 @@ static const char * const ecrc_policy_str[] = {
 };
 
 /**
- * enable_ercr_checking - enable PCIe ECRC checking for a device
+ * enable_ecrc_checking - enable PCIe ECRC checking for a device
  * @dev: the PCI device
  *
  * Returns 0 on success, or negative on failure.
@@ -153,7 +153,7 @@ static int enable_ecrc_checking(struct pci_dev *dev)
 }
 
 /**
- * disable_ercr_checking - disables PCIe ECRC checking for a device
+ * disable_ecrc_checking - disables PCIe ECRC checking for a device
  * @dev: the PCI device
  *
  * Returns 0 on success, or negative on failure.
@@ -1442,7 +1442,7 @@ static struct pcie_port_service_driver aerdriver = {
 };
 
 /**
- * aer_service_init - register AER root service driver
+ * pcie_aer_init - register AER root service driver
  *
  * Invoked when AER root service driver is loaded.
  */
-- 
2.20.1

