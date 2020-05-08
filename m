Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0771CAA3F
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 14:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEHMGq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 08:06:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4303 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726616AbgEHMGq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 May 2020 08:06:46 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 71793139C267C3A8E53A;
        Fri,  8 May 2020 20:06:44 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 20:06:36 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <kishon@ti.com>, <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH -next] PCI: endpoint: use kmemdup_nul() in pci_epf_create()
Date:   Fri, 8 May 2020 20:10:29 +0800
Message-ID: <20200508121029.167018-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It is more efficient to use kmemdup_nul() if the size is known exactly.

The doc in kernel:
"Note: Use kmemdup_nul() instead if the size is known exactly."

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 244e00f48c5c..f035d2ebcae5 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -252,7 +252,7 @@ struct pci_epf *pci_epf_create(const char *name)
 		return ERR_PTR(-ENOMEM);
 
 	len = strchrnul(name, '.') - name;
-	epf->name = kstrndup(name, len, GFP_KERNEL);
+	epf->name = kmemdup_nul(name, len, GFP_KERNEL);
 	if (!epf->name) {
 		kfree(epf);
 		return ERR_PTR(-ENOMEM);
-- 
2.20.1

