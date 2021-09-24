Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4B8416ABF
	for <lists+linux-pci@lfdr.de>; Fri, 24 Sep 2021 06:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244100AbhIXER1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 00:17:27 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:37322 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244087AbhIXER0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Sep 2021 00:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632456954; x=1663992954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0aTSFNISN4uSkix2990dOEcIuhNMSwYIrid/JfMpyCQ=;
  b=1AoBO21dCO8l56gkiwRnChCKHWA9KSRiNftEPWBMR8SDTxf16a+9F+U5
   OjZtfgew9NN3DeUFd6VIcmqqwXBcgQEfRJdCKQNFD6ybeu4ckP4z/YK6c
   yB/FOZGtaDELFa4QzDocurC0eC43h1F9hJI5HMon5aS0hWMglt1zBodib
   RTq7xLzta8WWNZSrdUZc6odtnj+AdN9/aXqzwhJGuStHie2YBc2aDgh+P
   QAbUs2Ue50KJH5vJzIBGmG1jAndI2J6UIYSggo47wgHatT1xoMB08UB+r
   0TUF6CpSrvQflUqhgJ8rOKkCdHhg2KIxqnY5O7ATSpZdCsLt07VKuuTn4
   g==;
IronPort-SDR: qwzuOjahS8GgxhuZ5X27OJgHl62VhZYix9dl5sy3xfO1PnsMGKU8WJ/ep48bA416J8PPqlNgLl
 g7O67i2FTwiHMWDzBDoCiIsgTfvVbdlJRnNL25WOiSDmNGXOCluQKMeFGUNXbH3KdrmexMXItr
 V000vdzwT9AQVrUkf3a0omgrpBnSqwSH5C3LM8KTkWicamIhN83lZveGDlrSYRkzjL1TuXRm05
 Q57ONJ3xi29kHBP5ZQyaMleUkrCA55Xyqx2yjuOCbQ+g3JRR1cEmKDc/xklOMr0WdZ4K3etTtM
 KwmJablWkHj53DVNCOXCW/fq
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; 
   d="scan'208";a="145412348"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Sep 2021 21:15:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 23 Sep 2021 21:15:53 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 23 Sep 2021 21:15:52 -0700
From:   <kelvin.cao@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kelvin.cao@microchip.com>, <kelvincao@outlook.com>
Subject: [PATCH 4/5] PCI/switchtec: Replace ENOTSUPP with EOPNOTSUPP
Date:   Fri, 24 Sep 2021 11:08:41 +0000
Message-ID: <20210924110842.6323-5-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924110842.6323-1-kelvin.cao@microchip.com>
References: <20210924110842.6323-1-kelvin.cao@microchip.com>
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

Link: https://lore.kernel.org/netdev/20200511165319.2251678-1-kuba@kernel.org/

Replace ENOTSUPP with EOPNOTSUPP to align with future patches which will
be using EOPNOTSUPP.

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
---
 drivers/pci/switch/switchtec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index b76094e2c885..20cec2367084 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -368,7 +368,7 @@ static ssize_t field ## _show(struct device *dev, \
 		return io_string_show(buf, &si->gen4.field, \
 				      sizeof(si->gen4.field)); \
 	else \
-		return -ENOTSUPP; \
+		return -EOPNOTSUPP; \
 } \
 \
 static DEVICE_ATTR_RO(field)
@@ -660,7 +660,7 @@ static int ioctl_flash_info(struct switchtec_dev *stdev,
 		info.flash_length = ioread32(&fi->gen4.flash_length);
 		info.num_partitions = SWITCHTEC_NUM_PARTITIONS_GEN4;
 	} else {
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	if (copy_to_user(uinfo, &info, sizeof(info)))
@@ -868,7 +868,7 @@ static int ioctl_flash_part_info(struct switchtec_dev *stdev,
 		if (ret)
 			return ret;
 	} else {
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	if (copy_to_user(uinfo, &info, sizeof(info)))
@@ -1603,7 +1603,7 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
 	else if (stdev->gen == SWITCHTEC_GEN4)
 		part_id = &stdev->mmio_sys_info->gen4.partition_id;
 	else
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	stdev->partition = ioread8(part_id);
 	stdev->partition_count = ioread8(&stdev->mmio_ntb->partition_count);
-- 
2.25.1

