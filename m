Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7D155A5FA
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jun 2022 04:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiFYCF7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 22:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFYCF6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 22:05:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465C14F444;
        Fri, 24 Jun 2022 19:05:57 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LVHNc1JYdzkWpR;
        Sat, 25 Jun 2022 10:04:16 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 25 Jun 2022 10:05:14 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 25 Jun
 2022 10:05:14 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <Frank.Li@nxp.com>, <jdmason@kudzu.us>, <kishon@ti.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>
Subject: [PATCH -next v2] PCI: endpoint: pci-epf-vntb: fix error handle in epf_ntb_mw_bar_init()
Date:   Sat, 25 Jun 2022 10:15:16 +0800
Message-ID: <20220625021516.431473-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In error case of epf_ntb_mw_bar_init(), memory window BARs should be
cleared, so add 'num_mws' parameter in epf_ntb_mw_bar_clear() and
calling it in error path to clear the BARs. Also add missing error
code when pci_epc_mem_alloc_addr() fails.

Fixes: ff32fac00d97 ("NTB: EPF: support NTB transfer between PCI RC and EP connection")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v2:
  add error label err_set_bar and move pci_epc_clear_bar() to it
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index ebf7e243eefa..ee9fee167d48 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -567,6 +567,8 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 	return -1;
 }
 
+static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws);
+
 /**
  * epf_ntb_db_bar_clear() - Clear doorbell BAR and free memory
  *   allocated in peers outbound address space
@@ -625,13 +627,21 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 							      &ntb->vpci_mw_phy[i],
 							      size);
 		if (!ntb->vpci_mw_addr[i]) {
+			ret = -ENOMEM;
 			dev_err(dev, "Failed to allocate source address\n");
-			goto err_alloc_mem;
+			goto err_set_bar;
 		}
 	}
 
 	return ret;
+
+err_set_bar:
+	pci_epc_clear_bar(ntb->epf->epc,
+			  ntb->epf->func_no,
+			  ntb->epf->vfunc_no,
+			  &ntb->epf->bar[barno]);
 err_alloc_mem:
+	epf_ntb_mw_bar_clear(ntb, i);
 	return ret;
 }
 
@@ -640,12 +650,12 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
  * @ntb: NTB device that facilitates communication between HOST and vHOST
  *
  */
-static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb)
+static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 {
 	enum pci_barno barno;
 	int i;
 
-	for (i = 0; i < ntb->num_mws; i++) {
+	for (i = 0; i < num_mws; i++) {
 		barno = ntb->epf_ntb_bar[BAR_MW0 + i];
 		pci_epc_clear_bar(ntb->epf->epc,
 				  ntb->epf->func_no,
@@ -774,7 +784,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 	return 0;
 
 err_write_header:
-	epf_ntb_mw_bar_clear(ntb);
+	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
 err_mw_bar_init:
 	epf_ntb_db_bar_clear(ntb);
 err_db_bar_init:
@@ -794,7 +804,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
 {
 	epf_ntb_db_bar_clear(ntb);
-	epf_ntb_mw_bar_clear(ntb);
+	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
 }
 
 #define EPF_NTB_R(_name)						\
-- 
2.25.1

