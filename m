Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DA8348A71
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 08:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhCYHu2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 03:50:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14587 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhCYHuT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 03:50:19 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F5cfT4Nsxz19JB9;
        Thu, 25 Mar 2021 15:48:17 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 15:50:07 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <bhelgaas@google.com>, <rjw@rjwysocki.net>, <ruscur@russell.cc>
CC:     <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangxiongfeng2@huawei.com>
Subject: [PATCH 1/4] PCI: acpi_pcihp: Correct acpi_pci_check_ejectable() function name in the header
Date:   Thu, 25 Mar 2021 15:51:41 +0800
Message-ID: <20210325075144.180030-2-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210325075144.180030-1-wangxiongfeng2@huawei.com>
References: <20210325075144.180030-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/pci/hotplug/acpi_pcihp.c:167: warning: expecting prototype for acpi_pcihp_check_ejectable(). Prototype was for acpi_pci_check_ejectable() instead

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/pci/hotplug/acpi_pcihp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
index 2750a64cecd3..4fedebf2f8c1 100644
--- a/drivers/pci/hotplug/acpi_pcihp.c
+++ b/drivers/pci/hotplug/acpi_pcihp.c
@@ -157,7 +157,7 @@ static int pcihp_is_ejectable(acpi_handle handle)
 }
 
 /**
- * acpi_pcihp_check_ejectable - check if handle is ejectable ACPI PCI slot
+ * acpi_pci_check_ejectable - check if handle is ejectable ACPI PCI slot
  * @pbus: the PCI bus of the PCI slot corresponding to 'handle'
  * @handle: ACPI handle to check
  *
-- 
2.20.1

