Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7DB618F14
	for <lists+linux-pci@lfdr.de>; Fri,  4 Nov 2022 04:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiKDDbk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 23:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiKDDbM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 23:31:12 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C472793B;
        Thu,  3 Nov 2022 20:28:34 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N3R0k3DbCz15MMK;
        Fri,  4 Nov 2022 11:28:22 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 11:28:27 +0800
Received: from huawei.com (10.67.175.41) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 11:28:27 +0800
From:   Yipeng Zou <zouyipeng@huawei.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>, <bhelgaas@google.com>,
        <tn@semihalf.com>, <linux-acpi@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     <zouyipeng@huawei.com>
Subject: [PATCH] PCI/ACPI: use ACPI Method Name macro directly
Date:   Fri, 4 Nov 2022 11:24:30 +0800
Message-ID: <20221104032430.186424-1-zouyipeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.41]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It's convenience to find all at once, use METHOD_NAME__UID as path string.

Fixes: 169de969c018 ("PCI/ACPI: Provide acpi_get_rc_resources() for ARM64 platform")
Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
---
 drivers/pci/pci-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a46fec776ad7..068d6745bf98 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -67,7 +67,7 @@ static acpi_status acpi_match_rc(acpi_handle handle, u32 lvl, void *context,
 	unsigned long long uid;
 	acpi_status status;
 
-	status = acpi_evaluate_integer(handle, "_UID", NULL, &uid);
+	status = acpi_evaluate_integer(handle, METHOD_NAME__UID, NULL, &uid);
 	if (ACPI_FAILURE(status) || uid != *segment)
 		return AE_CTRL_DEPTH;
 
-- 
2.17.1

