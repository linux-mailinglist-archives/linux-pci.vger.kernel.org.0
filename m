Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132E31F66B3
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jun 2020 13:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgFKLcx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jun 2020 07:32:53 -0400
Received: from mail.loongson.cn ([114.242.206.163]:57974 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726959AbgFKLcv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Jun 2020 07:32:51 -0400
Received: from ticat.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxH99fFuJe6e1AAA--.2135S2;
        Thu, 11 Jun 2020 19:32:47 +0800 (CST)
From:   Peng Fan <fanpeng@loongson.cn>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH] tools: PCI: Fix memory leak in run_test
Date:   Thu, 11 Jun 2020 19:32:46 +0800
Message-Id: <1591875166-12243-1-git-send-email-fanpeng@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9DxH99fFuJe6e1AAA--.2135S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw1kWry3uw17tF4UWw48JFb_yoWxurg_K3
        W2qwn7Wr45Xry8tasxA345WFyxCan8Wr4xWayftF47uFWvkan09F97ZrWkGF45Gw4avF9I
        kwnrAFy0vw17CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Gw4l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU8wIhUUUUU=
X-CM-SenderInfo: xidq1vtqj6z05rqj20fqof0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We should free "test" before the return of run_test.

Signed-off-by: Peng Fan <fanpeng@loongson.cn>
---
 tools/pci/pcitest.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 0a1344c..7c20332 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -47,6 +47,7 @@ static int run_test(struct pci_test *test)
 	fd = open(test->device, O_RDWR);
 	if (fd < 0) {
 		perror("can't open PCI Endpoint Test device");
+		free(test);
 		return -ENODEV;
 	}
 
@@ -151,6 +152,7 @@ static int run_test(struct pci_test *test)
 
 	fflush(stdout);
 	close(fd);
+	free(test);
 	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
 }
 
-- 
2.1.0

