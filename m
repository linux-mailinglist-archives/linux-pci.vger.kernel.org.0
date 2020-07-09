Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC302199AA
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 09:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgGIHZN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 03:25:13 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:62488 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgGIHZN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jul 2020 03:25:13 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id BD6D76DA4D9DBAC9C570;
        Thu,  9 Jul 2020 15:25:08 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id 0697P7W6095764;
        Thu, 9 Jul 2020 15:25:07 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020070915253562-4229803 ;
          Thu, 9 Jul 2020 15:25:35 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: [PATCH] PCI: Replace kmalloc with kzalloc in the comment/message
Date:   Thu, 9 Jul 2020 15:28:28 +0800
Message-Id: <1594279708-34369-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-07-09 15:25:35,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-07-09 15:25:11,
        Serialize complete at 2020-07-09 15:25:11
X-MAIL: mse-fl2.zte.com.cn 0697P7W6095764
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Liao Pingfang <liao.pingfang@zte.com.cn>

Use kzalloc instead of kmalloc in the comment/message according to
the previous kzalloc() call.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 drivers/pci/hotplug/ibmphp_pci.c | 2 +-
 drivers/pci/setup-bus.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/ibmphp_pci.c b/drivers/pci/hotplug/ibmphp_pci.c
index e22d023..2d36992 100644
--- a/drivers/pci/hotplug/ibmphp_pci.c
+++ b/drivers/pci/hotplug/ibmphp_pci.c
@@ -205,7 +205,7 @@ int ibmphp_configure_card(struct pci_func *func, u8 slotno)
 								cur_func->next = newfunc;
 
 							rc = ibmphp_configure_card(newfunc, slotno);
-							/* This could only happen if kmalloc failed */
+							/* This could only happen if kzalloc failed */
 							if (rc) {
 								/* We need to do this in case bridge itself got configured properly, but devices behind it failed */
 								func->bus = 1; /* To indicate to the unconfigure function that this is a PPB */
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index bbcef1a..13c5a44 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -151,7 +151,7 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 
 		tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
 		if (!tmp)
-			panic("pdev_sort_resources(): kmalloc() failed!\n");
+			panic("%s: kzalloc() failed!\n", __func__);
 		tmp->res = r;
 		tmp->dev = dev;
 
-- 
2.9.5

