Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B5257EC5E
	for <lists+linux-pci@lfdr.de>; Sat, 23 Jul 2022 08:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiGWGpD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Jul 2022 02:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235993AbiGWGpB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Jul 2022 02:45:01 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B36067CBD;
        Fri, 22 Jul 2022 23:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KZDSp
        PbIpEXdoyPYRgzx3dJeJEfWOtuL5cZbKBw/Vis=; b=VLu6Z0eNZG3SkGB4YFD9l
        dZn1eUrxVQXRPfjHRtru5bJ45/pksdesKPaXQFYBul9lfHN3Q5OCIDWoPHYE+GWR
        7Eyc+d8VldlaCUEi8U1y9oLZ/7l/fbbqYfkssTYxCX0l+8OE3vmlWqgPP8cv9wFg
        u0OY7qsb6aDG4ISCYSRdKk=
Received: from localhost.localdomain (unknown [123.58.221.99])
        by smtp2 (Coremail) with SMTP id GtxpCgDnRemdmNtiRiIVQw--.40677S2;
        Sat, 23 Jul 2022 14:43:43 +0800 (CST)
From:   williamsukatube@163.com
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH] PCI: endpoint: check the return value of alloc_workqueue()
Date:   Sat, 23 Jul 2022 14:43:39 +0800
Message-Id: <20220723064339.2957069-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgDnRemdmNtiRiIVQw--.40677S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtFWxXr1DWr1DKF18CF1fCrg_yoW8Jr18pr
        Z3Cry0yrW8tw4UGF45Xr4kAr9xAa1qg347ZryfWw4ava1xGFyrK3ykta43tFZrGrWUXw4r
        tFZ8Xa4aqF1UAr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bF9N3UUUUU=
X-Originating-IP: [123.58.221.99]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/1tbiNx9Hg1WBo2yi3QAAsI
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: William Dean <williamsukatube@gmail.com>

The function alloc_workqueue() in epf_ntb_init() can
fail, but there is no check of its return value. To fix this bug, its
return value should be checked with new error handling code.

Fixes: 8b821cf761503 ("PCI: endpoint: Add EP function driver to provide NTB functionality")
Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: William Dean <williamsukatube@gmail.com>
---
 drivers/pci/endpoint/functions/pci-epf-ntb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index 9a00448c7e61..41d85591cd1e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -2124,6 +2124,11 @@ static int __init epf_ntb_init(void)
 
 	kpcintb_workqueue = alloc_workqueue("kpcintb", WQ_MEM_RECLAIM |
 					    WQ_HIGHPRI, 0);
+	if (!kpcintb_workqueue) {
+		pr_err("Failed to alloc kpcintb workqueue\n");
+		return -ENOMEM;
+	}
+
 	ret = pci_epf_register_driver(&epf_ntb_driver);
 	if (ret) {
 		destroy_workqueue(kpcintb_workqueue);
-- 
2.25.1

