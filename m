Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5D847EA24
	for <lists+linux-pci@lfdr.de>; Fri, 24 Dec 2021 02:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245373AbhLXBZF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Dec 2021 20:25:05 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:25905 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244989AbhLXBZF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Dec 2021 20:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640309105; x=1671845105;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UFIZga4oh8vcATkIn3X5ozLYc1LQ3aq9KFSoPVhRJ3Y=;
  b=I7+gTk2UsvGUGONCuqpSUzTFIrk8g/Y5433dmlW/DAv/Xl4QXtOOBzPC
   mZUZarO2U4iExTrvst5uVwtqK6vC2Kun64/D7Q/oa5o0g/z011jsYPUfm
   82bL14841KVmlRQ7hOyMQ2iCCWVyuADKE9LxfgqKw8l17re2Lj4TCjKX0
   g/WOTrdrRw8LBPbq+9FIyAr4l9flRNCNs8BsaDHmC4Jg4dz8zgY7WVw4x
   kCoS0xDFI7MAyrHtve1V3RyVzvB/bfS0+ocH5x9VCA+iTQAD6mUR/I8GJ
   71o+Yauuj+CHr7cqndiW41UIT9m8RYkW14jA27ykCHl8XdxiwCCoXC+ua
   A==;
IronPort-SDR: mm53mf2+zM4KOPbvhHY2bQQhXRQ81TQG9hueu5oC2BINL7CkmXVXzmLI9wRzaJcxOElzl9QR8G
 VNmf1b4ABCpm1YeVY/Z6sqqi+8H0p4ieTvaYVkO+URBMwmPCtd7ECs2LpQz/2VbuJCDI905LIL
 yOD6RFkkEChJB98gC3wwrDor/FNQN5YlVHJAPPVrn/yaZaHB0jaiGwYDCoCKpRpwBLSKcZ1ZBY
 8krfWycGsxPsIOkvGCPOi3MmFHWq75RxIfW3eMebX6JdujJ08JNYjhqUOiut+YChDN9tDn9nXa
 BWnR62u1sV3OqJe/Aq1r6jfK
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="80533966"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Dec 2021 18:25:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 23 Dec 2021 18:25:04 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 23 Dec 2021 18:25:04 -0700
From:   Kelvin Cao <kelvin.cao@microchip.com>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-ntb@googlegroups.com>, <linux-kernel@vger.kernel.org>
CC:     Kelvin Cao <kelvin.cao@microchip.com>, <kelvincao@outlook.com>,
        "Jeremy Pallotta" <jmpallotta@gmail.com>
Subject: [PATCH 0/6] Switchtec NTB Fixes and Improvements
Date:   Thu, 23 Dec 2021 17:23:28 -0800
Message-ID: <20211224012334.89173-1-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Please find a bunch of patches for the Switchtec NTB driver.

Patche 1, 2 and 6 fix three minor bugs. Patch 3 works around a minor
firmware issue. Patch 4 updates the method of getting management VEP
instance ID based on a new firmware change. Patch 5 removes code that
disables ID protection to avoid conflict with static Switchtec config
settings.

This patchset is based on 5.16.0-rc5.

Thanks,
Kelvin

Jeremy Pallotta (2):
  ntb_hw_switchtec: Fix pff ioread to read into mmio_part_cfg_all
  ntb_hw_switchtec: AND with the part_map for a valid tpart_vec

Kelvin Cao (3):
  ntb_hw_switchtec: Update the way of getting VEP instance ID
  ntb_hw_switchtec: Remove code for disabling ID protection
  ntb_hw_switchtec: Fix a minor issue in config_req_id_table()

Wesley Sheng (1):
  ntb_hw_switchtec: Fix bug with more than 32 partitions

 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 24 +++++++++++-------------
 include/linux/switchtec.h              |  2 --
 2 files changed, 11 insertions(+), 15 deletions(-)

-- 
2.25.1

