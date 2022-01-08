Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160964882B2
	for <lists+linux-pci@lfdr.de>; Sat,  8 Jan 2022 10:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbiAHJJs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Jan 2022 04:09:48 -0500
Received: from mail.loongson.cn ([114.242.206.163]:42566 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231402AbiAHJJr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 8 Jan 2022 04:09:47 -0500
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Cxi+jRVNlhpLMAAA--.2989S2;
        Sat, 08 Jan 2022 17:09:37 +0800 (CST)
From:   Ming Wang <wangming01@loongson.cn>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] misc: pci_endpoint_test: Use a semicolon as the end of the statement.
Date:   Sat,  8 Jan 2022 17:09:37 +0800
Message-Id: <1641632977-6588-1-git-send-email-wangming01@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9Cxi+jRVNlhpLMAAA--.2989S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr45uFykuw45Wr1UZF43ZFb_yoW3Arc_Ga
        yUZwsxurWrGr18GrnIvw1xZrZF9wnIgF1rur1aqFZIya42v34DAFyjgr4vyr47CFnxCFnr
        C3sF9r9YkF1xAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbI8YjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
        cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx
        0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY
        02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        xU7GQ6DUUUU
X-CM-SenderInfo: 5zdqwzxlqjiio6or00hjvr0hdfq/
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Even so, there is no syntax error. But, this may be a
clerical error. ';' are more appropriate than ','.

Signed-off-by: Ming Wang <wangming01@loongson.cn>
---
 drivers/misc/pci_endpoint_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 2ed7e3a..8f786a2 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -865,7 +865,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		goto err_release_irq;
 	}
 	misc_device->parent = &pdev->dev;
-	misc_device->fops = &pci_endpoint_test_fops,
+	misc_device->fops = &pci_endpoint_test_fops;
 
 	err = misc_register(misc_device);
 	if (err) {
-- 
1.8.3.1

