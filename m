Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA013C6B35
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 09:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbhGMH3w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 03:29:52 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:14075 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbhGMH3w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jul 2021 03:29:52 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GPBvN1SPwzbc2D;
        Tue, 13 Jul 2021 15:23:44 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Jul 2021 15:27:00 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Jul 2021 15:27:00 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] PCI: Optimize pci_resource_len() to reduce the binary size of kernel
Date:   Tue, 13 Jul 2021 15:22:36 +0800
Message-ID: <20210713072236.3043-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_resource_end() can be 0 only when pci_resource_start() is 0.
Otherwise, it is definitely an error. In this case, pci_resource_len()
should be regarded as 0. Therefore, determining whether
pci_resource_start() and pci_resource_end() are both 0 can be reduced to
determining only whether pci_resource_end() is 0.

Although only one condition judgment is reduced, the macro function
pci_resource_len() is widely referenced in the kernel. I used defconfig to
compile the latest kernel on X86, and its binary code size was reduced by
about 3KB.

Before:
 [ 2] .rela.text        RELA             0000000000000000  093bfcb0
      0000000001a67168  0000000000000018   I      68     1     8

After:
 [ 2] .rela.text        RELA             0000000000000000  093bfcb0
      0000000001a66598  0000000000000018   I      68     1     8

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/pci.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 540b377ca8f6..23ef1a15eb5d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1881,9 +1881,7 @@ int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma);
 #define pci_resource_end(dev, bar)	((dev)->resource[(bar)].end)
 #define pci_resource_flags(dev, bar)	((dev)->resource[(bar)].flags)
 #define pci_resource_len(dev,bar) \
-	((pci_resource_start((dev), (bar)) == 0 &&	\
-	  pci_resource_end((dev), (bar)) ==		\
-	  pci_resource_start((dev), (bar))) ? 0 :	\
+	((pci_resource_end((dev), (bar)) == 0) ? 0 :	\
 							\
 	 (pci_resource_end((dev), (bar)) -		\
 	  pci_resource_start((dev), (bar)) + 1))
-- 
2.25.1

