Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C1E5575DD
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 10:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiFWIsr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 04:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiFWIsr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 04:48:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3BE4924E;
        Thu, 23 Jun 2022 01:48:46 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LTDQG0PFWzkWTY;
        Thu, 23 Jun 2022 16:47:02 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 16:48:11 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 23 Jun
 2022 16:48:11 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <kishon@ti.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <jdmason@kudzu.us>, <Frank.Li@nxp.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH -next] NTB: EPF: Fix Kconfig dependency
Date:   Thu, 23 Jun 2022 16:46:29 +0800
Message-ID: <20220623084629.260822-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If CONFIG_NTB is not set and CONFIG_PCI_EPF_VNTB is y.

make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-, will be failed, like this:

drivers/pci/endpoint/functions/pci-epf-vntb.o: In function `epf_ntb_cmd_handler':
pci-epf-vntb.c:(.text+0x95e): undefined reference to `ntb_db_event'
pci-epf-vntb.c:(.text+0xa1f): undefined reference to `ntb_link_event'
pci-epf-vntb.c:(.text+0xa42): undefined reference to `ntb_link_event'
drivers/pci/endpoint/functions/pci-epf-vntb.o: In function `pci_vntb_probe':
pci-epf-vntb.c:(.text+0x1250): undefined reference to `ntb_register_device'

The functions ntb_*() are defined in drivers/ntb/core.c, which need CONFIG_NTB setting y to be build-in.
To fix this build error, add depends on NTB.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: ff32fac00d97("NTB: EPF: support NTB transfer between PCI RC and EP connection")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 drivers/pci/endpoint/functions/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
index 362555b024e8..9beee4f0f4ee 100644
--- a/drivers/pci/endpoint/functions/Kconfig
+++ b/drivers/pci/endpoint/functions/Kconfig
@@ -29,6 +29,7 @@ config PCI_EPF_NTB
 config PCI_EPF_VNTB
         tristate "PCI Endpoint NTB driver"
         depends on PCI_ENDPOINT
+        depends on NTB
         select CONFIGFS_FS
         help
           Select this configuration option to enable the Non-Transparent
-- 
2.17.1

