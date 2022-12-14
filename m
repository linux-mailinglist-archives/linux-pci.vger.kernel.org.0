Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC7E64C3C2
	for <lists+linux-pci@lfdr.de>; Wed, 14 Dec 2022 07:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiLNG2u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Dec 2022 01:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiLNG2s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Dec 2022 01:28:48 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014F5222A4;
        Tue, 13 Dec 2022 22:28:46 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NX55F4RbMzlVtt;
        Wed, 14 Dec 2022 14:27:45 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:28:43 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jdmason@kudzu.us>, <dave.jiang@intel.com>, <allenbh@gmail.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <mani@kernel.org>,
        <kishon@kernel.org>, <bhelgaas@google.com>, <helgaas@kernel.org>,
        <Frank.Li@nxp.com>
Subject: [PATCH] PCI: endpoint: pci-epf-vntb: fix doc warnings in pci-epf-vntb.c
Date:   Wed, 14 Dec 2022 14:26:17 +0800
Message-ID: <20221214062617.2210218-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix the following make W=1 warnings:

  drivers/pci/endpoint/functions/pci-epf-vntb.c:338: warning: Function parameter or member 'ntb' not described in 'epf_ntb_config_sspad_bar_clear'
  drivers/pci/endpoint/functions/pci-epf-vntb.c:338: warning: Excess function parameter 'ntb_epc' description in 'epf_ntb_config_sspad_bar_clear'
  drivers/pci/endpoint/functions/pci-epf-vntb.c:645: warning: Function parameter or member 'num_mws' not described in 'epf_ntb_mw_bar_clear'

Fixes: 8e4bfbe644a6 ("PCI: endpoint: pci-epf-vntb: fix error handle in epf_ntb_mw_bar_init()")
Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 0ea85e1d292e..9e3a21c9debe 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -321,7 +321,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 /**
  * epf_ntb_config_sspad_bar_clear() - Clear Config + Self scratchpad BAR
- * @ntb_epc: EPC associated with one of the HOST which holds peer's outbound
+ * @ntb: EPC associated with one of the HOST which holds peer's outbound
  *	     address.
  *
  * Clear BAR0 of EP CONTROLLER 1 which contains the HOST1's config and
@@ -640,6 +640,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 /**
  * epf_ntb_mw_bar_clear() - Clear Memory window BARs
  * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @num_mws: the number of Memory window BARs that to be cleared
  */
 static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 {
-- 
2.25.1

