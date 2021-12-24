Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD7847EA33
	for <lists+linux-pci@lfdr.de>; Fri, 24 Dec 2021 02:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245155AbhLXBZM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Dec 2021 20:25:12 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:25932 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350639AbhLXBZJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Dec 2021 20:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640309108; x=1671845108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YIzE0HtGM6R96JVAkcrysKpawVgajkkhJymCUIKulUI=;
  b=udiZObvgL1RoQGzQYgNB+AYy9HbtvzmBtXAOn5RaEJ6e8G9Ck4BIk9FK
   6Zk4TeAwmmH4S8jiB+1Sx2G4odq4KeOQLjNOKOPUn7xw322O90ATtw9rw
   K0hvjvz8mxTG9Kil7uG+BwGUEFPmtXVYUyQTQJ/9FLmDrABETd9h2nQ/n
   ofdgZfA0MrXLnqJNKKZ3VZGVuvWfKomebsrfkKIb+KkTE46xq0VXG2SrK
   7/zVrxQRR8eDIYrQxV0thVGrXOp/JZPM8CITYt4GQslMp7zBvV+C9Aghp
   s2wwG0k+CByLzm+HTlHq4quJVvshJZJsCenbkAUSS2BJybC6JI89uc8xT
   w==;
IronPort-SDR: /qOZHSO6+L+Ze6LNxU3rUbzPVR+YCm43gAOUhb4+Ua65RzkMCdcHFRAXzbVSV99+pnGtTEDy4U
 pdw0KJkXTGBy+4f2S3VCTUrLuroT/MQMaiK3XZbUGiC1/NJzzUlyGUImz4CxddCzBWycGSQQDY
 KhHa78G2YasjcjKpAEXF0yL4UPtmPkm2XFmACc4XaBJ9MrPA7K11e5Hjm0eBeU7U9DBMiAXjH8
 sdnJXqP3i/Gt0ggc3QZkpEgTwNDr2BLSv3BQMFdWzXI644YjATLXDch9vYghIvOdt97EoaKw8S
 aBborne7IlXrYupAC7cTDMRa
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="80533988"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Dec 2021 18:25:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 23 Dec 2021 18:25:07 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 23 Dec 2021 18:25:06 -0700
From:   Kelvin Cao <kelvin.cao@microchip.com>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-ntb@googlegroups.com>, <linux-kernel@vger.kernel.org>
CC:     Kelvin Cao <kelvin.cao@microchip.com>, <kelvincao@outlook.com>,
        "Jeremy Pallotta" <jmpallotta@gmail.com>
Subject: [PATCH 5/6] ntb_hw_switchtec: Remove code for disabling ID protection
Date:   Thu, 23 Dec 2021 17:23:33 -0800
Message-ID: <20211224012334.89173-6-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211224012334.89173-1-kelvin.cao@microchip.com>
References: <20211224012334.89173-1-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ID protection is a firmware setting for NT window access control. With
it enabled, only the posted requests with requester IDs in the requester
ID table will be allowed to access the NT windows. Otherwise all posted
requests are allowed. Normally user will configure it statically via the
Switchtec config file, and it will take effect when the firmware boots
up. The driver can also toggle the ID protection setting dynamically,
which will overwrite the static setting in the Switchtec config file as
a side effect.

Currently, the driver disables the ID protection. However, it's not
necessary to disable the ID protection at the driver level as the driver
has already configured the proper requester IDs in the requester ID
table to allow the corresponding posted requests to hit the NT windows.
Remove the code that disables the ID protection to make the static
setting prevail.

Note: ID protection is not applicable to non-posted requests.

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 3 ---
 include/linux/switchtec.h              | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 03839346233d..0e33eef64ec6 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -967,9 +967,6 @@ static int config_req_id_table(struct switchtec_ntb *sndev,
 	if (rc)
 		return rc;
 
-	iowrite32(NTB_PART_CTRL_ID_PROT_DIS,
-		  &mmio_ctrl->partition_ctrl);
-
 	for (i = 0; i < count; i++) {
 		iowrite32(req_ids[i] << 16 | NTB_CTRL_REQ_ID_EN,
 			  &mmio_ctrl->req_id_table[i]);
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index be24056ac00f..48fabe36509e 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -337,8 +337,6 @@ enum {
 	NTB_CTRL_REQ_ID_EN = 1 << 0,
 
 	NTB_CTRL_LUT_EN = 1 << 0,
-
-	NTB_PART_CTRL_ID_PROT_DIS = 1 << 0,
 };
 
 struct ntb_ctrl_regs {
-- 
2.25.1

