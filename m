Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB93448F66D
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jan 2022 11:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiAOKue (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Jan 2022 05:50:34 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16712 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbiAOKud (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 Jan 2022 05:50:33 -0500
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JbZbv2kllzZdqM
        for <linux-pci@vger.kernel.org>; Sat, 15 Jan 2022 18:46:51 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 15 Jan 2022 18:50:31 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     <yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: [PATCH] PCI/AER: Update the link to the aer-inject tool
Date:   Sat, 15 Jan 2022 18:49:21 +0800
Message-ID: <20220115104921.21606-1-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The link to the aer-inject referenced leads to an empty repo
and seems no longer used. Replace it with the link mentioned
in Documentation/PCI/pcieaer-howto.rst.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/pcie/Kconfig      | 2 +-
 drivers/pci/pcie/aer_inject.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 45a2ef702b45..788ac8df3f9d 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -43,7 +43,7 @@ config PCIEAER_INJECT
 	  error injection can fake almost all kinds of errors with the
 	  help of a user space helper tool aer-inject, which can be
 	  gotten from:
-	     https://www.kernel.org/pub/linux/utils/pci/aer-inject/
+	     https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
 
 #
 # PCI Express ECRC
diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 767f8859b99b..2dab275d252f 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -6,7 +6,7 @@
  * trigger various real hardware errors. Software based error
  * injection can fake almost all kinds of errors with the help of a
  * user space helper tool aer-inject, which can be gotten from:
- *   https://www.kernel.org/pub/linux/utils/pci/aer-inject/
+ *   https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
  *
  * Copyright 2009 Intel Corporation.
  *     Huang Ying <ying.huang@intel.com>
-- 
2.24.0

