Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7657306FA
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2019 05:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfEaD2R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 May 2019 23:28:17 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:40410 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726581AbfEaD2Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 May 2019 23:28:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yinhe@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TT2dx.F_1559273285;
Received: from localhost(mailfrom:yinhe@linux.alibaba.com fp:SMTPD_---0TT2dx.F_1559273285)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 31 May 2019 11:28:14 +0800
From:   Hao Zheng <yinhe@linux.alibaba.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        nanhai.zou@linux.alibaba.com, Hao Zheng <yinhe@linux.alibaba.com>,
        Quan Xu <quan.xu0@linux.alibaba.com>
Subject: [PATCH 1/1] PCI/IOV: fix cfg_size setting for multiple vfio-devices
Date:   Fri, 31 May 2019 11:28:02 +0800
Message-Id: <1559273282-38802-1-git-send-email-yinhe@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When there are multiple vfio devices, only the cfg_size of first
vfio device can be correctly set to 4096. The cfg_size of other
vfio devices are incorrectly set to 256.

This will cause an error when live migrating a virtual machine with
vfio devices to multiple destinations. Fix this by setting correct
pcie_cap field before cfg_size initialize.

Signed-off-by: Hao Zheng <yinhe@linux.alibaba.com>
Signed-off-by: Quan Xu <quan.xu0@linux.alibaba.com>
cc: Zou Nanhai <nanhai.zou@linux.alibaba.com>
---
 drivers/pci/iov.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 3aa115e..239fad1 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -133,6 +133,7 @@ static void pci_read_vf_config_common(struct pci_dev *virtfn)
 	pci_read_config_word(virtfn, PCI_SUBSYSTEM_ID,
 			     &physfn->sriov->subsystem_device);
 
+	set_pcie_port_type(virtfn);
 	physfn->sriov->cfg_size = pci_cfg_space_size(virtfn);
 }
 
-- 
1.8.3.1

