Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168D022832F
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jul 2020 17:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgGUPH4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 11:07:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8348 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728362AbgGUPHz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Jul 2020 11:07:55 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 67FEC4F408849D84850E;
        Tue, 21 Jul 2020 23:07:47 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Jul 2020 23:07:38 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-pci@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH -next] PCI: rpadlpar: Make some functions static
Date:   Tue, 21 Jul 2020 23:17:35 +0800
Message-ID: <20200721151735.41181-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The sparse tool report build warnings as follows:

drivers/pci/hotplug/rpadlpar_core.c:355:5: warning:
 symbol 'dlpar_remove_pci_slot' was not declared. Should it be static?
drivers/pci/hotplug/rpadlpar_core.c:461:12: warning:
 symbol 'rpadlpar_io_init' was not declared. Should it be static?
drivers/pci/hotplug/rpadlpar_core.c:473:6: warning:
 symbol 'rpadlpar_io_exit' was not declared. Should it be static?

Those functions are not used outside of this file, so marks them
static.
Also mark rpadlpar_io_exit() as __exit.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pci/hotplug/rpadlpar_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index c5eb509c72f0..f979b7098acf 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -352,7 +352,7 @@ static int dlpar_remove_vio_slot(char *drc_name, struct device_node *dn)
  * -ENODEV		Not a valid drc_name
  * -EIO			Internal PCI Error
  */
-int dlpar_remove_pci_slot(char *drc_name, struct device_node *dn)
+static int dlpar_remove_pci_slot(char *drc_name, struct device_node *dn)
 {
 	struct pci_bus *bus;
 	struct slot *slot;
@@ -458,7 +458,7 @@ static inline int is_dlpar_capable(void)
 	return (int) (rc != RTAS_UNKNOWN_SERVICE);
 }
 
-int __init rpadlpar_io_init(void)
+static int __init rpadlpar_io_init(void)
 {
 
 	if (!is_dlpar_capable()) {
@@ -470,7 +470,7 @@ int __init rpadlpar_io_init(void)
 	return dlpar_sysfs_init();
 }
 
-void rpadlpar_io_exit(void)
+static void __exit rpadlpar_io_exit(void)
 {
 	dlpar_sysfs_exit();
 }

