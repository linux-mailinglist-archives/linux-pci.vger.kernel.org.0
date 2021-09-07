Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD72840260C
	for <lists+linux-pci@lfdr.de>; Tue,  7 Sep 2021 11:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244766AbhIGJQZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Sep 2021 05:16:25 -0400
Received: from smtp23.cstnet.cn ([159.226.251.23]:40694 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244756AbhIGJQY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Sep 2021 05:16:24 -0400
X-Greylist: delayed 896 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Sep 2021 05:16:24 EDT
Received: from localhost.localdomain (unknown [124.16.141.241])
        by APP-03 (Coremail) with SMTP id rQCowAAXOREEKjdhJZhwAA--.33777S2;
        Tue, 07 Sep 2021 16:59:48 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        bhelgaas@google.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pci/hotplug/pnv-php: Remove probable double put
Date:   Tue,  7 Sep 2021 08:59:46 +0000
Message-Id: <20210907085946.21694-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: rQCowAAXOREEKjdhJZhwAA--.33777S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw17uFyrAr15JrykXry7KFg_yoWxCFc_WF
        48WFZrWr4FyF1Sgrs0gryrZrWSya4DWrs5Aw4Iq3Zaya1xXr17CFWYvr98Jasrur43Xr95
        Ar9FqF45Ar15CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2kYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr
        1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_GFyl42xK
        82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8ldgJUUUUU==
X-Originating-IP: [124.16.141.241]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCwoRA1z4kZHFJgAAsU
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Device node iterators put the previous value of the index variable,
so an explicit put causes a double put.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/pci/hotplug/pnv_php.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 04565162a449..ed4d1a2c3f22 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -158,7 +158,6 @@ static void pnv_php_detach_device_nodes(struct device_node *parent)
 	for_each_child_of_node(parent, dn) {
 		pnv_php_detach_device_nodes(dn);
 
-		of_node_put(dn);
 		of_detach_node(dn);
 	}
 }
-- 
2.17.1

