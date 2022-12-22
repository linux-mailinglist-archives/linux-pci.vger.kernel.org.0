Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB7D65412A
	for <lists+linux-pci@lfdr.de>; Thu, 22 Dec 2022 13:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbiLVMlN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Dec 2022 07:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLVMlL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Dec 2022 07:41:11 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4400A2BF5;
        Thu, 22 Dec 2022 04:41:08 -0800 (PST)
Received: from kwepemi500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Nd8vz62qNzJpGc;
        Thu, 22 Dec 2022 20:37:19 +0800 (CST)
Received: from shaphisprc00214.huawei.com (100.108.184.173) by
 kwepemi500002.china.huawei.com (7.221.188.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 22 Dec 2022 20:41:05 +0800
From:   Jiantao Zhang <water.zhangjiantao@huawei.com>
To:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zhangjianrong5@huawei.com>
CC:     <suzhuangluan@hisilicon.com>, <caiyadong@huawei.com>,
        <guhengsheng@hisilicon.com>, <songxiaowei@hisilicon.com>,
        <water.zhangjiantao@huawei.com>
Subject: [PATCH] PCI: Exit restore process when device is still powerdown
Date:   Thu, 22 Dec 2022 12:41:04 +0000
Message-ID: <20221222124104.69607-1-water.zhangjiantao@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.108.184.173]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500002.china.huawei.com (7.221.188.171)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We get this stack when the rp doesn't power up in resume noirq:
    dump_backtrace.cfi_jt+0x0/0x4
    dump_stack_lvl+0xb4/0x10c
    show_regs_before_dump_stack+0x1c/0x30
    arm64_serror_panic+0x110/0x1a8
    do_serror+0x16c/0x1cc
    el1_error+0x8c/0x10c
    do_raw_spin_unlock+0x74/0xdc
    pci_bus_read_config_word+0xdc/0x1dc
    pci_restore_msi_state+0x2f4/0x36c
    pci_restore_state+0x13f0/0x1444
    pci_pm_resume_noirq+0x158/0x318
    dpm_run_callback+0x178/0x5e8
    device_resume_noirq+0x250/0x264
    async_resume_noirq+0x20/0xf8
    async_run_entry_fn+0xfc/0x364
    process_one_work+0x37c/0x7f4
    worker_thread+0x3e8/0x754
    kthread+0x168/0x204
    ret_from_fork+0x10/0x18
The ep device uses msix, the restore process will write bar space
in __pci_msix_desc_mask_irq, which will result in accessing the
powerdown area when the rp doesn't power on.

It makes sense we should do nothing when the device is still powerdown.

Signed-off-by: Jianrong Zhang <zhangjianrong5@huawei.com>
Signed-off-by: Jiantao Zhang <water.zhangjiantao@huawei.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index fba95486caaf..279f6e8c5a00 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1764,7 +1764,7 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
  */
 void pci_restore_state(struct pci_dev *dev)
 {
-	if (!dev->state_saved)
+	if (!dev->state_saved || dev->current_state == PCI_UNKNOWN)
 		return;
 
 	/*
-- 
2.17.1

