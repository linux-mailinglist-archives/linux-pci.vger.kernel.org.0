Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144E61E71FE
	for <lists+linux-pci@lfdr.de>; Fri, 29 May 2020 03:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438352AbgE2BQP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 May 2020 21:16:15 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:48670 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438345AbgE2BQK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 May 2020 21:16:10 -0400
X-Greylist: delayed 966 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 May 2020 21:16:10 EDT
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 4B46AFCA235482BF5DB5;
        Fri, 29 May 2020 08:59:50 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id 04T0xnMT013756;
        Fri, 29 May 2020 08:59:49 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020052909002322-3735728 ;
          Fri, 29 May 2020 09:00:23 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: [PATCH] PCI: Replace kmalloc with kzalloc in the comment/message
Date:   Fri, 29 May 2020 09:01:59 +0800
Message-Id: <1590714119-15744-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-05-29 09:00:23,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-05-29 08:59:53,
        Serialize complete at 2020-05-29 08:59:53
X-MAIL: mse-fl2.zte.com.cn 04T0xnMT013756
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Liao Pingfang <liao.pingfang@zte.com.cn>

Use kzalloc instead of kmalloc in the comment/message according to
the previous kzalloc() call.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
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

