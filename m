Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF340774940
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 21:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjHHTun (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 15:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjHHTuW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 15:50:22 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AE64FB00
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 09:56:00 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RKfSR5cbkz1hwCb;
        Tue,  8 Aug 2023 11:53:59 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 11:56:47 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <bhelgaas@google.com>, <fbarrat@linux.ibm.com>,
        <ajd@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <ben.widawsky@intel.com>
CC:     <linux-pci@vger.kernel.org>, <yangyingliang@huawei.com>,
        <linuxppc-dev@lists.ozlabs.org>, <jonathan.cameron@huawei.com>,
        <david.e.box@linux.intel.com>, <helgaas@kernel.org>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH v2 0/2] Introduce pci_find_next_dvsec_capability() to simplify the code
Date:   Tue, 8 Aug 2023 12:08:56 +0800
Message-ID: <20230808040858.183568-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some devices may have several DVSEC (Designated Vendor-Specific Extended
Capability) entries with the same DVSEC ID. Introduce
pci_find_next_dvsec_capability() to simplify the code.

ChangeLog:
v1->v2:  Add Reviewed-by and Acked-by tags
	 Modify commit message and document a little for the first patch

Xiongfeng Wang (2):
  PCI: Add pci_find_next_dvsec_capability to find next Designated VSEC
  ocxl: use pci_find_next_dvsec_capability() to simplify the code

 arch/powerpc/platforms/powernv/ocxl.c | 20 ++------------
 drivers/misc/ocxl/config.c            | 21 +++++----------
 drivers/pci/pci.c                     | 39 ++++++++++++++++++---------
 include/linux/pci.h                   |  2 ++
 include/misc/ocxl-config.h            |  4 ---
 5 files changed, 36 insertions(+), 50 deletions(-)

-- 
2.20.1

