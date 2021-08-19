Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F7A3F1496
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 09:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbhHSHzx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 03:55:53 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:14276 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhHSHzw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Aug 2021 03:55:52 -0400
Received: from dggeml759-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GqxrT6VDlz80tY;
        Thu, 19 Aug 2021 15:55:05 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 dggeml759-chm.china.huawei.com (10.1.199.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 19 Aug 2021 15:55:14 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] PCI: endpoint: Fix missing unlock on error in pci_epf_add_vepf()
Date:   Thu, 19 Aug 2021 08:06:55 +0000
Message-ID: <20210819080655.316468-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeml759-chm.china.huawei.com (10.1.199.138)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the missing unlock before return from function pci_epf_add_vepf()
in the error handling case.

Fixes: b64215ff2b5e ("PCI: endpoint: Add support to add virtual function in endpoint core")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index ec286ee5d04c..8aea16380870 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -200,8 +200,10 @@ int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf)
 	mutex_lock(&epf_pf->lock);
 	vfunc_no = find_first_zero_bit(&epf_pf->vfunction_num_map,
 				       BITS_PER_LONG);
-	if (vfunc_no >= BITS_PER_LONG)
+	if (vfunc_no >= BITS_PER_LONG) {
+		mutex_unlock(&epf_pf->lock);
 		return -EINVAL;
+	}
 
 	set_bit(vfunc_no, &epf_pf->vfunction_num_map);
 	epf_vf->vfunc_no = vfunc_no;

