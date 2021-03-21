Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0FB343348
	for <lists+linux-pci@lfdr.de>; Sun, 21 Mar 2021 16:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhCUPwF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Mar 2021 11:52:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14414 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCUPv4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Mar 2021 11:51:56 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F3MXP3lNbzjLZG;
        Sun, 21 Mar 2021 23:50:13 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.117) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Sun, 21 Mar 2021
 23:51:42 +0800
To:     <schnelle@linux.ibm.com>, <gerald.schaefer@linux.ibm.com>,
        <bhelgaas@google.com>
CC:     <linux-s390@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linfeilong <linfeilong@huawei.com>, <liuzhiqiang26@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [PATCH] pci/hotplug: fix potential memory leak in disable_slot()
Message-ID: <245c1063-f0cf-551a-b93c-1a0a5ac06eff@huawei.com>
Date:   Sun, 21 Mar 2021 23:51:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


In disable_slot(), if we obtain desired PCI device
successfully by calling pci_get_slot(), we should
call pci_dev_put() to release its reference.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Signed-off-by: Feilong Lin <linfeilong@huawei.com>
---
 drivers/pci/hotplug/s390_pci_hpc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/s390_pci_hpc.c b/drivers/pci/hotplug/s390_pci_hpc.c
index c9e790c74051..999a34b6fd50 100644
--- a/drivers/pci/hotplug/s390_pci_hpc.c
+++ b/drivers/pci/hotplug/s390_pci_hpc.c
@@ -89,9 +89,11 @@ static int disable_slot(struct hotplug_slot *hotplug_slot)
 		return -EIO;

 	pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
-	if (pdev && pci_num_vf(pdev)) {
+	if (pdev) {
+		rc = pci_num_vf(pdev);
 		pci_dev_put(pdev);
-		return -EBUSY;
+		if (rc)
+			return -EBUSY;
 	}

 	zpci_remove_device(zdev);
-- 
2.19.1


