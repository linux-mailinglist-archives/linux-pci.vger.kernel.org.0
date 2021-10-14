Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4589A42D394
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 09:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhJNH2g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 03:28:36 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:56343 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbhJNH2c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Oct 2021 03:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634196388; x=1665732388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=syL4/+YK/aL5HlwXEqODcUbypd3HoBOXAo6KAvaPuXk=;
  b=AyfhGESGlrX3/kwvR5VImNsv7/kz5nBd9n5JsTsvaWOwDOsEDIocnIQC
   dkW8rUMLETiO/zbZLhl6wL3kOy+bpD1on9l/IiKp+VutWv5vduOCZb6FM
   CZicw6WYA5+Ta3BM0LegTP/Gam3pQ8zR+sxkyz6G9fnWfB1eKtLt2f14x
   CyNu2Cc/B/uA1TryO8wurOR0eEfeM5OHqgzo+D/HazGRjKy56iN64lKix
   B2uwTE/PNKLvyv+Lg9o1qnR/tnl3drm6cur2YxrjVLnjGYOrYtEl7g7kg
   PNdi86+Q4LgpDDs2l35i1nna0smKihyT/AS3LpM0+n9ej2j4NSBb6czpG
   A==;
IronPort-SDR: NeTmjoOYSXppJ4D+QBHugjKfPF4RnOY9jO8C2uGY+Jc+EPl/jdXGtLwLyo1b+cGd9M6rnV73qs
 +fiP711PqJtIP6cgYpevnwbBHWULtaDT3xvmsEoj2/IYe/JMaSXoYesFVAzM56DdYMrVJ3WEOY
 LuoTKpD/C1aLZ/u4w0GYa/Cl/o1ljIamj/Z7yXFFOcp5qKJqJXH4HlZhDIXWdWBOTnG1BYbM06
 rco0579RI28EnIMNpW14kfeSQyU2l8t9hsV3YH0+f4bPm0rnjRvhffr1ArLeQGyH2CkQL1OJRe
 H6QTi+ZmqlWtizzdKXNhvM5M
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="148045675"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Oct 2021 00:26:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 14 Oct 2021 00:26:20 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 14 Oct 2021 00:26:20 -0700
From:   <kelvin.cao@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kelvin.cao@microchip.com>, <kelvincao@outlook.com>
Subject: [PATCH v2 4/5] PCI/switchtec: Replace ENOTSUPP with EOPNOTSUPP
Date:   Thu, 14 Oct 2021 14:18:58 +0000
Message-ID: <20211014141859.11444-5-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211014141859.11444-1-kelvin.cao@microchip.com>
References: <20211014141859.11444-1-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kelvin Cao <kelvin.cao@microchip.com>

ENOTSUPP is not a SUSV4 error code, and the following checkpatch.pl
warning will be given for new patches which still use ENOTSUPP.

    WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP

See the link below for the discussion.

  https://lore.kernel.org/netdev/20200511165319.2251678-1-kuba@kernel.org/

Replace ENOTSUPP with EOPNOTSUPP to align with future patches which will
be using EOPNOTSUPP.

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
---
 drivers/pci/switch/switchtec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 97a93c9b4629..236cb40cc7c5 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -376,7 +376,7 @@ static ssize_t field ## _show(struct device *dev, \
 		return io_string_show(buf, &si->gen4.field, \
 				      sizeof(si->gen4.field)); \
 	else \
-		return -ENOTSUPP; \
+		return -EOPNOTSUPP; \
 } \
 \
 static DEVICE_ATTR_RO(field)
@@ -668,7 +668,7 @@ static int ioctl_flash_info(struct switchtec_dev *stdev,
 		info.flash_length = ioread32(&fi->gen4.flash_length);
 		info.num_partitions = SWITCHTEC_NUM_PARTITIONS_GEN4;
 	} else {
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	if (copy_to_user(uinfo, &info, sizeof(info)))
@@ -876,7 +876,7 @@ static int ioctl_flash_part_info(struct switchtec_dev *stdev,
 		if (ret)
 			return ret;
 	} else {
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	if (copy_to_user(uinfo, &info, sizeof(info)))
@@ -1611,7 +1611,7 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
 	else if (stdev->gen == SWITCHTEC_GEN4)
 		part_id = &stdev->mmio_sys_info->gen4.partition_id;
 	else
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	stdev->partition = ioread8(part_id);
 	stdev->partition_count = ioread8(&stdev->mmio_ntb->partition_count);
-- 
2.25.1

